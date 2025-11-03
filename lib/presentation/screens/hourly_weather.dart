import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/widgets/weather_scaffold.dart';

class HourlyWeather extends StatelessWidget {
  const HourlyWeather({super.key});

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
              shrinkWrap: true,
              itemBuilder: (context, i) {
                final dayHourTime = provider.futureForecast?.forecastday[i];
                final date = DateFormat(
                  'yyyy-MM-dd',
                ).parse(dayHourTime?.date ?? "");
                return Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('dd MMMM').format(date),
                          style: textTheme.headlineSmall!.copyWith(color:Colors.blueGrey),
                        ),
                      ),
                      Column(
                        children: List.generate(dayHourTime?.hour?.length ?? 0, (
                          idx,
                        ) {
                          final hour = dayHourTime?.hour?[idx];
                          return Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              leading: Text(
                                hour!.time!.split(" ").last,
                                style: textTheme.bodyMedium,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "${hour.tempC!.toInt()}°C",
                                    style: textTheme.bodyLarge,
                                  ),
                                  // SizedBox(width: 24,),
                                  Spacer(),
                                  Image.network(
                                    "https:${hour.condition?.icon}",
                                    height: 25,
                                    width: 25,
                                  ),
                                ],
                              ),

                              children: [
                                GridView(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,childAspectRatio: 1.6
                                      ),
                                  children: [
                                    weatherDeatilsCard(textTheme, Icons.thermostat, Colors.redAccent, "Feels Like", "${hour.feelslikeC!.toInt()}°C",),
                                    weatherDeatilsCard(textTheme, Icons.wind_power_rounded, Colors.blueAccent, "Wind", "${hour.windDir} ${hour.windKph} km/h",),
                                    weatherDeatilsCard(textTheme,  Iconsax.sun_fog, Colors.yellow, "UV Index", "${hour.uv} of 11"),
                                    weatherDeatilsCard(textTheme,  Icons.opacity, Colors.purpleAccent, "Humidity",  "${hour.humidity}%"),
                                    weatherDeatilsCard(textTheme,   Icons.cloud, Colors.blueGrey,  "Cloud Cover",  "${hour.cloud}%"),
                                    weatherDeatilsCard(textTheme, Icons.water_drop_outlined,  Colors.lightBlueAccent, "Chance of Rain", "${hour.chanceOfRain}%")
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: provider.futureForecast?.forecastday.length ?? 0,
            ),
          );
  }

  Widget weatherDeatilsCard(TextTheme textTheme, IconData icon, Color iconColor, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color:iconColor),
              Text(label,
              softWrap: true,
               style: textTheme.titleMedium!.copyWith(fontSize: 12)),
              
            ],
          ),
          SizedBox(height: 12,),
          Text(
            value,
            style: textTheme.titleLarge!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
