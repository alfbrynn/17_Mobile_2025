import 'dart:io';
import 'package:camera/camera.dart';
import 'package:carousel_filter/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/filter_indicator.dart';

class CameraWithFilterPage extends StatefulWidget {
  const CameraWithFilterPage({super.key});

  @override
  State<CameraWithFilterPage> createState() => _CameraWithFilterPageState();
}

class _CameraWithFilterPageState extends State<CameraWithFilterPage> {
  CameraController? controller;
  bool isInitialized = false;
  int selectedFilterIndex = 0;
  final PageController _filterController = PageController(
    viewportFraction: 0.25,
  );

  final filters = [
    {
      'name': 'Normal',
      'filter': const ColorFilter.mode(Colors.transparent, BlendMode.dst),
    },
    {
      'name': 'Sepia',
      'filter': const ColorFilter.mode(Color(0xFF704214), BlendMode.modulate),
    },
    {
      'name': 'Grayscale',
      'filter': const ColorFilter.matrix(<double>[
        0.33,
        0.33,
        0.33,
        0,
        0,
        0.33,
        0.33,
        0.33,
        0,
        0,
        0.33,
        0.33,
        0.33,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]),
    },
    {
      'name': 'Inverted',
      'filter': const ColorFilter.matrix(<double>[
        -1,
        0,
        0,
        0,
        255,
        0,
        -1,
        0,
        0,
        255,
        0,
        0,
        -1,
        0,
        255,
        0,
        0,
        0,
        1,
        0,
      ]),
    },
  ];

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller!.initialize();
    if (!mounted) return;
    setState(() => isInitialized = true);
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) return;

    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/${DateTime.now()}.jpg';
    await controller!.takePicture().then((XFile file) async {
      final newFile = await File(file.path).copy(filePath);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PreviewPage(
            imagePath: newFile.path,
            filter: filters[selectedFilterIndex]['filter'] as ColorFilter,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Kamera full screen dengan filter aktif
          Positioned.fill(
            child: ColorFiltered(
              colorFilter:
                  filters[selectedFilterIndex]['filter'] as ColorFilter,
              child: CameraPreview(controller!),
            ),
          ),

          // Tombol kamera bulat di tengah bawah
          Positioned(
            bottom: 80,
            child: GestureDetector(
              onTap: takePicture,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                    ),
                  ),
                  // Ikon filter aktif di tengah tombol kamera
                  FilterIndicator(
                    label: filters[selectedFilterIndex]['name'] as String,
                  ),
                ],
              ),
            ),
          ),

          // Nama filter di bawah tombol kamera
          Positioned(
            bottom: 30,
            child: Text(
              filters[selectedFilterIndex]['name'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Geser filter di bagian atas tombol kamera
          Positioned(
            bottom: 180,
            child: SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _filterController,
                itemCount: filters.length,
                onPageChanged: (index) {
                  setState(() => selectedFilterIndex = index);
                },
                itemBuilder: (context, index) {
                  return Opacity(
                    opacity: selectedFilterIndex == index ? 1 : 0.4,
                    child: Center(
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white24,
                        child: Text(
                          filters[index]['name']!.toString()[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    _filterController.dispose();
    super.dispose();
  }
}

// Halaman preview foto
class PreviewPage extends StatelessWidget {
  final String imagePath;
  final ColorFilter filter;

  const PreviewPage({super.key, required this.imagePath, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview Foto'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ColorFiltered(
          colorFilter: filter,
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
}
