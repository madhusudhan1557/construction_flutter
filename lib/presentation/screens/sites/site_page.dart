import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';

import 'package:construction/presentation/includes/show_modal.dart';
import 'package:construction/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_colors.dart';

import '../../../bloc/sites/sites_bloc.dart';

import '../../../main.dart';

class SitePage extends StatefulWidget {
  const SitePage({super.key});

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  List<String> imageurl = [];

  List<String> images = [];

  List<XFile> siteimages = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddding = MediaQuery.of(context).padding;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          title: "Sites",
          bgcolor: AppColors.white,
          action: [
            args['role'] == "Admin"
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: paddding.top * 0.6),
                    child: CircleAvatar(
                      backgroundColor: AppColors.yellow,
                      radius: 21,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(addsitepage);
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.fadeblue,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.fadeblue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      backgroundColor: AppColors.white,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("sites").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 90 * 4.43,
                      ),
                      Image.asset(
                        "assets/images/sites.png",
                        height: size.height / 90 * 18.54,
                        width: size.width / 2,
                      ),
                      SizedBox(
                        height: size.height / 90 * 2.43,
                      ),
                      Center(
                        child: Text(
                          "No Sites At The Moment",
                          style: TextStyle(
                            color: AppColors.fadeblue,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 90 * 5.43,
                      ),
                      args['role'] == "Admin"
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      size.width / 90 * 1.8,
                                    ),
                                  ),
                                  backgroundColor: AppColors.yellow,
                                  foregroundColor: Colors.black,
                                  fixedSize: Size(
                                    size.width / 1.11,
                                    size.height / 90 * 4.76,
                                  )),
                              onPressed: () {},
                              child: const Text("Add New Sites"),
                            )
                          : Container(),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(siteDesc, arguments: {
                            "sid": snapshot.data!.docs[index]['sid'],
                            "sitename": snapshot.data!.docs[index]['sitename'],
                            "sitedesc": snapshot.data!.docs[index]['sitedesc'],
                            "sitelocation": snapshot.data!.docs[index]
                                ['sitelocation'],
                            "clientname": snapshot.data!.docs[index]
                                ['clientname'],
                            "phone": snapshot.data!.docs[index]['phone'],
                            "supervisor": snapshot.data!.docs[index]
                                ['supervisor'],
                            "role": args['role'],
                          });
                        },
                        child: CustomBox(
                          horizontalMargin: paddding.top * 0.4,
                          verticalMargin: paddding.top * 0.28,
                          height: size.height / 90 * 18,
                          width: size.width,
                          color: AppColors.white,
                          blurRadius: 4.0,
                          radius: 10,
                          shadowColor: AppColors.customWhite,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddding.top * 0.31,
                                vertical: paddding.top * 0.11),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['sitename'],
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['clientname'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.fadeblue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width / 2 * 1.2,
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            ['sitelocation'],
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.rtl,
                                      softWrap: true,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: 'Supervisor : ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.fadeblue,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: snapshot.data!.docs[index]
                                                ['supervisor'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.fadeblue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 98 * 0.8,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: paddding.top * 0.2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      args['role'] == "Admin"
                                          ? BlocConsumer<SitesBloc, SitesState>(
                                              listener: (context, state) {
                                                if (state
                                                    is LoadingDeleteSiteState) {
                                                  BotToast.showCustomLoading(
                                                    toastBuilder: (cancelFunc) {
                                                      return customLoading(
                                                          size);
                                                    },
                                                  );
                                                }
                                                if (state
                                                    is LoadingDeleteCompleteState) {
                                                  BotToast.closeAllLoading();
                                                  BotToast.showText(
                                                    text:
                                                        " Delete ${snapshot.data!.docs[index]['sitename']} Site",
                                                    contentColor: Colors.green,
                                                  );
                                                  Navigator.of(context).pop();
                                                }
                                                if (state
                                                    is FailedDeleteSiteState) {}
                                              },
                                              builder: (context, state) {
                                                return Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      QuerySnapshot siteimages =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "sites")
                                                              .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                  index]['sid'])
                                                              .collection(
                                                                  "siteimages")
                                                              .where("sid",
                                                                  isEqualTo: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]['sid'])
                                                              .get();
                                                      imageurl.clear();
                                                      for (int i = 0;
                                                          i <
                                                              siteimages
                                                                  .docs.length;
                                                          i++) {
                                                        imageurl.add(siteimages
                                                            .docs[i]['image']);
                                                      }

                                                      ShowCustomModal()
                                                          .showDeleteDialog(
                                                        id: snapshot.data!
                                                            .docs[index]['sid'],
                                                        context: context,
                                                        height: size.height /
                                                            90 *
                                                            23,
                                                        width:
                                                            size.width / 2 * 11,
                                                        imageurl: imageurl,
                                                      );
                                                    },
                                                    child: Iconify(
                                                      FluentMdl2.delete,
                                                      size: size.height /
                                                          90 *
                                                          2.3,
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: size.height / 90 * 2.3,
                                      ),
                                      args['role'] == "Admin"
                                          ? Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  ShowCustomModal()
                                                      .showArchriveDialog(
                                                    id: snapshot.data!
                                                        .docs[index]['sid'],
                                                    context: context,
                                                    height:
                                                        size.height / 90 * 23,
                                                    width: size.width / 2 * 11,
                                                    imageheight:
                                                        size.height / 90 * 6.54,
                                                  );
                                                },
                                                child: Iconify(
                                                  FluentMdl2.archive,
                                                  size: size.height / 90 * 2.3,
                                                  color: AppColors.fadeblue,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).customBox(),
                      );
                    },
                  );
          } else {
            return Builder(
              builder: (context) => customLoading(size),
            );
          }
        },
      ),
    );
  }
}
