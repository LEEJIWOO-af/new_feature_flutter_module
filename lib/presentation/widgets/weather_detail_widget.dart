import 'package:flutter/material.dart';
import 'package:new_feature_flutter_module/models/weather.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsWidget({
    super.key, required this.weather,
    // required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weather Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _DetailItem(
                    icon: Icons.water_drop,
                    title: 'humidity',
                    value: '${weather.humidity}%',
                  ),
                ),
                Expanded(
                  child: _DetailItem(
                    icon: Icons.compress,
                    title: 'atmospheric pressure',
                    value: '${weather.pressure} hPa',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _DetailItem(
                    icon: Icons.air,
                    title: 'wind speed',
                    value: weather.windSpeedString,
                  ),
                ),
                Expanded(
                  child: _DetailItem(
                    icon: Icons.navigation,
                    title: 'wind direction',
                    value: '${weather.windDirection}°',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
