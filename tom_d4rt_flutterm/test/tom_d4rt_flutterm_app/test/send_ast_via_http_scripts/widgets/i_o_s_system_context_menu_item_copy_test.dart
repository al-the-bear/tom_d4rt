// ignore_for_file: avoid_print
// IOSSystemContextMenuItemCopy – comprehensive deep demo
// Apple Gray / Silver palette – iOS platform-specific system context menu
// item representing the "Copy" action in text selection toolbars.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ccAppleGray = Color(0xFF636366);
  const Color ccSilver = Color(0xFFF2F2F7);
  const Color ccOnGray = Color(0xFFFFFFFF);
  const Color ccDarkGray = Color(0xFF1C1C1E);
  const Color ccLightSilver = Color(0xFFF9F9FB);
  const Color ccTextDark = Color(0xFF2C2C2E);
  const Color ccAccent = Color(0xFF007AFF);
  const Color ccMuted = Color(0xFFAEAEB2);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ccHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ccAppleGray, ccDarkGray],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ccOnGray)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ccOnGray.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ccSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ccLightSilver,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ccAppleGray.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ccAppleGray.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ccDarkGray)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget ccBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: ccAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ccTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ccCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ccSilver,
              height: 1.5)),
    );
  }

  Widget ccKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ccDarkGray)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ccTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ccHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ccAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ccAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ccDarkGray,
              height: 1.4)),
    );
  }

  Widget ccDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ccMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ccCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ccAppleGray,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: ccDarkGray)),
                  TextSpan(
                      text: desc,
                      style:
                          const TextStyle(fontSize: 11, color: ccTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ccInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ccAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ccDarkGray)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ccTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ccSilver,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ccHeader(
            'IOSSystemContextMenuItemCopy',
            'iOS-specific system context menu item that provides the '
                'standard "Copy" action for text selection on Apple platforms',
          ),

          // ── 1. class overview ──
          ccSection('1 · Class Identity & Role', [
            ccKeyValue('Class', 'IOSSystemContextMenuItemCopy'),
            ccKeyValue('Belongs to', 'iOS system context menu item family'),
            ccKeyValue('Platform', 'iOS only (Cupertino)'),
            ccKeyValue('Action', 'Copies selected text to the system clipboard'),
            ccDivider(),
            ccBullet(
                'IOSSystemContextMenuItemCopy is a platform-specific menu item '
                'class that represents the "Copy" entry in the iOS native text '
                'selection context menu toolbar.'),
            ccBullet(
                'On iOS, the system context menu appears as a floating toolbar '
                'above or below selected text, containing actions like Copy, '
                'Cut, Paste, Select All, and Look Up.'),
            ccBullet(
                'This class encapsulates the behavior and presentation of the '
                'Copy action specifically, integrating with the system clipboard '
                'service.'),
            ccCodeBlock(
                '// IOSSystemContextMenuItemCopy is typically created\n'
                '// internally by the Cupertino text selection toolbar.\n'
                '// It is part of the platform-adaptive menu system.'),
          ]),

          // ── 2. iOS context menu anatomy ──
          ccSection('2 · iOS Context Menu Anatomy', [
            ccHighlight(
                'The iOS text selection context menu (also called the "callout '
                'bar") is a horizontal toolbar that appears above or below '
                'selected text. It contains system-defined items like Cut, '
                'Copy, Paste arranged horizontally with separator dividers.'),
            ccBullet(
                'The menu appears when text is selected via long-press or '
                'double-tap, and disappears when the selection is dismissed '
                'or text is deselected.'),
            ccBullet(
                'Items are ordered by the system: Cut, Copy, Paste from left '
                'to right, with additional items like "Look Up" and "Share" '
                'accessible via a chevron arrow.'),
            ccBullet(
                'The Copy item is only visible when there is an active text '
                'selection (not when the caret is collapsed).'),
            ccDivider(),
            ccInfoRow('C', 'Cut', 'Removes selected text, copies to clipboard'),
            ccInfoRow('C', 'Copy', 'Copies to clipboard without removing'),
            ccInfoRow('P', 'Paste', 'Inserts clipboard content at caret'),
            ccInfoRow('A', 'Select All', 'Selects the entire text field'),
          ]),

          // ── 3. copy action behavior ──
          ccSection('3 · Copy Action Behavior', [
            ccBullet(
                'When tapped, the Copy item reads the currently selected text '
                'from the TextEditingValue and writes it to the system '
                'clipboard via Clipboard.setData.'),
            ccBullet(
                'After copying, the selection is typically preserved (unlike '
                'Cut, which removes the selected text).'),
            ccBullet(
                'The context menu automatically dismisses after the action '
                'completes, following iOS platform conventions.'),
            ccCodeBlock(
                '// What the Copy action does internally\n'
                'void handleCopy(TextEditingValue value) {\n'
                '  final selectedText = value.selection\n'
                '      .textInside(value.text);\n'
                '  Clipboard.setData(\n'
                '      ClipboardData(text: selectedText));\n'
                '  // Selection remains, menu closes\n'
                '}'),
            ccDivider(),
            ccBullet(
                'The clipboard write is asynchronous but typically completes '
                'within a single frame on iOS.'),
          ]),

          // ── 4. visibility conditions ──
          ccSection('4 · When Copy Appears', [
            ccBullet(
                'The Copy item is shown ONLY when there is a non-collapsed '
                'text selection (baseOffset != extentOffset).'),
            ccBullet(
                'In read-only fields, Copy and Select All appear but Cut '
                'and Paste do not.'),
            ccBullet(
                'If the text field has obscured text (password field), '
                'Copy is typically hidden to prevent credential leaking.'),
            ccDivider(),
            ccKeyValue('Non-collapsed selection', 'Copy is visible'),
            ccKeyValue('Collapsed caret', 'Copy is NOT visible'),
            ccKeyValue('Read-only field', 'Copy is visible'),
            ccKeyValue('Obscured text', 'Copy is hidden'),
            ccKeyValue('Empty selection', 'Copy is NOT visible'),
          ]),

          // ── 5. Cupertino toolbar integration ──
          ccSection('5 · CupertinoAdaptiveTextSelectionToolbar', [
            ccBullet(
                'On iOS, Flutter uses CupertinoAdaptiveTextSelectionToolbar '
                'to render the context menu with native iOS styling.'),
            ccBullet(
                'The toolbar automatically includes IOSSystemContextMenuItemCopy '
                'when the selection state warrants it.'),
            ccBullet(
                'The toolbar positions itself to avoid the keyboard and '
                'screen edges, using the selection rectangles as anchors.'),
            ccCodeBlock(
                '// The adaptive toolbar handles item creation\n'
                'CupertinoAdaptiveTextSelectionToolbar.editable(\n'
                '  clipboardStatus: ClipboardStatus.pasteable,\n'
                '  onCopy: handleCopy,\n'
                '  onCut: handleCut,\n'
                '  onPaste: handlePaste,\n'
                '  onSelectAll: handleSelectAll,\n'
                '  anchors: TextSelectionToolbarAnchors(\n'
                '    primaryAnchor: selectionMidpoint,\n'
                '  ),\n'
                ')'),
            ccDivider(),
            ccBullet(
                'The onCopy callback is null when Copy should be hidden, '
                'causing the toolbar to omit the Copy item entirely.'),
          ]),

          // ── 6. clipboard service ──
          ccSection('6 · System Clipboard Integration', [
            ccBullet(
                'The Copy action uses the Flutter Clipboard service which '
                'delegates to platform channels on iOS.'),
            ccBullet(
                'On iOS, the UIPasteboard.general receives the copied text '
                'as a plain-text representation.'),
            ccBullet(
                'Rich text (styled text, HTML) is not preserved through '
                'the standard Flutter Clipboard API – only plain text.'),
            ccDivider(),
            ccKeyValue('API', 'Clipboard.setData(ClipboardData(text: ...))'),
            ccKeyValue('Platform', 'UIPasteboard.general on iOS'),
            ccKeyValue('Format', 'Plain text only (kUTTypePlainText)'),
            ccKeyValue('Async', 'Returns Future<void>, typically instant'),
          ]),

          // ── 7. comparison with platform variants ──
          ccSection('7 · Cross-Platform Context Menu Comparison', [
            ccCompare('iOS (Cupertino)',
                'Floating callout bar with rounded corners, blur background'),
            ccCompare('Android (Material)',
                'Floating toolbar above selection, rectangular shape'),
            ccCompare('macOS (Desktop)',
                'Standard right-click context menu, vertical list'),
            ccCompare('Web',
                'Browser-native context menu or Flutter-rendered overlay'),
            ccDivider(),
            ccBullet(
                'IOSSystemContextMenuItemCopy is specific to the iOS rendering; '
                'on Android the equivalent is handled by '
                'MaterialAdaptiveTextSelectionToolbar.'),
            ccBullet(
                'The behavioral API (onCopy callback) is the same across all '
                'platforms – only the visual presentation differs.'),
          ]),

          // ── 8. custom copy handlers ──
          ccSection('8 · Custom Copy Action Overrides', [
            ccBullet(
                'You can provide a custom onCopy callback to modify what gets '
                'copied, e.g. adding prefixes, formatting, or analytics events.'),
            ccBullet(
                'The custom callback replaces the default clipboard write; '
                'you must call Clipboard.setData yourself if you want the '
                'text actually placed on the clipboard.'),
            ccCodeBlock(
                '// Custom copy with analytics tracking\n'
                'SelectableText(\n'
                '  \'Selectable content here\',\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCopy: () {\n'
                '        final sel = editableTextState\n'
                '            .textEditingValue.selection;\n'
                '        final text = sel.textInside(\n'
                '            editableTextState.textEditingValue.text);\n'
                '        Clipboard.setData(ClipboardData(text: text));\n'
                '        print(\'Copied: \$text\');\n'
                '      },\n'
                '      onCut: null,\n'
                '      onPaste: null,\n'
                '      onSelectAll: null,\n'
                '      anchors: editableTextState\n'
                '          .contextMenuAnchors,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 9. contextMenuBuilder pattern ──
          ccSection('9 · contextMenuBuilder Pattern', [
            ccBullet(
                'TextField and CupertinoTextField expose a contextMenuBuilder '
                'parameter to fully customize the context menu, including '
                'which system items appear.'),
            ccBullet(
                'The builder receives the BuildContext and the '
                'EditableTextState, giving access to the current '
                'selection and text value.'),
            ccBullet(
                'You can mix system items with custom items by constructing '
                'the toolbar manually.'),
            ccCodeBlock(
                '// Full custom context menu builder\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    final anchors = editableTextState.contextMenuAnchors;\n'
                '    return AdaptiveTextSelectionToolbar(\n'
                '      anchors: anchors,\n'
                '      children: [\n'
                '        // Include system Copy item\n'
                '        CupertinoAdaptiveTextSelectionToolbar\n'
                '            .getAdaptiveButtons(\n'
                '          context, [\n'
                '            ContextMenuButtonItem(\n'
                '              label: \'Copy\',\n'
                '              onPressed: () {\n'
                '                editableTextState.copySelection(\n'
                '                    SelectionChangedCause.toolbar);\n'
                '              },\n'
                '            ),\n'
                '          ],\n'
                '        ).first,\n'
                '      ],\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 10. password field behavior ──
          ccSection('10 · Obscured Text & Password Fields', [
            ccBullet(
                'When TextField has obscureText: true, the Copy item is '
                'intentionally omitted from the context menu.'),
            ccBullet(
                'This is a security measure to prevent users from copying '
                'password content to the clipboard where it could be '
                'accessed by other apps.'),
            ccBullet(
                'If you create a custom contextMenuBuilder for a password '
                'field, do NOT add a Copy action – it violates platform '
                'security guidelines.'),
            ccDivider(),
            ccHighlight(
                'Apple App Store review guidelines may reject apps that allow '
                'copying from password fields. Always follow platform security '
                'conventions for obscured text.'),
          ]),

          // ── 11. haptic feedback ──
          ccSection('11 · Haptic Feedback & Visual Response', [
            ccBullet(
                'On iOS, tapping Copy in the context menu triggers a subtle '
                'haptic feedback (selection impact) through the Taptic Engine.'),
            ccBullet(
                'The menu item shows a press-down highlight before dismissing, '
                'providing visual confirmation of the tap.'),
            ccBullet(
                'Flutter does not automatically add haptic feedback for context '
                'menu items; the native iOS UIMenuController handles this.'),
            ccDivider(),
            ccKeyValue('Haptic type', 'UIImpactFeedbackGenerator (light)'),
            ccKeyValue('Visual', 'Background highlight on press'),
            ccKeyValue('Dismissal', 'Menu fades out after action'),
          ]),

          // ── 12. VoiceOver accessibility ──
          ccSection('12 · VoiceOver & Accessibility', [
            ccBullet(
                'The Copy item is labeled "Copy" in the accessibility tree '
                'so VoiceOver announces "Copy, button" when focused.'),
            ccBullet(
                'After activating Copy via VoiceOver, a confirmation tone '
                'or announcement is provided by the system.'),
            ccBullet(
                'The context menu items have a specific VoiceOver navigation '
                'order matching the visual left-to-right arrangement.'),
            ccDivider(),
            ccKeyValue('A11y label', '"Copy"'),
            ccKeyValue('A11y trait', 'Button'),
            ccKeyValue('A11y hint', '"Copies the selected text"'),
          ]),

          // ── 13. edge cases ──
          ccSection('13 · Edge Cases & Boundary Conditions', [
            ccBullet(
                'Empty selection: Copy item is not shown. If programmatically '
                'invoked, it copies an empty string (no-op effectively).'),
            ccBullet(
                'Very large selection: copying megabytes of text may cause '
                'a brief UI freeze while the clipboard write completes.'),
            ccBullet(
                'Text with newlines: the copy preserves all whitespace '
                'and line breaks as they exist in the TextEditingValue.'),
            ccBullet(
                'Emoji text: multi-code-point emoji are copied as complete '
                'grapheme clusters, preserving their visual appearance.'),
            ccBullet(
                'Clipboard permission: iOS does not require explicit permission '
                'for clipboard write; it may show a notification banner on '
                'iOS 16+ informing the user when an app writes to clipboard.'),
            ccDivider(),
            ccBullet(
                'Rapid double-copy: the second copy overwrites the first on '
                'the clipboard; only the latest copied text is available.'),
          ]),

          // ── 14. testing strategies ──
          ccSection('14 · Testing Strategies', [
            ccBullet(
                'Use WidgetTester to simulate text selection and verify '
                'the context menu appears with a Copy item.'),
            ccBullet(
                'Tap the Copy button and verify clipboard content with '
                'Clipboard.getData.'),
            ccCodeBlock(
                'testWidgets(\'copy menu item works on iOS\',\n'
                '    (WidgetTester tester) async {\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: TextField(\n'
                '        controller: TextEditingController(\n'
                '          text: \'Hello World\',\n'
                '        ),\n'
                '      ),\n'
                '    ),\n'
                '  ));\n'
                '  // Long-press to trigger context menu\n'
                '  await tester.longPress(find.byType(TextField));\n'
                '  await tester.pump();\n'
                '  // Verify Copy button exists\n'
                '  expect(find.text(\'Copy\'), findsOneWidget);\n'
                '});'),
            ccDivider(),
            ccBullet(
                'Platform-specific tests should use debugDefaultTargetPlatformOverride '
                'set to TargetPlatform.iOS to simulate the iOS toolbar.'),
          ]),

          // ── 15. UIPasteControl and iOS 16+ ──
          ccSection('15 · UIPasteControl & iOS 16+ Clipboard Changes', [
            ccBullet(
                'Starting with iOS 16, the system shows a notification banner '
                'when an app accesses the clipboard ("App pasted from ...").'),
            ccBullet(
                'The Copy action writes to clipboard, which does not trigger '
                'this banner (the banner appears on paste/read, not write).'),
            ccBullet(
                'However, apps that read clipboard after a copy (e.g., for '
                'undo tracking) may trigger the banner unexpectedly.'),
            ccDivider(),
            ccHighlight(
                'Best practice: only read the clipboard when the user '
                'explicitly requests a paste action. Avoid programmatic '
                'clipboard reads to prevent the iOS 16+ notification banner.'),
          ]),

          // ── 16. API summary ──
          ccSection('16 · Quick API Reference', [
            ccKeyValue('Class', 'IOSSystemContextMenuItemCopy'),
            ccKeyValue('Platform', 'iOS only'),
            ccKeyValue('Action', 'Copy selected text to clipboard'),
            ccKeyValue('Visibility', 'Non-collapsed selection in non-obscured field'),
            ccKeyValue('Toolbar', 'CupertinoAdaptiveTextSelectionToolbar'),
            ccKeyValue('Clipboard API', 'Clipboard.setData(ClipboardData(...))'),
            ccDivider(),
            ccCodeBlock(
                '// The copy item is created automatically by the toolbar.\n'
                '// To customize, use contextMenuBuilder on TextField:\n'
                'TextField(\n'
                '  contextMenuBuilder: (ctx, state) {\n'
                '    // Build custom menu with or without Copy\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      anchors: state.contextMenuAnchors,\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCopy: () => state.copySelection(\n'
                '          SelectionChangedCause.toolbar),\n'
                '      onCut: null,\n'
                '      onPaste: null,\n'
                '      onSelectAll: null,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ccAppleGray.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemCopy · Apple Gray Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ccMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
