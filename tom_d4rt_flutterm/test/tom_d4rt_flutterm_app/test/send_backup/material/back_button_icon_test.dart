import 'package:flutter/material.dart';

/// Deep visual demo for BackButtonIcon - the icon used in BackButton.
/// Shows the platform-adaptive back arrow icon.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BackButtonIcon Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          children: [
            Text('Platform-Adaptive Back Arrow'),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, size: 32, color: Colors.blue),
                SizedBox(width: 8),
                Text('Android/Web', style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios, size: 32, color: Colors.blue),
                SizedBox(width: 8),
                Text('iOS/macOS', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('BackButtonIcon adapts to platform', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
