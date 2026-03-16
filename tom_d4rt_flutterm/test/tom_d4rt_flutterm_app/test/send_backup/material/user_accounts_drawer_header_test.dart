import 'package:flutter/material.dart';

/// Deep visual demo for UserAccountsDrawerHeader widget.
/// Drawer header for user account information.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('UserAccountsDrawerHeader', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(Icons.person, color: Colors.blue, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withAlpha(200)),
                    child: const Icon(Icons.person, color: Colors.blue, size: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('John Doe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('john@example.com', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('accountName, accountEmail, otherAccountsPictures', style: TextStyle(fontSize: 9, color: Colors.grey)),
    ],
  );
}
