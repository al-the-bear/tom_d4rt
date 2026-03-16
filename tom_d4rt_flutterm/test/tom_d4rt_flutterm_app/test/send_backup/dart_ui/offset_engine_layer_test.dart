import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for OffsetEngineLayer - offset transformation layer.
/// Demonstrates translating child layers by an offset.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OffsetEngineLayer Demo')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Offset Engine Layer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Stack(
            children: [
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: Colors.grey.shade100),
                child: const Center(child: Text('Parent Bounds', textAlign: TextAlign.center)),
              ),
              Positioned(
                left: 50, top: 50,
                child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(8)),
                  child: const Center(child: Text('Offset (50, 50)', style: TextStyle(color: Colors.white), textAlign: TextAlign.center)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('OffsetEngineLayer translates all child layers by a fixed offset.', textAlign: TextAlign.center),
          ),
        ],
      ),
    ),
  );
}
