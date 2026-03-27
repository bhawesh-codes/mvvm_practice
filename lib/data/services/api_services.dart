

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_practice/data/models/book_model.dart';
import 'package:mvvm_practice/data/services/secure_storage_service.dart';

class ApiService {
  final SecureStorageService storage = SecureStorageService();
  
  int page = 1;
  Future<BookModel?> fetchBooks() async {
    final String? token = await storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://tbe.thuprai.com/v1/books/new-releases/?page=$page'), 
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final bookModel = bookModelFromJson(response.body);
        return bookModel;
      } else {
        debugPrint("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return null;
    }
  } 
  }


  
    

  

