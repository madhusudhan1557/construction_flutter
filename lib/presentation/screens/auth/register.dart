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
          preferredSize: Size(size.width, size.height / 90 * 7.5),
          child: CustomAppbar(
            title: "Add a New User",
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
          ),
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
                        height: size.height / 90 * 5.51,
                      ),
                      CustomTextField(
                        controller: _fullname,
                        hintText: "Fullname",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _email,
                        hintText: "Email",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _password,
                        hintText: "Password",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _phone,
                        hintText: "PhoneNumber",
                        size: size.height / 90 * 5.44,
                        width: size.width,
                      ),
                      SizedBox(
                        height: size.height / 90 * 1.51,
                      ),
                      CustomTextField(
                        controller: _address,
                        hintText: "Address",
                        size: size.height / 90 * 5.44,
                        width: size.width,
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
                              color: AppColors.customWhite.withOpacity(0.6),
                            ),
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              hint: const Text("Select Role"),
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
                                dropdownvalue = newValue.toString();
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
                        foregroundColor: AppColors.fadeblue,
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
