import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/common/websocket/websocket_service.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/splash/domain/usecase/splash_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

final isFirstTimeProvider = Provider<SplashViewModel>((ref) => SplashViewModel(
      ref.read(userSharedPrefsProvider),
      ref.read(navigationServiceProvider),
      ref.read(splashUseCaseProvider),
      ref.read(webSocketProvider),
      //ref.read(webSocketServiceProvider)),
    ));

class SplashViewModel {
  final UserSharedPrefs userSharedPrefs;
  final NavigationService navigationService;
  final SplashUseCase splashUseCase;
  final WebSocketServices webSocketServices;
  //final WebSocketServices webSocketServices;
  // late final IOWebSocketChannel channel;
  // late final Future<void> channelInitialization;

  SplashViewModel(this.userSharedPrefs, this.navigationService,
      this.splashUseCase, this.webSocketServices);

  Future<void> checkFirstTime(ref) async {
    final isLoggedIn = await userSharedPrefs.getLoggedIn();
    final isOnboarded = await userSharedPrefs.getOnBoarded();
    final isRemembered = await userSharedPrefs.getRememberMe();
    final token = await userSharedPrefs.getUserToken() ?? "";

    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request();
    }

    await Future.delayed(const Duration(milliseconds: 1500));

    if (isLoggedIn && isOnboarded) {
      // channel = WebSocketServices.startWebSocket((data) {
      //   onDataCallback(data);
      //initilize socket and send notification dat to notification view model.
      // });
      // channelInitialization =
      //     NotificationServices.initializeAwesomeNotifications();

      //  final WebSocketServices webSocketServices = WebSocketServices();
      // webSocketServices.startWebSocket((data, type) {
      //   if (type == "news" || type == "notification") {
      //     print("*************News data detected ***********");
      //     notificationViewModel.onDataCallback(data);
      //   }
      // });
      // ref.watch(notificationViewModelProvider);
      //ref.watch(webSocketProvider);

      if (isRemembered) {
        final bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          final result = await splashUseCase.getUserData();

          result.fold(
            (failure) {
              navigationService.routeToAndRemoveUntil(AppRoute.authRoute);
            },
            (authEntity) {
              ref.read(authEntityProvider.notifier).state = authEntity;
              navigationService.routeToAndRemoveUntil(AppRoute.homeRoute);
            },
          );
        } else {
          navigationService.routeToAndRemoveUntil(AppRoute.authRoute);
        }
      } else {
        navigationService.routeToAndRemoveUntil(AppRoute.authRoute);
      }
    } else if (!isLoggedIn && !isOnboarded && !isRemembered) {
      navigationService.routeToAndRemoveUntil(AppRoute.onboardRoute);
    } else {
      navigationService.routeToAndRemoveUntil(AppRoute.authRoute);
    }
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int expirationTimestamp = decodedToken['exp'];
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    return currentDate < expirationTimestamp * 1000;
  }
}
