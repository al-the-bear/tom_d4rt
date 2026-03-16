import 'package:flutter/material.dart';

/// Deep visual demo for Switch.adaptive constructor.
/// Platform-adaptive switch appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Switch.adaptive', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SwitchVariant('Material', true),
          const SizedBox(width: 24),
          _SwitchVariant('iOS', false),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Adapts to platform automatically', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _SwitchVariant extends StatelessWidget {
  final String platform;
  final bool isMaterial;
  const _SwitchVariant(this.platform, this.isMaterial);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(platform, style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 8),
        if (isMaterial)
          Container(
            width: 52,
            height: 32,
            decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(4),
            alignment: Alignment.centerRight,
            child: Container(width: 24, height: 24, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          )
        else
          Container(
            width: 52,
            height: 32,
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(2),
            alignment: Alignment.centerRight,
            child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)])),
          ),
      ],
    );
  }
}
