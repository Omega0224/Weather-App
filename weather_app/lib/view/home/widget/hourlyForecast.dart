import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/sevices/api.dart';

class hourlyforecast extends StatefulWidget {
  final double lat;
  final double lon;
  const hourlyforecast({super.key, required this.lat, required this.lon});

  @override
  State<hourlyforecast> createState() => _hourlyforecastState();
}

class _hourlyforecastState extends State<hourlyforecast> {
  DateTime date = DateTime.now();
  bool sameTime = false;
  Forecast? hourlyForecast;

  @override
  void initState(){
    super.initState();
    print(widget.lat);
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    Forecast fetchedForecast = await ApiWeather.getForecast(widget.lat, widget.lon);

    setState(() {
      hourlyForecast = fetchedForecast;
      
    });
  }
  
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String nowHour = DateFormat('h a').format(now);
    final String nowDay = DateFormat('EEE').format(now);

    if (hourlyForecast == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<WeatherEntry> forecast = hourlyForecast!.list;

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final data = forecast[index];
          final dateTime = DateTime.parse(data.dtTxt);
          final forecastHour = DateFormat('h a').format(dateTime);
          final forecastDay = DateFormat('EEE').format(dateTime);

          bool isNow = (forecastHour == nowHour) && (forecastDay == nowDay);
          String clockLabel = isNow ? 'Now' : forecastHour;

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
                Text(clockLabel, style: _timeText(), maxLines: 1),
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


  TextStyle _timeText() => GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

  TextStyle _tempText({bool bold = false}) => GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

  TextStyle _humidityText() => GoogleFonts.poppins(
        fontSize: 10,
        color: Colors.cyanAccent,
        fontWeight: FontWeight.bold,
      );