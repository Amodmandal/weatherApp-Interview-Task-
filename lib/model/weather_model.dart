import 'dart:convert';

class WeatherModel {
  final double temp;
  final String text;
  final String icon;

  WeatherModel({required this.temp, required this.text, required this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['current']['temp_c'],
      text: json['current']['condition']['text'],
      icon: "https:${json['current']['condition']['icon']}",
    );
  }
}
