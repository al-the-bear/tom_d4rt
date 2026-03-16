import 'package:flutter/material.dart';

/// Deep visual demo for Badge.
/// Shows notification badges on icons.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Badge')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Badge Examples', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Badge(label: const Text('3'), child: Icon(Icons.mail, size: 36)),
                const SizedBox(height: 8),
                const Text('With count'),
              ]),
              Column(children: [
                Badge(child: Icon(Icons.notifications, size: 36)),
                const SizedBox(height: 8),
                const Text('Dot only'),
              ]),
              Column(children: [
                Badge(label: const Text('99+'), child: Icon(Icons.shopping_cart, size: 36)),
                const SizedBox(height: 8),
                const Text('Large count'),
              ]),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Custom Badges', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(
                backgroundColor: Colors.green,
                label: const Text('NEW'),
                child: const Icon(Icons.star, size: 36, color: Colors.amber),
              ),
              Badge(
                backgroundColor: Colors.red,
                label: const Text('!'),
                child: const Icon(Icons.warning, size: 36, color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
