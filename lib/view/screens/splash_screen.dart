import 'package:flutter/material.dart';
import 'package:mvvm_practice/data/services/secure_storage_service.dart';
import 'package:mvvm_practice/view/screens/home_screen.dart';
import 'package:mvvm_practice/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorageService _storage = SecureStorageService();
  Future<void> init() async {
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

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
