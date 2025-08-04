import 'package:flutter/material.dart';
import 'package:weather_app/material/color.dart';

class locWeather extends StatelessWidget {
  final String city;
  final String temp;
  final String weather;
  final String max;
  final String min;
  final double cityFont;
  final double tempFont;

  const locWeather({
    required this.city,
    required this.temp,
    required this.weather,
    required this.max,
    required this.min,
    required this.cityFont,
    required this.tempFont,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(city, style: TextStyle(color: colors.whiteColor, fontSize: cityFont)),
        Text(temp, style: TextStyle(color: colors.whiteColor, fontSize: tempFont, fontWeight: FontWeight.w100)),
        Text(weather, style: TextStyle(color: colors.greyColor, fontSize: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("H:$max", style: TextStyle(color: colors.whiteColor, fontSize: 20)),
            SizedBox(width: 10),
            Text("L:$min", style: TextStyle(color: colors.whiteColor, fontSize: 20)),
          ],
        )
      ],
    );
  }
}