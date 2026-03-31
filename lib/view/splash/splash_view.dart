import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/splash/splash_viewmodel.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:mvvm_practice/view/login/login_view.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SplashViewModel(), 
      builder: (context, _) {
        final vm = context.watch<SplashViewModel>();

        if (vm.isAuthenticated != null) {
          Future.microtask(() {
            // ✅ navigation in microtask, not directly in build
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => vm.isAuthenticated!
                    ? const HomeScreen()
                    : const LoginScreen(),
              ),
            );
          });
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          ),
        );
      },
    );
  }
}
