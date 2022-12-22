import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/orders/orders_bloc.dart';
import '../../../data/models/order_model.dart';
import '../../../main.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../../includes/appbar.dart';
import '../../includes/custom_box.dart';
import '../../includes/custom_number_field.dart';
import '../../includes/custom_textfield.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _itemname = TextEditingController();
  final TextEditingController _brandname = TextEditingController();
  final TextEditingController _suppliername = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> selectStatus = ["Delivered", "On The Way", "Cancelled"];
  String orderstatus = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [];
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    showAddOrderModal() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Form(
              key: _formKey,
              child: SizedBox(
                height: size.height / 90 * 58.334,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 90 * 1.338,
                      ),
                      Text(
                        "Add Orders",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue),
                      ),
                      SizedBox(
                        height: size.height / 90 * 2.538,
                      ),
                      CustomTextField(
                        controller: _itemname,
                        hintText: "Item Name",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      CustomTextField(
                        controller: _brandname,
                        hintText: "Brand Name",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      CustomTextField(
                        controller: _suppliername,
                        hintText: "Supplier Name",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Item Quantity"),
                          SizedBox(
                            width: size.width / 5.6,
                            child: CustomNumberField(
                              hintText: "Qty",
                              controller: _quantity,
                              color: AppColors.customWhite,
                              size: size.height / 90 * 5.44,
                            ).customNumberField(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Item rate"),
                          SizedBox(
                            width: size.width / 5.6,
                            child: CustomNumberField(
                              hintText: "Rate",
                              color: AppColors.customWhite,
                              controller: _rate,
                              size: size.height / 90 * 5.44,
                            ).customNumberField(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 90 * 2.334,
                      ),
                      CustomTextField(
                        controller: _unit,
                        hintText: "Unit",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.838,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: Size(size.width / 90 * 8.66,
                                  size.height / 90 * 5.86),
                              foregroundColor: AppColors.blue,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          BlocConsumer<OrdersBloc, OrdersState>(
                            listener: (context, state) {
                              if (state is AddingSiteOrderState) {
                                BotToast.showCustomLoading(
                                  toastBuilder: (cancelFunc) {
                                    return customLoading(size);
                                  },
                                );
                              }
                              if (state is CompletedAddingSiteOrderState) {
                                BotToast.closeAllLoading();
                                BotToast.showText(
                                    text: "New Order Added",
                                    contentColor: AppColors.green);
                              }
                              if (state is FailedSiteOrderState) {
                                BotToast.closeAllLoading();
                                BotToast.showText(
                                  text: state.error!,
                                  contentColor: AppColors.red,
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(size.width / 90 * 25.66,
                                      size.height / 90 * 3.86),
                                  backgroundColor: AppColors.yellow,
                                  foregroundColor: AppColors.blue,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    OrderModel orderModel = OrderModel(
                                      itemname: _itemname.text,
                                      brandname: _brandname.text,
                                      suppliername: _suppliername.text,
                                      quantity: double.parse(_quantity.text),
                                      rate: double.parse(_rate.text),
                                      status: orderstatus,
                                      unit: _unit.text,
                                    );
                                    BlocProvider.of<OrdersBloc>(context)
                                        .addOrder(orderModel, args['sid']);
                                  }
                                },
                                child: const Text("Save"),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    showDeleteDialog(String oid, String sid) {
      return showDialog(
          context: context,
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                width: size.width,
                height: size.height / 90 * 23,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: size.width / 8.2,
                      backgroundColor: AppColors.red,
                      child: Iconify(
                        FluentMdl2.delete,
                        size: size.height / 90 * 6.76,
                        color: AppColors.white,
                      ),
                    ),
                    const Text(
                      "Are you sure you want to Delete ?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(103, 33),
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.blue,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        BlocConsumer<OrdersBloc, OrdersState>(
                          listener: (context, state) {
                            if (state is DeletingOrderState) {
                              BotToast.showCustomLoading(
                                toastBuilder: (context) => customLoading(size),
                              );
                            }
                            if (state is CompleteDeletingOrderState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: "Order Deleted",
                                contentColor: AppColors.green,
                              );
                            }
                            if (state is FailedDeletingOrderState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: state.error!,
                                contentColor: AppColors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: const Size(103, 33),
                                backgroundColor: AppColors.red,
                                foregroundColor: AppColors.white,
                              ),
                              onPressed: () {
                                BlocProvider.of<OrdersBloc>(context)
                                    .deleteSiteOrder(sid, oid);
                              },
                              child: const Text("Delete"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    showEditSiteOrderModal({
      required String sid,
      required String oid,
      required String itemname,
      required String suppliername,
      required String itembrand,
      required double quantity,
      required String status,
      required String unit,
      required double rate,
    }) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            width: size.width,
            height: size.height / 90 * 62.334,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 90 * 1.338,
                    ),
                    Text(
                      "Update Site Orders Info",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue),
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: itemname,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Item Name",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          itemname = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cant Send Empty value";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: suppliername,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Supplier Name",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          suppliername = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cant Send Empty value";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: itembrand,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Item Brand",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          itembrand = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cant Send Empty value";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue,
                          ),
                        ),
                        Container(
                          height: size.height / 90 * 5.44,
                          width: size.width / 8 * 1.5,
                          decoration: BoxDecoration(
                            color: AppColors.customWhite.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: quantity.toString(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: padding.top * 0.4,
                              ),
                              hintText: "Quantity",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              quantity = double.parse(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cant Send Empty value";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    BlocConsumer<DropdownBloc, DropdownState>(
                      listener: (context, state) {
                        if (state is DropdownUserSelectState) {
                          orderstatus = state.value!;
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.customWhite,
                          ),
                          child: DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            buttonPadding: EdgeInsets.symmetric(
                                horizontal: padding.top * 0.2),
                            hint: const Text("Select Status"),
                            offset: Offset(-4, -size.height / 90 * 2.44),
                            items: selectStatus.map((st) {
                              return DropdownMenuItem(
                                value: st,
                                child: Text(st),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              BlocProvider.of<DropdownBloc>(context)
                                  .onUserSelectDropdown(newValue.toString());
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.538,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rate (Rs.)",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue,
                          ),
                        ),
                        Container(
                          height: size.height / 90 * 5.44,
                          width: size.width / 8 * 1.5,
                          decoration: BoxDecoration(
                            color: AppColors.customWhite.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: rate.toString(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: padding.top * 0.4,
                              ),
                              hintText: "Rate",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              rate = double.parse(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cant Send Empty value";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 90 * 2.538,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: unit,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Unit",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          unit = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cant Send Empty value";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 90 * 3.538,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(103, 33),
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.blue,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        BlocConsumer<OrdersBloc, OrdersState>(
                          listener: (context, state) {
                            if (state is UpdatingSiteOrderState) {
                              BotToast.showCustomLoading(
                                toastBuilder: (context) => customLoading(size),
                              );
                            }
                            if (state is CompleteUpdatingSiteOrderState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: "Order Information Updated",
                                contentColor: AppColors.green,
                              );
                            }
                            if (state is FailedUpdatingSiteOrderState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: state.error!,
                                contentColor: AppColors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: const Size(103, 33),
                                backgroundColor: AppColors.yellow,
                                foregroundColor: AppColors.blue,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<OrdersBloc>(context)
                                      .updateSiteOrder(
                                    sid,
                                    oid,
                                    itemname,
                                    suppliername,
                                    itembrand,
                                    quantity,
                                    orderstatus,
                                    rate,
                                    unit,
                                  );
                                }
                              },
                              child: const Text("Update"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    showAddQuantityModal(String oid, String sid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: size.height / 90 * 18.3,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Add Order Quantity",
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _qty,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Quantity",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cant Send Empty value";
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocConsumer<OrdersBloc, OrdersState>(
                      listener: (context, state) {
                        if (state is UpdatingQuantityState) {
                          BotToast.showCustomLoading(
                            toastBuilder: (cancelFunc) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blue,
                                ),
                              );
                            },
                          );
                        }
                        if (state is CompleteUpdatingQuantityState) {
                          BotToast.closeAllLoading();
                          Navigator.of(context).pop();
                          BotToast.showText(
                            text: "Progress Updated",
                            contentColor: AppColors.green,
                          );
                        }
                        if (state is FailedUpdatingQuantityState) {
                          BotToast.closeAllLoading();
                          Navigator.of(context).pop();
                          BotToast.showText(
                            text: state.error!,
                            contentColor: AppColors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            foregroundColor: AppColors.blue,
                            backgroundColor: AppColors.yellow,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<OrdersBloc>(context)
                                  .addOrderQuantity(
                                      sid, oid, double.parse(_qty.text));
                            }
                          },
                          child: const Iconify(FluentMdl2.update_restore),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          bgcolor: AppColors.white,
          title: args['sitename'],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          action: [
            IconButton(
              onPressed: () {
                showAddOrderModal();
              },
              icon: CircleAvatar(
                backgroundColor: AppColors.yellow,
                radius: 18,
                child: Icon(
                  Icons.add,
                  color: AppColors.blue,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: padding.top * 0.2),
              child: IconButton(
                onPressed: () {
                  double total = 0;
                  for (int i = 0; i < data.length; i++) {
                    total += data[i]['amount'];
                  }

                  if (data.isEmpty) {
                    BotToast.showText(
                        text: "No Orders at the moment",
                        contentColor: AppColors.red);
                  } else {
                    Navigator.of(context).pushNamed(
                      orderInvoiceSignaturePadPage,
                      arguments: {
                        "count": 9,
                        "data": data,
                        "total": total,
                        "name": "Order Invoice ${data[0]['sitename']}"
                      },
                    );
                  }
                },
                icon: CircleAvatar(
                  backgroundColor: AppColors.yellow,
                  radius: 18,
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
          ],
        ).customAppBar(),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomBox(
              height: size.height / 90 * 4.8,
              width: size.width,
              radius: 16,
              blurRadius: 4.0,
              shadowColor: AppColors.grey.withOpacity(0.2),
              color: AppColors.white,
              horizontalMargin: padding.top * 0.4,
              verticalMargin: padding.top * 0.2,
              child: TextFormField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(padding.top * 0.3),
                    child: const Iconify(
                      FluentMdl2.search,
                    ),
                  ),
                ),
              ),
            ).customBox(),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("sites")
                  .doc(args['sid'])
                  .collection("orders")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? const Center(
                          child: Text("No Orders at the Moment"),
                        )
                      : SizedBox(
                          height: size.height / 90 * 68,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data!.docs.isNotEmpty) {
                                data.clear();
                                double amount = snapshot.data!.docs[index]
                                        ['rate'] *
                                    snapshot.data!.docs[index]['quantity'];

                                data.add({
                                  'sn': "${index + 1}",
                                  "sitename": args['sitename'],
                                  "itemname": snapshot.data!.docs[index]
                                      ['itemname'],
                                  "brandname": snapshot.data!.docs[index]
                                      ['brandname'],
                                  "suppliername": snapshot.data!.docs[index]
                                      ['suppliername'],
                                  "unit": snapshot.data!.docs[index]['unit'],
                                  "quantity": snapshot.data!.docs[index]
                                      ['quantity'],
                                  "status": snapshot.data!.docs[index]
                                      ['status'],
                                  "rate": snapshot.data!.docs[index]['rate'],
                                  "amount": amount,
                                });
                              }
                              return CustomBox(
                                height: size.height / 90 * 15.15,
                                width: size.width,
                                radius: 15,
                                blurRadius: 4.0,
                                shadowColor: AppColors.customWhite,
                                color: AppColors.white,
                                horizontalMargin: padding.top * 0.4,
                                verticalMargin: padding.top * 0.2,
                                child: InkWell(
                                  onTap: () {
                                    showAddQuantityModal(
                                      snapshot.data!.docs[index]['oid'],
                                      snapshot.data!.docs[index]['sid'],
                                    );
                                  },
                                  child: Container(
                                    height: size.height,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: padding.top * 0.4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ['itemname'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  showDeleteDialog(
                                                    snapshot.data!.docs[index]
                                                        ['oid'],
                                                    snapshot.data!.docs[index]
                                                        ['sid'],
                                                  );
                                                },
                                                icon: Iconify(
                                                  FluentMdl2.delete,
                                                  color: AppColors.red,
                                                  size: size.height / 90 * 2.3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width / 7 * 2.6,
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    ['brandname'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            CustomBox(
                                              height: size.height / 90 * 2.44,
                                              width: size.width / 3.16,
                                              radius: 15,
                                              blurRadius: 4.0,
                                              shadowColor:
                                                  AppColors.customWhite,
                                              color: snapshot.data!.docs[index]
                                                          ['status'] ==
                                                      "Cancelled"
                                                  ? AppColors.red
                                                  : snapshot.data!.docs[index]
                                                              ['status'] ==
                                                          "Delivered"
                                                      ? AppColors.green
                                                      : Colors.deepOrangeAccent,
                                              horizontalMargin: 0,
                                              verticalMargin: 0,
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['status'],
                                                  style: TextStyle(
                                                      color: AppColors.white),
                                                ),
                                              ),
                                            ).customBox(),
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  showEditSiteOrderModal(
                                                    sid: snapshot.data!
                                                        .docs[index]['sid'],
                                                    oid: snapshot.data!
                                                        .docs[index]['oid'],
                                                    itemname: snapshot
                                                            .data!.docs[index]
                                                        ['itemname'],
                                                    suppliername: snapshot
                                                            .data!.docs[index]
                                                        ['suppliername'],
                                                    itembrand: snapshot
                                                            .data!.docs[index]
                                                        ['brandname'],
                                                    quantity: snapshot
                                                            .data!.docs[index]
                                                        ['quantity'],
                                                    status: snapshot.data!
                                                        .docs[index]['status'],
                                                    unit: snapshot.data!
                                                        .docs[index]['unit'],
                                                    rate: snapshot.data!
                                                        .docs[index]['rate'],
                                                  );
                                                },
                                                icon: Iconify(
                                                  FluentMdl2.edit,
                                                  color: AppColors.grey,
                                                  size: size.height / 90 * 2.3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: size.width / 7 * 2.2,
                                              child: const Text(
                                                "Quantities : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: size.width / 8 * 1.8,
                                              child: Text(
                                                "${snapshot.data!.docs[index]['quantity']} ${snapshot.data!.docs[index]['unit']}",
                                                style: const TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Iconify(
                                                  FluentMdl2.archive,
                                                  color: AppColors.blue,
                                                  size: size.height / 90 * 2.3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height / 90 * 0.1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).customBox();
                            },
                          ),
                        );
                } else {
                  return Center(
                    child: Builder(
                      builder: (context) => customLoading(size),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
