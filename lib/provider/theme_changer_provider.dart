import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ThemeChanger extends ChangeNotifier{
  var _themeMode=ThemeMode.light;
  bool dark=false;
  ThemeMode get themeMode => _themeMode;

  void setTheme(themeMode){
    _themeMode=themeMode;
    dark=!dark;
    notifyListeners();
  }
}