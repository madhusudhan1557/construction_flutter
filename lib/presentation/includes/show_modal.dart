import 'package:construction/bloc/sites/sites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../utils/app_colors.dart';

class ShowCustomModal {
  showArchriveDialog({
    required String id,
    required BuildContext context,
    required double height,
    required double width,
    required double imageheight,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: size.width / 8.6,
                    backgroundColor: AppColors.fadeblue,
                    child: Iconify(
                      FluentMdl2.archive_undo,
                      color: AppColors.white,
                      size: size.height / 90 * 6.76,
                    ),
                  ),
                  const Text(
                    "Are you sure you want to Archrive ?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(103, 33),
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.fadeblue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(103, 33),
                          backgroundColor: AppColors.fadeblue,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: () {},
                        child: const Text("Archrive"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  showDeleteDialog({
    required String id,
    required BuildContext context,
    required double height,
    required double width,
    required double imageheight,
    required List<String> imageurl,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: size.width / 8.2,
                    backgroundColor: AppColors.red,
                    child: Iconify(
                      FluentMdl2.delete,
                      size: size.height / 90 * 6.76,
                      color: AppColors.white,
                    ),
                  ),
                  const Text(
                    "Are you sure you want to Delete ?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(103, 33),
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.fadeblue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(103, 33),
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<SitesBloc>(context)
                              .deleteSite(id, imageurl, context);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
