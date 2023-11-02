import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';

import '../utils/colors_utils.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Future<void> save() async {
    try {
      var url = Uri.parse("http://192.168.101.9:5000/api/otp-login"); //create

      // Create a map for the request body
      var requestBody = {'email': otp.email};

      Map<String, dynamic> dataToPass = {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'hash': '',
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var result = response.body;
        Map<String, dynamic> parsedResponse = json.decode(result);
        String dataValue = parsedResponse['data'];
        dataToPass['hash'] = dataValue;

        Fluttertoast.showToast(
          msg: "Please verify your Email",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRoute.otpRoute,
            arguments: dataToPass); // error
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: "Email Exists : ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Server error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network error: $e",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      //print("Network error: $e");
    }
  }

  Otp otp = Otp('', '', '');
  User user = User('', '', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the Stack in a SingleChildScrollView
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
                      "Sign Up to 10Paisa",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Create a new 10Paisa account",
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
                        controller: TextEditingController(text: user.name),
                        onChanged: (value) {
                          user.name = value;
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Name cannot be empty';
                          }
                          return null; //if error delete thiss
                        },
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.account_circle_rounded,
                            color: MyColors.btnColor,
                          ),
                          hintText: 'Enter Name',
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
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                          otp.email = value;
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Email cannot be empty';
                          } else if (RegExp(
                                  r"^[a-zA-Z0.9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.email,
                            color: MyColors.btnColor,
                          ),
                          hintText: 'Enter Email',
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
                        //obscureText: true,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.vpn_key,
                            color: MyColors.btnColor,
                          ),
                          hintText: 'Enter Password',
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
                      padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.btnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              save();
                            } else {
                              //print("not ok");
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoute.signinRoute);
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
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
      ),
    );
  }
}
