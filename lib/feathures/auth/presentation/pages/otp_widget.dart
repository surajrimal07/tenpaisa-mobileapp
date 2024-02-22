import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:pinput/pinput.dart';

class OtpView extends ConsumerStatefulWidget {
  const OtpView({super.key});

  @override
  ConsumerState<OtpView> createState() => _MyVerifyState();
}

class _MyVerifyState extends ConsumerState<OtpView> {
  int otppin = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    final otpController = ref.watch(otpControllerProvider);
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: const TextStyle(
    //       fontSize: 20,
    //       color: Color.fromRGBO(30, 60, 87, 1),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            ref.read(authScreenProvider.notifier).state = AuthScreen.signup;
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
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    OtpStrings.otpText,
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    OtpStrings.otpSubText,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Sizes.dynamicHeight(6),
                    // height: 30,
                  ),
                  Pinput(
                    length: 4,
                    showCursor: true,
                    onCompleted: (pin) => otppin = int.tryParse(pin) ?? 0,
                    controller: otpController,
                  ),
                  SizedBox(height: Sizes.dynamicHeight(4)),
                  SizedBox(
                      width: Sizes.dynamicWidth(80),
                      height: Sizes.dynamicHeight(8),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (otppin == 0) {
                              CustomToast.showToast(OtpStrings.otpErrorText);
                              return;
                            }
                            ref.read(authViewModelProvider.notifier).verifyOTP(
                                otppin,
                                ref.read(authScreenProvider.notifier),
                                true,
                                ref,
                                false);
                          },
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(OtpStrings.otpButtonText,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.08, 15, 20, 0),
                    child: Row(
                      children: [
                        Text(
                          OtpStrings.noOTP,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref.read(authViewModelProvider.notifier).resendOTP(
                                ref.read(authScreenProvider.notifier));
                            otpController.clear();
                          },
                          child: Text(
                            OtpStrings.resendOtp,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
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
