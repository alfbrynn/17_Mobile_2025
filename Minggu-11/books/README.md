# 11 | Pemrograman Asynchronus

## 📘 Praktikum 1: Mengunduh Data dari Web Service (API)

### 🎯 Tujuan

Membuat aplikasi Flutter yang mengambil data dari Google Books API secara asynchronous dan menampilkannya di layar.

### 🧱 Langkah-langkah Praktikum

#### Langkah 1: Buat Project Baru

`flutter create books`

`cd books`

`flutter pub add http`

![img](img/p1/01.png)

📌 Penjelasan: Kita membuat project Flutter bernama books, lalu menambahkan dependency http agar bisa melakukan request ke API.

#### Langkah 2: Cek pubspec.yaml

![img](img/p1/02.png)

📌 Penjelasan: Pastikan plugin http sudah terpasang. Jika kamu pakai macOS, tambahkan entitlements agar bisa akses jaringan.

#### Langkah 3: Buka dan Tulis main.dart

![img](img/p1/03.png)

📌 Penjelasan: Ini adalah struktur dasar aplikasi Flutter. Kita menggunakan MaterialApp dan menambahkan nama panggilan di title sebagai identitas.

![img](img/p1/c1.gif)

#### Langkah 4: Tambahkan Method getData()

![img](img/p1/04.png)

📌 Penjelasan: Method ini membuat request ke Google Books API. ✅ Soal 2: Kamu diminta mencari buku favorit di Google Books, lalu ambil ID dari URL dan ganti di path.

#### Langkah 5: Tambahkan Tombol dan Tampilkan Data

![img](img/p1/05.png)

### ✅ Jawaban Soal Praktikum

🔸 Soal 1: Tambahkan nama panggilan
Sudah ditambahkan di title: 'Books App - Alif'.

![img](img/p1/s1.png)

🔸 Soal 2: Ganti ID buku favorit
Sudah diganti dengan ID junbDwAAQBAJ dari buku favorit di Google Books.

![img](img/p1/s2.png)

🔸 Soal 3: Jelaskan substring dan catchError
substring(0, 450) → digunakan untuk memotong isi response agar hanya menampilkan 450 karakter pertama. Ini berguna agar tampilan tidak terlalu panjang dan tetap rapi.

catchError → digunakan untuk menangkap error dari proses asynchronous. Jika terjadi error (misalnya koneksi gagal), maka akan menampilkan pesan 'An error occurred' dan mencegah aplikasi crash.

![img](img/p1/s3.png)

### 📸 Dokumentasi Akhir Praktikum 1

![img](img/p1/a1.gif)
