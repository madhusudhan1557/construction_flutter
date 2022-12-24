import 'package:flutter/material.dart';

import '../../utils/validator.dart';

class CustomNumberField {
  final TextEditingController controller;
  final String hintText;
  final Color? color;
  final Icon? suffixIcon;
  final double size;
  const CustomNumberField({
    required this.hintText,
    this.color,
    required this.controller,
    this.suffixIcon,
    required this.size,
  });

  customNumberField() {
    return Container(
      height: size,
      decoration: BoxDecoration(color: color),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
        validator: (value) => Validator.getNumberValidator(value, hintText),
      ),
    );
  }
}
