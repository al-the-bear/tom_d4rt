import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTextFormFieldRow - form field in scrollable list.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextFormFieldRow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 280,
        child: CupertinoFormSection.insetGrouped(
          header: const Text('Account'),
          children: [
            CupertinoTextFormFieldRow(prefix: const Text('Name'), placeholder: 'Enter name'),
            CupertinoTextFormFieldRow(prefix: const Text('Email'), placeholder: 'Enter email'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Scrolls with keyboard visibility', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
