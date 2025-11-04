import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.blue.shade700;

  Future<void> _showColorDialog(BuildContext context) async {
    color = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: <Widget>[
            TextButton(
              child: const Text('Red'),
              onPressed: () {
                Navigator.pop(context, Colors.red.shade700);
              },
            ),
            TextButton(
              child: const Text('Green'),
              onPressed: () {
                Navigator.pop(context, Colors.green.shade700);
              },
            ),
            TextButton(
              child: const Text('Purple'), // ✅ Soal 17: Ganti warna favorit
              onPressed: () {
                Navigator.pop(context, Colors.purple.shade700);
              },
            ),
          ],
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen - Alif'),
      ), // ✅ Soal 17
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            _showColorDialog(context);
          },
        ),
      ),
    );
  }
}
