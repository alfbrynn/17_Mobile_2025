import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class FilterCarousel extends StatelessWidget {
  final String imagePath;
  const FilterCarousel({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
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

    return cs.CarouselSlider(
      options: cs.CarouselOptions(
        height: 150,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.6,
      ),
      items: filters.map((filter) {
        return Column(
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: filter['filter'] as ColorFilter,
                child: Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 5),
            Text(filter['name'] as String),
          ],
        );
      }).toList(),
    );
  }
}
