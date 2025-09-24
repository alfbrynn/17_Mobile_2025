void main() {
  var names1 = <String>{};
  Set<String> names2 = {};
  var names3 = {}; // Ini akan dianggap sebagai Map, bukan Set

  print(names1); // Output: {}
  print(names2); // Output: {}
  print(names3); // Output: {}

  // Menambahkan elemen ke Set
  names1.add('Muhammad Alif Febriansyah');
  names2.addAll(['2341720025']);

  print(names1);
  print(names2);
}
