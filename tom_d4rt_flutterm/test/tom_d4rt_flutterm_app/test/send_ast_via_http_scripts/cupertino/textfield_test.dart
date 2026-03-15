import 'package:flutter/cupertino.dart';

/// Deep visual demo for CupertinoTextField - iOS-style text input field.
/// Demonstrates placeholder, prefix, suffix, clearButton, and styling.
dynamic build(BuildContext context) {
  return CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(
      middle: Text('CupertinoTextField Demo'),
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Basic TextField:', style: TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'Enter your name',
              padding: const EdgeInsets.all(12),
            ),
            const SizedBox(height: 24),
            const Text('With Prefix & Suffix:', style: TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'Search...',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey),
              ),
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.mic, color: CupertinoColors.systemGrey),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            ),
            const SizedBox(height: 24),
            const Text('With Clear Button:', style: TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'Email address',
              clearButtonMode: OverlayVisibilityMode.editing,
              keyboardType: TextInputType.emailAddress,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.systemGrey4),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Multiline TextField:', style: TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            CupertinoTextField(
              placeholder: 'Write your message here...',
              maxLines: 4,
              minLines: 3,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
