import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/validators.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const Text('Hi, welcome back! Please login to your account.'),
              const SizedBox(height: 30),

              SizedBox(
                height: 340,
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email'),
                          const SizedBox(height: 5),

                          TextFormField(
                            controller: vm.emailController,
                            validator: Validators.emailValidator,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 24),
                          const Text('Password'),
                          const SizedBox(height: 5),

                          TextFormField(
                            controller: vm.passwordController,
                            validator: Validators.passwordValidator,
                            obscureText: true,
                          ),

                          const SizedBox(height: 30),

                          Center(
                            child: ElevatedButton(
                              onPressed: vm.isLoading
                                  ? null
                                  : () async {
                                      final navigator = Navigator.of(context);
                                      final messenger = ScaffoldMessenger.of(
                                        context,
                                      );

                                      final success = await vm.login();

                                      if (success) {
                                        messenger.showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Login successful!"),
                                          ),
                                        );

                                        navigator.pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) => const HomeScreen(),
                                          ),
                                        );
                                      } else {
                                        messenger.showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              vm.error ??
                                                  "Something went wrong",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                              child: vm.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
