// ignore_for_file: avoid_print
// IOSSystemContextMenuItemPaste – comprehensive deep demo
// Copper / Sand palette – iOS system "Paste" context menu action:
// reads from the clipboard and inserts content into the text field.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ptCopper = Color(0xFFBF360C);
  const Color ptSand = Color(0xFFFBE9E7);
  const Color ptOnCopper = Color(0xFFFFFFFF);
  const Color ptDeep = Color(0xFF870000);
  const Color ptLightSand = Color(0xFFFFF3F0);
  const Color ptTextDark = Color(0xFF3E1508);
  const Color ptAccent = Color(0xFFFF7043);
  const Color ptMuted = Color(0xFFFFAB91);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ptHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ptCopper, ptDeep],
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
                  color: ptOnCopper)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ptOnCopper.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ptSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ptLightSand,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ptCopper.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ptCopper.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ptCopper)),
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

  Widget ptBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('■ ',
              style: TextStyle(color: ptAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ptTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ptCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A0A00),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ptSand,
              height: 1.5)),
    );
  }

  Widget ptKeyValue(String key, String value) {
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
                    color: ptDeep)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ptTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ptHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ptAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ptAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ptDeep,
              height: 1.4)),
    );
  }

  Widget ptDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ptMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ptInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ptCopper.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ptCopper)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ptDeep)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ptTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ptCompare(String label, String desc) {
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
              color: ptCopper,
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
                          color: ptDeep)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: ptTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ptSand,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ptHeader(
            'IOSSystemContextMenuItemPaste',
            'iOS system "Paste" context menu action – reads text from '
                'the clipboard and inserts it into the active text field',
          ),

          // ── 1. class overview ──
          ptSection('1 · Class Identity & Role', [
            ptKeyValue('Class', 'IOSSystemContextMenuItemPaste'),
            ptKeyValue('Platform', 'iOS (Cupertino)'),
            ptKeyValue('Action',
                'Reads clipboard and inserts at cursor / replaces selection'),
            ptKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            ptDivider(),
            ptBullet(
                'IOSSystemContextMenuItemPaste represents the "Paste" button '
                'in the iOS native text selection context menu. It reads '
                'the system clipboard and inserts the content.'),
            ptBullet(
                'Paste is the complement of Copy and Cut: while those write '
                'to the clipboard, Paste reads from it.'),
            ptBullet(
                'If text is selected when Paste is tapped, the clipboard '
                'content REPLACES the selection. If the caret is collapsed, '
                'the clipboard content is INSERTED at the caret position.'),
          ]),

          // ── 2. paste action internals ──
          ptSection('2 · Paste Action Internals', [
            ptBullet(
                'Step 1: Read clipboard via Clipboard.getData(Clipboard.kTextPlain).'),
            ptBullet(
                'Step 2: If clipboard has text and the field is editable, '
                'proceed with insertion.'),
            ptBullet(
                'Step 3: Replace the selected range (or insert at collapsed '
                'caret) with the clipboard text.'),
            ptBullet(
                'Step 4: Update TextEditingValue with new text and collapsed '
                'selection at the end of the pasted content.'),
            ptDivider(),
            ptCodeBlock(
                '// Internal paste implementation\n'
                'void handlePaste(TextEditingValue value) async {\n'
                '  final data = await Clipboard.getData(\n'
                '    Clipboard.kTextPlain,\n'
                '  );\n'
                '  if (data?.text == null) return;\n'
                '  final sel = value.selection;\n'
                '  final before = sel.textBefore(value.text);\n'
                '  final after = sel.textAfter(value.text);\n'
                '  final newText = before + data!.text! + after;\n'
                '  controller.value = TextEditingValue(\n'
                '    text: newText,\n'
                '    selection: TextSelection.collapsed(\n'
                '      offset: before.length + data.text!.length,\n'
                '    ),\n'
                '  );\n'
                '}'),
          ]),

          // ── 3. visibility conditions ──
          ptSection('3 · When Paste Appears', [
            ptBullet(
                'The Paste item appears when ALL conditions are met:'),
            ptKeyValue('Editable field',
                'The field is not read-only (readOnly: false)'),
            ptKeyValue('Clipboard has text',
                'UIPasteboard.general contains text data'),
            ptKeyValue('Field accepts input',
                'The field is focusable and enabled'),
            ptDivider(),
            ptBullet(
                'In read-only fields (readOnly: true or SelectableText), '
                'Paste is hidden because text cannot be inserted.'),
            ptBullet(
                'When the clipboard is empty, Paste is typically hidden or '
                'grayed out to indicate no pasteable content.'),
            ptBullet(
                'Paste appears regardless of selection state: it works '
                'with both collapsed caret and active selection.'),
          ]),

          // ── 4. iOS 16+ paste permission dialog ──
          ptSection('4 · iOS 16+ Paste Permission Dialog', [
            ptHighlight(
                'Starting with iOS 16, pasting from another app triggers a '
                'system permission dialog: "App would like to paste from '
                'Other App. Allow Paste?" This is a privacy measure to '
                'prevent silent clipboard snooping.'),
            ptBullet(
                'The dialog appears ONLY when the clipboard content was '
                'written by a DIFFERENT app. Same-app pastes do not trigger it.'),
            ptBullet(
                'The user must tap "Allow Paste" to complete the paste '
                'operation. "Don\'t Allow" cancels the paste silently.'),
            ptBullet(
                'This dialog cannot be suppressed or customized by the app – '
                'it is a system-level privacy protection.'),
            ptDivider(),
            ptCodeBlock(
                '// iOS 16+ paste permission flow:\n'
                '// 1. User taps Paste\n'
                '// 2. System checks clipboard source app\n'
                '// 3. If different app: shows permission dialog\n'
                '// 4. User taps "Allow Paste" or "Don\'t Allow"\n'
                '// 5. If allowed: paste completes normally\n'
                '// 6. If denied: paste is silently cancelled'),
          ]),

          // ── 5. UIPasteControl (iOS 16+) ──
          ptSection('5 · UIPasteControl (iOS 16+)', [
            ptBullet(
                'iOS 16 introduced UIPasteControl as an alternative to the '
                'context menu Paste that bypasses the permission dialog.'),
            ptBullet(
                'UIPasteControl is a dedicated button that the user taps '
                'specifically for paste, so the system treats it as explicit '
                'consent and does not show the dialog.'),
            ptBullet(
                'Flutter does not directly expose UIPasteControl, but the '
                'system Paste in the Cupertino toolbar handles the dialog.'),
            ptDivider(),
            ptKeyValue('UIPasteControl', 'No dialog (implicit consent)'),
            ptKeyValue('Context menu Paste',
                'Shows dialog for cross-app paste'),
            ptKeyValue('Keyboard Cmd+V',
                'Shows dialog for cross-app paste'),
          ]),

          // ── 6. clipboard content types ──
          ptSection('6 · Clipboard Content Types', [
            ptInfoRow('T', 'Plain text:', 'String data from kTextPlain'),
            ptInfoRow('R', 'Rich text:', 'Attributed strings (not in Flutter)'),
            ptInfoRow('I', 'Images:', 'Not handled by text field Paste'),
            ptInfoRow('U', 'URLs:', 'Pasted as plain text string'),
            ptDivider(),
            ptBullet(
                'Flutter text fields only paste plain text (Clipboard.kTextPlain). '
                'Rich formatting is stripped during the paste operation.'),
            ptBullet(
                'If the clipboard contains only images (no text representation), '
                'the Paste action may not be available or will insert nothing.'),
            ptBullet(
                'URLs on the clipboard are pasted as their string '
                'representation (e.g., "https://example.com").'),
          ]),

          // ── 7. paste and undo ──
          ptSection('7 · Paste and Undo Behavior', [
            ptBullet(
                'Paste is recorded in the undo history. Pressing Cmd+Z '
                'after paste removes the pasted text and restores the '
                'previous content and selection.'),
            ptBullet(
                'If paste replaced a selection, undo restores both the '
                'original text AND the selection state.'),
            ptBullet(
                'Multiple consecutive pastes create separate undo entries.'),
            ptCodeBlock(
                '// Undo after paste:\n'
                '// Before: "Hello [world]" (world selected)\n'
                '// Paste "Flutter": "Hello Flutter|"\n'
                '// Undo (Cmd+Z): "Hello [world]" (restored)'),
          ]),

          // ── 8. CupertinoTextField integration ──
          ptSection('8 · CupertinoTextField & TextField Integration', [
            ptBullet(
                'Both CupertinoTextField and TextField support Paste out '
                'of the box when the field is editable.'),
            ptBullet(
                'The keyboard shortcut Cmd+V (macOS) / Ctrl+V (other '
                'platforms) triggers the same paste action.'),
            ptCodeBlock(
                '// Standard TextField with Paste support\n'
                'TextField(\n'
                '  controller: TextEditingController(),\n'
                '  // Paste appears automatically when clipboard has text\n'
                ')\n'
                '\n'
                '// CupertinoTextField with Paste support\n'
                'CupertinoTextField(\n'
                '  placeholder: \'Paste something here...\',\n'
                ')'),
            ptDivider(),
            ptKeyValue('Shortcut', 'Cmd+V on macOS, Ctrl+V elsewhere'),
            ptKeyValue('Intent', 'PasteTextIntent'),
            ptKeyValue('Action', 'PasteTextAction (in EditableText)'),
          ]),

          // ── 9. custom paste overrides ──
          ptSection('9 · Custom Paste Overrides', [
            ptBullet(
                'Use contextMenuBuilder to customize the Paste behavior, '
                'for example to validate or transform clipboard content '
                'before insertion.'),
            ptCodeBlock(
                '// Custom paste with validation\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCut: null,\n'
                '      onCopy: null,\n'
                '      onPaste: () async {\n'
                '        final data = await Clipboard.getData(\n'
                '          Clipboard.kTextPlain,\n'
                '        );\n'
                '        if (data?.text != null) {\n'
                '          // Transform: uppercase the pasted text\n'
                '          final upper = data!.text!.toUpperCase();\n'
                '          editableTextState.userUpdateTextEditingValue(\n'
                '            editableTextState.textEditingValue.replaced(\n'
                '              editableTextState\n'
                '                  .textEditingValue.selection,\n'
                '              upper,\n'
                '            ),\n'
                '            SelectionChangedCause.toolbar,\n'
                '          );\n'
                '        }\n'
                '        editableTextState\n'
                '            .hideToolbar(false);\n'
                '      },\n'
                '      onSelectAll: null,\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 10. comparison with other operations ──
          ptSection('10 · Comparison with Other Menu Items', [
            ptCompare('Paste', 'Reads clipboard, inserts into field'),
            ptCompare('Cut', 'Writes to clipboard, deletes from field'),
            ptCompare('Copy', 'Writes to clipboard, field unchanged'),
            ptCompare('Select All', 'Selects all text, no clipboard interaction'),
            ptDivider(),
            ptBullet(
                'Paste is the only primary context menu action that READS '
                'from the clipboard. Cut and Copy both WRITE to it.'),
            ptBullet(
                'Paste modifies the text field content. Cut also modifies '
                'it. Copy and Select All do not.'),
          ]),

          // ── 11. empty clipboard behavior ──
          ptSection('11 · Empty Clipboard Behavior', [
            ptBullet(
                'When the system clipboard is empty (no text data), the '
                'Paste button is typically hidden from the context menu.'),
            ptBullet(
                'ClipboardStatus.unknown means the clipboard content has '
                'not been checked yet. The system queries it asynchronously.'),
            ptBullet(
                'ClipboardStatus.pasteable means text is available on the '
                'clipboard and Paste can be shown.'),
            ptBullet(
                'ClipboardStatus.notPasteable means no text is available.'),
            ptDivider(),
            ptCodeBlock(
                '// ClipboardStatus enum:\n'
                '// - pasteable: clipboard has text → show Paste\n'
                '// - notPasteable: clipboard empty → hide Paste\n'
                '// - unknown: not yet checked → may show dimmed\n'
                '//\n'
                '// The status is checked asynchronously when the\n'
                '// context menu is about to appear.'),
          ]),

          // ── 12. obscured text / password fields ──
          ptSection('12 · Password Fields & Paste', [
            ptBullet(
                'Unlike Cut and Copy, Paste IS allowed in obscured text '
                'fields (obscureText: true). Users can paste passwords.'),
            ptBullet(
                'This design allows password managers to paste generated '
                'passwords into login fields.'),
            ptBullet(
                'The pasted text is immediately obscured (shown as dots) '
                'just like manually typed characters.'),
            ptHighlight(
                'Disabling Paste in password fields is considered an '
                'anti-pattern by security experts and Apple HIG. Password '
                'managers need paste access to function properly.'),
          ]),

          // ── 13. maxLength interaction ──
          ptSection('13 · maxLength and Input Formatters', [
            ptBullet(
                'If the TextField has a maxLength set, pasting text that '
                'would exceed the limit results in truncation.'),
            ptBullet(
                'The maxLengthEnforcement property controls the behavior: '
                'MaxLengthEnforcement.enforced truncates, while '
                'MaxLengthEnforcement.none allows overflow.'),
            ptBullet(
                'Custom inputFormatters are applied to pasted text just '
                'like typed text. A digits-only formatter will strip '
                'non-numeric characters from the pasted content.'),
            ptCodeBlock(
                '// Paste with maxLength enforcement\n'
                'TextField(\n'
                '  maxLength: 10,\n'
                '  maxLengthEnforcement:\n'
                '      MaxLengthEnforcement.enforced,\n'
                '  // Pasting "Hello World!!" → "Hello Worl"\n'
                ')\n'
                '\n'
                '// Paste with input formatter\n'
                'TextField(\n'
                '  inputFormatters: [\n'
                '    FilteringTextInputFormatter.digitsOnly,\n'
                '  ],\n'
                '  // Pasting "abc123def" → "123"\n'
                ')'),
          ]),

          // ── 14. platform differences ──
          ptSection('14 · Platform Differences', [
            ptKeyValue('iOS', 'Cupertino callout bar with Paste'),
            ptKeyValue('iOS 16+', 'Permission dialog for cross-app paste'),
            ptKeyValue('Android', 'Material toolbar, no permission dialog'),
            ptKeyValue('macOS', 'Right-click context menu with Paste'),
            ptKeyValue('Web', 'Browser clipboard API with permissions'),
            ptDivider(),
            ptBullet(
                'The iOS 16+ paste permission dialog is unique to Apple '
                'platforms. Android and web have different clipboard '
                'permission models.'),
            ptBullet(
                'Web browsers may show their own permission prompt for '
                'clipboard access via the Clipboard API.'),
          ]),

          // ── 15. accessibility ──
          ptSection('15 · VoiceOver & Accessibility', [
            ptBullet(
                'Paste is announced as "Paste, button" by VoiceOver in '
                'the context menu.'),
            ptBullet(
                'After pasting, VoiceOver announces the updated text content '
                'and the new cursor position.'),
            ptBullet(
                'The accessibility hint describes the action: "Inserts the '
                'contents of the clipboard into the text field."'),
            ptDivider(),
            ptKeyValue('A11y label', '"Paste"'),
            ptKeyValue('A11y trait', 'Button'),
            ptKeyValue('A11y hint', '"Inserts clipboard contents"'),
          ]),

          // ── 16. edge cases ──
          ptSection('16 · Edge Cases', [
            ptBullet(
                'Pasting multi-line text into a single-line field: newlines '
                'may be stripped or converted to spaces depending on the '
                'field configuration.'),
            ptBullet(
                'Pasting very long text (>100KB): may cause frame drops '
                'during the insertion. The operation itself completes.'),
            ptBullet(
                'Pasting emoji: multi-code-point emoji are inserted as '
                'complete grapheme clusters.'),
            ptBullet(
                'Pasting RTL text into LTR field: the text direction of '
                'the pasted content is determined by the field directionality.'),
            ptBullet(
                'Rapid paste operations: each paste reads the clipboard at '
                'execution time, so content changes between pastes are '
                'reflected correctly.'),
          ]),

          // ── 17. API summary ──
          ptSection('17 · Quick API Reference', [
            ptKeyValue('Class', 'IOSSystemContextMenuItemPaste'),
            ptKeyValue('Platform', 'iOS / Cupertino'),
            ptKeyValue('Action', 'Read clipboard → insert at cursor'),
            ptKeyValue('Visibility', 'Editable + clipboard has text'),
            ptKeyValue('Shortcut', 'Cmd+V (macOS) / Ctrl+V (others)'),
            ptKeyValue('Password fields', 'Allowed (important for a11y)'),
            ptDivider(),
            ptCodeBlock(
                '// Paste is auto-provided by the toolbar:\n'
                'TextField(\n'
                '  contextMenuBuilder: (ctx, state) {\n'
                '    return AdaptiveTextSelectionToolbar.editable(\n'
                '      anchors: state.contextMenuAnchors,\n'
                '      clipboardStatus: ClipboardStatus.pasteable,\n'
                '      onCut: null,\n'
                '      onCopy: null,\n'
                '      onPaste: () => state.pasteText(\n'
                '          SelectionChangedCause.toolbar),\n'
                '      onSelectAll: null,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ptCopper.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemPaste · Copper Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ptMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
