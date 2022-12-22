import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomPhoneField {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final double size;
  const CustomPhoneField({
    required this.controller,
    this.suffixIcon,
    required this.size,
  });

  customPhoneField() {
    return Container(
      height: size,
      decoration: BoxDecoration(color: AppColors.customWhite),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Phone Number ",
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        validator: (value) => Validator.getPhoneValidator(value),
      ),
    );
  }
}
