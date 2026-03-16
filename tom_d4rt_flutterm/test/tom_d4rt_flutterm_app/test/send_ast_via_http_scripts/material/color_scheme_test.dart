import 'package:flutter/material.dart';

/// Deep visual demo for ColorScheme.
/// Shows Material 3 color system.
dynamic build(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return Scaffold(
    appBar: AppBar(title: const Text('ColorScheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Theme Colors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _ColorRow('primary', scheme.primary, scheme.onPrimary),
        _ColorRow('secondary', scheme.secondary, scheme.onSecondary),
        _ColorRow('tertiary', scheme.tertiary, scheme.onTertiary),
        _ColorRow('error', scheme.error, scheme.onError),
        _ColorRow('surface', scheme.surface, scheme.onSurface),
        const Divider(height: 32),
        const Text('Container Colors', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _ColorRow('primaryContainer', scheme.primaryContainer, scheme.onPrimaryContainer),
        _ColorRow('secondaryContainer', scheme.secondaryContainer, scheme.onSecondaryContainer),
        _ColorRow('errorContainer', scheme.errorContainer, scheme.onErrorContainer),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Use ColorScheme.fromSeed()'),
        ),
      ],
    ),
  );
}

class _ColorRow extends StatelessWidget {
  final String name;
  final Color bg;
  final Color fg;
  const _ColorRow(this.name, this.bg, this.fg);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Text(name, style: TextStyle(color: fg)),
  );
}
