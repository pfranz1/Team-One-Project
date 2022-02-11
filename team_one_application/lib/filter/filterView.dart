import 'package:flutter/material.dart';
import 'package:team_one_application/filter/filterController.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key, required this.filterController})
      : super(key: key);

  final FilterController filterController;

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.filterController.filterState.friendRefs?.toString() ??
          'Friend Refs Loading...'),
    );
  }
}
