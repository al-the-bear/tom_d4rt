import 'package:flutter/material.dart';

/// Deep visual demo for TooltipState class.
/// State class managing tooltip visibility.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TooltipState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('TooltipState methods', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MethodBox('.ensureTooltipVisible()', Icons.visibility),
                const SizedBox(width: 8),
                _MethodBox('.controller', Icons.settings_remote),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          Positioned(
            top: -30,
            left: -20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
              child: const Text('Tooltip text', style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    ],
  );
}

class _MethodBox extends StatelessWidget {
  final String method;
  final IconData icon;
  const _MethodBox(this.method, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 18),
          const SizedBox(height: 4),
          Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
        ],
      ),
    );
  }
}
