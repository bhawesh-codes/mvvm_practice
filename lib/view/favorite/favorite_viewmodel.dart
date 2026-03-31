import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/repositories/favorites_repository.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';

class FavoriteViewModel extends ChangeNotifier {

  final ApiService _apiService = ApiService();
  final favRepo = FavoritesRepository();
  FavoriteViewModel() {
    loadFavorites();
  }
  
  List<Result> favoriteBooks = [];
  List<Result> allBooks = [];
  List<String> _slugs = [];

  bool isLoading = false;
  String? error;

  // ✅ fix — only fetch allBooks once, reuse cache after
  Future<void> loadFavorites() async {
    if (isLoading) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _slugs = await favRepo.getSlugs();

      if (allBooks.isEmpty) {
        // ✅ only fetch if not already cached
        allBooks = await _apiService.fetchAllBooks();
      }

      favoriteBooks = allBooks
          .where((book) => _slugs.contains(book.slug))
          .toList();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Result book) async {
    await favRepo.toggle(book);

    if (_slugs.contains(book.slug)) {
      _slugs.remove(book.slug);
      favoriteBooks.removeWhere(
        (b) => b.slug == book.slug,
      ); // ✅ remove directly
    } else {
      _slugs.add(book.slug!);
      favoriteBooks.add(book);
    }

    notifyListeners(); // ✅ no need for updateFavorites()
  }

  bool isFavorite(Result book) {
    return favRepo.isFavorite(book, _slugs); // ✅ repo handles check
  }

  void updateFavorites() {
    favoriteBooks = allBooks
        .where((book) => _slugs.contains(book.slug))
        .toList();
    notifyListeners();
  }
}
