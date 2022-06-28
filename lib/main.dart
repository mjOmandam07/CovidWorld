import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_tracker/Pages/splash.dart';
import 'package:covid_tracker/Pages/home.dart';
import 'package:covid_tracker/Pages/world_stat.dart';
import 'package:covid_tracker/Pages/choose_country.dart';
import 'package:covid_tracker/Pages/globalCases.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
        (_) => runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const splash(),
            '/home': (context) => const home(),
            '/world': (context) => const world(),
            '/countries': (context) => const countries(),
            '/global': (context) => const global_cases()
          },
        ))
  );
}

