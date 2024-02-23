// ignore_for_file: unused_field

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/presentation/view/profile_view.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/common/connection_restored.dart';
import 'package:paisa/feathures/common/no_connection.dart';
import 'package:paisa/feathures/home/presentation/view/dashboard_home.dart';
import 'package:paisa/feathures/home/presentation/view/search_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/sensor_viewmodel.dart';
import 'package:paisa/feathures/home/presentation/widget/drawer_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/view/portfolio_view.dart';
import 'package:paisa/feathures/watchlist/presentation/view/watchlist_view.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool _hasNavigatedDisconnected = false;
  bool _hasNavigatedConnected = false;
  ConnectivityStatus _lastConnectivityStatus = ConnectivityStatus.isConnected;

  List<Widget> lstScreen = [
    const DashboardView(),
    const SearchView(),
    const PortfolioView(),
    const WishlistView(),
    const AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    ref.watch(shakeDetectionViewModelProvider).initIsShakes(context, ref);
    final connectivityStatus = ref.watch(connectivityStatusProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectivityStatus != _lastConnectivityStatus) {
        _lastConnectivityStatus = connectivityStatus;
        if (connectivityStatus == ConnectivityStatus.isDisconnected) {
          _hasNavigatedDisconnected = true;
          _hasNavigatedConnected = false;
          animatednavigateTo(context, const NoConnection());
        } else if (connectivityStatus == ConnectivityStatus.isConnected) {
          _hasNavigatedConnected = true;
          _hasNavigatedDisconnected = false;
          animatednavigateTo(context, const Connected());
        }
      }
    });

    return Scaffold(
      key: scaffoldKey,
      drawer: const CommonDrawer(),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.backgroundColor,
            child: child,
          );
        },
        duration: AppStrings.duration,
        child: lstScreen[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        backgroundColor: AppTheme.isDarkMode(context)
            ? Colors.grey[900]
            : AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.50),
        selectedFontSize: 15,
        unselectedFontSize: 14,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(size: 25, Iconsax.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(size: 25, Iconsax.global_search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(size: 25, Iconsax.document), label: "Portfolio"),
          BottomNavigationBarItem(
              icon: Icon(size: 25, Iconsax.wallet_1), label: "Watchlist"),
          // BottomNavigationBarItem(
          //   icon: CircleAvatar(
          //       radius: 12.2,
          //       backgroundImage: NetworkImage(
          //         ref.watch(authEntityProvider.select((it) => it.picture))!,
          //       )),
          //   label: "Profile",
          // ),

          BottomNavigationBarItem(
              icon: Icon(size: 25, Iconsax.profile_circle), label: "Profile"),
        ],
        currentIndex: selectedIndex,
      ),
    );
  }
}
