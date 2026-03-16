import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for CupertinoBasedMaterialThemeData - Material theme with Cupertino basis.
/// Shows how Material components can be themed using Cupertino colors.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Cupertino-Based Material Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Visual comparison
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemeBox('Cupertino', CupertinoColors.systemBlue.color, const Icon(CupertinoIcons.circle, color: Colors.white)),
          const Icon(Icons.arrow_forward, size: 24),
          _ThemeBox('Material', Colors.blue, const Icon(Icons.check_circle, color: Colors.white)),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Text('Color Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            SizedBox(height: 8),
            Text('CupertinoColors → ColorScheme', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('CupertinoTextTheme → TextTheme', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

class _ThemeBox extends StatelessWidget {
  final String label;
  final Color color;
  final Widget icon;
  const _ThemeBox(this.label, this.color, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          child: Center(child: icon),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
