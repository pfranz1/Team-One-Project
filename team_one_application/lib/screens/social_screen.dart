import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
import 'package:team_one_application/services/navigation_service.dart';
import 'package:team_one_application/social/socialView.dart';
import 'package:team_one_application/widgets/sharedDrawer.dart';

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
          drawer: SharedDrawer(),
          body: Center(
            child: SocialView(socialController: appController.socialController),
          ),
        );
      },
    );
  }
}
