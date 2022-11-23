import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../utils/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AppColors.customGrey,
      body: Column(
        children: [
          CustomAppbar(
            title: "Settings",
            bgcolor: AppColors.customGrey,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.fadeblue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: size.height / 90 * 1.86,
          ),
          CustomBox(
            height: size.height / 90 * 5.8,
            width: size.width,
            radius: 15,
            blurRadius: 4.0,
            shadowColor: Colors.grey,
            color: AppColors.customGrey,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: ListTile(
              onTap: () {},
              title: const Text(
                "Add Supervisor / Engineer",
                textAlign: TextAlign.start,
              ),
              leading: const Iconify(
                FluentMdl2.archive_undo,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fadeblue,
              ),
            ),
          ),
          CustomBox(
            height: size.height / 90 * 5.8,
            width: size.width,
            radius: 15,
            blurRadius: 4.0,
            shadowColor: Colors.grey,
            color: AppColors.customGrey,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: ListTile(
              onTap: () {},
              title: const Text(
                "Register a new Admin",
                textAlign: TextAlign.start,
              ),
              leading: const Iconify(
                FluentMdl2.archive_undo,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fadeblue,
              ),
            ),
          ),
          CustomBox(
            height: size.height / 90 * 5.8,
            width: size.width,
            radius: 15,
            blurRadius: 8.0,
            shadowColor: Colors.grey,
            color: AppColors.customGrey,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: ListTile(
              onTap: () {},
              title: const Text(
                "View Archrive List",
                textAlign: TextAlign.start,
              ),
              leading: const Iconify(
                FluentMdl2.archive_undo,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fadeblue,
              ),
            ),
          ),
          CustomBox(
            height: size.height / 90 * 5.8,
            width: size.width,
            radius: 15,
            blurRadius: 8.0,
            shadowColor: Colors.grey,
            color: AppColors.customGrey,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: ListTile(
              onTap: () {},
              title: const Text(
                "Add Categories for Stocks",
                textAlign: TextAlign.start,
              ),
              leading: const Iconify(
                FluentMdl2.archive_undo,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fadeblue,
              ),
            ),
          ),
          CustomBox(
            height: size.height / 90 * 5.8,
            width: size.width,
            radius: 15,
            blurRadius: 8.0,
            shadowColor: Colors.grey,
            color: AppColors.customGrey,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: ListTile(
              onTap: () {},
              title: const Text(
                "Add Measurement Units",
                textAlign: TextAlign.start,
              ),
              leading: const Iconify(
                FluentMdl2.archive_undo,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fadeblue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
