import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/center_circular_progress.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../providers/verify_otp_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/resend_otp_section.dart';
import 'sign_in_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name = '/verify-otp';

  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _verifyOtpProvider,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    AppLogo(),
                    const SizedBox(height: 24),
                    Text('Enter Your OTP', style: context.textTheme.titleLarge),
                    Text(
                      'Verify your otp that has been sent to your email',
                      textAlign: .center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PinCodeTextField(
                      controller: _otpTEController,
                      keyboardType: TextInputType.number,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: Duration(milliseconds: 300),
                      appContext: context,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 50,
                      ),
                      validator: (String? value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter your otp';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        if (_verifyOtpProvider.verifyOtpInProgress) {
                          return CenterCircularProgress();
                        }
                        return FilledButton(
                          onPressed: _onTapVerifyButton,
                          child: Text('Verify'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ResendOtpSection(),
                    TextButton(
                      onPressed: _onTapSignInButton,
                      child: Text('Already have an account? Sign in'),
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
    Navigator.pushNamed(context, SignInScreen.name);
  }

  Future<void> _onTapVerifyButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await _verifyOtpProvider.verifyOtp(
        email: widget.email,
        otp: _otpTEController.text,
      );
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainNavHolderScreen.name,
          (_) => false,
        );
      } else {
        showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
      }
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
