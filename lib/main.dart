import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/mapview.dart';
import 'package:flutter_application_1/pages/settingsPage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



// Future main() async => runApp(MaterialApp(

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MyApp());
  //WidgetsFlutterBinding.ensureInitialized();
  
  //Settings.init();

//   home: Home(),
//   routes: {
//     '/home': (context) => Home(),
//     '/mapview': (context) => mapview(),
//     '/settingsPage': (context) => settingsPage()
//   },
// ));

}
// runApp(MaterialApp){
  
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Exploration game',
        home: Home(),
    routes: {
    '/home': (context) => Home(),
    '/mapview': (context) => mapview(),
    '/settingsPage': (context) => settingsPage()
  }
  
    );

  
}
}