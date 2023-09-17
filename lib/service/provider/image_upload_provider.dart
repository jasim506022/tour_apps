import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadProvider with ChangeNotifier {
  XFile? imageFile;

 XFile get getImgeFile => imageFile!;

  setImage(XFile? image) async {
    imageFile = image;
    notifyListeners();
  }
}
