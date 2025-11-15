import 'package:Memo/providers/accountProvider.dart';
import 'package:Memo/providers/notesProvider.dart';
import 'package:flutter/material.dart';
import 'package:Memo/packages/logo.dart';
import 'package:Memo/packages/textField.dart';
import 'package:Memo/providers/navbarProvider.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:Memo/formControls.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: loginFormgroup,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Logo(withBreakLine: true)),
                const SizedBox(height: 32),
                const reactiveTextfield(
                  formControlName: 'email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 8),
                reactiveTextfield(
                  formControlName: 'password',
                  hintText: 'Enter your password',
                  ispassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validationMessages: {
                    ValidationMessage.minLength: (error) =>
                        "Password must be at least 8 characters",
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'forgotpasswordpage',
                      (route) => false,
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (loginFormgroup.valid) {
                      final formData = loginFormgroup.value;
                      final email = formData['email'] as String;
                      final password = formData['password'] as String;
                      context.read<NotesProvider>().reset();
                      final isSuccess = await context
                          .read<AccountProvider>()
                          .login(email, password);
                      if (isSuccess) {
                        showSnackBar(context, 'Login successful!', false);
                        context.read<NavbarProvider>().updateIndex(0);
                        loginFormgroup.reset();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'home',
                          (route) => false,
                        );
                      } else {
                        showSnackBar(
                          context,
                          'Invalid email or password!',
                          true,
                        );
                      }
                    } else {
                      loginFormgroup.markAllAsTouched();
                    }
                  },
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff1272CA),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'signupPage',
                        (route) => false,
                      );
                    },
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
