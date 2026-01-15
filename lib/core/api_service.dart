import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_interview_task/core/constants.dart';
import '../model/weather_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<WeatherModel> getWeather(String searchQuery) async {
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestHeaders: false,
        logRequestTimeout: false,
        logResponseHeaders: false,
      ),
    );
    try {
      final response = await _dio.get(
        AppConstants.baseUrl,
        queryParameters: {
          "key": AppConstants.apiKey,
          "q": searchQuery,

        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception("Weather fetch failed: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['error']['message'] ?? "Network error");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
