import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/screens/splash_screen.dart';
import 'package:mvvm_practice/viewmodel/home_viewmodel.dart';
import 'package:mvvm_practice/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SplashScreen()),
      ),
    );
  }
}
