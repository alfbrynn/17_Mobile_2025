import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alif', // Ganti dengan nama panggilan Anda
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Alif'),
      ), // Ganti dengan nama panggilan Anda
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            // ElevatedButton(
            //   child: const Text('GO!'),
            //   onPressed: () {
            //     setState(() {}); // refresh UI
            //     getData()
            //         .then((value) {
            //           result = value.body.toString().substring(
            //             0,
            //             450,
            //           ); // ✅ Soal 3
            //           setState(() {});
            //         })
            //         .catchError((_) {
            //           result = 'An error occurred'; // ✅ Soal 3
            //           setState(() {});
            //         });
            //   },
            // ),
            // const Spacer(),
            // Text(result),
            // const Spacer(),
            // const CircularProgressIndicator(),
            // const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                count();
              },
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path =
        '/books/v1/volumes/zM-vZ-JiSFYC'; // ✅ Soal 2: Ganti ID buku favorit
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }
}
