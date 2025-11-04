import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/current_weather_entity.dart';

class BackgroundThemeProvider  with ChangeNotifier{
  Gradient _currentGradient = _afternoonGradient;
  Color _bottomNavColor = const Color(0xFFc2e9fb); 
  Color _textColor =  Colors.black;
  Color _iconColor = Colors.grey;

  Gradient get currentGradient => _currentGradient;
  Color get bottomNavColor => _bottomNavColor;
  Color get textColor => _textColor;
  Color get iconColor => _iconColor;

  void updateBg(CurrentWeatherEntity? weather){
    if(weather == null) return;

    final condition = weather.conditionText.toLowerCase();
     int hour =int.parse(weather.localTime.split(' ').last.split(':').first) ;

     if (condition.contains('rain')) {
      _currentGradient = _rainyGradient;
      _bottomNavColor = const Color(0xFF4286f4);
      _textColor = Colors.white;
      _iconColor = Colors.white;
    } else if (condition.contains('snow')) {
      _currentGradient = _snowGradient;
      _bottomNavColor = const Color(0xFFcfdef3);
      _textColor =  Colors.black;
      _iconColor =  Colors.black;
    } else if (hour >= 6 && hour < 12) {
      _currentGradient = _afternoonGradient;
      _bottomNavColor = const Color(0xFFc2e9fb);
      _textColor =  Colors.black;
    } else if (hour >= 12 && hour < 17) {
      _currentGradient = _afternoonGradient;
      _bottomNavColor = const Color(0xFFc2e9fb);
      _textColor =  Colors.black;
    } else if (hour >= 17 && hour < 20) {
      _currentGradient = _eveningGradient;
      _bottomNavColor = const Color(0xFFa6c1ee);
     _textColor =  Colors.black;
     _iconColor =  Colors.black;
    } else {
      _currentGradient = _nightGradient;
      _bottomNavColor = const Color(0xFF2c5364);
      _textColor = Colors.white;
    }
    notifyListeners();
  }



  static const _afternoonGradient = LinearGradient(
    colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const _eveningGradient = LinearGradient(
    colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const _nightGradient = LinearGradient(
    colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const _rainyGradient = LinearGradient(
    colors: [Color(0xFF373B44), Color(0xFF4286f4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const _snowGradient = LinearGradient(
    colors: [Color(0xFFe0eafc), Color(0xFFcfdef3)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

