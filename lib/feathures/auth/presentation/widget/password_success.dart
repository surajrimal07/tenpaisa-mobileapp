import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/pages/forget_widget.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';

class PasswordResetSuccessDialog extends StatelessWidget {
  final WidgetRef ref;

  const PasswordResetSuccessDialog({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    var verificationStatus = ref.watch(verificationStatusProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(PasswordSuccessDialog.successImage,
                  height: 90, width: 90),
              const SizedBox(height: 20.0),
              const Text(
                textAlign: TextAlign.center,
                PasswordSuccessDialog.passwordChanged,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                textAlign: TextAlign.center,
                PasswordSuccessDialog.proceedToSignin,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  passwordController.clear();
                  verificationStatus.setMailVerified(false);
                  verificationStatus.setOtpVerified(false);
                  ref.read(authScreenProvider.notifier).state =
                      AuthScreen.login;
                },
                child: Text(
                  LoginStrings.signin,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
