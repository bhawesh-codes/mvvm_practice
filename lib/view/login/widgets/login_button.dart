import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context
        .watch<LoginViewModel>(); // ✅ watch — needs to rebuild for isLoading

    return Center(
      child: SizedBox(
        height: 50,
        width: 180,
        child: ElevatedButton(
          onPressed: vm.isLoading
              ? null
              : () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  final success = await vm.login();

                  if (success) {
                    messenger.showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        backgroundColor: Colors.green,
                        content: Text("Login successful!"),
                      ),
                    );

                    navigator.pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  } else {
                    messenger.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(vm.error ?? "Something went wrong"),
                      ),
                    );
                  }
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          child: vm.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

}