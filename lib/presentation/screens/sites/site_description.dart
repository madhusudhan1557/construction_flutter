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
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: padding.top * 0.4),
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
                          args['sitename'],
                          style: TextStyle(
                              color: AppColors.fadeblue,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: size.height / 90 * 1.8,
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
            )
          ],
        ),
      ),
    );
  }
}
