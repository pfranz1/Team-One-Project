import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/filter/filterController.dart';
import 'package:team_one_application/filter/filterState.dart';

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
          Text('FilterVisualElement ${widget.filterState.loadState}'),
        ],
      ),
    );
  }
}
