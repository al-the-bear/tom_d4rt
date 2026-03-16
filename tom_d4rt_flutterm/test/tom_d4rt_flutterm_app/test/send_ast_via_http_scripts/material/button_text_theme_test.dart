import 'package:flutter/material.dart';

/// Deep visual demo for ButtonTextTheme.
/// Shows button text theme options.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonTextTheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('ButtonTextTheme Enum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Deprecated with Material 3', style: TextStyle(color: Colors.orange)),
        const SizedBox(height: 24),
        _Demo('normal', 'Default colors'),
        _Demo('accent', 'Theme accent color'),
        _Demo('primary', 'Theme primary color'),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Modern approach:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Use ButtonStyle with foregroundColor instead'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Demo extends StatelessWidget {
  final String name, desc;
  const _Demo(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.text_fields),
    title: Text(name),
    subtitle: Text(desc),
  );
}
