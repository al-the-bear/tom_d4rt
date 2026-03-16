import 'package:flutter/material.dart';

/// Deep visual demo for advanced Scaffold features.
/// Drawers, persistent bottom sheets, FAB locations.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Advanced Scaffold Features', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 160,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Main content
              Container(color: Colors.grey.shade100, child: const Center(child: Text('Body', style: TextStyle(color: Colors.grey)))),
              // Left drawer
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 60,
                  color: Colors.blue.shade100,
                  child: const Column(
                    children: [
                      SizedBox(height: 8),
                      Icon(Icons.menu, size: 18),
                      Text('Drawer', style: TextStyle(fontSize: 8)),
                    ],
                  ),
                ),
              ),
              // AppBar
              Positioned(
                top: 0,
                left: 60,
                right: 0,
                child: Container(
                  height: 30,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
              // Bottom sheet
              Positioned(
                bottom: 0,
                left: 60,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
                  ),
                  alignment: Alignment.center,
                  child: const Text('Bottom Sheet', style: TextStyle(fontSize: 9)),
                ),
              ),
              // FAB
              Positioned(
                right: 8,
                bottom: 48,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
