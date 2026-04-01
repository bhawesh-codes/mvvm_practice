import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        Text('Hi, welcome back! Please login to your account.'),
      ],
    );
  }
}
