import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class mapview extends StatefulWidget {
  const mapview({super.key});

  @override
  State<mapview> createState() => _mapviewState();
}

class _mapviewState extends State<mapview> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-33.86, 151.20);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("MapScreen"),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );

  }
}

