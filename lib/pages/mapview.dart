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

  @override
  State<mapview> createState() => _mapviewState();
  
}

class _mapviewState extends State<mapview> {
  GoogleMapController? mapController;

LatLng? _center;
Position? _currentPosition;
bool _isLoading = true;
static double get _circleRadius => 100.0;
Offset? _circleOffset; //This will hold the screen position for the circle

/*@override
  void initState() {
    super.initState();
    getLocation();
  }*/

  @override
  void initState() {
    rootBundle.loadString('assets/map_styles/map_style_RDR2.json').then((string){
      _mapStyleString = string;
    });
    super.initState();
    getLocation();
  }

   void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(_mapStyleString);
    _updateCirclePosition();
    //initState();
   // _controller.complete(controller);
   // _controller.future.then((value){
   //   value.setMapStyle(_mapStyleString);
   // });
    
  }

  // Move the camera to the user's location
  void _moveCameraToUserLocation() {
    if (mapController != null && _currentPosition != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }

  // Get user's current location
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _moveCameraToUserLocation();
    });
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


// Convert LatLng to screen coordinates using GoogleMapController
  Future<void> _updateCirclePosition() async {
    if (_controller != null && _currentPosition != null) {
      LatLng userLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

      // Convert LatLng to Screen Coordinate (x, y) using the map controller
      ScreenCoordinate screenCoordinate = await mapController!.getScreenCoordinate(userLatLng);

      setState(() {
        // Update the circle's offset to match the user's screen position
        _circleOffset = Offset(screenCoordinate.x.toDouble(), screenCoordinate.y.toDouble());
      });
    }
  }

 

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
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onCameraMove: (CameraPosition position) {
                // Update the circle position when the camera moves
                _updateCirclePosition();
              },
              /*markers: {
                Marker(markerId: const MarkerId('user_location'),
                position: _center!,
                infoWindow: const InfoWindow(title: 'Your Location'),
                )
              },*/
            //_controller.complete(controller);
            //_controller.future.then((value){
            //value.setMapStyle(null);
            //value.setMapStyle(_mapStyleString);
           // }
          ),
          
          if (_circleOffset != null) ...[
            
            IgnorePointer(
            ignoring: true,
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: CircleRevealPainter(
                //center: Offset(
                  //MediaQuery.of(context).size.width / 2, // Center it on the screen horizontally
                  //MediaQuery.of(context).size.height / 2, // Center it vertically for now (can be adjusted)
                  center: _circleOffset!,
                  radius: _circleRadius,
                ),
                //radius: _circleRadius,
              ),
                
            ),
            
            
          ],  
                  //style: _mapStyleString
      // Positioned(
      //   bottom: 16,
      //   left: 16,
      //   child: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(201, 238, 236, 236),
      //   onPressed: () => mapController!.animateCamera(
      //     CameraUpdate.newCameraPosition(CameraPosition(target: _center!, zoom: 16.0)),
      //   ),
      //   child: const Icon(Icons.center_focus_strong),
      //   ),
      //   ),
        ],
      ),
      
      );

  }
}

// Custom Painter to create the circular reveal effect
class CircleRevealPainter extends CustomPainter {
  final Offset center;
  final double radius;

  CircleRevealPainter({required this.center, required this.radius});



@override
  void paint(Canvas canvas, Size size) {
    // Paint greyPaint = Paint()..color = Colors.grey.withOpacity(0.9);
    // Paint clearPaint = Paint()
    //   ..blendMode = BlendMode.clear; // This will "cut out" the circle from the overlay
    Paint greyPaint = Paint()..color = Colors.grey.withOpacity(0.7);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), greyPaint);


    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, size.width, size.height),
    //   greyPaint,
    // );

    // Transparent circle
    Paint clearPaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawCircle(center, radius, clearPaint);
     

    // Draw the transparent circle that reveals the map underneath
    //canvas.drawCircle(center, radius, clearPaint);
  }

  @override
  bool shouldRepaint(CircleRevealPainter oldDelegate) {
    return oldDelegate.center != center || oldDelegate.radius != radius;
  }
}