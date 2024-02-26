import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_appbar.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_headers_widget.dart';
import 'package:paisa/feathures/auth/presentation/widget/auth_widgets.dart';

enum AuthScreen { login, signup, forget, otp, style }

final authScreenProvider = StateProvider<AuthScreen>((ref) {
  return AuthScreen.login;
});

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AuthAppBar(),
      body: Column(
        children: [
          const CommonAuthHeader(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Form(child: AuthWidgets()),
            ),
          )
        ],
      ),
    );
  }
}
