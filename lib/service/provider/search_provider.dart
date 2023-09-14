import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String searchText = "";

  String get getSearchText => searchText;

  setSearchText({required String searchValue}) {
    searchText = searchValue;
    notifyListeners();
  }


  String searchGroupText = "";
  String get getGroupSearchText => searchGroupText;
  setSearchGroupText({required String searchValue}) {
    searchGroupText = searchValue;
    notifyListeners();
  }
}
