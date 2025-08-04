class City {
  final String name;
  final double lat;
  final double lon;

  const City({
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// List of famous cities as a constant
List<City> Cities = const [
  City(name: 'Tokyo', lat: 35.6833, lon: 139.7667),
  City(name: 'New Delhi', lat: 28.5833, lon: 77.2),
  City(name: 'Paris', lat: 48.85, lon: 2.3333),
  City(name: 'London', lat: 51.4833, lon: -0.0833),
  City(name: 'New York', lat: 40.7167, lon: -74.0167),
  City(name: 'Tehran', lat: 35.6833, lon: 51.4167),
];