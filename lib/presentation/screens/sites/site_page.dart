import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/presentation/includes/custom_phone_field.dart';
import 'package:construction/presentation/includes/custom_textarea.dart';
import 'package:construction/presentation/includes/custom_textfield.dart';
import 'package:construction/presentation/includes/show_modal.dart';
import 'package:construction/utils/routes.dart';
import 'package:construction/utils/validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_colors.dart';
import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/pickimage/pickimage_bloc.dart';
import '../../../bloc/sites/sites_bloc.dart';
import '../../../data/models/sites.dart';
import '../../../main.dart';

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
  List<String> imageurl = [];
  final _formKey = GlobalKey<FormState>();
  List<String> images = [];
  List<XFile> siteimages = [];
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
        builder: (context) => BlocListener<DropdownBloc, DropdownState>(
          listener: (context, state) {
            if (state is DropdownUserSelectState) {
              dropdownvalue = state.value!;
            }
          },
          child: AlertDialog(
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
                                width: size.width,
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
                              CustomTextArea(
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
                                width: size.width,
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
                                width: size.width,
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                size: size.height / 90 * 5.44,
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.538,
                              ),
                              CustomPhoneField(
                                controller: _phone,
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
                                  color: AppColors.customWhite.withOpacity(0.6),
                                ),
                                child: DropdownButtonFormField2(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) =>
                                      Validator.getBlankFieldValidator(
                                          value.toString(),
                                          "Supervisor for site"),
                                  isExpanded: true,
                                  hint: const Text("Assign a Supervisior"),
                                  offset: Offset(0, -size.height / 90 * 2.44),
                                  buttonPadding: EdgeInsets.only(
                                      right: paddding.top * 0.4),
                                  items: snapshot.data!.docs
                                      .map<DropdownMenuItem>((supervisor) {
                                    return DropdownMenuItem(
                                      value: "${supervisor['fullname']}",
                                      child: Text(
                                        "${supervisor['fullname']}",
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    BlocProvider.of<DropdownBloc>(context)
                                        .onUserSelectDropdown(
                                            newValue.toString());
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
                                  builder: (context, state) => state
                                              .siteimage !=
                                          null
                                      ? GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                                        File(state
                                                            .siteimage![index]
                                                            .path),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: const Alignment(
                                                      1.8, -2.8),
                                                  child: IconButton(
                                                    icon: const CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor:
                                                          Colors.red,
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 5,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  PickimageBloc>(
                                                              context)
                                                          .removeImage(
                                                        state.siteimage!,
                                                        index,
                                                      );
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
                              BlocBuilder<PickimageBloc, PickimageState>(
                                builder: (context, state) {
                                  return Row(
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
                                          _clientname.clear();
                                          _phone.clear();
                                          _sitelocation.clear();
                                          _sitedes.clear();
                                          _sitename.clear();
                                          if (state.siteimage != null) {
                                            state.siteimage!.clear();
                                          }
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      BlocConsumer<SitesBloc, SitesState>(
                                        listener: (context, state) {
                                          if (state is LoadingSiteState) {
                                            BotToast.showCustomLoading(
                                              toastBuilder: (cancelFunc) {
                                                return customLoading(size);
                                              },
                                            );
                                          }
                                          if (state is LoadingCompleteEvent) {
                                            BotToast.closeAllLoading();
                                          }
                                          if (state is AddedSiteState) {
                                            BotToast.showText(
                                                text: state.message!);
                                            Navigator.of(context).pop();
                                            BotToast.closeAllLoading();
                                          }
                                          if (state is FailedSiteState) {
                                            BotToast.showText(
                                                text: state.error!);
                                            BotToast.closeAllLoading();
                                          }
                                        },
                                        builder: (context, state) {
                                          return BlocConsumer<SitesBloc,
                                              SitesState>(
                                            listener: (context, state) {
                                              if (state is LoadingSiteState) {
                                                BotToast.showCustomLoading(
                                                  toastBuilder: (cancelFunc) {
                                                    return customLoading(size);
                                                  },
                                                );
                                                ;
                                              }
                                              if (state is CompletedSiteState) {
                                                BotToast.closeAllLoading();
                                                Navigator.of(context).pop();
                                                BotToast.showText(
                                                  text: "Site Added",
                                                  contentColor: Colors.green,
                                                );
                                              }
                                              if (state is FailedSiteState) {
                                                BotToast.closeAllLoading();
                                                BotToast.showText(
                                                  text: state.error!,
                                                  contentColor: Colors.red,
                                                );
                                              }
                                            },
                                            builder: (context, state) {
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  fixedSize:
                                                      const Size(103, 33),
                                                  backgroundColor:
                                                      AppColors.yellow,
                                                  foregroundColor:
                                                      AppColors.fadeblue,
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (dropdownvalue.isEmpty) {
                                                      BotToast.showText(
                                                        text:
                                                            "Please Assign a Supervisor",
                                                        contentColor:
                                                            AppColors.red,
                                                      );
                                                    } else {
                                                      SiteModel siteModel =
                                                          SiteModel(
                                                        sitename:
                                                            _sitename.text,
                                                        sitedesc: _sitedes.text,
                                                        sitelocation:
                                                            _sitelocation.text,
                                                        clientname:
                                                            _clientname.text,
                                                        phone: _phone.text,
                                                        supervisor:
                                                            dropdownvalue,
                                                      );
                                                      BlocProvider.of<
                                                                  SitesBloc>(
                                                              context)
                                                          .addSite(
                                                        siteModel,
                                                        siteimages,
                                                      );
                                                    }
                                                  }
                                                },
                                                child: const Text("Save"),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
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
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              title: "Sites",
              bgcolor: AppColors.white,
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
              stream:
                  FirebaseFirestore.instance.collection("sites").snapshots(),
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
                                    onPressed: () {
                                      showAddSiteModal();
                                    },
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
                                Navigator.of(context)
                                    .pushNamed(siteDesc, arguments: {
                                  "sid": snapshot.data!.docs[index]['sid'],
                                  "sitename": snapshot.data!.docs[index]
                                      ['sitename'],
                                  "sitedesc": snapshot.data!.docs[index]
                                      ['sitedesc'],
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
                                shadowColor: AppColors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: paddding.top * 0.31,
                                      vertical: paddding.top * 0.11),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['clientname'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.fadeblue,
                                            ),
                                          ),
                                          args['role'] == "Admin"
                                              ? BlocConsumer<SitesBloc,
                                                  SitesState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is LoadingDeleteSiteState) {
                                                      BotToast
                                                          .showCustomLoading(
                                                        toastBuilder:
                                                            (cancelFunc) {
                                                          return customLoading(
                                                              size);
                                                        },
                                                      );
                                                      ;
                                                    }
                                                    if (state
                                                        is LoadingDeleteCompleteState) {
                                                      BotToast
                                                          .closeAllLoading();
                                                      BotToast.showText(
                                                        text:
                                                            " Delete ${snapshot.data!.docs[index]['sitename']} Site",
                                                        contentColor:
                                                            Colors.green,
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                    if (state
                                                        is FailedDeleteSiteState) {}
                                                  },
                                                  builder: (context, state) {
                                                    return InkWell(
                                                      onTap: () async {
                                                        QuerySnapshot
                                                            siteimages =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "sites")
                                                                .doc(snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['sid'])
                                                                .collection(
                                                                    "siteimages")
                                                                .where("sid",
                                                                    isEqualTo: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        ['sid'])
                                                                .get();
                                                        imageurl.clear();
                                                        for (int i = 0;
                                                            i <
                                                                siteimages.docs
                                                                    .length;
                                                            i++) {
                                                          imageurl.add(
                                                              siteimages.docs[i]
                                                                  ['image']);
                                                        }

                                                        ShowCustomModal()
                                                            .showDeleteDialog(
                                                          id: snapshot.data!
                                                                  .docs[index]
                                                              ['sid'],
                                                          context: context,
                                                          height: size.height /
                                                              90 *
                                                              23,
                                                          width: size.width /
                                                              2 *
                                                              11,
                                                          imageurl: imageurl,
                                                        );
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/delete.png",
                                                        height: 28,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                          args['role'] == "Admin"
                                              ? InkWell(
                                                  onTap: () {
                                                    ShowCustomModal()
                                                        .showArchriveDialog(
                                                      id: snapshot.data!
                                                          .docs[index]['sid'],
                                                      context: context,
                                                      height:
                                                          size.height / 90 * 23,
                                                      width:
                                                          size.width / 2 * 11,
                                                      imageheight: size.height /
                                                          90 *
                                                          6.54,
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    "assets/icons/archrive.png",
                                                    height: 28,
                                                  ),
                                                )
                                              : Container()
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
                                ),
                              ),
                            );
                          },
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
