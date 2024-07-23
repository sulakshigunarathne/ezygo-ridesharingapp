import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:ezygo/constants.dart';
import 'package:location/location.dart' as loc; // Alias for location package
import 'package:permission_handler/permission_handler.dart' as permission_handler; // Alias for permission_handler package

class RiderPage extends StatefulWidget {
  const RiderPage({super.key});

  @override
  State<RiderPage> createState() => _RiderPageState();
}

class _RiderPageState extends State<RiderPage> {
  loc.Location _locationController = loc.Location(); // Use loc.Location from the location package
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _defaultLocation = LatLng(6.9271, 79.8612);
  LatLng? _currentLocation;
  LatLng? _startLocation;
  LatLng? _destinationLocation;
  Map<PolylineId, Polyline> polylines = {};

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rider Page')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _startController,
              decoration: InputDecoration(labelText: 'Enter start location'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Enter destination'),
            ),
          ),
          ElevatedButton(
            onPressed: _fetchRoute,
            child: Text('Find Route'),
          ),
          Expanded(
            child: _currentLocation == null
                ? Center(child: Text("Loading..."))
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) => _mapController.complete(controller),
                    initialCameraPosition: const CameraPosition(
                      target: _defaultLocation,
                      zoom: 13,
                    ),
                    markers: _buildMarkers(),
                    polylines: Set<Polyline>.of(polylines.values),
                    myLocationEnabled: true,
                  ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    return {
      if (_currentLocation != null)
        Marker(
          markerId: MarkerId('currentLocation'),
          icon: BitmapDescriptor.defaultMarker,
          position: _currentLocation!,
        ),
      if (_startLocation != null)
        Marker(
          markerId: MarkerId('startLocation'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: _startLocation!,
        ),
      if (_destinationLocation != null)
        Marker(
          markerId: MarkerId('destinationLocation'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: _destinationLocation!,
        ),
    };
  }

  Future<void> _fetchRoute() async {
    if (_startController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter both locations')));
      return;
    }

    // For simplicity, assume that the locations are entered in LatLng format
    _startLocation = LatLng(6.9271, 79.8612); // Placeholder: Replace with actual geocoding result
    _destinationLocation = LatLng(6.6668, 80.7017); // Placeholder: Replace with actual geocoding result

    List<LatLng> polylineCoordinates = await getPolylinePoints();
    generatePolyLineFromPoints(polylineCoordinates);
    if (_destinationLocation != null) {
      await _cameraToPosition(_destinationLocation!);
    }

    _showAvailableVehiclesDialog();
  }

  Future<void> _showAvailableVehiclesDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Available Vehicles'),
          content: Text('Do you want to see the available vehicles?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Handle the action for viewing available vehicles
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> requestLocationPermission() async {
    // Check the status of location permission using permission_handler
    permission_handler.PermissionStatus permissionStatus = await permission_handler.Permission.location.status;
    if (permissionStatus.isDenied) {
      permissionStatus = await permission_handler.Permission.location.request();
    }
    if (permissionStatus.isGranted) {
      getLocationUpdates();
    } else {
      print("Location permission denied");
    }
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Location permission status should be handled using the location package
    loc.PermissionStatus locationPermissionStatus = await _locationController.hasPermission();
    if (locationPermissionStatus == loc.PermissionStatus.denied) {
      locationPermissionStatus = await _locationController.requestPermission();
      if (locationPermissionStatus != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((loc.LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentLocation!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAPS_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(_startLocation!.latitude, _startLocation!.longitude),
        destination: PointLatLng(_destinationLocation!.latitude, _destinationLocation!.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
