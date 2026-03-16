import 'package:flutter/material.dart';

/// Deep visual demo for DropdownButtonFormField - dropdown in a form field.
/// Shows dropdown with form validation and decoration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownButtonFormField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            const Text('Category', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Dropdown field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(child: Text('Select category')),
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text('Required field', style: TextStyle(fontSize: 10, color: Colors.red)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Form-integrated with validation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
