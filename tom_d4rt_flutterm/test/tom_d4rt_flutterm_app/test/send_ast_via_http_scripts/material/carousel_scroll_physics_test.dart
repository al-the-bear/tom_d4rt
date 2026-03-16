import 'package:flutter/material.dart';

/// Deep visual demo for CarouselScrollPhysics.
/// Shows carousel snapping physics.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CarouselScrollPhysics')),
    body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Carousel Scroll Physics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Provides snapping behavior for carousel items'),
            ],
          ),
        ),
        Expanded(
          child: CarouselView(
            itemExtent: 280,
            shrinkExtent: 200,
            children: [
              for (int i = 0; i < 6; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.primaries[i * 2 % Colors.primaries.length], Colors.primaries[(i * 2 + 1) % Colors.primaries.length]],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text('Card ' + (i + 1).toString(), style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade100,
          child: const Text('Swipe and release - items snap to center position', style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}
