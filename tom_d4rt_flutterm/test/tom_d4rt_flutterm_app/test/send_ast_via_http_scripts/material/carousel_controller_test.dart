// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for CarouselController.
/// Shows carousel view controller.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CarouselController')),
    body: Center(child: _CarouselDemo()),
  );
}

class _CarouselDemo extends StatefulWidget {
  @override
  State<_CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<_CarouselDemo> {
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'CarouselController Demo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Swipe or use buttons to navigate'),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: CarouselView(
            controller: _controller,
            itemExtent: 280,
            shrinkExtent: 200,
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.primaries[i * 3 % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Page ' + (i + 1).toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () => _controller.animateTo(
                _controller.position.pixels - 280,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Prev'),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: () => _controller.animateTo(
                _controller.position.pixels + 280,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
