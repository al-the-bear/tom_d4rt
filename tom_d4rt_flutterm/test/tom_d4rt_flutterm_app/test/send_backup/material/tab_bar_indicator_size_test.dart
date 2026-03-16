import 'package:flutter/material.dart';

/// Deep visual demo for TabBarIndicatorSize enum.
/// Controls the width of the tab indicator.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabBarIndicatorSize', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _IndicatorDemo('tab', true),
      const SizedBox(height: 16),
      _IndicatorDemo('label', false),
      const SizedBox(height: 12),
      const Text('indicatorSize property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _IndicatorDemo extends StatelessWidget {
  final String name;
  final bool fullWidth;
  const _IndicatorDemo(this.name, this.fullWidth);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Tab('Tab 1', true, fullWidth),
              _Tab('Tab 2', false, fullWidth),
              _Tab('Tab 3', false, fullWidth),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final bool fullWidth;
  const _Tab(this.label, this.selected, this.fullWidth);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.blue : Colors.grey)),
          const SizedBox(height: 4),
          Container(
            width: fullWidth ? 60 : label.length * 5.0,
            height: 2,
            color: selected ? Colors.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
