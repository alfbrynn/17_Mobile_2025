# Project layout_flutter

## Praktikum 1: Membangun Layout Flutter

![main dart](img/layout_flutter/01.png)

### Penjelasan

Hasil output kode ini hanya akan menampilkan hello world pada tampilan di edge

![main judul tempat](img/layout_flutter/02.png)

### Penjelasan

Menampilkan informasi tempat wisata berupa nama, lokasi, ikon bintang, dan angka rating.

## Praktikum 2: Implementasi button row

![implementasi button row](img/layout_flutter/03.png)

### Penjelasan

method '\_buildButtonColumn()' bertugas membangun satu kolom tombol. Memiliki parameter warna, ikon dan label teks. Widget 'buttonSection' menggunakan 'Row' untuk menyusun tiga kolom tombol secara horizontal. Masing-masing kolom dibuat dengan '\_buildButtonColumn()' dan mengisi parameter sesuai kebutuhan. 'MainAxisAlignement.spaceEvenly' digunakan agar jarak antar kolom merata.

## Praktikum 3: Implementasi text section

![text](img/layout_flutter/04.png)

### Penjelasan

Text dimasukkan ke dalam 'Container' agar bisa diberi padding di semua sisi. 'EdgeInsets.all(32)' memberi ruang piksel disekelilng teks agar tidak menempel di tepi layar. 'softWrap: true' memastikan teks membungkud secara otomatis saat mencapai batas layar, sehingga tidak terpotong.

## Praktikum 4: Implementasi image section

![image section](img/layout_flutter/05.png)

### Penjelasan

Gambar ditambahkan ke dalam 'body' menggunakan widget 'Image.set'. Properti 'BoxFit.cover' digunakan agar gambar memenuhi ruang yang tersedia tanpa distorsi. Layout yang awalnya 'column' diubah menjadi 'lastView' agar tampilan bisa di scroll saat layar perangkat terlalu kecil untuk menampilkan semua sekaligus.
