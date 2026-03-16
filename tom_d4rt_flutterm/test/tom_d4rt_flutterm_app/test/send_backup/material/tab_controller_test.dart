import 'package:flutter/material.dart';

/// Deep visual demo for TabController class.
/// Controller for TabBar and TabBarView.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('with TickerProviderStateMixin', style: TextStyle(fontFamily: 'monospace', fontSize: 9, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PropBox('length', '3'),
                const SizedBox(width: 8),
                _PropBox('index', '1'),
                const SizedBox(width: 8),
                _PropBox('animation', '1.0'),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: [
                _MethodChip('.animateTo()'),
                _MethodChip('.offset'),
                _MethodChip('.addListener()'),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Coordinates TabBar and TabBarView', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PropBox extends StatelessWidget {
  final String name;
  final String value;
  const _PropBox(this.name, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontSize: 8, color: Colors.grey)),
          Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MethodChip extends StatelessWidget {
  final String method;
  const _MethodChip(this.method);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
    );
  }
}
