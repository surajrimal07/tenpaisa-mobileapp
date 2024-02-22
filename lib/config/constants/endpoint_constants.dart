import 'package:paisa/config/constants/api_endpoints.dart';

//final endPointsProvider = Provider.autoDispose<EndPoints>((ref) => EndPoints());

class EndPoints {
  static const String serverAddress = ApiEndpoints.SERVER_ADDRESS;
  static const String login = "$serverAddress${ApiEndpoints.LOGIN}";
  static const String verifyApi = "$serverAddress${ApiEndpoints.VERIFY_API}";
  static const String preVerify = "$serverAddress${ApiEndpoints.PRE_VERIFY}";
  static const String updateUser = "$serverAddress${ApiEndpoints.UPDATE_USER}";
  static const String deleteUser = "$serverAddress${ApiEndpoints.DELETE_USER}";
  static const String otpVerify = "$serverAddress${ApiEndpoints.OTP_VERIFY}";
  static const String signup = "$serverAddress${ApiEndpoints.SIGNUP}";
  static const String saveUser = "$serverAddress${ApiEndpoints.SAVE_USER}";
  static const String otpLogin = "$serverAddress${ApiEndpoints.OTP_LOGIN}";
  static const String whatToken = "$serverAddress${ApiEndpoints.WHATTOKEN}";
  static const String forget = "$serverAddress${ApiEndpoints.FORGET}";
  //
  static const String getCategories =
      "$serverAddress${ApiEndpoints.GET_ALLCATEGORIES}";
  static const String getCommodity =
      "$serverAddress${ApiEndpoints.GET_COMMODITY}";
  static const String getMetals = "$serverAddress${ApiEndpoints.METAL}";
  static const String getAllStock =
      "$serverAddress${ApiEndpoints.SHARESANSAR_ASSET_DATA}";
  static const String categorizedStock =
      "$serverAddress${ApiEndpoints.SHARESANSAR_ASSET_CATEGORIZED}";
  static const String getSingleStock =
      "$serverAddress${ApiEndpoints.SHARESANSAR_ASSET_SINGLE}";

  //portfolio
  static const String createPortfolio =
      "$serverAddress${ApiEndpoints.CREATE_PORTFOLIO}";
  static const String deletePortfolio =
      "$serverAddress${ApiEndpoints.DELETE_PORTFOLIO}";
  static const String getPortfolio = "$serverAddress${ApiEndpoints.GET_PORT}";
  static const String addStockToPortfolio =
      "$serverAddress${ApiEndpoints.ADD_STOCK_TO_PORTFOLIO}";
  static const String deleteStockFromPortfolio =
      "$serverAddress${ApiEndpoints.REM_STOCK_TO_PORTFOLIO}";
  static const String deleteportfolio =
      "$serverAddress${ApiEndpoints.DELETE_PORTFOLIO}";
  static const String renamePortfolio =
      "$serverAddress${ApiEndpoints.REM_PORT}";
  static const String addDefaultPortfolio =
      "$serverAddress${ApiEndpoints.ADD_DEFAULT_PORT}";

  static const String getIndex = "$serverAddress${ApiEndpoints.GET_Index}";
  static const String getNews = "$serverAddress${ApiEndpoints.NEWS}";
  static const String getIndexHistory =
      "$serverAddress${ApiEndpoints.INDEX_HISTORY}";
  static const String updateProfilePicture =
      "$serverAddress${ApiEndpoints.UPDATE_PROFILE_PICTURE}";

  //watchlist
  static const String createWatchlist =
      "$serverAddress${ApiEndpoints.CREATE_WATCHLIST}";
  static const String deleteWatchlist =
      "$serverAddress${ApiEndpoints.DELETE_WATCHLIST}";
  static const String getWatchlist =
      "$serverAddress${ApiEndpoints.GET_WATCHLIST}";
  static const String addStockToWatchlist =
      "$serverAddress${ApiEndpoints.ADD_STOCK_TO_WATCHLIST}";
  static const String deleteStockFromWatchlist =
      "$serverAddress${ApiEndpoints.REM_STOCK_TO_WATCHLIST}";
  static const String renameWatchlist =
      "$serverAddress${ApiEndpoints.RENAME_WATCHLIST}";
  static const String nrbData = "$serverAddress${ApiEndpoints.NRBDATA}";
  static const String worldData = "$serverAddress${ApiEndpoints.WORLDDATA}";
}
