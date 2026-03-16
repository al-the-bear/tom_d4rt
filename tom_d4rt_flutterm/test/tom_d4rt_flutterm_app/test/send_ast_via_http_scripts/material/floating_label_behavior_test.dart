import 'package:flutter/material.dart';

/// Deep visual demo for FloatingLabelBehavior.
/// Shows when/how labels float above input fields.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FloatingLabelBehavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BehaviorPreview('auto', 'Floats on\nfocus/input'),
          _BehaviorPreview('always', 'Always\nfloating'),
          _BehaviorPreview('never', 'Never\nfloats'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Controls label floating behavior', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _BehaviorPreview extends StatelessWidget {
  final String type;
  final String desc;
  const _BehaviorPreview(this.type, this.desc);
  @override
  Widget build(BuildContext context) {
    final isFloating = type != 'never';
    return Column(
      children: [
        Container(
          width: 70,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFloating) Text('Label', style: TextStyle(fontSize: 9, color: Colors.blue.shade700)),
              const Spacer(),
              Text(isFloating ? 'Text' : 'Label', style: TextStyle(fontSize: 11, color: isFloating ? Colors.black : Colors.grey)),
              Container(height: 1, color: Colors.grey.shade400),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      ],
    );
  }
}
