import 'package:paisa/view/dashboard_view.dart';
import 'package:paisa/view/onboarding_view.dart';
import 'package:paisa/view/signin_view.dart';
import 'package:paisa/view/signup_view.dart';

class AppRoute {
  AppRoute._();

  static const String onboardRoute = '/';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';

  static getApplicationRoute() {
    return {
      onboardRoute: (context) => const OnboardingView(),
      signinRoute: (context) => const SigninView(),
      signupRoute: (context) => const SignupView(),
      dashboardRoute: (context) => const DashboardView(),
    };
  }
}
