import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class NavigationService {
  static NavigationService? _instance;

  static NavigationService getInstance() {
    _instance ??= NavigationService();
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService() : navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> replaceCurrent(String routeName) {
    return navigatorKey.currentState!.popAndPushNamed(routeName);
  }

  void popUntilNameMatches(String routeName) {
    navigatorKey.currentState!
        .popUntil((route) => route.settings.name == routeName);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
