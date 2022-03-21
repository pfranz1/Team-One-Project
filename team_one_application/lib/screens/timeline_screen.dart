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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                //header of drawer
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Hello, <USERNAME>',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                //menu item of Drawer
                leading: Icon(Icons.calendar_today),
                title: Text('Timeline'),
                onTap: () =>
                    appController.navigationService.replaceCurrent('/timeline'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Social'),
                onTap: () =>
                    appController.navigationService.replaceCurrent('/social'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Account Settings'),
                onTap: () {},
              ),
            ],
          ),
        ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
