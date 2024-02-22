// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/feathures/home/data/data_source/sensors_data_source.dart';
// import 'package:paisa/feathures/home/domain/entity/accelerometer_entity.dart';

// //koi k garya k garya kai bhujeko vaye mari jau, stream complex rahexa

// // final shakeDetectionUseCaseProvider = Provider<ShakeDetectionUseCase>((ref) {
// //   return ShakeDetectionUseCase(
// //     ref.watch(accelerometerStreamProvider),
// //   );
// // });

// final shakeDetectionUseCaseProvider =
//     Provider.autoDispose<ShakeDetectionUseCase>((ref) {
//   final AutoDisposeStreamProvider<AccelerometerEntity>
//       accelerometerStreamProvide = ref.watch(accelerometerStreamProvider
//           as ProviderListenable<
//               AutoDisposeStreamProvider<AccelerometerEntity>>);

//   return ShakeDetectionUseCase(accelerometerStreamProvide);
// });

// class ShakeDetectionUseCase {
//   final AutoDisposeStreamProvider<AccelerometerEntity>
//       accelerometerStreamProvider;

//   ShakeDetectionUseCase(this.accelerometerStreamProvider);

//   void startShakeDetection({required VoidCallback onShakeDetected, ref}) {
//     watchForShake(ref).listen((isShakeDetected) {
//       if (isShakeDetected) {
//         onShakeDetected();
//       }
//     });
//   }

//   Stream<bool> watchForShake(WidgetRef ref) {
//     return ref
//         .watch(accelerometerStreamProvider.future)
//         .asStream()
//         .map((accelerometerData) {
//       final shakeDetector = ShakeDetector();
//       shakeDetector.updateCurrentData(accelerometerData);
//       return shakeDetector.isShakeDetected(accelerometerData);
//     }).where((value) => value);
//   }
// }

// class ShakeDetector {
//   AccelerometerEntity? currentData;
//   double accelerationThreshold = 12.0;

//   void updateCurrentData(AccelerometerEntity newData) {
//     currentData = newData;
//   }

//   bool isShakeDetected(AccelerometerEntity newData) {
//     if (currentData == null) {
//       return false;
//     }

//     double deltaX = newData.x - currentData!.x;
//     double deltaY = newData.y - currentData!.y;
//     double deltaZ = newData.z - currentData!.z;
//     double accelerationMagnitude =
//         sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

//     return accelerationMagnitude > accelerationThreshold;
//   }
// }

// import 'dart:ui';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/feathures/home/presentation/viewmodel/sensor_viewmodel.dart';
// import 'package:shake/shake.dart';

// final shakeDetectionUseCaseProvider =
//     Provider.autoDispose<ShakeDetectionUseCase>((ref) {
//   return ShakeDetectionUseCase(
//     onShakeDetected: () {
//       ref.read(shakeDetectionViewModelProvider).onShakeDetected();
//     },
//   );
// });

// class ShakeDetectionUseCase {
//   final VoidCallback onShakeDetected;
//   late ShakeDetector _detector;

//   ShakeDetectionUseCase({
//     required this.onShakeDetected,
//   }) {
//     _detector = ShakeDetector.autoStart(
//       onPhoneShake: () {
//         onShakeDetected();
//       },
//       minimumShakeCount: 1,
//       shakeSlopTimeMS: 500,
//       shakeCountResetTime: 3000,
//       shakeThresholdGravity: 2.7,
//     );
//   }

//   void stopShakeDetection() {
//     _detector.stopListening();
//   }

//   void startShakeDetection() {
//     _detector.startListening();
//   }
// }

