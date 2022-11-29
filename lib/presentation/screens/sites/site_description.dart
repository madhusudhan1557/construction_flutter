import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/utils/app_colors.dart';

import 'package:flutter/material.dart';

import '../../../utils/routes.dart';
import '../../includes/custom_box.dart';

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
      backgroundColor: AppColors.customWhite,
      body: Column(
        children: [
          CustomAppbar(
            bgcolor: AppColors.customWhite,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 90 * 1.3,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                      child: snapshot.data!.docs.isEmpty
                          ? Container()
                          : CarouselSlider.builder(
                              carouselController: carouselController,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index, _) {
                                return snapshot.data!.docs[index]['image'] ==
                                        null
                                    ? Container()
                                    : PageView(
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
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .docs[index]['image']),
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
                    snapshot.data!.docs.isEmpty
                        ? Container()
                        : Align(
                            alignment: Alignment.center,
                            child: CarouselIndicator(
                              count: snapshot.data!.docs.length,
                              activeColor: AppColors.yellow,
                              color: AppColors.fadeblue,
                              index: dotposition,
                            ),
                          ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${args['sitename']}",
                              style: TextStyle(
                                color: AppColors.fadeblue,
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${args['sitelocation']}",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                Icons.location_pin,
                                size: size.height / 90 * 2.66,
                                color: AppColors.grey,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height / 90 * 0.5,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${args['clientname']}",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "+977${args['phone']}",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                Icons.phone,
                                size: size.height / 90 * 2.66,
                                color: AppColors.grey,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.0,
                          ),
                          Text(
                            "About This site",
                            style: TextStyle(
                              color: AppColors.fadeblue,
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.0,
                          ),
                          Text(
                            maxLines: 15,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.parent,
                            "${args['sitedesc']}",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 3.5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(siteStocks, arguments: {
                                "sid": args['sid'],
                                "sitename": args['sitename'],
                                "sitedesc": args['sitedesc'],
                                "sitelocation": args['sitelocation'],
                                "clientname": args['clientname'],
                                "phone": args['phone'],
                                "supervisor": args['supervisor']
                              });
                            },
                            child: CustomBox(
                              height: size.height / 90 * 4.2,
                              width: size.width,
                              radius: 15,
                              blurRadius: 4.0,
                              shadowColor: Colors.grey,
                              color: AppColors.customWhite,
                              horizontalMargin: 0,
                              verticalMargin: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: padding.top * 0.4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Manage Stocks",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.2,
                          ),
                          args['role'] == "Admin"
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(siteEstimation);
                                  },
                                  child: CustomBox(
                                      height: size.height / 90 * 4.2,
                                      width: size.width,
                                      radius: 15,
                                      blurRadius: 4.0,
                                      shadowColor: Colors.grey,
                                      color: AppColors.customWhite,
                                      horizontalMargin: 0,
                                      verticalMargin: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: padding.top * 0.4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Estimation",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      )),
                                )
                              : Container(),
                          SizedBox(
                            height: size.height / 90 * 1.2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(siteEstimation);
                            },
                            child: CustomBox(
                                height: size.height / 90 * 4.2,
                                width: size.width,
                                radius: 15,
                                blurRadius: 4.0,
                                shadowColor: Colors.grey,
                                color: AppColors.customWhite,
                                horizontalMargin: 0,
                                verticalMargin: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(workinprogress);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Work in Progress",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(siteEstimation);
                            },
                            child: CustomBox(
                                height: size.height / 90 * 4.2,
                                width: size.width,
                                radius: 15,
                                blurRadius: 4.0,
                                shadowColor: Colors.grey,
                                color: AppColors.customWhite,
                                horizontalMargin: 0,
                                verticalMargin: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: padding.top * 0.4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Manage Orders",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
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
