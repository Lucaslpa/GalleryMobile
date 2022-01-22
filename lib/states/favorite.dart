import 'package:flutter/cupertino.dart';
import 'package:prov/models/image_data.dart';

class Favorites extends ChangeNotifier {
  final List<ImageData> _favorites = [];

  List<ImageData> get favorites => _favorites;

  void addFavorite(ImageData imageData) {
    if (!_favorites.contains(imageData)) {
      _favorites.add(imageData);
      notifyListeners();
    }
  }

  void removeFavorite(ImageData imageData) {
    if (_favorites.contains(imageData)) {
      _favorites.remove(imageData);
      notifyListeners();
    }
  }

  bool isFavorite(ImageData imageData) {
    return _favorites.contains(imageData);
  }
}
