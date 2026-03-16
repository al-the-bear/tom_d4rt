import 'package:flutter/material.dart';

/// Deep visual demo for RadioListTile widget.
/// ListTile with leading/trailing Radio.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RadioListTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            _RadioTile('Small', true),
            const Divider(height: 1),
            _RadioTile('Medium', false),
            const Divider(height: 1),
            _RadioTile('Large', false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('value, groupValue, onChanged', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _RadioTile extends StatelessWidget {
  final String label;
  final bool selected;
  const _RadioTile(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: selected ? Colors.blue : Colors.grey, width: 2)),
            child: selected ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))) : null,
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
