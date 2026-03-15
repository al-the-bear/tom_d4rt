import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSwitch with advanced styling options.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoSwitch Styles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CupertinoSwitch(value: true, onChanged: (_) {}),
              const SizedBox(height: 4),
              const Text('Default', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            children: [
              CupertinoSwitch(
                value: true,
                activeTrackColor: CupertinoColors.systemPurple,
                onChanged: (_) {},
              ),
              const SizedBox(height: 4),
              const Text('Purple', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            children: [
              CupertinoSwitch(
                value: false,
                onChanged: (_) {},
              ),
              const SizedBox(height: 4),
              const Text('Off', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      const CupertinoSwitch(value: true, onChanged: null),
      const Text('Disabled', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 12),
      const Text('activeTrackColor, thumbColor customization', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
