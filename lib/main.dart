import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/datasources/apis_fetching.dart';
import 'package:weather_app/data/repositories/weather_repository_imp.dart';
import 'package:weather_app/domain/usecases/fetch_current_weather_usecase.dart';
import 'package:weather_app/presentation/providers/background_theme_provider.dart';
import 'package:weather_app/presentation/providers/todays_weather_provider.dart';
import 'package:weather_app/presentation/providers/weather_navigation_provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:weather_app/presentation/screens/weather_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('UserWeatherDeatils');
  await dotenv.load(fileName: ".env");

  final apiService = WeatherApisFetching(
    baseUrl: dotenv.env['BASE_URL']!,
    apiKey: dotenv.env['API_KEY']!,
  );

  final repository = WeatherRepositoryImp(apiService);
  final usecase = FetchCurrentWeatherUsecase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider(usecase)),
        ChangeNotifierProvider(create: (_) => WeatherNavigationProvider()),
        ChangeNotifierProvider(create: (_) => TodaysWeatherProvider()),
        ChangeNotifierProvider(create: (_)=>BackgroundThemeProvider())
      ],
      child: kIsWeb ? DevicePreview(builder: (_) => MyApp()) : const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Consumer<BackgroundThemeProvider>(
      builder: (context, provider, _){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey[100],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: provider.bottomNavColor,
            selectedItemColor: provider.textColor,
            selectedIconTheme: IconThemeData(color: provider.textColor),
            elevation: 0
          ),
          expansionTileTheme: ExpansionTileThemeData(
            shape: RoundedRectangleBorder(),
            childrenPadding: EdgeInsets.all(12)
          ),
          cardColor: Colors.white,
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: provider.textColor),//h1
            headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: provider.textColor),
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: provider.textColor),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: provider.textColor),//h4
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: provider.textColor),//sub heading
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: provider.textColor),//buttons
            bodyMedium: TextStyle(fontSize: 14, color: provider.textColor),
            bodySmall: TextStyle(fontSize: 12, color: provider.textColor),
            labelLarge: TextStyle(fontSize: 10, color: provider.textColor),//caption
            labelMedium: TextStyle(fontSize: 8, color: provider.textColor),//overline
        
      
          )
        ),
        home: WeatherNavigationBar(),
      );
      },
    );
  }
}
