import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;

  bool _isRunning = false;

  bool get isRunning => _isRunning;

  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;

  void startTimer(int seconds) {
    if (_isRunning) return;

    _remainingSeconds = seconds;
    _isRunning = true;

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _remainingSeconds = _remainingSeconds - 1;
      notifyListeners();
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _isRunning = false;
      }
    });

    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }
}