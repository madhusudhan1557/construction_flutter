import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/presentation/includes/custom_textfield.dart';
import 'package:construction/presentation/includes/show_modal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_colors.dart';
import '../../../bloc/pickimage/pickimage_bloc.dart';
import '../../../bloc/sites/sites_bloc.dart';

class SitePage extends StatefulWidget {
  const SitePage({super.key});

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  final TextEditingController _sitename = TextEditingController(text: "Hello");
  final TextEditingController _sitedes = TextEditingController(text: "Hello");
  final TextEditingController _sitelocation =
      TextEditingController(text: "Hello");
  final TextEditingController _clientname =
      TextEditingController(text: "Hello");
  final TextEditingController _phone =
      TextEditingController(text: "9864022154");
  final _formKey = GlobalKey<FormState>();
  List<String> images = [];
  List<XFile> siteimages = [];
  final List<String> roles = ["Supervisor", "Engineer"];
  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddding = MediaQuery.of(context).padding;
    final siteimageBloc = BlocProvider.of<PickimageBloc>(context);
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    showAddSiteModal() {
      images.clear();
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("role", isEqualTo: "Supervisor")
                  .get()
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: size.width,
                    height: size.height / 90 * 74.334,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height / 90 * 1.338,
                            ),
                            Text(
                              "Add Site",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.fadeblue),
                            ),
                            SizedBox(
                              height: size.height / 90 * 2.538,
                            ),
                            CustomTextField(
                              controller: _sitename,
                              hintText: "Site Name",
                              suffixIcon: const Icon(
                                Icons.home_sharp,
                                color: Colors.black,
                              ),
                              size: size.height / 90 * 5.44,
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            CustomTextField(
                              controller: _sitedes,
                              hintText: "Site Description",
                              suffixIcon: const Icon(
                                Icons.home_sharp,
                                color: Colors.black,
                              ),
                              size: size.height / 90 * 11.44,
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            CustomTextField(
                              controller: _sitelocation,
                              hintText: "Site Location",
                              suffixIcon: const Icon(
                                Icons.location_pin,
                                color: Colors.black,
                              ),
                              size: size.height / 90 * 5.44,
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            CustomTextField(
                              controller: _clientname,
                              hintText: "Client Name",
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              size: size.height / 90 * 5.44,
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            CustomTextField(
                              controller: _phone,
                              hintText: "Phone Number",
                              suffixIcon: const Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              size: size.height / 90 * 5.44,
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.customGrey.withOpacity(0.6),
                              ),
                              child: DropdownButtonFormField2(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                buttonPadding: EdgeInsets.symmetric(
                                    horizontal: paddding.top * 0.4),
                                hint: const Text("Assign Supervisor"),
                                offset: Offset(0, -size.height / 90 * 2.44),
                                items: snapshot.data!.docs.map((supervisor) {
                                  return DropdownMenuItem(
                                    value: supervisor['uid'],
                                    child: Text(
                                      "${supervisor['firstname']} ${supervisor['lastname']}",
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                siteimages = await picker.pickMultiImage();
                                images.clear();

                                siteimageBloc.pickImage(siteimages);
                              },
                              child: Row(
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
                                      color: AppColors.fadeblue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 7,
                              child:
                                  BlocConsumer<PickimageBloc, PickimageState>(
                                listener: (context, state) {},
                                builder: (context, state) => state.siteimage !=
                                        null
                                    ? GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.siteimage!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) {
                                          images.add(
                                              state.siteimage![index].path);
                                          return Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(state
                                                          .siteimage![index]
                                                          .path),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    const Alignment(1.8, -2.8),
                                                child: IconButton(
                                                  icon: const CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor: Colors.red,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 5,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      images.removeAt(index);
                                                      state.siteimage!
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 2.334,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: const Size(103, 33),
                                    foregroundColor: AppColors.fadeblue,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                BlocConsumer<SitesBloc, SitesState>(
                                  listener: (context, state) {
                                    if (state is LoadingSiteState) {
                                      BotToast.showLoading();
                                    }
                                    if (state is LoadingCompleteEvent) {
                                      BotToast.closeAllLoading();
                                    }
                                    if (state is AddedSiteState) {
                                      BotToast.showText(text: state.message!);
                                      Navigator.of(context).pop();
                                      BotToast.closeAllLoading();
                                    }
                                    if (state is FailedSiteState) {
                                      BotToast.showText(text: state.error!);
                                      BotToast.closeAllLoading();
                                    }
                                  },
                                  builder: (context, state) {
                                    return BlocConsumer<SitesBloc, SitesState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            fixedSize: const Size(103, 33),
                                            backgroundColor: AppColors.yellow,
                                            foregroundColor: AppColors.fadeblue,
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {}
                                          },
                                          child: const Text("Save"),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              }),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.customGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              title: "Sites",
              bgcolor: AppColors.customGrey,
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
            StreamBuilder<QuerySnapshot>(
                stream: null,
                builder: (context, snapshot) {
                  return CustomBox(
                    horizontalMargin: paddding.top * 0.4,
                    verticalMargin: paddding.top * 0.28,
                    height: size.height / 90 * 18,
                    width: size.width,
                    color: AppColors.customGrey,
                    blurRadius: 4.0,
                    radius: 10,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddding.top * 0.31,
                          vertical: paddding.top * 0.11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Site 1",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Client Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.fadeblue,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ShowCustomModal().showDeleteDialog(
                                    id: 1,
                                    context: context,
                                    height: size.height / 90 * 23,
                                    width: size.width / 2 * 11,
                                    imageheight: size.height / 90 * 6.54,
                                  );
                                },
                                child: Image.asset(
                                  "assets/icons/delete.png",
                                  height: 28,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ShowCustomModal().showArchriveDialog(
                                    id: 1,
                                    context: context,
                                    height: size.height / 90 * 23,
                                    width: size.width / 2 * 11,
                                    imageheight: size.height / 90 * 6.54,
                                  );
                                },
                                child: Image.asset(
                                  "assets/icons/archrive.png",
                                  height: 28,
                                ),
                              )
                            ],
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
                                  text: 'Madhusudhan Ghimire',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.fadeblue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: args['role'] == "Admin"
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.yellow,
              onPressed: () {
                showAddSiteModal();
              },
              child: Icon(
                Icons.add,
                color: AppColors.fadeblue,
              ),
            )
          : Container(),
    );
  }
}
