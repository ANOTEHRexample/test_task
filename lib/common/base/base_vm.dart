
import 'package:flutter/material.dart';

class BaseVM extends ChangeNotifier {
  bool isLoading = false;

  setLoading(bool isLoading, {bool notify = true}) {
    this.isLoading = isLoading;
    if (notify) {
      notifyListeners();
    }
  }
}