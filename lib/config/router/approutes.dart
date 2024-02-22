import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view/profile_view.dart';
import 'package:paisa/feathures/home/presentation/view/comare_view.dart';
import 'package:paisa/feathures/home/presentation/view/financial_view.dart';
import 'package:paisa/feathures/home/presentation/view/forex_view.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/view/notification_view.dart';
import 'package:paisa/feathures/home/presentation/view/search_view.dart';
import 'package:paisa/feathures/home/presentation/view/wallet_view.dart';
import 'package:paisa/feathures/news/presentation/view/news_view.dart';
import 'package:paisa/feathures/onboarding/presentation/view/onboarding_view.dart';
import 'package:paisa/feathures/portfolio/presentation/view/portfolio_view.dart';
import 'package:paisa/feathures/splash/presentation/view/splash_view.dart';
import 'package:paisa/feathures/watchlist/presentation/view/watchlist_view.dart';

class AppRoute {
  AppRoute._();
  static const String authRoute = '/signin';
  static const String onboardRoute = '/onboard';
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';
  static const String walletRoute = '/wallet';
  static const String newsRoute = '/news';

  static const String profileRoute = '/profile';
  static const String searchRoute = '/search';
  static const String watchlistRoute = '/watchlist';
  static const String portfolioRoute = '/portfolio';
  static const String notificationRoute = '/notification';
  static const String compareRoute = '/compare';
  static const String walletsRoute = '/Wallets';
  static const String financialRoute = '/financialdata';
  static const String forexRoute = '/forex';

  static getApplicationRoute() {
    return {
      authRoute: (context) => const AuthView(),
      onboardRoute: (context) => const OnboardingView(),
      splashRoute: (context) => const SplashView(),
      homeRoute: (context) => const HomeView(),
      newsRoute: (context) => const NewsView(),
      profileRoute: (context) => const AccountView(),
      searchRoute: (context) => const SearchView(),
      watchlistRoute: (context) => const WishlistView(),
      portfolioRoute: (context) => const PortfolioView(),
      notificationRoute: (context) => const NotificationView(),
      compareRoute: (context) => const CompareView(),
      walletsRoute: (context) => const WalletViews(),
      financialRoute: (context) => const FinancialDataView(),
      forexRoute: (context) => const ForexDataView(),
    };
  }
}
