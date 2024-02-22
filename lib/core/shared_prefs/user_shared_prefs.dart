import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  var userSharedPrefs = UserSharedPrefs();
  userSharedPrefs.init();

  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  final AppKeys appKeys = AppKeys();
  bool _isInitialized = false;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  // Ensure that _sharedPreferences is initialized before calling other methods
  Future<void> _checkInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<bool> setUserPass(String pass) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.pass, pass);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUserPass() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final pass = _sharedPreferences.getString(appKeys.pass);
      return pass;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteUserPass() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.pass);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setUserEmail(String email) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.email, email);
      return true;
    } catch (e) {
      return false;
    }
  }

  //for fp login
  Future<void> setUseFingerprint() async {
    try {
      await _checkInitialized();
      await _sharedPreferences.setBool(appKeys.useFingerprint, true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

Future<bool> isShakeEnabled(String? value) async {
  await _checkInitialized();

  if (value == null || value.isEmpty) {
    bool data = _sharedPreferences.getBool(appKeys.shakeToLogout) ?? false;
    return data;
  } else if (value == "true") {
    await _sharedPreferences.setBool(appKeys.shakeToLogout, true);
    return true;
  } else if (value == "false") {
    await _sharedPreferences.setBool(appKeys.shakeToLogout, false);
    return false;
  } else {
    throw ArgumentError("Invalid value for 'isShakeEnabled': $value");
  }
}
  Future<void> remUseFingerprint() async {
    try {
      await _checkInitialized();
      await _sharedPreferences.setBool(appKeys.useFingerprint, false);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> getUseFingerprint() async {
    try {
      await _checkInitialized();
      return _sharedPreferences.getBool(appKeys.useFingerprint) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final email = _sharedPreferences.getString(appKeys.email);
      return email;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteUserEmail() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveTempEmail(String email) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.tempemail, email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveTempUserData(String data) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.tempdata, data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> getTempUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final data = _sharedPreferences.getString(appKeys.tempdata);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> settempRememberMe(bool value) async {
    //user le register ma rememberme click gare tyo
    ///yaha save garne ani last ma final registration ma yo value
    ///extract garera shared prefs ma save garne, only for temo use
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(appKeys.tempRemember, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> gettempRememberMe() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final rememberMe =
          _sharedPreferences.getBool(appKeys.tempRemember) ?? false;
      return rememberMe;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletetempRememberMe() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.tempRemember);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTempUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.tempdata);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getTempEmail() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final email = _sharedPreferences.getString(appKeys.tempemail);
      return email;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTempEmail() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.tempemail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.usertoken, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString(appKeys.usertoken);
      return token;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.usertoken);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setRememberMe(bool value) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(appKeys.rememberMe, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getRememberMe() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final rememberMe =
          _sharedPreferences.getBool(appKeys.rememberMe) ?? false;
      return rememberMe;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteRememberMe() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.rememberMe);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveHash(String hash) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.otphash, hash);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getHash() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final hash = _sharedPreferences.getString(appKeys.otphash) ?? "";
      return hash;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteHash() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.otphash);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getOnBoarded() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final isOnBoarded =
          _sharedPreferences.getBool(appKeys.onboarding) ?? false;
      return isOnBoarded;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setOnBoarded() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(appKeys.onboarding, true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteOnBoarded() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(appKeys.onboarding);
      return true;
    } catch (e) {
      return false;
    }
  }

  // bool get useFingerprint =>
  //     _sharedPreferences.getBool("useFingerprint") ?? false;

  // set useFingerprint(bool value) {

  Future<bool> getLoggedIn() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final isLoggedIn =
          _sharedPreferences.getBool(appKeys.isLoggedIn) ?? false;
      return isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setLoggedIn() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(appKeys.isLoggedIn, true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> remLoggedIn() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(appKeys.isLoggedIn, false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getThemeKey() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final themeKey =
          _sharedPreferences.getString(appKeys.themeKey) ?? "light";
      return themeKey;
    } catch (e) {
      return "light";
    }
  }

  Future<void> setThemeMode(String themeKey) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(appKeys.themeKey, themeKey);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ThemeMode> getThemeMode() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final themeKey = await getThemeKey();
      switch (themeKey) {
        case "light":
          return ThemeMode.light;
        case "dark":
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    } catch (e) {
      return ThemeMode.light;
    }
  }
}
