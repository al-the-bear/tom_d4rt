import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldMessengerState.
/// State class that manages SnackBars and MaterialBanners.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldMessengerState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('ScaffoldMessenger.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MethodChip('.showSnackBar()'),
                _MethodChip('.hideCurrentSnackBar()'),
                _MethodChip('.removeCurrentSnackBar()'),
                _MethodChip('.clearSnackBars()'),
                _MethodChip('.showMaterialBanner()'),
                _MethodChip('.clearMaterialBanners()'),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Manages notifications across routes', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MethodChip extends StatelessWidget {
  final String method;
  const _MethodChip(this.method);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
    );
  }
}
