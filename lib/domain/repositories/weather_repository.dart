import 'package:weather_app/domain/entities/current_weather_entity.dart';
import 'package:weather_app/domain/entities/future_forecast_entity.dart';
import 'package:weather_app/domain/entities/search_locations_entity.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherEntity> getCurrentWeather(String city);
  Future<List<SearchLocationsEntity>> getLocations(String search);
  Future<FutureForecastEntity> getFutureWeather(String city);
}