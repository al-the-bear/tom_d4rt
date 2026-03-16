import 'package:flutter/material.dart';

/// Deep visual demo for CheckedPopupMenuItem.
/// Shows popup menu with checkmarks.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('CheckedPopupMenuItem'),
      actions: [_FilterMenu()],
    ),
    body: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_list, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('CheckedPopupMenuItem Demo'),
          SizedBox(height: 8),
          Text('Tap filter icon in AppBar →', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}

class _FilterMenu extends StatefulWidget {
  @override
  State<_FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<_FilterMenu> {
  bool _showRead = true;
  bool _showUnread = true;
  bool _showStarred = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: (v) {
        setState(() {
          if (v == 'read') _showRead = !_showRead;
          if (v == 'unread') _showUnread = !_showUnread;
          if (v == 'starred') _showStarred = !_showStarred;
        });
      },
      itemBuilder: (_) => [
        CheckedPopupMenuItem(value: 'read', checked: _showRead, child: const Text('Show read')),
        CheckedPopupMenuItem(value: 'unread', checked: _showUnread, child: const Text('Show unread')),
        CheckedPopupMenuItem(value: 'starred', checked: _showStarred, child: const Text('Show starred')),
      ],
    );
  }
}
