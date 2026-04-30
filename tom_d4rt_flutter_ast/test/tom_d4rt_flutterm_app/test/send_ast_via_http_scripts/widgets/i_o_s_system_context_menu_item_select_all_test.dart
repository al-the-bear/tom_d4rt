// ignore_for_file: avoid_print
// IOSSystemContextMenuItemSelectAll – comprehensive deep demo
// Plum / Blush palette – iOS "Select All" context menu action:
// selects the entire text content in the field.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color saPlum = Color(0xFF880E4F);
  const Color saBlush = Color(0xFFFCE4EC);
  const Color saOnPlum = Color(0xFFFFFFFF);
  const Color saDark = Color(0xFF560027);
  const Color saLightBlush = Color(0xFFFFF0F3);
  const Color saTextDark = Color(0xFF3E1929);
  const Color saAccent = Color(0xFFEC407A);
  const Color saMuted = Color(0xFFF48FB1);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget saHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [saPlum, saDark],
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
                  color: saOnPlum)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: saOnPlum.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget saSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: saLightBlush,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: saPlum.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: saPlum.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: saPlum)),
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

  Widget saBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('♦ ',
              style: TextStyle(color: saAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: saTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget saCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C0A1A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: saBlush,
              height: 1.5)),
    );
  }

  Widget saKeyValue(String key, String value) {
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
                    color: saDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: saTextDark)),
          ),
        ],
      ),
    );
  }

  Widget saHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: saAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: saAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: saDark,
              height: 1.4)),
    );
  }

  Widget saDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: saMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget saInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: saPlum.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: saPlum)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: saDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: saTextDark)),
          ),
        ],
      ),
    );
  }

  Widget saCompare(String label, String desc) {
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
              color: saPlum,
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
                          color: saDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: saTextDark)),
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
    color: saBlush,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          saHeader(
            'IOSSystemContextMenuItemSelectAll',
            'iOS "Select All" context menu action – selects the '
                'entire text content in an editable or read-only field',
          ),

          // ── 1. class overview ──
          saSection('1 · Class Identity & Role', [
            saKeyValue('Class', 'IOSSystemContextMenuItemSelectAll'),
            saKeyValue('Platform', 'iOS / iPadOS'),
            saKeyValue('Action', 'Selects all text in the field'),
            saKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            saDivider(),
            saBullet(
                'IOSSystemContextMenuItemSelectAll represents the '
                '"Select All" button in the iOS text selection context menu.'),
            saBullet(
                'Tapping it selects the entire text content from the '
                'start to the end of the field, making the selection '
                'cover every character.'),
            saBullet(
                'This is a LOCAL operation – it never touches the clipboard, '
                'the network, or leaves the app.'),
          ]),

          // ── 2. select all behavior ──
          saSection('2 · Select All Action Effect', [
            saBullet(
                'Step 1: User taps into a text field (cursor appears).'),
            saBullet(
                'Step 2: User long-presses or double-taps to open context menu.'),
            saBullet(
                'Step 3: User taps "Select All" from the callout bar.'),
            saBullet(
                'Step 4: iOS sets TextSelection(baseOffset: 0, '
                'extentOffset: text.length).'),
            saBullet(
                'Step 5: The callout bar updates to show Cut, Copy, and other '
                'actions now that text is selected.'),
            saDivider(),
            saHighlight(
                'Select All replaces the current selection with a full selection. '
                'If text was already partially selected, the selection expands. '
                'If text was already fully selected, nothing visible changes.'),
          ]),

          // ── 3. visibility conditions ──
          saSection('3 · When Select All Appears', [
            saBullet(
                'Appears when the field has text content and NOT all of it '
                'is already selected.'),
            saBullet(
                'Hidden when the field is empty – there is nothing to select.'),
            saBullet(
                'Hidden when the entire text is already selected – Select All '
                'would be a no-op.'),
            saDivider(),
            saKeyValue('Text required', 'Yes (field must not be empty)'),
            saKeyValue('Full selection', 'Hides it (already selected all)'),
            saKeyValue('Editable required', 'No (works in read-only too)'),
            saKeyValue('Clipboard', 'Not involved'),
          ]),

          // ── 4. menu position ──
          saSection('4 · Context Menu Positioning', [
            saBullet(
                'Select All is a PRIMARY item. It appears on the first '
                'page of the iOS callout bar.'),
            saBullet(
                'Typical primary row order (when applicable): Cut | Copy | '
                'Paste | Select All.'),
            saBullet(
                'When there is no selection but a cursor exists, the menu '
                'may show only: Select | Select All | Paste.'),
            saDivider(),
            saKeyValue('Position', 'Primary row of callout bar'),
            saKeyValue('Icon', 'None (text label only)'),
            saKeyValue('Label', '"Select All" (localized)'),
          ]),

          // ── 5. selection behavior details ──
          saSection('5 · Selection Mechanics', [
            saBullet(
                'Select All sets the TextSelection with baseOffset = 0 and '
                'extentOffset = text.length.'),
            saBullet(
                'This is equivalent to pressing Cmd+A on macOS or Ctrl+A '
                'on Windows/Linux.'),
            saCodeBlock(
                '// What Select All does internally:\n'
                'final fullSelection = TextSelection(\n'
                '  baseOffset: 0,\n'
                '  extentOffset: controller.text.length,\n'
                ');\n'
                'controller.selection = fullSelection;\n'
                '\n'
                '// After Select All:\n'
                '// controller.selection.start == 0\n'
                '// controller.selection.end == controller.text.length\n'
                '// controller.selection.isCollapsed == false'),
            saDivider(),
            saBullet(
                'The selection handles appear at the start and end of the text. '
                'The user can drag either handle to refine the selection.'),
          ]),

          // ── 6. interaction with other actions ──
          saSection('6 · What Happens After Select All', [
            saInfoRow('✂', 'Cut:', 'Removes all text, writes to clipboard'),
            saInfoRow('⎘', 'Copy:', 'Writes all text to clipboard'),
            saInfoRow('⌫', 'Delete:', 'Typing replaces entire content'),
            saInfoRow('↗', 'Share:', 'Shares the full text content'),
            saInfoRow('🔍', 'Search:', 'Searches full text on the web'),
            saDivider(),
            saBullet(
                'Select All is commonly used as a preparatory step before '
                'Cut, Copy, or Delete operations.'),
            saBullet(
                'In a typical "replace all text" flow: Select All → Paste '
                'replaces the entire field content.'),
          ]),

          // ── 7. Flutter integration ──
          saSection('7 · Flutter Framework Integration', [
            saBullet(
                'Select All is auto-provided by EditableText when the system '
                'toolbar is shown. Flutter maps it to selectAll().'),
            saBullet(
                'In TextSelectionControls, handleSelectAll() calls '
                'textEditingValue.selectAll() on the delegate.'),
            saCodeBlock(
                '// Flutter handles Select All internally:\n'
                'void handleSelectAll(TextSelectionDelegate delegate) {\n'
                '  delegate.selectAll(SelectionChangedCause.toolbar);\n'
                '  delegate.hideToolbar();\n'
                '}\n'
                '\n'
                '// This sets the selection to cover the full text\n'
                '// and hides the toolbar (it reappears with new items)'),
            saDivider(),
            saBullet(
                'If you implement a custom contextMenuBuilder, include the '
                'system selectAll button to preserve this functionality.'),
          ]),

          // ── 8. class properties ──
          saSection('8 · Class Properties & Constructor', [
            saCodeBlock(
                '// IOSSystemContextMenuItemSelectAll is a final class\n'
                '// with a const constructor.\n'
                'const IOSSystemContextMenuItemSelectAll({\n'
                '  super.title,  // optional custom label\n'
                '})\n'
                '\n'
                '// Usage:\n'
                'const item = IOSSystemContextMenuItemSelectAll();\n'
                '// item.title → null (uses system default "Select All")\n'
                '\n'
                'const custom = IOSSystemContextMenuItemSelectAll(\n'
                '  title: \'Highlight Everything\',\n'
                ');\n'
                '// custom.title → "Highlight Everything"'),
            saDivider(),
            saKeyValue('title', 'Optional String, null uses system default'),
            saKeyValue('Const', 'Yes, supports const construction'),
            saKeyValue('Mixin', 'Diagnosticable for debug inspection'),
            saKeyValue('Superclass', 'IOSSystemContextMenuItem'),
          ]),

          // ── 9. multiline text fields ──
          saSection('9 · Select All in Multiline Fields', [
            saBullet(
                'In multiline TextField, Select All selects across ALL lines, '
                'not just the current line.'),
            saBullet(
                'The selection spans from the first character of the first '
                'line to the last character of the last line.'),
            saBullet(
                'Selection handles appear at the very top-left and very '
                'bottom-right of the text content.'),
            saDivider(),
            saCodeBlock(
                '// Multiline example:\n'
                '// Text: "Line 1\\nLine 2\\nLine 3"\n'
                '// After Select All:\n'
                '//   selection.start == 0\n'
                '//   selection.end == 20  (total chars)\n'
                '//   selectedText == "Line 1\\nLine 2\\nLine 3"'),
            saBullet(
                'If only one line needs to be selected, the user must '
                'manually drag the selection handles or triple-tap.'),
          ]),

          // ── 10. empty and read-only fields ──
          saSection('10 · Edge Cases: Empty & Read-Only', [
            saBullet(
                'Empty field: Select All is hidden because there is nothing '
                'to select. The menu shows only Paste (if clipboard has data).'),
            saBullet(
                'Read-only field: Select All IS shown (read-only still allows '
                'selection for copying). After Select All, Copy is available.'),
            saBullet(
                'Disabled field: No context menu appears at all. Select All '
                'is not accessible in a disabled TextField.'),
            saHighlight(
                'Read-only with full selection already active: Select All is '
                'hidden (it would be a no-op), but Copy remains available.'),
          ]),

          // ── 11. const canonicalization ──
          saSection('11 · Const Canonicalization & Identity', [
            saBullet(
                'IOSSystemContextMenuItemSelectAll supports const construction.'),
            saBullet(
                'Two const instances with the same arguments are identical '
                '(identical() returns true).'),
            saCodeBlock(
                '// Const canonicalization:\n'
                'const a = IOSSystemContextMenuItemSelectAll();\n'
                'const b = IOSSystemContextMenuItemSelectAll();\n'
                'identical(a, b); // true (same compile-time const)\n'
                '\n'
                'const c = IOSSystemContextMenuItemSelectAll(\n'
                '  title: \'All\',\n'
                ');\n'
                'const d = IOSSystemContextMenuItemSelectAll(\n'
                '  title: \'All\',\n'
                ');\n'
                'identical(c, d); // true (same title value)'),
            saDivider(),
            saBullet(
                'This is standard Dart behavior for all const classes. '
                'It also means hashCode and == work correctly.'),
          ]),

          // ── 12. platform differences ──
          saSection('12 · Platform Comparison', [
            saKeyValue('iOS', '"Select All" in primary callout bar'),
            saKeyValue('iPadOS', 'Same as iOS, wider callout bar'),
            saKeyValue('macOS', 'Edit > Select All (Cmd+A) in menu bar'),
            saKeyValue('Android', '"SELECT ALL" button in action mode'),
            saKeyValue('Web', 'Ctrl+A / Cmd+A keyboard shortcut'),
            saDivider(),
            saBullet(
                'On Android, the wording is "SELECT ALL" (all caps) in the '
                'action mode bar. On iOS, it is "Select All" (title case).'),
            saBullet(
                'On desktop platforms, Select All is primarily a keyboard '
                'shortcut rather than a context menu item.'),
          ]),

          // ── 13. VoiceOver accessibility ──
          saSection('13 · VoiceOver & Accessibility', [
            saBullet(
                'VoiceOver announces "Select All, button" when focused.'),
            saBullet(
                'The accessibility hint is "Selects all text."'),
            saBullet(
                'After activation, VoiceOver announces the selected text '
                'range and updated toolbar options.'),
            saDivider(),
            saKeyValue('A11y label', '"Select All"'),
            saKeyValue('A11y trait', 'Button'),
            saKeyValue('A11y hint', '"Selects all text"'),
          ]),

          // ── 14. SelectableText ──
          saSection('14 · Select All in SelectableText', [
            saBullet(
                'SelectableText (read-only rich text widget) also supports '
                'Select All through the system context menu.'),
            saBullet(
                'Unlike TextField, SelectableText does not have editability – '
                'after Select All, only Copy and Share are available.'),
            saCodeBlock(
                '// SelectableText usage:\n'
                'SelectableText(\n'
                '  \'Long article text that the user may want to copy...\',\n'
                '  showCursor: true,\n'
                '  toolbarOptions: ToolbarOptions(\n'
                '    selectAll: true, // ensure Select All is available\n'
                '    copy: true,\n'
                '  ),\n'
                ')'),
            saDivider(),
            saBullet(
                'In Flutter, SelectableText.rich() also supports Select All '
                'across mixed TextSpan styles (bold, italic, links, etc.).'),
          ]),

          // ── 15. comparison with all menu items ──
          saSection('15 · Complete iOS Menu Item Reference', [
            saCompare('Cut', 'Clipboard write + delete (editable only)'),
            saCompare('Copy', 'Clipboard write (any field)'),
            saCompare('Paste', 'Clipboard read + insert (editable only)'),
            saCompare('Select All', 'Full text selection (any non-empty field)'),
            saCompare('Look Up', 'Inline dictionary/wiki (any field)'),
            saCompare('Translate', 'System translation (any field)'),
            saCompare('Search Web', 'Safari search (any field)'),
            saCompare('Share', 'Share sheet (any field)'),
            saCompare('Scan Text', 'Camera OCR (editable only)'),
          ]),

          // ── 16. quick API reference ──
          saSection('16 · Quick API Reference', [
            saKeyValue('Class', 'IOSSystemContextMenuItemSelectAll'),
            saKeyValue('Platform', 'iOS / iPadOS'),
            saKeyValue('Action', 'Selects all text in the field'),
            saKeyValue('Visibility', 'Non-empty field, not fully selected'),
            saKeyValue('Modifies text', 'No (only changes selection)'),
            saKeyValue('Modifies clipboard', 'No'),
            saKeyValue('Leaves app', 'No'),
            saDivider(),
            saCodeBlock(
                '// Select All is auto-included by the system toolbar.\n'
                'const item = IOSSystemContextMenuItemSelectAll();\n'
                'print(item.title); // null (system default)\n'
                'print(item is IOSSystemContextMenuItem); // true\n'
                '\n'
                'const custom = IOSSystemContextMenuItemSelectAll(\n'
                '  title: \'Highlight All\',\n'
                ');'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: saPlum.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemSelectAll · Plum Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: saMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
