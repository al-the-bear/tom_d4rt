import 'package:flutter/material.dart';

/// Deep visual demo for FlexibleSpaceBarSettings.
/// Shows settings that control FlexibleSpaceBar behavior.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FlexibleSpaceBarSettings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 240,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Settings:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            _SettingRow('toolbarOpacity', '1.0'),
            _SettingRow('minExtent', '56.0'),
            _SettingRow('maxExtent', '200.0'),
            _SettingRow('currentExtent', '120.0'),
            _SettingRow('isScrolledUnder', 'true'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
        child: const Text('InheritedWidget passing scroll info', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _SettingRow extends StatelessWidget {
  final String name;
  final String value;
  const _SettingRow(this.name, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text(value, style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
