import 'package:flutter/material.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../widgets/app_logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  AppLogo(),
                  const SizedBox(height: 24),
                  Text('Sign Up With Email', style: context.textTheme.titleLarge),
                  Text(
                    'Get started with your details',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) =>
                        Validators.validateEmail(value, 'Email is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'First name'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'First name is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'Last name is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Phone'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'Phone is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'City'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'City name is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) =>
                        Validators.validatePassword(value),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {}

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
