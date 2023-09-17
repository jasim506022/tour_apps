import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/categoriesmodel.dart';

class UploadProvider with ChangeNotifier {
 
 
 //Image List Xfile
  List<XFile> _imagesListXfile = [];
  List<XFile> get getImagesListXFile => _imagesListXfile;

  void setImage({required List<XFile> photo}) {
    _imagesListXfile = photo;
    notifyListeners();
  }

  void removieImage({required int index}) {
    _imagesListXfile.removeAt(index);
    notifyListeners();
  }

//Image
  List<String> _imageUrls = [];

  List<String> get getImageUrl => _imageUrls;

  void setImageUrl({required List<String> photo}) {
    _imageUrls = photo;
    notifyListeners();
  }

  void removieImageUrl({required int index}) {
    _imageUrls.removeAt(index);
    notifyListeners();
  }

  String _categoryName = categoryAllString[1];

  String get getCategoryName => _categoryName;

  categorySet({required String cateory}) {
    _categoryName = cateory;
    notifyListeners();
  }

  String selectedDate = DateTime.now().toString();

  String get getSelectedDate => selectedDate;

  setSelectedDate({required String date}) {
    selectedDate = date;
    notifyListeners();
  }
}
