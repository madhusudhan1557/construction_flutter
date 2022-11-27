import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../utils/app_colors.dart';

class WorkInProgressPage extends StatefulWidget {
  const WorkInProgressPage({super.key});

  @override
  State<WorkInProgressPage> createState() => _WorkInProgressPageState();
}

class _WorkInProgressPageState extends State<WorkInProgressPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final List<dynamic> items = ["Cement", "Brick", "Woods"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.customGrey,
      body: Column(
        children: [
          CustomAppbar(
            title: "Work In Progress",
            bgcolor: AppColors.customGrey,
            action: [
              IconButton(
                onPressed: () {},
                icon: Image.asset("assets/icons/camera.png"),
              ),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.fadeblue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: size.height / 90 * 1.5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: padding.top * 0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Colors.grey,
                      )
                    ],
                    color: AppColors.customGrey,
                  ),
                  child: DropdownButtonFormField2(
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.customGrey,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    buttonPadding:
                        EdgeInsets.symmetric(horizontal: padding.top * 0.2),
                    hint: const Text("Select Item"),
                    offset: Offset(0, -size.height / 90 * 2.44),
                    items: items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      BlocProvider.of<DropdownBloc>(context)
                          .onSelectDropdown(newValue.toString());
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 90 * 1.2,
                ),
                CustomBox(
                  height: size.height / 90 * 35,
                  width: size.width,
                  radius: 15,
                  blurRadius: 4.0,
                  shadowColor: AppColors.grey.withOpacity(0.3),
                  color: AppColors.customGrey,
                  horizontalMargin: 0,
                  verticalMargin: 0,
                  child: const Text("Stocks"),
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
                          color: AppColors.grey.withOpacity(0.3),
                          blurRadius: 4.0),
                    ],
                  ),
                  child: FAProgressBar(
                    formatValueFixed: 2,
                    animatedDuration: const Duration(seconds: 2),
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: AppColors.customGrey,
                    progressColor: AppColors.yellow,
                    direction: Axis.horizontal,
                    displayText: "%",
                    displayTextStyle: TextStyle(
                      color: AppColors.fadeblue,
                    ),
                    maxValue: 100,
                    currentValue: 90,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
