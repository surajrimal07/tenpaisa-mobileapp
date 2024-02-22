// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/constants/api_endpoints.dart';
// import 'package:paisa/core/network/http/dio_error_interceptor.dart';
// import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// final httpServiceProvider = Provider.autoDispose<Dio>(
//   (ref) => HttpService(Dio()).dio,
// );

// final sharedPrefs = ProviderContainer().read(userSharedPrefsProvider);

// class HttpService {
//   final Dio _dio;

//   late String? userToken;

//   Dio get dio => _dio;

//   Future<void> getHeader() async {
//     userToken = await sharedPrefs.getUserToken();
//     bool? getRememberMe = await sharedPrefs.getRememberMe();

//     if (userToken != null && getRememberMe) {
//       print("Header with Token");
//       _dio.options.headers['Accept'] = 'application/json';
//       _dio.options.headers['Content-Type'] = 'application/json';
//       _dio.options.headers['Authorization'] = 'Bearer $userToken';
//     }

//     _dio.options.headers['Accept'] = 'application/json';
//     _dio.options.headers['Content-Type'] = 'application/json';
//   }

//   HttpService(this._dio) {
//     initializeHeaders();
//   }

//   Future<void> initializeHeaders() async {
//     userToken = await sharedPrefs.getUserToken();
//     bool? getRememberMe = await sharedPrefs.getRememberMe();

//     _dio
//       ..options.baseUrl = ApiEndpoints.SERVER_ADDRESS
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..interceptors.add(PrettyDioLogger(
//           requestHeader: true,
//           responseBody: true,
//           error: true,
//           requestBody: true,
//           responseHeader: true))
//       //use headers from getHeader here
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/config/constants/api_endpoints.dart';
// import 'package:paisa/core/network/http/dio_error_interceptor.dart';
// import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// final httpServiceProvider = Provider.autoDispose<Dio>(
//   (ref) => HttpService(Dio()).dio,
// );

// final sharedPrefs = ProviderContainer().read(userSharedPrefsProvider);

// class HttpService {
//   final Dio _dio;

//   late String? userToken;

//   Dio get dio => _dio;

//   HttpService(this._dio) {
//     initializeHeaders();
//   }

//   Future<void> initializeHeaders() async {
//     userToken = await sharedPrefs.getUserToken();
//     bool? getRememberMe = await sharedPrefs.getRememberMe();

//     _dio
//       ..options.baseUrl = ApiEndpoints.SERVER_ADDRESS
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };

//     if (userToken != null && getRememberMe == true) {
//       print("Header with Token");
//       _dio.options.headers['Authorization'] = 'Bearer $userToken';
//     } else {
//       print("Header without Token");
//     }

//     _dio.interceptors.add(PrettyDioLogger(
//         requestHeader: true,
//         responseBody: true,
//         error: true,
//         requestBody: true,
//         responseHeader: true));
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/api_endpoints.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final httpServiceProvider = Provider.autoDispose<Dio>(
  (ref) => HttpService(Dio()).dio,
);

final sharedPrefs = ProviderContainer().read(userSharedPrefsProvider);

class HttpService {
  final Dio _dio;

  late String? userToken;

  Dio get dio => _dio;

  Future<Map<String, String>> getHeaders() async {
    final userToken = await sharedPrefs.getUserToken() ?? "";
    //print("userToken to use in headers: $userToken");
    //bool? getRememberMe = await sharedPrefs.getRememberMe();

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    // if (userToken != null) {
    //   //&& getRememberMe == true
    //   print("Header with Token");
    //   headers['Authorization'] = 'Bearer $userToken';
    // } else {
    //   print("Header without Token");
    // }

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
      ..interceptors
          .add(ErrorInterceptor()) //below this validate one is test code
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
