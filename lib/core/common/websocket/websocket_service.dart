// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/constants/api_endpoints.dart';
// import 'package:web_socket_channel/io.dart';

// final webSocketServiceProvider =
//     Provider<WebSocketServices>((ref) => WebSocketServices());

// class WebSocketServices {
//   static IOWebSocketChannel? _channel;
//   static bool _isConnectedd = false;

//   static bool get isConnectedd => _isConnectedd;

//   static IOWebSocketChannel startWebSocket(void Function(dynamic) onData) {
//     void handleSocketError(dynamic error) {
//       //CustomToast.showToast("Socket: Error $error ");
//       Future.delayed(const Duration(seconds: 10), () {
//         startWebSocket(onData);
//       });
//     }

//     try {
//       _channel = IOWebSocketChannel.connect(ApiEndpoints.SOCKET_ADDRESS);

//       _channel!.stream.listen(
//         (message) {
//           onData(message);
//         },
//         onError: handleSocketError,
//         onDone: () {
//           //CustomToast.showToast("Socket: Connection closed");
//           _isConnectedd = false;
//         },
//       );

//       _isConnectedd = true;
//     } on SocketException catch (e) {
//       handleSocketError(e);
//     } catch (e) {
//       handleSocketError(e);
//     }

//     return _channel!;
//   }

//   static void closeWebSocket() {
//     _channel?.sink.close();
//     _isConnectedd = false;
//   }
// }

//new
// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/constants/api_endpoints.dart';
// import 'package:web_socket_channel/io.dart';

// final webSocketServiceProvider =
//     Provider<WebSocketServices>((ref) => WebSocketServices());

// class WebSocketServices {
//   IOWebSocketChannel? _channel;
//   bool _isConnectedd = false;

//   bool get isConnectedd => _isConnectedd;

//   IOWebSocketChannel startWebSocket(void Function(dynamic) onData) {
//     void handleSocketError(dynamic error) {
//       Future.delayed(const Duration(seconds: 10), () {
//         startWebSocket(onData);
//       });
//     }

//     try {
//       _channel = IOWebSocketChannel.connect(ApiEndpoints.SOCKET_ADDRESS);

//       _channel!.stream.listen(
//         (message) {
//           onData(message);
//         },
//         onError: handleSocketError,
//         onDone: () {
//           _isConnectedd = false;
//         },
//       );

//       _isConnectedd = true;
//     } on SocketException catch (e) {
//       handleSocketError(e);
//     } catch (e) {
//       handleSocketError(e);
//     }

//     return _channel!;
//   }

//   void closeWebSocket() {
//     _channel?.sink.close();
//     _isConnectedd = false;
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/api_endpoints.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/notification_view_model.dart';
import 'package:web_socket_channel/io.dart';

//bool isConnected = false;

final webSocketProvider = Provider<WebSocketServices>((ref) {
  final NotificationViewModel notificationViewModel =
      ref.read(notificationViewModelProvider);
  final IndexViewModelLive indexViewModel =
      ref.read(indexLiveViewModelProvider);
  final internetConnection = ref.watch(connectivityStatusProvider);
  final webSocketServices = WebSocketServices();

  if (ConnectivityStatus.isConnected == internetConnection) {
    //  isConnected = true;
    //print("*************Internet Connected***********");
    webSocketServices.startWebSocket((data, type) {
      if (type == 'news' || type == 'notification') {
        notificationViewModel.onDataCallback(data);
      } else {
        indexViewModel.onDataCallback(data);
      }
    });
  }
  // webSocketServices.startWebSocket((data, type) {
  //   if (type == 'news' || type == 'notification') {
  //     notificationViewModel.onDataCallback(data);
  //   } else {
  //     indexViewModel.onDataCallback(data);
  //   }
  // });

  return webSocketServices;
});

class WebSocketServices {
  late IOWebSocketChannel _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<void> startWebSocket(void Function(dynamic, String) onData) async {
    void handleSocketError(dynamic error) {
      Future.delayed(const Duration(seconds: 10), () {
        if (isConnected) {
          print("*************Reconnecting WebSocket***********");
          startWebSocket(onData);
        }
        // startWebSocket(onData);
      });
    }

    try {
      _channel = IOWebSocketChannel.connect(ApiEndpoints.SOCKET_ADDRESS);

      _channel.stream.listen(
        (message) {
          String messageType = getMessageType(message);

          onData(message, messageType);
        },
        onError: handleSocketError,
        onDone: () {
          _isConnected = false;
        },
      );

      _isConnected = true;
    } on SocketException catch (e) {
      handleSocketError(e);
    } catch (e) {
      handleSocketError(e);
    }
  }

  void closeWebSocket() {
    _channel.sink.close();
    _isConnected = false;
  }

  String getMessageType(dynamic messageData) {
    Map<String, dynamic> dataMap = json.decode(messageData);
    if (dataMap['type'] == 'news') {
      return 'news';
    }
    if (dataMap['type'] == 'index') {
      return 'index';
    } else {
      return 'notification';
    }
  }
}
