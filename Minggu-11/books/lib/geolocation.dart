import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  @override
  void initState() {
    super.initState();
    getPosition().then((value) {
      print('Latitude: ${value.latitude} - Longitude: ${value.longitude}');
      setState(() {
        myPosition =
            'Latitude: ${value.latitude} - Longitude: ${value.longitude}';
      });
    });
  }

  Future<Position> getPosition() async {
    await Future.delayed(const Duration(seconds: 3)); // ✅ Soal 12
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final myWidget = myPosition == ''
        ? const CircularProgressIndicator()
        : Text(myPosition);

    return Scaffold(
      appBar: AppBar(title: const Text('Current Location - Alif')), // ✅ Soal 11
      body: Center(child: myWidget),
    );
  }
}
