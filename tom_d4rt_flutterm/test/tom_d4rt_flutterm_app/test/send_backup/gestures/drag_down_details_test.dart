import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DragDownDetails.
/// Shows details of initial drag touch point.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DragDownDetails')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drag Down Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange)),
            child: Stack(children: [
              const Positioned(left: 100, top: 80, child: Icon(Icons.touch_app, size: 40, color: Colors.orange)),
              Positioned(left: 130, top: 85, child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('globalPosition:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text('(116.0, 96.0)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  SizedBox(height: 4),
                  Text('localPosition:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text('(100.0, 80.0)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                ]),
              )),
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
                Text('• globalPosition - screen coordinates'),
                Text('• localPosition - widget-relative coordinates'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
