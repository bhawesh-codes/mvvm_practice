import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';
import 'package:mvvm_practice/repositories/favorites_repository.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';

class HomeViewModel extends ChangeNotifier {
  final FavoritesRepository _favRepo;
  HomeViewModel(this._favRepo);
  final ApiService _apiService = ApiService();
  final SecureStorageService _storage = SecureStorageService();
  

  ApiService get apiService => _apiService;

  BookModel? bookData;
  bool isLoading = false;
  bool hasFetched = false;
  String? error;
  bool hasLoadedSlugs = false;
  List<String> favoriteSlugs = [];

  Future<void> fetchBooks() async {
    if (isLoading) return;
    isLoading = true;
    hasFetched = true;
    error = null;

    if (!hasLoadedSlugs) {
      favoriteSlugs = await _favRepo.getSlugs(); // ✅ repo handles prefs
      hasLoadedSlugs = true;
    }

    notifyListeners();

    try {
      bookData = await _apiService.fetchBooks();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Result book) async {
    await _favRepo.toggle(book); // ✅ repo handles logic

    // keep local slugs in sync
    if (favoriteSlugs.contains(book.slug)) {
      favoriteSlugs.remove(book.slug);
    } else {
      favoriteSlugs.add(book.slug!);
    }

    notifyListeners();
  }

  bool isFavorite(Result book) {
    return _favRepo.isFavorite(book, favoriteSlugs); // ✅ repo handles check
  }

  Future<void> refreshFavoriteSlugs() async {
    favoriteSlugs = await _favRepo.getSlugs();
    notifyListeners();
  }

  void nextPage() {
    if (_apiService.page < 6) {
      _apiService.page++;
      hasFetched = false;
      fetchBooks();
    }
  }

  void previousPage() {
    if (_apiService.page > 1) {
      _apiService.page--;
      hasFetched = false;
      fetchBooks();
    }
  }

  void logout() {
    _storage.deleteToken();
    bookData = null;
    hasFetched = false;
    _apiService.page = 1;
    hasLoadedSlugs = false;
    favoriteSlugs.clear();
    notifyListeners();
  }
}
