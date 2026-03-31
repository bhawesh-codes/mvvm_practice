import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  ApiService get apiService => _apiService;
  final SecureStorageService _storage = SecureStorageService();

  BookModel? bookData;
  bool isLoading = false;
  bool hasFetched = false; // ✅ add this
  String? error;
  bool hasLoadedSlugs = false;

  List<String> favoriteSlugs = [];

  Future<void> fetchBooks() async {
    if (isLoading) return;
    isLoading = true;
    hasFetched = true; // ✅ mark as fetched
    error = null;
    if (!hasLoadedSlugs) {
      await loadFavoriteSlugs();
      hasLoadedSlugs = true;
    }
    notifyListeners();
    try {
      final data = await _apiService.fetchBooks();
      bookData = data;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void nextPage() {
    if (_apiService.page < 6) {
      _apiService.page++;
      hasFetched = false; // ✅ reset so fetchBooks runs again
      fetchBooks();
    }
  }

  void previousPage() {
    if (_apiService.page > 1) {
      _apiService.page--;
      hasFetched = false; // ✅ reset so fetchBooks runs again
      fetchBooks();
    }
  }

  void logout() {
    _storage.deleteToken();
    bookData = null;
    hasFetched = false; // ✅ reset on logout
    _apiService.page = 1;
    hasLoadedSlugs = false;
    favoriteSlugs.clear();
    notifyListeners();
  }

  Future<void> loadFavoriteSlugs() async {
    final pref = await SharedPreferences.getInstance();
    favoriteSlugs = pref.getStringList(_favKey) ?? [];
  }

  static const String _favKey = 'favorite_slugs';

  Future<void> toggleFavorite(Result book) async {
    final pref = await SharedPreferences.getInstance();
    // await pref.remove(  _favKey); // ✅ clear old data to prevent duplicates
    final slugs = pref.getStringList(_favKey) ?? [];

    if (favoriteSlugs.contains(book.slug)) {
      favoriteSlugs.remove(book.slug); // ✅ remove by slug
      slugs.remove(book.slug);
    } else {
      favoriteSlugs.add(book.slug!);
      slugs.add(book.slug!); // ✅ save slug
    }

    await pref.setStringList(_favKey, slugs);
    notifyListeners();
  }

  bool isFavorite(Result book) {
    return favoriteSlugs.contains(book.slug); // ✅ compare by slug
  }
}
