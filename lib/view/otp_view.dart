import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors_utils.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<OtpView> {
//save token
  Future<void> savetoken(String usrtoken1) async {
    try {
      var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/savetkn");

      var requestBody = {'email': otp.email, 'token': usrtoken1};

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Token Saved");

        SharedPreferences prefs =
            await SharedPreferences.getInstance(); //error here
        prefs.remove('userToken');
        prefs.setString('userToken', usrtoken1);

        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.invStyle, //AppRoute.signinRoute,
            (route) => false,
            arguments: {'hash': usrtoken1, 'email': user.email});
      } else {
        CustomToast.showToast("Token failed to save");
      }
    } catch (e) {
      CustomToast.showToast("Token error");
    }
  }

  //verify otp
  Future<void> verify() async {
    try {
      var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/otp-verify");

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
        CustomToast.showToast("OTP Verified successfully");

        // ignore: use_build_context_synchronously
        save();
        //Navigator.pushNamed(context, AppRoute.otpRoute); // error
      } else {
        CustomToast.showToast("OTP Expired: ${response.statusCode}");
      }
    } catch (e) {
      CustomToast.showToast("Network error: $e");
    }
  }

//resend otp
  Future<void> resend() async {
    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/otp-login"); //create

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

        CustomToast.showToast("Please Enter Email OTP");

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRoute.otpRoute,
            arguments: dataToPass); // error
      } else if (response.statusCode == 400) {
        CustomToast.showToast("Email Exists : ${response.statusCode}");
      } else {
        CustomToast.showToast("Server error: ${response.statusCode}");
      }
    } catch (e) {
      CustomToast.showToast("Network error: $e");
      //print("Network error: $e");
    }
  }

  //now do data entry
  Future<void> save() async {
    try {
      var url = Uri.parse("${ServerConfig.SERVER_ADDRESS}/api/create");

      // Create a map for the request body
      var requestBody = {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'phone': user.phone,
      };

      //creating concept of session token and user token
      //session token is created during login, it checks if token is there or not to function
      //the app, also

      // final String dataToHash =
      //     '$user.email+$user.password'; // Concatenate email and password
      // final hashtopass =
      //     sha256.convert(dataToHash.codeUnits).toString(); // Generate the hash

      final key = utf8.encode('${user.email}${user.password}');
      final hmacSha256 = Hmac(sha256, key);
      final digest = hmacSha256.convert(Uint8List.fromList(key));
      final userToken1 = digest.toString();

      print("Fresh token generated is : $userToken1");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("User Created Successfully");

        savetoken(userToken1);

        // Navigator.pushNamedAndRemoveUntil(context, AppRoute.invStyle,
        //     arguments: dataToPass);
      } else if (response.statusCode == 400) {
        CustomToast.showToast("Email Exists : ${response.statusCode}");
      } else {
        CustomToast.showToast("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      CustomToast.showToast("Network error: $e");
    }
  }

  User user = User('', '', '', '', '', '');
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
    user.phone = receivedData['phone'];

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
                  Text(
                    "10Paisa Email Verification",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please use otp you got in your Email",
                    style: GoogleFonts.poppins(
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
                      width: 200,
                      height: 45,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MyColors.btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            verify();
                          },
                          child: Text("Verify Email",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                              )))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "Did not recieve OTP? ",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            resend();
                          },
                          child: Text(
                            "Resend OTP",
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
    );
  }
}
