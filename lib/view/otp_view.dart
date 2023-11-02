import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';
import 'package:pinput/pinput.dart';

import '../utils/colors_utils.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<OtpView> {
  //verify otp
  Future<void> verify() async {
    try {
      var url = Uri.parse("http://192.168.101.9:5000/api/otp-verify");

      // Create a map for the request body

      var requestBody = {'email': otp.email, 'hash': otp.hash, 'otp': otp.otp};

      //print(requestBody);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP Verified successfully",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );

        // ignore: use_build_context_synchronously
        save();
        //Navigator.pushNamed(context, AppRoute.otpRoute); // error
      } else {
        Fluttertoast.showToast(
          msg: "OTP error: ${response.statusCode}",
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
    }
  }

//resend otp
  Future<void> resend() async {
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
          msg: "Please Enter Email OTP",
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

  //now do data entry
  Future<void> save() async {
    try {
      var url = Uri.parse("http://192.168.101.9:5000/api/create");

      // Create a map for the request body
      var requestBody = {
        'name': user.name,
        'email': user.email,
        'password': user.password,
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "User Created, proceed to login",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRoute.signinRoute); // error
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

  User user = User('', '', '');
  Otp otp = Otp('', '', '');

  //
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> receivedData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    user.name = receivedData['name'];
    otp.email = receivedData['email'];
    otp.hash = receivedData['hash'];
    user.email = receivedData['email'];
    user.password = receivedData['password'];

    // print(user.name);
    // print(user.email);
    // print(user.password);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    // ignore: unused_local_variable
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    // ignore: unused_local_variable
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Image.asset('assets/images/blite.png', fit: BoxFit.cover),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 140,
                  ),
                  const Text(
                    "10Paisa Email Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please use otp you got in your Email",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 4,
                    showCursor: true,
                    onCompleted: (pin) => otp.otp = pin, //print(pin),
                    //otp.otp = pin,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.btnColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          verify();
                        },
                        child: const Text("Verify Email")),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          "Did not recieve OTP? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            resend();
                          },
                          child: const Text(
                            "Resend OTP",
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
    );
  }
}
