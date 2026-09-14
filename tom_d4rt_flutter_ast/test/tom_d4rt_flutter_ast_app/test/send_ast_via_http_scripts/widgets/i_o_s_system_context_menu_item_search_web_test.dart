// ignore_for_file: avoid_print
// IOSSystemContextMenuItemSearchWeb – comprehensive deep demo
// Ocean Teal / Seafoam palette – iOS "Search Web" context menu action:
// opens Safari with a web search for the selected text.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color swTeal = Color(0xFF00695C);
  const Color swSeafoam = Color(0xFFE0F2F1);
  const Color swOnTeal = Color(0xFFFFFFFF);
  const Color swDeep = Color(0xFF004D40);
  const Color swLightFoam = Color(0xFFF0FAF8);
  const Color swTextDark = Color(0xFF0D3330);
  const Color swAccent = Color(0xFF26A69A);
  const Color swMuted = Color(0xFF80CBC4);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget swHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [swTeal, swDeep],
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
                  color: swOnTeal)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: swOnTeal.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget swSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: swLightFoam,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: swTeal.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: swTeal.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: swTeal)),
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

  Widget swBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('○ ',
              style: TextStyle(color: swAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: swTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget swCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF002420),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: swSeafoam,
              height: 1.5)),
    );
  }

  Widget swKeyValue(String key, String value) {
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
                    color: swDeep)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: swTextDark)),
          ),
        ],
      ),
    );
  }

  Widget swHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: swAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: swAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: swDeep,
              height: 1.4)),
    );
  }

  Widget swDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: swMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget swInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: swTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: swTeal)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: swDeep)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: swTextDark)),
          ),
        ],
      ),
    );
  }

  Widget swCompare(String label, String desc) {
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
              color: swTeal,
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
                          color: swDeep)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: swTextDark)),
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
    color: swSeafoam,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          swHeader(
            'IOSSystemContextMenuItemSearchWeb',
            'iOS "Search Web" context menu action – opens the default '
                'search engine in Safari with the selected text as the query',
          ),

          // ── 1. class overview ──
          swSection('1 · Class Identity & Role', [
            swKeyValue('Class', 'IOSSystemContextMenuItemSearchWeb'),
            swKeyValue('Platform', 'iOS / iPadOS'),
            swKeyValue('Action',
                'Opens Safari with a web search for selected text'),
            swKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            swDivider(),
            swBullet(
                'IOSSystemContextMenuItemSearchWeb represents the '
                '"Search Web" button in the iOS text selection context menu.'),
            swBullet(
                'Tapping it opens Safari (or the default browser) with the '
                'selected text as the search query using the configured '
                'default search engine.'),
            swBullet(
                'The action navigates AWAY from the app – the user leaves '
                'the Flutter app and enters Safari.'),
          ]),

          // ── 2. search web flow ──
          swSection('2 · Search Web Action Flow', [
            swBullet(
                'Step 1: User selects text in a text field or SelectableText.'),
            swBullet(
                'Step 2: Context menu appears with primary and secondary items.'),
            swBullet(
                'Step 3: User taps "Search Web" in the secondary row.'),
            swBullet(
                'Step 4: iOS opens Safari with the search engine query URL.'),
            swBullet(
                'Step 5: The search query is the exact selected text, URL-encoded.'),
            swDivider(),
            swHighlight(
                'The search uses the default search engine configured in '
                'Settings > Safari > Search Engine. Common choices are Google, '
                'Yahoo, Bing, DuckDuckGo, and Ecosia.'),
            swCodeBlock(
                '// Example URL generated:\n'
                '// Selected text: "Flutter widgets"\n'
                '// With Google: https://google.com/search?q=Flutter+widgets\n'
                '// With DuckDuckGo: https://duckduckgo.com/?q=Flutter+widgets'),
          ]),

          // ── 3. visibility conditions ──
          swSection('3 · When Search Web Appears', [
            swBullet(
                'The item appears when text is selected (non-collapsed selection).'),
            swBullet(
                'Available in BOTH editable and read-only fields – this is '
                'a read-only action that does not modify the field.'),
            swBullet(
                'Appears regardless of clipboard state – it does not interact '
                'with the clipboard at all.'),
            swDivider(),
            swKeyValue('Selection required', 'Yes, non-collapsed'),
            swKeyValue('Editable required', 'No (works in read-only too)'),
            swKeyValue('Clipboard', 'Not involved'),
            swKeyValue('Network', 'Required for search results'),
          ]),

          // ── 4. menu positioning ──
          swSection('4 · Context Menu Positioning', [
            swBullet(
                'Search Web is a SECONDARY item. It does not appear on '
                'the first page of the iOS callout bar.'),
            swBullet(
                'The user must tap the chevron arrow to reveal the '
                'secondary row containing Search Web.'),
            swBullet(
                'Typical secondary row order: Look Up, Translate, Search Web, '
                'Share, Scan Text (if available).'),
            swDivider(),
            swKeyValue('Position', 'Secondary row of callout bar'),
            swKeyValue('Icon', 'None (text label only)'),
            swKeyValue('Label', '"Search Web" (localized)'),
          ]),

          // ── 5. difference from Look Up ──
          swSection('5 · Search Web vs Look Up', [
            swCompare('Search Web',
                'Opens Safari with full search results page'),
            swCompare('Look Up',
                'Shows inline dictionary/Wikipedia card in-app'),
            swDivider(),
            swBullet(
                'Search Web always navigates away from the app. Look Up stays '
                'within the app in a system-managed sheet.'),
            swBullet(
                'Search Web shows full web search results. Look Up shows '
                'curated results from dictionary, Wikipedia, and Siri Knowledge.'),
            swBullet(
                'Search Web works for any text, even phrases that have no '
                'dictionary entry. Look Up works best for single words '
                'or well-known phrases.'),
          ]),

          // ── 6. search engines ──
          swSection('6 · Default Search Engine', [
            swInfoRow('G', 'Google:', 'Most common default, full web search'),
            swInfoRow('B', 'Bing:', 'Microsoft search, AI-enhanced'),
            swInfoRow('Y', 'Yahoo:', 'Web search with Yahoo results'),
            swInfoRow('D', 'DuckDuckGo:', 'Privacy-focused, no tracking'),
            swInfoRow('E', 'Ecosia:', 'Eco-friendly, plants trees with ad revenue'),
            swDivider(),
            swBullet(
                'The app has NO control over which search engine is used. '
                'It relies entirely on the system setting.'),
            swBullet(
                'The search engine preference is at: Settings > Safari > Search Engine.'),
          ]),

          // ── 7. Flutter integration ──
          swSection('7 · Flutter Framework Integration', [
            swBullet(
                'Search Web is auto-provided by the iOS system toolbar. '
                'Flutter does not add it manually.'),
            swBullet(
                'In custom contextMenuBuilder implementations, include '
                'system-provided buttonItems to retain Search Web.'),
            swCodeBlock(
                '// Preserve Search Web in custom menus\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    final buttonItems =\n'
                '        editableTextState.contextMenuButtonItems;\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: buttonItems, // includes Search Web\n'
                '    );\n'
                '  },\n'
                ')'),
            swDivider(),
            swBullet(
                'If you replace all buttonItems with custom ones, Search Web '
                'disappears. It cannot be manually re-added.'),
          ]),

          // ── 8. class properties ──
          swSection('8 · Class Properties & Constructor', [
            swCodeBlock(
                '// IOSSystemContextMenuItemSearchWeb is a final class\n'
                '// with a const constructor.\n'
                'const IOSSystemContextMenuItemSearchWeb({\n'
                '  super.title,  // optional custom label\n'
                '})\n'
                '\n'
                '// Usage:\n'
                'const item = IOSSystemContextMenuItemSearchWeb();\n'
                '// item.title → null (uses system default)\n'
                '\n'
                'const custom = IOSSystemContextMenuItemSearchWeb(\n'
                '  title: \'Google It\',\n'
                ');\n'
                '// custom.title → "Google It"'),
            swDivider(),
            swKeyValue('title', 'Optional String, null uses system default'),
            swKeyValue('Const', 'Yes, supports const construction'),
            swKeyValue('Mixin', 'Diagnosticable for debug inspection'),
            swKeyValue('Superclass', 'IOSSystemContextMenuItem'),
          ]),

          // ── 9. URL encoding ──
          swSection('9 · URL Encoding of Search Query', [
            swBullet(
                'The selected text is URL-encoded before being passed to '
                'the search engine. Special characters are escaped.'),
            swBullet(
                'Spaces become "+" or "%20" depending on the encoding scheme. '
                'Non-ASCII characters are percent-encoded (UTF-8).'),
            swCodeBlock(
                '// URL encoding examples:\n'
                '// "hello world" → "hello+world"\n'
                '// "C++ programming" → "C%2B%2B+programming"\n'
                '// "cafe\u0301" → "caf%C3%A9"\n'
                '// "2+2=4" → "2%2B2%3D4"'),
            swDivider(),
            swBullet(
                'Very long selections may be truncated by the search engine '
                'URL length limits (typically 2000+ characters).'),
          ]),

          // ── 10. offline behavior ──
          swSection('10 · Offline Behavior', [
            swBullet(
                'Search Web always navigates to Safari, even when offline.'),
            swBullet(
                'If the device is offline, Safari shows its own "Cannot '
                'Connect to Server" error page.'),
            swBullet(
                'The context menu item itself is NOT hidden when offline – '
                'it always appears when text is selected.'),
            swHighlight(
                'Unlike Look Up (which falls back to offline dictionary), '
                'Search Web provides no useful result without an internet '
                'connection.'),
          ]),

          // ── 11. platform constraints ──
          swSection('11 · Platform Constraints', [
            swKeyValue('iOS', 'Available (opens Safari search)'),
            swKeyValue('iPadOS', 'Available (opens Safari search)'),
            swKeyValue('macOS', 'Not in text context menu (use Spotlight)'),
            swKeyValue('Android', 'Not available (has "Web Search" via Google)'),
            swKeyValue('Web', 'Not available'),
            swDivider(),
            swBullet(
                'On Android, a similar "Web Search" or "Assist" action exists '
                'but uses Google Assistant or the Google app rather than the '
                'browser directly.'),
          ]),

          // ── 12. privacy considerations ──
          swSection('12 · Privacy Considerations', [
            swBullet(
                'The selected text is sent to the default search engine as '
                'a query parameter. This means the search engine receives '
                'whatever text was selected.'),
            swBullet(
                'If the user has Private Relay enabled (iOS 15+), the IP '
                'address is anonymized for the search request.'),
            swBullet(
                'Safari may cache the search query in history and autocomplete '
                'suggestions unless Private Browsing is active.'),
            swDivider(),
            swBullet(
                'Apps should be aware that sensitive text (passwords, private '
                'data) could be inadvertently searched if the user taps '
                'Search Web on such content.'),
          ]),

          // ── 13. accessibility ──
          swSection('13 · VoiceOver & Accessibility', [
            swBullet(
                'Search Web is announced as "Search Web, button" by VoiceOver.'),
            swBullet(
                'The accessibility hint is "Searches the web for the '
                'selected text."'),
            swBullet(
                'After tapping, VoiceOver focus moves to Safari, which has '
                'its own accessibility support for search results.'),
            swDivider(),
            swKeyValue('A11y label', '"Search Web"'),
            swKeyValue('A11y trait', 'Button'),
            swKeyValue('A11y hint', '"Searches the web for selected text"'),
          ]),

          // ── 14. comparison with all menu items ──
          swSection('14 · Complete iOS Context Menu Reference', [
            swCompare('Cut', 'Writes to clipboard + deletes (editable only)'),
            swCompare('Copy', 'Writes to clipboard (any field)'),
            swCompare('Paste', 'Reads clipboard + inserts (editable only)'),
            swCompare('Select All', 'Selects entire text (any field)'),
            swCompare('Look Up', 'Inline dictionary/Wikipedia (any field)'),
            swCompare('Translate', 'Translates to another language (any field)'),
            swCompare('Search Web', 'Opens Safari search (any field)'),
            swCompare('Share', 'Opens share sheet (any field)'),
            swCompare('Scan Text', 'Camera OCR insertion (editable only)'),
          ]),

          // ── 15. edge cases ──
          swSection('15 · Edge Cases', [
            swBullet(
                'Emoji selection: searching emoji in Safari returns relevant '
                'results about the emoji meaning.'),
            swBullet(
                'Numeric selection: searching numbers returns calculator '
                'results, unit conversions, etc.'),
            swBullet(
                'Multi-line selection: newlines are typically converted to '
                'spaces in the search query.'),
            swBullet(
                'Very short selection (1 character): search still proceeds '
                'but results are usually not useful.'),
            swBullet(
                'Non-Latin scripts: search engines handle CJK, Arabic, '
                'Cyrillic, etc. with proper encoding.'),
          ]),

          // ── 16. API summary ──
          swSection('16 · Quick API Reference', [
            swKeyValue('Class', 'IOSSystemContextMenuItemSearchWeb'),
            swKeyValue('Platform', 'iOS / iPadOS'),
            swKeyValue('Action', 'Opens Safari with web search query'),
            swKeyValue('Visibility', 'Non-collapsed selection, any field'),
            swKeyValue('Modifies text', 'No'),
            swKeyValue('Modifies clipboard', 'No'),
            swKeyValue('Leaves app', 'Yes (navigates to Safari)'),
            swDivider(),
            swCodeBlock(
                '// Search Web is auto-included by the system toolbar.\n'
                'const item = IOSSystemContextMenuItemSearchWeb();\n'
                'print(item.title); // null (system default)\n'
                'print(item is IOSSystemContextMenuItem); // true\n'
                '\n'
                'const custom = IOSSystemContextMenuItemSearchWeb(\n'
                '  title: \'Search Online\',\n'
                ');'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: swTeal.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemSearchWeb · Ocean Teal Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: swMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
