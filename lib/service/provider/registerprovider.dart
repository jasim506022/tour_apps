import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider with ChangeNotifier {
  XFile? image;
  setImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final pickIfile = await picker.pickImage(source: source);
    image = pickIfile;
    notifyListeners();
  }
}
