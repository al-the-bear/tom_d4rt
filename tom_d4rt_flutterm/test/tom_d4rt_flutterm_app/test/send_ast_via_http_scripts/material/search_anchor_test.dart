import 'package:flutter/material.dart';

/// Deep visual demo for SearchAnchor widget.
/// Manages connection between search bar and search view.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SearchAnchor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(24)),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey, size: 18),
            SizedBox(width: 8),
            Text('Search...', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Icon(Icons.arrow_downward, color: Colors.grey, size: 16),
      const SizedBox(height: 8),
      Container(
        width: 200,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Container(height: 20, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)))),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(8), child: Text('Search suggestions...', style: TextStyle(fontSize: 10, color: Colors.grey))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('builder, suggestionsBuilder', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
