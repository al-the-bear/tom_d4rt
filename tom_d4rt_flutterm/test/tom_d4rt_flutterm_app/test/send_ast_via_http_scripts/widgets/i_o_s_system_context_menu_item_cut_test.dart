// ignore_for_file: avoid_print
// IOSSystemContextMenuItemCut – comprehensive deep demo
// Forest Emerald / Mint palette – iOS system context menu "Cut" action:
// removes selected text and places it on the system clipboard.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ctForest = Color(0xFF1B5E20);
  const Color ctMint = Color(0xFFE8F5E9);
  const Color ctOnForest = Color(0xFFFFFFFF);
  const Color ctDeepGreen = Color(0xFF0A3D0C);
  const Color ctLightMint = Color(0xFFF1F9F1);
  const Color ctTextDark = Color(0xFF1B3820);
  const Color ctAccent = Color(0xFF4CAF50);
  const Color ctMuted = Color(0xFFA5D6A7);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ctHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ctForest, ctDeepGreen],
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
                  color: ctOnForest)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ctOnForest.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ctSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ctLightMint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ctForest.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ctForest.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ctForest)),
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

  Widget ctBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: ctAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ctTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ctCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2E0C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ctMint,
              height: 1.5)),
    );
  }

  Widget ctKeyValue(String key, String value) {
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
                    color: ctDeepGreen)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ctTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ctHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ctAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ctAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ctDeepGreen,
              height: 1.4)),
    );
  }

  Widget ctDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ctMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ctCompare(String label, String desc) {
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
              color: ctForest,
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
                          color: ctDeepGreen)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: ctTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ctInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ctForest.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ctForest)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ctDeepGreen)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ctTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ctMint,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ctHeader(
            'IOSSystemContextMenuItemCut',
            'iOS system context menu "Cut" action – removes selected text '
                'from the field and copies it to the system clipboard',
          ),

          // ── 1. class overview ──
          ctSection('1 · Class Identity & Role', [
            ctKeyValue('Class', 'IOSSystemContextMenuItemCut'),
            ctKeyValue('Platform', 'iOS (Cupertino)'),
            ctKeyValue('Action',
                'Removes selected text and copies to clipboard'),
            ctKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            ctDivider(),
            ctBullet(
                'IOSSystemContextMenuItemCut represents the "Cut" button '
                'in the iOS native text selection context menu. It '
                'performs the classic clipboard Cut operation.'),
            ctBullet(
                'Cut is a compound action: it copies the selected text '
                'to the system clipboard AND removes that text from '
                'the text field, replacing the selection with nothing.'),
            ctBullet(
                'After cutting, the caret collapses to the position '
                'where the selection began.'),
            ctCodeBlock(
                '// The Cut operation in pseudo-code:\n'
                '// 1. Read selected text from TextEditingValue\n'
                '// 2. Write to clipboard: Clipboard.setData(...)\n'
                '// 3. Delete selected text from the field\n'
                '// 4. Collapse selection to start of former selection'),
          ]),

          // ── 2. cut vs copy distinction ──
          ctSection('2 · Cut vs Copy: The Key Distinction', [
            ctHighlight(
                'Copy preserves the original text in the field and only '
                'writes to the clipboard. Cut is destructive: it removes '
                'the selected text from the field. This makes Cut unavailable '
                'in read-only fields where text cannot be modified.'),
            ctInfoRow('C', 'Copy:', 'Clipboard write only, text preserved'),
            ctInfoRow('X', 'Cut:', 'Clipboard write + text deletion'),
            ctInfoRow('V', 'Paste:', 'Clipboard read + text insertion'),
            ctDivider(),
            ctBullet(
                'Both Cut and Copy write the exact same data to the clipboard. '
                'The difference is purely in what happens to the source field.'),
            ctBullet(
                'Undo after Cut restores the deleted text; undo after Copy '
                'has no field effect to undo.'),
          ]),

          // ── 3. visibility conditions ──
          ctSection('3 · When Cut Appears', [
            ctBullet(
                'The Cut item is shown when ALL of these conditions are met:'),
            ctKeyValue('Non-collapsed selection',
                'baseOffset != extentOffset (text is selected)'),
            ctKeyValue('Editable field',
                'The field is not read-only'),
            ctKeyValue('Non-obscured text',
                'The field does not have obscureText: true'),
            ctDivider(),
            ctBullet(
                'In read-only fields (readOnly: true or SelectableText), '
                'Cut is hidden because the text cannot be modified.'),
            ctBullet(
                'In password fields (obscureText: true), Cut is hidden '
                'for security reasons – preventing credential extraction.'),
            ctBullet(
                'When the caret is collapsed (no selection), Cut is not '
                'shown because there is nothing to cut.'),
            ctCodeBlock(
                '// Visibility logic (simplified)\n'
                'final showCut = selection.isValid\n'
                '    && !selection.isCollapsed\n'
                '    && !readOnly\n'
                '    && !obscureText;'),
          ]),

          // ── 4. cut action internals ──
          ctSection('4 · Cut Action Internals', [
            ctBullet(
                'Step 1: Extract the selected text using '
                'selection.textInside(value.text).'),
            ctBullet(
                'Step 2: Write to clipboard via '
                'Clipboard.setData(ClipboardData(text: selectedText)).'),
            ctBullet(
                'Step 3: Replace the selected range with an empty string, '
                'effectively deleting the selection.'),
            ctBullet(
                'Step 4: Update the TextEditingValue with the new text '
                'and a collapsed selection at the cut point.'),
            ctDivider(),
            ctCodeBlock(
                '// Internal cut implementation\n'
                'void handleCut(TextEditingValue value) {\n'
                '  final sel = value.selection;\n'
                '  final selectedText = sel.textInside(value.text);\n'
                '  Clipboard.setData(ClipboardData(text: selectedText));\n'
                '  final newText = sel.textBefore(value.text)\n'
                '      + sel.textAfter(value.text);\n'
                '  controller.value = TextEditingValue(\n'
                '    text: newText,\n'
                '    selection: TextSelection.collapsed(\n'
                '      offset: sel.start,\n'
                '    ),\n'
                '  );\n'
                '}'),
          ]),

          // ── 5. Cupertino toolbar integration ──
          ctSection('5 · CupertinoAdaptiveTextSelectionToolbar', [
            ctBullet(
                'The iOS Cupertino toolbar automatically includes the Cut item '
                'when the onCut callback is non-null.'),
            ctBullet(
                'The framework sets onCut to null when the field is read-only '
                'or the text is obscured, hiding the Cut button.'),
            ctCodeBlock(
                '// Toolbar with Cut callback\n'
                'CupertinoAdaptiveTextSelectionToolbar.editable(\n'
                '  clipboardStatus: ClipboardStatus.pasteable,\n'
                '  onCut: handleCut,  // non-null = Cut shown\n'
                '  onCopy: handleCopy,\n'
                '  onPaste: handlePaste,\n'
                '  onSelectAll: handleSelectAll,\n'
                '  anchors: TextSelectionToolbarAnchors(\n'
                '    primaryAnchor: selectionMidpoint,\n'
                '  ),\n'
                ')'),
            ctDivider(),
            ctBullet(
                'The toolbar positions Cut as the FIRST item (leftmost) '
                'in the callout bar, followed by Copy, then Paste.'),
          ]),

          // ── 6. clipboard interaction ──
          ctSection('6 · System Clipboard Interaction', [
            ctBullet(
                'Cut writes to the same system clipboard as Copy. The '
                'clipboard content is identical after either operation.'),
            ctBullet(
                'On iOS, the text is written to UIPasteboard.general as '
                'a plain-text representation (kUTTypePlainText).'),
            ctBullet(
                'Rich formatting is not preserved – only the raw text '
                'content is placed on the clipboard.'),
            ctDivider(),
            ctKeyValue('API', 'Clipboard.setData(ClipboardData(text: ...))'),
            ctKeyValue('Platform', 'UIPasteboard.general'),
            ctKeyValue('Format', 'Plain text only'),
            ctKeyValue('Timing', 'Asynchronous, typically sub-millisecond'),
          ]),

          // ── 7. undo behavior ──
          ctSection('7 · Undo Behavior After Cut', [
            ctBullet(
                'The text field records the cut operation in its undo history. '
                'Pressing Cmd+Z restores the deleted text.'),
            ctBullet(
                'The undo only restores the text in the field; it does NOT '
                'clear the clipboard. The cut text remains available for paste.'),
            ctBullet(
                'Multiple consecutive cuts create separate undo entries, '
                'so each Cmd+Z restores one cut operation at a time.'),
            ctHighlight(
                'This means after cut + undo, the text is back in the field '
                'AND still on the clipboard – the user effectively has a copy '
                'plus the original text restored.'),
          ]),

          // ── 8. custom cut overrides ──
          ctSection('8 · Custom Cut Action Overrides', [
            ctBullet(
                'Customize the Cut behavior using contextMenuBuilder on '
                'TextField to control what happens when Cut is tapped.'),
            ctBullet(
                'Remember to handle both clipboard writing AND text deletion '
                'in the custom callback.'),
            ctCodeBlock(
                '// Custom cut with logging\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCut: () {\n'
                '        final sel = editableTextState\n'
                '            .textEditingValue.selection;\n'
                '        final text = sel.textInside(\n'
                '            editableTextState.textEditingValue.text);\n'
                '        Clipboard.setData(ClipboardData(text: text));\n'
                '        print(\'Cut text: \$text\');\n'
                '        editableTextState.cutSelection(\n'
                '            SelectionChangedCause.toolbar);\n'
                '      },\n'
                '      onCopy: null,\n'
                '      onPaste: null,\n'
                '      onSelectAll: null,\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 9. comparison with other menu items ──
          ctSection('9 · Comparison with Other Menu Items', [
            ctCompare('Cut', 'Writes to clipboard AND deletes from field'),
            ctCompare('Copy', 'Writes to clipboard, field unchanged'),
            ctCompare('Paste', 'Reads from clipboard, inserts into field'),
            ctCompare('Select All', 'Expands selection, no clipboard interaction'),
            ctCompare('Delete', 'Removes text without clipboard write (not in iOS menu)'),
            ctDivider(),
            ctBullet(
                'Cut is unique because it modifies both the clipboard AND '
                'the text field content in a single action.'),
          ]),

          // ── 10. CupertinoTextField integration ──
          ctSection('10 · CupertinoTextField & TextField Integration', [
            ctBullet(
                'Both CupertinoTextField and TextField support Cut out of the '
                'box when the field is editable and text is selected.'),
            ctBullet(
                'The keyboard shortcut Cmd+X (macOS) / Ctrl+X (other platforms) '
                'triggers the same cut action as the context menu button.'),
            ctCodeBlock(
                '// Standard TextField with Cut support\n'
                'TextField(\n'
                '  controller: TextEditingController(\n'
                '    text: \'Select some text, then use Cut\',\n'
                '  ),\n'
                ')\n'
                '\n'
                '// CupertinoTextField with Cut support\n'
                'CupertinoTextField(\n'
                '  controller: TextEditingController(\n'
                '    text: \'Cupertino field with Cut\',\n'
                '  ),\n'
                ')'),
            ctDivider(),
            ctKeyValue('Keyboard shortcut', 'Cmd+X on macOS, Ctrl+X elsewhere'),
            ctKeyValue('Intent class', 'CutSelectionTextIntent'),
            ctKeyValue('Action class', 'CutSelectionAction (in EditableText)'),
          ]),

          // ── 11. obscured text / password ──
          ctSection('11 · Password Fields & Security', [
            ctBullet(
                'Cut is intentionally disabled in password fields '
                '(obscureText: true) to prevent credential extraction.'),
            ctBullet(
                'If you build a custom contextMenuBuilder for a password '
                'field, never add a Cut action – it violates platform '
                'security conventions.'),
            ctBullet(
                'The keyboard shortcut Cmd+X is also disabled in '
                'obscured text fields for the same reason.'),
            ctHighlight(
                'Apple App Store review may reject apps that allow Cut '
                'from password fields. Always respect the obscureText flag.'),
          ]),

          // ── 12. haptic feedback ──
          ctSection('12 · Haptic Feedback & Visual Response', [
            ctBullet(
                'Tapping Cut triggers a subtle haptic through the Taptic '
                'Engine on supported iOS devices.'),
            ctBullet(
                'The button shows a highlight on press, then the menu '
                'dismisses and the selected text visually disappears '
                'from the field.'),
            ctBullet(
                'The visual transition is immediate – the text removal '
                'happens synchronously within the same frame as the '
                'clipboard write.'),
            ctDivider(),
            ctKeyValue('Haptic', 'UIImpactFeedbackGenerator (light)'),
            ctKeyValue('Visual', 'Text removal + caret repositioning'),
            ctKeyValue('Menu', 'Auto-dismisses after action'),
          ]),

          // ── 13. accessibility ──
          ctSection('13 · VoiceOver & Accessibility', [
            ctBullet(
                'The Cut item is labeled "Cut" in the accessibility tree, '
                'announced as "Cut, button" by VoiceOver.'),
            ctBullet(
                'After cutting, VoiceOver announces the text field change '
                'including the new content and cursor position.'),
            ctBullet(
                'The accessibility hint explains the destructive nature: '
                '"Removes the selected text and places it on the clipboard."'),
            ctDivider(),
            ctKeyValue('A11y label', '"Cut"'),
            ctKeyValue('A11y trait', 'Button'),
            ctKeyValue('A11y hint',
                '"Removes the selected text and copies it"'),
          ]),

          // ── 14. edge cases ──
          ctSection('14 · Edge Cases & Boundary Conditions', [
            ctBullet(
                'Cutting entire text content: the field becomes empty, '
                'caret collapses to offset 0.'),
            ctBullet(
                'Cutting a single character: precise clipboard content '
                'and field update for the minimal case.'),
            ctBullet(
                'Cutting text with newlines: all whitespace and line breaks '
                'are preserved on the clipboard.'),
            ctBullet(
                'Cutting emoji: multi-code-point emoji are cut as complete '
                'grapheme clusters, preserving visual integrity.'),
            ctBullet(
                'Rapid cut operations: each cut is independent; the clipboard '
                'only retains the most recent cut text.'),
            ctDivider(),
            ctBullet(
                'If the selection is programmatically changed between the '
                'button press and the action execution (rare), the action '
                'uses the selection at execution time.'),
          ]),

          // ── 15. testing strategies ──
          ctSection('15 · Testing Strategies', [
            ctBullet(
                'Verify that text is removed from the field after Cut.'),
            ctBullet(
                'Verify that Clipboard.getData returns the cut text.'),
            ctBullet(
                'Verify that the selection collapses to the start of '
                'the former selection.'),
            ctCodeBlock(
                'testWidgets(\'cut removes text and copies to clipboard\',\n'
                '    (WidgetTester tester) async {\n'
                '  final controller = TextEditingController(\n'
                '    text: \'Hello World\',\n'
                '  );\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: TextField(controller: controller),\n'
                '    ),\n'
                '  ));\n'
                '  // Select "World", trigger Cut\n'
                '  // Verify controller.text == "Hello "\n'
                '  // Verify clipboard contains "World"\n'
                '});'),
            ctDivider(),
            ctBullet(
                'Test on TargetPlatform.iOS to get the Cupertino toolbar.'),
          ]),

          // ── 16. platform differences ──
          ctSection('16 · Platform Differences', [
            ctKeyValue('iOS',
                'Cupertino callout bar with Cut as first item'),
            ctKeyValue('Android',
                'Material toolbar, Cut may appear in different position'),
            ctKeyValue('macOS',
                'Right-click context menu with Cut entry'),
            ctKeyValue('Web',
                'Browser-native or Flutter-rendered toolbar'),
            ctDivider(),
            ctBullet(
                'The Cut functionality is identical across platforms; only '
                'the visual presentation of the menu item differs.'),
          ]),

          // ── 17. API summary ──
          ctSection('17 · Quick API Reference', [
            ctKeyValue('Class', 'IOSSystemContextMenuItemCut'),
            ctKeyValue('Platform', 'iOS only'),
            ctKeyValue('Action', 'Cut = Copy to clipboard + Delete from field'),
            ctKeyValue('Visibility', 'Editable + non-collapsed + non-obscured'),
            ctKeyValue('Shortcut', 'Cmd+X (macOS) / Ctrl+X (others)'),
            ctKeyValue('Undo', 'Cmd+Z restores cut text'),
            ctDivider(),
            ctCodeBlock(
                '// Cut is auto-provided by the toolbar:\n'
                'TextField(\n'
                '  contextMenuBuilder: (ctx, state) {\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      anchors: state.contextMenuAnchors,\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCut: () => state.cutSelection(\n'
                '          SelectionChangedCause.toolbar),\n'
                '      onCopy: () => state.copySelection(\n'
                '          SelectionChangedCause.toolbar),\n'
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
            color: ctForest.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemCut · Forest Emerald Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ctMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
