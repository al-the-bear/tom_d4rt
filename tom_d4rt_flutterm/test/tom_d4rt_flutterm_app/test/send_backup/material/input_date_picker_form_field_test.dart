import 'package:flutter/material.dart';

/// Deep visual demo for InputDatePickerFormField.
/// Shows date input with text field and calendar picker.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputDatePickerFormField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date of birth', style: TextStyle(fontSize: 10, color: Colors.blue)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Expanded(child: Text('03/15/1990', style: TextStyle(fontSize: 14))),
                  Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Enter date or use picker', style: TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Text input + calendar picker', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
