import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SiteStocks extends StatefulWidget {
  const SiteStocks({super.key});

  @override
  State<SiteStocks> createState() => _SiteStocksState();
}

class _SiteStocksState extends State<SiteStocks> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    double stock = 1000000000;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: Column(
        children: [
          CustomAppbar(
            bgcolor: AppColors.customWhite,
            title: args['sitename'],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          CustomBox(
            height: size.height / 90 * 12.15,
            width: size.width,
            radius: 15,
            blurRadius: 4.0,
            shadowColor: Colors.grey,
            color: AppColors.customWhite,
            horizontalMargin: padding.top * 0.4,
            verticalMargin: padding.top * 0.4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding.top * 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Cement",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Brand Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      CustomBox(
                        height: size.height / 90 * 2.44,
                        width: size.width / 3.86,
                        radius: 15,
                        blurRadius: 2.0,
                        shadowColor: AppColors.grey.withOpacity(0.5),
                        color: stock == 0
                            ? AppColors.red
                            : stock >= 10
                                ? AppColors.green
                                : AppColors.yellow,
                        horizontalMargin: 0,
                        verticalMargin: 0,
                        child: Center(
                          child: Text(
                            stock == 0
                                ? "Out of Stock"
                                : stock >= 10
                                    ? "In Stock"
                                    : "Low Stock",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.more_vert,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantities : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "$stock pieces",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.more_vert,
                        color: AppColors.customWhite,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
