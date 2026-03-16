import 'package:flutter/material.dart';

/// Deep visual demo for CarouselView.
/// Shows carousel widget for scrollable items.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CarouselView')),
    body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Featured Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 220,
          child: CarouselView(
            itemExtent: 300,
            shrinkExtent: 240,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            children: [
              _CarouselItem('Featured 1', Colors.blue, Icons.star),
              _CarouselItem('Featured 2', Colors.green, Icons.favorite),
              _CarouselItem('Featured 3', Colors.orange, Icons.bolt),
              _CarouselItem('Featured 4', Colors.purple, Icons.rocket),
              _CarouselItem('Featured 5', Colors.teal, Icons.diamond),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Properties: itemExtent, shrinkExtent, elevation, shape, onTap', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ],
    ),
  );
}

class _CarouselItem extends StatelessWidget {
  final String title; final Color color; final IconData icon;
  const _CarouselItem(this.title, this.color, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(gradient: LinearGradient(colors: [color, color.withAlpha(180)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon, size: 48, color: Colors.white), const SizedBox(height: 16), Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
    ),
  );
}
