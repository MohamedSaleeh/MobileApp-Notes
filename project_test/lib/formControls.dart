import 'package:reactive_forms/reactive_forms.dart';

final loginFormgroup = FormGroup({
  'email':
      FormControl<String>(validators: [Validators.email, Validators.required]),
  'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)]),
});

final signupFormgroup = FormGroup({
  'email':
      FormControl<String>(validators: [Validators.email, Validators.required]),
  'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)]),
  'username': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)]),
  'confirm_password': FormControl<String>(validators: [
    Validators.required,
    Validators.minLength(8),
  ]),
  'acceptTerms': FormControl<bool>(validators: [Validators.requiredTrue]),
}, validators: [
  Validators.mustMatch('password', 'confirm_password'),
]);

final notesFormgroup = FormGroup({
  'title': FormControl<String>(validators: [Validators.required]),
  'date': FormControl<String>(value: DateTime.now().toString(), validators: []),
  'content': FormControl<String>(validators: [Validators.required]),
});

final profileFormgroup = FormGroup({
  'email':
      FormControl<String>(validators: [Validators.email, Validators.required]),
  'username': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)]),
  'oldPassword': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)]),
  'newPassword': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)]),
  'matchNewPassword': FormControl<String>(validators: [
    Validators.required,
    Validators.minLength(8),
    Validators.mustMatch('newPassword', 'matchNewPassword')
  ]),
});

final forgotpassword = FormGroup({
  'email':
      FormControl<String>(validators: [Validators.email, Validators.required]),
});
