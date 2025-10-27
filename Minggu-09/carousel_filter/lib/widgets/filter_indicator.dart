import 'package:flutter/material.dart';

class FilterIndicator extends StatelessWidget {
  final String label;

  const FilterIndicator({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.substring(0, 1).toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
