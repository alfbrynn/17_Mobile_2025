void main() {
  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 1,
    'Nama': 'Muhammad Alif Febriansyah',
    'NIM': '2341720025',
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 2,
    'Nama': 'Muhammad Alif Febriansyah',
    'NIM': '2341720025',
  };

  var mhs1 = Map<String, String>();

  mhs1['Nama'] = 'Muhammad Alif Febriansyah';
  mhs1['NIM'] = '2341720025';

  var mhs2 = Map<int, String>();
  mhs2[1] = 'Muhammad Alif Febriansyah';
  mhs2[2] = '2341720025';

  print(gifts);
  print(nobleGases);
  print(mhs1);
  print(mhs2);
}
