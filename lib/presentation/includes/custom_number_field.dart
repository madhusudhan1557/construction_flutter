import 'package:flutter/material.dart';

import '../../utils/validator.dart';

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? color;
  final Icon? suffixIcon;
  final double size;
  const CustomNumberField({
    super.key,
    required this.hintText,
    this.color,
    required this.controller,
    this.suffixIcon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(color: color),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => Validator.getNumberValidator(value, hintText),
      ),
    );
  }
}
