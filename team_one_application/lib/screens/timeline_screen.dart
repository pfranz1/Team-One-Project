import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
import 'package:team_one_application/filter/filterView.dart';
import 'package:team_one_application/schedule/scheduleView.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationController>(
        builder: (context, appController, _) {
      final bool _hasFilter = appController.filterController != null;
      final bool _hasSelected = appController.scheduleController != null;

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
              if (_hasFilter)
                FilterView(filterController: appController.filterController!),
              if (_hasSelected)
                ScheduleView(
                    scheduleController: appController.scheduleController!),
            ],
          ),
        ),
      );
    });
  }
}
