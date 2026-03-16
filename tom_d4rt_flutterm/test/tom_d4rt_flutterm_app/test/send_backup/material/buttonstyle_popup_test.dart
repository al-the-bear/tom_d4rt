import 'package:flutter/material.dart';

/// Deep visual demo for ButtonStyle with popup.
/// Shows styled popup menu button.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('ButtonStyle Popup'),
      actions: [
        PopupMenuButton<String>(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          onSelected: (v) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected: ' + v))),
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(Icons.edit), title: Text('Edit'))),
            const PopupMenuItem(value: 'delete', child: ListTile(leading: Icon(Icons.delete), title: Text('Delete'))),
            const PopupMenuItem(value: 'share', child: ListTile(leading: Icon(Icons.share), title: Text('Share'))),
          ],
        ),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.more_vert, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Styled PopupMenuButton'),
          const SizedBox(height: 8),
          const Text('Check AppBar menu →', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          PopupMenuButton<String>(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(mainAxisSize: MainAxisSize.min, children: [Text('Options'), Icon(Icons.arrow_drop_down)]),
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'a', child: Text('Option A')),
              const PopupMenuItem(value: 'b', child: Text('Option B')),
            ],
          ),
        ],
      ),
    ),
  );
}
