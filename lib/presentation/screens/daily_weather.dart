import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/widgets/weather_scaffold.dart';

class DailyWeather extends StatelessWidget {
  const DailyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return provider.location == null
        ? WeatherScaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 28, color: Colors.grey[500]),
                  SizedBox(height: 12),
                  Text(
                    "Select Your Location to Fetch Details",
                    style: textTheme.titleMedium!.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          )
        : WeatherScaffold(
            body: ListView.separated(
              itemBuilder: (context, index) {
                DateTime date = DateFormat(
                  'yyyy-MM-dd',
                ).parse(provider.futureForecast?.forecastday[index].date ?? "");

                return Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      "${DateFormat('EEE').format(date)}, ${DateFormat('dd MMM').format(date)}",
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Row(
                      children: [
                        Image.network(
                          "https:${provider.futureForecast?.forecastday[index].day?.condition?.icon}",
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "${provider.futureForecast?.forecastday[index].day?.avgtempC?.toInt() ?? 0}°C ${provider.futureForecast?.forecastday[index].day?.condition?.text}",
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${provider.futureForecast?.forecastday[index].day?.avgtempC?.toInt() ?? 0}°",
                                  style: textTheme.headlineLarge!.copyWith(
                                    color: Colors.purple,
                                    fontSize: 60,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Image.network(
                                  "https:${provider.futureForecast?.forecastday[index].day?.condition?.icon ?? ""}",
                                  height: 60,
                                  width: 60,
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.water_drop,
                                          color: Colors.lightBlueAccent,
                                        ),
                                        title: Text(
                                          "${provider.futureForecast?.forecastday[index].day?.dailyChanceOfRain ?? 0}%",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 159,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.wind_power_rounded,
                                          color: Colors.lightBlueAccent,
                                        ),
                                        title: Text(
                                          " ${provider.futureForecast?.forecastday[index].day?.maxwindKph ?? 0} km/h",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              "${provider.futureForecast?.forecastday[index].day?.condition?.text ?? ""}, Low ${provider.futureForecast?.forecastday[index].day?.mintempC?.toInt() ?? 0}°C",
                            ),
                            SizedBox(height: 12),
                            GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.55,
                                  ),
                              children: [
                                weatherDeatilCard(
                                  textTheme,
                                  Icons.opacity,
                                  "Humidity",
                                  "${provider.futureForecast?.forecastday[index].day?.avghumidity ?? 0}%",
                                ),
                                weatherDeatilCard(
                                  textTheme,
                                  Iconsax.sun_fog,
                                  "UV Index",
                                  "${provider.futureForecast?.forecastday[index].day?.uv ?? 0}",
                                ),
                                weatherDeatilCard(
                                  textTheme,
                                  Icons.sunny,
                                  "Sunrise",
                                  "${provider.futureForecast?.forecastday[index].astro?.sunrise ?? 0}",
                                ),
                                weatherDeatilCard(
                                  textTheme,
                                  Icons.wb_sunny_outlined,
                                  "Sunset",
                                  "${provider.futureForecast?.forecastday[index].astro?.sunset ?? 0}",
                                ),
                                weatherDeatilCard(
                                  textTheme,
                                  Iconsax.moon,
                                  "Moonrise",
                                  "${provider.futureForecast?.forecastday[index].astro?.moonrise ?? 0}",
                                ),
                                weatherDeatilCard(
                                  textTheme,
                                  Iconsax.moon,
                                  "Moonset",
                                  "${provider.futureForecast?.forecastday[index].astro?.moonset ?? 0}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: provider.futureForecast?.forecastday.length ?? 0,
            ),
          );
  }

  Container weatherDeatilCard(
    TextTheme textTheme,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blueGrey),
              SizedBox(width: 4),
              Text(
                label,
                style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: textTheme.titleLarge!.copyWith(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
