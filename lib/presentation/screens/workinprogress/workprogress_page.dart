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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final padding = MediaQuery.of(context).padding;

    showProgressModal(String wid, sid) {
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
                          color: AppColors.fadeblue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    CustomNumberField(
                      hintText: "Progress in Percent ( 1 - 100 )",
                      controller: _progress,
                      color: AppColors.grey.withOpacity(0.1),
                      size: size.height / 90 * 5.876,
                    ).customNumberField(),
                    BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                      listener: (context, state) {
                        if (state is UpdatingWorkProgressState) {
                          BotToast.showCustomLoading(
                            toastBuilder: (cancelFunc) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.fadeblue,
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
                            foregroundColor: AppColors.fadeblue,
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
                    color: AppColors.fadeblue,
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
                                    ? const Text(
                                        "There are no stocks for this sites")
                                    : Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: AppColors.grey
                                                  .withOpacity(0.2),
                                            )
                                          ],
                                          color: AppColors.white,
                                        ),
                                        child: DropdownButtonFormField2(
                                          buttonPadding: EdgeInsets.only(
                                              right: padding.top * 0.4),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppColors.white,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          hint: const Text("Select Item"),
                                          offset: Offset(
                                              0, -size.height / 90 * 2.44),
                                          items:
                                              snapshot.data!.docs.map((item) {
                                            return DropdownMenuItem(
                                              value: item['skid'],
                                              child: Text(
                                                item['itemname'],
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            BlocProvider.of<DropdownBloc>(
                                                    context)
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
                                            height: size.height / 90 * 5.86,
                                            width: size.width / 7 * 3.8,
                                            radius: 15,
                                            blurRadius: 4.0,
                                            shadowColor:
                                                AppColors.grey.withOpacity(0.2),
                                            color: AppColors.white,
                                            horizontalMargin: 0,
                                            verticalMargin: 0,
                                            child: CustomNumberField(
                                              controller: stocks,
                                              hintText: "Stock Used",
                                              size: size.height / 90 * 5.86,
                                            ).customNumberField(),
                                          ).customBox(),
                                          BlocConsumer<StocksBloc, StocksState>(
                                            listener: (context, state) {
                                              if (state
                                                  is UpdatingStockQuantityState) {
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
                                                          MaterialStateProperty
                                                              .all(AppColors
                                                                  .yellow),
                                                    ),
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        if (dropdownvalue
                                                            .isEmpty) {
                                                          BotToast.showText(
                                                            text:
                                                                "Please select a Stock",
                                                            contentColor:
                                                                AppColors.red,
                                                          );
                                                        } else {
                                                          String sid = "";

                                                          for (int i = 0;
                                                              i <
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length;
                                                              i++) {
                                                            sid = snapshot.data!
                                                                .docs[i]['sid'];
                                                          }
                                                          if (stocks
                                                              .text.isEmpty) {
                                                            BotToast.showText(
                                                              text:
                                                                  "Stock used value is Empty",
                                                              contentColor:
                                                                  AppColors.red,
                                                            );
                                                          } else {
                                                            BlocProvider.of<
                                                                        StocksBloc>(
                                                                    context)
                                                                .updateStockQuantity(
                                                              sid,
                                                              double.parse(
                                                                  stocks.text),
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
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.fadeblue,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 90 * 1.2,
                                ),
                                Container(
                                  height: size.height / 90 * 2.26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppColors.grey.withOpacity(0.2),
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
                                    currentValue: 90,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 90 * 1.5,
                                ),
                                Text(
                                  "Site Works",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.fadeblue,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 90 * 1.5,
                                ),
                                StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection("sites")
                                      .doc(args['sid'])
                                      .collection("works")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SizedBox(
                                        height: size.height / 90 * 48.78,
                                        width: size.width,
                                        child: Scrollbar(
                                          thickness: 4,
                                          radius: const Radius.circular(12),
                                          child: ListView.builder(
                                            padding: const EdgeInsets.only(
                                              top: 0,
                                            ),
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      showProgressModal(
                                                        snapshot.data!
                                                            .docs[index]['wid'],
                                                        snapshot.data!
                                                            .docs[index]['sid'],
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: size.width / 3,
                                                          child: Text(
                                                            "${snapshot.data!.docs[index]['title']}",
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              color: AppColors
                                                                  .grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat.MMMd()
                                                              .format(snapshot
                                                                  .data!
                                                                  .docs[index][
                                                                      'endDate']
                                                                  .toDate()),
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: size.height /
                                                              90 *
                                                              2.6,
                                                          width: size.width / 8,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                padding.top *
                                                                    0.2,
                                                            vertical:
                                                                padding.top *
                                                                    0.2,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: AppColors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  blurRadius:
                                                                      2.0,
                                                                )
                                                              ]),
                                                          child: FAProgressBar(
                                                            formatValueFixed: 2,
                                                            animatedDuration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            backgroundColor:
                                                                AppColors.white,
                                                            progressColor:
                                                                AppColors
                                                                    .orange,
                                                            direction:
                                                                Axis.horizontal,
                                                            maxValue: 100,
                                                            currentValue: double
                                                                .parse(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                        [
                                                                        'progress']
                                                                    .toString()),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${snapshot.data!.docs[index]['progress']} %",
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    editwork,
                                                                    arguments: {
                                                                  "sid": snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]['sid'],
                                                                  "wid": snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]['wid'],
                                                                  "title": snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      ['title'],
                                                                  "startdate": snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'startdate']
                                                                      .toDate(),
                                                                  "endDate": snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'endDate']
                                                                      .toDate(),
                                                                  "workdesc": snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'workdesc']
                                                                });
                                                          },
                                                          icon: Iconify(
                                                            FluentMdl2.edit,
                                                            color:
                                                                AppColors.grey,
                                                            size: size.height /
                                                                90 *
                                                                2.2,
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
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                            "Your Site Works Appears Here"),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
