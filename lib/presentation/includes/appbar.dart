import 'package:construction/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar {
  final String title;
  final Color? bgcolor;
  final Widget leading;
  final List<Widget>? action;

  const CustomAppbar({
    required this.title,
    required this.leading,
    this.bgcolor,
    this.action,
  });

  customAppBar() {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(color: AppColors.blue),
          automaticallyImplyLeading: false,
          leading: leading,
          backgroundColor: bgcolor,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: action,
        ),
        Divider(
          thickness: 4,
          color: AppColors.yellow,
        ),
      ],
    );
  }
}
