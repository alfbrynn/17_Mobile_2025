## 🧩 Langkah-langkah Praktikum 1

- Langkah 1: Buat Project Baru
  📄 File: main.dart

![img](img/kamera_flutter/)
Perintah:

Buat project Flutter baru dengan nama kamera_flutter.

Tujuan: Menyiapkan struktur awal aplikasi Flutter.

- Langkah 2: Tambah Dependensi
  📄 File: pubspec.yaml

Tambahkan plugin berikut:

![img](img/kamera_flutter/)

yaml
dependencies:
camera: ^0.10.5+2
path_provider: ^2.1.1
path: ^1.8.3
Tujuan:

camera: mengakses kamera perangkat.

path_provider: menentukan lokasi penyimpanan file.

path: mengelola path file lintas platform.

- Langkah 3: Ambil Sensor Kamera dari Device
  📄 File: main.dart

Kode:
![img](img/kamera_flutter/)

dart
WidgetsFlutterBinding.ensureInitialized();
final cameras = await availableCameras();
final firstCamera = cameras.first;
Tujuan:

Menginisialisasi plugin sebelum runApp().

Mengambil daftar kamera yang tersedia.

Memilih kamera pertama (biasanya kamera belakang).

- Langkah 4: Buat dan Inisialisasi CameraController
  📄 File: lib/widget/takepicture_screen.dart

Kode:
![img](img/kamera_flutter/)

dart
late CameraController \_controller;
late Future<void> \_initializeControllerFuture;

@override
void initState() {
super.initState();
\_controller = CameraController(widget.camera, ResolutionPreset.medium);
\_initializeControllerFuture = \_controller.initialize();
}

@override
void dispose() {
\_controller.dispose();
super.dispose();
}
Tujuan:

Membuat CameraController untuk mengatur kamera.

Menginisialisasi controller saat widget dimuat.

Membersihkan controller saat widget dihancurkan.

🔹 Langkah 5: Gunakan CameraPreview
📄 File: lib/widget/takepicture_screen.dart

Kode:
![img](img/kamera_flutter/)

dart
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Take a picture - NIM Anda')),
body: FutureBuilder<void>(
future: \_initializeControllerFuture,
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.done) {
return CameraPreview(\_controller);
} else {
return const Center(child: CircularProgressIndicator());
}
},
),
);
}
Tujuan:

Menampilkan pratinjau kamera setelah controller selesai diinisialisasi.

Menunggu proses async dengan FutureBuilder.

- Langkah 6: Ambil Foto dengan CameraController
  📄 File: lib/widget/takepicture_screen.dart

Kode:
![img](img/kamera_flutter/)

dart
FloatingActionButton(
onPressed: () async {
try {
await \_initializeControllerFuture;
final image = await \_controller.takePicture();
} catch (e) {
print(e);
}
},
child: const Icon(Icons.camera_alt),
)
Tujuan:

Mengambil foto saat tombol ditekan.

Menangani error dengan try/catch.

- Langkah 7: Buat Widget DisplayPictureScreen
  📄 File: lib/widget/displaypicture_screen.dart

Kode:
![img](img/kamera_flutter/)

dart
class DisplayPictureScreen extends StatelessWidget {
final String imagePath;
const DisplayPictureScreen({super.key, required this.imagePath});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Display the Picture - NIM Anda')),
body: Image.file(File(imagePath)),
);
}
}
Tujuan:

Menampilkan hasil foto yang diambil.

Menerima path gambar dari halaman sebelumnya.

- Langkah 8: Edit main.dart
  📄 File: main.dart

Kode:
![img](img/kamera_flutter/)

dart
runApp(
MaterialApp(
theme: ThemeData.dark(),
home: TakePictureScreen(camera: firstCamera),
debugShowCheckedModeBanner: false,
),
);
Tujuan:

Menjalankan aplikasi dengan tema gelap.

Menampilkan halaman TakePictureScreen.

- Langkah 9: Navigasi ke DisplayPictureScreen
  📄 File: lib/widget/takepicture_screen.dart

Kode tambahan:
![img](img/kamera_flutter/)

dart
await Navigator.of(context).push(
MaterialPageRoute(
builder: (context) => DisplayPictureScreen(imagePath: image.path),
),
);
Tujuan:

Setelah foto diambil, tampilkan halaman baru untuk melihat hasilnya.

## 🧩 Langkah-langkah Praktikum 2

- Langkah 1: Buat Project Baru
  Perintah:

Buat project Flutter baru dengan nama photo_filter_carousel.

![img](img/photo_filter_carousel/01.png)

Tujuan: Menyiapkan struktur awal aplikasi Flutter.

- Langkah 2: Buat Widget Selector Ring dan Shadow Gradient
  📄 File: lib/widget/filter_selector.dart

![img](img/photo_filter_carousel/02.png)

Penjelasan: Widget ini menampilkan carousel filter warna yang bisa digeser. Saat pengguna memilih filter, warna akan diterapkan ke foto.

Komponen penting:

PageController: mengatur scroll horizontal.

\_onPageChanged(): mendeteksi perubahan halaman dan menerapkan warna filter.

\_buildCarousel(): menampilkan daftar warna sebagai carousel.

\_buildSelectionRing(): menampilkan lingkaran putih sebagai indikator filter aktif.

\_buildShadowGradient(): menambahkan efek gradasi gelap di bawah carousel.

- Langkah 3: Buat Widget Photo Filter Carousel
  📄 File: lib/widget/filter_carousel.dart

![img](img/photo_filter_carousel/03.png)

Penjelasan: Widget utama yang menampilkan foto dan carousel filter di bagian bawah.

Komponen penting:

\_filters: daftar warna filter.

\_filterColor: ValueNotifier untuk menyimpan warna filter aktif.

\_buildPhotoWithFilter(): menampilkan foto dengan efek warna.

\_buildFilterSelector(): memanggil FilterSelector dari langkah sebelumnya.

Catatan: Foto diambil dari URL dan diberi efek warna menggunakan colorBlendMode.

- Langkah 4: Buat Filter Warna – Bagian 1
  📄 File: lib/widget/carousel_flowdelegate.dart

![img](img/photo_filter_carousel/04.png)

Penjelasan: Custom FlowDelegate untuk mengatur animasi dan posisi item dalam carousel.

Komponen penting:

paintChildren(): menghitung posisi, skala, dan transparansi setiap item berdasarkan posisi scroll.

Matrix4: digunakan untuk transformasi visual (skala dan translasi).

viewportOffset: digunakan untuk mengetahui posisi scroll saat ini.

- Langkah 5: Buat Widget Filter Item
  📄 File: lib/widget/filter_item.dart

![img](img/photo_filter_carousel/05.png)

Penjelasan: Widget individual untuk setiap warna filter dalam carousel.

Komponen penting:

GestureDetector: mendeteksi tap pada filter.

ClipOval: membuat bentuk bulat.

Image.network: menampilkan tekstur dengan warna filter.

- Langkah 6: Implementasi ke main.dart
  📄 File: lib/main.dart

Penjelasan: Menjalankan aplikasi dan menampilkan PhotoFilterCarousel sebagai halaman utama.

Kode:

dart
void main() {
runApp(const MaterialApp(
home: PhotoFilterCarousel(),
debugShowCheckedModeBanner: false,
));
}

## 🧠 Ringkasan Alur Aplikasi

User membuka aplikasi → PhotoFilterCarousel ditampilkan.

Foto default ditampilkan dengan warna filter awal.

User menggeser carousel → warna filter berubah.

Efek warna diterapkan ke foto secara real-time.

❓ Nomor 3: Jelaskan maksud void async pada praktikum 1
void async digunakan untuk mendefinisikan fungsi asynchronous, yaitu fungsi yang dapat menjalankan proses secara tidak langsung (tidak blocking). Dalam konteks Flutter:

void menunjukkan bahwa fungsi tidak mengembalikan nilai.

async memungkinkan penggunaan await di dalam fungsi tersebut, agar bisa menunggu hasil dari operasi asynchronous seperti pengambilan foto dari kamera.

Contoh:

dart
void ambilFoto() async {
final foto = await ImagePicker().pickImage(source: ImageSource.camera);
// proses lanjutan setelah foto diambil
}
Tanpa async, kita tidak bisa menggunakan await, dan proses pengambilan foto bisa menyebabkan UI freeze karena menunggu hasil secara langsung.

❓ Nomor 4: Jelaskan fungsi dari anotasi @immutable dan @override
@immutable:

Digunakan untuk menandai bahwa sebuah class tidak boleh diubah setelah dibuat.

Biasanya digunakan pada Widget di Flutter agar nilai properti tidak berubah, menjaga konsistensi dan efisiensi rendering.

Contoh:

dart
@immutable
class MyWidget extends StatelessWidget {
final String title;
const MyWidget({required this.title});
}
@override:

Digunakan untuk menandai bahwa sebuah method atau properti sedang menimpa (override) method dari superclass.

Membantu compiler dan pembaca kode memahami bahwa kita sengaja mengganti perilaku bawaan.

Contoh:

dart
@override
Widget build(BuildContext context) {
return Text('Halo');
}

tugas gabungan praktim 1 dan 2

[img](img/carousel_filter/kamera%20filter.gif)
