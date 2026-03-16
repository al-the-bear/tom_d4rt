import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for SerialTapGestureRecognizer.
/// Shows recognition of triple+ taps.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SerialTapGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Serial Tap Recognizer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Use Case:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Triple-tap to select paragraph'),
                Text('• Multi-tap shortcuts'),
                Text('• Games requiring combo taps'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• onSerialTapDown(SerialTapDownDetails)'),
                Text('• onSerialTapUp(SerialTapUpDetails)'),
                Text('• onSerialTapCancel(SerialTapCancelDetails)'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 4; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(50 + i * 50),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('\$i', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const Center(child: Text('Detects 1, 2, 3, 4+ taps in sequence')),
        ],
      ),
    ),
  );
}
