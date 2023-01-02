import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/bloc/workinprogress/workinprogress_bloc.dart';
import 'package:construction/main.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../bloc/pickimage/pickimage_bloc.dart';
import '../../../utils/app_colors.dart';

class WorkImagesPage extends StatefulWidget {
  const WorkImagesPage({super.key});

  @override
  State<WorkImagesPage> createState() => _WorkImagesPageState();
}

class _WorkImagesPageState extends State<WorkImagesPage> {
  List<String> images = [];

  List<XFile> workimages = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final siteimageBloc = BlocProvider.of<PickimageBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          size.height / 90 * 8.5,
        ),
        child: CustomAppbar(
          title: "${args["title"]}",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: padding.top * 0.4),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: size.height / 90 * 1.538,
            ),
            InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                workimages = await picker.pickMultiImage();
                images.clear();

                siteimageBloc.pickImage(workimages);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/camera.png",
                    height: 44,
                    width: 44,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add Site Images",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 90 * 1.5,
            ),
            Container(
              height: size.height / 90 * 27,
              width: size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: padding.top * 0.4, vertical: padding.top * 0.3),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              child: BlocConsumer<PickimageBloc, PickimageState>(
                listener: (context, state) {},
                builder: (context, state) => state.siteimage != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: size.height / 90 * 18,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.siteimage!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(state.siteimage![index].path),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        icon: CircleAvatar(
                                          radius: 11,
                                          backgroundColor: AppColors.red,
                                          child: const Icon(
                                            Icons.close,
                                            size: 8,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            state.siteimage!.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90 * 1.5,
                          ),
                          BlocConsumer<WorkinprogressBloc, WorkinprogressState>(
                            listener: (context, state) {
                              if (state is UploadingWorkImagesState) {
                                BotToast.showCustomLoading(
                                  toastBuilder: (cancelFunc) =>
                                      customLoading(size),
                                );
                              }
                              if (state is FailedUploadingWorkImagesState) {
                                BotToast.closeAllLoading();
                                BotToast.showText(
                                    text: state.error!,
                                    contentColor: AppColors.red);
                              }
                              if (state is CompletedUploadingWorkImagesState) {
                                BotToast.closeAllLoading();
                                BotToast.showText(
                                    text: "Upload Successfull",
                                    contentColor: AppColors.green);
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<WorkinprogressBloc>(context)
                                      .addWorkImages(
                                          args['sid'], args["wid"], workimages);
                                },
                                child: const Text("Upload"),
                              );
                            },
                          ),
                        ],
                      )
                    : const Center(
                        child: Text("Add Work  Images Here "),
                      ),
              ),
            ),
            SizedBox(
              height: size.height / 90 * 1.5,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("sites")
                  .doc(args['sid'])
                  .collection("works")
                  .doc(args['wid'])
                  .collection("images")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: size.height / 90 * 35,
                    child: snapshot.data!.docs.isEmpty
                        ? const Text("No Images Found")
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: size.height / 90 * 18.5,
                                width: size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: padding.top * 0.4),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.customWhite,
                                        blurRadius: 4.0,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height / 90 * 13.5,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]["image"],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text("Date : "),
                                        Text(
                                          DateFormat.yMMMd().format(
                                            snapshot.data!.docs[index]['date']
                                                .toDate(),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                } else {
                  return Center(
                    child: Builder(
                      builder: (context) => customLoading(size),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
