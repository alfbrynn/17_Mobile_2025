import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/filter_carousel.dart';

class FilterPage extends StatelessWidget {
  final String imagePath;
  const FilterPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final file = File(imagePath);

    return Scaffold(
      appBar: AppBar(title: const Text('Filter Carousel')),
      body: Column(
        children: [
          Expanded(child: Image.file(file, fit: BoxFit.contain)),
          const SizedBox(height: 10),
          FilterCarousel(imagePath: imagePath),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
