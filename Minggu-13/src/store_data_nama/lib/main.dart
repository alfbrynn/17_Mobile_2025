import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'model/pizza.dart';

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
  List<Pizza> myPizzas = [];

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
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
    final jsonOutput = convertToJSON(pizzas);
    print(jsonOutput);

    return pizzas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JSON")),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          final pizza = myPizzas[index];
          return ListTile(
            title: Text(pizza.pizzaName),
            subtitle: Text(pizza.description),
            trailing: Text("Rp ${pizza.price.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}
