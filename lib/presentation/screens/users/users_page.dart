import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/main.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_box.dart';
import 'package:construction/utils/app_colors.dart';
import 'package:construction/utils/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

import '../../../bloc/dropdown/dropdown_bloc.dart';
import '../../../bloc/users/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> roles = ["Admin", "Supervisor", "Engineer"];
  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    showEditUserModal(
        String uid, String fullname, String phone, String address) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: SizedBox(
            height: size.height / 90 * 45,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 90 * 2.51,
                    ),
                    Text(
                      "Update User Info",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.fadeblue),
                    ),
                    SizedBox(
                      height: size.height / 90 * 2.51,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: fullname,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                          hintText: "Fullname",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          fullname = value;
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
                      height: size.height / 90 * 1.51,
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
                          if (value.length != 10) {
                            return "Phone number is invalid";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    Container(
                      height: size.height / 90 * 5.44,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        initialValue: address,
                        decoration: InputDecoration(
                          hintText: "Address",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding.top * 0.4,
                          ),
                        ),
                        onChanged: (value) {
                          address = value;
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
                      height: size.height / 90 * 1.51,
                    ),
                    BlocConsumer<DropdownBloc, DropdownState>(
                      listener: (context, state) {
                        if (state is DropdownUserSelectState) {
                          dropdownvalue = state.value!;
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.customWhite.withOpacity(0.6),
                          ),
                          child: DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            buttonPadding: EdgeInsets.symmetric(
                                horizontal: padding.top * 0.2),
                            hint: const Text("Select Role (Optional)"),
                            offset: Offset(0, -size.height / 90 * 2.44),
                            items: roles.map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              BlocProvider.of<DropdownBloc>(context)
                                  .onUserSelectDropdown(newValue.toString());
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height / 90 * 3.8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        BlocConsumer<UsersBloc, UsersState>(
                          listener: (context, state) {
                            if (state is UpdatingUserState) {
                              BotToast.showCustomLoading(
                                toastBuilder: (context) => customLoading(size),
                              );
                            }
                            if (state is CompleteUpdatingUserState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: "User Information Updated",
                                contentColor: AppColors.green,
                              );
                            }
                            if (state is FailedUpdatingUserState) {
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
                                BlocProvider.of<UsersBloc>(context)
                                    .updateUserInfo(
                                  uid,
                                  fullname,
                                  phone,
                                  address,
                                  dropdownvalue,
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
          ),
        ),
      );
    }

    showDeleteDialog(String uid) {
      return showDialog(
          context: context,
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                width: size.width,
                height: size.height / 90 * 23,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: size.width / 8.2,
                      backgroundColor: AppColors.red,
                      child: Iconify(
                        FluentMdl2.delete,
                        size: size.height / 90 * 6.76,
                        color: AppColors.white,
                      ),
                    ),
                    const Text(
                      "Are you sure you want to Delete ?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        BlocConsumer<UsersBloc, UsersState>(
                          listener: (context, state) {
                            if (state is DeletingUserState) {
                              BotToast.showCustomLoading(
                                toastBuilder: (context) => customLoading(size),
                              );
                            }
                            if (state is CompleteDeletingUserState) {
                              BotToast.closeAllLoading();
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: "User Deleted",
                                contentColor: AppColors.green,
                              );
                            }
                            if (state is FailedDeletingUserState) {
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
                                backgroundColor: AppColors.red,
                                foregroundColor: AppColors.white,
                              ),
                              onPressed: () {
                                BlocProvider.of<UsersBloc>(context)
                                    .deleteUsers(uid);
                              },
                              child: const Text("Delete"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          bgcolor: AppColors.white,
          title: "Avialable Users",
          action: [
            Padding(
              padding: EdgeInsets.only(right: padding.top * 0.4),
              child: CircleAvatar(
                radius: 21,
                backgroundColor: AppColors.yellow,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(register);
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppColors.fadeblue,
                  ),
                ),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.fadeblue,
            ),
          ),
        ).customAppBar(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CustomBox(
                    height: size.height / 90 * 15.3,
                    width: size.width,
                    radius: 15,
                    blurRadius: 4.0,
                    shadowColor: AppColors.customWhite,
                    color: AppColors.white,
                    horizontalMargin: padding.top * 0.3,
                    verticalMargin: padding.top * 0.2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: padding.top * 0.4),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height / 90 * 1.1),
                              Text(
                                snapshot.data!.docs[index]['fullname'],
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height / 90 * 1.1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['phone'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomBox(
                                    height: size.height / 90 * 2.44,
                                    width: size.width / 3.86,
                                    radius: 15,
                                    blurRadius: 4.0,
                                    shadowColor: AppColors.customWhite,
                                    color: snapshot.data!.docs[index]['role'] ==
                                            "Admin"
                                        ? AppColors.green
                                        : snapshot.data!.docs[index]['role'] ==
                                                "Supervisor"
                                            ? AppColors.fadeblue
                                            : Colors.deepOrangeAccent,
                                    horizontalMargin: 0,
                                    verticalMargin: 0,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]['role'],
                                        style:
                                            TextStyle(color: AppColors.white),
                                      ),
                                    ),
                                  ).customBox(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        showEditUserModal(
                                          snapshot.data!.docs[index]['uid'],
                                          snapshot.data!.docs[index]
                                              ['fullname'],
                                          snapshot.data!.docs[index]['phone'],
                                          snapshot.data!.docs[index]['address'],
                                        );
                                      },
                                      icon: Iconify(
                                        FluentMdl2.edit,
                                        color: AppColors.grey,
                                        size: size.height / 90 * 2.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height / 90 * 1.1),
                              Text(
                                snapshot.data!.docs[index]['address'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    showDeleteDialog(
                                      snapshot.data!.docs[index]['uid'],
                                    );
                                  },
                                  icon: Iconify(
                                    FluentMdl2.delete,
                                    color: AppColors.red,
                                    size: size.height / 90 * 2.3,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Iconify(
                                    FluentMdl2.archive,
                                    color: AppColors.fadeblue,
                                    size: size.height / 90 * 2.3,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ).customBox();
                },
              ),
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
