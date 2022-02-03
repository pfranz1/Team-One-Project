import 'package:flutter/material.dart';
import 'package:team_one_application/views/home_view.dart';

enum pageEnum { home }

class RouteGenerator {
  static pageEnum? currentPage;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //The route name will be something like 'home/userprefs/'

    final String baseDir;
    RegExp exp = RegExp(r"[^\/]*");

    final test = exp.firstMatch(settings.name ?? '/home').toString();

    if (settings.name == null || settings.name == '/') {
      baseDir = '/home';
    } else {
      baseDir = "/" + settings.name!.substring(1).split('/').first;
    }

    //Get the first element in the adress, if there is no name defaults to 'home'
    switch (baseDir) {
      case ('/home'):
        return MaterialPageRoute(
          builder: (context) {
            return HomeView();
          },
          settings: RouteSettings(name: '/home'),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
