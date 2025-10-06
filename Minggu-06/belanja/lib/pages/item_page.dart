import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data dari halaman sebelumnya
    final item = ModalRoute.of(context)!.settings.arguments as Item;

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Harga: Rp ${item.price}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Buah segar dengan kualitas terbaik, cocok untuk konsumsi harian.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
