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