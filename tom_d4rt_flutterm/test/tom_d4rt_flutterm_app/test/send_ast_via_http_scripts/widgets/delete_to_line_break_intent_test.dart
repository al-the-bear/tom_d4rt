// ignore_for_file: avoid_print
// Deep demo: DeleteToLineBreakIntent — deleting from cursor to line boundary
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Teal Forest / Pale Mint
// ─────────────────────────────────────────────────────────────
const Color _dlTeal = Color(0xFF004D40);
const Color _dlMint = Color(0xFFE0F2F1);
const Color _dlDarkTeal = Color(0xFF00251A);
const Color _dlMedTeal = Color(0xFF00796B);
const Color _dlLightTeal = Color(0xFF80CBC4);
const Color _dlWhite = Color(0xFFFFFFFF);
const Color _dlDarkText = Color(0xFF1B2D2A);
const Color _dlAccentAmber = Color(0xFFFF8F00);
const Color _dlAccentBlue = Color(0xFF1565C0);
const Color _dlAccentRed = Color(0xFFC62828);
const Color _dlAccentPurple = Color(0xFF6A1B9A);
const Color _dlAccentGreen = Color(0xFF2E7D32);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _dlSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dlWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dlLightTeal, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x15004D40), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _dlTeal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _dlWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _dlLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _dlDarkTeal,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _dlBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _dlDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _dlCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF0FBF9),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _dlLightTeal.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _dlDarkTeal,
            height: 1.45)),
  );
}

Widget _dlChip(String text, Color bg, Color fg) {
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

Widget _dlDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _dlLightTeal.withValues(alpha: 0.4),
  );
}

Widget _dlInfoBox(String text, Color color) {
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
  print('  DEEP DEMO: DeleteToLineBreakIntent');
  print('  Deleting from cursor to line start or line end');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _dlMint,
      appBarTheme: const AppBarTheme(
        backgroundColor: _dlTeal,
        foregroundColor: _dlWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DeleteToLineBreakIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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
                  colors: [_dlDarkTeal, _dlTeal, _dlMedTeal],
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
                      color: _dlWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.format_strikethrough,
                        color: _dlWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DeleteToLineBreakIntent',
                      style: TextStyle(
                          color: _dlWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Delete everything from cursor to line boundary',
                      style: TextStyle(
                          color: _dlWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dlChip('Cmd+Backspace', _dlWhite.withValues(alpha: 0.25), _dlWhite),
                      _dlChip('Line Delete', _dlWhite.withValues(alpha: 0.25), _dlWhite),
                      _dlChip('Forward/Back', _dlWhite.withValues(alpha: 0.25), _dlWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('1 · What Is DeleteToLineBreakIntent?', [
              _dlBody(
                'DeleteToLineBreakIntent is a text editing intent that '
                'deletes all characters between the current cursor position '
                'and the nearest line boundary. Depending on the forward '
                'property, it deletes to the end of the line or back to '
                'the beginning.',
              ),
              _dlLabel('In the Intent hierarchy'),
              _dlCodeBlock(
                'Intent (abstract)\n'
                '  └─ DeleteToLineBreakIntent\n'
                '       • forward: bool\n'
                '       • true  → delete cursor to line end\n'
                '       • false → delete cursor to line start\n'
                '       • const constructor',
              ),
              _dlDivider(),
              _dlInfoBox(
                'This is the "nuclear option" for line editing — it removes '
                'an entire segment rather than a character or word at a time.',
                _dlAccentAmber,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Forward vs backward line deletion
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('2 · Forward vs Backward Line Deletion', [
              _dlBody(
                'Like DeleteCharacterIntent, this intent has a direction, '
                'but it operates on a much larger scope — entire line segments.',
              ),
              _buildLineDirectionComparison(),
              _dlDivider(),
              _dlCodeBlock(
                '// Line: "The quick brown fox jumps"\n'
                '// Cursor at:        ^  (after "brown")\n'
                '\n'
                '// forward: false (delete to line start)\n'
                '// Result: "| fox jumps"\n'
                '\n'
                '// forward: true (delete to line end)\n'
                '// Result: "The quick brown|"',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Shortcut → Intent → Action chain
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('3 · Shortcut → Intent → Action Chain', [
              _dlBody(
                'The line deletion follows the standard three-layer '
                'architecture for text editing shortcuts.',
              ),
              ..._buildLineDeleteChain(),
              _dlDivider(),
              _dlLabel('Default wiring'),
              _dlCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    // macOS: Cmd+Backspace = delete to line start\n'
                '    SingleActivator(\n'
                '      LogicalKeyboardKey.backspace,\n'
                '      meta: true,\n'
                '    ): DeleteToLineBreakIntent(forward: false),\n'
                '\n'
                '    // macOS: Cmd+Delete = delete to line end\n'
                '    SingleActivator(\n'
                '      LogicalKeyboardKey.delete,\n'
                '      meta: true,\n'
                '    ): DeleteToLineBreakIntent(forward: true),\n'
                '  },\n'
                '  child: Actions(...),\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Platform shortcuts
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('4 · Platform Shortcuts', [
              _dlBody(
                'Line deletion shortcuts vary significantly by platform. '
                'Some platforms have no native line-delete shortcut.',
              ),
              _buildPlatformTable(),
              _dlDivider(),
              _dlInfoBox(
                'Windows and Linux do not have standard line-delete shortcuts. '
                'Editors like VS Code add their own (Ctrl+Shift+K deletes entire line).',
                _dlAccentBlue,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Cursor-to-boundary visualization
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('5 · Cursor-to-Boundary Visualization', [
              _dlBody(
                'Different cursor positions produce different deletion regions. '
                'The boundary is the line break — not the document edge.',
              ),
              _buildCursorBoundaryVisual(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Multiline behavior
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('6 · Multiline Behavior', [
              _dlBody(
                'In multiline text fields, DeleteToLineBreakIntent only '
                'operates within the current line. It does not cross line '
                'boundaries — the \\n character acts as a wall.',
              ),
              _buildMultilineDemo(),
              _dlDivider(),
              _dlCodeBlock(
                'Line 1: Hello World\n'
                'Line 2: Foo Bar|Baz    ← cursor here\n'
                'Line 3: End Text\n'
                '\n'
                'forward: true  → "Foo Bar|"\n'
                'forward: false → "|Baz"\n'
                '\n'
                'Lines 1 and 3 remain completely untouched.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Comparison with char/word delete
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('7 · Delete Hierarchy: Char → Word → Line', [
              _dlBody(
                'Flutter provides three levels of text deletion, each '
                'with progressively larger scope.',
              ),
              _buildDeleteHierarchy(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Selection interaction
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('8 · Selection Interaction', [
              _dlBody(
                'When text is selected, DeleteToLineBreakIntent first '
                'removes the selection, then the cursor position determines '
                'the remaining deletion to the line boundary.',
              ),
              _buildSelectionInteraction(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Custom action override
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('9 · Custom Action Override', [
              _dlBody(
                'You can override the line-delete action to implement '
                'custom behavior, such as confirming before deleting, '
                'or logging deleted text.',
              ),
              _dlCodeBlock(
                'Actions(\n'
                '  actions: {\n'
                '    DeleteToLineBreakIntent: CallbackAction<\n'
                '        DeleteToLineBreakIntent>(\n'
                '      onInvoke: (intent) {\n'
                '        final direction = intent.forward\n'
                '            ? "to line end"\n'
                '            : "to line start";\n'
                '        print("Deleting \$direction");\n'
                '        // Could show confirmation dialog\n'
                '        // Could log deleted text for undo\n'
                '        return null;\n'
                '      },\n'
                '    ),\n'
                '  },\n'
                '  child: textField,\n'
                ')',
              ),
              _dlDivider(),
              _dlInfoBox(
                'Custom actions can prevent accidental bulk deletion '
                'in production apps by showing a confirmation step.',
                _dlAccentGreen,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Code editor scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('10 · Real-World: Code Editor', [
              _dlBody(
                'In a code editor, line deletion is one of the most '
                'frequently used operations. Here is a sequence showing '
                'how a developer might use it to refactor a line.',
              ),
              _buildCodeEditorScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Edge cases
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('11 · Edge Cases', [
              ..._buildEdgeCases(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dlSection('12 · Summary', [
              _dlBody(
                'DeleteToLineBreakIntent provides bulk text deletion '
                'at the line level — a critical editing operation.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_dlTeal, _dlMedTeal],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _dlSummaryRow(Icons.format_strikethrough, 'Deletes from cursor to line start or end'),
                    _dlSummaryRow(Icons.swap_horiz, 'Direction via forward property'),
                    _dlSummaryRow(Icons.apple, 'macOS: Cmd+Backspace / Cmd+Delete'),
                    _dlSummaryRow(Icons.wrap_text, 'Respects line boundaries in multiline'),
                    _dlSummaryRow(Icons.layers, 'Part of char → word → line hierarchy'),
                    _dlSummaryRow(Icons.undo, 'Fully undoable with Ctrl+Z / Cmd+Z'),
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
// Section 2: Direction comparison
// ─────────────────────────────────────────────────────────────
Widget _buildLineDirectionComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dlMint,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dlLightTeal),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dlAccentAmber.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _dlAccentAmber.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.keyboard_backspace,
                    color: _dlAccentAmber, size: 28),
                const SizedBox(height: 6),
                const Text('To Line Start',
                    style: TextStyle(
                        color: _dlAccentAmber,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: false',
                    style: TextStyle(
                        color: _dlAccentAmber,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dlDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dlWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    children: [
                      Text('Hello World|end',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                      Icon(Icons.arrow_downward, size: 14, color: _dlAccentAmber),
                      Text('|end',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Removes everything BEFORE cursor',
                    style: TextStyle(color: _dlAccentAmber, fontSize: 9)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dlTeal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _dlTeal.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.last_page,
                    color: _dlTeal, size: 28),
                const SizedBox(height: 6),
                const Text('To Line End',
                    style: TextStyle(
                        color: _dlTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: true',
                    style: TextStyle(
                        color: _dlTeal,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dlDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dlWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    children: [
                      Text('Hello|World end',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                      Icon(Icons.arrow_downward, size: 14, color: _dlTeal),
                      Text('Hello|',
                          style: TextStyle(
                              fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Removes everything AFTER cursor',
                    style: TextStyle(color: _dlTeal, fontSize: 9)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Chain
// ─────────────────────────────────────────────────────────────
List<Widget> _buildLineDeleteChain() {
  final layers = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut Layer',
      'detail': 'Cmd+Backspace / Cmd+Delete → DeleteToLineBreakIntent',
      'color': _dlAccentBlue,
    },
    {
      'icon': Icons.format_strikethrough,
      'title': 'Intent Layer',
      'detail': 'Carries forward flag for direction to line boundary',
      'color': _dlTeal,
    },
    {
      'icon': Icons.edit,
      'title': 'Action Layer',
      'detail': 'Computes line boundary, removes text range, updates cursor',
      'color': _dlAccentGreen,
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
            child: Icon(l['icon'] as IconData, color: _dlWhite, size: 18),
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
                    style: const TextStyle(color: _dlDarkText, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 4: Platform table
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformTable() {
  final rows = <List<String>>[
    ['Action', 'macOS', 'Windows', 'Linux'],
    ['Delete to line start', 'Cmd+Backspace', '— (none)', '— (none)'],
    ['Delete to line end', 'Cmd+Fn+Bksp', '— (none)', '— (none)'],
    ['Delete entire line', '— (editor)', 'Ctrl+Shift+K', 'Ctrl+Shift+K'],
    ['Select to line start', 'Cmd+Shift+←', 'Home+Shift', 'Home+Shift'],
    ['Select to line end', 'Cmd+Shift+→', 'End+Shift', 'End+Shift'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dlLightTeal),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          color: isHeader
              ? _dlTeal
              : entry.key.isEven
                  ? _dlMint
                  : _dlWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 0 ? 2 : 1,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _dlWhite : _dlDarkText,
                        fontSize: 10,
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
// Section 5: Cursor-to-boundary visualization
// ─────────────────────────────────────────────────────────────
Widget _buildCursorBoundaryVisual() {
  final scenarios = <Map<String, dynamic>>[
    {
      'position': 'Near start',
      'before': 'H|ello World of Flutter',
      'backResult': '|ello World of Flutter',
      'fwdResult': 'H|',
      'backLen': '1 char removed',
      'fwdLen': '22 chars removed',
      'color': _dlAccentBlue,
    },
    {
      'position': 'Middle',
      'before': 'Hello World |of Flutter',
      'backResult': '|of Flutter',
      'fwdResult': 'Hello World |',
      'backLen': '12 chars removed',
      'fwdLen': '10 chars removed',
      'color': _dlTeal,
    },
    {
      'position': 'Near end',
      'before': 'Hello World of Flutte|r',
      'backResult': '|r',
      'fwdResult': 'Hello World of Flutte|',
      'backLen': '21 chars removed',
      'fwdLen': '1 char removed',
      'color': _dlAccentPurple,
    },
  ];

  return Column(
    children: scenarios.map((s) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _dlChip(s['position'] as String, s['color'] as Color, _dlWhite),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _dlWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(s['before'] as String,
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _dlAccentAmber.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _dlAccentAmber.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('← To start',
                            style: TextStyle(
                                color: _dlAccentAmber,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                        Text(s['backResult'] as String,
                            style: const TextStyle(
                                fontFamily: 'monospace', fontSize: 10, color: _dlDarkText)),
                        Text(s['backLen'] as String,
                            style: const TextStyle(color: _dlAccentAmber, fontSize: 8)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _dlTeal.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _dlTeal.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('→ To end',
                            style: TextStyle(
                                color: _dlTeal,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                        Text(s['fwdResult'] as String,
                            style: const TextStyle(
                                fontFamily: 'monospace', fontSize: 10, color: _dlDarkText)),
                        Text(s['fwdLen'] as String,
                            style: const TextStyle(color: _dlTeal, fontSize: 8)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Multiline demo
// ─────────────────────────────────────────────────────────────
Widget _buildMultilineDemo() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dlMint,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dlLightTeal),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dlWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _dlLightTeal),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dlLabel('Multiline text field'),
              Row(
                children: [
                  Container(
                    width: 24,
                    alignment: Alignment.center,
                    child: const Text('1',
                        style: TextStyle(
                            color: _dlMedTeal, fontSize: 10, fontFamily: 'monospace')),
                  ),
                  const Expanded(
                    child: Text('Hello World',
                        style: TextStyle(
                            fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 24,
                    alignment: Alignment.center,
                    child: const Text('2',
                        style: TextStyle(
                            color: _dlMedTeal, fontSize: 10, fontFamily: 'monospace')),
                  ),
                  const Expanded(
                    child: Text('Foo Bar|Baz  ← cursor here',
                        style: TextStyle(
                            fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 24,
                    alignment: Alignment.center,
                    child: const Text('3',
                        style: TextStyle(
                            color: _dlMedTeal, fontSize: 10, fontFamily: 'monospace')),
                  ),
                  const Expanded(
                    child: Text('End Text',
                        style: TextStyle(
                            fontFamily: 'monospace', fontSize: 11, color: _dlDarkText)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _dlAccentAmber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _dlAccentAmber.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Text('Backward',
                        style: TextStyle(
                            color: _dlAccentAmber,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                    Text('Line 2: |Baz',
                        style: TextStyle(
                            fontFamily: 'monospace', fontSize: 10, color: _dlDarkText)),
                    Text('Lines 1, 3 unchanged',
                        style: TextStyle(color: _dlAccentAmber, fontSize: 9)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _dlTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _dlTeal.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Text('Forward',
                        style: TextStyle(
                            color: _dlTeal,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                    Text('Line 2: Foo Bar|',
                        style: TextStyle(
                            fontFamily: 'monospace', fontSize: 10, color: _dlDarkText)),
                    Text('Lines 1, 3 unchanged',
                        style: TextStyle(color: _dlTeal, fontSize: 9)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Delete hierarchy
// ─────────────────────────────────────────────────────────────
Widget _buildDeleteHierarchy() {
  final levels = <Map<String, dynamic>>[
    {
      'intent': 'DeleteCharacterIntent',
      'scope': '1 character',
      'key': 'Backspace / Delete',
      'color': _dlAccentGreen,
      'icon': Icons.text_fields,
    },
    {
      'intent': 'DeleteToNextWordBoundaryIntent',
      'scope': '1 word (to boundary)',
      'key': 'Ctrl/Opt + Backspace/Delete',
      'color': _dlAccentBlue,
      'icon': Icons.short_text,
    },
    {
      'intent': 'DeleteToLineBreakIntent',
      'scope': 'Entire line segment',
      'key': 'Cmd + Backspace/Delete',
      'color': _dlAccentRed,
      'icon': Icons.format_strikethrough,
    },
  ];

  return Column(
    children: levels.asMap().entries.map((entry) {
      final l = entry.value;
      final scale = 0.7 + (entry.key * 0.15);
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (l['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (l['color'] as Color).withValues(alpha: 0.3),
              width: scale * 2),
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
              child: Icon(l['icon'] as IconData, color: _dlWhite, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l['intent'] as String,
                      style: TextStyle(
                          color: l['color'] as Color,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                          fontFamily: 'monospace')),
                  Row(
                    children: [
                      Text('Scope: ${l['scope']}',
                          style: const TextStyle(
                              color: _dlDarkText, fontSize: 10)),
                      const SizedBox(width: 10),
                      Text(l['key'] as String,
                          style: TextStyle(
                              color: (l['color'] as Color).withValues(alpha: 0.7),
                              fontSize: 9,
                              fontFamily: 'monospace')),
                    ],
                  ),
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
// Section 8: Selection interaction
// ─────────────────────────────────────────────────────────────
Widget _buildSelectionInteraction() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dlMint,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dlLightTeal),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dlWhite,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              const Text('Before: selection active',
                  style: TextStyle(
                      color: _dlDarkTeal,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 14, color: _dlDarkText),
                  children: [
                    const TextSpan(text: 'Hello '),
                    TextSpan(
                        text: 'World',
                        style: TextStyle(
                            backgroundColor: _dlMedTeal.withValues(alpha: 0.3),
                            fontWeight: FontWeight.w700)),
                    const TextSpan(text: ' of Flutter'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _dlCodeBlock(
          '// After Cmd+Backspace (delete to line start):\n'
          '// 1. Selection "World" is removed → "Hello | of Flutter"\n'
          '// 2. Then deletes to line start → "| of Flutter"\n'
          '\n'
          '// After Cmd+Delete (delete to line end):\n'
          '// 1. Selection "World" is removed → "Hello | of Flutter"\n'
          '// 2. Then deletes to line end → "Hello |"',
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Code editor scenario
// ─────────────────────────────────────────────────────────────
Widget _buildCodeEditorScenario() {
  final steps = <Map<String, String>>[
    {'action': 'Original', 'code': 'final result = computeData(input, options);'},
    {'action': 'Cmd+End (go to end)', 'code': 'final result = computeData(input, options);|'},
    {'action': 'Cmd+Bksp', 'code': '|'},
    {'action': 'Type new code', 'code': 'final output = transform(data);|'},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dlLightTeal),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dlTeal,
          child: const Row(
            children: [
              Icon(Icons.code, color: _dlWhite, size: 14),
              SizedBox(width: 8),
              Text('Refactoring a Line',
                  style: TextStyle(
                      color: _dlWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...steps.asMap().entries.map((entry) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: entry.key.isEven ? _dlMint : _dlWhite,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _dlTeal.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _dlTeal, fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  child: Text(entry.value['action']!,
                      style: const TextStyle(
                          color: _dlDarkTeal,
                          fontSize: 9,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _dlWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _dlLightTeal.withValues(alpha: 0.5)),
                    ),
                    child: Text(entry.value['code']!,
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 10, color: _dlDarkText)),
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
List<Widget> _buildEdgeCases() {
  final cases = <Map<String, dynamic>>[
    {
      'case': 'Cursor at line start',
      'desc': 'forward: false is a no-op (nothing to delete)',
      'icon': Icons.first_page,
      'color': _dlAccentBlue,
    },
    {
      'case': 'Cursor at line end',
      'desc': 'forward: true is a no-op (nothing to delete)',
      'icon': Icons.last_page,
      'color': _dlAccentAmber,
    },
    {
      'case': 'Empty line',
      'desc': 'Both directions are no-ops on a truly empty line',
      'icon': Icons.space_bar,
      'color': _dlAccentPurple,
    },
    {
      'case': 'Single character line',
      'desc': 'Either direction removes the one character, leaving empty line',
      'icon': Icons.looks_one,
      'color': _dlAccentGreen,
    },
    {
      'case': 'Soft line wrap',
      'desc': 'Deletion considers the logical line break, not visual wrap',
      'icon': Icons.wrap_text,
      'color': _dlTeal,
    },
    {
      'case': 'Read-only field',
      'desc': 'Intent dispatched but action does nothing',
      'icon': Icons.lock,
      'color': _dlAccentRed,
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
            child: Icon(c['icon'] as IconData, color: _dlWhite, size: 15),
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
                    style: const TextStyle(color: _dlDarkText, fontSize: 10)),
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
Widget _dlSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _dlWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _dlWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
