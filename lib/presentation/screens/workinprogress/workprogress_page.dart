import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/bloc/stock/stocks_bloc.dart';

import 'package:construction/main.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/presentation/includes/custom_number_field.dart';
import 'package:construction/utils/routes.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:intl/intl.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/workinprogress/workinprogress_bloc.dart';
import '../../../utils/app_colors.dart';

class WorkInProgressPage extends StatefulWidget {
  const WorkInProgressPage({super.key});

  @override
  State<WorkInProgressPage> createState() => _WorkInProgressPageState();
}

class _WorkInProgressPageState extends State<WorkInProgressPage> {
  final TextEditingController stocks = TextEditingController();
  final TextEditingController _progress = TextEditingController();
  String dropdownvalue = "";
  final _formKey = GlobalKey<FormState>();
  DateTime? startDate;

  DateTime? endDate;
  double average = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final padding = MediaQuery.of(context).padding;

    showProgressModal(String wid, sid) async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: size.height / 90 * 18.3,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Update Work Progress",
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    CustomNumberField(
                      hintText: "Progress in Percent ( 1 - 100 )",
                      controller: _progress,
                      color: AppColors.customWhite,
                      size: size.height / 90 * 5.876,
                    ).customNumberField(),
                    BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                      listener: (context, state) {
                        if (state is UpdatingWorkProgressState) {
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
                        if (state is CompleteUpdatingWorkProgressState) {
                          BotToast.closeAllLoading();
                          Navigator.of(context).pop();
                          BotToast.showText(
                            text: "Progress Updated",
                            contentColor: AppColors.green,
                          );
                        }
                        if (state is FailedUpdatingWorkProgressState) {
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
                            if (_progress.text.isNotEmpty) {
                              BlocProvider.of<WorkinprogressBloc>(context)
                                  .updateWorkProgress(
                                double.parse(_progress.text),
                                wid,
                                sid,
                              );
                            } else {
                              BotToast.showText(
                                  text: "Empty value Provided",
                                  contentColor: AppColors.red);
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

    showDeleteDialog({
      String? sid,
      String? wid,
      double? height,
      double? width,
    }) async {
      return showDialog(
          context: context,
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                width: width,
                height: height,
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
                        BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                          listener: (context, state) {
                            if (state is DeletingWorkInfoState) {
                              BotToast.showCustomLoading(
                                toastBuilder: (cancelFunc) =>
                                    customLoading(size),
                              );
                            }
                            if (state is FailedDeletingWorkProgressState) {
                              BotToast.closeAllLoading();
                              BotToast.showText(
                                text: state.error!,
                                contentColor: AppColors.red,
                              );
                              Navigator.of(context).pop();
                            }
                            if (state is CompleteDeletingWorkInfoState) {
                              BotToast.closeAllLoading();
                              BotToast.showText(
                                text: "Work Deleted",
                                contentColor: AppColors.red,
                              );
                              Navigator.of(context).pop();
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
                                BlocProvider.of<WorkinprogressBloc>(context)
                                    .deleteWork(sid!, wid!);
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

    return GestureDetector(
      onTap: () {
        FocusScopeNode cf = FocusScope.of(context);
        if (!cf.hasPrimaryFocus) {
          cf.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height / 90 * 8.5),
          child: CustomAppbar(
            action: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(scheduleWOrk, arguments: {"sid": args['sid']});
                },
                icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.yellow,
                  child: Icon(
                    Icons.add,
                    color: AppColors.blue,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset("assets/icons/camera.png"),
              ),
            ],
            title: "Work in Progress",
            bgcolor: AppColors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ).customAppBar(),
        ),
        body: BlocConsumer<DropdownBloc, DropdownState>(
          listener: (context, state) {},
          builder: (context, state) {
            return stocksused(args, size, padding, context, showProgressModal,
                showDeleteDialog);
          },
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> stocksused(
    Map<String, dynamic> args,
    Size size,
    EdgeInsets padding,
    BuildContext context,
    Future<dynamic> Function(String wid, dynamic sid) showProgressModal,
    Future<dynamic> Function({
      String? sid,
      String? wid,
      double? height,
      double? width,
    })
        showDeleteDialog,
  ) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("sites")
            .doc(args['sid'])
            .collection("stocks")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 90 * 1.2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: padding.top * 0.8, vertical: 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.data!.docs.isEmpty
                            ? const Text("There are no stocks for this sites")
                            : Container(
                                height: size.height / 90 * 5.26,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: AppColors.customWhite,
                                    )
                                  ],
                                  color: AppColors.white,
                                ),
                                child: DropdownButtonFormField2(
                                  scrollbarAlwaysShow: true,
                                  buttonPadding: EdgeInsets.only(
                                      right: padding.top * 0.5,
                                      top: padding.top * 0),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  hint: const Text("Select Item"),
                                  offset: Offset(0, -size.height / 90 * 2.44),
                                  items: snapshot.data!.docs.map((item) {
                                    return DropdownMenuItem(
                                        value: item['skid'],
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width / 90 * 20,
                                              child: Text(
                                                item['itemname'],
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width / 90 * 20,
                                              child: Text(
                                                "${item['unit']}",
                                                style: TextStyle(
                                                  color: AppColors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 8,
                                              backgroundColor:
                                                  item['quantity'] == 0
                                                      ? AppColors.red
                                                      : item['quantity'] > 10
                                                          ? AppColors.green
                                                          : AppColors.orange,
                                            )
                                          ],
                                        ));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    BlocProvider.of<DropdownBloc>(context)
                                        .onItemSelectDropdown(
                                            newValue.toString());
                                    dropdownvalue = newValue.toString();
                                  },
                                ),
                              ),
                        SizedBox(
                          height: size.height / 90 * 1.2,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBox(
                                      height: size.height / 90 * 5.26,
                                      width: size.width / 7 * 3.8,
                                      radius: 15,
                                      blurRadius: 4.0,
                                      shadowColor: AppColors.customWhite,
                                      color: AppColors.white,
                                      horizontalMargin: 0,
                                      verticalMargin: 0,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: stocks,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Stock Used",
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: padding.top * 0.4),
                                        ),
                                      )).customBox(),
                                  BlocConsumer<StocksBloc, StocksState>(
                                    listener: (context, state) {
                                      if (state is UpdatingStockQuantityState) {
                                        BotToast.showCustomLoading(
                                          toastBuilder: (cancelFunc) {
                                            return customLoading(size);
                                          },
                                        );
                                      }
                                      if (state
                                          is CompleteUpdatingStockQuantityState) {
                                        BotToast.closeAllLoading();
                                        BotToast.showText(
                                          text: "Stock Updated",
                                          contentColor: AppColors.green,
                                        );
                                      }
                                      if (state
                                          is FailedUpdatingStockQuantityState) {
                                        BotToast.closeAllLoading();
                                        BotToast.showText(
                                          text: state.error!,
                                          contentColor: AppColors.red,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return SizedBox(
                                        width: size.width / 7 * 1.3,
                                        child: IconButton(
                                            color: AppColors.yellow,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.yellow),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (dropdownvalue.isEmpty) {
                                                  BotToast.showText(
                                                    text:
                                                        "Please select a Stock",
                                                    contentColor: AppColors.red,
                                                  );
                                                } else {
                                                  String sid = "";

                                                  for (int i = 0;
                                                      i <
                                                          snapshot.data!.docs
                                                              .length;
                                                      i++) {
                                                    sid = snapshot.data!.docs[i]
                                                        ['sid'];
                                                  }
                                                  if (stocks.text.isEmpty) {
                                                    BotToast.showText(
                                                      text:
                                                          "Stock used value is Empty",
                                                      contentColor:
                                                          AppColors.red,
                                                    );
                                                  } else {
                                                    BlocProvider.of<StocksBloc>(
                                                            context)
                                                        .updateStockQuantity(
                                                      sid,
                                                      double.parse(stocks.text),
                                                      dropdownvalue,
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                            icon: const Text("Update")),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.2,
                        ),
                        Text(
                          "Progress",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.2,
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("sites")
                              .doc(args['sid'])
                              .collection("works")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Builder(
                                  builder: (context) => customLoading(size),
                                ),
                              );
                            } else {
                              if (snapshot.data!.docs.isEmpty) {
                                return Container(
                                  height: size.height / 90 * 1.8,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.customWhite,
                                          blurRadius: 4.0),
                                    ],
                                  ),
                                  child: FAProgressBar(
                                    formatValueFixed: 2,
                                    animatedDuration:
                                        const Duration(seconds: 2),
                                    borderRadius: BorderRadius.circular(15),
                                    backgroundColor: AppColors.white,
                                    progressColor: AppColors.green,
                                    direction: Axis.horizontal,
                                    displayText: "%",
                                    displayTextStyle: TextStyle(
                                      color: AppColors.white,
                                    ),
                                    maxValue: 100,
                                    currentValue: 0,
                                  ),
                                );
                              } else {
                                average = snapshot.data!.docs
                                        .map((e) => e['progress'])
                                        .reduce((value, element) =>
                                            value + element) /
                                    snapshot.data!.docs.length;
                                return Container(
                                  height: size.height / 90 * 1.8,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.customWhite,
                                          blurRadius: 4.0),
                                    ],
                                  ),
                                  child: FAProgressBar(
                                    formatValueFixed: 2,
                                    animatedDuration:
                                        const Duration(seconds: 2),
                                    borderRadius: BorderRadius.circular(15),
                                    backgroundColor: AppColors.white,
                                    progressColor: AppColors.green,
                                    direction: Axis.horizontal,
                                    displayText: "%",
                                    displayTextStyle: TextStyle(
                                      color: AppColors.white,
                                    ),
                                    maxValue: 100,
                                    currentValue: average,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.5,
                        ),
                        Text(
                          "Site Works",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.5,
                        ),
                        worklist(args, size, context, showProgressModal,
                            showDeleteDialog, padding),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Builder(
                builder: (context) => customLoading(size),
              ),
            );
          }
        });
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> worklist(
      Map<String, dynamic> args,
      Size size,
      BuildContext context,
      Future<dynamic> Function(String wid, dynamic sid) showProgressModal,
      Future<dynamic> Function({
    String? sid,
    String? wid,
    double? height,
    double? width,
  })
          showDeleteDialog,
      EdgeInsets padding) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("sites")
          .doc(args['sid'])
          .collection("works")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = [];
          return Column(
            children: [
              SizedBox(
                height: size.height / 90 * 42.78,
                width: size.width,
                child: Scrollbar(
                  thickness: 4,
                  radius: const Radius.circular(12),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showProgressModal(
                                snapshot.data!.docs[index]['wid'],
                                snapshot.data!.docs[index]['sid'],
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width / 3,
                                  child: Text(
                                    "${snapshot.data!.docs[index]['title']}",
                                    style: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 8,
                                  child: Text(
                                    "${snapshot.data!.docs[index]['progress']} %",
                                    style: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height / 90 * 1.5,
                                  width: size.width / 8,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: padding.top * 0.2,
                                    vertical: padding.top * 0.2,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.customWhite,
                                          blurRadius: 2.0,
                                        )
                                      ]),
                                  child: FAProgressBar(
                                    formatValueFixed: 2,
                                    animatedDuration:
                                        const Duration(seconds: 2),
                                    borderRadius: BorderRadius.circular(15),
                                    backgroundColor: AppColors.white,
                                    progressColor: AppColors.orange,
                                    direction: Axis.horizontal,
                                    maxValue: 100,
                                    currentValue: double.parse(snapshot
                                        .data!.docs[index]['progress']
                                        .toString()),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(editwork, arguments: {
                                      "sid": snapshot.data!.docs[index]['sid'],
                                      "wid": snapshot.data!.docs[index]['wid'],
                                      "title": snapshot.data!.docs[index]
                                          ['title'],
                                      "startdate": snapshot
                                          .data!.docs[index]['startdate']
                                          .toDate(),
                                      "endDate": snapshot
                                          .data!.docs[index]['endDate']
                                          .toDate(),
                                      "workdesc": snapshot.data!.docs[index]
                                          ['workdesc']
                                    });
                                  },
                                  icon: Iconify(
                                    FluentMdl2.edit,
                                    color: AppColors.grey,
                                    size: size.height / 90 * 2.2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDeleteDialog(
                                        height: size.height / 90 * 23,
                                        width: size.width / 8 * 14,
                                        wid: snapshot.data!.docs[index]['wid'],
                                        sid: snapshot.data!.docs[index]['sid']);
                                  },
                                  icon: Iconify(
                                    Zondicons.trash,
                                    size: size.height / 90 * 2.3,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1.3,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 90 * 1.5,
              ),
              snapshot.data!.docs.isEmpty
                  ? const Center(child: Text("Work Progress appears here"))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.blue,
                        fixedSize: Size(size.width, size.height / 90 * 4.2),
                      ),
                      onPressed: () {
                        data.clear();
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          data.add({
                            "sn": "${i + 1}",
                            "sitename": args['sitename'],
                            "title": snapshot.data!.docs[i]['title'],
                            "startdate": DateFormat.yMMMMd().format(
                                snapshot.data!.docs[i]['startdate'].toDate()),
                            "endDate": DateFormat.yMMMMd().format(
                                snapshot.data!.docs[i]['endDate'].toDate()),
                            "progress": snapshot.data!.docs[i]['progress']
                          });
                        }
                        if (data.isNotEmpty) {
                          Navigator.of(context).pushNamed(
                              workInvoiceSignaturePadPage,
                              arguments: {
                                "data": data,
                                "name": "WorkReport - ${data[0]['sitename']}",
                                "count": 5,
                              });
                        }
                      },
                      child: const Text("Generate Report"),
                    )
            ],
          );
        } else {
          return const Center(
            child: Text("Your Site Works Appears Here"),
          );
        }
      },
    );
  }
}
