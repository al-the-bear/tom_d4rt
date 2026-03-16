import 'package:flutter/material.dart';

/// Deep visual demo for SimpleDialogOption widget.
/// A simple option item for SimpleDialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SimpleDialogOption', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Select an option', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            _DialogOption('Option 1', true),
            _DialogOption('Option 2', false),
            _DialogOption('Option 3', false),
            const SizedBox(height: 8),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('onPressed, padding, child', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DialogOption extends StatelessWidget {
  final String text;
  final bool highlighted;
  const _DialogOption(this.text, this.highlighted);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: highlighted ? Colors.blue.shade50 : null,
      child: Text(text, style: TextStyle(fontSize: 11, color: highlighted ? Colors.blue : null)),
    );
  }
}
