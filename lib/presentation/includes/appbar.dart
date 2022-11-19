import 'package:construction/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Color? bgcolor;
  final Widget leading;
  final List<Widget>? action;

  const CustomAppbar({
    super.key,
    required this.title,
    required this.leading,
    this.bgcolor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(color: AppColors.fadeblue),
          automaticallyImplyLeading: false,
          leading: leading,
          backgroundColor: bgcolor,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.fadeblue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: action,
        ),
        Image.asset('assets/icons/horline.png'),
      ],
    );
  }
}
