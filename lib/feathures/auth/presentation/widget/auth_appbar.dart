import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';

final showLeadingButtonProvider = StateProvider<bool>((ref) => false);

class AuthAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLeadingButton = ref.watch(showLeadingButtonProvider);

    return AppBar(
      backgroundColor: Colors.transparent,
      leading: showLeadingButton
          ? IconButton(
              onPressed: () {
                ref.read(showLeadingButtonProvider.notifier).state = false;
                ref.read(authScreenProvider.notifier).state = AuthScreen.login;
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            )
          : null,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
