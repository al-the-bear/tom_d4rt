import 'package:flutter/material.dart';

/// Deep visual demo for AboutDialog.
/// Shows application info dialog.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AboutDialog')),
    body: Center(
      child: ElevatedButton.icon(
        onPressed: () => showAboutDialog(
          context: context,
          applicationName: 'Demo App',
          applicationVersion: '1.0.0',
          applicationIcon: const FlutterLogo(size: 48),
          applicationLegalese: '© 2024 Demo Company',
          children: [
            const SizedBox(height: 16),
            const Text('An example application demonstrating AboutDialog widget.'),
          ],
        ),
        icon: const Icon(Icons.info_outline),
        label: const Text('Show About Dialog'),
      ),
    ),
  );
}
