import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'model/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Data Alif',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Pizza> myPizzas = [];
  int appCounter = 0;
  String documentsPath = '';
  String tempPath = '';
  late File myFile;
  String fileText = '';

  final pwdController = TextEditingController();
  String myPass = '';

  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';

  @override
  void initState() {
    super.initState();
    getPaths().then((_) {
      myFile = File('$documentsPath/pizzas.txt');
      writeFile();
    });
  }

  Future<bool> readFile() async {
    try {
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  String convertToJSON(List<Pizza> pizzas) {
    final List<Map<String, dynamic>> jsonList = pizzas
        .map((pizza) => pizza.toJson())
        .toList();
    return jsonEncode(jsonList);
  }

  Future<List<Pizza>> readJsonFile() async {
    final jsonString = await rootBundle.rootBundle.loadString(
      'assets/pizzalist.json',
    );
    final List<dynamic> pizzaMapList = jsonDecode(jsonString);
    final List<Pizza> pizzas = pizzaMapList
        .map((data) => Pizza.fromJson(data))
        .toList();

    // Tambahan langkah 25
    // final jsonOutput = convertToJSON(pizzas);
    // print(jsonOutput);

    return pizzas;
  }

  Future<void> readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Langkah 7: Baca nilai, cek null, increment
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;

    // Langkah 8: Simpan nilai baru
    await prefs.setInt('appCounter', appCounter);

    // Langkah 9: Perbarui UI
    setState(() {});
  }

  Future<void> deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  // Future<void> getPaths() async {
  //   final docDir = await getApplicationDocumentsDirectory();
  //   final tempDir = await getTemporaryDirectory();

  //   setState(() {
  //     documentsPath = docDir.path;
  //     tempPath = tempDir.path;
  //   });
  // }

  Future<void> getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString('Alif, 2241720001');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String> readFromSecureStorage() async {
    String secret = await storage.read(key: myKey) ?? '';
    return secret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Path Provider')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(controller: pwdController),
            ElevatedButton(
              child: Text('Save Value'),
              onPressed: () {
                writeToSecureStorage();
              },
            ),
            ElevatedButton(
              child: Text('Read Value'),
              onPressed: () {
                readFromSecureStorage().then((value) {
                  setState(() {
                    myPass = value;
                  });
                });
              },
            ),
            Text('Stored password: $myPass'),
          ],
        ),
      ),
    );
  }
}
