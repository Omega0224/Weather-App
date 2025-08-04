import 'package:flutter/material.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weathers.dart';
import 'package:weather_app/sevices/api.dart';
import 'package:weather_app/view/home/home.dart';
import 'package:weather_app/view/home/widget/weatherCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> _weatherList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialCities();
  }

  Future<void> _loadInitialCities() async {
    setState(() => _isLoading = true);

    List<Map<String, dynamic>> loadedWeather = [];

    for (var city in Cities) {
      try {
        Weather weather = await ApiWeather.getWeatherBySearch(city.name);
        loadedWeather.add({
          'temperature': weather.main.temp.toInt(),
          'location': weather.name,
          'min': weather.main.tempMin.toInt(),
          'max': weather.main.tempMax.toInt(),
          'condition': weather.weather[0].description,
          'asset': weather.weather[0].icon,
          'lat': weather.coord.lat,
          'lon': weather.coord.lon,
        });
      } catch (e) {
        debugPrint("Error loading weather for ${city.name}: $e");
      }
    }

    setState(() {
      _weatherList = loadedWeather;
      _isLoading = false;
    });
  }

  Future<void> _searchWeather() async {
    String cityName = searchController.text.trim();
    if (cityName.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Weather weather = await ApiWeather.getWeatherBySearch(cityName);
      setState(() {
        _weatherList = [
          {
            'temperature': weather.main.temp.toInt(),
            'location': weather.name,
            'min': weather.main.tempMin.toInt(),
            'max': weather.main.tempMax.toInt(),
            'condition': weather.weather[0].description,
            'asset': weather.weather[0].icon,
            'lat': weather.coord.lat,
            'lon': weather.coord.lon,
          }
        ];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B4EFF),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'Weather',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                onSubmitted: (_) => _searchWeather(),
                decoration: InputDecoration(
                  hintText: 'Search for a city',
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            // Content: Loader / Cards / Empty
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : _weatherList.isEmpty
                      ? const Center(
                          child: Text("No data found", style: TextStyle(color: Colors.white70)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _weatherList.length,
                          itemBuilder: (context, index) {
                            final weather = _weatherList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: WeatherCard(
                                temperature: weather['temperature'],
                                city: weather['location'],
                                low: weather['min'],
                                high: weather['max'],
                                condition: weather['condition'],
                                iconPath: weather['asset'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => homePage(
                                        lat: weather['lat'],
                                        lon: weather['lon'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         TextField(
  //           controller: searchController,
  //           onChanged: (text) {
  //             searchText = text;
  //           },
  //           decoration: InputDecoration(
  //             contentPadding: EdgeInsets.symmetric(
  //               vertical: 15.0, horizontal: 15.0),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //               borderSide: BorderSide(
  //               color: colors.blackColor, width: 2.0),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //               borderSide: BorderSide(
  //               color: colors.blackColor, width: 2.0)),
  //             labelText: 'Search for a city',
  //             labelStyle: TextStyle(color: Colors.white),
  //             fillColor: Colors.transparent,
  //             filled: true,
  //             prefixIcon: Icon(
  //               Icons.search,
  //                color: Colors.white,
  //             )),
  //             style: TextStyle(color: Colors.white),
  //             textInputAction: TextInputAction.search,
  //         )
  //       ],
  //     ),
  //   );
  // }