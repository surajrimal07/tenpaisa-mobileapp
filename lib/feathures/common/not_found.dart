import 'package:flutter/material.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/splash/presentation/widget/loading_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedLoading(
              path: ErrorStrings.errorAnimation,
              height: Sizes.dynamicHeight(40),
              width: Sizes.dynamicWidth(80),
            ),
            SizedBox(height: Sizes.p16Height),
            Text(
              ErrorStrings.notFound,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: Sizes.p8Height),
            Text(
              ErrorStrings.subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: Sizes.p16Height),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: const Text(ErrorStrings.errorButton),
            ),
          ],
        ),
      ),
    );
  }
}
