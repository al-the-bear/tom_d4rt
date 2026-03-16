import 'package:flutter/material.dart';

/// Deep visual demo for ButtonBarTheme.
/// Shows button bar theme configuration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonBarTheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('ButtonBar Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('(Deprecated in favor of OverflowBar)', style: TextStyle(color: Colors.orange, fontSize: 12)),
        const SizedBox(height: 16),
        _Prop('alignment', 'MainAxisAlignment', 'Button alignment'),
        _Prop('mainAxisSize', 'MainAxisSize', 'Size behavior'),
        _Prop('buttonTextTheme', 'ButtonTextTheme', 'Text styling'),
        _Prop('buttonMinWidth', 'double', 'Minimum button width'),
        _Prop('buttonHeight', 'double', 'Button height'),
        _Prop('buttonPadding', 'EdgeInsets', 'Button padding'),
        _Prop('buttonAlignedDropdown', 'bool', 'Dropdown alignment'),
        _Prop('layoutBehavior', 'ButtonBarLayoutBehavior', 'Layout mode'),
        _Prop('overflowDirection', 'VerticalDirection', 'Overflow direction'),
        const SizedBox(height: 24),
        const Text('Example ButtonBar:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ButtonBar(
          children: [
            TextButton(onPressed: () {}, child: const Text('CANCEL')),
            ElevatedButton(onPressed: () {}, child: const Text('OK')),
          ],
        ),
      ],
    ),
  );
}

class _Prop extends StatelessWidget {
  final String name, type, desc;
  const _Prop(this.name, this.type, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(name),
    subtitle: Text(desc),
    trailing: Text(type, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    dense: true,
  );
}
