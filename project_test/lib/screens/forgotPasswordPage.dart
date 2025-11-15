import 'package:flutter/material.dart';
import 'package:Memo/formControls.dart';
import 'package:Memo/packages/logo.dart';
import 'package:Memo/packages/textField.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Forgotpasswordpage extends StatelessWidget {
  const Forgotpasswordpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: forgotpassword,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Logo(
                    withBreakLine: true,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "FORGOT PASSWORD?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                const reactiveTextfield(
                  formControlName: 'email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                 
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'forgotpasswordsentpage',
                      (route) => false,
                    );
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'loginPage',
                      (route) => false,
                    );
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
