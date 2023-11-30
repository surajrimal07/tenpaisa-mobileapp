// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa/app/common/drawer_common.dart';
import 'package:paisa/app/common/navbar_common.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistView> {
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
          'Watchlist',
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
            'No Wishlist found',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
      drawer: const CommonDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 3) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.wishlistRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 2) {
            Navigator.pushNamed(context, AppRoute.portRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },
      ),
    );
  }
}
