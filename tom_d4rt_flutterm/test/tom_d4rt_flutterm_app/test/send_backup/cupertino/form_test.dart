import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoFormSection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoFormSection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 260,
        child: CupertinoFormSection.insetGrouped(
          header: const Text('PROFILE'),
          children: [
            CupertinoTextFormFieldRow(prefix: const Text('Username'), placeholder: 'Enter username'),
            CupertinoTextFormFieldRow(prefix: const Text('Bio'), placeholder: 'Tell us about yourself'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS Settings-style form layout', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
