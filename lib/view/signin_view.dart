import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/user_model.dart';

import '../app/snackbar/snackbar_snackbar.dart';
import '../utils/colors_utils.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SigninView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool rememberMe = false;
  //String errorMessage = ''; // Variable to store error message.

  Future save() async {
    var url = Uri.parse(
        "http://192.168.101.6:5000/api/login"); //replace this with localhost ip address
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user.email,
        'password': user.password,
      }),
    );

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Signin Successful",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.dashboardRoute,
        (route) => false,
      );
    } else {
      CustomSnackbar.showSnackbar(context, "Email or password is incorrect");

      //CustomToast.showToast("Email or password is incorrect");
    }
  }

  User user = User('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Image.asset('assets/images/blite.png', fit: BoxFit.cover),
          ),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 230,
                  ),
                  Text(
                    "Login to 10Paisa",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Please enter your Email and Password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: MyColors.subTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.email),
                      onChanged: (value) {
                        user.email = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email cannot be empty';
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return null;
                        } else {
                          return 'Enter valid email';
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.alternate_email_outlined,
                          color: MyColors.btnColor,
                        ),
                        hintText: 'Email',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: MyColors.btnColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: MyColors.btnColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      onChanged: (value) {
                        user.password = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.password_outlined,
                          color: MyColors.btnColor,
                        ),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: MyColors.btnColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: MyColors.btnColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyColors
                                .btnColor, // Change the color to your preference
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //padding: const EdgeInsets.fromLTRB(40, 0, 35, 0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: MyColors.btnColor,
                              value: rememberMe,
                              onChanged: (newValue) {
                                setState(() {
                                  rememberMe = newValue ?? false;
                                });
                              },
                            ),
                            Text(
                              "Remember me",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(), // Adds spacing between Remember me and Forgot Password
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.forgotRoute); // error
                          },
                          child: Text(
                            "Forgot Password",
                            style: GoogleFonts.poppins(
                              color: MyColors.btnColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //new code

                  Padding(
                    padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                    child: SizedBox(
                      height: 50,
                      width: 400,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: MyColors.btnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            save();
                          } else {
                            //print("Empty Credentials passed");
                            CustomToast.showToast("Error Occured");
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.fromLTRB(85, 15, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.signupRoute); //error
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              color: MyColors.btnColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
