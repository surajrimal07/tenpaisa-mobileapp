import 'package:flutter/material.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/presentation/view/auth_view.dart';
import 'package:paisa/feathures/auth/presentation/view/profile_view.dart';
import 'package:paisa/feathures/common/link_broken.dart';
import 'package:paisa/feathures/home/presentation/view/asset_view.dart';
import 'package:paisa/feathures/home/presentation/view/categories_view.dart';
import 'package:paisa/feathures/home/presentation/view/comare_view.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/view/world_market_view.dart';
import 'package:paisa/feathures/news/presentation/view/news_view.dart';
import 'package:paisa/feathures/onboarding/presentation/view/onboarding_view.dart';
import 'package:paisa/feathures/portfolio/presentation/view/portfolio_detail_view.dart';
import 'package:paisa/feathures/splash/presentation/view/splash_view.dart';

final class RouteGenerator {
  static Future<void> shouldNavigate(BuildContext context) async {
    final token = await UserSharedPrefs().getUserToken();
    if (token == null) {
      MaterialPageRoute(builder: (context) => const AuthView());
    }
  }

  static Route<dynamic> generateRoutes(
      RouteSettings settings, NavigationService navigationService) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => const SplashView());
      case '/onBoarding':
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      // case '/wallet':
      //   return MaterialPageRoute(builder: (context) => const WalletView());
      case '/auth':
        return MaterialPageRoute(builder: (context) => const AuthView());
      case '/signin':
        return MaterialPageRoute(builder: (context) => const AuthView());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeView());
      case '/news':
        return MaterialPageRoute(builder: (context) => const NewsView());
      case '/account':
        return MaterialPageRoute(builder: (context) => const AccountView());
      case '/category':
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => CategoryView(
                  initialTabIndex: arguments['initialTabIndex'],
                ));
      case '/worldmarket':
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => WorldMarketsView(
                  initialTabIndex: arguments['initialTabIndex'],
                ));

      case '/portfolioDetailView':
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => PortfoliodetailView(
                portfolioIndex: arguments['portfolioIndex']));

      case '/assetview':
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) =>
                AssetView(stockEntity: arguments['stockEntity']));
      case '/compare':
        final arguments = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => CompareView(
                selectedPortfolio1: arguments['selectedPortfolio1']));

      default:
        return MaterialPageRoute(
          builder: (context) => const BrokenLink(),
        );
    }
  }
}
