import 'package:flutter/material.dart';

/// Deep visual demo for Autocomplete with chips.
/// Shows multi-select autocomplete pattern.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Autocomplete Chips')),
    body: Center(child: _ChipsAutocomplete()),
  );
}

class _ChipsAutocomplete extends StatefulWidget {
  @override
  State<_ChipsAutocomplete> createState() => _ChipsAutocompleteState();
}

class _ChipsAutocompleteState extends State<_ChipsAutocomplete> {
  final List<String> _selected = [];
  static const _options = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select fruits:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: _selected.map((s) => Chip(
            label: Text(s),
            onDeleted: () => setState(() => _selected.remove(s)),
          )).toList()),
          const SizedBox(height: 16),
          Autocomplete<String>(
            optionsBuilder: (v) => _options.where((o) => o.toLowerCase().contains(v.text.toLowerCase()) && !_selected.contains(o)),
            onSelected: (s) => setState(() => _selected.add(s)),
            fieldViewBuilder: (ctx, ctrl, focus, submit) => TextField(
              controller: ctrl,
              focusNode: focus,
              decoration: const InputDecoration(hintText: 'Type to search...', border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}
