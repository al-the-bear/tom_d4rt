import 'package:flutter/material.dart';

/// Deep visual demo for LicensePage widget.
/// Shows page displaying open-source licenses.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('LicensePage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // App bar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text('Licenses', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // License entries
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _LicenseEntry('flutter', '3 licenses'),
                  _LicenseEntry('collection', '1 license'),
                  _LicenseEntry('meta', '1 license'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Shows package licenses', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _LicenseEntry extends StatelessWidget {
  final String pkg;
  final String count;
  const _LicenseEntry(this.pkg, this.count);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.description, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(pkg, style: const TextStyle(fontSize: 12))),
          Text(count, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
