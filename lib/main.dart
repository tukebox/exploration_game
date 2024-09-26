import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/mapview.dart';
import 'package:flutter_application_1/pages/settingsPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() => runApp(MaterialApp(
  home: Home(),
  routes: {
    '/home': (context) => Home(),
    '/mapview': (context) => mapview(),
    '/settingsPage': (context) => settingsPage()
  },
));