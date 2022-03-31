import 'dart:html';
import 'services/navigation_service.dart';

class NavigatorSingletonManager {
  static bool _isMade = false;
  static NavigationService? singleton;

  static getInstance() {
    if (!_isMade) {
      singleton = NavigationService();
      _isMade = true;
    }
    return singleton;
  }
}
