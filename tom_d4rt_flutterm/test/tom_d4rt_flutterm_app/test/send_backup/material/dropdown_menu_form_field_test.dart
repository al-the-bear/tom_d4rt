import 'package:flutter/material.dart';

/// Deep visual demo for DropdownMenuFormField - form-integrated dropdown menu.
/// Shows dropdown menu with form field styling and validation.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownMenuFormField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 8),
                    child: Text('Country', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      children: [
                        const Text('🇺🇸 United States', style: TextStyle(fontSize: 13)),
                        const Spacer(),
                        Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text('Helper text goes here', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Combines DropdownMenu + FormField', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
