import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart'; // Import SalomonBottomBar

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  int indexBottomBar =
      4; // Variable to hold the current index of SalomonBottomBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/content/user1.jpg'),
            ),
            const SizedBox(height: 20),
            itemProfile(
                'Name',
                'Suraj Rimal',
                Icons
                    .person), // Replaced CupertinoIcons.person with Icons.person
            const SizedBox(height: 10),
            itemProfile('Phone', '979789',
                Icons.phone), // Replaced CupertinoIcons.phone with Icons.phone
            const SizedBox(height: 10),
            itemProfile(
                'Address',
                'abc address, xyz city',
                CupertinoIcons
                    .location), // Replaced CupertinoIcons.location with Icons.location
            const SizedBox(height: 10),
            itemProfile('Email', 'suraj@jjjs.com',
                Icons.mail), // Replaced CupertinoIcons.mail with Icons.mail
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: MyColors.btnColor,
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.white), // Set the text color to black
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        // Added SalomonBottomBar
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 4) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else {
            setState(() => indexBottomBar = i);
          }
        },

        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home"),
            selectedColor: MyColors.btnColor,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.global_search),
            title: const Text("Search"),
            selectedColor: MyColors.btnColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.document),
            title: const Text("Portfolio"),
            selectedColor: MyColors.btnColor,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Iconsax.wallet_1),
            title: const Text("Wallet"),
            selectedColor: MyColors.btnColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.profile_circle),
            title: const Text("Profile"),
            selectedColor: MyColors.btnColor,
          ),
        ],
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.blue.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
