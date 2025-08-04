import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/models/weathers.dart';
import 'package:weather_app/view/home/widget/weatheInfo.dart';
import 'package:weather_app/view/home/widget/hourlyForecast.dart';
import 'package:weather_app/view/home/widget/weeklyForecast.dart';

class BottomDrawer extends StatefulWidget {
  final double lat;
  final double lon;
  final double maxChildSize;
  final Function(double) onExtentChanged;
  final DraggableScrollableController controller;
  final Weather weather;

  const BottomDrawer({
    super.key,
    required this.lat,
    required this.lon,
    required this.maxChildSize,
    required this.onExtentChanged,
    required this.controller,
    required this.weather,
  });

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  bool isHourly = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        widget.onExtentChanged(notification.extent);
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.38,
        minChildSize: 0.38,
        maxChildSize: widget.maxChildSize,
        builder: (context, scrollController) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: Container(
              color: colors.purpleColor.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.whiteColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTab("Hourly Forecast", isHourly, () {
                          setState(() => isHourly = true);
                        }),
                        _buildTab("Weekly Forecast", !isHourly, () {
                          setState(() => isHourly = false);
                        }),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            isHourly ? hourlyforecast(lat: widget.lat , lon: widget.lon,) :  weeklyForecast(lat: widget.lat , lon: widget.lon,),
                            const SizedBox(height: 10),
                            const AirQualityWidget(airQualityIndex: 3, description: 'Low Health Risk'),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildHalfWidth(context, UVIndexCard(index: 4, level: 'Moderate')),

                                _buildHalfWidth(
                                  context,
                                  SunriseCard(
                                    sunrise: widget.weather.sys.sunrise?.toString() ?? '0',
                                    sunset: widget.weather.sys.sunset?.toString() ?? '0',
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  WindCard(
                                    speed: widget.weather.wind.speed ?? 0.0,
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  RainfallCard(
                                    lastHour: 1.8,
                                    next24h: 1.2,
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  FeelsLikeCard(
                                    feelsLike: widget.weather.main.feelsLike?.toInt() ?? 0,
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  HumidityCard(
                                    humidity: widget.weather.main.humidity ?? 0,
                                    dewPoint: 17,
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  VisibilityCard(
                                    distance: widget.weather.main.visibility ?? 0,
                                  ),
                                ),

                                _buildHalfWidth(
                                  context,
                                  PressureCard(
                                    pressure: widget.weather.main.pressure ?? 0,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isActive ? colors.whiteColor : colors.greyColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              )),
          const SizedBox(height: 4),
          if (isActive)
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: colors.whiteColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHalfWidth(BuildContext context, Widget child) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: (width - 25 * 2 - 12) / 2,
      child: child,
    );
  }
}
