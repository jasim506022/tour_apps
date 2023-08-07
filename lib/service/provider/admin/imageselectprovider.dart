import 'package:flutter/material.dart';

import '../../../const/const.dart';

class ImageSelectProvider with ChangeNotifier {
  int selectImage = 0;

  int get getImage => selectImage;

  setImage({required int imageNumber}) {
    selectImage = imageNumber;
    notifyListeners();
  }

  int selectColor = 0;

  int get getColor => selectColor;

  setColor({required int colorNumber}) {
    selectColor = colorNumber;
    notifyListeners();
  }

  DeleteUpdate? selectMenu;

  DeleteUpdate get getMenu => selectMenu!;

  setMenu({required DeleteUpdate setMenu}) {
    selectMenu = setMenu;
    notifyListeners();
  }
}
