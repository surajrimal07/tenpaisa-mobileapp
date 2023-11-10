import 'dart:io';

import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketServices {
  static IOWebSocketChannel startWebSocket(void Function(dynamic) onData) {
    late IOWebSocketChannel channel;

    void handleSocketError(dynamic error) {
      CustomToast.showToast("Socket: Error $error ");
      Future.delayed(const Duration(seconds: 5), () {
        // Restart WebSocket after 5 seconds
        startWebSocket(onData);
      });
    }

    try {
      channel = IOWebSocketChannel.connect('ws://192.168.101.4:8081');

      channel.stream.listen(
        (message) {
          onData(message);
        },
        onError: handleSocketError,
        onDone: () {
          CustomToast.showToast("Socket: Connection closed");
        },
      );
    } on SocketException catch (e) {
      handleSocketError(e);
    } catch (e) {
      handleSocketError(e);
    }

    return channel;
  }
}
