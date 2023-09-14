import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool uploading = false;

  bool get getUploading => uploading;

  setUploading({required bool value}) {
    uploading = value;
    notifyListeners();
  }
}
