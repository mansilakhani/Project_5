import 'package:flutter/material.dart';
import 'package:sky_scrapper_cvd_app/homepage.dart';
import 'package:sky_scrapper_cvd_app/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    routes: {
      '/': (context) => MyHomePage(),
      'splashscreen': (context) => SplashScreen(),
    },
  ));
}
