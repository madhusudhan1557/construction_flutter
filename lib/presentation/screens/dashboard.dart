import 'package:construction/presentation/includes/appbar.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> grids = [
    {"route": site, "title": "Sites", "image": "assets/images/sites.png"},
    {
      "route": "workinprogress",
      "title": "Work in Progress",
      "image": "assets/images/workinprogress.png"
    },
    {"route": stocks, "title": "Stocks", "image": "assets/images/stocks.png"},
    {"route": orders, "title": "Orders", "image": "assets/images/order.png"},
    {
      "route": estimation,
      "title": "Estimation",
      "image": "assets/images/estimation.png"
    },
    {
      "route": invoices,
      "title": "Invoices",
      "image": "assets/images/invoices.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AppColors.customGrey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: padding.top * 0.8),
        margin: EdgeInsets.only(top: padding.top * 0.8),
        child: Column(
          children: [
            CustomAppbar(
              title: "Dashboard",
              leading: Image.asset(
                'assets/images/logo/png',
                height: 24,
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: grids.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: size.height / 90 * 2.8,
                crossAxisSpacing: size.height / 90 * 2.8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      grids[index]["route"],
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.customGrey,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          grids[index]['image'],
                          height: size.height / 80 * 8.44,
                        ),
                        SizedBox(
                          height: size.height / 90 * 2.3,
                        ),
                        Text(
                          grids[index]["title"],
                          style: TextStyle(
                            color: AppColors.fadeblue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
