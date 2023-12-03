import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/user_model.dart';
import 'package:paisa/services/user_services.dart';

import '../utils/colors_utils.dart';

class StyleView extends StatefulWidget {
  const StyleView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StyleViewState createState() => _StyleViewState();
}

class _StyleViewState extends State<StyleView> {
  final _formKey = GlobalKey<FormState>();
  User user = User('', '', '', '', '', '');
  int?
      _selectedValue; // Add this line  // make it int? if we are passing model (like 1,2,3,)

  Future<void> save() async {
    String valueAsString = _selectedValue.toString();

    try {
      await UserService.updateUser("style", valueAsString, "");
      CustomToast.showToast("Saved Successfully");
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.dashboardRoute,
        (route) => false,
      );
    } catch (error) {
      if (error == "400") {
        CustomToast.showToast("Failed to save token");
      } else {
        CustomToast.showToast("error occured $error");
      }
    }
  }

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
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    'assets/images/blite.png',
                    fit: BoxFit.fitWidth,
                  )),
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
                      height: 3,
                    ),
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
                            style: GoogleFonts.poppins(),
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
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.65, 5, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoute.dashboardRoute,
                                  (route) => false,
                                );
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
                                if (_selectedValue != null) {
                                  save();
                                } else {
                                  CustomToast.showToast("Please select");
                                }
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
