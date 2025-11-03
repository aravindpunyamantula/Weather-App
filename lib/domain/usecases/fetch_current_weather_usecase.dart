import 'package:weather_app/domain/entities/current_weather_entity.dart';
import 'package:weather_app/domain/entities/future_forecast_entity.dart';
import 'package:weather_app/domain/entities/search_locations_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class FetchCurrentWeatherUsecase {
  final WeatherRepository repo;

  FetchCurrentWeatherUsecase(this.repo);

  Future<CurrentWeatherEntity> execute(String city){
    return repo.getCurrentWeather(city);
  }

  Future<List<SearchLocationsEntity>> search(String search){
    return repo.getLocations(search);
  }

  Future<FutureForecastEntity> getFutureWeather(String city){
    return repo.getFutureWeather(city);
  }
}