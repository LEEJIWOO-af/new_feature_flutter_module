import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_feature_flutter_module/models/weather.dart';

class WeatherRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '080c937460104f13577fe72c4a6d0376';

  WeatherRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': _apiKey,
        },
      );

      print("response: ${response}");

      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw Exception('날씨 데이터를 가져올 수 없습니다');
      }
    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('알 수 없는 오류: $e');
    }
  }

  Future<Weather> getCurrentWeatherByCity(String cityName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw Exception('날씨 데이터를 가져올 수 없습니다');
      }
    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('알 수 없는 오류: $e');
    }
  }
}

// Repository Provider
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});