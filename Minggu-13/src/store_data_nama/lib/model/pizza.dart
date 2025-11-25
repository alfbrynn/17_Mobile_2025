class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: int.tryParse(json['id'].toString()) ?? 0, // Langkah 3
      pizzaName: json['pizzaName'] != null
          ? json['pizzaName'].toString()
          : 'No name', // Langkah 10
      description: json['description']?.toString() ?? '', // Langkah 5 & 10
      price: double.tryParse(json['price'].toString()) ?? 0, // Langkah 8
      imageUrl: json['imageUrl']?.toString() ?? '', // Langkah 5
    );
  }
}
