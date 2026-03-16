import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTheme widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: CupertinoColors.systemPurple),
        child: Builder(builder: (ctx) => Column(
          children: [
            CupertinoButton(
              color: CupertinoTheme.of(ctx).primaryColor,
              onPressed: () {},
              child: const Text('Themed Button'),
            ),
            const SizedBox(height: 8),
            Text('Primary: Purple', style: TextStyle(color: CupertinoTheme.of(ctx).primaryColor, fontSize: 11)),
          ],
        )),
      ),
      const SizedBox(height: 12),
      const Text('CupertinoTheme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: CupertinoColors.systemGrey)),
    ],
  );
}
