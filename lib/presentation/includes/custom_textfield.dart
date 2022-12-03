import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double size;
  final double width;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    required this.size,
    this.prefixIcon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: width,
      decoration: BoxDecoration(color: AppColors.customWhite.withOpacity(0.6)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        validator: (value) => Validator.getBlankFieldValidator(value, hintText),
      ),
    );
  }
}
