import 'dart:io';

import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketServices {
  static IOWebSocketChannel? _channel;
  static bool _isConnected = false;

  static bool get isConnected => _isConnected;

  static IOWebSocketChannel startWebSocket(void Function(dynamic) onData) {
    void handleSocketError(dynamic error) {
      CustomToast.showToast("Socket: Error $error ");
      Future.delayed(const Duration(seconds: 5), () {
        startWebSocket(onData);
      });
    }

    try {
      _channel = IOWebSocketChannel.connect(ServerConfig.SOCKET_ADDRESS);

      _channel!.stream.listen(
        (message) {
          onData(message);
        },
        onError: handleSocketError,
        onDone: () {
          CustomToast.showToast("Socket: Connection closed");
          _isConnected = false;
        },
      );

      _isConnected = true;
    } on SocketException catch (e) {
      handleSocketError(e);
    } catch (e) {
      handleSocketError(e);
    }

    return _channel!;
  }

  static void closeWebSocket() {
    _channel?.sink.close();
    _isConnected = false;
  }
}
