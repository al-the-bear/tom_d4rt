import 'package:flutter/material.dart';

/// Deep visual demo for ListTileControlAffinity enum.
/// Controls where checkbox/switch/radio appears in ListTile.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListTileControlAffinity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _AffinityPreview('leading', true, false),
      const SizedBox(height: 8),
      _AffinityPreview('trailing', false, true),
      const SizedBox(height: 8),
      _AffinityPreview('platform', true, false, isPlatform: true),
      const SizedBox(height: 12),
      const Text('Used with CheckboxListTile, SwitchListTile', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _AffinityPreview extends StatelessWidget {
  final String label;
  final bool leading;
  final bool trailing;
  final bool isPlatform;
  const _AffinityPreview(this.label, this.leading, this.trailing, {this.isPlatform = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          if (leading) Container(
            width: 20, height: 20,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
          if (leading) const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          if (trailing) Container(
            width: 20, height: 20,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
          if (isPlatform) const Text(' (default)', style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    );
  }
}
