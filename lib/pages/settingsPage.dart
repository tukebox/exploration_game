import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mapview.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';



class settingsPage extends StatefulWidget {
  @override
  State<settingsPage> createState() => _settingsPageState();
  
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  
}


Widget mapTheme() => const DropDownSettingsTile(
    title: 'Map Theme',
    settingKey: 'key-themeSetting', //viimeksi käytetty teema
    selected: 1, 
    values: <int, String>{
      1: 'RDR2',
      2: 'Dark',
      3: 'Normal',
      4: 'Terrain',
    },
    // onChange: (){
      
    // },
    );

    Widget circleRadius() => const SliderSettingsTile(
      title: 'Circle radius(m):', 
      settingKey: 'key-radiusSetting', //viimeksi käytetty radius
      min: 0, max: 1000,
      defaultValue: 20,
      step: 1,
      leading: Icon(Icons.circle),
      //onChange: jotaki,
      );

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: const Text("Settings"),
      centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            mapTheme(),
            circleRadius(),
            // Text("Map theme: ",
            // style: TextStyle(fontSize: 24),
            // ),
            // Text("Circle radius: ",
            // style: TextStyle(fontSize: 24),
            // ),
          ],
        )
      )
      // body: const Center(
      //   child: Text("this is settings page",
      //   style: TextStyle(fontSize: 24
      //   ),
      //   ),
      // ),
    );
  
  
  }
}