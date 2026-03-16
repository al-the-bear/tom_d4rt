import 'package:flutter/material.dart';

/// Deep visual demo for Switch widget.
/// Material Design switch toggle.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Switch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SwitchDemo('Off', false, false),
          const SizedBox(width: 16),
          _SwitchDemo('On', true, false),
          const SizedBox(width: 16),
          _SwitchDemo('Disabled', false, true),
        ],
      ),
      const SizedBox(height: 16),
      const Text('With thumb icon:', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 8),
      Container(
        width: 52,
        height: 32,
        decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.centerRight,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 14, color: Colors.green),
        ),
      ),
      const SizedBox(height: 12),
      const Text('value, onChanged, activeColor, thumbIcon', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _SwitchDemo extends StatelessWidget {
  final String label;
  final bool isOn;
  final bool disabled;
  const _SwitchDemo(this.label, this.isOn, this.disabled);
  @override
  Widget build(BuildContext context) {
    final trackColor = disabled ? Colors.grey.shade300 : isOn ? Colors.blue.shade600 : Colors.grey.shade400;
    final thumbColor = disabled ? Colors.grey.shade400 : Colors.white;
    return Column(
      children: [
        Container(
          width: 44,
          height: 26,
          decoration: BoxDecoration(color: trackColor, borderRadius: BorderRadius.circular(13)),
          padding: const EdgeInsets.all(3),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(width: 20, height: 20, decoration: BoxDecoration(color: thumbColor, shape: BoxShape.circle)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
