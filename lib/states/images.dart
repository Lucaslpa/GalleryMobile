import 'package:flutter/cupertino.dart';
import 'package:prov/models/image_data.dart';

class Images extends ChangeNotifier {
  List<ImageData> _images = [];

  List<ImageData> get images => _images;

  void addImage(ImageData imageData) {
    if (!_images.contains(imageData)) {
      _images.add(imageData);
      notifyListeners();
    }
  }

  void removeImage(ImageData imageData) {
    if (_images.contains(imageData)) {
      _images.remove(imageData);
      notifyListeners();
    }
  }

  addImages(List<ImageData> img) {
    if (images.isEmpty) {
      _images = img;
      notifyListeners();
    }
  }
}
