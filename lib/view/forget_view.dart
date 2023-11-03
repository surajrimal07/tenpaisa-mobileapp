import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';

import '../utils/colors_utils.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<ForgotView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool rememberMe = false;
  bool mailverified = false;
  bool otpverified = false;
  String btntext = "Verify Email";

//verify mail logic
// push email from here
// make seperate recover pass endpoint
// get that email and verify of that email exists in the databse
// if email exists, send otp

//verify otp logic
//get email and otp from here
// send the otp to recover pass end point
// if otp verified (status 200)
// enable passwrd textfield

//reset password logic
//if above all opreations are done and true
//send password mail and otp data from here to endpoint
//after 200 success, send user to login page with a toast

  Future verifymail() async {
    var url = Uri.parse(
        "http://192.168.101.6:5000/api/forget"); //replace this with localhost ip address

    // print("We are here at verify mail");
    // print(mailverified);
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': otp.email,
      }),
    );

    if (res.statusCode == 200) {
      //print("enabling otp button 64");

      Fluttertoast.showToast(
        msg: "Check Email for OTP",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      setState(() {
        mailverified = true; // This will show the OTP field
      });

      var result = res.body;

      Map<String, dynamic> parsedResponse = json.decode(result);
      String dataValue = parsedResponse['hash'];
      otp.hash = dataValue;

      //print("enabling otp button");
    } else if (res.statusCode == 404) {
      Fluttertoast.showToast(
        msg: "Email Not Found",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future verifyotp() async {
    // print(otp.email);
    // print(otp.otp);
    // print(otp.hash);

    //print(mailverified);
    var url = Uri.parse(
        "http://192.168.101.6:5000/api/otp-verify"); //replace this with localhost ip address

    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': otp.email,
        'otp': otp.otp,
        'hash': otp.hash,
      }),
    );

    if (res.statusCode == 200) {
      setState(() {
        otpverified = true; // This will show the OTP field
      });

      Fluttertoast.showToast(
        msg: "OTP Verified",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "OTP Error : VO",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future updatepassword() async {
    var url = Uri.parse(
        "http://192.168.101.6:5000/api/updatepasswd"); //replace this with localhost ip address
    var res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': otp.email,
        'newpass': user.password,
      }),
    );

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Password Updated",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.signinRoute,
        (route) => false,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error occured : UP",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  User user = User('', '', '');
  Otp otp = Otp('', '', '');

  @override
  Widget build(BuildContext context) {
    print("inside 117");
    print(mailverified);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child:
                    Image.asset('assets/images/blite.png', fit: BoxFit.cover),
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
                        "Password recovery",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 28,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Please enter your 10Paisa Email",
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
                          controller: TextEditingController(text: otp.email),
                          onChanged: (value) {
                            otp.email = value;
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

                      Visibility(
                        visible: mailverified,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: TextEditingController(text: otp.otp),
                            onChanged: (value) {
                              //user.password = value;
                              otp.otp = value;
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'OTP cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.numbers_outlined,
                                color: MyColors.btnColor,
                              ),
                              hintText: 'OTP',
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
                      ),
                      Visibility(
                        visible: otpverified,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller:
                                TextEditingController(text: user.password),
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
                      ),

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
                                if (mailverified == false) {
                                  verifymail();
                                } else if (mailverified == true &&
                                    otpverified == false) {
                                  verifyotp();
                                } else if (mailverified == true &&
                                    otpverified == true) {
                                  updatepassword();
                                }
                                // }
                              } else {
                                //print("Empty Credentials passed");
                                Fluttertoast.showToast(
                                  msg: "Error Occured",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 14.0,
                                );
                              }
                            },
                            child: Text(
                              // mailverified == true? "Verify OTP"
                              //     : otpverified == true? "Save Password": "Verify Email",

                              otpverified
                                  ? "Update Password"
                                  : (mailverified
                                      ? "Verify OTP"
                                      : "Verify Email"),
                              // btntext,
                              //"Verify Email",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.fromLTRB(125, 15, 0, 0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoute.signinRoute); //error
                              },
                              child: Text(
                                " Sign In ",
                                style: GoogleFonts.poppins(
                                  color: MyColors.btnColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              " or  ",
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
