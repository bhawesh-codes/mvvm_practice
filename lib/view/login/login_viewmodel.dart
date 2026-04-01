import 'package:flutter/material.dart';
import 'package:mvvm_practice/services/api_services.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? error;

  final ApiService _apiService = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<bool> login() async {
    if (!formKey.currentState!.validate()) return false;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final token = await _apiService.requestLogin(
        emailController.text,
        passwordController.text,
      );
      await _storage.saveToken(token!);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
