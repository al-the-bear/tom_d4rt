import 'package:flutter/material.dart';

/// Deep visual demo for MaterialLocalizations.
/// Provides localized strings for Material widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialLocalizations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(Icons.translate, color: Colors.green, size: 32),
            const SizedBox(height: 8),
            _LocaleExample('okButtonLabel', 'OK'),
            _LocaleExample('cancelButtonLabel', 'Cancel'),
            _LocaleExample('openAppDrawer', 'Open navigation menu'),
            _LocaleExample('backButtonTooltip', 'Back'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('MaterialLocalizations.of(context)', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
    ],
  );
}

class _LocaleExample extends StatelessWidget {
  final String method;
  final String value;
  const _LocaleExample(this.method, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(method, style: const TextStyle(fontSize: 9, fontFamily: 'monospace'))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text(value, style: const TextStyle(fontSize: 9)),
          ),
        ],
      ),
    );
  }
}
