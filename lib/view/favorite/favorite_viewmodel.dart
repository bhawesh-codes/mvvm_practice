import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  static const String _favKey = 'favorite_slugs';

  List<Result> favoriteBooks = [];
  List<Result> allBooks = []; // Cache all books
  bool isLoading = false;
  String? error;
  bool hasLoaded = false;

  Future<void> loadFavorites() async {
    if (isLoading) return; // ✅ only guard is isLoading
    isLoading = true;
    hasLoaded = true; // ✅ mark as loaded
    error = null;
    notifyListeners();

    try {
      final pref = await SharedPreferences.getInstance();
      final slugs = pref.getStringList(_favKey) ?? [];

      if (slugs.isEmpty) {
        favoriteBooks = [];
      } else {
        final allBooks = await _apiService.fetchAllBooks();
        this.allBooks = allBooks; // Cache all books
        favoriteBooks = allBooks
            .where((book) => slugs.contains(book.slug)) // ✅ match by slug
            .toList();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateFavorites() async {
    final pref = await SharedPreferences.getInstance();
    final slugs = pref.getStringList(_favKey) ?? [];
    favoriteBooks = allBooks
        .where((book) => slugs.contains(book.slug))
        .toList();
    notifyListeners();
  }
}
