import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/pickimage/pickimage_bloc.dart';
import '../../../bloc/sites/sites_bloc.dart';
import '../../../data/models/sites.dart';
import '../../../main.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/validator.dart';
import '../../includes/appbar.dart';
import '../../includes/custom_phone_field.dart';

import '../../includes/custom_textfield.dart';

class AddSitePage extends StatefulWidget {
  const AddSitePage({super.key});

  @override
  State<AddSitePage> createState() => _AddSitePageState();
}

class _AddSitePageState extends State<AddSitePage> {
  final TextEditingController _sitename = TextEditingController();

  final TextEditingController _sitedes = TextEditingController();

  final TextEditingController _sitelocation = TextEditingController();

  final TextEditingController _clientname = TextEditingController();

  final TextEditingController _phone = TextEditingController();

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          bgcolor: AppColors.white,
          title: "Add Sites",
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: size.height / 90 * 2.3,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      body: BlocListener<DropdownBloc, DropdownState>(
        listener: (context, state) {
          if (state is DropdownUserSelectState) {
            dropdownvalue = state.value!;
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: paddding.top * 0.6),
          child: StreamBuilder<QuerySnapshot>(
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
                            ).customTextField(),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            Container(
                              color: AppColors.customWhite,
                              padding:
                                  EdgeInsets.only(left: paddding.top * 0.3),
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: _sitedes,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText: "Site Description",
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.home,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
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
                            ).customTextField(),
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
                            ).customTextField(),
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
                            ).customPhoneField(),
                            SizedBox(
                              height: size.height / 90 * 1.538,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.customWhite,
                              ),
                              child: DropdownButtonFormField2(
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    Validator.getBlankFieldValidator(
                                        value.toString(),
                                        "Supervisor for site"),
                                isExpanded: true,
                                hint: const Text("Assign a Supervisior"),
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
                                      color: AppColors.blue,
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
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                  icon: CircleAvatar(
                                                    radius: 11,
                                                    backgroundColor:
                                                        AppColors.red,
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 8,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
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
                            BlocBuilder<PickimageBloc, PickimageState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        fixedSize: const Size(103, 33),
                                        foregroundColor: AppColors.blue,
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
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
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
                                          BotToast.showText(text: state.error!);
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
                                                fixedSize: const Size(103, 33),
                                                backgroundColor:
                                                    AppColors.yellow,
                                                foregroundColor: AppColors.blue,
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
                                                      sitename: _sitename.text,
                                                      sitedesc: _sitedes.text,
                                                      sitelocation:
                                                          _sitelocation.text,
                                                      clientname:
                                                          _clientname.text,
                                                      phone: _phone.text,
                                                      supervisor: dropdownvalue,
                                                    );
                                                    BlocProvider.of<SitesBloc>(
                                                            context)
                                                        .addSite(
                                                      siteModel,
                                                      siteimages,
                                                    );
                                                    siteimages.clear();
                                                    images.clear();
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
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
                  return Builder(
                    builder: (context) => customLoading(size),
                  );
                }
              }),
        ),
      ),
    );
  }
}
