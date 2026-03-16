import 'package:flutter/material.dart';

/// Deep visual demo for MaterialBanner widget.
/// Shows a banner with message and action buttons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialBanner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Your subscription is expiring soon. Renew now to continue service.',
                      style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: const Text('DISMISS', style: TextStyle(fontSize: 11))),
                  TextButton(onPressed: () {}, child: const Text('RENEW', style: TextStyle(fontSize: 11))),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('content, leading, actions', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
