import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDialog extends StatelessWidget {
  final String hint;
  final Function actionOK;
  final String title;
  final String controlName;
  final FormGroup formGroup;
  final String textButton;
  const CustomDialog(
      {super.key,
      required this.hint,
      required this.actionOK,
      required this.title,
      required this.controlName,
      required this.formGroup,
      required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(22.0),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ReactiveTextField(
                formControlName: controlName,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: const Color(0xFFFFF5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validationMessages: controlName == "username"
                    ? {
                        ValidationMessage.minLength: (error) =>
                            "Username must be at least 3 characters",
                      }
                    : {},
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: actionOK(),
                    child: Text(
                      textButton,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
