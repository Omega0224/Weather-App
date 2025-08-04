import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weathers.dart';
import 'package:weather_app/sevices/location.dart';

class ApiWeather {
  static final dio = Dio();
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static double lat = 0.0;
  static double lon = 0.0;
  static const apiKeys = 'a5a86b65b212af7412554a1e978a7bb8';

  static Future<void> fetchLocation() async {
    final location = await getLocation();
    lat = location.latitude;
    lon = location.longitude;
  }

  static Future<Weather> getCurrentWeather(double cityLat, double cityLon) async {
    if(lat == 0.0 && lon == 0.0){
      await fetchLocation();
    }else{
      lat = cityLat;
      lon = cityLon;
    }
    final url = constructWeatherUrl();
    final response = await fetchData(url);
    return Weather.fromJson(response);
  }

  static Future<Forecast> getForecast(double cityLat, double cityLon) async {
    if(lat == 0.0 && lon == 0.0){
      await fetchLocation();
    }else{
      lat = cityLat;
      lon = cityLon;
    }
    final url = constructForecastUrl();
    final response = await fetchData(url);
    return Forecast.fromJson(response);
  }

  static Future<Weather> getWeatherBySearch(String cityName) async {
    final url = constructCityWeatherUrl(cityName);
    final response = await fetchData(url);
    return Weather.fromJson(response);
  }

  static Future<Weather> getCityWeather(double cityLat, double cityLon) async {
    lat = cityLat;
    lon = cityLon;
    final url = constructWeatherUrl();
    final response = await fetchData(url);
    return Weather.fromJson(response);
  }

  static String constructWeatherUrl() => 
    '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKeys';
  
  static String constructForecastUrl() =>
    '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKeys';

  static String constructCityWeatherUrl(String cityName) =>
    '$baseUrl/weather?q=$cityName&units=metric&appid=$apiKeys';  

  static Future<Map<String, dynamic>> fetchData(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching data from $url: $e');
      throw Exception('Error fetching data');
    }
  }
}