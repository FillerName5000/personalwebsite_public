import 'package:flutter/material.dart';

class FontProvider extends ChangeNotifier {
  FontProvider() {
    _fontFamily = 'W95font';
  }
  late String _fontFamily;

  String get fontFamily => _fontFamily;

  void changeFontFamily() {
    _fontFamily = _fontFamily == "COUR" ? 'W95font' : 'COUR';
    notifyListeners();
  }
}
