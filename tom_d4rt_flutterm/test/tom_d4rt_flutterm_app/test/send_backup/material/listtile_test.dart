import 'package:flutter/material.dart';

/// Deep visual demo for ListTile widget.
/// Shows the standard Material list item.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // Standard ListTile
            _ListTilePreview(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: 'John Doe',
              subtitle: 'john@example.com',
              trailing: const Icon(Icons.chevron_right),
            ),
            const Divider(height: 1),
            // With badge
            _ListTilePreview(
              leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.message, color: Colors.white)),
              title: 'Messages',
              subtitle: '3 unread',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('leading, title, subtitle, trailing', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ListTilePreview extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  const _ListTilePreview({this.leading, required this.title, this.subtitle, this.trailing});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (leading != null) leading!,
          if (leading != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
