import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appSharedPrefsProviderr = Provider<UserSharedPrefss>((ref) {
  return UserSharedPrefss();
});

class UserSharedPrefss {
  late SharedPreferences _sharedPreferences;

  Future<Either<Failure, bool>> saveData<T>(String key, T data) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      if (data is String) {
        await _sharedPreferences.setString(key, data);
      } else if (data is int) {
        await _sharedPreferences.setInt(key, data);
      } else if (data is double) {
        await _sharedPreferences.setDouble(key, data);
      } else if (data is bool) {
        await _sharedPreferences.setBool(key, data);
      } else {
        final errorMessage = 'Unsupported data type: ${T.toString()}';
        CustomToast.showToast(errorMessage);
        return left(Failure(error: errorMessage));
      }

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, T?>> getData<T>(String key) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      if (T == String) {
        final data = _sharedPreferences.getString(key) as T?;
        return right(data);
      } else if (T == int) {
        final data = _sharedPreferences.getInt(key) as T?;
        return right(data);
      } else if (T == double) {
        final data = _sharedPreferences.getDouble(key) as T?;
        return right(data);
      } else if (T == bool) {
        final data = _sharedPreferences.getBool(key) as T?;
        return right(data);
      } else {
        final errorMessage = 'Unsupported data type: ${T.toString()}';
        CustomToast.showToast(errorMessage);
        return left(Failure(error: errorMessage));
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteData(String key) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(key);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  setThemeKey(String s) {}

  Future<void> saveShakeToLogoutOption(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shake_to_logout_enabled', value ?? false);
  }

  Future<bool?> loadShakeToLogoutOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('shake_to_logout_enabled');
  }
}

//****Usage *******//
// final result = await ref
//     .read(userSharedPrefsProvider)
//     .saveData<String>('token', 'your_token_value');