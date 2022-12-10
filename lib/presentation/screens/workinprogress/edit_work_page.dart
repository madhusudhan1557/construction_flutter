import 'package:bot_toast/bot_toast.dart';
import 'package:construction/data/models/works.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/workinprogress/workinprogress_bloc.dart';
import '../../../main.dart';
import '../../../utils/app_colors.dart';
import '../../includes/appbar.dart';

class EditWorkPage extends StatefulWidget {
  const EditWorkPage({super.key});

  @override
  State<EditWorkPage> createState() => _EditWorkPageState();
}

class _EditWorkPageState extends State<EditWorkPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          bgcolor: AppColors.white,
          title: "Edit Work Info",
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      body: Container(
        margin: EdgeInsets.only(top: padding.top * 0.4),
        padding: EdgeInsets.symmetric(
          horizontal: padding.top * 0.8,
        ),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 90 * 5.5,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    initialValue: args["title"],
                    decoration: InputDecoration(
                      hintText: "Work Title",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(padding.top * 0.4),
                    ),
                    onChanged: (value) {
                      args['title'] = value;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 90 * 1.5,
                ),
                InkWell(
                  onTap: () async {
                    args["startdate"] = await showDatePicker(
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
                      args["startdate"];
                    });
                  },
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: padding.top * 0.4,
                    ),
                    height: size.height / 90 * 5.5,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        args['startdate'] == null
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
                                    .format(args["startdate"])
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fadeblue,
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
                    args["endDate"] = await showDatePicker(
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
                      args["endDate"];
                    });
                  },
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: padding.top * 0.4,
                    ),
                    height: size.height / 90 * 5.5,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        args["endDate"] == null
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
                                    .format(args["endDate"])
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fadeblue,
                                ),
                              ),
                        const Icon(Icons.calendar_month_rounded),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 90 * 1.3,
                ),
                Container(
                  height: size.height / 90 * 5.5,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    initialValue: args["workdesc"],
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: "Work Description",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(padding.top * 0.4)),
                    onChanged: (value) {
                      args["workdesc"] = value;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 90 * 3.5,
                ),
                BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                  listener: (context, state) {
                    if (state is UpdatingWorkInfoState) {
                      BotToast.showCustomLoading(
                        toastBuilder: (cancelFunc) {
                          return customLoading(size);
                        },
                      );
                    }
                    if (state is CompleteUpdatingWorkInfoState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: "Work Info Updated",
                        contentColor: AppColors.green,
                      );
                    }
                    if (state is FailedUpdatingWorkInfoState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: "Failed To Add Work",
                        contentColor: AppColors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.fadeblue,
                        fixedSize: Size(
                          size.width,
                          size.height / 90 * 3,
                        ),
                      ),
                      onPressed: () {
                        if (args['title'].isEmpty || args['title'] == null) {
                          BotToast.showText(
                            text: "Title must not be empty",
                            contentColor: AppColors.red,
                          );
                        }
                        if (args['startdate'] == null) {
                          BotToast.showText(
                            text: "Start Date must not be empty",
                            contentColor: AppColors.red,
                          );
                        }
                        if (args['endDate'] == null) {
                          BotToast.showText(
                            text: "End Date must not be empty",
                            contentColor: AppColors.red,
                          );
                        } else {
                          WorksModel worksModel = WorksModel(
                            wid: args['wid'],
                            title: args["title"],
                            startdate: args['startdate'],
                            endDate: args['endDate'],
                            workdesc: args["workdesc"],
                          );
                          BlocProvider.of<WorkinprogressBloc>(context)
                              .updateWorkInfo(
                            worksModel,
                            args['sid'],
                          );
                        }
                      },
                      child: const Text("Save"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
