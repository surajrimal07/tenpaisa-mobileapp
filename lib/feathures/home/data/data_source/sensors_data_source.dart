// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/feathures/home/domain/entity/accelerometer_entity.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// final accelerometerStreamProvider =
//     AutoDisposeStreamProvider<AccelerometerEntity>((ref) {
//   final streamController = StreamController<AccelerometerEntity>();

// // final accelerometerStreamProvider = StreamProvider<AccelerometerEntity>((ref) {
// //   final streamController = StreamController<AccelerometerEntity>();

//   final subscription = accelerometerEventStream().listen((event) {
//     streamController.add(AccelerometerEntity(
//       x: event.x,
//       y: event.y,
//       z: event.z,
//     ));
//   });

//   ref.onDispose(() {
//     subscription.cancel();
//     streamController.close();
//   });

//   return streamController.stream;
// });
