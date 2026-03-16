import 'package:flutter/material.dart';

/// Deep visual demo for miscellaneous button styles.
/// Shows various button styling approaches.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Button Styles Misc')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Styling Approaches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _StyleDemo('styleFrom()', ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
          onPressed: () {},
          child: const Text('styleFrom'),
        )),
        _StyleDemo('ButtonStyle()', ElevatedButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
          onPressed: () {},
          child: const Text('ButtonStyle'),
        )),
        _StyleDemo('copyWith()', ElevatedButton(
          style: ElevatedButton.styleFrom().copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.purple)),
          onPressed: () {},
          child: const Text('copyWith'),
        )),
        _StyleDemo('Theme default', Builder(builder: (ctx) {
          return Theme(
            data: Theme.of(ctx).copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink)),
            ),
            child: ElevatedButton(onPressed: () {}, child: const Text('Themed')),
          );
        })),
        const SizedBox(height: 16),
        const Text('Priority: widget style > theme > defaults', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}

class _StyleDemo extends StatelessWidget {
  final String label; final Widget button;
  const _StyleDemo(this.label, this.button);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [SizedBox(width: 120, child: Text(label)), button]),
  );
}
