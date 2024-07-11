import 'package:bot_toast/bot_toast.dart';
import 'package:construction/bloc/auth/auth_bloc.dart';
import 'package:construction/bloc/dropdown/dropdown_bloc.dart';

import 'package:construction/data/models/users.dart';
import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_textfield.dart';
import 'package:construction/utils/app_colors.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _fullname = TextEditingController();

  final List<String> roles = ["Admin", "Supervisor", "Engineer"];
  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: () {
        FocusScopeNode cf = FocusScope.of(context);
        if (!cf.hasPrimaryFocus) {
          cf.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height / 90 * 8.5),
          child: CustomAppbar(
            title: "Add a New User",
            bgcolor: AppColors.white,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padding.top * 0.4),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 90 * 2.51,
                      ),
                      CustomTextField(
                        controller: _fullname,
                        hintText: "Fullname",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _email,
                        hintText: "Email",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _password,
                        hintText: "Password",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _phone,
                        hintText: "PhoneNumber",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _address,
                        hintText: "Address",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ).customTextField(),
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
                              hint: const Text("Select Role"),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 90 * 1.51,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is EmailSignUpLoadingState) {
                      BotToast.showCustomLoading(
                        toastBuilder: (cancelFunc) {
                          return customLoading(size);
                        },
                      );
                    }
                    if (state is EmailSignUpCompletedState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                          text: "New User Added", contentColor: Colors.green);
                    }
                    if (state is UsernameAlreadyExistState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: "Username Already Exist",
                        contentColor: Colors.green,
                      );
                    }
                    if (state is EmailAlreadyExistState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: "Email Alredy Exist",
                        contentColor: Colors.redAccent,
                      );
                    }
                    if (state is EmailSignUpFailedState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: state.error,
                        contentColor: Colors.redAccent,
                      );
                    }
                    if (state is WeakPasswordState) {
                      BotToast.closeAllLoading();
                      BotToast.showText(
                        text: "Password too Weak",
                        contentColor: Colors.redAccent,
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(
                          size.width / 2 * 1.85,
                          size.height / 90 * 4.41,
                        ),
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserModel userModel = UserModel(
                            email: _email.text,
                            fullname: _fullname.text,
                            phone: _phone.text,
                            password: _password.text,
                            address: _address.text,
                            role: dropdownvalue,
                          );
                          BlocProvider.of<AuthBloc>(context)
                              .signUpWithEmail(userModel);
                        }
                      },
                      child: const Text("Save"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
