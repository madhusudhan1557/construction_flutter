import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final double size;
  const CustomPasswordField({
    super.key,
    required this.controller,
    this.suffixIcon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(color: AppColors.customWhite.withOpacity(0.6)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => Validator.getPasswordValidator(value),
      ),
    );
  }
}
