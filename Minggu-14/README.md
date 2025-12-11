# Jobsheet 14

## 🔧 Praktikum 1: Membuat Layanan Mock API

Langkah 1: Setup WireMock Cloud
Tujuan: Simulasi backend menggunakan layanan mock.

Langkah:

Daftar di WireMock Cloud

Masuk dan buka “Example Mock API”

Klik tab Stubs, lalu klik entri pertama: Get a JSON resource

Klik tombol New, isi:

Name: Pizza List

Method: GET

URL: /pizzalist

Response: Status 200, format JSON, isi dari https://bit.ly/pizzalist

Contoh JSON body:

json
[
{
"id": 1,
"name": "Margherita",
"description": "Tomato, fresh mozzarella and basil",
"image": "images/margherita.png"
},
{
"id": 2,
"name": "Marinara",
"description": "Tomato, garlic and oregano",
"image": "images/marinara.png"
}
]
📦 Langkah 2: Tambahkan Dependensi HTTP
Tujuan: Agar Flutter bisa melakukan request ke API.

Tambahkan di terminal:

bash
flutter pub add http
📁 Langkah 3: Buat File httphelper.dart
Tujuan: Membuat helper untuk mengambil data dari API.

dart
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pizza.dart';

class HttpHelper {
static final HttpHelper \_instance = HttpHelper.\_internal();
factory HttpHelper() => \_instance;
HttpHelper.\_internal();

final String authority = '02z2g.mocklab.io';
final String path = 'pizzalist';

Future<List<Pizza>> getPizzaList() async {
final Uri url = Uri.https(authority, path);
final http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonData = json.decode(result.body);
      final List<Pizza> pizzas = jsonData.map((item) => Pizza.fromJson(item)).toList();
      return pizzas;
    } else {
      return [];
    }

}
}
Penjelasan:

Menggunakan Singleton agar hanya satu instance HttpHelper dibuat.

getPizzaList() mengambil data dari endpoint dan mengubahnya jadi list objek Pizza.

📄 Langkah 4: Tambahkan Method di main.dart
Tujuan: Memanggil data dari HttpHelper.

dart
Future<List<Pizza>> callPizzas() async {
HttpHelper helper = HttpHelper();
List<Pizza> pizzas = await helper.getPizzaList();
return pizzas;
}
🧱 Langkah 5: Tampilkan Data dengan FutureBuilder
Tujuan: Menampilkan list pizza di UI.

dart
FutureBuilder(
future: callPizzas(),
builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
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
📝 Soal 1: Modifikasi Tampilan
Soal:

Tambahkan nama panggilan pada judul aplikasi.

Ganti warna tema sesuai kesukaan.

Capture hasil aplikasi dan commit dengan pesan: "W14: Jawaban Soal 1"

Jawaban:

Tambahkan nama panggilan:

dart
appBar: AppBar(
title: const Text('JSON - Alif'),
),
Ganti warna tema:

dart
theme: ThemeData(
primarySwatch: Colors.teal, // contoh warna kesukaan
),
Capture hasil aplikasi dan commit:

bash
git add .
git commit -m "W14: Jawaban Soal 1"
