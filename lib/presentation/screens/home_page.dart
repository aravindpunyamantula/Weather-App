import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/background_theme_provider.dart';
import 'package:weather_app/presentation/providers/todays_weather_provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/widgets/weather_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 
 @override
  void initState() {
    super.initState();
   
    
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final todaysWeatherProvider = Provider.of<TodaysWeatherProvider>(context);
    final bgProvider = Provider.of<BackgroundThemeProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

   

    return  WeatherScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //seach bar
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
                  padding: EdgeInsets.all(12),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: MediaQuery.sizeOf(context).width,
                  child: todaysWeatherProvider.isSearch
                      ? TextField(
                          onChanged: provider.loadLocations,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: bgProvider.iconColor,),
                            suffixIcon: IconButton(
                              onPressed: () {
                                todaysWeatherProvider.updateIsSearch(false);
                                provider.clearLocations();
                              },
                              icon: Icon(Icons.close, color: bgProvider.iconColor,),
                            ),
                            hintText: "Enter city name",
                            hintStyle: TextStyle(color: bgProvider.iconColor),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  todaysWeatherProvider.updateIsSearch(true);
                                },
                                icon: Icon(Icons.search, color: bgProvider.iconColor,),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                  provider.setLocation(provider.location ?? "");
                                }, 
                                icon: Icon(Icons.refresh_rounded, color: bgProvider.iconColor,)
                                )
                            ],
                          ),
                        ),
                ),
              ),
              if (provider.weather == null &&
                  !provider.isCurrentWeatherLoading &&
                  !todaysWeatherProvider.isSearch)
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text("Search Your Location"),
                        ],
                      ),
                    ],
                  ),
                ),
              if (provider.location == null &&
                      !todaysWeatherProvider.isSearch &&
                      provider.isCurrentWeatherLoading ||
                  provider.isFutureForecastLoading)
                Center(child: CircularProgressIndicator()),
              if (provider.location != null &&
                  !todaysWeatherProvider.isSearch &&
                  !provider.isCurrentWeatherLoading &&
                  !provider.isFutureForecastLoading)
                Center(
                  child: AnimatedContainer(
                    height: provider.isCurrentWeatherLoading ? 20 : 280,
                    width: MediaQuery.sizeOf(context).width,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.19),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            provider.weather?.cityName ?? "",
                            style: textTheme.titleLarge,
                          ),
                          SizedBox(height: 12),
                          Image.network(
                            "https:${provider.weather?.iconUrl}",
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text(
                                "${provider.weather?.tempratureC ?? 0}°C",
                                style: textTheme.headlineLarge!.copyWith(
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                provider.weather?.conditionText ?? "",
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Text("Feels Like", style: textTheme.bodyLarge),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.device_thermostat, color: Colors.blue),
                              SizedBox(width: 4),
                              Text(
                                "${provider.weather?.feelslikeC.toInt() ?? 0}°",
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      
              if (provider.locations != null && provider.locations!.isNotEmpty && provider.error == null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.all(12),
                    height: provider.isLocationsLoading ? 20 : 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: provider.isLocationsLoading
                        ? Center(child: CupertinoActivityIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.locations?.length ?? 0,
                            itemBuilder: (context, index) {
                              final loc = provider.locations![index];
                              return ListTile(
                                contentPadding: EdgeInsets.all(0),
                                onTap: (){
                                  provider.setLocation(loc.name);
                                  todaysWeatherProvider.updateIsSearch(false);
                                  if(provider.isCurrentWeatherLoading){
                                    Future.delayed(Duration(seconds: 2));
                                  }

                                  Provider.of<BackgroundThemeProvider>(context, listen: false).updateBg(provider.weather);

                                },
                                title: Text(
                                  '${loc.name}, ${loc.region}, ${loc.country}',
                                ),
                              );
                            },
                          ),
                  ),
                ),
              SizedBox(height: 12),
              if (provider.weather != null &&
                  !todaysWeatherProvider.isSearch &&
                  !provider.isCurrentWeatherLoading &&
                  !provider.isFutureForecastLoading)
                AnimatedContainer(
                  margin: EdgeInsets.all(12),
                  duration: Duration(milliseconds: 300),
                  height: provider.isCurrentWeatherLoading ? 20 : 340,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.19),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        customTile(
                          provider,
                          Icons.wind_power_outlined,
                          "Wind",
                          "${provider.weather?.windKph ?? 0}km/h",
                          textTheme,
                          Colors.teal
                        ),
                        customTile(
                          provider,
                          Icons.directions,
                          "Wind Direction",
                          "${provider.weather?.windDir}",
                          textTheme,
                          Colors.deepOrange
                        ),
                        customTile(
                          provider,
                          Icons.opacity,
                          "Humidity",
                          "${provider.weather?.humidity ?? 0}%",
                          textTheme,
                          Colors.blueAccent
                        ),
                        customTile(
                          provider,
                          Iconsax.activity,
                          "Dew Point",
                          "${provider.weather?.dewpointC.toInt() ?? 0}°",
                          textTheme,
                          Colors.red
                        ),
                        customTile(
                          provider,
                          Iconsax.sun_fog,
                          "UV Index",
                          "${provider.weather?.uv.toInt() ?? 0}",
                          textTheme,
                          Colors.amber
                        ),
                        customTile(
                          provider,
                          Icons.speed,
                          "Pressure",
                          "${provider.weather?.pressureMb ?? 0}mb",
                          textTheme,
                          Colors.cyan
                        ),
                        customTile(
                          provider,
                          Icons.visibility,
                          "Visibility",
                          "${provider.weather?.visibility ?? 0} km",
                          textTheme,
                          Colors.indigo
                        ),
                      ],
                    ),
                  ),
                ),
      
              SizedBox(height: 12),
              if (provider.weather != null &&
                  !todaysWeatherProvider.isSearch &&
                  !provider.isCurrentWeatherLoading &&
                  !provider.isFutureForecastLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.19),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.wb_sunny_outlined, color: Colors.amber),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "SunRise ",
                                    style: textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text:
                                        " ${provider.futureForecast?.forecastday[0].astro?.sunrise}",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "SunSet ",
                                    style: textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text:
                                        " ${provider.futureForecast?.forecastday[0].astro?.sunset}",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.19),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(Iconsax.moon, color: Colors.lightBlueAccent),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "MoonRise ",
                                    style: textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text:
                                        " ${provider.futureForecast?.forecastday[0].astro?.moonrise}",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "MoonSet ",
                                    style: textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text:
                                        " ${provider.futureForecast?.forecastday[0].astro?.moonset}",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
              SizedBox(height: 12),
              if (provider.location != null &&
                  !todaysWeatherProvider.isSearch &&
                  !provider.isCurrentWeatherLoading &&
                  !provider.isFutureForecastLoading)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text("Hourly Forecast", style: textTheme.titleLarge,),
                )),
              if (provider.location != null &&
                  !todaysWeatherProvider.isSearch &&
                  !provider.isCurrentWeatherLoading &&
                  !provider.isFutureForecastLoading)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: List.generate(
                        provider.futureForecast?.forecastday[0].hour?.length ??
                            0,
                        (i) {
                          final time =
                              provider.futureForecast?.forecastday[0].hour?[i];
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.19),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Text("${time?.time!.split(" ").last}"),
                                Image.network(
                                  "https:${time?.condition?.icon}",
                                  height: 50,
                                  width: 50,
                                ),
                                Text("${time?.tempC?.toInt()}°C"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              
              if(provider.location != null && provider.weather != null && !todaysWeatherProvider.isSearch)
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  child: Text("Last Updated: ${provider.weather?.lastUpdated ?? " "}", style: textTheme.labelLarge,)))

            ],
          ),
        ),
      ),
    );
  }

  ListTile customTile(
    WeatherProvider provider,
    IconData icon,
    String label,
    String value,
    TextTheme textTheme,
    Color iconColor
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor,),
      title: Text(label),
      trailing: Text(value, style:textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold) ,),
    );
  }
}
