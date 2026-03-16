import 'package:flutter/material.dart';

/// Deep visual demo for CircleAvatar.
/// Shows circular avatar variations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CircleAvatar')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('CircleAvatar Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              CircleAvatar(backgroundColor: Colors.blue, child: const Text('AB')),
              const SizedBox(height: 8),
              const Text('Initials'),
            ]),
            Column(children: [
              CircleAvatar(backgroundColor: Colors.green, child: const Icon(Icons.person)),
              const SizedBox(height: 8),
              const Text('Icon'),
            ]),
            Column(children: [
              CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/100')),
              const SizedBox(height: 8),
              const Text('Image'),
            ]),
          ],
        ),
        const SizedBox(height: 32),
        const Text('Sizes:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(children: [
              CircleAvatar(radius: 16, backgroundColor: Colors.purple, child: const Text('S', style: TextStyle(fontSize: 12))),
              const SizedBox(height: 4),
              const Text('Small', style: TextStyle(fontSize: 10)),
            ]),
            Column(children: [
              CircleAvatar(radius: 24, backgroundColor: Colors.purple, child: const Text('M')),
              const SizedBox(height: 4),
              const Text('Medium', style: TextStyle(fontSize: 10)),
            ]),
            Column(children: [
              CircleAvatar(radius: 36, backgroundColor: Colors.purple, child: const Text('L', style: TextStyle(fontSize: 20))),
              const SizedBox(height: 4),
              const Text('Large', style: TextStyle(fontSize: 10)),
            ]),
          ],
        ),
        const SizedBox(height: 24),
        const ListTile(
          leading: CircleAvatar(backgroundColor: Colors.orange, child: Text('JD')),
          title: Text('John Doe'),
          subtitle: Text('john.doe@example.com'),
        ),
      ],
    ),
  );
}
