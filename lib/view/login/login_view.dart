import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/validators.dart';
import 'package:mvvm_practice/view/home/home_view.dart';
import 'package:mvvm_practice/view/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lv = context.watch<LoginViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text('Hi, welcome back! Please login to your account.'),
              SizedBox(height: 30),
              SizedBox(
                height: 340,
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: .min,
                          crossAxisAlignment: .start,
                          children: [
                            Text('Email'),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: Validators.emailValidator,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter your Email..',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Text('Password'),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: Validators.passwordValidator,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    // Capture BEFORE the async gap
                                    final navigator = Navigator.of(context);
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );

                                    await lv.login(
                                      emailController.text,
                                      passwordController.text,
                                    );

                                    if (lv.token != null) {
                                      messenger.showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          duration: Duration(milliseconds: 500),
                                          content: Text(
                                            "Login successful!",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                      navigator.pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => HomeScreen(),
                                        ),
                                      );
                                    } else if (lv.error != null) {
                                      messenger.showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Check your credentials!",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(200, 50),
                                ),
                                child: lv.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        ),
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
