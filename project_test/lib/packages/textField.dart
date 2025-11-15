import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class reactiveTextfield extends StatelessWidget {
  final String formControlName;
  final String hintText;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final Icon? prefixIcon;
  final bool ispassword;
  const reactiveTextfield(
      {super.key,
      required this.formControlName,
      required this.hintText,
      this.prefixIcon,
      this.validationMessages,
      this.ispassword=false});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      obscureText: ispassword?true:false,
      formControlName: formControlName,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: const Color(0xffFFF5F5),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
