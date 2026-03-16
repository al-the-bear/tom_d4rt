import 'package:flutter/material.dart';

/// Deep visual demo for MaterialBannerTheme.
/// Shows banner theme customization.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MaterialBannerTheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Banner Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _ThemeProp('backgroundColor', 'Banner background'),
        _ThemeProp('surfaceTintColor', 'M3 surface tint'),
        _ThemeProp('shadowColor', 'Shadow color'),
        _ThemeProp('dividerColor', 'Divider line color'),
        _ThemeProp('contentTextStyle', 'Content text style'),
        _ThemeProp('elevation', 'Shadow elevation'),
        _ThemeProp('padding', 'Content padding'),
        _ThemeProp('leadingPadding', 'Leading icon padding'),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: const Text('This is a themed banner message'),
              leading: const Icon(Icons.info),
              actions: [TextButton(onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(), child: const Text('DISMISS'))],
            ),
          ),
          child: const Text('Show Banner'),
        ),
      ],
    ),
  );
}

class _ThemeProp extends StatelessWidget {
  final String name, desc;
  const _ThemeProp(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
    subtitle: Text(desc),
    dense: true,
  );
}
