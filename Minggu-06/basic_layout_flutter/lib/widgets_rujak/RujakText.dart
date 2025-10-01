/// Bagian teks: judul, deskripsi, rating, info bar
import 'package:flutter/material.dart';
import 'RujakInfoBar.dart';
import 'RujakRating.dart';

class RujakText extends StatelessWidget {
  const RujakText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Rujak Kikil',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Rujak kikil merupakan makanan khas dari Jawa Timur yang mempunyai bumbu yang khas diantaranya, '
            'kacang tanah, pisang kluthuk, cabai, petis Tambar dan udang, asam Jawa, gula merah, garam, terasi.',
            style: TextStyle(color: Colors.black87, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const RujakRating(),
          const SizedBox(height: 16),
          const RujakInfoBar(),
        ],
      ),
    );
  }
}
