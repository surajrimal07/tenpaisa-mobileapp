import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/services/user_services.dart';
import 'package:paisa/utils/colors_utils.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>?>(
        future: UserService.fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
            //return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            Map<String, dynamic> userData = snapshot.data!;
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  margin: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(color: MyColors.btnColor),
                  accountName: Text(userData['name'] ?? ''),
                  accountEmail: Text(userData['email'] ?? ''),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(userData['dp'] ?? ''),
                  ),
                ),
                ListTile(
                  title: const Text('My Profile'),
                  leading: const Icon(CupertinoIcons.person),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.profileRoute);
                  },
                ),
                const ListTile(
                  title: Text('Compare'),
                  leading: Icon(CupertinoIcons.zoom_in),
                ),
                const ListTile(
                  title: Text('Analytics'),
                  leading: Icon(CupertinoIcons.chart_bar),
                ),
                ListTile(
                  title: const Text('Wishlist'),
                  leading: const Icon(CupertinoIcons.heart),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.wishlistRoute);
                  },
                ),
                ListTile(
                  title: const Text('Wallet'),
                  leading: const Icon(CupertinoIcons.heart),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.walletRoute);
                  },
                ),
                const ListTile(
                  title: Text('Settings'),
                  leading: Icon(CupertinoIcons.settings),
                ),
                const ListTile(
                  title: Text('Exit'),
                  leading: Icon(Icons.exit_to_app),
                )
              ],
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
