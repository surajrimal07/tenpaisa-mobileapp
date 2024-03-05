import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_appbar.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_textbox_widgets.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/auth/presentation/widget/password_success.dart';
import 'package:paisa/feathures/auth/presentation/widget/string_validators.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class VerificationStatus extends ChangeNotifier {
  bool _mailVerified = false;
  bool _otpVerified = false;

  bool get isMailVerified => _mailVerified;
  bool get isOtpVerified => _otpVerified;

  void setMailVerified(bool value) {
    _mailVerified = value;
    notifyListeners();
  }

  void setOtpVerified(bool value) {
    _otpVerified = value;
    notifyListeners();
  }
}

final verificationStatusProvider =
    ChangeNotifierProvider<VerificationStatus>((ref) {
  return VerificationStatus();
});

class ForgotView extends ConsumerStatefulWidget {
  const ForgotView({super.key});

  @override
  ForgotState createState() => ForgotState();
}

class ForgotState extends ConsumerState<ForgotView> with FieldValidator {
  final _formKey = GlobalKey<FormState>();

  final node = FocusScopeNode();
  final otp = TextEditingController();

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  void _emailEditingComplete(value) {
    final String email = value.trim();
    final String? emailError = validateEmail(email);
    if (emailError == null) {
      node.nextFocus();
    }
  }

  void _passwordEditingComplete(value) {
    final String password = value.trim();
    final String? passwordError = validatePassword(password);
    if (passwordError == null) {
      //call api here too
      node.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final obscureText = ref.watch(obscureTextProvider);
    final state = ref.watch(authViewModelProvider);
    final verificationStatus = ref.watch(verificationStatusProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

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
                    ForgetPasswordStrings.forgetHead,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ForgetPasswordStrings.forgetPasswordSubText,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardAppearance: Brightness.light,
                      onEditingComplete: () =>
                          _emailEditingComplete(emailController.text),
                      autocorrect: false,
                      controller: emailController,
                      validator: (value) {
                        return validateEmail(value);
                      },
                      decoration: buildInputDecoration(
                        icon: const Icon(
                          Icons.alternate_email_outlined,
                          color: AppColors.primaryColor,
                        ),
                        hintText: LoginStrings.enterEmail,
                        obscureText: obscureText,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: verificationStatus.isMailVerified,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: otp,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardAppearance: Brightness.light,
                        autocorrect: false,
                        onChanged: (value) {
                          otp.text = value;
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return ForgetPasswordStrings.otpEmpty;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: buildInputDecoration(
                          icon: const Icon(
                            Icons.password_outlined,
                            color: AppColors.primaryColor,
                          ),
                          hintText: ForgetPasswordStrings.otpHint,
                          obscureText: obscureText,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: verificationStatus.isOtpVerified,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: const Key('loginForm_passwordInput_textField'),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        keyboardAppearance: Brightness.light,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: obscureText,
                        onEditingComplete: () =>
                            _passwordEditingComplete(passwordController.text),
                        validator: (value) {
                          return validatePassword(value);
                        },
                        decoration: buildInputDecoration(
                          icon: const Icon(
                            Icons.password_outlined,
                            color: AppColors.primaryColor,
                          ),
                          hintText: LoginStrings.passHint,
                          onSuffixIconPressed: () {
                            ref.read(obscureTextProvider.notifier).state =
                                !ref.read(obscureTextProvider.notifier).state;
                          },
                          obscureText: obscureText,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Sizes.dynamicWidth(16),
                      Sizes.dynamicHeight(1),
                      16,
                      0,
                    ),
                    child: SizedBox(
                      height: Sizes.dynamicHeight(6),
                      width: Sizes.dynamicWidth(80),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (verificationStatus.isMailVerified == false) {
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .forgetPassword(emailController.text,
                                      ref.read(navigationServiceProvider));

                              await Future.delayed(
                                  const Duration(milliseconds: 900));
                              if (state.isLoading) {
                                CustomToast.showToast(
                                    ForgetPasswordStrings.pleaseWait);
                              } else {
                                CustomToast.showToast(
                                    ForgetPasswordStrings.checkEmail);
                              }
                              verificationStatus.setMailVerified(true);
                            } else if (verificationStatus.isMailVerified &&
                                !verificationStatus.isOtpVerified) {
                              CustomToast.showToast(
                                  ForgetPasswordStrings.pleaseWait);

                              ref
                                  .read(authViewModelProvider.notifier)
                                  .verifyOTP(
                                      int.parse(otp.text),
                                      ref.read(navigationServiceProvider),
                                      false,
                                      ref,
                                      true);
                            } else if (verificationStatus.isMailVerified &&
                                verificationStatus.isOtpVerified) {
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .saveStyle(
                                      'password',
                                      passwordController.text,
                                      ref.read(navigationServiceProvider),
                                      true,
                                      ref);

                              if (!state.isLoading) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PasswordResetSuccessDialog(ref: ref);
                                  },
                                );
                              }
                            }
                          }
                        },
                        child: state.isLoading
                            ? const ButtonLoading()
                            : Text(
                                verificationStatus.isOtpVerified
                                    ? ForgetPasswordStrings.updatePassword
                                    : (verificationStatus.isMailVerified
                                        ? ForgetPasswordStrings.verifyOtpText
                                        : ForgetPasswordStrings
                                            .verifyEmailText),
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.45, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            ref.read(showLeadingButtonProvider.notifier).state =
                                false;
                            ref.read(authScreenProvider.notifier).state =
                                AuthScreen.login;
                          },
                          child: Text(
                            ForgetPasswordStrings.signInText,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
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
                            ref.read(authScreenProvider.notifier).state =
                                AuthScreen.signup;
                          },
                          child: Text(
                            ForgetPasswordStrings.signup,
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
    ));
  }
}
