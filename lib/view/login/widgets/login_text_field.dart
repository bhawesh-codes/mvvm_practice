import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:mvvm_practice/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;

  const LoginTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginViewModel>(); // ✅ read — no rebuild needed

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: isPassword ? vm.passwordController : vm.emailController,
          validator: isPassword
              ? Validators.passwordValidator
              : Validators.emailValidator,
          obscureText: isPassword,
          keyboardType: isPassword
              ? TextInputType.text
              : TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
