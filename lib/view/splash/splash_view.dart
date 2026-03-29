import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/splash/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    SplashViewModel().checkAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
    );
  }
}
