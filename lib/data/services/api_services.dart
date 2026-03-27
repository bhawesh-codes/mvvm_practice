

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_practice/data/models/book_model.dart';

class ApiService {
  int page = 1;
  Future<BookModel?> fetchBooks() async {
  final response = await http.get(
    Uri.parse('https://tbe.thuprai.com/v1/books/new-releases/?page=$page'),
  );

  if (response.statusCode == 200) {
    
    final bookModel = bookModelFromJson(response.body);

    return bookModel;
  } else {
    debugPrint("Error: ${response.statusCode}");
    return null;
  }
  
}
  
    

  }

