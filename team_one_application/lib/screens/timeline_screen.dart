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
