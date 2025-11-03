import 'package:flutter/foundation.dart';
import 'package:weather_app/data/Models/current_weather_model.dart';
import 'package:weather_app/domain/entities/future_forecast_entity.dart';

class FutureForeCast {
  Forecast? forecast;

  FutureForeCast({this.forecast});

  FutureForeCast.fromJson(Map<String, dynamic> json) {
    forecast = json['forecast'] != null
        ? Forecast.fromJson(json['forecast'])
        : null;
  }

 

}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(Forecastday.fromJson(v));
      });
    }
  }
  
  FutureForecastEntity toEntity(){
    return FutureForecastEntity(forecastday: forecastday ?? []);
  }


}

class Forecastday {
  String? date;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.date,  this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add( Hour.fromJson(v));
      });
    }
  }

  Forecastday toEntity() {
    return Forecastday(
      date: date ?? "",
      day: day,
      astro: astro,
      hour: hour
    );
  }


}

class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? maxwindKph;
  int? avghumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  int? dailyWillItSnow;
  int? dailyChanceOfSnow;
  Condition? condition;
  double? uv;

  Day(
      {this.maxtempC,
     
      this.mintempC,
      this.avgtempC,
      this.maxwindKph,
      this.avghumidity,
      this.dailyWillItRain,
      this.dailyChanceOfRain,
      this.dailyWillItSnow,
      this.dailyChanceOfSnow,
      this.condition,
      this.uv});

  Day.fromJson(Map<String, dynamic> json) {
   try{ maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    dailyWillItSnow = json['daily_will_it_snow'];
    dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    uv = json['uv'];}catch (e){
      debugPrint("Error in Day $e");
    }
  }

}



class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  int? isMoonUp;
  int? isSunUp;

  Astro(
      {this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.isMoonUp,
      this.isSunUp});

  Astro.fromJson(Map<String, dynamic> json) {
    try{sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    isMoonUp = json['is_moon_up'];
    isSunUp = json['is_sun_up'];}catch (e){
      debugPrint("Error in astro $e");
    }
  }

 
}

class Hour {
  int? timeEpoch;
  String? time;
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  int? windDegree;
  String? windDir;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? windchillC;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;
  double? uv;


  Hour(
      {this.timeEpoch,
      this.time,
      this.tempC,
      this.isDay,
      this.condition,
      this.windKph,
      this.windDegree,
      this.windDir,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.windchillC,
      this.willItRain,
      this.chanceOfRain,
      this.willItSnow,
      this.chanceOfSnow,
      this.uv,});

  Hour.fromJson(Map<String, dynamic> json) {
  try {
    timeEpoch = (json['time_epoch'] as num?)?.toInt();
    time = json['time'];
    tempC = (json['temp_c'] as num?)?.toDouble();
    isDay = (json['is_day'] as num?)?.toInt();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = (json['wind_kph'] as num?)?.toDouble();
    windDegree = (json['wind_degree'] as num?)?.toInt();
    windDir = json['wind_dir'];
    humidity = (json['humidity'] as num?)?.toInt();
    cloud = (json['cloud'] as num?)?.toInt();
    feelslikeC = (json['feelslike_c'] as num?)?.toDouble();
    windchillC = (json['windchill_c'] as num?)?.toDouble();
    willItRain = (json['will_it_rain'] as num?)?.toInt();
    chanceOfRain = (json['chance_of_rain'] as num?)?.toInt();
    willItSnow = (json['will_it_snow'] as num?)?.toInt();
    chanceOfSnow = (json['chance_of_snow'] as num?)?.toInt();
    uv = (json['uv'] as num?)?.toDouble();
  } catch (e, stack) {
    debugPrint("Error in Hour Class: $e");
    debugPrint("Offending JSON: $json");
    debugPrint("Stack trace: $stack");
  }
}

 
}
