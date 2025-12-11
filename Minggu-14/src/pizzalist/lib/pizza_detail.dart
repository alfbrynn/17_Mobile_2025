import 'package:flutter/material.dart';
import 'model/pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;

  const PizzaDetailScreen({
    required this.pizza,
    required this.isNew,
    super.key,
  });

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  String resultMessage = '';

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  // Future<void> sendPizza() async {
  //   final pizza = Pizza(
  //     id: int.parse(idController.text),
  //     pizzaName: nameController.text,
  //     description: descController.text,
  //     price: double.parse(priceController.text),
  //     imageUrl: imageController.text,
  //   );

  //   final helper = HttpHelper();
  //   final result = await helper.postPizza(pizza);

  //   setState(() {
  //     resultMessage = result;
  //   });
  // }

  Future<void> sendPizza() async {
    final pizza = Pizza(
      id: int.parse(idController.text),
      pizzaName: nameController.text,
      description: descController.text,
      price: double.parse(priceController.text),
      imageUrl: imageController.text,
    );

    final helper = HttpHelper();
    final result = widget.isNew
        ? await helper.postPizza(pizza)
        : await helper.putPizza(pizza);

    setState(() {
      resultMessage = result;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isNew) {
      idController.text = widget.pizza.id.toString();
      nameController.text = widget.pizza.pizzaName;
      descController.text = widget.pizza.description;
      priceController.text = widget.pizza.price.toString();
      imageController.text = widget.pizza.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Detail')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(resultMessage, style: const TextStyle(color: Colors.green)),
              const SizedBox(height: 24),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'Insert ID'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Insert Pizza Name',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Insert Description',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Insert Price'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Insert Image Url',
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: sendPizza,
                child: const Text('Send Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
