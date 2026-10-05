import 'package:flutter/material.dart';

class ProviderApp extends ChangeNotifier {
  int _indexBottomBar = 0;

  get indexBottomBar => _indexBottomBar;

  set indexBottomBar(int i) {
    _indexBottomBar = i;

    notifyListeners();
  }
}
