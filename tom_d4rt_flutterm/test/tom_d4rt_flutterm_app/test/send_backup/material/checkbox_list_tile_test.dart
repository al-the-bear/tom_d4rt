import 'package:flutter/material.dart';

/// Deep visual demo for CheckboxListTile.
/// Shows checkbox with list tile layout.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CheckboxListTile')),
    body: _CheckboxListDemo(),
  );
}

class _CheckboxListDemo extends StatefulWidget {
  @override
  State<_CheckboxListDemo> createState() => _CheckboxListDemoState();
}

class _CheckboxListDemoState extends State<_CheckboxListDemo> {
  final _items = ['Email notifications', 'Push notifications', 'SMS alerts', 'Weekly digest'];
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Notification Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        for (final item in _items)
          CheckboxListTile(
            title: Text(item),
            subtitle: Text('Enable ' + item.toLowerCase()),
            secondary: const Icon(Icons.notifications),
            value: _selected.contains(item),
            onChanged: (v) => setState(() => v! ? _selected.add(item) : _selected.remove(item)),
          ),
        const Divider(),
        CheckboxListTile(
          title: const Text('Tristate checkbox'),
          tristate: true,
          value: _selected.length == _items.length ? true : _selected.isEmpty ? false : null,
          onChanged: (_) {},
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Selected: ' + _selected.length.toString() + '/' + _items.length.toString()),
        ),
      ],
    );
  }
}
