import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;
  final double size;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(color: AppColors.customGrey.withOpacity(0.6)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => Validator.getBlankFieldValidator(value),
      ),
    );
  }
}
