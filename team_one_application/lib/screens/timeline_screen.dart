import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
import 'package:team_one_application/filter/filterView.dart';
import 'package:team_one_application/schedule/scheduleView.dart';
import 'package:team_one_application/widgets/sharedDrawer.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationController>(
        builder: (context, appController, _) {
      final bool _hasFilter = appController.filterController != null;
      final bool _hasSelected = appController.scheduleController != null;

      return Scaffold(
        drawer: SharedDrawer(),
        appBar: AppBar(
          title: const Text("Quick Share"),
          key: const ValueKey('appBar'),
          actions: [
            // Sign-Out Button
            ElevatedButton(
                onPressed: () => appController.authController!.signOut(),
                child: const Text('Log Out'))
          ],
        ),
        body: Center(
          child: Row(
            children: [
              if (_hasFilter)
                FilterView(filterController: appController.filterController!),
              SizedBox(
                width: 40,
              ),
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
