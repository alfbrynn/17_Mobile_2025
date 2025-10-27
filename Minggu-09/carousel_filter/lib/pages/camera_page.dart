import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'filter_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      controller = CameraController(cameras![0], ResolutionPreset.medium);
      await controller!.initialize();
      if (!mounted) return;
      setState(() => isCameraReady = true);
    }
  }

  Future<void> _takePicture() async {
    if (!controller!.value.isInitialized) return;

    final image = await controller!.takePicture();
    if (!mounted) return;

    // Arahkan ke halaman filter dengan membawa path foto
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(imagePath: image.path),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambil Foto')),
      body: isCameraReady
          ? Stack(
              children: [
                CameraPreview(controller!),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FloatingActionButton(
                      onPressed: _takePicture,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
