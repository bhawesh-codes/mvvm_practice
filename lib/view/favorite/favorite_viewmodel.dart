import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';

class FavoriteViewmodel extends ChangeNotifier{
  bool isLoading = false;
  String? error;
  List<Result> favoritebooks = [];
  void toggleFavorite(Result book) {
    if (favoritebooks.contains(book)) {
      favoritebooks.remove(book);
    } else {
      favoritebooks.add(book);
    }

    notifyListeners();
  }

  bool isFavorite(Result book) {
    return favoritebooks.contains(book);
  }
}