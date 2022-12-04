import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/data/models/stocks.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../../bloc/stock/stocks_bloc.dart';
import '../../../main.dart';
import '../../includes/custom_number_field.dart';
import '../../includes/custom_textfield.dart';

class SiteStocks extends StatefulWidget {
  const SiteStocks({super.key});

  @override
  State<SiteStocks> createState() => _SiteStocksState();
}

class _SiteStocksState extends State<SiteStocks> {
  final TextEditingController _itemname = TextEditingController();
  final TextEditingController _brandname = TextEditingController();
  final TextEditingController _suppliername = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _unit = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    showAddStockModal() {
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
                          "Add Stocks",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.fadeblue),
                        ),
                        SizedBox(
                          height: size.height / 90 * 2.538,
                        ),
                        CustomTextField(
                          controller: _itemname,
                          hintText: "Item Name",
                          size: size.height / 90 * 5.44,
                          width: size.width,
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.538,
                        ),
                        CustomTextField(
                          controller: _brandname,
                          hintText: "Brand Name",
                          size: size.height / 90 * 5.44,
                          width: size.width,
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.538,
                        ),
                        CustomTextField(
                          controller: _suppliername,
                          hintText: "Supplier Name",
                          size: size.height / 90 * 5.44,
                          width: size.width,
                        ),
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
                                color: AppColors.grey.withOpacity(0.1),
                                size: size.height / 90 * 5.44,
                              ),
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
                                color: AppColors.grey.withOpacity(0.1),
                                controller: _rate,
                                size: size.height / 90 * 5.44,
                              ),
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
                        ),
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
                                foregroundColor: AppColors.fadeblue,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            BlocConsumer<StocksBloc, StocksState>(
                              listener: (context, state) {
                                if (state is AddingSiteStockState) {
                                  BotToast.showCustomLoading(
                                    toastBuilder: (cancelFunc) {
                                      return customLoading(size);
                                    },
                                  );
                                }
                                if (state is CompletedAddingSiteStockState) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(
                                      text: "New Stock Added",
                                      contentColor: AppColors.green);
                                }
                                if (state is FailedSiteStockState) {
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
                                    foregroundColor: AppColors.fadeblue,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      StockModel stockModel = StockModel(
                                        itemname: _itemname.text,
                                        brandname: _brandname.text,
                                        suppliername: _suppliername.text,
                                        quantity: double.parse(_quantity.text),
                                        rate: double.parse(_rate.text),
                                        unit: _unit.text,
                                      );
                                      BlocProvider.of<StocksBloc>(context)
                                          .addStock(stockModel, args['sid']);
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
                )),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 7.5),
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
                showAddStockModal();
              },
              icon: CircleAvatar(
                backgroundColor: AppColors.yellow,
                radius: 15,
                child: Icon(
                  Icons.add,
                  color: AppColors.fadeblue,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomBox(
              height: size.height / 90 * 4.8,
              width: size.width,
              radius: 15,
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
                    )),
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("sites")
                  .doc(args['sid'])
                  .collection("stocks")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? const Center(
                          child: Text("No Stocks at the Moment"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return CustomBox(
                              height: size.height / 90 * 14.15,
                              width: size.width,
                              radius: 15,
                              blurRadius: 4.0,
                              shadowColor: AppColors.grey.withOpacity(0.2),
                              color: AppColors.white,
                              horizontalMargin: padding.top * 0.4,
                              verticalMargin: padding.top * 0.2,
                              child: Container(
                                height: size.height,
                                padding: EdgeInsets.symmetric(
                                    horizontal: padding.top * 0.4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['itemname'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                          width: size.width / 3.86,
                                          radius: 15,
                                          blurRadius: 4.0,
                                          shadowColor: AppColors.customWhite,
                                          color: snapshot.data!.docs[index]
                                                      ['quantity'] ==
                                                  0
                                              ? AppColors.red
                                              : snapshot.data!.docs[index]
                                                          ['quantity'] >=
                                                      10
                                                  ? AppColors.green
                                                  : Colors.deepOrangeAccent,
                                          horizontalMargin: 0,
                                          verticalMargin: 0,
                                          child: Center(
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                          ['quantity'] ==
                                                      0
                                                  ? "Out of Stock"
                                                  : snapshot.data!.docs[index]
                                                              ['quantity'] >=
                                                          10
                                                      ? "In Stock"
                                                      : "Low Stock",
                                              style: TextStyle(
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.more_vert,
                                          ),
                                        )
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
                                        Text(
                                          "${snapshot.data!.docs[index]['quantity']} ${snapshot.data!.docs[index]['unit']}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 90 * 0.1,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
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
