import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
import 'package:team_one_application/social/socialView.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationController>(
      builder: (context, appController, _) {
        //TODO: Maybe need to just have a common scaffold? To get appBar and drawer
        return Scaffold(
          //TODO: Have some common way to get same AppBar across screens
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
          //TODO: Have common drawer
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
                  onTap: () => appController.navigationService
                      .replaceCurrent('/timeline'),
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
          body: Center(
            child: SocialView(socialController: appController.socialController),
          ),
        );
      },
    );
  }
}
