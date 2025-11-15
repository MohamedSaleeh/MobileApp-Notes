import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordDialog extends StatelessWidget {
  final List<String> hint;
  final Function actionOK;
  final String title;
  final List<String> controlName;
  final FormGroup formGroup;
  final String textButton;
  const PasswordDialog({
    super.key,
    required this.hint,
    required this.actionOK,
    required this.title,
    required this.controlName,
    required this.formGroup,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(22.0),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ReactiveTextField(
                obscureText: true,
                formControlName: controlName[0],
                decoration: InputDecoration(
                  hintText: hint[0],
                  filled: true,
                  fillColor: const Color(0xFFFFF5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validationMessages: {
                  ValidationMessage.minLength: (error) =>
                      "Password must be at least 8 characters",
                },
              ),
              const SizedBox(height: 8),
              ReactiveTextField(
                obscureText: true,
                formControlName: controlName[1],
                decoration: InputDecoration(
                  hintText: hint[1],
                  filled: true,
                  fillColor: const Color(0xFFFFF5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validationMessages: {
                  ValidationMessage.minLength: (error) =>
                      "Password must be at least 8 characters",
                },
              ),
              const SizedBox(height: 8),
              ReactiveTextField(
                obscureText: true,
                formControlName: controlName[2],
                decoration: InputDecoration(
                  hintText: hint[2],
                  filled: true,
                  fillColor: const Color(0xFFFFF5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validationMessages: {
                  ValidationMessage.minLength: (error) =>
                      "Passwords do not match",
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: actionOK(),
                    child: Text(
                      textButton,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
