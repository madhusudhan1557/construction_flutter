import 'package:construction/presentation/includes/appbar.dart';
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
    final padding = MediaQuery.of(context).padding;

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
                  height: size.height / 90 * 48.334,
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
                          hintText: "Brand Name",
                          size: size.height / 90 * 5.44,
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.538,
                        ),
                        CustomTextField(
                          controller: _itemname,
                          hintText: "Supplier Name",
                          size: size.height / 90 * 5.44,
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
                          controller: _itemname,
                          hintText: "Unit",
                          size: size.height / 90 * 5.44,
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: Size(size.width / 90 * 25.66,
                                    size.height / 90 * 3.86),
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
                  ),
                )),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.customWhite,
      body: Column(
        children: [
          CustomAppbar(
            title: "Stocks",
            bgcolor: AppColors.customWhite,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.fadeblue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
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
