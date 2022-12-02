import 'package:bot_toast/bot_toast.dart';
import 'package:construction/data/models/works.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/workinprogress/workinprogress_bloc.dart';
import '../../../main.dart';
import '../../../utils/app_colors.dart';

class ScheduleWork extends StatefulWidget {
  const ScheduleWork({super.key});

  @override
  State<ScheduleWork> createState() => _ScheduleWorkState();
}

class _ScheduleWorkState extends State<ScheduleWork> {
  DateTime? startDate;
  TextEditingController worktitle = TextEditingController();
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return GestureDetector(
      onTap: () {
        FocusScopeNode cf = FocusScope.of(context);
        if (!cf.hasPrimaryFocus) {
          cf.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height / 90 * 7.5),
          child: CustomAppbar(
            title: "Schedule Work",
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
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: padding.top * 0.4),
          padding: EdgeInsets.symmetric(
            horizontal: padding.top * 0.4,
          ),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 90 * 6.5,
                    child: TextFormField(
                      controller: worktitle,
                      decoration: InputDecoration(
                        hintText: "Work Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 1.5,
                  ),
                  InkWell(
                    onTap: () async {
                      startDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.dark(
                              primary: AppColors.yellow,
                              onPrimary: Colors.black,
                              surface: AppColors.yellow,
                              onSurface: Colors.black,
                            )),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2016),
                        lastDate: DateTime.utc(2050),
                      );
                      setState(() {
                        startDate;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding.top * 0.4,
                      ),
                      height: size.height / 90 * 6.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.customWhite,
                              blurRadius: 2.0,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          startDate == null
                              ? Text(
                                  "Pick a Start Date",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                )
                              : Text(
                                  DateFormat.yMMMMd()
                                      .format(startDate!)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                ),
                          const Icon(Icons.calendar_month_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 1.5,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {});
                      endDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.dark(
                              primary: AppColors.yellow,
                              onPrimary: Colors.black,
                              surface: AppColors.yellow,
                              onSurface: Colors.black,
                            )),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2016),
                        lastDate: DateTime.utc(2050),
                      );
                      setState(() {
                        endDate;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding.top * 0.4,
                      ),
                      height: size.height / 90 * 6.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.customWhite,
                              blurRadius: 2.0,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          endDate == null
                              ? Text(
                                  "Pick a End Date",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                )
                              : Text(
                                  DateFormat.yMMMMd()
                                      .format(endDate!)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                ),
                          const Icon(Icons.calendar_month_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 1.5,
                  ),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Work Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 8.5,
                  ),
                  BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                    listener: (context, state) {
                      if (state is AddingWorkState) {
                        BotToast.showCustomLoading(
                          toastBuilder: (cancelFunc) {
                            return customLoading(size);
                          },
                        );
                        ;
                      }
                      if (state is CompletedAddingWorkState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(
                          text: "Work Added",
                          contentColor: AppColors.green,
                        );
                      }
                      if (state is FailedAddingWorkState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(
                          text: "Failed To Add Work",
                          contentColor: AppColors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          foregroundColor: AppColors.grey,
                          fixedSize: Size(
                            size.width,
                            size.height / 90 * 3,
                          ),
                        ),
                        onPressed: () {
                          WorksModel worksModel = WorksModel(
                            title: worktitle.text,
                            startdate: startDate!,
                            endDate: endDate!,
                          );
                          BlocProvider.of<WorkinprogressBloc>(context)
                              .addWork(worksModel, args['sid']);
                        },
                        child: const Text("Save"),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
