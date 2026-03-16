import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for LicenseEntry - software license information.
/// Shows how licenses are registered and displayed in app.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('LicenseEntry Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('License Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _LicenseCard(package: 'flutter', license: 'BSD-3-Clause', color: Colors.blue),
          _LicenseCard(package: 'cupertino_icons', license: 'MIT', color: Colors.green),
          _LicenseCard(package: 'collection', license: 'BSD-3-Clause', color: Colors.orange),
          _LicenseCard(package: 'vector_math', license: 'BSD-2-Clause', color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('License Registry:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• LicenseRegistry.addLicense() - register'),
                Text('• LicenseRegistry.licenses - stream'),
                Text('• showLicensePage() - display in app'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _LicenseCard extends StatelessWidget {
  final String package;
  final String license;
  final Color color;
  const _LicenseCard({required this.package, required this.license, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Row(
        children: [
          Icon(Icons.article, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(package, style: const TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text(license, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
