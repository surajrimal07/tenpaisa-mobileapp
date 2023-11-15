import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchView> {
  int indexBottomBar = 1;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.btnColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: MyColors.btnColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  _loadUserData() {
    // Implement your user data loading logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search Assets',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        backgroundColor: MyColors.btnColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.xmark_circle, color: Colors.white),
            onPressed: () {
              // Clear the text in the TextField
              _searchController.clear();
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Search Something',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 1) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 4) {
            Navigator.pushNamed(context, AppRoute.profileRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
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
