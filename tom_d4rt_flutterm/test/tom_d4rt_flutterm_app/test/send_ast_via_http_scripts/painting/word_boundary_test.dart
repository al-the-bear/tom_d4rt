import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const sample = 'Hello world\nSecond line';
  final painter = TextPainter(
    text: const TextSpan(text: sample, style: TextStyle(fontSize: 18, color: Colors.black)),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: 320);

  final boundary = painter.wordBoundaries;
  final positions = <int>[0, 1, 6, 12, 18];
  final ranges = positions.map(boundary.getTextBoundaryAt).toList();

  String slice(TextRange r) => sample.substring(r.start, r.end).replaceAll('\n', '\\n');

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('WordBoundary Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(8)),
          child: const Text(sample, style: TextStyle(fontSize: 18)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < ranges.length; i++)
              Chip(label: Text('p${positions[i]}: "${slice(ranges[i])}" ${ranges[i]}')),
          ],
        ),
      ],
    ),
  );
}