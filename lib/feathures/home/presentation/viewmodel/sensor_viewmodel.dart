// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
// import 'package:paisa/feathures/auth/presentation/widget/logout_dialog.dart';
// import 'package:paisa/feathures/home/domain/usecase/shake_detect_usecase.dart';

// final shakeDetectionViewModelProvider =
//     ChangeNotifierProvider<ShakeDetectionViewModel>(
//   (ref) {
//     final shakeDetectionUseCase = ref.read(shakeDetectionUseCaseProvider);
//     final userSharedPrefs = ref.read(userSharedPrefsProvider);

//     return ShakeDetectionViewModel(
//       shakeDetectionUseCase: shakeDetectionUseCase,
//       userSharedPrefs: userSharedPrefs,
//     );
//   },
// );

// class ShakeDetectionViewModel extends ChangeNotifier {
//   final ShakeDetectionUseCase shakeDetectionUseCase;
//   final UserSharedPrefs userSharedPrefs;

//   bool _shakeEnabled = false;
//   bool get shakeEnabled => _shakeEnabled;

//   ShakeDetectionViewModel({
//     required this.shakeDetectionUseCase,
//     required this.userSharedPrefs,
//   }) {
//     print("Is shake enabled: 31");
//     initIsShake();
//   }

//   Future<void> initIsShake() async {
//     _shakeEnabled = await userSharedPrefs.isShakeEnabled(null);
//     print("Is shake enabled: $_shakeEnabled");
//     notifyListeners();

//     if (_shakeEnabled) {
//       startShakeDetection();
//       // shakeDetectionUseCase.startShakeDetection(
//       //   onShakeDetected: () {
//       //     print(_shakeEnabled);
//       //     // _showSignOutDialog();
//       //   },
//       // );
//     }
//   }

//   void startShakeDetection() {
//     shakeDetectionUseCase.startShakeDetection(
//       onShakeDetected: () {
//         print(_shakeEnabled);
//         // _showSignOutDialog();
//       },
//     );
//   }

//   void showSignOutDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return SignOutDialog(context: context, ref: ref);
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
// import 'package:shake/shake.dart';

// final shakeDetectionViewModelProvider =
//     ChangeNotifierProvider<ShakeDetectionViewModel>(
//   (ref) {
//     final userSharedPrefs = ref.read(userSharedPrefsProvider);

//     return ShakeDetectionViewModel(
//       userSharedPrefs: userSharedPrefs,
//     );
//   },
// );

// class ShakeDetectionViewModel extends ChangeNotifier {
//   final UserSharedPrefs userSharedPrefs;

//   bool _shakeEnabled = false;
//   bool get shakeEnabled => _shakeEnabled;

//   ShakeDetectionViewModel({
//     required this.userSharedPrefs,
//   });

//   Future<void> initIsShake(WidgetRef ref, BuildContext context) async {
//     _shakeEnabled = await userSharedPrefs.isShakeEnabled(null);
//     notifyListeners();

//     if (_shakeEnabled) {
//       print("Shake enabled");
//       ShakeDetector detector = ShakeDetector.autoStart(
//         onPhoneShake: () {
//           // showDialog(
//           //   context: context,
//           //   builder: (context) {
//           //     return SignOutDialog(context: context, ref: ref);
//           //   },
//           // );
//         },
//         shakeThresholdGravity: 1.5,
//       );

//       // To close: detector.stopListening();
//       // ShakeDetector.waitForStart()
//     }
//   }
// }

import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/presentation/widget/logout_dialog.dart';

final shakeDetectionViewModelProvider =
    ChangeNotifierProvider<ShakeDetectionViewModel>(
  (ref) {
    final userSharedPrefs = ref.read(userSharedPrefsProvider);

    return ShakeDetectionViewModel(
      userSharedPrefs: userSharedPrefs,
    );
  },
);

class ShakeDetectionViewModel extends ChangeNotifier {
  final UserSharedPrefs userSharedPrefs;

  bool _shakeEnabled = false;
  bool get shakeEnabled => _shakeEnabled;

  ShakeDetectionViewModel({
    required this.userSharedPrefs,
  });

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool _isListening = false;
  bool _isDialogShowing = false;

  Future<void> initIsShakes(BuildContext context, WidgetRef ref) async {
    if (_isListening) return;

    _shakeEnabled = await userSharedPrefs.isShakeEnabled(null);
    //   print("Is shake enabled: $_shakeEnabled");
    // notifyListeners(); //-- this throws error if shake to enable is disabled
    //find it challenging to fix it

    if (_shakeEnabled) {
//      print("Shake enabled");

      _accelerometerSubscription = accelerometerEvents!.listen((event) {
        if (!_shakeEnabled) {
          _accelerometerSubscription?.cancel();
          _isListening = false;
          return;
        }

        double accelerationMagnitude = _calculateAccelerationMagnitude(event);

        if (accelerationMagnitude > 20.0 && !_isDialogShowing) {
          print("Shake detected");

          _isDialogShowing = true;

          showDialog(
            context: context,
            builder: (context) {
              return const SignOutDialog();
            },
          ).then((_) {
            _isDialogShowing = false;
          });

          Timer(const Duration(seconds: 5), () {
            _isDialogShowing = false;
          });
        }
      });

      _isListening = true;
    } else {
      _accelerometerSubscription?.cancel();
      _isListening = false;
      //super.dispose(); // causes exceptions //so moved it below
    }
  }

  double _calculateAccelerationMagnitude(AccelerometerEvent event) {
    return event.x.abs() + event.y.abs() + event.z.abs();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }
}
