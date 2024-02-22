import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

class ConnectivityService {
  late StreamSubscription<InternetStatus> _subscription;

  final StreamController<bool> _connectionStatusController =
      StreamController<bool>();
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  ConnectivityService() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      _connectionStatusController.add(status == InternetStatus.connected);
    });
  }

  Stream<bool> checkConnection() async* {
    yield await InternetConnection().hasInternetAccess;
    yield* _connectionStatusController.stream;
  }

  void dispose() {
    _subscription.cancel();
    _connectionStatusController.close();
  }
}
