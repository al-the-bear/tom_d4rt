import 'package:flutter/material.dart';

/// Deep visual demo for BottomAppBarTheme.
/// Shows bottom app bar styling configuration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BottomAppBarTheme')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('BottomAppBar Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Prop('color', 'Background color'),
        _Prop('elevation', 'Shadow depth'),
        _Prop('shape', 'Notch shape for FAB'),
        _Prop('height', 'Bar height'),
        _Prop('surfaceTintColor', 'M3 surface tint'),
        _Prop('shadowColor', 'Shadow color'),
        _Prop('padding', 'Content padding'),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Text('Preview: Themed BottomAppBar below', style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
    ),
  );
}

class _Prop extends StatelessWidget {
  final String name, desc;
  const _Prop(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(title: Text(name), subtitle: Text(desc), dense: true);
}
