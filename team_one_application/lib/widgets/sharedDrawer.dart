import 'package:flutter/material.dart';
import 'package:team_one_application/services/navigation_service.dart';

class SharedDrawer extends StatelessWidget {
  const SharedDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                NavigationService.getInstance().replaceCurrent('/timeline'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Social'),
            onTap: () =>
                NavigationService.getInstance().replaceCurrent('/social'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
