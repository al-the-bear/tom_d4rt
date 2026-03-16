import 'package:flutter/material.dart';

/// Deep visual demo for CarouselViewTheme.
/// Shows inherited carousel theme widget.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CarouselViewTheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('CarouselViewTheme Widget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Provides theme data to descendant CarouselView widgets'),
        const SizedBox(height: 24),
        const Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Text(
            'CarouselViewTheme(\n  data: CarouselViewThemeData(...),\n  child: CarouselView(...),\n)',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 140,
          child: CarouselView(
            itemExtent: 180,
            children: [
              for (var c in [Colors.red, Colors.green, Colors.blue, Colors.orange])
                Container(color: c, alignment: Alignment.center, child: const Icon(Icons.image, color: Colors.white, size: 40)),
            ],
          ),
        ),
      ],
    ),
  );
}
