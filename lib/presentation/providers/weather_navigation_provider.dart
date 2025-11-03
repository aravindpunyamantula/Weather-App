import 'package:flutter/cupertino.dart';

class WeatherNavigationProvider extends ChangeNotifier{
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeScreen(int n){
    _selectedIndex = n;
    notifyListeners();
  }

}