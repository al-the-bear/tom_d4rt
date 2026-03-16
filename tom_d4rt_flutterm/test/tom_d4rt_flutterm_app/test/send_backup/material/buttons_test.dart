import 'package:flutter/material.dart';

/// Deep visual demo for OutlinedButton.
/// Shows outlined button customization.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OutlinedButton')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('OutlinedButton Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        OutlinedButton(onPressed: () {}, child: const Text('Default')),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('With Icon')),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple, width: 2),
            foregroundColor: Colors.deepPurple,
          ),
          onPressed: () {},
          child: const Text('Custom Border'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {},
          child: const Text('Rounded'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(onPressed: null, child: const Text('Disabled')),
        const SizedBox(height: 24),
        const Text('Use for secondary actions', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}
