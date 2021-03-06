import 'package:flutter/material.dart';
import 'package:team_one_application/screens/home_screen.dart';
import 'package:team_one_application/screens/social_screen.dart';
import 'package:team_one_application/screens/timeline_screen.dart';

enum pageEnum { home }

class RouteGenerator {
  static pageEnum? currentPage;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //The route name will be something like 'home/userprefs/'

    final String baseDir;

    if (settings.name == null || settings.name == '/') {
      baseDir = '/';
    } else {
      baseDir = "/" + settings.name!.substring(1).split('/').first;
    }

    //Get the first element in the adress, if there is no name defaults to 'home'
    switch (settings.name) {
      case ('/'):
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
          settings: RouteSettings(name: '/'),
        );
      case ('/timeline'):
        return MaterialPageRoute(
          builder: (context) {
            return TimelineScreen();
          },
          settings: RouteSettings(name: '/timeline'),
        );
      case ('/social'):
        return MaterialPageRoute(
          builder: (context) {
            return SocialScreen();
          },
          settings: RouteSettings(name: "/social"),
        );

      default:
        return _errorRoute("Page ${settings.name} not found");
    }
  }

  static Route<dynamic> _errorRoute(String errorMessage) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Text(errorMessage),
        ),
      );
    });
  }
}
