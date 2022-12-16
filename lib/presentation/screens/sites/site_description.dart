import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/utils/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/sites/sites_bloc.dart';
import '../../../main.dart';
import '../../../utils/routes.dart';
import '../../../utils/validator.dart';
import '../../includes/custom_box.dart';

class SiteDescription extends StatefulWidget {
  const SiteDescription({super.key});

  @override
  State<SiteDescription> createState() => _SiteDescriptionState();
}

class _SiteDescriptionState extends State<SiteDescription> {
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = "";
  String sid = "";
  String sitename = "";
  String sitelocation = "";
  String clientname = "";
  String phone = "";
  String about = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    int dotposition = 0;
    CarouselController carouselController = CarouselController();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    showEditSiteModal({
      required String sid,
      required String sitename,
      required String sitelocation,
      required String clientname,
      required String phone,
      required String about,
    }) {
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
                      height: size.height / 90 * 53.334,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height / 90 * 1.338,
                              ),
                              Text(
                                "Update Site Info",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.fadeblue),
                              ),
                              SizedBox(
                                height: size.height / 90 * 2.538,
                              ),
                              Container(
                                height: size.height / 90 * 5.44,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.customWhite.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  initialValue: sitename,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    hintText: "Site Name",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    sitename = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Cant Send Empty value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.538,
                              ),
                              Container(
                                height: size.height / 90 * 5.44,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.customWhite.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  initialValue: sitelocation,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    hintText: "Site Location",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    sitelocation = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Cant Send Empty value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.538,
                              ),
                              Container(
                                height: size.height / 90 * 5.44,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.customWhite.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  initialValue: clientname,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    hintText: "Client Name",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    clientname = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Cant Send Empty value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.538,
                              ),
                              Container(
                                height: size.height / 90 * 5.44,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.customWhite.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  initialValue: phone,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    hintText: "Phone",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Cant Send Empty value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.538,
                              ),
                              Container(
                                height: size.height / 90 * 5.44,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.customWhite.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  initialValue: about,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: padding.top * 0.4,
                                    ),
                                    hintText: "About Site",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    about = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Cant Send Empty value";
                                    }
                                    return null;
                                  },
                                ),
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
                                  buttonPadding:
                                      EdgeInsets.only(right: padding.top * 0.4),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      fixedSize: const Size(103, 33),
                                      backgroundColor: AppColors.white,
                                      foregroundColor: AppColors.fadeblue,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  BlocConsumer<SitesBloc, SitesState>(
                                    listener: (context, state) {
                                      if (state is UpdatingSiteState) {
                                        BotToast.showCustomLoading(
                                          toastBuilder: (context) =>
                                              customLoading(size),
                                        );
                                      }
                                      if (state is CompleteUpdatingSiteState) {
                                        BotToast.closeAllLoading();
                                        Navigator.of(context).pop();
                                        BotToast.showText(
                                          text: "Site Information Updated",
                                          contentColor: AppColors.green,
                                        );
                                      }
                                      if (state is FailedUpdatingSiteState) {
                                        BotToast.closeAllLoading();
                                        Navigator.of(context).pop();
                                        BotToast.showText(
                                          text: state.error!,
                                          contentColor: AppColors.red,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize: const Size(103, 33),
                                          backgroundColor: AppColors.yellow,
                                          foregroundColor: AppColors.fadeblue,
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<SitesBloc>(context)
                                              .updateSiteInfo(
                                            sid: sid,
                                            sitename: sitename,
                                            sitelocation: sitelocation,
                                            clientname: clientname,
                                            phone: phone,
                                            sitedesc: about,
                                            supervisor: dropdownvalue,
                                          );
                                        },
                                        child: const Text("Update"),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          title: args['sitename'],
          action: [
            args['role'] == "Admin"
                ? IconButton(
                    onPressed: () {
                      showEditSiteModal(
                        sid: sid,
                        sitename: sitename,
                        sitelocation: sitelocation,
                        clientname: clientname,
                        phone: phone,
                        about: about,
                      );
                    },
                    icon: CircleAvatar(
                      backgroundColor: AppColors.yellow,
                      radius: 18,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.fadeblue,
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(right: padding.top * 0.2),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset("assets/icons/camera.png"),
              ),
            ),
          ],
          bgcolor: AppColors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ).customAppBar(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: padding.top * 0.8),
                    child: snapshot.data!.docs.isEmpty
                        ? Container()
                        : CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index, _) {
                              return snapshot.data!.docs[index]['image'] == null
                                  ? Container()
                                  : PageView(
                                      onPageChanged: (value) {
                                        setState(() {
                                          dotposition = value;
                                        });
                                      },
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: padding.top * 0.2,
                                              vertical: padding.top * 0.2),
                                          decoration: BoxDecoration(
                                            color: AppColors.fadeblue,
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data!.docs[index]['image']),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: size.height / 90 * 15.5,
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
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("sites")
                        .doc(args['sid'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        sid = snapshot.data!['sid'];
                        sitename = snapshot.data!['sitename'];
                        sitelocation = snapshot.data!['sitelocation'];
                        clientname = snapshot.data!['clientname'];
                        phone = snapshot.data!['phone'];
                        about = snapshot.data!['sitedesc'];
                        return Container(
                          height: size.height / 90 * 52,
                          padding: EdgeInsets.symmetric(
                              horizontal: padding.top * 0.8),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height: size.height / 90 * 1.2,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!['sitename']}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width / 2 * 1.4,
                                    child: Text(
                                      "${snapshot.data!['sitelocation']}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
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
                                  "${snapshot.data!['clientname']}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "+977${snapshot.data!['phone']}",
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
                                "About ${snapshot.data!['sitename']}",
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
                                "${snapshot.data!['sitedesc']}",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 90 * 1.2,
                              ),
                              SizedBox(
                                height: size.height / 90 * 25.5,
                                child: GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 3 / 2,
                                  ),
                                  children: [
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
                                        height: size.height / 90 * 6,
                                        width: size.width / 8 * 1.3,
                                        blurRadius: 4,
                                        radius: 15,
                                        shadowColor: AppColors.customWhite,
                                        color: AppColors.white,
                                        horizontalMargin: 0,
                                        verticalMargin: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Iconify(
                                              FluentMdl2.blob_storage,
                                              size: size.height / 90 * 6.2,
                                              color: AppColors.fadeblue,
                                            ),
                                            Text(
                                              "Manage Stocks",
                                              style: TextStyle(
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).customBox(),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(siteEstimation);
                                      },
                                      child: CustomBox(
                                        height: size.height / 90 * 6,
                                        width: size.width / 8 * 1.3,
                                        blurRadius: 4,
                                        radius: 15,
                                        shadowColor: AppColors.customWhite,
                                        color: AppColors.white,
                                        horizontalMargin: 0,
                                        verticalMargin: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Iconify(
                                              Zondicons.currency_dollar,
                                              size: size.height / 90 * 6.2,
                                              color: AppColors.fadeblue,
                                            ),
                                            Text(
                                              "Estimation",
                                              style: TextStyle(
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).customBox(),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            workinprogress,
                                            arguments: {
                                              "sid": args['sid'],
                                              "sitename": args['sitename']
                                            });
                                      },
                                      child: CustomBox(
                                        height: size.height / 90 * 6,
                                        width: size.width / 8 * 1.3,
                                        blurRadius: 4,
                                        radius: 15,
                                        shadowColor: AppColors.customWhite,
                                        color: AppColors.white,
                                        horizontalMargin: 0,
                                        verticalMargin: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Iconify(
                                              Zondicons.inbox_check,
                                              color: AppColors.fadeblue,
                                              size: size.height / 90 * 6,
                                            ),
                                            Text(
                                              "Work in Progress",
                                              style: TextStyle(
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).customBox(),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          orders,
                                          arguments: {
                                            "sid": args['sid'],
                                            "sitename": args['sitename']
                                          },
                                        );
                                      },
                                      child: CustomBox(
                                        height: size.height / 90 * 6,
                                        width: size.width / 8 * 1.3,
                                        blurRadius: 4,
                                        radius: 15,
                                        shadowColor: AppColors.customWhite,
                                        color: AppColors.white,
                                        horizontalMargin: 0,
                                        verticalMargin: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Iconify(
                                              FluentMdl2.reservation_orders,
                                              color: AppColors.fadeblue,
                                              size: size.height / 90 * 6,
                                            ),
                                            Text(
                                              "Manage Orders",
                                              style: TextStyle(
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).customBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
