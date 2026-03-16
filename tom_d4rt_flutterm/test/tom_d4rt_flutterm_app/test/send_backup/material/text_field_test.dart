import 'package:flutter/material.dart';

/// Deep visual demo for TextField widget.
/// Material text input field.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _FieldDemo('Default', null, false),
      const SizedBox(height: 12),
      _FieldDemo('With Label', 'Email', false),
      const SizedBox(height: 12),
      _FieldDemo('Error', 'Password', true),
      const SizedBox(height: 12),
      const Text('decoration, controller, onChanged', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _FieldDemo extends StatelessWidget {
  final String label;
  final String? fieldLabel;
  final bool hasError;
  const _FieldDemo(this.label, this.fieldLabel, this.hasError);
  @override
  Widget build(BuildContext context) {
    final borderColor = hasError ? Colors.red : Colors.blue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        const SizedBox(height: 2),
        Container(
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fieldLabel != null) Text(fieldLabel!, style: TextStyle(fontSize: 9, color: borderColor)),
              const Text('Input text', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        if (hasError) const Text('Required field', style: TextStyle(fontSize: 9, color: Colors.red)),
      ],
    );
  }
}
