import 'package:flutter/cupertino.dart';

class TodaysWeatherProvider extends ChangeNotifier{
  bool _isSearch = false;
  bool get isSearch => _isSearch;

  void updateIsSearch(bool val){
    _isSearch = val;
    notifyListeners();
  }
}