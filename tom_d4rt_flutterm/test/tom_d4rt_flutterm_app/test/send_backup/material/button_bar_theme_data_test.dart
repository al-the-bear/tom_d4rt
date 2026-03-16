import 'package:flutter/material.dart';

/// Deep visual demo for ButtonBarThemeData.
/// Shows button bar theme data properties.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonBarThemeData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Theme Data Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Prop('alignment', 'MainAxisAlignment'),
        _Prop('mainAxisSize', 'MainAxisSize'),
        _Prop('buttonTextTheme', 'ButtonTextTheme'),
        _Prop('buttonMinWidth', 'double'),
        _Prop('buttonHeight', 'double'),
        _Prop('buttonPadding', 'EdgeInsetsGeometry'),
        _Prop('buttonAlignedDropdown', 'bool'),
        _Prop('layoutBehavior', 'ButtonBarLayoutBehavior'),
        _Prop('overflowDirection', 'VerticalDirection'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Themed Example:', style: TextStyle(fontWeight: FontWeight.bold)),
                ButtonBarTheme(
                  data: const ButtonBarThemeData(
                    alignment: MainAxisAlignment.center,
                    buttonHeight: 48,
                    buttonMinWidth: 100,
                  ),
                  child: ButtonBar(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('One')),
                      TextButton(onPressed: () {}, child: const Text('Two')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _Prop extends StatelessWidget {
  final String name, type;
  const _Prop(this.name, this.type);
  @override
  Widget build(BuildContext context) => ListTile(title: Text(name), trailing: Text(type, style: const TextStyle(fontSize: 11)), dense: true);
}
