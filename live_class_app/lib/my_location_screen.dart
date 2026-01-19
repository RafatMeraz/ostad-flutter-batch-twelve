import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  Position? _currentPosition;

  StreamSubscription? _positionSubscriber;

  @override
  void initState() {
    super.initState();
    _listenCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My location')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                'My current location: $_currentPosition',
                textAlign: .center,
              ),
              TextButton(
                onPressed: _onTapGetMyLocation,
                child: Text('Get my location'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapGetMyLocation() async {
    // Check Location Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (_isLocationPermissionGranted(permission)) {
      // Check if location service enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        // Get user current location
        Position position = await Geolocator.getCurrentPosition();
        print(position);
        _currentPosition = position;
        setState(() {});
      } else {
        // If not, then request to enable service
        Geolocator.openLocationSettings();
      }
    } else {
      // If not, then request permission
      LocationPermission requestedPermission =
          await Geolocator.requestPermission();
      if (_isLocationPermissionGranted(requestedPermission)) {
        _onTapGetMyLocation();
        return;
      }
    }
  }

  Future<void> _listenCurrentLocation() async {
    await _checkLocationPermissionAndService(
      onSuccess: () {
        _positionSubscriber = Geolocator.getPositionStream().listen((
          currentLocation,
        ) {
          print(currentLocation);
          _currentPosition = currentLocation;
          setState(() {});
        });
      },
    );
  }

  Future<void> _checkLocationPermissionAndService({
    required VoidCallback onSuccess,
  }) async {
    // Check Location Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (_isLocationPermissionGranted(permission)) {
      // Check if location service enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        // do your operation
        onSuccess();
      } else {
        // If not, then request to enable service
        Geolocator.openLocationSettings();
      }
    } else {
      // If not, then request permission
      LocationPermission requestedPermission =
          await Geolocator.requestPermission();
      if (_isLocationPermissionGranted(requestedPermission)) {
        _onTapGetMyLocation();
        return;
      }
    }
  }

  bool _isLocationPermissionGranted(LocationPermission permission) {
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  void dispose() {
    _positionSubscriber?.cancel();
    super.dispose();
  }
}
