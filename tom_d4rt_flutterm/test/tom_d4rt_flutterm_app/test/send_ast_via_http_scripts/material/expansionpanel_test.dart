import 'package:flutter/material.dart';

/// Deep visual demo for ExpansionPanelList - list of expandable panels.
/// Shows multiple panels that can expand/collapse independently.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ExpansionPanelList Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            _ExpansionTile('Personal Info', true),
            const Divider(height: 1),
            _ExpansionTile('Contact Details', false),
            const Divider(height: 1),
            _ExpansionTile('Preferences', false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Manages list of ExpansionPanels', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ExpansionTile extends StatelessWidget {
  final String title;
  final bool expanded;
  const _ExpansionTile(this.title, this.expanded);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: expanded ? Colors.blue.shade50 : Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Icon(expanded ? Icons.expand_less : Icons.expand_more)]),
          if (expanded) ...[const SizedBox(height: 8), const Text('Panel content goes here...', style: TextStyle(fontSize: 11))]
        ],
      ),
    );
  }
}
