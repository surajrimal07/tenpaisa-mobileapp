// ignore_for_file: use_build_context_synchronously

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:image_picker/image_picker.dart';
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
  int indexBottomBar = 4;
  String currentName = "";
  String currentPass = "";
  String currentEmail = "";
  String currentPhone = "";
  String currentDP = "assets/images/content/default.png";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPhoneController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
//updating image is broken, needs more logic,
  //XFile? _pickedImage; // Initialize with null

  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedImage =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     //bool success = await UserService.uploadProfilePicture(pickedImage.path);

  //     // if (success) {
  //     //   // Update the user's profile picture URL
  //     //   //await UserService.updateUserProfilePictureUrl();

  //     //   setState(() {
  //     //     // Get the updated profile picture URL
  //     //     //currentDP = UserService.getUpdatedProfilePictureUrl();
  //     //   });
  //     // } else {
  //     //   CustomToast.showToast("Failed to upload profile picture");
  //     // }
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: MyColors.btnColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: currentName,
              userProfilePic: AssetImage(currentDP),
              imageRadius: 80,
              //onTap: (_pickImage),
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
                  subtitle: currentEmail.isEmpty ? 'No Email' : currentEmail,
                ),
                SettingsItem(
                  onTap: () => showPhoneChangeDialog(context),
                  icons: Icons.phone,
                  title: 'Phone',
                  subtitle: currentPhone.isEmpty ? 'No Phone' : currentPhone,
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
                  onTap: () => deleteAccount(context),
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
        backgroundColor: MyColors.btnColor,
        currentIndex: indexBottomBar,
        onTap: (i) {
          if (i == 4) {
            setState(() => indexBottomBar = i);
          } else if (i == 0) {
            Navigator.pushNamed(context, AppRoute.dashboardRoute);
          } else if (i == 2) {
            Navigator.pushNamed(context, AppRoute.portRoute);
          } else if (i == 1) {
            Navigator.pushNamed(context, AppRoute.searchRoute);
          } else if (i == 3) {
            Navigator.pushNamed(context, AppRoute.walletRoute);
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

                //String? checktoken = prefs.getString('userToken');
                //print("is token null after logged out: $checktoken");
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

                      try {
                        await UserService.updateUser("name", newName, "");
                        updateName(newName);
                        CustomToast.showToast("Name Updated");
                      } catch (error) {
                        CustomToast.showToast("Error occured");
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

  Future<void> deleteAccount(BuildContext context) async {
    String? passError;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Delete Account"),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Please Enter your password"),
                    TextFormField(
                      controller: newPassController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
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
                    newPassController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String pass = newPassController.text;

                      try {
                        await UserService.deleteUser(pass, context);

                        CustomToast.showToast("Account Deleted");
                      } catch (error) {
                        if (error == "401") {
                          CustomToast.showToast("Password Incorrect");
                        } else {
                          CustomToast.showToast("Error occured");
                        }
                      }
                      newPassController.clear();
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        passError = 'Password is empty';
                      });
                    }
                  },
                  child: const Text("Delete"),
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
                        try {
                          CustomToast.showToast("Password Updated");
                          await UserService.updateUser(
                              "password", newPassword, "");
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
                        await UserService.updateUser("email", newEmail, "");
                        updateEmail(newEmail);
                        Navigator.of(context).pop();
                        CustomToast.showToast("Saved: $newEmail");
                      } catch (error) {
                        if (error == "400") {
                          setState(() {
                            emailError = 'Email already exists';
                          });
                        } else {
                          CustomToast.showToast("Error occured updating Email");
                        }
                      }
                    } else {
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
                    "Current Phone: ${currentPhone.isEmpty ? "No Number" : currentPhone}",
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
                        await UserService.updateUser("phone", newPhone, "");
                        updatePhone(newPhone);
                        //updateUserData("name", newName);
                        CustomToast.showToast("Saved: $newPhone");
                      } catch (error) {
                        if (error == "400") {
                          setState(() {
                            phoneError = 'Phone already exists';
                          });
                        } else {
                          CustomToast.showToast("Error occured updating Email");
                        }
                      }

                      Navigator.of(context).pop();
                    } else {
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
