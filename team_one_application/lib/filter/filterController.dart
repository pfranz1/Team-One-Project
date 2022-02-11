import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterState.dart';

class FilterController extends ChangeNotifier {
  String uuId;
  FilterState filterState;

  FilterController({required this.uuId}) : filterState = FilterState();
}
