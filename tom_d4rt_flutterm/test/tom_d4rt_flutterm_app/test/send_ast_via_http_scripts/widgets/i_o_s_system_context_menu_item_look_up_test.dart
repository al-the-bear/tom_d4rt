// ignore_for_file: avoid_print
// IOSSystemContextMenuItemLookUp – comprehensive deep demo
// Cobalt Blue / Ice palette – iOS "Look Up" dictionary action:
// provides inline dictionary definitions for selected words.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color luCobalt = Color(0xFF0D47A1);
  const Color luIce = Color(0xFFE3F2FD);
  const Color luOnCobalt = Color(0xFFFFFFFF);
  const Color luDeep = Color(0xFF002171);
  const Color luLightIce = Color(0xFFF0F7FF);
  const Color luTextDark = Color(0xFF0D253D);
  const Color luAccent = Color(0xFF42A5F5);
  const Color luMuted = Color(0xFF90CAF9);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget luHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [luCobalt, luDeep],
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
                  color: luOnCobalt)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: luOnCobalt.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget luSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: luLightIce,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: luCobalt.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: luCobalt.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: luCobalt)),
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

  Widget luBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('◉ ',
              style: TextStyle(color: luAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: luTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget luCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF001338),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: luIce,
              height: 1.5)),
    );
  }

  Widget luKeyValue(String key, String value) {
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
                    color: luDeep)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: luTextDark)),
          ),
        ],
      ),
    );
  }

  Widget luHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: luAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: luAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: luDeep,
              height: 1.4)),
    );
  }

  Widget luDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: luMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget luInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: luCobalt.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: luCobalt)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: luDeep)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: luTextDark)),
          ),
        ],
      ),
    );
  }

  Widget luCompare(String label, String desc) {
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
              color: luCobalt,
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
                          color: luDeep)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: luTextDark)),
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
    color: luIce,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          luHeader(
            'IOSSystemContextMenuItemLookUp',
            'iOS "Look Up" context menu action – provides inline dictionary '
                'definitions, Wikipedia summaries, and web results for selected text',
          ),

          // ── 1. class overview ──
          luSection('1 · Class Identity & Role', [
            luKeyValue('Class', 'IOSSystemContextMenuItemLookUp'),
            luKeyValue('Platform', 'iOS / iPadOS'),
            luKeyValue('Action',
                'Opens dictionary/encyclopedia lookup for selected text'),
            luKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            luDivider(),
            luBullet(
                'IOSSystemContextMenuItemLookUp represents the "Look Up" '
                'button in the iOS text selection context menu. Tapping it '
                'opens a system sheet with dictionary definitions.'),
            luBullet(
                'The Look Up feature aggregates results from multiple sources: '
                'the built-in dictionary, Wikipedia, Siri Knowledge, and web '
                'search suggestions.'),
            luBullet(
                'It operates on the SELECTED text – the user must have an '
                'active non-collapsed selection for Look Up to appear.'),
          ]),

          // ── 2. what look up shows ──
          luSection('2 · What Look Up Displays', [
            luInfoRow('D', 'Dictionary:', 'Word definitions from installed dictionaries'),
            luInfoRow('W', 'Wikipedia:', 'Summary paragraph from Wikipedia'),
            luInfoRow('S', 'Siri:', 'Siri Knowledge base results'),
            luInfoRow('N', 'News:', 'Related news articles'),
            luInfoRow('M', 'Maps:', 'Location info if text is a place name'),
            luDivider(),
            luBullet(
                'The results sheet is a system-level modal presented by iOS, '
                'not rendered by the app. It uses the UIReferenceLibraryViewController '
                'or the newer UIDefinitionReferenceLibraryViewController.'),
            luBullet(
                'The available sources depend on the iOS version and the '
                'installed dictionaries. Users can add dictionaries in '
                'Settings > General > Dictionary.'),
          ]),

          // ── 3. visibility conditions ──
          luSection('3 · When Look Up Appears', [
            luBullet(
                'The Look Up item appears when ALL conditions are met:'),
            luKeyValue('Non-collapsed selection',
                'baseOffset != extentOffset (text is selected)'),
            luKeyValue('Meaningful text',
                'Selected text contains recognizable word(s)'),
            luKeyValue('iOS platform',
                'Only available on iOS and iPadOS'),
            luDivider(),
            luBullet(
                'Unlike Cut, Look Up appears in BOTH editable and read-only '
                'fields. The text does not need to be writable.'),
            luBullet(
                'Look Up works with obscured text fields too, though the '
                'practical value is limited since the text is hidden.'),
            luBullet(
                'The item is available regardless of clipboard state – it '
                'does not interact with the clipboard at all.'),
          ]),

          // ── 4. look up action flow ──
          luSection('4 · Action Flow', [
            luBullet(
                'Step 1: User selects text in a TextField or SelectableText.'),
            luBullet(
                'Step 2: Context menu appears with Cut, Copy, Paste, Look Up, etc.'),
            luBullet(
                'Step 3: User taps "Look Up" in the secondary row.'),
            luBullet(
                'Step 4: iOS presents a system sheet with dictionary results.'),
            luBullet(
                'Step 5: User reads the definition and dismisses the sheet.'),
            luBullet(
                'Step 6: The text field retains its selection and focus.'),
            luDivider(),
            luHighlight(
                'Look Up is a read-only operation – it never modifies the '
                'text, the selection, or the clipboard. The field state is '
                'completely preserved after dismissing the Look Up sheet.'),
          ]),

          // ── 5. dictionary system ──
          luSection('5 · iOS Dictionary System', [
            luBullet(
                'iOS comes with built-in dictionaries for many languages. '
                'Additional dictionaries can be downloaded from Settings.'),
            luBullet(
                'The dictionary lookup uses the selected language context '
                'to choose the appropriate dictionary.'),
            luKeyValue('English', 'Oxford English Dictionary (built-in)'),
            luKeyValue('Chinese', 'Simplified and Traditional dictionaries'),
            luKeyValue('Japanese', 'Super Daijirin (built-in)'),
            luKeyValue('Multi-language',
                'Bilingual dictionaries like English-French'),
            luDivider(),
            luCodeBlock(
                '// Dictionary languages are managed at the OS level:\n'
                '// Settings > General > Dictionary\n'
                '// The app has no API to control which dictionaries\n'
                '// are available or which one is used.\n'
                '//\n'
                '// UIReferenceLibraryViewController.dictionaryHas\n'
                '// DefinitionForTerm(term) can check availability.'),
          ]),

          // ── 6. menu positioning ──
          luSection('6 · Context Menu Positioning', [
            luBullet(
                'Look Up is a SECONDARY item in the iOS callout bar. It does '
                'not appear on the first page of the menu.'),
            luBullet(
                'The user must tap the chevron (right arrow) in the callout '
                'bar to reveal the secondary row containing Look Up.'),
            luBullet(
                'Secondary row order: Look Up, Translate, Share, and '
                'optionally Scan Text and other platform items.'),
            luDivider(),
            luKeyValue('Position', 'Secondary row of callout bar'),
            luKeyValue('Icon', 'None (text label only)'),
            luKeyValue('Label', '"Look Up" (localized)'),
          ]),

          // ── 7. comparison with translate ──
          luSection('7 · Look Up vs Translate', [
            luCompare('Look Up', 'Shows dictionary definition, Wikipedia, Siri Knowledge'),
            luCompare('Translate', 'Translates selected text to another language'),
            luDivider(),
            luBullet(
                'Both are read-only operations that present a system sheet.'),
            luBullet(
                'Look Up is for understanding meaning; Translate is for '
                'language conversion.'),
            luBullet(
                'Both use on-device processing when possible; Translate may '
                'require a network connection for some language pairs.'),
            luBullet(
                'The UI presentation differs: Look Up shows a rich card with '
                'multiple sources; Translate shows a simple translation sheet.'),
          ]),

          // ── 8. Flutter integration ──
          luSection('8 · Flutter Framework Integration', [
            luBullet(
                'Flutter exposes Look Up through the CupertinoAdaptiveText'
                'SelectionToolbar when running on iOS.'),
            luBullet(
                'The native iOS platform handles the actual lookup UI – '
                'Flutter passes the selected text across the platform channel.'),
            luCodeBlock(
                '// Look Up is auto-provided by the system.\n'
                '// In custom contextMenuBuilder, include system buttons:\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    final buttonItems =\n'
                '        editableTextState.contextMenuButtonItems;\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: buttonItems, // includes Look Up\n'
                '    );\n'
                '  },\n'
                ')'),
            luDivider(),
            luBullet(
                'If you replace all buttonItems with custom ones, Look Up '
                'will not appear. It cannot be added manually.'),
          ]),

          // ── 9. class properties ──
          luSection('9 · Class Properties & Constructor', [
            luCodeBlock(
                '// IOSSystemContextMenuItemLookUp is a final class\n'
                '// with a const constructor.\n'
                'const IOSSystemContextMenuItemLookUp({\n'
                '  super.title,  // optional custom label\n'
                '})\n'
                '\n'
                '// Usage:\n'
                'const item = IOSSystemContextMenuItemLookUp();\n'
                '// item.title → null (uses system default "Look Up")\n'
                '\n'
                'const custom = IOSSystemContextMenuItemLookUp(\n'
                '  title: \'Define\',\n'
                ');\n'
                '// custom.title → "Define"'),
            luDivider(),
            luKeyValue('title', 'Optional String, null uses system default'),
            luKeyValue('Const', 'Yes, supports const construction'),
            luKeyValue('Mixin', 'Diagnosticable for debug inspection'),
            luKeyValue('Superclass', 'IOSSystemContextMenuItem'),
          ]),

          // ── 10. Diagnosticable ──
          luSection('10 · Diagnosticable Mixin', [
            luBullet(
                'IOSSystemContextMenuItemLookUp mixes in Diagnosticable, '
                'providing debug-friendly properties in DevTools.'),
            luCodeBlock(
                '// Debug output includes:\n'
                '// IOSSystemContextMenuItemLookUp\n'
                '//   title: "Look Up Selection"\n'
                '//\n'
                '// Access via:\n'
                'final builder = DiagnosticPropertiesBuilder();\n'
                'lookUpItem.debugFillProperties(builder);\n'
                '// builder.properties contains title property'),
            luDivider(),
            luBullet(
                'The Diagnosticable output is useful when debugging which '
                'context menu items are being generated by the toolbar.'),
          ]),

          // ── 11. SelectableText integration ──
          luSection('11 · SelectableText & Read-Only Fields', [
            luBullet(
                'Look Up is available in SelectableText widgets, not just '
                'editable TextFields. This makes it useful for content '
                'display screens.'),
            luCodeBlock(
                '// SelectableText provides Look Up automatically\n'
                'SelectableText(\n'
                '  \'Select a word to look it up in the dictionary.\',\n'
                '  style: TextStyle(fontSize: 16),\n'
                ')\n'
                '\n'
                '// Read-only TextField also supports Look Up\n'
                'TextField(\n'
                '  controller: TextEditingController(\n'
                '    text: \'Read-only text with Look Up\',\n'
                '  ),\n'
                '  readOnly: true,\n'
                ')'),
            luDivider(),
            luBullet(
                'In read-only fields, the menu shows: Copy, Look Up, Translate, '
                'Share – but NOT Cut or Paste.'),
          ]),

          // ── 12. platform constraints ──
          luSection('12 · Platform Constraints', [
            luKeyValue('iOS', 'Available (Look Up with dictionary)'),
            luKeyValue('iPadOS', 'Available (same as iOS)'),
            luKeyValue('macOS',
                'Available (Force Touch or right-click > Look Up)'),
            luKeyValue('Android', 'Not available (no equivalent)'),
            luKeyValue('Web', 'Not available'),
            luDivider(),
            luBullet(
                'On macOS, Look Up is triggered by Force Touch (3D Touch on '
                'trackpad) or through the right-click context menu.'),
            luBullet(
                'Android has a "Define" action in some keyboards but it is '
                'not part of the text selection context menu system.'),
          ]),

          // ── 13. network requirements ──
          luSection('13 · Offline & Network Behavior', [
            luBullet(
                'Dictionary definitions work fully offline – they use the '
                'locally installed dictionary databases.'),
            luBullet(
                'Wikipedia summaries, Siri Knowledge, news, and web results '
                'require a network connection.'),
            luBullet(
                'When offline, the Look Up sheet shows only the dictionary '
                'definition (if available) and omits network-dependent sections.'),
            luHighlight(
                'If the selected word is not in any installed dictionary AND '
                'the device is offline, the Look Up sheet shows "No definitions '
                'found" with an option to "Search the Web" when online.'),
          ]),

          // ── 14. multi-word selections ──
          luSection('14 · Multi-Word & Phrase Lookups', [
            luBullet(
                'Look Up works for single words AND multi-word phrases.'),
            luBullet(
                'For single words: shows dictionary definition, pronunciation, '
                'examples, and related words.'),
            luBullet(
                'For phrases: dictionary may not have an entry. Falls back to '
                'Wikipedia or web search results.'),
            luBullet(
                'For proper nouns (names, places): Siri Knowledge and '
                'Wikipedia are the primary result sources.'),
            luDivider(),
            luCodeBlock(
                '// Single word → dictionary definition\n'
                '// "ephemeral" → adjective, lasting for a short time\n'
                '//\n'
                '// Phrase → Wikipedia/web results\n'
                '// "machine learning" → Wikipedia summary\n'
                '//\n'
                '// Proper noun → Siri Knowledge\n'
                '// "Isaac Newton" → Knowledge card + Wikipedia'),
          ]),

          // ── 15. accessibility ──
          luSection('15 · VoiceOver & Accessibility', [
            luBullet(
                'Look Up is announced as "Look Up, button" by VoiceOver '
                'in the context menu.'),
            luBullet(
                'The Look Up results sheet is fully accessible – VoiceOver '
                'reads dictionary definitions, Wikipedia summaries, etc.'),
            luBullet(
                'The accessibility hint is "Shows definitions and related '
                'information for the selected text."'),
            luDivider(),
            luKeyValue('A11y label', '"Look Up"'),
            luKeyValue('A11y trait', 'Button'),
            luKeyValue('A11y hint',
                '"Shows definitions and related information"'),
          ]),

          // ── 16. edge cases ──
          luSection('16 · Edge Cases', [
            luBullet(
                'Emoji selection: Look Up shows the emoji name and meaning '
                'from the Unicode standard.'),
            luBullet(
                'Numbers: Look Up may show unit conversions or calculator '
                'results for numeric selections.'),
            luBullet(
                'URLs: Look Up shows a web preview for recognized URLs.'),
            luBullet(
                'Unknown words: shows "No definitions found" with a web '
                'search option.'),
            luBullet(
                'Very long selections (>100 characters): Look Up may '
                'truncate or fall back to web search only.'),
          ]),

          // ── 17. API summary ──
          luSection('17 · Quick API Reference', [
            luKeyValue('Class', 'IOSSystemContextMenuItemLookUp'),
            luKeyValue('Platform', 'iOS / iPadOS'),
            luKeyValue('Action', 'Dictionary + Wikipedia + Siri Knowledge'),
            luKeyValue('Visibility', 'Non-collapsed selection on any field'),
            luKeyValue('Modifies text', 'No (read-only operation)'),
            luKeyValue('Modifies clipboard', 'No'),
            luDivider(),
            luCodeBlock(
                '// Look Up is auto-included by the system toolbar.\n'
                '// The class provides metadata for the menu item:\n'
                'const item = IOSSystemContextMenuItemLookUp();\n'
                'print(item.title); // null (system default)\n'
                'print(item is IOSSystemContextMenuItem); // true\n'
                '\n'
                '// Custom title:\n'
                'const custom = IOSSystemContextMenuItemLookUp(\n'
                '  title: \'Define Word\',\n'
                ');'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: luCobalt.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemLookUp · Cobalt Blue Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: luMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
