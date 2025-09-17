class Weather {
  final String cityName;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;

  const Weather({
    required this.cityName,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weatherData = weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : <String, dynamic>{};

    print('🔍 Debug - weatherData: $weatherData');

    return Weather(
      cityName: json['name'] ?? '',
      description: weatherData['description'] ?? '',
      icon: weatherData['icon'] ?? '',
      temperature: ((json['main']['temp'] as num? ?? 273.15) - 273.15),
      feelsLike: ((json['main']['feels_like'] as num? ?? 273.15) - 273.15),
      humidity: json['main']['humidity'] as int? ?? 0,
      pressure: json['main']['pressure'] as int? ?? 0,
      windSpeed: (json['wind']['speed'] as num? ?? 0).toDouble(),
      windDirection: json['wind']['deg'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'cityName': cityName,
    'description': description,
    'icon': icon,
    'temperature': temperature,
    'feelsLike': feelsLike,
    'humidity': humidity,
    'pressure': pressure,
    'windSpeed': windSpeed,
    'windDirection': windDirection,
  };

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  String get temperatureString => '${temperature.round()}°C';

  String get feelsLikeString => 'feeling ${feelsLike.round()}°C';

  String get windSpeedString => '${windSpeed.toStringAsFixed(1)} m/s';
}
