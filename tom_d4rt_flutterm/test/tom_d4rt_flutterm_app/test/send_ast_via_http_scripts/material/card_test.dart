import 'package:flutter/material.dart';

/// Deep visual demo for Card.
/// Shows card widget variations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Card')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Card Variations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Card(child: ListTile(title: Text('Default Card'), subtitle: Text('With ListTile content'))),
        const SizedBox(height: 8),
        Card(
          elevation: 8,
          child: const Padding(padding: EdgeInsets.all(16), child: Text('Elevated Card (elevation: 8)')),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: Colors.blue.shade50,
          child: const Padding(padding: EdgeInsets.all(16), child: Text('Flat colored card')),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.blue, width: 2),
          ),
          child: const Padding(padding: EdgeInsets.all(16), child: Text('Bordered rounded card')),
        ),
        const SizedBox(height: 8),
        Card.filled(child: const Padding(padding: EdgeInsets.all(16), child: Text('Card.filled()'))),
        const SizedBox(height: 8),
        Card.outlined(child: const Padding(padding: EdgeInsets.all(16), child: Text('Card.outlined()'))),
      ],
    ),
  );
}
