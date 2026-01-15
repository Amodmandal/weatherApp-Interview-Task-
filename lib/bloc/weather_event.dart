abstract class WeatherEvent {}

class LocationTextChanged extends WeatherEvent {
  final String text;
  LocationTextChanged(this.text);
}

class FetchWeatherByGPS extends WeatherEvent {}

class FetchWeatherByLocation extends WeatherEvent {
  final String location;
  FetchWeatherByLocation(this.location);
}
