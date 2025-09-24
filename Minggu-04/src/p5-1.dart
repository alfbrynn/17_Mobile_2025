void main() {
  var record = ('first', a: 2, b: true, 'last');
  print(record);

  (int, int) tukar((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }

  var hasil = tukar((10, 20));
  print(hasil); // Output: (20, 10)

  (String, int) mahasiswa = ('Alif', 2341720025);
  print(mahasiswa);

  var mahasiswa2 = ('Alif', a: 225100123, b: true, 'Febriansyah');
  print(mahasiswa2.$1); // Output: 'Alif'
  print(mahasiswa2.a); // Output: 225100123
  print(mahasiswa2.b); // Output: true
  print(mahasiswa2.$2); // Output: 'Febriansyah'
}
