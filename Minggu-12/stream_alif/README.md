# 12 | Lanjutan State Manajemen dengan Streams

## Praktikum 1: Dart Stream

✅ Langkah 1: Buat Project Baru
Buat project Flutter baru dengan nama stream_namaPanggilan di folder week-12/src/.

bash
flutter create stream_alif
Penjelasan: Ini membuat struktur dasar aplikasi Flutter. Nama project disesuaikan agar mudah dikenali sebagai hasil praktikum pribadi.

✅ Langkah 2: Buka file main.dart

![img](../img/p1/2.png)

Soal 1 Jawaban:

Nama panggilan ditambahkan pada judul aplikasi: 'Stream Alif'

Warna tema diganti ke Colors.indigo

Commit: "W12: Jawaban Soal 1"

✅ Langkah 3: Buat file baru stream.dart

![img](../img/p1/2.png)

Soal 2 Jawaban:

Menambahkan 5 warna tambahan sesuai keinginan

Commit: "W12: Jawaban Soal 2"

✅ Langkah 5: Tambah method getColors()

![img](../img/p1/3.png)

Soal 3 Jawaban:

yield\* digunakan untuk meneruskan stream dari Stream.periodic ke stream utama.

Kode menghasilkan warna baru setiap detik berdasarkan urutan dalam list colors.

Commit: "W12: Jawaban Soal 3"

✅ Langkah 7: Impor stream.dart di main.dart
dart

![img](../img/p1/7.png)

✅ Langkah 8: Tambah variabel di \_StreamHomePageState
dart

![img](../img/p1/8.png)

Penjelasan:

bgColor menyimpan warna latar saat ini.

colorStream adalah instance dari class ColorStream.

✅ Langkah 9: Tambah method changeColor()

![img](../img/p1/9.png)

Penjelasan:

Mendengarkan stream warna dan mengubah warna latar setiap detik.

✅ Langkah 10: Override initState()

![img](../img/p1/10.png)

Penjelasan:

Inisialisasi colorStream dan mulai mendengarkan perubahan warna saat widget dibuat.

✅ Langkah 11: Ubah isi Scaffold()

![img](../img/p1/11.png)

Penjelasan:

Menampilkan warna latar yang berubah setiap detik.

✅ Langkah 12: Jalankan aplikasi
Soal 4 Jawaban:

![img](../img/p1/Adobe%20Express%20-%20p1.gif)

Commit: "W12: Jawaban Soal 4"

✅ Langkah 13: Alternatif method changeColor() menggunakan listen

![img](../img/p1/13.png)

![img](../img/p1/Adobe%20Express%20-%20p1-2.gif)

Soal 5 Jawaban:

listen: langsung berlangganan stream dan menangani event secara reaktif.

await for: digunakan dalam fungsi async untuk menunggu setiap event satu per satu.

Perbedaan utama: listen tidak perlu async, sedangkan await for digunakan dalam fungsi async dan lebih cocok untuk kontrol alur yang kompleks.

Commit: "W12: Jawaban Soal 5"

## Praktikum 2: Stream Controllers dan Sinks

✅ Langkah 1: Buka file stream.dart

![img](../img/p2/01.png)

Penjelasan: Membuat class NumberStream sebagai wadah untuk mengelola stream angka. Class ini akan dikembangkan di langkah-langkah berikutnya.

✅ Langkah 2: Tambah StreamController

![img](../img/p2/02.png)

Penjelasan: StreamController bertugas sebagai penghubung antara Sink dan Stream.

Sink: tempat memasukkan data.

Stream: tempat data keluar dan bisa didengarkan oleh subscriber.

✅ Langkah 3: Tambah method addNumberToSink()

![img](../img/p2/03.png)

Penjelasan: Method ini digunakan untuk memasukkan angka baru ke dalam stream melalui sink.

✅ Langkah 4: Tambah method close()

![img](../img/p2/04.png)

Penjelasan: Menutup stream controller agar tidak terjadi memory leak. Wajib dipanggil saat widget dihapus (dispose()).

✅ Langkah 5: Buka file main.dart dan tambahkan import

![img](../img/p2/05.png)

Penjelasan:

dart:async: untuk menggunakan StreamController.

dart:math: untuk menghasilkan angka acak.

✅ Langkah 6: Tambah variabel di \_StreamHomePageState

![img](../img/p2/06.png)

Penjelasan:

lastNumber: menyimpan angka terakhir yang diterima dari stream.

numberStreamController: controller dari stream.

numberStream: instance dari class NumberStream.

✅ Langkah 7: Override initState()

![img](../img/p2/07.png)

Penjelasan:

Inisialisasi objek NumberStream.

Mendengarkan stream dan mengubah lastNumber setiap kali ada data baru.

✅ Langkah 8: Override dispose()

![img](../img/p2/08.png)

Penjelasan: Menutup stream controller saat widget dihapus agar tidak terjadi kebocoran memori.

✅ Langkah 9: Tambah UI di body

![img](../img/p2/09.png)

Penjelasan:

Menampilkan angka terakhir.

Tombol untuk menambahkan angka acak ke stream.

✅ Langkah 10: Tambah method addRandomNumber()

![img](../img/p2/10.png)

Penjelasan:

Menghasilkan angka acak dari 0–9.

Memasukkan angka ke stream melalui addNumberToSink().

✅ Soal 6: Jelaskan maksud kode langkah 8 dan 10
Jawaban Soal 6:

Langkah 8 (initState): Menginisialisasi stream dan mendengarkan data baru. Setiap data yang masuk akan mengubah nilai lastNumber.

Langkah 10 (addRandomNumber): Menghasilkan angka acak dan mengirimkannya ke stream agar bisa ditampilkan di UI.

Commit: "W12: Jawaban Soal 6"

![img](../img/p2/Adobe%20Express%20-%20p2.gif)

✅ Langkah 13: Tambah method addError()

![img](../img/p2/13.png)

Penjelasan: Menambahkan error ke stream. Berguna untuk menguji penanganan error.

✅ Langkah 14: Tambah onError di initState()

![img](../img/p2/14.png)

Penjelasan:

Jika terjadi error, nilai lastNumber diubah menjadi -1.

✅ Langkah 15: Edit addRandomNumber() untuk uji error

![img](../img/p2/15.png)

Penjelasan:

Baris asli dikomentari.

Memanggil addError() untuk menguji penanganan error.

✅ Soal 7: Jelaskan maksud kode langkah 13–15
Jawaban Soal 7:

Langkah 13: Menyediakan cara untuk mengirim error ke stream.

Langkah 14: Menangani error dengan mengubah tampilan UI agar menunjukkan nilai -1.

Langkah 15: Menguji apakah error ditangani dengan benar.

Commit: "W12: Jawaban Soal 7"
