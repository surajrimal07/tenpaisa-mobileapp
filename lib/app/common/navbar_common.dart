import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CommonBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      backgroundColor: MyColors.btnColor,
      margin: const EdgeInsets.all(6),
      currentIndex: currentIndex,
      onTap: onTap,
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
          title: const Text("Wishlist"),
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
    );
  }
}
