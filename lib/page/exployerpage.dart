

// class DistanceCalculator {
//   static const apiKey = 'YOUR_API_KEY';

//   static Future<double> calculateDistance(
//       LatLng origin, LatLng destination) async {
//     final url = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
//         'units=metric&'
//         'origins=${origin.latitude},${origin.longitude}&'
//         'destinations=${destination.latitude},${destination.longitude}&'
//         'key=AIzaSyCjD_IcVeQArHgLrzeHN5v-czdmziXU_ps';

//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);

//     if (data['status'] == 'OK') {
//       final distance = data['rows'][0]['elements'][0]['distance']['value'];
//       return distance.toDouble() / 1000.0; // Convert distance to kilometers
//     } else {
//       throw Exception('Failed to calculate distance');
//     }
//   }
// }

// class DistanceScreen extends StatefulWidget {
//   @override
//   _DistanceScreenState createState() => _DistanceScreenState();
// }

// class _DistanceScreenState extends State<DistanceScreen> {
//   LatLng origin = LatLng(37.7749, -122.4194); // San Francisco
//   LatLng destination = LatLng(34.0522, -118.2437); // Los Angeles

//   @override
//   void initState() {
//     super.initState();
//     calculateDistance();
//   }

//   Future<void> calculateDistance() async {
//     try {
//       final distance =
//           await DistanceCalculator.calculateDistance(origin, destination);
//       print('Distance: $distance km');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Distance Calculator'),
//       ),
//       body: Center(
//         child: Text('Calculating distance...'),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}








class DistanceCalculator {
  static const apiKey = 'YOUR_API_KEY';

  static Future<double> calculateDistance(LatLng origin, LatLng destination) async {
    final url = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
        'units=metric&'
        'origins=${origin.latitude},${origin.longitude}&'
        'destinations=${destination.latitude},${destination.longitude}&'
        'key=AIzaSyCjD_IcVeQArHgLrzeHN5v-czdmziXU_ps';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      final distance = data['rows'][0]['elements'][0]['distance']['value'];
      return distance.toDouble() / 1000.0; // Convert distance to kilometers
    } else {
      throw Exception('Failed to calculate distance');
    }
  }
}



class DistanceScreen extends StatefulWidget {
  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  LatLng origin = LatLng(37.7749, -122.4194); // San Francisco
  LatLng destination = LatLng(34.0522, -118.2437); // Los Angeles

  @override
  void initState() {
    super.initState();
    calculateDistance();
  }

  Future<void> calculateDistance() async {
    try {
      final distance = await DistanceCalculator.calculateDistance(origin, destination);
      print('Distance: $distance km');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Calculator'),
      ),
      body: Center(
        child: Text('Calculating distance...'),
      ),
    );
  }
}
