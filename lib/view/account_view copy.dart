// ignore_for_file: use_build_context_synchronously

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/services/websocket_services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_services.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<AccountView> {
  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int indexBottomBar = 4;
  String currentName = "";
  String currentPass = "**********";
  String currentEmail = "";
  String currentPhone = "";
  String currentDP = "";
  //DateTime? currentBackPressTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPhoneController = TextEditingController();

//updating image is broken, needs more logic,
  XFile? _pickedImage; // Initialize with null

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      //bool success = await UserService.uploadProfilePicture(pickedImage.path);

      // if (success) {
      //   // Update the user's profile picture URL
      //   //await UserService.updateUserProfilePictureUrl();

      //   setState(() {
      //     // Get the updated profile picture URL
      //     //currentDP = UserService.getUpdatedProfilePictureUrl();
      //   });
      // } else {
      //   CustomToast.showToast("Failed to upload profile picture");
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    //_formKey = GlobalKey<FormState>();
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

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await UserService.fetchUserData();

    if (userData != null) {
      setState(() {
        currentName = userData['name'] ?? "";
        currentEmail = userData['email'];
        currentPhone = userData['phone'];
        currentDP = userData['dp'];
      });
    }
  }

  // Future<void> updateUserData(String whatfield, String whatvalue) async {
  //   try {
  //     await UserService.updateUser(whatfield, whatvalue);

  //     CustomToast.showToast("Data updated successfully");
  //   } catch (error) {
  //     CustomToast.showToast("Error occured updating data");
  //     print("Error updating user $whatfield : $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white.withOpacity(.94),
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
              userName: currentDP, // currentName
              userProfilePic: AssetImage(currentDP)
              // != null
              //     ? AssetImage("assets/images/content/$currentDP")
              //     : const AssetImage("assets/images/content/default.png"

              //)
              ,
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
                  subtitle: currentPass,
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () => showEmailChangeDialog(context),
                  icons: Icons.email_outlined,
                  title: 'Email',
                  subtitle: currentEmail ?? 'No Email',
                ),
                SettingsItem(
                  onTap: () => showPhoneChangeDialog(context),
                  icons: Icons.phone,
                  title: 'Phone',
                  subtitle: currentPhone ?? 'No Number',
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
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.settings_solid,
                  title:
                      "Web socket is ${WebSocketServices.isConnected ? 'connected' : 'disconnected'}",
                  titleStyle: const TextStyle(
                    color: Colors.black,
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
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userToken');

                String? checktoken = prefs.getString('userToken');
                print("is token null after logged out: $checktoken");
                CustomToast.showToast("Logging out");

                //Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.signinRoute,
                  (route) => false,
                );
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
    String? nameError;
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String newName = newNameController.text;

                      //updateName(newName);
                      //updateUserData("name", newName);

                      try {
                        await UserService.updateUser("name", newName);
                        updateName(newName);
                        //updateUserData("name", newName);
                        CustomToast.showToast("Saved: $newName");
                      } catch (error) {
                        CustomToast.showToast("Error occured updating Name");
                        print("Error: $error");
                      }

                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        nameError = 'Name cannot be empty';
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

  Future<void> showPasswordChangeDialog(BuildContext context) async {
    String? passwordError;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Change Password"),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Current Password: *********"),
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        //errorText: passwordError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    // Add additional TextFormField widgets for current and confirm password if needed
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    CustomToast.showToast("Cancelled");
                    newPasswordController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String newPassword = newPasswordController.text;
                      if (newPassword.isNotEmpty) {
                        // Process the new password

                        try {
                          await UserService.updateUser("password", newPassword);
                          CustomToast.showToast("Password Updated");
                        } catch (error) {
                          CustomToast.showToast("Error occured updating Pass");
                          print("Error: $error");
                        }
                        newPasswordController.clear();
                        Navigator.of(context).pop();
                      } else {
                        // Update the error text to display the error below the text field
                        setState(() {
                          passwordError = 'Password cannot be empty';
                        });
                      }
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
                  onPressed: () async {
                    if (newEmailController.text.isNotEmpty &&
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(newEmailController.text)) {
                      String newEmail = newEmailController.text;
                      try {
                        await UserService.updateUser("email", newEmail);
                        updateEmail(newEmail);
                        //updateUserData("name", newName);
                        CustomToast.showToast("Saved: $newEmail");
                      } catch (error) {
                        CustomToast.showToast("Error occured updating Email");
                        print("Error: $error");
                      }
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
                  Text(
                    "Current Phone: ${currentPhone ?? "No Number"}",
                  ),
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
                  onPressed: () async {
                    if (newPhoneController.text.isNotEmpty &&
                        newPhoneController.text.length == 10 &&
                        int.tryParse(newPhoneController.text) != null) {
                      String newPhone = newPhoneController.text;

                      try {
                        await UserService.updateUser("phone", newPhone);
                        updatePhone(newPhone);
                        //updateUserData("name", newName);
                        CustomToast.showToast("Saved: $newPhone");
                      } catch (error) {
                        CustomToast.showToast("Error occured updating Phone");
                        print("Error: $error");
                      }

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

  // void updatePass(String newPass) {
  //   setState(() {
  //     currentPass = newPass;
  //   });
  // }

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

  // Future<bool> _onBackPressed() async {
  //   DateTime now = DateTime.now();

  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Press back again to exit'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     return false;
  //   }
  //   SystemNavigator.pop();
  //   return true;
  // }
}
