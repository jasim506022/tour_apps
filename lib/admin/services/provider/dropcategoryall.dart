import 'package:flutter/material.dart';
import 'package:tour_apps/model/categoriesmodel.dart';

class DropCategoyAll with ChangeNotifier {
  String categoryName = categoryAllString.first;

  String get categoryNames => categoryName;

   categorySet({required String cateory}) {
    categoryName = cateory;
    notifyListeners();
  }
}
