// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/common/localauth/local_Auth.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';
import 'package:paisa/feathures/auth/presentation/widget/change_theme_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/delete_account_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/emailchange_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/fingetprint_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/logout_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/namechange_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/password_change.dart';
import 'package:paisa/feathures/auth/presentation/widget/phone_change_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/shake_logout.dart';
import 'package:paisa/feathures/auth/presentation/widget/stylechange_dialog.dart';
import 'package:paisa/feathures/auth/presentation/widget/subscription_dialog.dart';
import 'package:paisa/feathures/common/animated_page_transition.dart';
import 'package:paisa/feathures/home/presentation/view/wallet_view.dart';
import 'package:paisa/feathures/home/presentation/widget/about_us.dart';
import 'package:paisa/feathures/home/presentation/widget/data_decode.dart';
import 'package:paisa/feathures/home/presentation/widget/data_sources.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<AccountView> {

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource, email) async {
    //shift to viewmodel
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref
              .read(authViewModelProvider.notifier)
              .updateProfile(_img!, email, ref);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(appThemeStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(ProfileStrings.profile)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SmallUserCard(
              cardColor:
                  ref.watch(authEntityProvider.select((it) => it.premium)) ==
                          false
                      ? Colors.grey[600]
                      : const Color.fromARGB(255, 38, 92, 41),

              onTap: () {
                showModalBottomSheet(
                  backgroundColor: AppTheme.isDarkMode(context)
                      ? Colors.grey[900]
                      : Colors.white,
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // checkCameraPermission();
                            ref
                                .watch(authViewModelProvider.notifier)
                                .cameraPermission();
                            _browseImage(
                              ref,
                              ImageSource.camera,
                              ref.watch(
                                  authEntityProvider.select((it) => it.email)),
                            );
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text(ProfileStrings.camera),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _browseImage(
                              ref,
                              ImageSource.gallery,
                              ref.watch(
                                  authEntityProvider.select((it) => it.email)),
                            );
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.image),
                          label: const Text(ProfileStrings.gallery),
                        ),
                      ],
                    ),
                  ),
                );
              },
              userName: ref.watch(authEntityProvider.select((it) => it.name)),
              userProfilePic: NetworkImage(
                  ref.watch(authEntityProvider.select((it) => it.picture))!),
              //imageRadius: 80,
              //icon: const Icon(Iconsax.activity),
              userMoreInfo: Text(
                ref.watch(authEntityProvider.select((it) => it.premium)) ==
                        false
                    ? ProfileStrings.freeUser
                    : ProfileStrings.premiumUser,
                style: const TextStyle(color: AppColors.backgroundColor),
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: ProfileStrings.profile,
              settingsGroupTitleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              items: [
                SettingsItem(
                  onTap: () => showNameChangeDialog(),
                  icons: Icons.person_2_outlined,
                  title: ProfileStrings.name,
                  subtitle:
                      ref.watch(authEntityProvider.select((it) => it.name)),
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () => showPasswordChangeDialog(),
                  icons: Icons.password_outlined,
                  title: ProfileStrings.password,
                  subtitle: "******",
                  titleMaxLine: 1,
                  subtitleMaxLine: 1,
                ),
                SettingsItem(
                  onTap: () => showEmailChangeDialog(),
                  icons: Icons.email_outlined,
                  title: ProfileStrings.email,
                  subtitle:
                      ref.watch(authEntityProvider.select((it) => it.email)),
                ),
                SettingsItem(
                  onTap: () => showPhoneChangeDialog(),
                  icons: Icons.phone,
                  title: ProfileStrings.phone,
                  subtitle: ref
                      .watch(authEntityProvider.select((it) => it.phone))
                      .toString(),
                ),
                SettingsItem(
                  onTap: () {
                    animatednavigateTo(context, const WalletViews());
                  },
                  icons: Icons.account_balance_wallet_outlined,
                  title: ProfileStrings.balance,
                  subtitle:
                      'Rs: ${ref.watch(authEntityProvider.select((it) => it.userAmount))}',
                ),
                SettingsItem(
                  onTap: () => showInvChangeDialog(),
                  icons: Icons.type_specimen_outlined,
                  title: ProfileStrings.accountGoal,
                  subtitle: decodeInvStyle(ref.watch(
                      authEntityProvider.select((it) => it.invstyle ?? 0))),
                ),
                SettingsItem(
                  onTap: () => showPremiumDialog(),
                  icons: Icons.workspace_premium_outlined,
                  title: ProfileStrings.premium,
                  subtitle: ref
                      .watch(authEntityProvider.select((it) => it.premium))
                      .toString(),
                ),
                SettingsItem(
                  onTap: () {
                    CustomToast.showToast(ProfileStrings.adminStatusCan,
                        customType: Type.info);
                  },
                  icons: Icons.admin_panel_settings_outlined,
                  title: ProfileStrings.admin,
                  subtitle: ref
                      .watch(authEntityProvider.select((it) => it.isAdmin))
                      .toString(),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_outlined,
                  // iconStyle: IconStyle(
                  //   iconsColor: Colors.white,
                  //   //withBackground: true,
                  //   // backgroundColor: Colors.red,
                  // ),
                  title: 'Dark mode',
                  subtitle:
                      AppTheme.isDarkMode(context) ? "Dark Mode" : "Light Mode",
                  trailing: Switch.adaptive(
                    value: themeState.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        themeState.setDarkTheme();
                      } else {
                        themeState.setLightTheme();
                      }
                    },
                  ),
                )
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: ProfileStrings.account,
              settingsGroupTitleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              items: [
                // SettingsItem(
                //   onTap: () => changeThemeDialog(),
                //   icons: Icons.dark_mode_outlined,
                //   title: ProfileStrings.theme,
                //   subtitle:
                //       AppTheme.isDarkMode(context) ? "Dark Mode" : "Light Mode",
                // ),
                SettingsItem(
                  onTap: () => changeBiometricsDialog(),
                  icons: Icons.fingerprint_outlined,
                  //   subtitle: _fingerprintState,
                  title: ProfileStrings.biometricsLogin,
                ),
                SettingsItem(
                  onTap: () => changeShakeToLogoutDialog(),
                  icons: Icons.vibration_outlined,
                  title: ProfileStrings.shakeToLogout,
                ),
                SettingsItem(
                  onTap: () => showSignOutDialog(),
                  icons: Icons.exit_to_app_rounded,
                  title: ProfileStrings.logout,
                ),
                SettingsItem(
                  onTap: () => deleteAccount(),
                  icons: CupertinoIcons.delete_solid,
                  title: ProfileStrings.deleteAccount,
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  onTap: () => dataSources(),
                  icons: Icons.data_object_outlined,
                  title: ProfileStrings.dataSources,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  onTap: () => aboutUs(),
                  icons: Icons.app_registration_outlined,
                  title: ProfileStrings.aboutUs,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changeThemeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ChangeThemeDialog();
      },
    );
  }

  // Future<String> getFingerprintSate() async {
  //   final isBiometricsAvailable =
  //       await ref.read(localAuthProvider).isBiometricsAvailable();
  //   final userSharedPrefs = ref.read(userSharedPrefsProvider);
  //   if (isBiometricsAvailable) {
  //     bool data = await userSharedPrefs.getUseFingerprint();
  //     if (data == true) {
  //       return "Enabled";
  //     } else {
  //       return "Disabled";
  //     }
  //   } else {
  //     return "Disabled";
  //   }
  // }

  Future<void> changeShakeToLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShakeLogoutDialog(
            userSharedPrefs: ref.read(userSharedPrefsProvider));
      },
    );
  }

  Future<void> changeBiometricsDialog() async {
    final isBiometricsAvailable =
        await ref.read(localAuthProvider).isBiometricsAvailable();
    final userSharedPrefs = ref.read(userSharedPrefsProvider);

    if (isBiometricsAvailable) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BiometricsAlertDialog(userSharedPrefs: userSharedPrefs);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(ProfileStrings.biometricsLogin),
            content: const Text(ProfileStrings.noHardware),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(ProfileStrings.ok),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> showSignOutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignOutDialog();
      },
    );
  }

  Future<void> showNameChangeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ChangeNameDialog();
      },
    );
  }

  Future<void> showInvChangeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const InvestmentStyleChangeDialog();
      },
    );
  }

  Future<void> showPremiumDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PremiumSubscriptionDialog();
      },
    );
  }

  Future<void> deleteAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeleteAccountDialog();
      },
    );
  }

  Future<void> dataSources() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DataSourcesView();
      },
    );
  }

  Future<void> aboutUs() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AboutUsView();
      },
    );
  }

  Future<void> showPasswordChangeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PasswordChangeDialog();
      },
    );
  }

  Future<void> showEmailChangeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const EmailChangeDialog();
      },
    );
  }

  Future<void> showPhoneChangeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PhoneChangeDialog();
      },
    );
  }
}
