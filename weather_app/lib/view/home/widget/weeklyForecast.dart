import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/sevices/api.dart';

class weeklyForecast extends StatefulWidget {
  final double lat;
  final double lon;
  const weeklyForecast({super.key, required this.lat, required this.lon});

  @override
  State<weeklyForecast> createState() => _weeklyForecastState();
}

class _weeklyForecastState extends State<weeklyForecast> {
  DateTime date = DateTime.now();
  bool sameTime = false;
  Forecast? weeklyForecast;

  @override
  void initState(){
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    Forecast fetchedForecast = await ApiWeather.getForecast(widget.lat, widget.lon);
    setState(() {
      weeklyForecast = fetchedForecast;
    });
  }
  
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String nowDay = DateFormat('EEE').format(now); 

    if (weeklyForecast == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<WeatherEntry> dailyForecast = weeklyForecast!.list
      .where((entry) => entry.dtTxt.contains('12:00:00'))
      .toList();

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyForecast.length,
        itemBuilder: (context, index) {
          final data = dailyForecast[index];
          final dateTime = DateTime.parse(data.dtTxt);
          final String forecastDay = DateFormat('EEE', 'en_US').format(dateTime);

          bool isNow = forecastDay == nowDay;

          String iconCode = data.weather.first.icon;
          Widget weatherIcon = Image.network(
            'http://openweathermap.org/img/w/$iconCode.png',
            width: 30,
            height: 30,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
          );

          String temp = '${data.main.temp.round()}°';

          String humidityText = '${data.main.humidity}%';

          return Container(
            width: 60,
            height: 146,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isNow
                  ? colors.purpleColor.withOpacity(0.8)
                  : colors.purpleColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: colors.blackColor.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(forecastDay, style: _timeText(), maxLines: 1),
                const SizedBox(height: 5),
                weatherIcon,
                 Text(humidityText, style: _humidityText()),
                const SizedBox(height: 5),
                Text(temp, style: _tempText(bold: true)),
              ],
            ),
          );

        },
      ),
    );
  }
}


  TextStyle _timeText({bool bold = false}) => GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );

  TextStyle _tempText({bool bold = false}) => GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );

  TextStyle _humidityText() => GoogleFonts.poppins(
        fontSize: 10,
        color: Colors.cyanAccent,
        fontWeight: FontWeight.w600,
      );