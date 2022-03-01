import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/models/friend_ref.dart';
import 'package:team_one_application/social/socialController.dart';

class SocialView extends StatelessWidget {
  const SocialView({Key? key, required this.socialController})
      : super(key: key);

  final SocialController socialController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: socialController,
      child: Consumer<SocialController>(
        builder: (context, socialController, child) {
          return SocialVisualElement(
            socialController: socialController,
          );
        },
      ),
    );
  }
}

class SocialVisualElement extends StatefulWidget {
  SocialVisualElement({Key? key, required this.socialController})
      : super(key: key);
  SocialController socialController;

  @override
  _SocialVisualElementState createState() => _SocialVisualElementState();
}

class _SocialVisualElementState extends State<SocialVisualElement> {
  @override
  void initState() {
    widget.socialController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.socialController.socialState;
    if (state.isLoading) {
      return CircularProgressIndicator();
    } else if (state.isError) {
      return Text("Error with loading friends, Sorry!");
    } else if (state.isDone) {
      return SocialLoadedWidget(friends: state.freinds!);
    } else {
      return const Text(
          "Wow rare easter egg! state in social controller is not one of the three expected");
    }
  }
}

class SocialLoadedWidget extends StatefulWidget {
  const SocialLoadedWidget({Key? key, required this.friends}) : super(key: key);
  final List<FriendRef> friends;

  @override
  _SocialLoadedWidgetState createState() => _SocialLoadedWidgetState();
}

class _SocialLoadedWidgetState extends State<SocialLoadedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return FriendListTile(
            info: widget.friends[index],
          );
        },
        itemCount: widget.friends.length,
      ),
    );
  }
}

class FriendListTile extends StatelessWidget {
  const FriendListTile({Key? key, required this.info}) : super(key: key);

  final FriendRef info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(info.displayName ?? "U:${info.uId}"),
    );
  }
}
