// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const sections = <Map<String, String>>[
    {'type': 'ListView', 'usage': 'Linear content with lazily built children.'},
    {
      'type': 'GridView',
      'usage': 'Two-dimensional tile layouts with scroll behavior.',
    },
    {
      'type': 'CustomScrollView',
      'usage': 'Composed slivers with advanced layout control.',
    },
    {
      'type': 'SingleChildScrollView',
      'usage': 'Simple overflow handling for one child subtree.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollView')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.3,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final item = sections[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['type']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(item['usage']!),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
