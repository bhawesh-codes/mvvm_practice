import 'package:flutter/material.dart';
import 'package:mvvm_practice/models/book_details_model.dart';
import 'package:mvvm_practice/services/api_services.dart';

class BookDetailsViewmodel extends ChangeNotifier{
  
  final ApiService _apiService = ApiService();
  ApiService get apiService => _apiService;
  BookDetailsModel? _bookDetails;
  BookDetailsModel? get bookDetails => _bookDetails;
  bool isLoading = false;

  String? error;
  Future<void> fetchBookDetails(String slug) async {
    isLoading = true;
    notifyListeners();

    try {
      _bookDetails = await _apiService.getBookDetails(slug);
      error = null;
    } catch (e) {
      print("Error: $e");
      error = "Failed to fetch book details";
      _bookDetails = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}