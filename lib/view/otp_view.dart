// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';
import 'package:paisa/services/user_services.dart';
import 'package:pinput/pinput.dart';

import '../utils/colors_utils.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<OtpView> {
  Future<void> verify() async {
    try {
      await UserService.verifyOTP(otp.email, otp.otp);
      await Future.delayed(const Duration(seconds: 2)); //delaying for 2 seconds
      CustomToast.showToast("OTP Verified successfully");
      save();
    } catch (error) {
      if (error == 400) {
        CustomToast.showToast("OTP Error");
      } else if (error == 600) {
        CustomToast.showToast("Network error");
      }
    }
  }

  Future<void> resend() async {
    Map<String, dynamic> dataToPass = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
    };

    try {
      await UserService.resendOTP(otp.email);

      await Future.delayed(const Duration(seconds: 2));
      CustomToast.showToast("Please Enter Email OTP");

      Navigator.pushNamed(context, AppRoute.otpRoute, arguments: dataToPass);
    } catch (error) {
      if (error == 400) {
        CustomToast.showToast("Email Exists");
      } else if (error == 600) {
        CustomToast.showToast("Network error $error");
      }
    }
  }

  Future<void> save() async {
    try {
      await UserService.savedata(
          user.name, user.email, user.password, user.phone);

      await Future.delayed(const Duration(seconds: 2)); //delaying for 2 seconds

      CustomToast.showToast("User Created Successfully");
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.invStyle,
        (route) => false,
      );
    } catch (error) {
      if (error == "500") {
        CustomToast.showToast("Server error $error");
      } else if (error == "300") {
        CustomToast.showToast("Token save failed");
      } else {
        CustomToast.showToast("Network error $error");
      }
    }
  }

  User user = User('', '', '', '', '', '');
  Otp otp = Otp('', '', '');

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> receivedData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    user.name = receivedData['name'];
    otp.email = receivedData['email'];
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
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset(
                  'assets/images/blite.png',
                  fit: BoxFit.fitWidth,
                )),
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
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.65, 20, 0, 0),
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
                            CustomToast.showToast("Please wait");
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
