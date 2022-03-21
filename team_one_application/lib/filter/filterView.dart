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
        return FilterVisualElement(filterController: filterController);
      }),
    );
  }
}

class FilterVisualElement extends StatelessWidget {
  FilterVisualElement({Key? key, required this.filterController})
      : filterState = filterController.filterState,
        super(key: key);

  final FilterState filterState;
  final FilterController filterController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          if (filterState.isDone)
            FriendsList(
              friends: filterState.friendRefs,
              onFriendSelect: filterController.onAgentSelect,
            ),
          if (filterState.isLoading)
            Container(
              child: Text("Loading...."),
            ),
          if (filterState.isError)
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
    widget.onFriendSelect(widget.friends![newIndex].documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 2.0)),
        child: ListView(
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
    return InkWell(
      onTap: callback,
      hoverColor: Colors.green,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
            color: isSelected ? Colors.blueGrey[400] : Colors.blueGrey[600]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              friendRef.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
