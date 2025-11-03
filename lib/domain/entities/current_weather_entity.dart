class CurrentWeatherEntity {
  final String cityName;
  final int tempratureC;
  final double feelslikeC;
  final double windKph;
  final double pressureIn;
  final double pressureMb;
  final int humidity;
  final int cloud;
  final double heatindexC;
  final double dewpointC;
  final int uv;
  final String conditionText;
  final String iconUrl;
  final String lastUpdated;
  final String windDir;
  final double visibility;
  final String localTime;


  const CurrentWeatherEntity({
    required this.cityName,
    required this.tempratureC,
    required this.feelslikeC,
    required this.windKph,
    required this.pressureIn,
    required this.humidity,
    required this.cloud,
    required this.heatindexC,
    required this.dewpointC,
    required this.uv,
    required this.conditionText,
    required this.iconUrl,
    required this.lastUpdated,
    required this.windDir,
    required this.pressureMb,
    required this.visibility,
    required this.localTime
  });
}