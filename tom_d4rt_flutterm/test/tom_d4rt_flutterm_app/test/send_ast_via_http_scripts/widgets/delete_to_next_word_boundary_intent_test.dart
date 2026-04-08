// ignore_for_file: avoid_print
// Deep demo: DeleteToNextWordBoundaryIntent — word-level text deletion
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Burnt Sienna / Warm Sand
// ─────────────────────────────────────────────────────────────
const Color _dwSienna = Color(0xFF8D4E25);
const Color _dwSand = Color(0xFFFFF3E0);
const Color _dwDarkSienna = Color(0xFF5D3317);
const Color _dwMedSienna = Color(0xFFBF6D3A);
const Color _dwLightSienna = Color(0xFFDEB896);
const Color _dwWhite = Color(0xFFFFFFFF);
const Color _dwDarkText = Color(0xFF3E2723);
const Color _dwAccentBlue = Color(0xFF1565C0);
const Color _dwAccentRed = Color(0xFFC62828);
const Color _dwAccentGreen = Color(0xFF2E7D32);
const Color _dwAccentPurple = Color(0xFF6A1B9A);
const Color _dwAccentIndigo = Color(0xFF283593);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _dwSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dwWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dwLightSienna, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x158D4E25), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _dwSienna,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _dwWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _dwLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _dwDarkSienna,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _dwBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _dwDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _dwCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _dwLightSienna.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _dwDarkSienna,
            height: 1.45)),
  );
}

Widget _dwChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _dwDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _dwLightSienna.withValues(alpha: 0.4),
  );
}

Widget _dwInfoBox(String text, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color, fontSize: 11.5, fontWeight: FontWeight.w500)),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: DeleteToNextWordBoundaryIntent');
  print('  Word-level text deletion from cursor');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _dwSand,
      appBarTheme: const AppBarTheme(
        backgroundColor: _dwSienna,
        foregroundColor: _dwWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DeleteToNextWordBoundaryIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_dwDarkSienna, _dwSienna, _dwMedSienna],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _dwWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.space_bar,
                        color: _dwWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DeleteToNextWordBoundaryIntent',
                      style: TextStyle(
                          color: _dwWhite,
                          fontSize: 17,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Delete word by word — from cursor to word boundary',
                      style: TextStyle(
                          color: _dwWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dwChip('Ctrl+Bksp', _dwWhite.withValues(alpha: 0.25), _dwWhite),
                      _dwChip('Ctrl+Del', _dwWhite.withValues(alpha: 0.25), _dwWhite),
                      _dwChip('Word Nav', _dwWhite.withValues(alpha: 0.25), _dwWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('1 · What Is DeleteToNextWordBoundaryIntent?', [
              _dwBody(
                'DeleteToNextWordBoundaryIntent is the text editing intent '
                'that deletes from the current cursor position to the next '
                'word boundary. It is the middle ground between deleting a '
                'single character and deleting an entire line.',
              ),
              _dwLabel('Class definition'),
              _dwCodeBlock(
                'Intent (abstract)\n'
                '  └─ DeleteToNextWordBoundaryIntent\n'
                '       • forward: bool\n'
                '       • true  → delete forward to next word boundary\n'
                '       • false → delete backward to previous word boundary\n'
                '       • const constructor',
              ),
              _dwDivider(),
              _dwBody(
                'This is the most commonly used bulk-deletion intent in '
                'professional text editing. Programmers use it constantly '
                'to delete variable names, keywords, and identifiers.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Word boundaries explained
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('2 · Word Boundaries Explained', [
              _dwBody(
                'A word boundary is the transition between characters of '
                'different categories: letters, digits, whitespace, and '
                'punctuation.',
              ),
              _buildWordBoundaryVisual(),
              _dwDivider(),
              _dwCodeBlock(
                '// Boundaries marked with | in:\n'
                '|Hello|,| |World|!| |123| |abc|\n'
                '\n'
                '// Letter→punct: Hello|,\n'
                '// Punct→space: ,| \n'
                '// Space→letter: |World\n'
                '// Letter→punct: World|!\n'
                '// Space→digit: |123\n'
                '// Digit→space: 123|',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Forward vs backward
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('3 · Forward vs Backward Word Deletion', [
              _dwBody(
                'The forward property determines whether the word boundary '
                'search goes right (forward) or left (backward).',
              ),
              _buildWordDirectionComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Shortcut → Intent → Action
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('4 · Shortcut → Intent → Action Chain', [
              _dwBody(
                'Word deletion follows the standard three-layer text '
                'editing architecture.',
              ),
              ..._buildWordChain(),
              _dwDivider(),
              _dwLabel('Default wiring'),
              _dwCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    // Windows/Linux: Ctrl+Backspace\n'
                '    SingleActivator(\n'
                '      LogicalKeyboardKey.backspace,\n'
                '      control: true,\n'
                '    ): DeleteToNextWordBoundaryIntent(forward: false),\n'
                '\n'
                '    // Windows/Linux: Ctrl+Delete\n'
                '    SingleActivator(\n'
                '      LogicalKeyboardKey.delete,\n'
                '      control: true,\n'
                '    ): DeleteToNextWordBoundaryIntent(forward: true),\n'
                '  },\n'
                '  child: Actions(...),\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Platform shortcuts
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('5 · Platform Word-Delete Shortcuts', [
              _dwBody(
                'Word deletion is universally supported, but the modifier '
                'key differs between macOS and Windows/Linux.',
              ),
              _buildPlatformWordTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Word boundary rules
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('6 · Word Boundary Rules', [
              _dwBody(
                'Different character categories create word boundaries:',
              ),
              _buildBoundaryRules(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Consecutive word deletions
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('7 · Consecutive Word Deletions', [
              _dwBody(
                'Pressing Ctrl+Backspace repeatedly deletes words one '
                'at a time, from right to left.',
              ),
              _buildConsecutiveDeleteDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Comparison with char/line
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('8 · Delete Hierarchy: Char → Word → Line', [
              _dwBody(
                'Word deletion sits in the middle of the deletion '
                'granularity hierarchy.',
              ),
              _buildHierarchyVisual(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: CamelCase behavior
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('9 · CamelCase and Identifiers', [
              _dwBody(
                'How word deletion handles camelCase identifiers depends '
                'on the platform and text engine. Some editors treat each '
                'capital as a word boundary.',
              ),
              _buildCamelCaseDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Real-world refactoring
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('10 · Real-World: Refactoring a Method Call', [
              _dwBody(
                'A developer uses Ctrl+Backspace to quickly delete '
                'parts of a method call, then re-types.',
              ),
              _buildRefactoringScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Edge cases
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('11 · Edge Cases', [
              ..._buildWordEdgeCases(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dwSection('12 · Summary', [
              _dwBody(
                'DeleteToNextWordBoundaryIntent is the workhorse of '
                'text editing — used more than any other bulk-delete intent.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_dwSienna, _dwMedSienna],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _dwSummaryRow(Icons.space_bar, 'Deletes from cursor to word boundary'),
                    _dwSummaryRow(Icons.swap_horiz, 'Forward or backward via forward flag'),
                    _dwSummaryRow(Icons.keyboard, 'Ctrl+Bksp / Ctrl+Del (Opt on macOS)'),
                    _dwSummaryRow(Icons.text_fields, 'Respects Unicode word boundary rules'),
                    _dwSummaryRow(Icons.layers, 'Middle tier of char → word → line hierarchy'),
                    _dwSummaryRow(Icons.undo, 'Fully undoable with Ctrl+Z'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Word boundary visual
// ─────────────────────────────────────────────────────────────
Widget _buildWordBoundaryVisual() {
  final words = <Map<String, dynamic>>[
    {'text': 'Hello', 'type': 'word', 'color': _dwAccentBlue},
    {'text': ',', 'type': 'punct', 'color': _dwAccentRed},
    {'text': ' ', 'type': 'space', 'color': _dwLightSienna},
    {'text': 'World', 'type': 'word', 'color': _dwAccentGreen},
    {'text': '!', 'type': 'punct', 'color': _dwAccentRed},
    {'text': ' ', 'type': 'space', 'color': _dwLightSienna},
    {'text': '123', 'type': 'digit', 'color': _dwAccentPurple},
    {'text': ' ', 'type': 'space', 'color': _dwLightSienna},
    {'text': 'abc', 'type': 'word', 'color': _dwAccentBlue},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dwSand,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dwLightSienna),
    ),
    child: Column(
      children: [
        _dwLabel('Character categories'),
        Wrap(
          children: words.map((w) {
            return Container(
              margin: const EdgeInsets.only(right: 2, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: (w['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: (w['color'] as Color).withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Text(w['text'] as String,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: w['color'] as Color)),
                  Text(w['type'] as String,
                      style: TextStyle(
                          color: (w['color'] as Color).withValues(alpha: 0.7),
                          fontSize: 8)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        _dwInfoBox(
          'Word boundaries occur at transitions between different character categories.',
          _dwSienna,
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Direction comparison
// ─────────────────────────────────────────────────────────────
Widget _buildWordDirectionComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dwSand,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dwLightSienna),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dwAccentRed.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _dwAccentRed.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.keyboard_backspace,
                    color: _dwAccentRed, size: 28),
                const SizedBox(height: 6),
                const Text('Backward',
                    style: TextStyle(
                        color: _dwAccentRed,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: false',
                    style: TextStyle(
                        color: _dwAccentRed,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dwDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dwWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    children: [
                      Text('Hello World|',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dwDarkText)),
                      Icon(Icons.arrow_downward, size: 14, color: _dwAccentRed),
                      Text('Hello |',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dwDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Deletes word BEFORE cursor',
                    style: TextStyle(color: _dwAccentRed, fontSize: 9)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dwSienna.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _dwSienna.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.last_page,
                    color: _dwSienna, size: 28),
                const SizedBox(height: 6),
                const Text('Forward',
                    style: TextStyle(
                        color: _dwSienna,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: true',
                    style: TextStyle(
                        color: _dwSienna,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dwDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dwWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    children: [
                      Text('|Hello World',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dwDarkText)),
                      Icon(Icons.arrow_downward, size: 14, color: _dwSienna),
                      Text('| World',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dwDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Deletes word AFTER cursor',
                    style: TextStyle(color: _dwSienna, fontSize: 9)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Chain
// ─────────────────────────────────────────────────────────────
List<Widget> _buildWordChain() {
  final layers = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut Layer',
      'detail': 'Ctrl+Bksp / Ctrl+Del → DeleteToNextWordBoundaryIntent',
      'color': _dwAccentBlue,
    },
    {
      'icon': Icons.space_bar,
      'title': 'Intent Layer',
      'detail': 'Carries forward flag, describes word-level deletion',
      'color': _dwSienna,
    },
    {
      'icon': Icons.edit,
      'title': 'Action Layer',
      'detail': 'Finds word boundary, removes text range, repositions cursor',
      'color': _dwAccentGreen,
    },
  ];
  return layers.map((l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (l['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (l['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: l['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(l['icon'] as IconData, color: _dwWhite, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l['title'] as String,
                    style: TextStyle(
                        color: l['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Text(l['detail'] as String,
                    style: const TextStyle(color: _dwDarkText, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 5: Platform table
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformWordTable() {
  final rows = <List<String>>[
    ['Action', 'macOS', 'Win/Linux'],
    ['Word backward', 'Opt+Backspace', 'Ctrl+Backspace'],
    ['Word forward', 'Opt+Delete', 'Ctrl+Delete'],
    ['Select word back', 'Opt+Shift+←', 'Ctrl+Shift+←'],
    ['Select word fwd', 'Opt+Shift+→', 'Ctrl+Shift+→'],
    ['Move word back', 'Opt+←', 'Ctrl+←'],
    ['Move word fwd', 'Opt+→', 'Ctrl+→'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dwLightSienna),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          color: isHeader
              ? _dwSienna
              : entry.key.isEven
                  ? _dwSand
                  : _dwWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 0 ? 2 : 1,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _dwWhite : _dwDarkText,
                        fontSize: 10.5,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Boundary rules
// ─────────────────────────────────────────────────────────────
Widget _buildBoundaryRules() {
  final rules = <Map<String, dynamic>>[
    {
      'from': 'Letter → Space',
      'example': 'Hello| World',
      'color': _dwAccentBlue,
    },
    {
      'from': 'Space → Letter',
      'example': 'Hello |World',
      'color': _dwAccentGreen,
    },
    {
      'from': 'Letter → Punct',
      'example': 'Hello|, World',
      'color': _dwAccentRed,
    },
    {
      'from': 'Digit → Space',
      'example': '123| abc',
      'color': _dwAccentPurple,
    },
    {
      'from': 'Letter → Digit',
      'example': 'abc|123',
      'color': _dwAccentIndigo,
    },
    {
      'from': 'Underscore',
      'example': 'hello_|world',
      'color': _dwSienna,
    },
  ];

  return Column(
    children: rules.map((r) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: (r['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (r['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(r['from'] as String,
                  style: TextStyle(
                      color: r['color'] as Color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _dwWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(r['example'] as String,
                    style: const TextStyle(
                        fontFamily: 'monospace', fontSize: 11, color: _dwDarkText)),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Consecutive delete demo
// ─────────────────────────────────────────────────────────────
Widget _buildConsecutiveDeleteDemo() {
  final steps = <Map<String, String>>[
    {'action': 'Initial', 'field': 'The quick brown fox jumps|'},
    {'action': 'Ctrl+Bksp ×1', 'field': 'The quick brown fox |'},
    {'action': 'Ctrl+Bksp ×2', 'field': 'The quick brown |'},
    {'action': 'Ctrl+Bksp ×3', 'field': 'The quick |'},
    {'action': 'Ctrl+Bksp ×4', 'field': 'The |'},
    {'action': 'Ctrl+Bksp ×5', 'field': '|'},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dwLightSienna),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dwSienna,
          child: const Row(
            children: [
              Icon(Icons.replay, color: _dwWhite, size: 14),
              SizedBox(width: 8),
              Text('Consecutive Ctrl+Backspace',
                  style: TextStyle(
                      color: _dwWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...steps.asMap().entries.map((entry) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: entry.key.isEven ? _dwSand : _dwWhite,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _dwSienna.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _dwSienna,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  child: Text(entry.value['action']!,
                      style: const TextStyle(
                          color: _dwDarkSienna,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _dwWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: _dwLightSienna.withValues(alpha: 0.5)),
                    ),
                    child: Text(entry.value['field']!,
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dwDarkText)),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Hierarchy visual
// ─────────────────────────────────────────────────────────────
Widget _buildHierarchyVisual() {
  final line = 'Hello World Flutter';
  final levels = <Map<String, dynamic>>[
    {
      'name': 'Character',
      'from': 'Hello World Flutte|r',
      'result': 'Hello World Flutte|',
      'removed': '1 char',
      'color': _dwAccentGreen,
    },
    {
      'name': 'Word',
      'from': 'Hello World Flutter|',
      'result': 'Hello World |',
      'removed': '7 chars',
      'color': _dwSienna,
    },
    {
      'name': 'Line',
      'from': 'Hello World Flutter|',
      'result': '|',
      'removed': '${line.length} chars',
      'color': _dwAccentRed,
    },
  ];

  return Column(
    children: levels.map((l) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (l['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (l['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: l['color'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(l['name'] as String,
                  style: const TextStyle(
                      color: _dwWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${l['from']} → ${l['result']}',
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _dwDarkText)),
                  Text(l['removed'] as String,
                      style: TextStyle(
                          color: (l['color'] as Color).withValues(alpha: 0.7),
                          fontSize: 9)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: CamelCase demo
// ─────────────────────────────────────────────────────────────
Widget _buildCamelCaseDemo() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dwSand,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dwLightSienna),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dwAccentBlue.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _dwAccentBlue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Text('Standard mode',
                        style: TextStyle(
                            color: _dwAccentBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                    _dwDivider(),
                    const Text('myVariableName|',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dwDarkText)),
                    const Icon(Icons.arrow_downward,
                        size: 12, color: _dwAccentBlue),
                    const Text('|',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dwDarkText)),
                    const Text('Treats as one word',
                        style: TextStyle(
                            color: _dwAccentBlue, fontSize: 9)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dwAccentPurple.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dwAccentPurple.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Text('CamelCase aware',
                        style: TextStyle(
                            color: _dwAccentPurple,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                    _dwDivider(),
                    const Text('myVariableName|',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dwDarkText)),
                    const Icon(Icons.arrow_downward,
                        size: 12, color: _dwAccentPurple),
                    const Text('myVariable|',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dwDarkText)),
                    const Text('Stops at capitals',
                        style: TextStyle(
                            color: _dwAccentPurple, fontSize: 9)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _dwInfoBox(
          'Flutter default text editing uses standard word boundaries (spaces/punct). '
          'CamelCase-aware deletion is an editor feature, not built into the intent.',
          _dwSienna,
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Refactoring scenario
// ─────────────────────────────────────────────────────────────
Widget _buildRefactoringScenario() {
  final steps = <Map<String, String>>[
    {'action': 'Original', 'code': 'widget.computeLayout(context, constraints)|'},
    {'action': 'Ctrl+Bksp', 'code': 'widget.computeLayout(context, |'},
    {'action': 'Ctrl+Bksp', 'code': 'widget.computeLayout(|'},
    {'action': 'Type new args', 'code': 'widget.computeLayout(newCtx)|'},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dwLightSienna),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dwSienna,
          child: const Row(
            children: [
              Icon(Icons.code, color: _dwWhite, size: 14),
              SizedBox(width: 8),
              Text('Editing Method Arguments',
                  style: TextStyle(
                      color: _dwWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...steps.asMap().entries.map((entry) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: entry.key.isEven ? _dwSand : _dwWhite,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _dwSienna.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _dwSienna,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: Text(entry.value['action']!,
                      style: const TextStyle(
                          color: _dwDarkSienna,
                          fontSize: 9,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _dwWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: _dwLightSienna.withValues(alpha: 0.5)),
                    ),
                    child: Text(entry.value['code']!,
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: _dwDarkText)),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Edge cases
// ─────────────────────────────────────────────────────────────
List<Widget> _buildWordEdgeCases() {
  final cases = <Map<String, dynamic>>[
    {
      'case': 'Single word in field',
      'desc': 'One Ctrl+Bksp clears the entire field content',
      'icon': Icons.looks_one,
      'color': _dwAccentBlue,
    },
    {
      'case': 'Multiple spaces',
      'desc': 'Consecutive spaces are treated as a single word boundary',
      'icon': Icons.space_bar,
      'color': _dwAccentGreen,
    },
    {
      'case': 'Punctuation sequences',
      'desc': '!@# treated as one unit — removed in one word-delete',
      'icon': Icons.more_horiz,
      'color': _dwAccentRed,
    },
    {
      'case': 'Emoji in text',
      'desc': 'Emoji is a word boundary — word-delete stops at emoji edge',
      'icon': Icons.emoji_emotions,
      'color': _dwAccentPurple,
    },
    {
      'case': 'Cursor at field start',
      'desc': 'Backward word-delete is a no-op',
      'icon': Icons.first_page,
      'color': _dwSienna,
    },
    {
      'case': 'Selection active',
      'desc': 'Selection removed first, then word deletion from collapsed cursor',
      'icon': Icons.select_all,
      'color': _dwAccentIndigo,
    },
  ];

  return cases.map((c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (c['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (c['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: c['color'] as Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(c['icon'] as IconData, color: _dwWhite, size: 15),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['case'] as String,
                    style: TextStyle(
                        color: c['color'] as Color,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700)),
                Text(c['desc'] as String,
                    style: const TextStyle(color: _dwDarkText, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _dwSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _dwWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _dwWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
