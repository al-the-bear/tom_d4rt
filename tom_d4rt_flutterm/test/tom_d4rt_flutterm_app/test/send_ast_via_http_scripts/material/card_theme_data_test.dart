import 'package:flutter/material.dart';

/// Deep visual demo for CardThemeData.
/// Shows card theme customization.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CardThemeData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Card Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Prop('color', 'Color', 'Background color'),
        _Prop('shadowColor', 'Color', 'Shadow color'),
        _Prop('surfaceTintColor', 'Color', 'M3 surface tint'),
        _Prop('elevation', 'double', 'Shadow elevation'),
        _Prop('shape', 'ShapeBorder', 'Card shape'),
        _Prop('clipBehavior', 'Clip', 'Clipping behavior'),
        _Prop('margin', 'EdgeInsets', 'Outer margin'),
        const SizedBox(height: 24),
        const Text('Themed Card:', style: TextStyle(fontWeight: FontWeight.bold)),
        Theme(
          data: Theme.of(context).copyWith(
            cardTheme: CardThemeData(
              color: Colors.amber.shade100,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          child: const Card(
            child: Padding(padding: EdgeInsets.all(24), child: Text('This card uses CardThemeData')),
          ),
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
