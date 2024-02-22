import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  dynamic routeTo(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }

  dynamic routeToAndReplaceAll(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  dynamic routeToAndReplace(String route, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  dynamic routeToAndRemoveUntil(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  dynamic routeToAndRemoveUntilWithRoute(String route, String route2,
      {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, ModalRoute.withName(route2),
        arguments: arguments);
  }

  dynamic routeToAndRemoveUntilWithRouteAndReplace(String route, String route2,
      {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, ModalRoute.withName(route2),
        arguments: arguments);
  }

  dynamic routeToAndRemoveUntilWithRouteAndReplaceAll(
      String route, String route2,
      {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route, ModalRoute.withName(route2),
        arguments: arguments);
  }

  void popToFirst() =>
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
}

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});
