import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final baselineSpan = WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: const Icon(Icons.star, size: 18, color: Colors.orange),
  );
  final middleSpan = WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: const Icon(Icons.circle, size: 14, color: Colors.blue),
  );

  final text = TextSpan(
    text: 'A',
    style: const TextStyle(color: Colors.black, fontSize: 18),
    children: [
      baselineSpan,
      const TextSpan(text: 'B'),
      middleSpan,
    ],
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PlaceholderSpan Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RichText(text: text),
        const SizedBox(height: 8),
        Text('Baseline alignment: ${baselineSpan.alignment.name}'),
        Text('Middle alignment: ${middleSpan.alignment.name}'),
        Text('Children: ${text.children?.length ?? 0}'),
      ],
    ),
  );
}
