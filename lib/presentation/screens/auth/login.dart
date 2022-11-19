import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/hidepassword/hidepassword_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/validator.dart';
import '../../includes/custom_clipper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController usernameController =
      TextEditingController(text: "madhu@test.com");
  TextEditingController passwordController =
      TextEditingController(text: "madhu123");
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool hidepassword = true;
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
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipPath(
                clipper: CustomCurve(),
                child: Container(
                  color: AppColors.fadeblue,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.grey[10],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/akar.png",
                        width: size.width / 1.22,
                        height: size.height / 20 * 2.334,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.fadeblue,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height / 90 * 1.88,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: padding.top),
                              child: TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    "assets/icons/user.png",
                                    height: 24,
                                    color: AppColors.fadeblue,
                                  ),
                                ),
                                validator: (value) =>
                                    Validator.getEmailValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.88,
                            ),
                            BlocConsumer<HidepasswordCubit, HidepasswordState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: padding.top),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: state.hidepassword,
                                    decoration: InputDecoration(
                                      prefixIcon: Image.asset(
                                        "assets/icons/password.png",
                                        height: 24,
                                        color: AppColors.fadeblue,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: state.hidepassword
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: AppColors.fadeblue,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: AppColors.fadeblue,
                                              ),
                                        onPressed: () {
                                          BlocProvider.of<HidepasswordCubit>(
                                                  context)
                                              .hidepassword(state.hidepassword);
                                        },
                                      ),
                                    ),
                                    validator: (value) =>
                                        Validator.getPasswordValidator(value),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: size.height / 90 * 0.88,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: padding.top * 0.6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: AppColors.fadeblue,
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: AppColors.fadeblue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Forgot Password ?",
                                      style: TextStyle(
                                        color: AppColors.fadeblue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.88,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.fadeblue,
                                fixedSize:
                                    Size(size.width / 1.12, size.height / 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {}
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 90 * 1.88,
                            ),
                            Image.asset("assets/icons/vert_line.png"),
                            Text(
                              "Or",
                              style: TextStyle(color: AppColors.fadeblue),
                            ),
                            Image.asset("assets/icons/vert_line.png"),
                            SizedBox(
                              height: size.height / 90 * 1.88,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.customGrey,
                                fixedSize: Size(
                                  size.width / 1.12,
                                  size.height / 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/gmail.png"),
                                  SizedBox(
                                    width: size.width / 60 * 1.88,
                                  ),
                                  Text(
                                    "Sign in with Gmail",
                                    style: TextStyle(color: AppColors.fadeblue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
