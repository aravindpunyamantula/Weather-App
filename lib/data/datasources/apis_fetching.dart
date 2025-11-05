import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/Models/current_weather_model.dart';
import 'package:weather_app/data/Models/future_forecast.dart';
import 'package:weather_app/data/Models/search_place_model.dart';

class WeatherApisFetching {
final String  apiKey;
final String baseUrl;

WeatherApisFetching({required this.apiKey, required this.baseUrl,});

 Future<CurrentWeatherModel> fetchCurrentWeather(String location) async {
  final url = "${baseUrl}current.json?key=$apiKey&q=$location";
 try{
   final res = await http.get(Uri.parse(url));
  if(res.statusCode == 200){
    return CurrentWeatherModel.fromJson(jsonDecode(res.body));
  }else{
    debugPrint("Error");
    throw Exception("Unable to fetch your location");
  }
 }on SocketException{
  throw Exception("Check your connection");
 }on http.ClientException{
  throw Exception("Check your network and try again");
 }catch(e){
    throw Exception(e);
  }
}

Future<List<SearchPlaceModel>> fetchPlaces(String search) async{
  final url = "${baseUrl}search.json?key=$apiKey&q=$search";
  try{
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){
      List<dynamic> data = jsonDecode(res.body);
      return data.map((place)=>SearchPlaceModel.fromJson(place)).toList();
    }else{
      throw Exception();
    }
  }on SocketException{
  throw Exception("Check your connection");
 }on http.ClientException{
  throw Exception("Check your network and try again");
 }
  catch(e){
    throw Exception(e);
  }
}

Future<FutureForeCast> fetchFutureForecast(String city) async {
  final url = "${baseUrl}forecast.json?key=$apiKey&q=$city&days=7";

  try{
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){
      return FutureForeCast.fromJson(jsonDecode(res.body));
    }else{
      throw Exception("Unable to load");
    }

  }on SocketException{
  throw Exception("Check your connection");
 }on http.ClientException{
  throw Exception("Check your network and try again");
 }
  catch(e){
    throw Exception(e);
  }
}


}
