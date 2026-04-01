import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:mvvm_practice/view/login/widgets/login_text_field.dart';
import 'package:mvvm_practice/view/login/widgets/login_button.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
          child: Form(
            key: vm.formKey,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  isPassword: false,
                ),
                SizedBox(height: 24),
                LoginTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  isPassword: true,
                ),
                SizedBox(height: 30),
                LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
