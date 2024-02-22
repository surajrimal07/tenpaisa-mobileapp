import 'package:flutter_riverpod/flutter_riverpod.dart';

final appKeysProvider = Provider<AppKeys>((ref) => AppKeys());

class AppKeys {
  String usertoken = 'userToken';
  String rememberMe = 'loginsaved';
  String otphash = 'otphash';
  String tempdata = 'tempdata';
  String email = 'email';
  String onboarding = 'onboarding';
  String isLoggedIn = 'isLoggedInn';
  String themeKey = 'themeKey';
  String tempemail = 'tempemail'; //used for forget pass and otp verification
  String tempRemember = 'tempRemember';
  String pass = 'tempPassword';
  //for local auth
  final String useFingerprint = 'useFingerprint';
  final String shakeToLogout = 'shakeToLogout';
}
