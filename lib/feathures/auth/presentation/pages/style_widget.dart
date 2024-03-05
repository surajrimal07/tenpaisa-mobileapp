import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

class StyleView extends ConsumerStatefulWidget {
  const StyleView({super.key});

  @override
  StyleViewState createState() => StyleViewState();
}

class StyleViewState extends ConsumerState<StyleView> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StyleStrings.option1,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      StyleStrings.option2,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Sizes.dynamicHeight(1)),
                    Column(
                      children: [
                        RadioListTile<int>(
                          title: Text(
                            StyleStrings.option3,
                            style: GoogleFonts.poppins(),
                          ),
                          value: 1,
                          groupValue: _selectedValue,
                          activeColor: AppColors.primaryColor,
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
                            StyleStrings.option4,
                            style: GoogleFonts.poppins(),
                          ),
                          value: 2,
                          groupValue: _selectedValue,
                          activeColor: AppColors.primaryColor,
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
                            StyleStrings.option5,
                            style: GoogleFonts.poppins(),
                          ),
                          value: 3,
                          groupValue: _selectedValue,
                          activeColor: AppColors.primaryColor,
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
                            StyleStrings.option6,
                            style: GoogleFonts.poppins(),
                          ),
                          value: 4,
                          groupValue: _selectedValue,
                          activeColor: AppColors.primaryColor,
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
                    SizedBox(height: Sizes.dynamicHeight(2)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.08, 5, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Sizes.dynamicHeight(6),
                            width: Sizes.dynamicWidth(36),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 231, 231, 231),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                ref
                                    .read(navigationServiceProvider)
                                    .routeToAndReplaceAll(AppRoute.homeRoute);
                              },
                              child: Text(
                                StyleStrings.skipText,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Sizes.dynamicWidth(5)),
                          SizedBox(
                            height: Sizes.dynamicHeight(6.5),
                            width: Sizes.dynamicWidth(36),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () async {
                                if (_selectedValue != null) {
                                  ref
                                      .read(authViewModelProvider.notifier)
                                      .saveStyle(
                                          "style",
                                          _selectedValue.toString(),
                                          ref.read(navigationServiceProvider),
                                          true,
                                          ref);
                                }
                              },
                              child: state.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      StyleStrings.continueText,
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
