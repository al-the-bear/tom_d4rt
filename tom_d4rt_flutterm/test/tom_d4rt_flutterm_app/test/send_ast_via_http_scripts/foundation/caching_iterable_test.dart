// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for CachingIterable - lazily caches iterable elements.
/// Shows how elements are computed once and cached for repeated access.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CachingIterable Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lazy Caching Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cache State:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    for (int i = 0; i < 8; i++)
                      Expanded(
                        child: _CacheSlot(
                          index: i,
                          isCached: i < 5,
                          value: i < 5 ? '\${i * 10}' : '?',
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Benefits:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Elements computed only when accessed'),
                Text('• Cached values reused on repeat access'),
                Text('• Memory efficient for large iterables'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _CacheSlot extends StatelessWidget {
  final int index;
  final bool isCached;
  final String value;
  const _CacheSlot({
    required this.index,
    required this.isCached,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCached ? Colors.green.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isCached ? Colors.green : Colors.grey),
      ),
      child: Column(
        children: [
          Text(
            '[\$index]',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Icon(
            isCached ? Icons.check_circle : Icons.hourglass_empty,
            size: 16,
            color: isCached ? Colors.green : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCached ? Colors.green.shade700 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
