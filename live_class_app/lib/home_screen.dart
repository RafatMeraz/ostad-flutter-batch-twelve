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
          zoom: 16,
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
        markers: <Marker>{
          Marker(
            markerId: MarkerId('my-home'),
            position: LatLng(23.80106391545618, 90.37150841206312),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRose,
            ),
            visible: true,
            infoWindow: InfoWindow(
              title: 'My home',
              snippet: 'Where I live',
              onTap: () {
                print('My home Info window tapped');
              },
            ),
          ),
          Marker(
            markerId: MarkerId('my-office'),
            position: LatLng(23.802390039175737, 90.37151981145144),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            visible: true,
            infoWindow: InfoWindow(
              title: 'My office',
              snippet: 'Where I work',
              onTap: () {
                print('My office Info window tapped');
              },
            ),
          ),
          Marker(
            markerId: MarkerId('location-picker'),
            position: LatLng(23.804553588783108, 90.36813654005527),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            visible: true,
            draggable: true,
            onDragEnd: (LatLng latLng) {
              print('Marker drag end $latLng');
            },
            onDragStart: (LatLng latLng) {
              print('Marker dragged from $latLng');
            },
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('my-route'),
            points: [
              LatLng(23.80106391545618, 90.37150841206312),
              LatLng(23.802390039175737, 90.37151981145144),
              LatLng(23.80192131135802, 90.36903943866491),
            ],
            color: Colors.blue,
            width: 8,
            visible: true,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            onTap: () {},
          ),
        },
        circles: <Circle>{
          Circle(
            circleId: CircleId('office-circle'),
            center: LatLng(23.802390039175737, 90.37151981145144),
            radius: 50,
            fillColor: Colors.red.withAlpha(100),
            strokeColor: Colors.red,
            strokeWidth: 4,
          ),
          Circle(
            circleId: CircleId('home-circle'),
            center: LatLng(23.80106391545618, 90.37150841206312),
            radius: 30,
            fillColor: Colors.green.withAlpha(100),
            strokeColor: Colors.green,
            strokeWidth: 4,
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('random-polygon'),
            points: [
              LatLng(23.799196337281256, 90.36971099674702),
              LatLng(23.80009301129655, 90.36886375397444),
              LatLng(23.79940953949814, 90.36820828914642),
              LatLng(23.800003742966894, 90.36701068282127),
              LatLng(23.79831530225156, 90.36756824702024),
              LatLng(23.797694402109563, 90.36820828914642),
              LatLng(23.797444384663017, 90.36920707672834),
            ],
            fillColor: Colors.purple.withAlpha(100),
            strokeColor: Colors.purple,
            strokeWidth: 4,
            onTap: () {
              print('This area is corona affected');
            },
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _mapController.moveCamera(
          //   CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //       zoom: 16,
          //       target: LatLng(23.80106391545618, 90.37150841206312),
          //     ),
          //   ),
          // );
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 16,
                target: LatLng(23.80106391545618, 90.37150841206312),
              ),
            ),
          );
        },
        child: Icon(Icons.home),
      ),
    );
  }
}
