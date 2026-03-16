import 'package:flutter/material.dart';

/// Deep visual demo for TimePickerThemeData.
/// Theme customization for time picker.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TimePickerThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TimePickerTheme('Default', Colors.blue, Colors.blue.shade50),
          const SizedBox(width: 16),
          _TimePickerTheme('Custom', Colors.purple, Colors.purple.shade50),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('backgroundColor'),
          _PropChip('dialHandColor'),
          _PropChip('hourMinuteColor'),
          _PropChip('entryModeIconColor'),
        ],
      ),
    ],
  );
}

class _TimePickerTheme extends StatelessWidget {
  final String name;
  final Color accent;
  final Color inputBg;
  const _TimePickerTheme(this.name, this.accent, this.inputBg);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.circular(4)),
                    child: Text('10', style: TextStyle(fontSize: 12, color: accent)),
                  ),
                  const Text(':', style: TextStyle(fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                    child: const Text('30', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
                child: Center(child: Container(width: 6, height: 6, decoration: BoxDecoration(color: accent, shape: BoxShape.circle))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _PropChip extends StatelessWidget {
  final String prop;
  const _PropChip(this.prop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
      child: Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
