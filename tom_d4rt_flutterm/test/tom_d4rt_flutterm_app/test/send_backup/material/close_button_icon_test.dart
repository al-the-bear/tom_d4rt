import 'package:flutter/material.dart';

/// Deep visual demo for CloseButtonIcon.
/// Shows platform-adaptive close icon.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CloseButtonIcon')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CloseButtonIcon Widget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Platform-adaptive close icon'),
          const SizedBox(height: 32),
          Row(
            children: [
              const Text('Icon: '),
              const SizedBox(width: 16),
              const CloseButtonIcon(),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Usage in CloseButton:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [const CloseButton(), const SizedBox(width: 16), const Text('CloseButton()')]),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Platform Behavior:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Material: Icons.close'),
                Text('• iOS/macOS: CupertinoIcons.xmark'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
