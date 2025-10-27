import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'widget/takepicture_screen.dart';

Future<void> main() async {
  // Pastikan plugin telah diinisialisasi sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Ambil daftar kamera yang tersedia di perangkat
  final cameras = await availableCameras();

  // Pilih kamera pertama dari daftar
  final firstCamera = cameras.first;

  // Jalankan aplikasi dengan tema gelap dan widget pengambil gambar
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
