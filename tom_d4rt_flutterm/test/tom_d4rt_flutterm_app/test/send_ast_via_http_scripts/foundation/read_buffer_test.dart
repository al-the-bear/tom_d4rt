import 'package:flutter/material.dart';

/// Deep visual demo for ReadBuffer - binary data deserialization.
/// Shows reading typed values from byte buffer.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ReadBuffer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Binary Deserialization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                const Text(
                  'Buffer: [2A 00 00 00 1F 85 EB 51 B8 1E 09 40]',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
                const SizedBox(height: 16),
                _ReadOp(method: 'getInt32()', result: '42', bytes: '4'),
                _ReadOp(method: 'getFloat64()', result: '3.14159', bytes: '8'),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Position: 12 bytes',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11),
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
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Read Methods:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('getInt8, getInt16, getInt32, getInt64'),
                Text('getUint8, getUint16, getUint32, getUint64'),
                Text('getFloat64, getUint8List'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ReadOp extends StatelessWidget {
  final String method;
  final String result;
  final String bytes;
  const _ReadOp({
    required this.method,
    required this.result,
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
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              method,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward, size: 16),
          const SizedBox(width: 8),
          Text(result, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(
            '(\$bytes bytes)',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
