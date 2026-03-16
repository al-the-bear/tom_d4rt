import 'package:flutter/material.dart';

/// Deep visual demo for CloseButton.
/// Shows close button widget with back navigation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('CloseButton'),
      actions: const [CloseButton()],
    ),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CloseButton Widget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Calls Navigator.maybePop when pressed'),
          const SizedBox(height: 32),
          const Text('Standalone:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [const CloseButton(), const Text(' Tap to trigger pop')]),
          const SizedBox(height: 24),
          const Text('Custom onPressed:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            CloseButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Custom action')))),
            const Text(' Custom handler'),
          ]),
          const SizedBox(height: 24),
          const Text('Comparison:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Row(children: [CloseButton(), SizedBox(width: 8), Text('CloseButton - X icon')]),
          const SizedBox(height: 8),
          const Row(children: [BackButton(), SizedBox(width: 8), Text('BackButton - Arrow icon')]),
        ],
      ),
    ),
  );
}
