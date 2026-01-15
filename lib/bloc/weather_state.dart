import '../model/weather_model.dart';

abstract class WeatherState {
  final bool isLocationEmpty;
  const WeatherState(this.isLocationEmpty);
}

class WeatherInitial extends WeatherState {
  const WeatherInitial({bool isLocationEmpty = true})
      : super(isLocationEmpty);
}

class WeatherLoading extends WeatherState {
  const WeatherLoading(bool isLocationEmpty)
      : super(isLocationEmpty);
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  const WeatherLoaded(this.weather, bool isLocationEmpty)
      : super(isLocationEmpty);
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message, bool isLocationEmpty)
      : super(isLocationEmpty);
}
