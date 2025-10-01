import 'package:flutter/material.dart';
import 'widgets_rujak/RujakPage.dart';

void main() {
  runApp(const MyApp());
}

/// Entry point aplikasinya
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Rujak Kikil', home: const RujakPage());
  }
}
