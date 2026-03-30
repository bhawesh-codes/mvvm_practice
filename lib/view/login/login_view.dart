import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/validators.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (context, child) {
        final vm = context.watch<LoginViewModel>();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hi, welcome back! Please login to your account.',
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      height: 360,
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
                          child: Form(
                            key: vm.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email'),
                                const SizedBox(height: 5),

                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  controller: vm.emailController,
                                  validator: Validators.emailValidator,
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: 24),
                                const Text('Password'),
                                const SizedBox(height: 5),

                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  controller: vm.passwordController,
                                  validator: Validators.passwordValidator,
                                  obscureText: true,
                                ),

                                const SizedBox(height: 30),

                                Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: ElevatedButton(
                                      onPressed: vm.isLoading
                                          ? null
                                          : () async {
                                              final navigator = Navigator.of(
                                                context,
                                              );
                                              final messenger =
                                                  ScaffoldMessenger.of(context);

                                              final success = await vm.login();

                                              if (success) {
                                                messenger.showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                      milliseconds: 500,
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Login successful!",
                                                    ),
                                                  ),
                                                );

                                                navigator.pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const HomeScreen(),
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
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        backgroundColor: Colors.blueAccent,
                                      ),

                                      child: vm.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
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
          ),
        );
      },
    );
  }
}
