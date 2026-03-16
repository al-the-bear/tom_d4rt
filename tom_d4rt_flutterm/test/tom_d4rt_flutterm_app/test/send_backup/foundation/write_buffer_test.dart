import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for WriteBuffer - binary data serialization.
/// Shows writing typed values to byte buffer.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('WriteBuffer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Binary Serialization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WriteOp(method: 'putInt32(42)', bytes: '2A 00 00 00'),
                _WriteOp(method: 'putFloat64(3.14159)', bytes: '1F 85 EB 51 B8 1E 09 40'),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                  child: const Text('[2A 00 00 00 1F 85 EB 51 B8 1E 09 40]', style: TextStyle(fontFamily: 'monospace', color: Colors.green, fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Write Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('putInt8, putInt16, putInt32, putInt64'),
                Text('putUint8, putUint16, putUint32, putUint64'),
                Text('putFloat64, putUint8List'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _WriteOp extends StatelessWidget {
  final String method;
  final String bytes;
  const _WriteOp({required this.method, required this.bytes});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
          child: Text(method, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 11)),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.arrow_forward, size: 16),
        const SizedBox(width: 8),
        Text(bytes, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ]),
    );
  }
}
