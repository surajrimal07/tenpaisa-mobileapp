// ignore_for_file: constant_identifier_names

class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String HTTPS = "http://";
  static const String PORT = ":5000";

  //localhost
  static const String ADDRESS = "192.168.101.8";
  static const String SERVER_ADDRESS = "$HTTPS$ADDRESS$PORT";

  //google cloud
  //static const String ADDRESS = "paisabackend.el.r.appspot.com";
  //static const String SERVER_ADDRESS = "$HTTPS$ADDRESS";

  //for socket
  static const String SOCKET_ADDRESS = "ws://$ADDRESS:8081";

//
  static const String VERIFY_API = "/api/verify";
  static const String UPDATE_USER = "/api/updateuser";
  static const String DELETE_USER = "/api/delete-acc";
  static const String LOGIN = "/api/login";
  static const String SIGNUP = "/api/otp-login";
  static const String OTP_VERIFY = "/api/otp-verify";
  static const String SAVE_USER = "/api/create";
  static const String OTP_LOGIN = "/api/otp-login";
  static const String PRE_VERIFY = "/api/pre-verify";
  static const String FORGET = "/api/forget";
  static const String UPDATE_PROFILE_PICTURE = "/api/updateprofilepic";

  static const String NEWS = "/news";
  static const String WHATTOKEN = "/api/whattoken";
  static const String GET_ASSET = "/api/multiassetdetails";
  static const String GET_SINGLEASSET = "/api/singleassetdetails";
  static const String GET_COMMODITY = "/api/commodity";
  static const String GAINERS = "/api/topgainers";
  static const String LOOSERS = "/api/toploosers";
  static const String METALHISTORY = "/api/metalhist";
  static const String METAL = "/api/metal";
  static const String TURNOVER = "/api/topturnover";
  static const String VOLUME = "/api/topvolume";
  static const String TRANSACTION = "/api/toptrans";

  //portfolio
  static const String CREATE_PORTFOLIO = "/api/newport";
  static const String ADD_STOCK_TO_PORTFOLIO = "/api/addstock";
  static const String REM_STOCK_TO_PORTFOLIO = "/api/remstock";
  static const String DELETE_PORTFOLIO = "/api/delport";
  static const String GET_PORT = "/api/getallportforuser";
  static const String REM_PORT = "/api/renameportfolio";
  static const String ADD_DEFAULT_PORT = "/api/adddefaultport";
  static const String REM_DEFAULT_PORT = "/api/removedefaultport";

  static const String SHARESANSAR_ASSET_DATA = "/api/sharesansardata";
  static const String SHARESANSAR_ASSET_SINGLE = "/api/singlesharesansardata";
  static const String SHARESANSAR_ASSET_CATEGORIZED =
      "/api/sectorsharesansardata";
  //all categores in same json
  static const String GET_ALLCATEGORIES = "/api/dashboard";
  static const String GET_Index = "/api/index";
  static const String INDEX_HISTORY = "/api/combinedindex";
  static const int limitPage = 10;

  //watchlist
  static const String CREATE_WATCHLIST = "/api/createwatchlist";
  static const String GET_WATCHLIST = "/api/getwatchlist";
  static const String ADD_STOCK_TO_WATCHLIST = "/api/addstocktowatchlist";
  static const String REM_STOCK_TO_WATCHLIST = "/api/remstockfromwatchlist";
  static const String DELETE_WATCHLIST = "/api/deletewatchlist";
  static const String RENAME_WATCHLIST = "/api/renamewatchlist";

  //other data of nrb
  static const String NRBDATA = "/api/combinednrbdata";
  static const String WORLDDATA = "/api/worldmarketdata";
}
