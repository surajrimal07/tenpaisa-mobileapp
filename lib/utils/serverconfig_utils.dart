// config.dart

class ServerConfig {
  static const String HTTPS = "http://";
  static const String PORT = ":5000";
  static const String ADDRESS = "192.168.101.9"; // Change me
  static const String SERVER_ADDRESS = "$HTTPS$ADDRESS$PORT";
  static const String SOCKET_ADDRESS = "ws://$ADDRESS:8081";
}
