import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/background_theme_provider.dart';
import 'package:weather_app/presentation/providers/weather_navigation_provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/screens/daily_weather.dart';
import 'package:weather_app/presentation/screens/home_page.dart';
import 'package:weather_app/presentation/screens/hourly_weather.dart';
import 'package:weather_app/presentation/widgets/weather_scaffold.dart';

class WeatherNavigationBar extends StatefulWidget {
  const WeatherNavigationBar({super.key});

  @override
  State<WeatherNavigationBar> createState() => _WeatherNavigationBarState();
}

class _WeatherNavigationBarState extends State<WeatherNavigationBar> {
  final box = Hive.box("UserWeatherDeatils");

  @override
  void initState() {
    super.initState();
    if (box.get("location") != null && box.get('location').isNotEmpty) {
      String location = box.get('location');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<WeatherProvider>(context, listen: false);
        provider.setLocation(location);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<WeatherNavigationProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final bgProvider = Provider.of<BackgroundThemeProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (weatherProvider.weather != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bgProvider.updateBg(weatherProvider.weather);
      });
    }

    List<Widget> screens = [HomePage(), HourlyWeather(), DailyWeather()];
    return weatherProvider.error != null
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    weatherProvider.error!.split('Exception:').last,
                    style: textTheme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 2),
                  TextButton(
                    onPressed: () {
                      weatherProvider.editError(null);
                      weatherProvider.loadLocations(
                        weatherProvider.location ?? "",
                      );
                    },
                    child: Text(
                      "Try Again",
                      style: textTheme.bodyLarge!.copyWith(
                        color: Colors.blue,
                        decorationColor: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : WeatherScaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navProvider.selectedIndex,
              onTap: (val) {
                navProvider.changeScreen(val);
              },
              selectedItemColor: bgProvider.iconColor,
              unselectedItemColor: Colors.blueGrey,
              selectedIconTheme: IconThemeData(
                color: bgProvider.iconColor,
                size: 26,
                fill: 0.8,
              ),
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              enableFeedback: true,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.calendar),
                  label: "Today",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.clock),
                  label: "Hourly",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.calendar_2),
                  label: "Daily",
                ),
              ],
            ),
            body: screens[navProvider.selectedIndex],
          );
  }
}
