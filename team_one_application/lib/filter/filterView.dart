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
            Consumer<ApplicationController>(
                builder: (context, appController, _) {
              return FriendsList(
                friends: widget.filterState.friendRefs,
                onFriendSelect: appController.onFilterSelect,
              );
            }),
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
    required this.onFriendSelect,
  }) : super(key: key);

  final List<FriendRef>? friends;
  final void Function(String) onFriendSelect;

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  int currentIndex = -1;

  void selectIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
    // Calling the callback with the UId of whoever was selected
    widget.onFriendSelect(widget.friends![newIndex].uId);
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
                isSelected: currentIndex == friend.key,
              ),
        ],
      ),
    );
  }
}

class FriendElement extends StatelessWidget {
  const FriendElement(
      {Key? key,
      required this.friendRef,
      required this.callback,
      required this.isSelected})
      : super(key: key);

  final FriendRef friendRef;
  final VoidCallback callback;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: isSelected ? Colors.lightGreen : Colors.blue,
        ),
        child: Text(friendRef.displayName ?? "No Name"),
      ),
    );
  }
}
