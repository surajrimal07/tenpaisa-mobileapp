import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_appbar.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_textbox_widgets.dart';
import 'package:paisa/feathures/auth/presentation/widget/input_controllers.dart';
import 'package:paisa/feathures/auth/presentation/widget/string_validators.dart';
import 'package:paisa/feathures/common/button_circular_loading.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => SignupState();
}

class SignupState extends ConsumerState<SignupView> with FieldValidator {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final node = FocusScopeNode();

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

  void _phoneEditingComplete(value) {
    final String phone = value.trim();
    final String? phoneError = validatePhone(phone);
    if (phoneError == null) {
      node.nextFocus();
    }
  }

  void _nameEditingComplete(value) {
    final String name = value.trim();
    final String? nameError = validateName(name);
    if (nameError == null) {
      node.nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rememberMe = ref.watch(rememberMeProvider);
    final obscureText = ref.watch(obscureTextProvider);
    final state = ref.watch(authViewModelProvider);
    final nameController = ref.watch(nameControllerProvider);
    final phoneController = ref.watch(phoneControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      RegisterStrings.registerText,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      RegisterStrings.registerSubText,
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
                        key: const Key('username_field'), //for testing
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        keyboardAppearance: Brightness.light,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        onEditingComplete: () =>
                            _nameEditingComplete(nameController.text),
                        validator: (value) {
                          return validateName(value);
                        },
                        decoration: buildInputDecoration(
                          icon: const Icon(
                            Icons.account_circle_outlined,
                            color: AppColors.primaryColor,
                          ),
                          hintText: RegisterStrings.enterNameHint,
                          obscureText: obscureText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: const Key('phone_field'),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardAppearance: Brightness.light,
                        autocorrect: false,
                        onEditingComplete: () =>
                            _phoneEditingComplete(phoneController.text),
                        validator: (value) {
                          return validatePhone(value);
                        },
                        decoration: buildInputDecoration(
                          icon: const Icon(
                            Icons.phone_android_outlined,
                            color: AppColors.primaryColor,
                          ),
                          hintText: RegisterStrings.enterPhoneHint,
                          obscureText: obscureText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: const Key('email_field'),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: const Key('password_field'),
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        keyboardAppearance: Brightness.light,
                        autocorrect: false,
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
                          hintText: RegisterStrings.enterPasswordHint,
                          onSuffixIconPressed: () {
                            ref.read(obscureTextProvider.notifier).state =
                                !ref.read(obscureTextProvider.notifier).state;
                          },
                          obscureText: obscureText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                key: const Key('remember_me_checkbox'),
                                focusNode: FocusNode(),
                                activeColor: AppColors.primaryColor,
                                checkColor: Colors.white,
                                value: rememberMe,
                                onChanged: (newValue) {
                                  ref.read(rememberMeProvider.notifier).state =
                                      newValue ?? false;
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 0, 16, 0),
                      child: SizedBox(
                        height: Sizes.dynamicHeight(6),
                        width: Sizes.dynamicWidth(80),
                        child: TextButton(
                          key: const Key('signup_button'),
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          onPressed: () async {
                            if (signUpKey.currentState!.validate()) {
                              var userModel = AuthEntity(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  token: DefaultUserValues.defaultToken,
                                  phone:
                                      int.tryParse(phoneController.text) ?? 0);
                              ref.read(authViewModelProvider.notifier).signUp(
                                    userModel,
                                    rememberMe,
                                    ref.read(authScreenProvider.notifier),
                                  );
                            }
                          },
                          child: state.isLoading
                              ? const ButtonLoading()
                              : const Text(
                                  RegisterStrings.signupButtonText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //     Sizes.dynamicWidth(10),
                    //     0,
                    //     0,
                    //     10,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       const SizedBox(height: 10),
                    //       SocialLoginButton(
                    //         height: Sizes.dynamicHeight(6),
                    //         width: Sizes.dynamicWidth(80),
                    //         borderRadius: 16.0,
                    //         buttonType: SocialLoginButtonType.google,
                    //         onPressed: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Sizes.dynamicWidth(40),
                        15,
                        0,
                        Sizes.dynamicHeight(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            key: const Key('already_account_text'),
                            RegisterStrings.alreadyAccount,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref
                                  .read(showLeadingButtonProvider.notifier)
                                  .state = false;
                              ref.read(authScreenProvider.notifier).state =
                                  AuthScreen.login;
                            },
                            child: Text(
                              key: const Key('signin_text'),
                              RegisterStrings.signin,
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
      ),
    );
  }
}
