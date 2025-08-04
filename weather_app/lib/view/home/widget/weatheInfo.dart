import 'package:flutter/material.dart';

class AirQualityWidget extends StatelessWidget {
  final int airQualityIndex;
  final String description;

  const AirQualityWidget({
    super.key,
    required this.airQualityIndex,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xFF2A1659), Color(0xFF3B1E77)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AIR QUALITY',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$airQualityIndex - $description',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              // Gradient bar background
              Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF42A5F5), // biru
                      Color(0xFFAB47BC), // ungu
                      Color(0xFFF06292), // pink
                    ],
                  ),
                ),
              ),
              // Slider indicator
              Positioned(
                left: (airQualityIndex / 10) * 300, // Sesuaikan panjang
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'See more',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.9))
            ],
          )
        ],
      ),
    );
  }
}

class UVIndexCard extends StatelessWidget {
  final int index;
  final String level;

  const UVIndexCard({super.key, required this.index, required this.level});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("UV INDEX"),
          Text('$index', style: _bigText()),
          Text(level, style: _normalText()),
          const SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.pink],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Align(
              alignment: Alignment((index / 10) * 2 - 1, 0),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SunriseCard extends StatelessWidget {
  final String sunrise;
  final String sunset;

  const SunriseCard({super.key, required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("SUNRISE"),
          Text(sunrise, style: _bigText()),
          const SizedBox(height: 8),
          SizedBox(height: 8),
          Text("Sunset: $sunset", style: _normalText()),
        ],
      ),
    );
  }
}

class WindCard extends StatelessWidget {
  final double speed;

  const WindCard({super.key, required this.speed});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("WIND"),
          const SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text('${speed.toStringAsFixed(1)} km/h', style: _bigText()),
                const Text("N", style: TextStyle(color: Colors.white70)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RainfallCard extends StatelessWidget {
  final double lastHour;
  final double next24h;

  const RainfallCard({
    super.key,
    required this.lastHour,
    required this.next24h,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("RAINFALL"),
          Text("$lastHour mm", style: _bigText()),
          const Text("in last hour", style: TextStyle(color: Colors.white)),
          Text("$next24h mm expected in next 24h.", style: _normalText()),
        ],
      ),
    );
  }
}

class FeelsLikeCard extends StatelessWidget {
  final int feelsLike;

  const FeelsLikeCard({super.key, required this.feelsLike});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("FEELS LIKE"),
          Text("$feelsLike°", style: _bigText()),
          Text("Similar to the actual temperature.", style: _normalText()),
        ],
      ),
    );
  }
}

class HumidityCard extends StatelessWidget {
  final int humidity;
  final int dewPoint;

  const HumidityCard({super.key, required this.humidity, required this.dewPoint});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("HUMIDITY"),
          Text("$humidity%", style: _bigText()),
          Text("The dew point is $dewPoint right now.", style: _normalText()),
        ],
      ),
    );
  }
}

class VisibilityCard extends StatelessWidget {
  final int distance;

  const VisibilityCard({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("VISIBILITY"),
          Text("$distance km", style: _bigText()),
          Text("Similar to the actual temperature.", style: _normalText()),
        ],
      ),
    );
  }
}

class PressureCard extends StatelessWidget {
  final int pressure;

  const PressureCard({super.key, required this.pressure});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("PRESSURE"),
          const SizedBox(height: 8),
          Center(
            child: Text("$pressure hPa", style: _bigText()),
          ),
        ],
      ),
    );
  }
}

Widget _label(String text) => Text(
  text.toUpperCase(),
  style: const TextStyle(
    fontSize: 12,
    letterSpacing: 1.1,
    color: Colors.white54,
  ),
);

TextStyle _bigText() => const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

TextStyle _normalText() => const TextStyle(
  fontSize: 13,
  color: Colors.white70,
);

class _BaseCard extends StatelessWidget {
  final Widget child;
  const _BaseCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

