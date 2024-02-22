import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/onboarding/presentation/widget/onboarding_widget.dart';

final pageControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: 0);
});

final onboardingStateProvider = StateProvider<int>((ref) => 0);

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: OnboardingWidget(),
    );
  }
}
