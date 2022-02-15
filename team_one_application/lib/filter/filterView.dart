import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/filter/filterController.dart';
import 'package:team_one_application/filter/filterState.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterView extends StatelessWidget {
  FilterView({Key? key, required this.filterController}) : super(key: key);

  final FilterController filterController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: filterController,
      child:
          Consumer<FilterController>(builder: (context, filterController, _) {
        return FilterVisualElement(filterState: filterController.filterState);
      }),
    );
  }
}

class FilterVisualElement extends StatefulWidget {
  FilterVisualElement({Key? key, required this.filterState}) : super(key: key);

  FilterState filterState;

  @override
  _FilterVisualElementState createState() => _FilterVisualElementState();
}

class _FilterVisualElementState extends State<FilterVisualElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.filterState.isDone)
            FriendsList(friends: widget.filterState.friendRefs),
          if (widget.filterState.isLoading)
            Container(
              child: Text("Loading...."),
            ),
          if (widget.filterState.isError)
            Container(
              child: Text("Error!"),
            ),
        ],
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({
    Key? key,
    required this.friends,
  }) : super(key: key);

  final List<FriendRef>? friends;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2.0)),
      child: Column(
        children: [
          if (friends != null && friends!.isNotEmpty)
            for (final friend in friends!)
              FriendElement(name: friend.displayName ?? "No Name"),
        ],
      ),
    );
  }
}

class FriendElement extends StatelessWidget {
  const FriendElement({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
