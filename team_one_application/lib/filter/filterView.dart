import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/filter/filterController.dart';

class FilterView extends StatelessWidget {
  FilterView({Key? key, required this.filterController}) : super(key: key);

  final FilterController filterController;

  @override
  Widget build(BuildContext context) {
    return FilterVisualElement();
  }
}

class FilterVisualElement extends StatefulWidget {
  const FilterVisualElement({Key? key}) : super(key: key);

  @override
  _FilterVisualElementState createState() => _FilterVisualElementState();
}

class _FilterVisualElementState extends State<FilterVisualElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('FilterVisualElement'),
    );
  }
}
