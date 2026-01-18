import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../utils/get_storage_helper.dart';
import 'help_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = StorageHelper.getLocation() ?? "";
    context.read<WeatherBloc>().add(LocationTextChanged(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HelpScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (v) =>
                  context.read<WeatherBloc>().add(LocationTextChanged(v)),
              decoration: const InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    StorageHelper.saveLocation(controller.text);
                    context.read<WeatherBloc>().add(
                      FetchWeatherByLocation(controller.text),
                    );
                  },
                  child: Text(state.isLocationEmpty ? "Save" : "Update"),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        "${state.weather.temp} °C",
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(state.weather.text),
                      Image.network(state.weather.icon),
                    ],
                  );
                }
                if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
