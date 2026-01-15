import 'package:flutter/material.dart';

import '../utils/get_storage_helper.dart';
import 'home_screen.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), goHome);
  }

  void goHome() {
    StorageHelper.saveSkip();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://www.vhv.rs/dpng/d/427-4270068_gold-retro-decorative-frame-png-free-download-transparent.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Text(
              "We show weather for you",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 100,
            left: 100,
            child: ElevatedButton(onPressed: goHome, child: Text("Skip")),
          ),
        ],
      ),
    );
  }
}
