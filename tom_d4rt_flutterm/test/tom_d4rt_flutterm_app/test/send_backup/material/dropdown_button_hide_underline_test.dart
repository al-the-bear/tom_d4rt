import 'package:flutter/material.dart';

/// Deep visual demo for DropdownButtonHideUnderline - removes underline from dropdown.
/// Shows dropdown button with and without underline.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownButtonHideUnderline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // With underline
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Option 1'),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Default', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 24),
          // Without underline
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Option 1'),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_drop_down, color: Colors.blue.shade600),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('HideUnderline', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Wrap DropdownButton with this widget', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
