import 'package:flutter/material.dart';
import '../models/item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [
      Item(name: 'Apel', price: 5000),
      Item(name: 'Jeruk', price: 7000),
      Item(name: 'Mangga', price: 10000),
      Item(name: 'Pisang', price: 4000),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Belanja')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              // Navigasi ke ItemPage sambil mengirim data item
              Navigator.pushNamed(context, '/item', arguments: item);
            },
            child: Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text('Rp ${item.price}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
}
