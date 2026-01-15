import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_task/core/api_service.dart';
import 'package:flutter_interview_task/screens/help_screen.dart';
import 'package:flutter_interview_task/screens/home_screen.dart';
import 'package:flutter_interview_task/utils/get_storage_helper.dart';
import 'package:get_storage/get_storage.dart';

import 'bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    BlocProvider(
      create: (_) => WeatherBloc(ApiService()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StorageHelper.isSkipped()
          ? HomeScreen()
          : HelpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
