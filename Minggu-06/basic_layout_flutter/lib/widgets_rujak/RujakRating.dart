import 'package:flutter/material.dart';

class RujakRating extends StatelessWidget {
  const RujakRating({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Ambil lebar layar dari parent
        double screenWidth = constraints.maxWidth;

        // Tentukan ukuran icon dan teks proporsional
        double iconSize = screenWidth * 0.05; // 5% dari lebar layar
        double fontSize = screenWidth * 0.035; // 3.5% dari lebar layar

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < 3 ? Colors.red[500] : Colors.grey,
                  size: iconSize.clamp(
                    14,
                    28,
                  ), // biar tidak terlalu kecil/besar
                );
              }),
            ),
            const SizedBox(width: 8),
            Text(
              '170 Reviews',
              style: TextStyle(fontSize: fontSize.clamp(12, 20)),
            ),
          ],
        );
      },
    );
  }
}
