import 'package:construction/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Color? bgcolor;
  const CustomAppbar({
    super.key,
    required this.title,
    this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
        ),
        Image.asset('assets/icons/horline.png'),
      ],
    );
  }
}
