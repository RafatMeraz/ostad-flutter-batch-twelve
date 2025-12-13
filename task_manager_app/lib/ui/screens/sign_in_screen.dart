import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/providers/sign_in_provider.dart';
import 'package:task_manager_app/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_holder_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _signInProvider,
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a your email';
                        }
                        if (EmailValidator.validate(value!) == false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter a your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Consumer<SignInProvider>(
                      builder: (context, signInProvider, child) {
                        return Visibility(
                          visible: signInProvider.signInProgress == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: FilledButton(
                            onPressed: _onTapSignInButton,
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPasswordButton,
                            child: Text('Forgot Password?'),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                  style: TextStyle(color: Colors.green),
                                  text: 'Sign Up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    final bool isSuccess = await _signInProvider.signIn(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );

    if (isSuccess) {
      Navigator.pushReplacementNamed(context, MainBottomNavHolderScreen.name);
    } else {
      showSnackBarMessage(context, _signInProvider.errorMessage!);
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }
}
