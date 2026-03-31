import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    checkAuth(); // ✅ start auth check immediately
  }
  
  final SecureStorageService _storage = SecureStorageService();
  bool _hasChecked = false;
  bool? isAuthenticated; // ✅ ViewModel only exposes state

  Future<void> checkAuth() async {
    
    if (_hasChecked) return;
    _hasChecked = true;

    final token = await _storage.getToken();
    isAuthenticated = token != null; // ✅ just sets state
    notifyListeners(); // ✅ tells View to react
  }
}
