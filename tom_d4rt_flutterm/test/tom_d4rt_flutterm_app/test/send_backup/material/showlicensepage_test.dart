import 'package:flutter/material.dart';

/// Deep visual demo for showLicensePage function.
/// Shows an application licenses page.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showLicensePage()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 140,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              height: 35,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 14),
                  SizedBox(width: 8),
                  Text('Licenses', style: TextStyle(color: Colors.white, fontSize: 11)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: const [
                  _LicenseItem('flutter', '3'),
                  _LicenseItem('cupertino_icons', '1'),
                  _LicenseItem('material_color_utilities', '2'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('applicationName, applicationVersion', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _LicenseItem extends StatelessWidget {
  final String name;
  final String count;
  const _LicenseItem(this.name, this.count);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontSize: 10))),
          Text('\$count licenses', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
