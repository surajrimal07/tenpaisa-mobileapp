import 'package:paisa/view/account_view.dart';
import 'package:paisa/view/dashboard_view.dart';
import 'package:paisa/view/forget_view.dart';
import 'package:paisa/view/news_view.dart';
import 'package:paisa/view/noti_view.dart';
import 'package:paisa/view/onboarding_view.dart';
import 'package:paisa/view/otp_view.dart';
import 'package:paisa/view/portfolio_View.dart';
import 'package:paisa/view/search_view.dart';
import 'package:paisa/view/signin_view.dart';
import 'package:paisa/view/signup_view.dart';
import 'package:paisa/view/style_view.dart';
import 'package:paisa/view/wallet_view.dart';

class AppRoute {
  AppRoute._();
  static const String signinRoute = '/signin';
  static const String onboardRoute = '/onboard';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';
  static const String otpRoute = '/otp';
  static const String forgotRoute = '/forgot';
  static const String invStyle = '/invstyle';
  static const String profileRoute = '/profile';
  static const String newsRoute = '/news';
  static const String notiRoute = '/noti';
  static const String portRoute = '/port';
  static const String searchRoute = '/search';
  static const String walletRoute = '/wallet';

  static getApplicationRoute() {
    return {
      signinRoute: (context) => const SigninView(),
      onboardRoute: (context) => const OnboardingView(),
      signupRoute: (context) => const SignupView(),
      dashboardRoute: (context) => const DashboardView(),
      otpRoute: (context) => const OtpView(),
      forgotRoute: (context) => const ForgotView(),
      invStyle: (context) => const StyleView(),
      profileRoute: (context) => const AccountView(),
      newsRoute: (context) => const NewsView(),
      notiRoute: (context) => const NotificationView(),
      portRoute: (context) => const PortfolioView(),
      searchRoute: (context) => const SearchView(),
      walletRoute: (context) => const WalletView()
    };
  }
}
