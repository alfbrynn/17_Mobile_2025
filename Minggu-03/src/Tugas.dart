void main() {
  for (int i = 0; i <= 201; i++) {
    if (isPrime(i)) {
      print('$i adalah bilangan prima');
      print('Nama: Muhammad Alif Febriansyah');
      print('NIM: 2341720025');
    }
  }
}

bool isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}
