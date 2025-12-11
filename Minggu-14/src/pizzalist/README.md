# pizzalist

🔧 Praktikum 1: Membuat Layanan Mock API
Langkah 1: Setup WireMock Cloud
Daftar di WireMock Cloud

Buat stub baru:

Name: Pizza List

Method: GET

Endpoint: /pizzalist

Response: JSON dari https://bit.ly/pizzalist

Contoh JSON:

json
[
{
"name": "Margherita",
"description": "Tomato, fresh mozzarella and basil",
"image": "images/margherita.png"
},
...
]
📦 Langkah 2: Tambahkan Dependency http
Di terminal proyek Flutter:

bash
flutter pub add http
📁 Langkah 3: Buat File httphelper.dart
Penulisan ulang dan penjelasan kode:
dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'pizza.dart';

class HttpHelper {
static final HttpHelper \_instance = HttpHelper.\_internal();
factory HttpHelper() => \_instance;
HttpHelper.\_internal();

final String baseUrl = '02z2g.mocklab.io';
final String endpoint = 'pizzalist';

Future<List<Pizza>> getPizzaList() async {
final Uri uri = Uri.http(baseUrl, endpoint);
final http.Response response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<Pizza>((item) => Pizza.fromJson(item)).toList();
    } else {
      return [];
    }

}
}
🧠 Penjelasan:

Menggunakan singleton agar hanya satu instance HttpHelper dibuat.

getPizzaList() mengambil data dari endpoint dan mengubahnya jadi list Pizza.

🧩 Langkah 4: Tambahkan Fungsi di main.dart
dart
Future<List<Pizza>> callPizzas() async {
HttpHelper helper = HttpHelper();
List<Pizza> pizzas = await helper.getPizzaList();
return pizzas;
}
🖼️ Langkah 5: Tampilkan Data dengan FutureBuilder
dart
FutureBuilder<List<Pizza>>(
future: callPizzas(),
builder: (context, snapshot) {
if (snapshot.hasError) {
return const Text('Something went wrong');
}
if (!snapshot.hasData) {
return const CircularProgressIndicator();
}

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final pizza = snapshot.data![index];
        return ListTile(
          title: Text(pizza.name),
          subtitle: Text('${pizza.description} - € ${pizza.price}'),
        );
      },
    );

},
)
📝 Jawaban Soal Refleksi
Soal 1: Tambahkan nama panggilan dan ubah warna tema
Contoh:

dart
return MaterialApp(
title: 'Pizza App - Alif',
theme: ThemeData(
primarySwatch: Colors.deepPurple,
),
home: MyHomePage(),
);
❓ Pertanyaan Praktikum

1. Apa manfaat menggunakan layanan mock seperti WireMock?
   Jawaban: Memungkinkan pengujian aplikasi tanpa backend nyata, mempercepat pengembangan dan debugging.

2. Mengapa kita menggunakan FutureBuilder?
   Jawaban: Untuk membangun UI berdasarkan hasil asynchronous dari API, seperti menampilkan loading, error, atau data.

3. Apa keuntungan menggunakan pola singleton di HttpHelper?
   Jawaban: Menghemat resource dan menjaga konsistensi akses ke API dari satu instance saja.

## Praktikum 2

🧪 Langkah 1: Buat Stub POST di WireMock
Method: POST

Endpoint: /pizza

Status: 201

Response Body:

json
{
"message": "The pizza was posted"
}
Ini akan menjadi target endpoint untuk mengirim data pizza dari aplikasi Flutter.

📁 Langkah 2: Tambahkan Fungsi postPizza() di httphelper.dart
✅ Kode:
dart
Future<String> postPizza(Pizza pizza) async {
final Uri uri = Uri.http(baseUrl, 'pizza');
final Map<String, dynamic> jsonMap = pizza.toJson();
final String jsonString = jsonEncode(jsonMap);

final http.Response response = await http.post(
uri,
headers: {'Content-Type': 'application/json'},
body: jsonString,
);

if (response.statusCode == 201) {
final Map<String, dynamic> responseBody = jsonDecode(response.body);
return responseBody['message'];
} else {
return 'Failed to post pizza';
}
}
🧠 Penjelasan:
Mengubah objek Pizza menjadi JSON.

Mengirim POST ke endpoint /pizza.

Jika berhasil, mengembalikan pesan dari server.

📄 Langkah 3: Buat File pizza_detail.dart
✅ Kode:
dart
import 'package:flutter/material.dart';
import 'pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
const PizzaDetailScreen({super.key});

@override
State<PizzaDetailScreen> createState() => \_PizzaDetailScreenState();
}

class \_PizzaDetailScreenState extends State<PizzaDetailScreen> {
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

Future<void> sendPizza() async {
final pizza = Pizza(
id: int.parse(idController.text),
name: nameController.text,
description: descController.text,
price: double.parse(priceController.text),
image: imageController.text,
);

    final helper = HttpHelper();
    final result = await helper.postPizza(pizza);

    setState(() {
      resultMessage = result;
    });

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
TextField(controller: idController, decoration: const InputDecoration(labelText: 'Insert ID')),
const SizedBox(height: 24),
TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Insert Pizza Name')),
const SizedBox(height: 24),
TextField(controller: descController, decoration: const InputDecoration(labelText: 'Insert Description')),
const SizedBox(height: 24),
TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Insert Price')),
const SizedBox(height: 24),
TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Insert Image Url')),
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
🧭 Langkah 4: Navigasi dari main.dart
Tambahkan tombol di MyHomePage untuk membuka PizzaDetailScreen:

dart
floatingActionButton: FloatingActionButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const PizzaDetailScreen()),
);
},
child: const Icon(Icons.add),
),
✅ Hasil yang Diharapkan
Setelah mengisi form dan menekan tombol Send Post, kamu akan melihat pesan:

json
"message": "The pizza was posted"
❓ Jawaban Pertanyaan Praktikum

1. Apa perbedaan utama antara GET dan POST?
   Jawaban:

GET digunakan untuk mengambil data dari server.

POST digunakan untuk mengirim data baru ke server.

2. Mengapa kita perlu mengubah objek menjadi JSON sebelum dikirim?
   Jawaban: Karena server web biasanya menerima data dalam format JSON, bukan objek Dart.

3. Apa yang terjadi jika respons dari server bukan status 201?
   Jawaban: Fungsi postPizza() akan mengembalikan 'Failed to post pizza', dan UI akan menampilkan pesan error.
