import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ShowCustomModal {
  showArchriveDialog({
    required int id,
    required BuildContext context,
    required double height,
    required double width,
    required double imageheight,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.fadeblue,
                child: Image.asset(
                  "assets/icons/archrive.png",
                  color: Colors.white,
                  height: imageheight,
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
      ),
    );
  }

  showDeleteDialog({
    required int id,
    required BuildContext context,
    required double height,
    required double width,
    required double imageheight,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/delete_icon.png",
                height: imageheight,
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
                    onPressed: () {},
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
