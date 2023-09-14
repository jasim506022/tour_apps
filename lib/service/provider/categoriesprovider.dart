import 'package:flutter/cupertino.dart';

import '../../../model/categoriesmodel.dart';

class CategoriesProvider with ChangeNotifier {
  String _category = categories[0].name;

  String get getCategory => _category;

  setCategory({required String cateory}) {
    _category = cateory;
    notifyListeners();
  }


  int _index = 0;
  int get getIndex => _index;
  setIndex({required int index}) {
    _index = index;
    notifyListeners();
  }
}
