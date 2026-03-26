import 'package:flutter/material.dart';
import 'package:mvvm_practice/data/models/book_model.dart';
import 'package:mvvm_practice/data/services/api_services.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

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
}