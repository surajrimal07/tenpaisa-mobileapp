import 'package:paisa/view/dashboard_view.dart';
import 'package:paisa/view/forget_view.dart';
import 'package:paisa/view/onboarding_view.dart';
import 'package:paisa/view/otp_view.dart';
import 'package:paisa/view/signin_view.dart';
import 'package:paisa/view/signup_view.dart';

class AppRoute {
  AppRoute._();
  static const String signinRoute = '/signin';
  static const String onboardRoute = '/onboard';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';
  static const String otpRoute = '/otp';
  static const String forgotRoute = '/forgot';

  static getApplicationRoute() {
    return {
      signinRoute: (context) => const SigninView(),
      onboardRoute: (context) => const OnboardingView(),
      signupRoute: (context) => const SignupView(),
      dashboardRoute: (context) => const DashboardView(),
      otpRoute: (context) => const OtpView(),
      forgotRoute: (context) => const ForgotView()
    };
  }
}
