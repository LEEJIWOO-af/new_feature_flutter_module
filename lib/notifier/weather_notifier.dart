import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_feature_flutter_module/models/weather.dart';
import 'package:new_feature_flutter_module/repository/weather_repository.dart';

class WeatherNotifier extends AsyncNotifier<Weather> {
  late WeatherRepository _repository;

  @override
  Future<Weather> build() async {
    _repository = ref.read(weatherRepositoryProvider);
    return getCurrentLocationWeather();
  }

  Future<Weather> getCurrentLocationWeather() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Reject location permission');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Reject location permission');
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final weather = await _repository.getCurrentWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      return weather;
    } catch (e) {
      throw Exception('Weather error: $e');
    }
  }

  Future<void> refreshWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => getCurrentLocationWeather());
  }

  Future<void> getWeatherByCity(String cityName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getCurrentWeatherByCity(cityName),
    );
  }
}

// Weather Notifier Provider
final weatherNotifierProvider =
    AsyncNotifierProvider<WeatherNotifier, Weather>(() {
      return WeatherNotifier();
    });
