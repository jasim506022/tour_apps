import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/categoriesmodel.dart';

class UploadGroupProvider with ChangeNotifier {
  bool uploading = false;
  bool get getUploading => uploading;
  setUploading({required bool value}) {
    uploading = value;
    notifyListeners();
  }

  List<XFile> imagesListXfile = [];

  List<XFile> get selectedImage => imagesListXfile;

  void setImage({required List<XFile> photo}) {
    imagesListXfile = photo;
    notifyListeners();
  }

  void removieImage({required int index}) {
    imagesListXfile.removeAt(index);
    notifyListeners();
  }

  List<String> imageUrls = [];

  List<String> get selectedImageUrl => imageUrls;

  void setImageUrl({required List<String> photo}) {
    imageUrls = photo;
    notifyListeners();
  }

  void removieImageUrl({required int index}) {
    imageUrls.removeAt(index);
    notifyListeners();
  }

  String categoryName = updatecategoryString.first;

  String get categoryNames => categoryName;

  categorySet({required String cateory}) {
    categoryName = cateory;
    notifyListeners();
  }

  String selectedDate = DateTime.now().toString();

  String get getSelectedDate => selectedDate;

  setSelectedDate({required String date}) {
    selectedDate = date;
    notifyListeners();
  }
}
