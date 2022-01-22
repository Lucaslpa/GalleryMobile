import 'package:flutter/cupertino.dart';
import 'package:prov/models/image_data.dart';

class Trash extends ChangeNotifier {
  final List<ImageData> _trash = [];

  List<ImageData> get images => _trash;

  void addToTrash(ImageData imageData) {
    if (!_trash.contains(imageData)) {
      _trash.add(imageData);
      notifyListeners();
    }
  }

  void removeFromTrash(ImageData imageData) {
    if (_trash.contains(imageData)) {
      _trash.remove(imageData);
      notifyListeners();
    }
  }

  bool isInTrash(ImageData imageData) {
    return _trash.contains(imageData);
  }
}
