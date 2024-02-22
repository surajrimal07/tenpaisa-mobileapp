import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/pages/forget_widget.dart';
import 'package:paisa/feathures/auth/presentation/pages/login_widget.dart';
import 'package:paisa/feathures/auth/presentation/pages/otp_widget.dart';
import 'package:paisa/feathures/auth/presentation/pages/signup_widget.dart';
import 'package:paisa/feathures/auth/presentation/pages/style_widget.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';

class AuthWidgets extends ConsumerWidget {
  const AuthWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(authScreenProvider);

    switch (currentScreen) {
      case AuthScreen.login:
        return const SigninView();
      case AuthScreen.signup:
        return const SignupView();
      case AuthScreen.forget:
        return const ForgotView();
      case AuthScreen.otp:
        return const OtpView();
      case AuthScreen.style:
        return const StyleView();

      default:
        return const SignupView();
    }
  }
}
