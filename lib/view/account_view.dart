import 'dart:io';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<AccountView> {
  int indexBottomBar = 4;
  String currentName = "Suraj Rimal";
  String currentEmail = "hello@suraj.com";
  String currentPhone = "98402202**";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPhoneController = TextEditingController();

  XFile? _pickedImage; // Initialize with null

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: currentName,
              userProfilePic: _pickedImage != null
                  ? Image.file(File(_pickedImage!.path)).image
                  : const AssetImage("assets/images/content/user1.jpg"),
              imageRadius: 80,
              onTap: _pickImage,
            ),
            SettingsGroup(
              settingsGroupTitle: "Profile",
              settingsGroupTitleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              items: [
                SettingsItem(
                  onTap: () => showNameChangeDialog(context),
                  icons: Icons.person_2_outlined,
                  title: 'Name',
                  subtitle: currentName,
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () => showPasswordChangeDialog(context),
                  icons: Icons.person_2_outlined,
                  title: 'Password',
                  subtitle: "**********",
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () => showEmailChangeDialog(context),
                  icons: Icons.email_outlined,
                  title: 'Email',
                  subtitle: currentEmail,
                ),
                SettingsItem(
                  onTap: () => showPhoneChangeDialog(context),
                  icons: Icons.phone,
                  title: 'Phone',
                  subtitle: currentPhone,
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              settingsGroupTitleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              items: [
                SettingsItem(
                  onTap: () => showSignOutDialog(context),
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                // SettingsItem(
                //   onTap: () {},
                //   icons: Icons.change_circle_outlined,
                //   title: "Change email",
                // ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
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
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home"),
            selectedColor: MyColors.btnColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.global_search),
            title: const Text("Search"),
            selectedColor: MyColors.btnColor,
          ),
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
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.profile_circle),
            title: const Text("Profile"),
            selectedColor: MyColors.btnColor,
          ),
        ],
      ),
    );
  }

  Future<void> showSignOutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          actions: [
            TextButton(
              onPressed: () {
                CustomToast.showToast("Logging out");
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                CustomToast.showToast("Not logged out");
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showNameChangeDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Change Name"),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Current Name: $currentName"),
                    TextFormField(
                      controller: newNameController,
                      decoration: const InputDecoration(labelText: 'New Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    CustomToast.showToast("Cancelled");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String newName = newNameController.text;
                      updateName(newName);
                      CustomToast.showToast("Saved: $newName");
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showPasswordChangeDialog(BuildContext context) async {
    String? passwordError;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Change Password"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // You may add more widgets as needed
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      return null;
                    },
                  ),
                  // Add additional TextFormField widgets for current and confirm password if needed
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    CustomToast.showToast("Cancelled");
                    // Clear the input value when cancel is pressed
                    newPasswordController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String newPassword = newPasswordController.text;
                      // Process the new password
                      CustomToast.showToast("Saved: $newPassword");
                      newPasswordController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showEmailChangeDialog(BuildContext context) async {
    String? emailError;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Change Email"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Current Email: $currentEmail"),
                  TextField(
                    controller: newEmailController,
                    decoration: InputDecoration(
                      labelText: 'New Email',
                      errorText: emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    CustomToast.showToast("Cancelled");
                    newEmailController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (newEmailController.text.isNotEmpty &&
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(newEmailController.text)) {
                      String newEmail = newEmailController.text;
                      updateEmail(newEmail);
                      CustomToast.showToast("Saved: $newEmail");
                      Navigator.of(context).pop();
                    } else {
                      // Handle invalid email case
                      setState(() {
                        emailError = 'Please enter a valid email address';
                      });
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showPhoneChangeDialog(BuildContext context) async {
    String? phoneError;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Change Phone"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Current Phone: $currentPhone"),
                  TextField(
                    controller: newPhoneController,
                    decoration: InputDecoration(
                      labelText: 'New Phone',
                      errorText: phoneError,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    newPhoneController.clear();
                    CustomToast.showToast("Cancelled");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (newPhoneController.text.isNotEmpty &&
                        newPhoneController.text.length == 10 &&
                        int.tryParse(newPhoneController.text) != null) {
                      String newPhone = newPhoneController.text;
                      updatePhone(newPhone);
                      CustomToast.showToast("Saved: $newPhone");
                      Navigator.of(context).pop();
                    } else {
                      // Handle invalid phone number case
                      setState(() {
                        phoneError =
                            'Please enter a valid 10-digit phone number';
                      });
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void updateName(String newName) {
    setState(() {
      currentName = newName;
    });
  }

  void updatePass(String newPass) {
    setState(() {
      currentName = newPass;
    });
  }

  void updateEmail(String newEmail) {
    setState(() {
      currentEmail = newEmail;
    });
  }

  void updatePhone(String newPhone) {
    setState(() {
      currentPhone = newPhone;
    });
  }
}
