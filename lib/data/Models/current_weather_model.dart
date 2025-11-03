import 'package:flutter/foundation.dart';
import 'package:weather_app/domain/entities/current_weather_entity.dart';

class CurrentWeatherModel {
  Location? location;
  Current? current;

  CurrentWeatherModel({this.location, this.current});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  
  CurrentWeatherEntity toEntity() {
    return CurrentWeatherEntity(
      cityName: location?.name ?? "Unknown",
      tempratureC: current?.tempC?.toInt() ?? 0 , 
      conditionText: current?.condition?.text ?? "" , 
      iconUrl: current?.condition?.icon ?? "", 
      feelslikeC: current?.feelslikeC?.toDouble() ?? 0.0, 
      windKph: current?.windKph?.toDouble() ?? 0.0, 
      pressureIn: current?.pressureIn?.toDouble() ?? 0.0, 
      humidity: current?.humidity?.toInt() ?? 0, 
      cloud: current?.cloud?.toInt() ?? 0, 
      heatindexC: current?.heatindexC?.toDouble() ?? 0.0, 
      dewpointC: current?.dewpointC?.toDouble() ?? 0.0, 
      uv: current?.uv?.toInt() ?? 0, 
      lastUpdated: current?.lastUpdated?.toString() ?? "",
      windDir: current?.windDir?.toString() ?? '',
      pressureMb:current?.pressuremb?.toDouble() ?? 0.0, 
      visibility: current?.visibility?.toDouble() ?? 0.0,
      localTime: location?.localtime ?? ""
    );
  }

}

class Location {
  String? name;
  String? region;
  String? country;
  String? localtime;

  Location({this.name, this.region, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
  }
}


class Current{
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  String? windDir;
  double? pressureIn;
  double? pressuremb;
  double? humidity;
  double? cloud;
  double? feelslikeC;
  double? heatindexC;
  double? dewpointC;
  double? uv;
  double? visibility;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.windDir,
    this.pressureIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.heatindexC,
    this.dewpointC,
    this.uv,
    this.pressuremb,
    this.visibility

  });

  Current.fromJson(Map<String, dynamic> json) {
  try {
    lastUpdatedEpoch = (json['last_updated_epoch'] as num?)?.toInt();
    lastUpdated = json['last_updated'];
    tempC = (json['temp_c'] as num?)?.toDouble();
    isDay = (json['is_day'] as num?)?.toInt();
    condition =
        json['condition'] != null ? Condition.fromJson(json['condition']) : null;
    windKph = (json['wind_kph'] as num?)?.toDouble();
    windDir = json['wind_dir'];
    pressureIn = (json['pressure_in'] as num?)?.toDouble();
    pressuremb = (json['pressure_mb'] as num?)?.toDouble();
    humidity = (json['humidity'] as num?)?.toDouble();
    cloud = (json['cloud'] as num?)?.toDouble();
    feelslikeC = (json['feelslike_c'] as num?)?.toDouble();
    heatindexC = (json['heatindex_c'] as num?)?.toDouble();
    dewpointC = (json['dewpoint_c'] as num?)?.toDouble();
    uv = (json['uv'] as num?)?.toDouble();
    visibility = (json['vis_km'] as num?)?.toDouble();
  } catch (e, stack) {
    debugPrint("⚠️ Error parsing CurrentWeather JSON: $e");
    debugPrint("Offending JSON data: $json");
    debugPrint("Stack trace: $stack");
  }
}

}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon,});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}
