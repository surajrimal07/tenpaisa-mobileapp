import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_appbar.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_textbox_widgets.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/auth/presentation/widget/string_validators.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SigninView extends ConsumerStatefulWidget {
  const SigninView({super.key});

  @override
  ConsumerState<SigninView> createState() => SignInState();
}

class SignInState extends ConsumerState<SigninView> with FieldValidator {
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _emailEditingComplete(value) {
    final String email = value.trim();
    final String? emailError = validateEmail(email);
    if (emailError == null) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete(pass, email, rememberMe) async {
    final String password = pass.trim();
    final String? passwordError = validatePassword(password);
    if (passwordError == null) {
      if (_signInKey.currentState!.validate()) {
        await ref.read(authViewModelProvider.notifier).signIn(
              ref,
              email,
              pass,
              rememberMe,
              ref.read(navigationServiceProvider),
            );
      }
      _node.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rememberMe = ref.watch(rememberMeProvider);
    final obscureText = ref.watch(obscureTextProvider);
    final state = ref.watch(authViewModelProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: FocusScope(
                node: _node,
                child: Form(
                  key: _signInKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              width: Sizes.dynamicWidth(5),
                              height: Sizes.dynamicHeight(0.5)),
                          // const Text(
                          //   LoginStrings.loginText,
                          //   style:
                          //       TextStyle(fontSize: 28.0, color: Colors.black),
                          // ),
                          SizedBox(
                              width: Sizes.dynamicWidth(3),
                              height: Sizes.dynamicHeight(0.5)),
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 28.0,
                              color: Colors.black,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText('Login To 10Paisa',
                                    speed: const Duration(milliseconds: 50),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 28,
                                    )),
                                TypewriterAnimatedText('Fast, Secure, Reliable',
                                    speed: const Duration(milliseconds: 50),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 28,
                                    )),

                                // TypewriterAnimatedText('10Paisa is Secure',
                                //     speed: const Duration(milliseconds: 50)),
                                // TypewriterAnimatedText('10Paisa is Reliable',
                                //     speed: const Duration(milliseconds: 50)),
                              ],
                              pause: const Duration(milliseconds: 1000),
                              repeatForever: true,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   LoginStrings.loginText,
                      //   style: GoogleFonts.poppins(
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 28,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      Text(
                        LoginStrings.loginSubText,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: Sizes.dynamicHeight(0.6)),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                      Padding(
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
                          onEditingComplete: () => _passwordEditingComplete(
                              passwordController.text,
                              emailController.text,
                              rememberMe),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: AppColors.primaryColor,
                                  value: rememberMe,
                                  onChanged: (newValue) {
                                    ref
                                        .read(rememberMeProvider.notifier)
                                        .state = newValue ?? false;
                                  },
                                ),
                                Text(
                                  LoginStrings.rememberMe,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(showLeadingButtonProvider.notifier)
                                    .state = true;
                                ref.read(authScreenProvider.notifier).state =
                                    AuthScreen.forget;
                              },
                              child: Text(
                                LoginStrings.forgetpassword,
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .fingerprintLogin(
                                    ref,
                                    ref.read(navigationServiceProvider),
                                  );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: SizedBox(
                                height: Sizes.dynamicHeight(8),
                                width: Sizes.dynamicWidth(13),
                                child: FutureBuilder<bool>(
                                  future: ref
                                      .read(authViewModelProvider.notifier)
                                      .getFingerprintStatus(),
                                  builder: (context, snapshot) {
                                    return snapshot.data ?? false //false
                                        ? const Icon(
                                            Icons.fingerprint,
                                            color: AppColors.primaryColor,
                                            size: 40,
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Sizes.dynamicHeight(7),
                            width: Sizes.dynamicWidth(80),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: () async {
                                if (_signInKey.currentState!.validate()) {
                                  await ref
                                      .read(authViewModelProvider.notifier)
                                      .signIn(
                                        ref,
                                        emailController.text,
                                        passwordController.text,
                                        rememberMe,
                                        ref.read(navigationServiceProvider),
                                      );
                                }
                              },
                              child: state.isLoading
                                  ? const ButtonLoading()
                                  : Text(
                                      LoginStrings.signin,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Sizes.dynamicWidth(35),
                          10,
                          0,
                          0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LoginStrings.socalLogin,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Sizes.dynamicWidth(10),
                          0,
                          0,
                          10,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: Sizes.dynamicHeight(1)),
                            SizedBox(
                              child: SocialLoginButton(
                                height: Sizes.dynamicHeight(7),
                                width: Sizes.dynamicWidth(80),
                                borderRadius: 16.0,
                                buttonType: SocialLoginButtonType.google,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Sizes.dynamicWidth(22),
                          5,
                          0,
                          Sizes.dynamicHeight(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LoginStrings.noAccount,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(showLeadingButtonProvider.notifier)
                                    .state = true;
                                ref.read(authScreenProvider.notifier).state =
                                    AuthScreen.signup;
                              },
                              child: Text(
                                LoginStrings.signup,
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
            )
          ],
        ),
      ),
    );
  }
}
