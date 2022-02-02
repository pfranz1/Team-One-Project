import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';
import 'authentication/authentication.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => MyApp(),
  ));
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
      home: const MyHomePage(title: 'Team One App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Authentication(
                  loginState: appState.loginState,
                  email: appState.email,
                  startLoginFlow: appState.startLoginFlow,
                  verifyEmail: appState.verifyEmail,
                  signInWithEmailAndPassword:
                      appState.signInWithEmailAndPassword,
                  cancelRegistration: appState.cancelRegistration,
                  registerAccount: appState.registerAccount,
                  signOut: appState.signOut,
                  firstText: 'Sign In / Register',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
