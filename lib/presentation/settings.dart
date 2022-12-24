import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';

import 'package:construction/presentation/includes/show_modal.dart';
import 'package:construction/utils/routes.dart';
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
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          title: "Settings",
          bgcolor: AppColors.customWhite,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      backgroundColor: AppColors.customWhite,
      body: Column(
        children: [
          CustomBox(
            height: size.height / 90 * 5.6,
            width: size.width,
            radius: 18,
            blurRadius: 4.0,
            shadowColor: Colors.grey,
            color: AppColors.customWhite,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.2,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(userspage);
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: size.width / 18.3),
                    CircleAvatar(
                      backgroundColor: AppColors.blue,
                      radius: 18,
                      child: Iconify(
                        FluentMdl2.engineering_group,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: size.width / 11.3),
                    Text(
                      "View Users",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blue,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).customBox(),
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
                  height: size.height / 90 * 5.6,
                  width: size.width,
                  radius: 18,
                  blurRadius: 4.0,
                  shadowColor: Colors.grey,
                  color: AppColors.customWhite,
                  horizontalMargin: padding.top * 0.4,
                  verticalMargin: padding.top * 0.2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: size.width / 18.3),
                        CircleAvatar(
                          backgroundColor: AppColors.blue,
                          radius: 18,
                          child: Iconify(
                            FluentMdl2.sign_out,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: size.width / 11.3),
                        Text(
                          "Log out",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blue,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).customBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
