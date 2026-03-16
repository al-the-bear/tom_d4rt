import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoThemeData - theme configuration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: const Column(
          children: [
            _ThemeProp('primaryColor', 'CupertinoColors.activeBlue'),
            _ThemeProp('brightness', 'Brightness.light'),
            _ThemeProp('textTheme', 'CupertinoTextThemeData'),
            _ThemeProp('barBackgroundColor', 'Color(0xF0F9F9F9)'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Configure app-wide styling', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ThemeProp extends StatelessWidget {
  final String name, value;
  const _ThemeProp(this.name, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        const Text(': ', style: TextStyle(fontSize: 10)),
        Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
      ],
    ),
  );
}
