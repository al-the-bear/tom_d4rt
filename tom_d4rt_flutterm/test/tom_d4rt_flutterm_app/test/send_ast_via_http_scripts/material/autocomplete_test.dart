import 'package:flutter/material.dart';

/// Deep visual demo for Autocomplete.
/// Shows type-ahead suggestion widget.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Autocomplete')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Type to Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Autocomplete<String>(
            optionsBuilder: (v) {
              if (v.text.isEmpty) return const Iterable<String>.empty();
              return ['Flutter', 'Firebase', 'Dart', 'Android', 'iOS', 'Material', 'Cupertino']
                .where((o) => o.toLowerCase().contains(v.text.toLowerCase()));
            },
            onSelected: (v) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected: ' + v))),
            fieldViewBuilder: (ctx, ctrl, focus, submit) => TextField(
              controller: ctrl,
              focusNode: focus,
              decoration: InputDecoration(
                labelText: 'Search technologies',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (_) => submit(),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('• optionsBuilder - filter options'),
                Text('• onSelected - handle selection'),
                Text('• fieldViewBuilder - custom input'),
                Text('• optionsViewBuilder - custom dropdown'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
