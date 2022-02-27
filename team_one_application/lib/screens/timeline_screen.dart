import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationController>(
        builder: (context, appController, _) {
      return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text("Quick Share"),
          actions: [
            // Sign-Out Button
            ElevatedButton(
                onPressed: () => appController.authController!.signOut(),
                child: const Text('Log Out'))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text("Welcome to the timeline screen!"),
            ],
          ),
        ),
      );
    });
  }
}
