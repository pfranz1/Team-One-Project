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
    widget.onFriendSelect(widget.friends![newIndex].uId);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<FriendElement> friendsList = <FriendElement>[];
    if (widget.friends != null && widget.friends!.isNotEmpty)
      for (final friend in widget.friends!
          .asMap()
          .entries) //As map is the easiest way to get index with a value
        friendsList.add(FriendElement(
          friendRef: friend.value,
          callback: () => selectIndex(friend.key),
          isSelected: currentIndex == friend.key,
        ));

    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2.0)),
      height: MediaQuery.of(context).size.height * .80,
      width: 150,
      child: Column(
        children: [
          Text(
            "Friends:",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          //SizedBox adds space between Friends title and ListView
          SizedBox(
            height: 20,
          ),
          //List View needs container to know rendering boundaries
          Container(
            height: MediaQuery.of(context).size.height * .7,
            width: 150,
            child: ListView.separated(
                itemCount: friendsList.length,
                itemBuilder: (context, index) {
                  return friendsList[index];
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                }),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            primary: isSelected ? Colors.grey : Colors.white,
          ),
          child: Text(friendRef.displayName ?? "No Name",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
