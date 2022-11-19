import 'package:construction/presentation/includes/appbar.dart';
import 'package:construction/presentation/includes/custom_textfield.dart';
import 'package:construction/utils/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _lastname = TextEditingController();

  final List<String> roles = ["Supervisor", "Engineer"];
  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: padding.top * 0.4),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 90 * 5.51,
                    ),
                    CustomTextField(
                      controller: _firstname,
                      hintText: "Firstname",
                      size: size.height / 90 * 5.44,
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    CustomTextField(
                      controller: _lastname,
                      hintText: "Lastname",
                      size: size.height / 90 * 5.44,
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    CustomTextField(
                      controller: _email,
                      hintText: "Email",
                      size: size.height / 90 * 5.44,
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    CustomTextField(
                      controller: _phone,
                      hintText: "PhoneNumber",
                      size: size.height / 90 * 5.44,
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    CustomTextField(
                      controller: _address,
                      hintText: "Address",
                      size: size.height / 90 * 5.44,
                    ),
                    SizedBox(
                      height: size.height / 90 * 1.51,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.customGrey.withOpacity(0.6),
                      ),
                      child: DropdownButtonFormField2(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        buttonPadding:
                            EdgeInsets.symmetric(horizontal: padding.top * 0.4),
                        hint: const Text("Select Role"),
                        offset: Offset(0, -size.height / 90 * 2.44),
                        items: roles.map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height / 90 * 1.51,
            ),
            ElevatedButton(
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
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
