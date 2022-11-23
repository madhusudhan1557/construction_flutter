import 'package:carousel_indicator/carousel_indicator.dart';
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
    int dotposition = 0;
    CarouselController carouselController = CarouselController();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height / 90 * 1.3,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                        child: CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, _) {
                            return PageView(
                              onPageChanged: (value) {
                                setState(() {
                                  dotposition = value;
                                });
                              },
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.fadeblue,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data!.docs[index]['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: size.height / 90 * 21.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.3,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CarouselIndicator(
                          count: snapshot.data!.docs.length,
                          activeColor: AppColors.yellow,
                          color: AppColors.fadeblue,
                          index: dotposition,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.3,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Site Name : ${args['sitename']}",
                                  style: TextStyle(
                                    color: AppColors.fadeblue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.home,
                                  size: size.height / 90 * 2.66,
                                  color: AppColors.fadeblue,
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Site Location : ${args['sitelocation']}",
                                  style: TextStyle(
                                    color: AppColors.fadeblue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.location_pin,
                                  size: size.height / 90 * 2.66,
                                  color: AppColors.fadeblue,
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Client Name : ${args['clientname']}",
                                  style: TextStyle(
                                    color: AppColors.fadeblue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.person,
                                  size: size.height / 90 * 2.66,
                                  color: AppColors.fadeblue,
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Client Phone : +977${args['phone']}",
                                  style: TextStyle(
                                    color: AppColors.fadeblue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.phone,
                                  size: size.height / 90 * 2.66,
                                  color: AppColors.fadeblue,
                                )
                              ],
                            ),
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
                              headingTextStyle:
                                  TextStyle(color: AppColors.white),
                              showBottomBorder: true,
                              columnSpacing: padding.top * 1.2,
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
