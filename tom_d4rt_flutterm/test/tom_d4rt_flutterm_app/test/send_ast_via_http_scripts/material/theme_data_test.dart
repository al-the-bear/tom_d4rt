import 'package:flutter/material.dart';

/// Deep visual demo for ThemeData class.
/// Material Design theme configuration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemePreview('Light', Colors.white, Colors.blue, Colors.black87),
          const SizedBox(width: 16),
          _ThemePreview('Dark', Colors.grey.shade900, Colors.lightBlue, Colors.white),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('colorScheme'),
          _PropChip('textTheme'),
          _PropChip('brightness'),
          _PropChip('primaryColor'),
        ],
      ),
    ],
  );
}

class _ThemePreview extends StatelessWidget {
  final String name;
  final Color bg;
  final Color primary;
  final Color text;
  const _ThemePreview(this.name, this.bg, this.primary, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Container(height: 20, decoration: BoxDecoration(color: primary, borderRadius: const BorderRadius.vertical(top: Radius.circular(7)))),
              Expanded(child: Center(child: Text('Aa', style: TextStyle(color: text, fontSize: 16)))),
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(4)),
                child: const Text('BTN', style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class _PropChip extends StatelessWidget {
  final String name;
  const _PropChip(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
      child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
