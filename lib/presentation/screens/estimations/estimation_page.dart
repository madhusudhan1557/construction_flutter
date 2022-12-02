import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class EstimationPage extends StatelessWidget {
  const EstimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: padding.top * 0.8),
        margin: EdgeInsets.only(top: padding.top * 0.8),
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
                    width: size.width / 5 * 1.1,
                  ),
                  Text(
                    "Estimations",
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
                    height: size.height / 90 * 2.36,
                  ),
                  Text(
                    "Estimation Sheet",
                    style: TextStyle(
                      color: AppColors.fadeblue,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90 * 0.66,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.fadeblue,
                      ),
                      border: TableBorder(
                          bottom: BorderSide(
                              width: 1,
                              color: AppColors.fadeblue,
                              style: BorderStyle.solid),
                          left: BorderSide(
                              width: 1,
                              color: AppColors.fadeblue,
                              style: BorderStyle.solid),
                          right: BorderSide(
                              width: 1,
                              color: AppColors.fadeblue,
                              style: BorderStyle.solid),
                          horizontalInside: BorderSide(
                              width: 1,
                              color: AppColors.fadeblue,
                              style: BorderStyle.solid)),
                      headingTextStyle: TextStyle(color: AppColors.white),
                      showBottomBorder: true,
                      columnSpacing: padding.top * 1.8,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Quantity'),
                        ),
                        DataColumn(
                          label: Text('Rate'),
                        ),
                        DataColumn(
                          label: Text('Amount'),
                        ),
                        DataColumn(
                          label: Text('Rate'),
                        ),
                        DataColumn(
                          label: Text('Amount'),
                        ),
                      ],
                      rows: const [
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cement')),
                            DataCell(Text('19')),
                            DataCell(Text('1300')),
                            DataCell(Text('${19 * 1300}')),
                            DataCell(Text('1300')),
                            DataCell(Text('${19 * 1300}')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cement')),
                            DataCell(Text('19')),
                            DataCell(Text('1300')),
                            DataCell(Text('${19 * 1300}')),
                            DataCell(Text('1300')),
                            DataCell(Text('${19 * 1300}')),
                          ],
                        )
                      ],
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
