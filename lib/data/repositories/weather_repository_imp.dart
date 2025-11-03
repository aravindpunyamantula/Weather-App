import 'package:weather_app/data/datasources/apis_fetching.dart';
import 'package:weather_app/domain/entities/current_weather_entity.dart';
import 'package:weather_app/domain/entities/future_forecast_entity.dart';
import 'package:weather_app/domain/entities/search_locations_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImp implements WeatherRepository{
  final WeatherApisFetching apiService;

  WeatherRepositoryImp(this.apiService);

  @override
  Future<CurrentWeatherEntity> getCurrentWeather(String city)async {
    final model = await apiService.fetchCurrentWeather(city);
    return model.toEntity(); 
  }

  @override
  Future<List<SearchLocationsEntity>> getLocations(String search) async {
    final model = await apiService.fetchPlaces(search);
    return model.map((m)=>m.toEntity()).toList();
  }

  @override
  Future<FutureForecastEntity> getFutureWeather(String city) async{
    final model = await apiService.fetchFutureForecast(city);
    return  model.forecast!.toEntity();
  }
}