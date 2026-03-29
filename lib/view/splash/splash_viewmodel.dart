import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:mvvm_practice/view/login/login_view.dart';

class SplashViewModel {
  final SecureStorageService _storage = SecureStorageService();

  Future<void> checkAuth(BuildContext context) async {
    final navigator = Navigator.of(context);
    final token = await _storage.getToken();
    if (token != null) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }
}
