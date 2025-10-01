import 'package:flutter/material.dart';

/// Bagian gambar
class RujakImage extends StatelessWidget {
  const RujakImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Image.asset('images/rujak.jpg', fit: BoxFit.cover),
    );
  }
}
