import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoFormSection - grouped form layout.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoFormSection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 280,
        child: CupertinoFormSection.insetGrouped(
          header: const Text('PREFERENCES'),
          footer: const Text('Configure your app settings'),
          children: [
            CupertinoFormRow(prefix: const Text('Notifications'), child: CupertinoSwitch(value: true, onChanged: (_) {})),
            CupertinoFormRow(prefix: const Text('Sound'), child: CupertinoSwitch(value: false, onChanged: (_) {})),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Header + rows + footer pattern', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
