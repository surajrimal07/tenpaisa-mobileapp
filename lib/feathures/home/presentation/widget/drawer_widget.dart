import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/widget/logout_dialog.dart';
import 'package:paisa/feathures/common/image_loader.dart';

class CommonDrawer extends ConsumerWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authEntityProvider);
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    final nav = ref.watch(navigationServiceProvider);
    final color = AppTheme.isDarkMode(context)
        ? AppColors.greyPrimaryColor
        : AppColors.primaryColor;

    Color dotColor = Colors.red;

    if (connectivityStatus == ConnectivityStatus.isConnected) {
      dotColor = Colors.green;
    }

    return Drawer(
        width: Sizes.dynamicWidth(58),
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            color: color,
          ),
          ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    ref
                        .watch(navigationServiceProvider)
                        .routeTo(AppRoute.profileRoute);
                  },
                  child: UserAccountsDrawerHeader(
                    margin: const EdgeInsets.all(0),
                    decoration: BoxDecoration(color: color),
                    accountName: Row(
                      children: [
                        Text(auth.name),
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dotColor,
                          ),
                        ),
                      ],
                    ),
                    accountEmail: Text(auth.email),
                    currentAccountPicture:
                        buildCircularImage(auth.picture!, 30, 30),
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(auth.picture!),
                    // ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text(DrawerWidgetStrings.myProfile),
                    leading: const Icon(CupertinoIcons.person),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.profileRoute);
                    },
                  ),
                  ListTile(
                    title: const Text(DrawerWidgetStrings.compare),
                    leading: const Icon(CupertinoIcons.zoom_in),
                    onTap: () {
                      nav.routeTo(AppRoute.compareRoute);
                    },
                  ),
                  // const ListTile(
                  //   title: Text(DrawerWidgetStrings.analytics),
                  //   leading: Icon(CupertinoIcons.chart_bar),
                  // ),
                  ListTile(
                    title: const Text(DrawerWidgetStrings.watchlist),
                    leading: const Icon(CupertinoIcons.heart),
                    onTap: () {
                      nav.routeTo(AppRoute.watchlistRoute);
                    },
                  ),
                  ListTile(
                    title: const Text(DrawerWidgetStrings.wallet),
                    leading: const Icon(CupertinoIcons.money_dollar_circle),
                    onTap: () {
                      nav.routeTo(AppRoute.walletsRoute);
                    },
                  ),
                  ListTile(
                    title: const Text(DrawerWidgetStrings.exchangeRates),
                    leading: const Icon(Iconsax.activity),
                    onTap: () {
                      nav.routeTo(AppRoute.forexRoute);
                    },
                  ),

                  ListTile(
                    title: const Text(DrawerWidgetStrings.portfolio),
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    onTap: () {
                      nav.routeTo(AppRoute.portfolioRoute);
                    },
                  ),
                  ListTile(
                    title: const Text(DrawerWidgetStrings.indicators),
                    leading: const Icon(Icons.search_outlined),
                    onTap: () {
                      nav.routeTo(AppRoute.financialRoute); //searchRoute
                    },
                  ),

                  ListTile(
                    title: const Text(DrawerWidgetStrings.exit),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () => showSignOutDialog(context, ref),
                  )
                ],
              ),
              //)
            ],
          ),
        ]));
  }

  Future<void> showSignOutDialog(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignOutDialog();
      },
    );
  }
}





//  minifyEnabled false
//  shrinkResources false
// to android/app/build.gradle fixed the issue