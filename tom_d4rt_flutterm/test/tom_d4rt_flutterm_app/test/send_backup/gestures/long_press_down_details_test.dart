import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for LongPressDownDetails.
/// Shows details when long press starts.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('LongPressDownDetails')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Long Press Down Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.purple)),
            child: Stack(children: [
              const Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.touch_app, size: 48, color: Colors.purple),
                  SizedBox(height: 8),
                  Text('Press and Hold', style: TextStyle(color: Colors.purple)),
                ]),
              ),
              Positioned(
                right: 16, top: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('globalPosition:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('(150, 200)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  ]),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• globalPosition - screen-relative touch point'),
                Text('• localPosition - widget-relative touch point'),
                Text('• kind - pointer device kind'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
