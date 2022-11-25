import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';

import 'package:construction/presentation/includes/show_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../bloc/auth/auth_bloc.dart';
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
                size: 18,
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
                size: 18,
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
                size: 18,
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
                size: 18,
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
                size: 18,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ShowCustomModal().showSignOutDialog(
                context: context,
                height: size.height / 90 * 23,
                width: size.width / 2 * 11,
              );
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return CustomBox(
                  height: size.height / 90 * 5.8,
                  width: size.width,
                  radius: 15,
                  blurRadius: 4.0,
                  shadowColor: Colors.grey,
                  color: AppColors.customGrey,
                  horizontalMargin: padding.top * 0.4,
                  verticalMargin: padding.top * 0.2,
                  child: ListTile(
                    title: const Text(
                      "Log out",
                      textAlign: TextAlign.start,
                    ),
                    leading: Iconify(
                      FluentMdl2.sign_out,
                      color: AppColors.red,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.fadeblue,
                      size: 18,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
