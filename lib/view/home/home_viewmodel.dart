import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  ApiService get apiService => _apiService;
  final SecureStorageService _storage = SecureStorageService();

  BookModel? bookData;
  bool isLoading = false;
  bool hasFetched = false; // ✅ add this
  String? error;

  Future<void> fetchBooks() async {
    if (isLoading) return;
    isLoading = true;
    hasFetched = true; // ✅ mark as fetched
    error = null;
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
    notifyListeners();
  }
}
