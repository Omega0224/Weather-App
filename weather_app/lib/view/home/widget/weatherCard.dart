import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final int temperature;
  final int high;
  final int low;
  final String city;
  final String condition;
  final String iconPath;
  final VoidCallback onTap;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.high,
    required this.low,
    required this.city,
    required this.condition,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF6A5AE0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temperature°',
                    style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'H:$high°  L:$low°',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    city,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    condition,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Image.network(
              'http://openweathermap.org/img/w/$iconPath.png',
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
            )
            ),
          ],
        ),
      ),
    );
  }
}
