import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.79957137036744, 90.37208624834955),
          zoom: 16
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        trafficEnabled: true,
        onTap: (LatLng latLng) {
          print(latLng);
        },
        onLongPress: (LatLng latLng) {
          print('Long pressed on $latLng');
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
