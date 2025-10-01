import 'package:flutter/material.dart';
import 'RujakText.dart';
import 'RujakImage.dart';

/// Halaman utama yang menampilkan layout Pavlova
class RujakPage extends StatelessWidget {
  const RujakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rujak Kikil')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              // bagian teks
              Expanded(flex: 2, child: RujakText()),
              // bagian gambar
              Expanded(flex: 4, child: RujakImage()),
            ],
          ),
        ),
      ),
    );
  }
}
