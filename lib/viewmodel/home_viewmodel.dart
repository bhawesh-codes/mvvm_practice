import 'package:flutter/material.dart';
import 'package:mvvm_practice/data/models/book_model.dart';
import 'package:mvvm_practice/data/services/api_services.dart';
import 'package:mvvm_practice/data/services/secure_storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  BookModel? bookData;
  bool isLoading = false;
  String? error;

  Future<void> fetchBooks() async {
    isLoading = true;
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
  void logout(){
    _storage.deleteToken();
    bookData = null;
    _apiService.page= 1;
    notifyListeners();
    
  }
  void nextPage(){
    _apiService.page++;
    fetchBooks();
    notifyListeners();
  }
  void previousPage() {
    if(_apiService.page > 1){
    _apiService.page--;
    fetchBooks();
    notifyListeners();
    }
  }
}