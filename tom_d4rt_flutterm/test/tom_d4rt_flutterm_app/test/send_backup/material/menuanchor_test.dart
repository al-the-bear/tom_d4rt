import 'package:flutter/material.dart';

/// Deep visual demo for MenuAnchor widget.
/// Anchors a menu to any widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuAnchor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Stack(
        clipBehavior: Clip.none,
        children: [
          // Anchor button
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Options', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          // Menu
          Positioned(
            top: 50,
            left: 0,
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(padding: EdgeInsets.all(8), child: Text('Edit', style: TextStyle(fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Delete', style: TextStyle(fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Share', style: TextStyle(fontSize: 12))),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 80),
      const Text('Positions menu relative to child', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
