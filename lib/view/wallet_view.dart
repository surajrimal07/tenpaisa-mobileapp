// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletView> {
  int indexBottomBar = 3;
  @override
  void initState() {
    super.initState();
    _loadUserData();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          MyColors.btnColor, // Status bar color set to a dark blue shade
      statusBarIconBrightness:
          Brightness.light, // Adjust status bar icon colors
      systemNavigationBarColor:
          MyColors.btnColor, // Navigation bar color set to the same blue shade
      systemNavigationBarIconBrightness:
          Brightness.light, // Adjust navigation bar icon colors
    ));
  }

  _loadUserData() {
    // Implement your user data loading logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'No Wallet found',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 3) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 2) {
            Navigator.pushNamed(context, AppRoute.portRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.global_search),
            title: const Text("Search"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.document),
            title: const Text("Portfolio"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.wallet_1),
            title: const Text("Wallet"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.profile_circle),
            title: const Text("Profile"),
            selectedColor: Colors.white,
            unselectedColor: Colors.white70,
          ),
        ],
      ),
    );
  }
}
