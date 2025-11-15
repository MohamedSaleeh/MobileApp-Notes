import 'package:Memo/database/userModel.dart';
import 'package:Memo/providers/accountProvider.dart';
import 'package:Memo/providers/notesProvider.dart';
import 'package:flutter/material.dart';
import 'package:Memo/packages/logo.dart';
import 'package:Memo/packages/textField.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:Memo/formControls.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  void showSnackBar(context, String message, bool isError) {
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
      formGroup: signupFormgroup,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50),
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
                  formControlName: 'username',
                  hintText: 'Enter your username',
                  prefixIcon: const Icon(Icons.person),
                  validationMessages: {
                    ValidationMessage.minLength: (error) =>
                        "Username must be at least 3 characters",
                  },
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
                const SizedBox(height: 8),
                reactiveTextfield(
                  formControlName: 'confirm_password',
                  hintText: 'Confirm Password',
                  ispassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validationMessages: {
                    ValidationMessage.mustMatch: (error) =>
                        "Passwords do not match",
                    ValidationMessage.required: (error) => "required",
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ReactiveCheckbox(formControlName: 'acceptTerms'),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        text: 'I accept ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    if (signupFormgroup.valid) {
                      final formData = signupFormgroup.value;
                      final user = User(
                        username: formData['username'] as String,
                        email: formData['email'] as String,
                        password: formData['password'] as String,
                      );
                  context.read<NotesProvider>().reset();
                      final isSuccess = await context
                          .read<AccountProvider>()
                          .register(user);
                      
                       
                      

                      if (isSuccess) {
                        showSnackBar(
                          context,
                          'Account created successfully',
                          false,
                        );
                        signupFormgroup.reset();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'home',
                          (route) => false,
                        );
                      } else {
                        showSnackBar(context, 'Email already exists', true);
                      }
                    } else {
                      signupFormgroup.markAllAsTouched();
                    }
                  },
                  child: const Text('Create Account'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff1272CA),
                    ),
                    onPressed: () {
                      signupFormgroup.reset();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'loginPage',
                        (route) => false,
                      );
                    },
                    child: const Text('Login'),
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
