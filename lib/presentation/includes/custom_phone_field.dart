import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final double size;
  const CustomPhoneField({
    super.key,
    required this.controller,
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
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Phone Number ",
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
