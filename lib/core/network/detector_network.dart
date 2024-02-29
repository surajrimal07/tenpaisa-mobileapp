// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(),
);

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
  bool isChecked = false;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    //made default is connected
    //since at initial state we are not sure about the connectivity, and code
    //switches to local source which is wrong.
    //this creates issue with fetching user data when in splash screen
    //where status is disconnected by default and we are not able to fetch user data
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisconnected;
    }
    lastResult = ConnectivityStatus.notDetermined;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisconnected;
          break;
        default:
          newState = ConnectivityStatus.isDisconnected;
      }

      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }

  void setChecked(bool checked) {
    isChecked = checked;
  }
}

// final connectivityStatusProviders = StateNotifierProvider((ref) {
//   return ConnectivityStatusNotifier();
// });

// final connectivityStatusProviders = StateNotifierProvider((ref) {
//   return ConnectivityStatusNotifier();
// });

// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum ConnectivityStatus { isConnected, isDisconnected }

// class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
//   StreamController<ConnectivityResult> controller =
//       StreamController<ConnectivityResult>();

//   ConnectivityStatus? lastResult;
//   ConnectivityStatus? newState;
//   bool isChecked = false;

//   ConnectivityStatusNotifier() : super(ConnectivityStatus.isDisconnected) {
//     lastResult = ConnectivityStatus.isConnected;

//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       switch (result) {
//         case ConnectivityResult.mobile:
//         case ConnectivityResult.wifi:
//           newState = ConnectivityStatus.isConnected;
//           break;
//         case ConnectivityResult.none:
//           newState = ConnectivityStatus.isDisconnected;
//           break;
//         default:
//           newState = ConnectivityStatus.isDisconnected;
//       }

//       if (newState != lastResult) {
//         state = newState!;
//         lastResult = newState;
//       }
//     });
//   }

//   void setChecked(bool checked) {
//     isChecked = checked;
//   }
// }

// final connectivityStatusProviders = StateNotifierProvider((ref) {
//   return ConnectivityStatusNotifier();
// });



// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

// class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
//   final Connectivity _connectivity = Connectivity();

//   ConnectivityStatusNotifier() : super(ConnectivityStatus.isDisconnected) {
//     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _updateConnectivity(result);
//     });
//   }

//   void _updateConnectivity(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.wifi:
//         bool isConnected = await _pingServer();
//         state = isConnected
//             ? ConnectivityStatus.isConnected
//             : ConnectivityStatus.isDisconnected;
//         break;
//       case ConnectivityResult.none:
//         state = ConnectivityStatus.isDisconnected;
//         break;
//       default:
//         state = ConnectivityStatus.isDisconnected;
//     }
//   }

//   Future<bool> _pingServer() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       print(result);
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         print("Internet Availble");
//         return true;
//       } else {
//         print("Internet Not Availble");
//         return false;
//       }
//     } on SocketException catch (_) {
//       print("Internet Not Availble");
//       return false;
//     }
//   }
// }

// final connectivityStatusProviders =
//     StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
//         (ref) {
//   return ConnectivityStatusNotifier();
// });

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

// class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
//   final Connectivity _connectivity = Connectivity();

//   ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
//     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _updateConnectivity(result);
//     });

//     _initializeConnectivity();
//   }

//   void _initializeConnectivity() async {
//     ConnectivityResult connectivityResult =
//         await _connectivity.checkConnectivity();
//     _updateConnectivity(connectivityResult);
//   }

//   void _updateConnectivity(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.wifi:
//         bool isOnline = await InternetConnectionChecker().hasConnection;
//         print("Active Internet Available: $isOnline");
//         state = isOnline
//             ? ConnectivityStatus.isConnected
//             : ConnectivityStatus.isDisconnected;
//         break;
//       case ConnectivityResult.none:
//         print("No Internet Connection");
//         state = ConnectivityStatus.isDisconnected;
//         break;
//       default:
//         print("Unexpected Connectivity Result: $result");
//         state = ConnectivityStatus.isDisconnected;
//     }
//   }
// }

// final connectivityStatusProviders =
//     StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
//   (ref) {
//     return ConnectivityStatusNotifier();
//   },
// );
