import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/extension/string.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/models/weathers.dart';
import 'package:weather_app/sevices/api.dart';
import 'package:weather_app/view/home/widget/bottomDrawer.dart';
import 'package:weather_app/view/home/widget/locWaether.dart';
import 'package:weather_app/view/home/widget/navBar.dart';

class homePage extends StatefulWidget {
  final double lat;
  final double lon;
  const homePage({super.key, required this.lat, required this.lon});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Weather? weather;
  final GlobalKey _weatherKey = GlobalKey();
  final DraggableScrollableController _drawerController = DraggableScrollableController();

  double _maxChildSize = 0.6;
  double _drawerExtent = 0.38;

  @override
  void initState() {
    super.initState();
    fetchWeather(widget.lat, widget.lon);

    _drawerController.addListener(() {
      setState(() {
        _drawerExtent = _drawerController.size;
      });
    });
  }

  Future<void> fetchWeather(double lat, double lon) async {
    Weather fetchedWeather = await ApiWeather.getCurrentWeather(lat, lon);
    setState(() {
      weather = fetchedWeather;
    });
  }

  double _calculateMaxChildSize(BuildContext context) {
    final RenderBox? renderBox = _weatherKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final screenHeight = MediaQuery.of(context).size.height;
      final weatherHeight = renderBox.size.height + 100; // 100 untuk spacing bawah
      final availableHeight = screenHeight - weatherHeight;
      return (availableHeight / screenHeight).clamp(0.4, 1.0);
    }
    return 0.6;
  }

  void _handleExtentChanged(double extent) {
    setState(() {
      _drawerExtent = extent;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newMax = _calculateMaxChildSize(context);
      if (_maxChildSize != newMax) {
        setState(() {
          _maxChildSize = newMax.clamp(0.4, 1.0);
        });
      }
    });

    if (weather == null) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

    final double progress = (_drawerExtent / _maxChildSize).clamp(0.0, 1.0);
    final double cityFont = lerpDouble(34, 22, progress)!;
    final double tempFont = lerpDouble(96, 52, progress)!;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/assets/bgHome.png', fit: BoxFit.cover),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 0,
            right: 0,
            child: Column(
              key: _weatherKey,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                locWeather(
                  city: weather!.name,
                  temp: '${weather!.main.temp.toInt()}°',
                  weather: weather!.weather.first.description.capitalizeWords(),
                  max: '${weather!.main.tempMax.toInt()}°',
                  min: '${weather!.main.tempMin.toInt()}°',
                  cityFont: cityFont,
                  tempFont: tempFont,
                ),
                const SizedBox(height: 15),
                Image.asset('lib/assets/home.png'),
              ],
            ),
          ),
          BottomDrawer(
            lat: weather!.coord.lat,
            lon: weather!.coord.lon,
            maxChildSize: _maxChildSize,
            onExtentChanged: _handleExtentChanged,
            controller: _drawerController,
            weather: weather!,
          ),
          if (_drawerExtent < 0.39)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomBar(
                onLocationPressed: (){
                  // fetchWeather(0.0, 0.0);
                }
              ),
            ),
        ],
      ),
    );
  }
}
