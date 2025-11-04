import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  late Future<Position> position;

  @override
  void initState() {
    super.initState();
    position = getPosition();

    // keep the existing behaviour of updating a readable string when
    // the position becomes available
    position
        .then((value) {
          print('Latitude: ${value.latitude} - Longitude: ${value.longitude}');
          setState(() {
            myPosition =
                'Latitude: ${value.latitude} - Longitude: ${value.longitude}';
          });
        })
        .catchError((e) {
          // handle errors (e.g., permission denied or location disabled)
          debugPrint('Error getting position: $e');
        });
  }

  Future<Position> getPosition() async {
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(
      const Duration(seconds: 3),
    ); // delay agar loading terlihat
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  // @override
  // Widget build(BuildContext context) {
  //   final myWidget = myPosition == ''
  //       ? const CircularProgressIndicator()
  //       : Text(myPosition);

  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Current Location - Alif')), // ✅ Soal 11
  //     body: Center(child: myWidget),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location - Alif')),
      body: Center(
        child: FutureBuilder<Position>(
          future: position,
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            // Handle the common states and ensure a Widget is always returned
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.hasData) {
              // Prefer formatted string if available
              return Text(
                myPosition != '' ? myPosition : snapshot.data.toString(),
              );
            }

            // Fallback UI for ConnectionState.none or unexpected cases
            return const Text('No location data available');
          },
        ),
      ),
    );
  }
}
