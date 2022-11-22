import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SiteDescription extends StatefulWidget {
  const SiteDescription({super.key});

  @override
  State<SiteDescription> createState() => _SiteDescriptionState();
}

class _SiteDescriptionState extends State<SiteDescription> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          CustomAppbar(
            bgcolor: AppColors.white,
            title: args['sitename'],
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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("sites")
                .doc(args['sid'])
                .collection("siteimages")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: padding.top * 0.4),
                    children: [
                      CarouselSlider(
                        items: snapshot.data!.docs.map((siteimage) {
                          return Image.network(
                            siteimage['image'],
                            fit: BoxFit.cover,
                            width: 1000,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: size.height / 90 * 21.5,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 4.3,
                      ),
                      Text(
                        "Site Name : ${args['sitename']}",
                        style: TextStyle(
                            color: AppColors.fadeblue,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.8,
                      ),
                      Text(
                        "Site Location : ${args['sitelocation']}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.8,
                      ),
                      Text(
                        "Client Name : ${args['clientname']}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.8,
                      ),
                      Text(
                        "Client Phone : +977${args['phone']}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 3.66,
                      ),
                      Text(
                        "Estimation Sheet",
                        style: TextStyle(
                          color: AppColors.fadeblue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 0.66,
                      ),
                      DataTable(
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
                        columnSpacing: padding.top * 0.8,
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
                        ],
                        rows: const [
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Cement')),
                              DataCell(Text('19')),
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
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
