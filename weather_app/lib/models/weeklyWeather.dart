class DailyWeather {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final String icon;
  final String description;

  DailyWeather({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.icon,
    required this.description,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      tempMin: (json['temp']['min'] as num).toDouble(),
      tempMax: (json['temp']['max'] as num).toDouble(),
      humidity: json['humidity'],
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}
