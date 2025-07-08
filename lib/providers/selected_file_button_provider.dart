import 'package:flutter/material.dart';

class SelectedFileButtonProvider extends ChangeNotifier {
  SelectedFileButtonProvider();
  int? _selectedFileButtonIndex;

  int? get selectedFileButtonIndex => _selectedFileButtonIndex;

  void setSelectedFileButtonIndex(int? index) {
    if (_selectedFileButtonIndex != index) {
      _selectedFileButtonIndex = index;
      notifyListeners();
    }
  }

  void unSelectSelectedFileButton() {
    _selectedFileButtonIndex = null;
    notifyListeners();
  }

  void resetSelectedFileButtonIndex() {
    if (_selectedFileButtonIndex != null) {
      _selectedFileButtonIndex = null;
      notifyListeners();
    }
  }
}
