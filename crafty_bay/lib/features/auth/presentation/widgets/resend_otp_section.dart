import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../providers/timer_provider.dart';

class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({super.key});

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  final TimerProvider _timerProvider = TimerProvider();

  @override
  void initState() {
    super.initState();
    _timerProvider.startTimer(30);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _timerProvider,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Consumer<TimerProvider>(
            builder: (context, timerProvider, _) {
              return Row(
                children: [
                  if (timerProvider.isRunning)
                    Text('Resend OTP after ${timerProvider.remainingSeconds}s'),
                  TextButton(
                    onPressed: _onTapResendButton,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: timerProvider.isRunning
                            ? Colors.grey
                            : AppColors.themeColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTapResendButton() {
    if (_timerProvider.isRunning) return;

    _timerProvider.startTimer(60);
  }
}
