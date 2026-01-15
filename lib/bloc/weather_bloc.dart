import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../core/api_service.dart';
import '../core/location_permission_handler.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiService apiService;

  WeatherBloc(this.apiService)
      : super(const WeatherInitial()) {


    on<LocationTextChanged>((event, emit) {
      final isEmpty = event.text.trim().isEmpty;
      if (isEmpty) {
        add(FetchWeatherByGPS());
      } else {
        emit(const WeatherInitial(isLocationEmpty: false));
      }
    });


    on<FetchWeatherByGPS>((event, emit) async {
      emit(const WeatherLoading(true));

      final hasPermission =
      await LocationPermissionHelper.checkPermission();

      if (!hasPermission) {
        emit(const WeatherError(
            "Location permission denied", true));
        return;
      }

      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final query =
            "${position.latitude},${position.longitude}";

        final weather =
        await apiService.getWeather(query);

        emit(WeatherLoaded(weather, true));
      } catch (_) {
        emit(const WeatherError(
            "Unable to fetch GPS weather", true));
      }
    });


    on<FetchWeatherByLocation>((event, emit) async {
      emit(const WeatherLoading(false));
      try {
        final weather =
        await apiService.getWeather(event.location);

        emit(WeatherLoaded(weather, false));
      } catch (e) {
        emit(WeatherError(
            e.toString().replaceAll("Exception: ", ""),
            false));
      }
    });
  }
}
