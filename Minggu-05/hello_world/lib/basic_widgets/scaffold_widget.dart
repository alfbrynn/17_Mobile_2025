import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scaffold Widget")),
      body: const Center(child: Text("Ini adalah body dari Scaffold")),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50.0, color: Colors.grey[200]),
      ),
      floatingActionButton: const Icon(Icons.add),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
