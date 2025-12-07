# 13 | Persistensi Data

## 🧪 Praktikum 1: Konversi Dart Model ke JSON

🔹 Langkah 1: Buat Project Baru
Tujuan: Menyiapkan struktur awal proyek Flutter.

Buat project Flutter baru dengan nama store_data_nama di folder week-13/src/ pada repository GitHub kamu. Ini akan menjadi wadah untuk semua file dan konfigurasi yang digunakan dalam praktikum ini.

🔹 Langkah 2: Buka dan Edit main.dart
Tujuan: Menyiapkan struktur dasar aplikasi Flutter.

```dart
import 'package:flutter/material.dart';
import 'dart:convert';
import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo - Alif',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}
```

📌 Penjelasan: Ini adalah struktur dasar aplikasi Flutter. Kita menggunakan MaterialApp sebagai root dan mengarahkan ke MyHomePage.

🔹 Langkah 3–4: Buat Folder dan File JSON
Tujuan: Menyediakan data pizza dalam format JSON.

Buat folder assets/ di root project.

Tambahkan file pizzalist.json berisi data pizza seperti berikut:

```json
[
  {
    "id": 1,
    "pizzaName": "Margherita",
    "description": "Pizza with tomato, fresh mozzarella and basil",
    "price": 8.75,
    "imageUrl": "images/margherita.png"
  },
  {
    "id": 2,
    "pizzaName": "Marinara",
    "description": "Pizza with tomato, garlic and oregano",
    "price": 7.5,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 3,
    "pizzaName": "Napoli",
    "description": "Pizza with tomato, garlic and anchovies",
    "price": 9.5,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 4,
    "pizzaName": "Carciofi",
    "description": "Pizza with tomato, fresh mozzarella and artichokes",
    "price": 8.8,
    "imageUrl": "images/marinara.png"
  },
  {
    "id": 5,
    "pizzaName": "Bufala",
    "description": "Pizza with tomato, buffalo mozzarella and basil",
    "price": 12.5,
    "imageUrl": "images/marinara.png"
  }
]
```

📌 Penjelasan: File ini berisi data yang akan kita baca dan tampilkan di aplikasi.

🔹 Langkah 5: Tambahkan Referensi di pubspec.yaml
Tujuan: Memberitahu Flutter bahwa kita akan menggunakan folder assets.

```yaml
flutter:
  assets:
    - assets/
```

📌 Penjelasan: Ini wajib agar Flutter bisa mengakses file JSON yang kita simpan di folder assets.

🔹 Langkah 6–10: Baca dan Tampilkan JSON di UI
Tujuan: Menampilkan isi file JSON sebagai teks mentah.

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';

  Future readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');
    setState(() {
      pizzaString = myString;
    });
  }

  @override
  void initState() {
    super.initState();
    readJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON')),
      body: Text(pizzaString),
    );
  }
}
```

📌 Penjelasan: Kita membaca file JSON dan menampilkannya sebagai string mentah di layar.

🔹 Langkah 11–13: Buat Model Pizza
Tujuan: Membuat representasi data pizza dalam bentuk objek Dart.

```dart
class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pizzaName = json['pizzaName'],
        description = json['description'],
        price = json['price'],
        imageUrl = json['imageUrl'];
}
```

📌 Penjelasan: Model ini memungkinkan kita mengubah data JSON menjadi objek Dart yang bisa digunakan secara lebih fleksibel.

🔹 Langkah 14–22: Konversi JSON ke List Object
Tujuan: Mengubah data JSON menjadi list objek Pizza dan menampilkannya secara terstruktur.

```dart
Future<List<Pizza>> readJsonFile() async {
  String myString = await DefaultAssetBundle.of(context)
      .loadString('assets/pizzalist.json');
  List pizzaMapList = jsonDecode(myString);

  List<Pizza> myPizzas = [];
  for (var pizza in pizzaMapList) {
    Pizza myPizza = Pizza.fromJson(pizza);
    myPizzas.add(myPizza);
  }

  return myPizzas;
}

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

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('JSON')),
    body: ListView.builder(
      itemCount: myPizzas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(myPizzas[index].pizzaName),
          subtitle: Text(myPizzas[index].description),
        );
      },
    ),
  );
}
```

📌 Penjelasan: Kita tampilkan data pizza dalam bentuk list yang lebih rapi dan mudah dibaca.

🔹 Langkah 23–26: Konversi Kembali ke JSON String
Tujuan: Mengubah objek Dart kembali menjadi JSON string.

Tambahkan method toJson() di Pizza:

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'pizzaName': pizzaName,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
```

Tambahkan fungsi konversi di main.dart:

```dart
String convertToJSON(List<Pizza> pizzas) {
  return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
}
```

Cetak hasil JSON ke konsol:

```dart
String json = convertToJSON(myPizzas);
print(json);
```

📌 Penjelasan: Ini berguna jika kita ingin menyimpan kembali data ke file atau mengirim ke server.

## 🧪 Praktikum 2: Handle Kompatibilitas Data JSON

🔹 Langkah 1: Simulasikan Error
Tujuan: Menguji ketahanan aplikasi terhadap data rusak.

Ganti file pizzalist.json dengan versi rusak, misalnya pizzalist_broken.json, yang berisi data seperti:

```json
[
  {
    "id": "1",
    "pizzaName": null,
    "description": 123,
    "price": "8.75"
  }
]
```

📌 Penjelasan: Format ini tidak sesuai dengan model Dart yang mengharapkan tipe data spesifik.

🔹 Langkah 2: Lihat Error Tipe Data String ke Int
Tujuan: Mengamati error runtime akibat perbedaan tipe data.

Jika id dikirim sebagai "1" (String), padahal model Dart mengharapkan int, maka akan muncul error:

Code
\_TypeError (type 'String' is not a subtype of type 'int')

🔹 Langkah 3: Terapkan tryParse dan ?? pada ID
Tujuan: Menangani konversi tipe data dengan aman.

```dart
id = int.tryParse(json['id'].toString()) ?? 0;
```

📌 Penjelasan: Mengubah nilai menjadi int jika bisa, atau default ke 0 jika gagal.

🔹 Langkah 4: Simulasikan Error Null pada String
Tujuan: Mengamati error akibat nilai null pada field String.

Jika pizzaName atau imageUrl bernilai null, akan muncul error:

Code
\_TypeError (type 'Null' is not a subtype of type 'String')

🔹 Langkah 5: Terapkan Null Coalescing (??) pada String
Tujuan: Memberi nilai default jika field bernilai null.

```dart
imageUrl = json['imageUrl'] ?? '';
pizzaName = json['pizzaName'] ?? 'No name';
```

📌 Penjelasan: Jika null, maka gunakan string kosong atau label default.

🔹 Langkah 6: Gunakan .toString() untuk Field String
Tujuan: Memastikan semua field bertipe String.

```dart
description = json['description'].toString();
```

📌 Penjelasan: Menghindari error jika nilai dikirim sebagai angka atau tipe lain.

🔹 Langkah 7: Simulasikan Error Tipe Data String ke Double
Tujuan: Mengamati error saat price dikirim sebagai "8.75" (String).

Error:

Code
\_TypeError (type 'String' is not a subtype of type 'double')

🔹 Langkah 8: Terapkan double.tryParse dan ??
Tujuan: Menangani konversi ke double dengan aman.

```dart
price = double.tryParse(json['price'].toString()) ?? 0;
```

📌 Penjelasan: Jika parsing gagal, gunakan nilai default 0.

🔹 Langkah 9: Run dan Perhatikan Output Null
Tujuan: Menjalankan aplikasi dan melihat apakah masih muncul "null" di UI.

Jika masih muncul "null", berarti ada field yang gagal diparsing atau tidak ditangani dengan baik.

🔹 Langkah 10: Tambahkan Operator Ternary untuk Output User-Friendly
Tujuan: Menyembunyikan nilai "null" dari tampilan UI.

Contoh:

```dart
Text(pizza.pizzaName != null ? pizza.pizzaName : 'No name'),
Text(pizza.description != null ? pizza.description : ''),
```

📌 Penjelasan: Menyediakan fallback agar UI tetap ramah pengguna.

🔹 Langkah 11: Run
Tujuan: Menjalankan aplikasi untuk memastikan semua error dan nilai null telah ditangani.

📝 Soal 4: Capture hasil running aplikasi
Jawaban:

Jalankan aplikasi.

Ambil screenshot tampilan list pizza.

Impor ke laporan praktikum.

Commit dengan pesan:

Code
W13: Jawaban Soal 4

## Praktikum 3

✅ Langkah 1: Buat Konstanta untuk Kunci JSON
Kode:

![img](img/p3/01.png)

Penjelasan: Konstanta ini digunakan untuk menggantikan string literal seperti 'id', 'pizzaName', dll. Tujuannya adalah:

Menghindari kesalahan pengetikan (typo).

Memudahkan pemeliharaan kode jika suatu saat nama kunci berubah.

✅ Langkah 2: Perbarui fromJson() Menggunakan Konstanta
Kode:

![img](img/p3/02.png)

Penjelasan:

Menggunakan keyId, keyName, dll sebagai pengganti string literal.

tryParse digunakan agar tidak error jika format data tidak sesuai.

Operator ?? dan ternary digunakan untuk memberikan nilai default jika data tidak tersedia.

✅ Langkah 3: Perbarui toJson() Menggunakan Konstanta
Kode:

![img](img/p3/02.png)

Penjelasan:

Sama seperti fromJson(), penggunaan konstanta membuat kode lebih konsisten dan aman.

toJson() digunakan untuk mengubah objek Dart menjadi format JSON.

✅ Langkah 4: Jalankan Aplikasi
Penjelasan:

Tidak ada perubahan visual karena ini hanya refactor internal.

Namun, kode sekarang lebih aman dan mudah dirawat.

✅ Soal 5: Jelaskan Maksud Kode Lebih Safe dan Maintainable
Jawaban: Kode menjadi lebih safe karena:

Menghindari error akibat kesalahan pengetikan string literal.

Menggunakan nilai default untuk mencegah crash saat data tidak lengkap.

Kode menjadi lebih maintainable karena:

Jika ada perubahan nama kunci JSON, cukup ubah di satu tempat (konstanta).

Membuat kode lebih mudah dibaca dan dipahami oleh tim pengembang.

## Praktikum 4

🔹 Langkah 1: Tambahkan Dependensi
Kode (di terminal):

bash
flutter pub add shared_preferences
Penjelasan: Menambahkan package shared_preferences ke proyek Flutter agar bisa digunakan untuk menyimpan data lokal secara sederhana.

🔹 Langkah 2: Install Dependensi
Kode (otomatis atau manual):

bash
flutter pub get
Penjelasan: Mengunduh dan mengintegrasikan package yang baru ditambahkan ke dalam proyek.

🔹 Langkah 3: Import Package
Kode:

dart
import 'package:shared_preferences/shared_preferences.dart';
Penjelasan: Mengimpor package agar bisa digunakan di file Dart.

🔹 Langkah 4: Tambahkan Variabel appCounter
Kode:

dart
int appCounter = 0;
Penjelasan: Variabel ini digunakan untuk menyimpan jumlah pembukaan aplikasi.

🔹 Langkah 5: Buat Method readAndWritePreference()
Kode:

dart
Future readAndWritePreference() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
appCounter = prefs.getInt('appCounter') ?? 0;
appCounter++;
await prefs.setInt('appCounter', appCounter);
setState(() {
appCounter = appCounter;
});
}
Penjelasan:

Mendapatkan instance SharedPreferences.

Membaca nilai appCounter dari storage, default ke 0 jika belum ada.

Menambahkan 1 ke nilai tersebut.

Menyimpan kembali ke storage.

Memanggil setState() agar UI diperbarui.

🔹 Langkah 6: Panggil di initState()
Kode:

dart
@override
void initState() {
super.initState();
readAndWritePreference();
}
Penjelasan: Memastikan readAndWritePreference() dipanggil saat aplikasi pertama kali dibuka.

🔹 Langkah 7: Perbarui Tampilan (body)
Kode:

dart
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Text('You have opened the app $appCounter times.'),
ElevatedButton(
onPressed: () {
deletePreference();
},
child: Text('Reset counter'),
),
],
),
),
Penjelasan: Menampilkan jumlah pembukaan aplikasi dan tombol untuk mereset hitungan.

🔹 Langkah 8: Buat Method deletePreference()
Kode:

dart
Future deletePreference() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.clear();
setState(() {
appCounter = 0;
});
}
Penjelasan: Menghapus semua data dari SharedPreferences dan mengatur ulang appCounter ke 0.

🔹 Langkah 9: Hubungkan Tombol Reset
Sudah dilakukan di langkah 7 dengan:

dart
onPressed: () {
deletePreference();
}
🔹 Langkah 10: Jalankan Aplikasi
Penjelasan:

Saat pertama kali dibuka, akan muncul: "You have opened the app 1 times."

Setiap kali dibuka ulang, angka akan bertambah.

Tombol reset akan menghapus data dan mengatur ulang ke 0.

✅ Jawaban Soal 6
Jawaban:

Capture hasil aplikasi dalam bentuk GIF.

Lampirkan di README.

Commit dengan pesan:

bash
git commit -m "W13: Jawaban Soal 6"
