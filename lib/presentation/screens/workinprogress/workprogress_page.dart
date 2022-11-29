import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../../bloc/counter/counter_bloc.dart';
import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../utils/app_colors.dart';

class WorkInProgressPage extends StatefulWidget {
  const WorkInProgressPage({super.key});

  @override
  State<WorkInProgressPage> createState() => _WorkInProgressPageState();
}

class _WorkInProgressPageState extends State<WorkInProgressPage> {
  TextEditingController stocks = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final padding = MediaQuery.of(context).padding;

    final List<dynamic> items = ["Cement", "Brick", "Woods"];
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
          preferredSize: Size(size.width, size.height / 90 * 7.5),
          child: CustomAppbar(
            action: [
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
          ),
        ),
        body: Column(
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
                      color: AppColors.white,
                    ),
                    child: DropdownButtonFormField2(
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.customWhite,
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
                            .onItemSelectDropdown(newValue.toString());
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 1.2,
                  ),
                  CustomBox(
                    height: size.height / 90 * 23,
                    width: size.width,
                    radius: 15,
                    blurRadius: 4.0,
                    shadowColor: AppColors.customWhite,
                    color: AppColors.customWhite,
                    horizontalMargin: 0,
                    verticalMargin: 0,
                    child: Form(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 90 * 1.2,
                          ),
                          Text(
                            "Stock Used",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.3,
                          ),
                          SizedBox(
                            width: size.width / 7 * 2.8,
                            child: Divider(
                              color: AppColors.fadeblue,
                              thickness: 1.5,
                            ),
                          ),
                          BlocBuilder<CounterBloc, num>(
                            builder: (context, stock) {
                              return SizedBox(
                                height: size.height / 90 * 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppColors.fadeblue,
                                      child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<CounterBloc>(context)
                                              .add(DecrementEvent());
                                          stocks.text = stock.toString();
                                        },
                                        icon: Iconify(
                                          FluentMdl2.calculator_subtract,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 90 * 5.8,
                                      width: size.width / 7 * 2.8,
                                      child: TextFormField(
                                        controller: stocks,
                                        style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w400),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Stocks",
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: padding.top * 0.4,
                                            vertical: padding.top * 0.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppColors.fadeblue,
                                      child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<CounterBloc>(context)
                                              .add(IncrementEvent());
                                          stocks.text = stock.toString();
                                        },
                                        icon: Iconify(
                                          FluentMdl2.add,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: size.width / 7 * 2.8,
                            child: Divider(
                              color: AppColors.fadeblue,
                              thickness: 1.5,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.2,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  foregroundColor: AppColors.grey,
                                  fixedSize: Size(
                                    size.width / 7 * 2.8,
                                    size.height / 90 * 3,
                                  )),
                              onPressed: () {},
                              child: const Text("Update"))
                        ],
                      ),
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
                            color: AppColors.grey.withOpacity(0.3),
                            blurRadius: 4.0),
                      ],
                    ),
                    child: FAProgressBar(
                      formatValueFixed: 2,
                      animatedDuration: const Duration(seconds: 2),
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: AppColors.customWhite,
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
                  SizedBox(
                    height: size.height / 90 * 1.5,
                  ),
                  const Text("Site Works"),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("sites")
                          .doc("sid")
                          .collection("works")
                          .doc()
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CustomBox(
                            height: size.height / 90 * 45,
                            width: size.width,
                            radius: 15,
                            blurRadius: 4.0,
                            shadowColor: AppColors.white,
                            color: AppColors.white,
                            horizontalMargin: 0,
                            verticalMargin: 0,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 0),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data()!.length,
                              itemBuilder: (context, index) {
                                return const Text("HEllo");
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("Site Works Appears Here"),
                          );
                        }
                      }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.grey,
                        fixedSize: Size(
                          size.width,
                          size.height / 90 * 3,
                        )),
                    onPressed: () {},
                    child: const Text("Schedule Work"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
