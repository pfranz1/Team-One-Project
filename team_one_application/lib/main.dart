import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/services/navigation_service.dart';
import 'package:team_one_application/services/route_generator.dart';
import 'applicationController.dart';
import 'authentication/authView.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NavigationService>(
          create: (_) => NavigationService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationController(
            navigationService: context.read<NavigationService>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team One App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
      navigatorKey: context.read<NavigationService>().navigatorKey,
    );
  }
}
