import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomTextArea {
  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;
  final double size;
  const CustomTextArea({
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    required this.size,
  });

  customTextArea() {
    return Container(
      height: size,
      decoration: BoxDecoration(color: AppColors.customWhite),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        keyboardType: TextInputType.multiline,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
        validator: (value) => Validator.getBlankFieldValidator(value, hintText),
      ),
    );
  }
}
