import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  final data = TextParentData();
  const span = WidgetSpan(child: Text('inline-child'));
  data.span = span;
  final beforeDetach = data.span != null;
  data.detach();
  final afterDetach = data.span == null;

  Widget statusTile(String label, bool ok) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ok ? Colors.green.withAlpha(28) : Colors.red.withAlpha(28),
        border: Border.all(color: ok ? Colors.green : Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(ok ? Icons.check_circle : Icons.error, color: ok ? Colors.green : Colors.red, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextParentData Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        statusTile('Before detach: span assigned', beforeDetach),
        const SizedBox(height: 8),
        statusTile('After detach: span cleared', afterDetach),
        const SizedBox(height: 8),
        Text('Offset: ${data.offset}'),
        Text('Type: ${data.runtimeType}'),
      ],
    ),
  );
}