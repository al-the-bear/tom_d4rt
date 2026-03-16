import 'package:flutter/material.dart';

/// Deep visual demo for Dialog - base Material dialog widget.
/// Shows the core dialog structure with content area.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Dialog Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16)],
        ),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.blue),
              SizedBox(height: 16),
              Text('Dialog Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text('This is the base Dialog widget.\nCustomize with your content.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Text('Base widget for AlertDialog, SimpleDialog', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
