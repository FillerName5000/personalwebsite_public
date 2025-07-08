import 'dart:async';

import 'package:flutter/material.dart';

class SecondLoopingProvider extends ChangeNotifier {
  SecondLoopingProvider() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }

  DateTime _currentTime = DateTime.now();
  DateTime get currentTime => _currentTime;

  void updateTime() {
    _currentTime = DateTime.now();
    notifyListeners();
  }
}
