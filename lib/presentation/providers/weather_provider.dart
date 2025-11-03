import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:weather_app/domain/entities/current_weather_entity.dart';
import 'package:weather_app/domain/entities/future_forecast_entity.dart';
import 'package:weather_app/domain/entities/search_locations_entity.dart';
import 'package:weather_app/domain/usecases/fetch_current_weather_usecase.dart';

class WeatherProvider extends ChangeNotifier{
  final box = Hive.box("UserWeatherDeatils");
  final FetchCurrentWeatherUsecase fetchCurrentWeather;
  WeatherProvider(this.fetchCurrentWeather);

  
  bool _isLocationsLoading = false;
  bool _isCurrentWeatherLoading = false;
  bool _isFutureForecastLoading = false;

  String? _error;
  String? _selectedLocation;
  
  
  

  CurrentWeatherEntity? _weather;
  List<SearchLocationsEntity>? _locations;
  FutureForecastEntity? _futureForecast;

  bool get isLocationsLoading => _isLocationsLoading;
  bool get isCurrentWeatherLoading => _isCurrentWeatherLoading;
  bool get isFutureForecastLoading => _isFutureForecastLoading;
  String? get error => _error;
  String? get location => _selectedLocation;
  List<SearchLocationsEntity>? get locations => _locations;
  CurrentWeatherEntity? get weather => _weather;
  FutureForecastEntity? get futureForecast => _futureForecast;

  void editError(String? msg){
    _error = msg;
    notifyListeners();
  }

  void setLocation(String location) async{
    _selectedLocation = location;
    _error = null;
    _isCurrentWeatherLoading = true;
    _isFutureForecastLoading = true;
    notifyListeners();

    try{
      final weatherData = await fetchCurrentWeather.execute(location);
      final forecastData = await fetchCurrentWeather.getFutureWeather(location);

      _weather = weatherData;
      _futureForecast = forecastData;
      box.put("location", location);
      clearLocations();

    }on SocketException catch(e){
      debugPrint(e.message);
      _error = e.message;
    }on ClientException catch(e){
      debugPrint(e.message);
      _error = e.message;
    }catch (e){
      _error = e.toString();
    }finally{
      _isCurrentWeatherLoading = false;
      _isFutureForecastLoading = false;
      notifyListeners();
    }

    
  }

  void clearLocations() {
  _locations = null;
  notifyListeners();
}




  Timer? _debounce;
  void loadLocations(String search) {
    if(_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer( Duration(milliseconds: 600), () async {
      _isLocationsLoading = true;
    _error = null;
    notifyListeners();
    try{
     _locations = await fetchCurrentWeather.search(search);
    }catch(e){
      _error = e.toString();
    }finally{
      _isLocationsLoading = false;
      notifyListeners();
    }

    });
    
  }



}