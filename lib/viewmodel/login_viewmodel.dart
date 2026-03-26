import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_practice/data/services/secure_storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? token;
  String? error;

  final SecureStorageService _storage = SecureStorageService();

  Future<void> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://tbe.thuprai.com/v1/api/login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        token = data['token'];
        

        
        await _storage.saveToken(token!);

      } else {
        error = "Check your credentials";
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}