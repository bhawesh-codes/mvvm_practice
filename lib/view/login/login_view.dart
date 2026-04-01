import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:mvvm_practice/view/login/widgets/login_header.dart';
import 'package:mvvm_practice/view/login/widgets/login_card.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (context, _) {
        return const Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [LoginHeader(), SizedBox(height: 30), LoginCard()],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
