import 'package:flutter/material.dart';
import 'package:tour_apps/model/categoriesmodel.dart';

class DropCateogryProvider with ChangeNotifier {
  String _categoryName = categoryAllString.first;

  String get getCategory => _categoryName;

  setCategory({required String cateory}) {
    _categoryName = cateory;
    notifyListeners();
  }
}
