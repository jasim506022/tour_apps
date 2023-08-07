import 'package:flutter/cupertino.dart';

import '../../../model/categoriesmodel.dart';

class CategoriesProvider with ChangeNotifier {
  String categoryName = categories[0].name;

  String get categoryNames => categoryName;

  categorySet({required String cateory}) {
    categoryName = cateory;
    notifyListeners();
  }

  int selectIndex = 0;

  int get getIndex => selectIndex;

  setIndex({required int index}) {
    selectIndex = index;
    notifyListeners();
  }
}
