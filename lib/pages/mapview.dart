import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

final Completer<GoogleMapController> _controller = Completer();

late String _mapStyleString;


//void initState(){
 //   rootBundle.loadString('assets/map_styles/map_style1.json').then((string){
 //     _mapStyleString = string;
  //  });
  //  initState();
 // }


class mapview extends StatefulWidget {
  mapview({super.key});

  

  @override
  State<mapview> createState() => _mapviewState();
  
}

class _mapviewState extends State<mapview> {
  GoogleMapController? mapController;

LatLng? _center;
Position? _currentPosition;
bool _isLoading = true;

/*@override
  void initState() {
    super.initState();
    getLocation();
  }*/

  @override
  void initState() {
    rootBundle.loadString('assets/map_styles/map_style1.json').then((string){
      _mapStyleString = string;
    });
    super.initState();
    getLocation();
  }

   void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(_mapStyleString);
    //initState();
   // _controller.complete(controller);
   // _controller.future.then((value){
   //   value.setMapStyle(_mapStyleString);
   // });
    
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    return;
    }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
  return;
  }
  if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission != LocationPermission.whileInUse &&
  permission != LocationPermission.always) {
  return;
  }
  }


    _currentPosition = await Geolocator.getCurrentPosition();
        setState(() {
          _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
        });
  }

    //double lat = _currentPosition.latitude;
    //double long = _currentPosition.longitude;

    //LatLng location = LatLng(lat, long);

    //setState(() {
   //   _currentPosition = location;
   //   _isLoading = false;
   // });
 // }

  //void dispose(){
   // mapController.dispose();
   // super.dispose();
  //}
   //const _initialCameraPosition = CameraPosition(
    //target: LatLng(65.834359, 24.180486),
    //zoom: 13,
   // );
    
    
  //final LatLng _center = const LatLng(-33.86, 151.20);
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("MapScreen"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings), onPressed: () {
              //goes to settings
              Navigator.pushNamed(context, "/settingsPage");
            },)
        ] ,
      ),
      body: Stack(
        children: [
          GoogleMap(
            //initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center!,
              zoom: 16.0,
              ),
            //_controller.complete(controller);
            //_controller.future.then((value){
            //value.setMapStyle(null);
            //value.setMapStyle(_mapStyleString);
           // }
          ),
                  
                  //style: _mapStyleString
      Positioned(
        bottom: 16,
        left: 16,
        child: FloatingActionButton(
        backgroundColor: const Color.fromARGB(201, 238, 236, 236),
        onPressed: () => mapController?.animateCamera(
          CameraUpdate.newCameraPosition(_center as CameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
        ),)
        ],
      )
      
      
    );

  }
}
