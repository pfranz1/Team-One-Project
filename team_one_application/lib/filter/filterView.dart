import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
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

class FriendsList extends StatefulWidget {
  const FriendsList({
    Key? key,
    required this.friends,
  }) : super(key: key);

  final List<FriendRef>? friends;

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  int currentIndex = -1;

  void selectIndex(int newIndex) {
    //Probably call the DB?
    setState(() {
      currentIndex = newIndex;
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2.0)),
      child: Column(
        children: [
          if (widget.friends != null && widget.friends!.isNotEmpty)
            for (final friend in widget.friends!
                .asMap()
                .entries) //As map is the easiest way to get index with a value
              FriendElement(
                friendRef: friend.value,
                callback: () => selectIndex(friend.key),
              ),
        ],
      ),
    );
  }
}

class FriendElement extends StatelessWidget {
  const FriendElement(
      {Key? key, required this.friendRef, required this.callback})
      : super(key: key);

  final FriendRef friendRef;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: callback,
        child: Text(friendRef.displayName ?? "No Name"),
      ),
    );
  }
}
