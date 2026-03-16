import 'package:flutter/material.dart';

/// Deep visual demo for TextTheme class.
/// Collection of TextStyles for Material typography.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TextStyleRow('displayLarge', 57, FontWeight.w400),
            _TextStyleRow('headlineMedium', 28, FontWeight.w400),
            _TextStyleRow('titleLarge', 22, FontWeight.w500),
            _TextStyleRow('bodyLarge', 16, FontWeight.w400),
            _TextStyleRow('labelSmall', 11, FontWeight.w500),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Theme.of(context).textTheme', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TextStyleRow extends StatelessWidget {
  final String name;
  final double size;
  final FontWeight weight;
  const _TextStyleRow(this.name, this.size, this.weight);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 9))),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text('${size.toInt()}', style: const TextStyle(fontSize: 9, color: Colors.grey)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(2)),
            child: Text('Sample', style: TextStyle(fontSize: size.clamp(10, 16).toDouble(), fontWeight: weight)),
          ),
        ],
      ),
    );
  }
}
