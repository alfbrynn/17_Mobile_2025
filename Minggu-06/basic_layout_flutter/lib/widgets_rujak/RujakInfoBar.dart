import 'package:flutter/material.dart';

/// Widget untuk bar info (Prep, Cook, Feeds)
class RujakInfoBar extends StatelessWidget {
  const RujakInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        InfoColumn(icon: Icons.kitchen, label: 'PREP:', value: '25 min'),
        InfoColumn(icon: Icons.timer, label: 'COOK:', value: '1 hr'),
        InfoColumn(icon: Icons.restaurant, label: 'FEEDS:', value: '4–6'),
      ],
    );
  }
}

/// Kolom kecil dalam info bar: ikon + label + nilai
class InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.green[500]),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
