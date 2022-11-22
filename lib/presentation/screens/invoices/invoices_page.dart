import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: paddding.top * 0.8),
        margin: EdgeInsets.only(top: paddding.top * 0.8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: size.height / 90 * 3.44,
                  ),
                  SizedBox(
                    width: size.width / 5 * 1.432,
                  ),
                  Text(
                    "Invoices",
                    style: TextStyle(
                      color: AppColors.fadeblue,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 90 * 3.44,
                  ),
                  Image.asset(
                    "assets/images/invoices.png",
                    height: size.height / 90 * 15.334,
                  ),
                  SizedBox(
                    height: size.height / 90 * 3.44,
                  ),
                  Text(
                    "Seems Like there are no Invoices",
                    style: TextStyle(
                      color: AppColors.fadeblue,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
