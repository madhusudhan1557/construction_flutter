import 'package:construction/presentation/includes/custom_number_field.dart';
import 'package:construction/presentation/includes/custom_textfield.dart';

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _itemname = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _rate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String unit = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddding = MediaQuery.of(context).padding;

    showAddStockModal() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: SizedBox(
                  height: size.height / 90 * 44.334,
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
                        hintText: "Items Name",
                        size: size.height / 90 * 5.44,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      CustomNumberField(
                        hintText: "Item Quantity",
                        controller: _quantity,
                        size: size.height / 90 * 5.44,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      // Container(
                      //   height: size.height / 90 * 5.44,
                      //   decoration: BoxDecoration(
                      //       color: AppColors.customGrey
                      //           .withOpacity(0.6)),
                      //   child: DropdownButtonHideUnderline(
                      //       child: DropdownButtonFormField(
                      //     decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.symmetric(
                      //         horizontal: paddding.top * 0.4,
                      //       ),
                      //       hintText: "Select Unit",
                      //       border: InputBorder.none,
                      //     ),
                      //     items: listmaterial.unit!
                      //         .map<DropdownMenuItem<String>>(
                      //             (items) {
                      //       return DropdownMenuItem<String>(
                      //         value: items["id"].toString(),
                      //         child: Text(
                      //           items["name"],
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       setState(() {
                      //         unit = value.toString();
                      //       });
                      //     },
                      //   )),
                      // ),
                      SizedBox(
                        height: size.height / 90 * 1.538,
                      ),
                      CustomNumberField(
                        hintText: "Item Rate",
                        controller: _rate,
                        size: size.height / 90 * 5.44,
                      ),
                      SizedBox(
                        height: size.height / 90 * 2.334,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(103, 33),
                              foregroundColor: AppColors.fadeblue,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(103, 33),
                              backgroundColor: AppColors.yellow,
                              foregroundColor: AppColors.fadeblue,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: paddding.top * 0.3),
        margin: EdgeInsets.only(top: paddding.top * 0.8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: size.height / 90 * 2.532,
                      color: AppColors.fadeblue,
                    ),
                  ),
                  SizedBox(
                    width: size.width / 5 * 1.432,
                  ),
                  Text(
                    "Stocks",
                    style: TextStyle(
                      color: AppColors.fadeblue,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 90 * 3.44,
                  ),
                  Image.asset(
                    "assets/images/stocks.png",
                    height: size.height / 90 * 15.334,
                  ),
                  SizedBox(
                    height: size.height / 90 * 3.44,
                  ),
                  Text(
                    "Seems Like there are no Stocks",
                    style: TextStyle(
                      color: AppColors.fadeblue,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.yellow,
        onPressed: () {
          showAddStockModal();
        },
        child: Icon(
          Icons.add,
          color: AppColors.fadeblue,
        ),
      ),
    );
  }
}
