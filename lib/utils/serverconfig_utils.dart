// config.dart

class ServerConfig {
  static const String HTTPS = "http://";
  static const String PORT = ":5000";
  static const String ADDRESS = "192.168.101.9"; // Change me
  static const String SERVER_ADDRESS = "$HTTPS$ADDRESS$PORT";
  static const String SOCKET_ADDRESS = "ws://$ADDRESS:8081";

  static const String VERIFY_API = "/api/verify";
  static const String UPDATE_USER = "/api/updateuser";
  static const String DELETE_USER = "/api/delete-acc";
  //static const String SAVE_TOKEN = "/api/savetkn";
  static const String LOGIN = "/api/login";
  static const String SIGNUP = "/api/otp-login";
  static const String OTP_VERIFY = "/api/otp-verify";
  static const String SAVE_USER = "/api/create";
  static const String OTP_LOGIN = "/api/otp-login";
  static const String PRE_VERIFY = "/api/pre-verify";
  static const String FORGET = "/api/forget";
  static const String NEWS = "/news";
  static const String WHATTOKEN = "/api/whattoken";
}
