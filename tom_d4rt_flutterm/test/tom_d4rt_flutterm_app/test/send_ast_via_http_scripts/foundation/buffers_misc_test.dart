import 'package:flutter/material.dart';

/// Deep visual demo for buffer utilities - WriteBuffer and ReadBuffer.
/// Shows binary data serialization and deserialization patterns.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Buffer Utilities Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Binary Buffer Operations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.edit_note, color: Colors.teal),
                    SizedBox(width: 8),
                    Text(
                      'WriteBuffer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _BufferOperation(
                  op: 'putInt32',
                  value: '42',
                  bytes: '2A 00 00 00',
                ),
                _BufferOperation(
                  op: 'putFloat64',
                  value: '3.14',
                  bytes: '1F 85 EB 51 B8 1E 09 40',
                ),
                _BufferOperation(
                  op: 'putUint8List',
                  value: '[1,2,3]',
                  bytes: '01 02 03',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.visibility, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'ReadBuffer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _BufferOperation(
                  op: 'getInt32',
                  value: '42',
                  bytes: '2A 00 00 00',
                ),
                _BufferOperation(op: 'getFloat64', value: '3.14', bytes: '...'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _BufferOperation extends StatelessWidget {
  final String op;
  final String value;
  final String bytes;
  const _BufferOperation({
    required this.op,
    required this.value,
    required this.bytes,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              op,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Text('→ \$value'),
          const Spacer(),
          Text(
            bytes,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
