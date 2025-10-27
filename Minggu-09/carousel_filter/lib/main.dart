import 'package:flutter/material.dart';
import 'pages/camera_page.dart';

void main() {
  runApp(const MyCameraApp());
}

class MyCameraApp extends StatelessWidget {
  const MyCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera & Filter Carousel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CameraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
