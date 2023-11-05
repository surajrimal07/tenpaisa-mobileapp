import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/otp_model.dart';
import 'package:paisa/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors_utils.dart';

class StyleView extends StatefulWidget {
  const StyleView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StyleViewState createState() => _StyleViewState();
}

class _StyleViewState extends State<StyleView> {
  final _formKey = GlobalKey<FormState>();
  User user = User('', '', '', '');
  int? _selectedValue; // Add this line

  Future<void> continuesave() async {
    // Map<String, dynamic> dataToPass = {
    //   'name': user.name,
    //   'email': user.email,
    //   'password': user.password,
    //   'hash': '',
    // };

    // final String dataToHash =
    //     '$user.email+$user.password'; // Concatenate email and password
    // final userToken =
    //     sha256.convert(dataToHash.codeUnits).toString(); // Generate the hash
  }

  Future<void> savetokenskip() async {
    //get username and pass here
    //hash it
    //pass it to shared preferenses
    //and navigate to dashboard

    print("hash saved in from style view on skip is ${otp.hash}");
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //error here
    prefs.setString('userToken', otp.hash);

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.dashboardRoute,
      (route) => false,
    );
  }

  Future<void> save() async {
    // var url = Uri.parse("http://192.168.101.6:5000/api/login");
    // var res = await http.post(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'email': user.email,
    //     'password': user.password,
    //   }),
    // );

    // if (res.statusCode == 200) {
    //   CustomToast.showToast("Signin Successful");
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     AppRoute.dashboardRoute,
    //     (route) => false,
    //   );
    // } else {
    //   CustomToast.showToast("Email or password is incorrect");
    // }
    CustomToast.showToast("In Development");
  }

  Otp otp = Otp('', '', '');

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> receivedData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    otp.hash = receivedData['hash'];
    print("Hash recieved from otp view is ${otp.hash}");

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
                      "Your Investment Style",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Tell us about your investment style",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // List of radio buttons
                    Column(
                      children: [
                        RadioListTile<int>(
                          title: Text(
                            'Spend and save',
                            style: GoogleFonts.poppins(),
                          ),
                          value: 1,
                          groupValue: _selectedValue,
                          activeColor: MyColors.btnColor,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20), // Add padding
                          //controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Save for retirement',
                            style: GoogleFonts.poppins(),
                          ),
                          value: 2,
                          groupValue: _selectedValue,
                          activeColor: MyColors.btnColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Financial speculation',
                            style: GoogleFonts
                                .poppins(), // Apply the Google Poppins font
                          ),
                          value: 3,
                          groupValue: _selectedValue,
                          activeColor: MyColors.btnColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Others',
                            style: GoogleFonts
                                .poppins(), // Apply the Google Poppins font
                          ),
                          value: 4,
                          groupValue: _selectedValue,
                          activeColor: MyColors.btnColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 42,
                            width: 120,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 231, 231, 231),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                //save user token, and open dashboard
                                savetokenskip();
                              },
                              child: Text(
                                "Skip",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            height: 42,
                            width: 120,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MyColors.btnColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                //save choice to database
                                // save usertoken to shared preferenses
                              },
                              child: Text(
                                "Continue",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
