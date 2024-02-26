import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/api_endpoints.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final httpServiceProvider = Provider<Dio>(
  (ref) => HttpService(Dio()).dio,
);

final sharedPrefs = ProviderContainer().read(userSharedPrefsProvider);

class HttpService {
  final Dio _dio;

  late String? userToken;

  Dio get dio => _dio;

  Future<Map<String, String>> getHeaders() async {
    final userToken = await sharedPrefs.getUserToken() ?? "";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    return headers;
  }

  Future<void> initializeHeaders() async {
    _dio.options.headers = await getHeaders();
  }

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.SERVER_ADDRESS
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(ErrorInterceptor())
      ..options.validateStatus = (int? status) {
        return status != null;
      };

    initializeHeaders().then((_) {
      _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioException e, handler) {
          CustomToast.showToast(e.message.toString());
          handler.next(e);
        },
      ));

      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseBody: true,
        error: true,
        requestBody: true,
        responseHeader: true,
      ));
    });
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 500;
    if (!isValid) {
      CustomToast.showToast("Error: $status");
      // throw DioException.badResponse(
      //   statusCode: status!,
      //   requestOptions: response.requestOptions,
      //   response: response,
      // );
    }
    super.onResponse(response, handler);
  }
}





// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/constants/api_endpoints.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import 'dio_error_interceptor.dart';

// final httpServiceProvider = Provider<Dio>(
//   (ref) => HttpService(Dio()).dio,
// );

// class HttpService {
//   final Dio _dio;

//   Dio get dio => _dio;

//   HttpService(this._dio) {
//     _dio
//       ..options.baseUrl = ApiEndpoints.SERVER_ADDRESS
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..interceptors.add(PrettyDioLogger(
//           requestHeader: true, requestBody: true, responseHeader: true))
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };
//   }
// }
