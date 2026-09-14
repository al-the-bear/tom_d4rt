// ignore_for_file: avoid_print
// Deep demo: DeleteCharacterIntent — deleting characters at the cursor
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Crimson Rose / Soft Blush
// ─────────────────────────────────────────────────────────────
const Color _dcCrimson = Color(0xFFAD1457);
const Color _dcBlush = Color(0xFFFCE4EC);
const Color _dcDarkCrimson = Color(0xFF880E4F);
const Color _dcMedCrimson = Color(0xFFD81B60);
const Color _dcLightCrimson = Color(0xFFF48FB1);
const Color _dcWhite = Color(0xFFFFFFFF);
const Color _dcDarkText = Color(0xFF311B30);
const Color _dcAccentGreen = Color(0xFF2E7D32);
const Color _dcAccentBlue = Color(0xFF1565C0);
const Color _dcAccentOrange = Color(0xFFE65100);
const Color _dcAccentPurple = Color(0xFF6A1B9A);
const Color _dcAccentTeal = Color(0xFF00796B);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _dcSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dcWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dcLightCrimson, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x15AD1457), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _dcCrimson,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _dcWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _dcLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _dcDarkCrimson,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _dcBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _dcDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _dcCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0F3),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _dcLightCrimson.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _dcDarkCrimson,
            height: 1.45)),
  );
}

Widget _dcChip(String text, Color bg, Color fg) {
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

Widget _dcDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _dcLightCrimson.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: DeleteCharacterIntent');
  print('  Deleting characters at the cursor position');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _dcBlush,
      appBarTheme: const AppBarTheme(
        backgroundColor: _dcCrimson,
        foregroundColor: _dcWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DeleteCharacterIntent',
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
                  colors: [_dcDarkCrimson, _dcCrimson, _dcMedCrimson],
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
                      color: _dcWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.backspace,
                        color: _dcWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DeleteCharacterIntent',
                      style: TextStyle(
                          color: _dcWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Delete characters forward or backward at the cursor',
                      style: TextStyle(
                          color: _dcWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dcChip('Backspace', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                      _dcChip('Delete', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                      _dcChip('Cursor', _dcWhite.withValues(alpha: 0.25), _dcWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('1 · What Is DeleteCharacterIntent?', [
              _dcBody(
                'DeleteCharacterIntent is the semantic intent dispatched '
                'when the user presses Backspace or Delete to remove a '
                'single character from text. It carries a direction flag '
                'indicating whether to delete forward or backward.',
              ),
              _dcLabel('Class definition'),
              _dcCodeBlock(
                'Intent (abstract)\n'
                '  └─ DeleteCharacterIntent\n'
                '       • forward: bool\n'
                '       • true → Delete key (remove char after cursor)\n'
                '       • false → Backspace key (remove char before cursor)\n'
                '       • const constructor',
              ),
              _dcDivider(),
              _dcBody(
                'This intent cleanly separates the physical key event '
                'from the text manipulation, allowing the same delete '
                'behavior regardless of input method.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Forward vs Backward deletion
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('2 · Forward vs Backward Deletion', [
              _dcBody(
                'The key distinction in DeleteCharacterIntent is the '
                'deletion direction, controlled by the forward property.',
              ),
              _buildDirectionComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Shortcut → Intent → Action
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('3 · Shortcut → Intent → Action Chain', [
              _dcBody(
                'The delete operation follows the same three-layer '
                'architecture as all Flutter text intents.',
              ),
              ..._buildDeleteChain(),
              _dcDivider(),
              _dcLabel('Wiring code'),
              _dcCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    SingleActivator(LogicalKeyboardKey.backspace):\n'
                '      DeleteCharacterIntent(forward: false),\n'
                '    SingleActivator(LogicalKeyboardKey.delete):\n'
                '      DeleteCharacterIntent(forward: true),\n'
                '  },\n'
                '  child: textEditingActions,\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Cursor position and direction
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('4 · Cursor Position and Deletion', [
              _dcBody(
                'The character deleted depends on cursor position and '
                'the forward flag. Boundary cases are handled gracefully.',
              ),
              _buildCursorPositionDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Platform shortcuts
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('5 · Platform Delete Shortcuts', [
              _dcBody(
                'Different platforms have different modifier keys for '
                'extended delete operations.',
              ),
              _buildPlatformDeleteTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Word-level deletion
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('6 · Word-Level Deletion', [
              _dcBody(
                'Word-level deletion uses a separate intent (DeleteToNextWordBoundaryIntent) '
                'but follows the same directional pattern.',
              ),
              _buildWordDeleteDemo(),
              _dcDivider(),
              _dcCodeBlock(
                '// Character delete:\n'
                'Hel|lo → Hel|o  (forward: true)\n'
                'Hel|lo → He|lo  (forward: false)\n'
                '\n'
                '// Word delete (Ctrl+Backspace):\n'
                'Hello Wor|ld → Hello |ld\n'
                '\n'
                '// Word delete (Ctrl+Delete):\n'
                'Hello Wor|ld → Hello Wor|',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Line-level deletion
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('7 · Line-Level Deletion', [
              _dcBody(
                'Line-level deletion removes all characters from cursor '
                'to the line boundary.',
              ),
              _buildLineDeleteDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Selection deletion
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('8 · Selection Deletion Behavior', [
              _dcBody(
                'When text is selected (non-collapsed selection), both '
                'Backspace and Delete remove the entire selection regardless '
                'of direction.',
              ),
              _buildSelectionDeleteVisual(),
              _dcDivider(),
              _dcCodeBlock(
                '// With selection:\n'
                'He[llo Wo]rld  ← selection from index 2-8\n'
                '\n'
                '// Backspace or Delete:\n'
                'He|rld  ← selection replaced with collapsed cursor',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Undo integration
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('9 · Undo Integration', [
              _dcBody(
                'Every delete operation pushes onto the undo stack, '
                'allowing Ctrl+Z to restore the deleted character.',
              ),
              _buildUndoFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Text field delete visual
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('10 · Text Field Delete Visual', [
              _dcBody(
                'A series of delete operations on a text field, showing '
                'cursor movement and character removal.',
              ),
              _buildDeleteSequenceDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Edge cases
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('11 · Edge Cases', [
              ..._buildEdgeCases(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dcSection('12 · Summary', [
              _dcBody(
                'DeleteCharacterIntent is the foundational text deletion '
                'intent in Flutter, handling single-character removal.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_dcCrimson, _dcMedCrimson],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _dcSummaryRow(Icons.backspace, 'Backspace = backward, Delete = forward'),
                    _dcSummaryRow(Icons.swap_horiz, 'Direction controlled by forward property'),
                    _dcSummaryRow(Icons.select_all, 'Selection mode: deletes entire selection'),
                    _dcSummaryRow(Icons.undo, 'Every delete is undoable via Ctrl+Z'),
                    _dcSummaryRow(Icons.text_fields, 'Works in all text editing widgets'),
                    _dcSummaryRow(Icons.emoji_symbols, 'Handles emoji/grapheme clusters correctly'),
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
Widget _buildDirectionComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dcBlush,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dcAccentOrange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: _dcAccentOrange.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.keyboard_backspace,
                    color: _dcAccentOrange, size: 28),
                const SizedBox(height: 6),
                const Text('Backspace',
                    style: TextStyle(
                        color: _dcAccentOrange,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: false',
                    style: TextStyle(
                        color: _dcAccentOrange,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dcDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dcWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      const Text('Hel|lo',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: _dcDarkText)),
                      const Icon(Icons.arrow_downward,
                          size: 14, color: _dcAccentOrange),
                      const Text('He|lo',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: _dcDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Deletes char BEFORE cursor',
                    style: TextStyle(
                        color: _dcAccentOrange, fontSize: 9)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dcCrimson.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _dcCrimson.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.delete,
                    color: _dcCrimson, size: 28),
                const SizedBox(height: 6),
                const Text('Delete',
                    style: TextStyle(
                        color: _dcCrimson,
                        fontSize: 13,
                        fontWeight: FontWeight.w800)),
                const Text('forward: true',
                    style: TextStyle(
                        color: _dcCrimson,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _dcDivider(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _dcWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      const Text('Hel|lo',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: _dcDarkText)),
                      const Icon(Icons.arrow_downward,
                          size: 14, color: _dcCrimson),
                      const Text('Hel|o',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: _dcDarkText)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Deletes char AFTER cursor',
                    style: TextStyle(
                        color: _dcCrimson, fontSize: 9)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Delete chain
// ─────────────────────────────────────────────────────────────
List<Widget> _buildDeleteChain() {
  final layers = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut Layer',
      'detail': 'Backspace/Delete → DeleteCharacterIntent(forward)',
      'color': _dcAccentBlue,
    },
    {
      'icon': Icons.delete_outline,
      'title': 'Intent Layer',
      'detail': 'Carries direction and deletion semantics',
      'color': _dcCrimson,
    },
    {
      'icon': Icons.edit,
      'title': 'Action Layer',
      'detail': 'Modifies TextEditingValue, updates selection',
      'color': _dcAccentGreen,
    },
  ];
  return layers.map((l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (l['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (l['color'] as Color).withValues(alpha: 0.3)),
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
            child:
                Icon(l['icon'] as IconData, color: _dcWhite, size: 18),
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
                    style: const TextStyle(
                        color: _dcDarkText, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 4: Cursor position demo
// ─────────────────────────────────────────────────────────────
Widget _buildCursorPositionDemo() {
  final positions = <Map<String, dynamic>>[
    {'label': 'Start of text', 'text': '|Hello', 'backspace': 'No-op (nothing before cursor)', 'delete': '|ello', 'color': _dcAccentBlue},
    {'label': 'Middle of text', 'text': 'He|llo', 'backspace': 'H|llo', 'delete': 'He|lo', 'color': _dcCrimson},
    {'label': 'End of text', 'text': 'Hello|', 'backspace': 'Hell|', 'delete': 'No-op (nothing after cursor)', 'color': _dcAccentPurple},
  ];

  return Column(
    children: positions.map((p) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (p['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (p['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(p['label'] as String,
                    style: TextStyle(
                        color: p['color'] as Color,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _dcWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: (p['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: Text(p['text'] as String,
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: _dcDarkText)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.keyboard_backspace,
                          size: 12, color: _dcAccentOrange),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p['backspace'] as String,
                            style: const TextStyle(
                                color: _dcDarkText,
                                fontSize: 10,
                                fontFamily: 'monospace')),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.delete,
                          size: 12, color: _dcCrimson),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p['delete'] as String,
                            style: const TextStyle(
                                color: _dcDarkText,
                                fontSize: 10,
                                fontFamily: 'monospace')),
                      ),
                    ],
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
// Section 5: Platform delete table
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformDeleteTable() {
  final rows = <List<String>>[
    ['Action', 'macOS', 'Windows/Linux'],
    ['Char backward', 'Backspace', 'Backspace'],
    ['Char forward', 'Fn+Backspace', 'Delete'],
    ['Word backward', 'Opt+Backspace', 'Ctrl+Backspace'],
    ['Word forward', 'Opt+Fn+Backspace', 'Ctrl+Delete'],
    ['To line start', 'Cmd+Backspace', '—'],
    ['To line end', 'Cmd+Fn+Backspace', '—'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          color: isHeader
              ? _dcCrimson
              : entry.key.isEven
                  ? _dcBlush
                  : _dcWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _dcWhite : _dcDarkText,
                        fontSize: 10.5,
                        fontWeight: isHeader
                            ? FontWeight.w700
                            : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Word delete demo
// ─────────────────────────────────────────────────────────────
Widget _buildWordDeleteDemo() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dcBlush,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dcCrimson.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _dcCrimson.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Character',
                    style: TextStyle(
                        color: _dcCrimson,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const Text('Backspace',
                    style: TextStyle(
                        color: _dcCrimson,
                        fontSize: 9,
                        fontFamily: 'monospace')),
                _dcDivider(),
                const Text('Removes 1 char',
                    style: TextStyle(
                        color: _dcDarkText, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dcAccentPurple.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: _dcAccentPurple.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Word',
                    style: TextStyle(
                        color: _dcAccentPurple,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const Text('Ctrl+Backspace',
                    style: TextStyle(
                        color: _dcAccentPurple,
                        fontSize: 9,
                        fontFamily: 'monospace')),
                _dcDivider(),
                const Text('Removes to word boundary',
                    style: TextStyle(
                        color: _dcDarkText, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dcAccentTeal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: _dcAccentTeal.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Line',
                    style: TextStyle(
                        color: _dcAccentTeal,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const Text('Cmd+Backspace',
                    style: TextStyle(
                        color: _dcAccentTeal,
                        fontSize: 9,
                        fontFamily: 'monospace')),
                _dcDivider(),
                const Text('Removes to line start',
                    style: TextStyle(
                        color: _dcDarkText, fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Line delete demo
// ─────────────────────────────────────────────────────────────
Widget _buildLineDeleteDemo() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dcBlush,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    child: Column(
      children: [
        _dcLabel('macOS line deletion'),
        _dcCodeBlock(
          'Before: The quick brown fox| jumps over\n'
          '\n'
          'Cmd+Backspace (delete to line start):\n'
          'After:  |jumps over\n'
          '\n'
          'Cmd+Fn+Backspace (delete to line end):\n'
          'After:  The quick brown fox|',
        ),
        _dcBody(
          'Line-level deletion uses DeleteToLineBreakIntent, '
          'which is a sibling to DeleteCharacterIntent in the '
          'intent hierarchy.',
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Selection delete visual
// ─────────────────────────────────────────────────────────────
Widget _buildSelectionDeleteVisual() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dcBlush,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dcWhite,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              const Text('Before: selection active',
                  style: TextStyle(
                      color: _dcDarkCrimson,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: _dcDarkText),
                  children: [
                    const TextSpan(text: 'He'),
                    TextSpan(
                        text: 'llo Wo',
                        style: TextStyle(
                            backgroundColor:
                                _dcMedCrimson.withValues(alpha: 0.3),
                            fontWeight: FontWeight.w700)),
                    const TextSpan(text: 'rld'),
                  ],
                ),
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
                  color: _dcAccentOrange.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: _dcAccentOrange.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.keyboard_backspace,
                        size: 16, color: _dcAccentOrange),
                    const Text('Backspace',
                        style: TextStyle(
                            color: _dcAccentOrange,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                    const Text('He|rld',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: _dcDarkText)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _dcCrimson.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: _dcCrimson.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.delete,
                        size: 16, color: _dcCrimson),
                    Text('Delete',
                        style: TextStyle(
                            color: _dcCrimson,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                    Text('He|rld',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: _dcDarkText)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _dcCrimson.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
              'Both keys produce identical result — selection is deleted',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _dcCrimson,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Undo flow
// ─────────────────────────────────────────────────────────────
Widget _buildUndoFlow() {
  final steps = <Map<String, dynamic>>[
    {'step': 'Type "Flutter"', 'state': 'Flutter|', 'color': _dcAccentBlue},
    {'step': 'Backspace ×3', 'state': 'Flu|', 'color': _dcCrimson},
    {'step': 'Ctrl+Z (undo ×1)', 'state': 'Flut|', 'color': _dcAccentGreen},
    {'step': 'Ctrl+Z (undo ×2)', 'state': 'Flutt|', 'color': _dcAccentGreen},
    {'step': 'Ctrl+Z (undo ×3)', 'state': 'Flutter|', 'color': _dcAccentGreen},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dcBlush,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dcLightCrimson),
    ),
    child: Column(
      children: steps.asMap().entries.map((entry) {
        final s = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (s['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: (s['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: s['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          color: _dcWhite,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(s['step'] as String,
                    style: TextStyle(
                        color: s['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _dcWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: (s['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Text(s['state'] as String,
                    style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _dcDarkText)),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Delete sequence demo
// ─────────────────────────────────────────────────────────────
Widget _buildDeleteSequenceDemo() {
  final steps = <Map<String, String>>[
    {'action': 'Initial', 'field': 'Hello World|'},
    {'action': 'Backspace', 'field': 'Hello Worl|'},
    {'action': 'Backspace', 'field': 'Hello Wor|'},
    {'action': '← arrow ×3', 'field': 'Hello |orld'},
    {'action': 'Delete', 'field': 'Hello |rld'},
    {'action': 'Delete', 'field': 'Hello |ld'},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dcLightCrimson),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dcCrimson,
          child: const Row(
            children: [
              Icon(Icons.text_fields, color: _dcWhite, size: 14),
              SizedBox(width: 8),
              Text('Delete Sequence',
                  style: TextStyle(
                      color: _dcWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...steps.asMap().entries.map((entry) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            color: entry.key.isEven ? _dcBlush : _dcWhite,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _dcCrimson.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${entry.key + 1}',
                        style: const TextStyle(
                            color: _dcCrimson,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: Text(entry.value['action']!,
                      style: const TextStyle(
                          color: _dcDarkCrimson,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _dcWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: _dcLightCrimson.withValues(alpha: 0.5)),
                    ),
                    child: Text(entry.value['field']!,
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _dcDarkText)),
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
      'case': 'Empty field',
      'desc': 'Both Backspace and Delete are no-ops',
      'icon': Icons.text_fields,
      'color': _dcAccentBlue,
    },
    {
      'case': 'Emoji / grapheme clusters',
      'desc': 'Deletes entire emoji (e.g., family emoji = 1 delete)',
      'icon': Icons.emoji_emotions,
      'color': _dcAccentOrange,
    },
    {
      'case': 'Combining characters',
      'desc': 'Deletes base + combining marks as one unit',
      'icon': Icons.text_format,
      'color': _dcAccentPurple,
    },
    {
      'case': 'RTL text',
      'desc': 'Forward/backward follows logical order, not visual',
      'icon': Icons.format_textdirection_r_to_l,
      'color': _dcAccentTeal,
    },
    {
      'case': 'Max length field',
      'desc': 'Delete always allowed even at maxLength limit',
      'icon': Icons.straighten,
      'color': _dcAccentGreen,
    },
    {
      'case': 'Read-only field',
      'desc': 'DeleteCharacterIntent dispatched but action is disabled',
      'icon': Icons.lock,
      'color': _dcDarkCrimson,
    },
  ];

  return cases.map((c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (c['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (c['color'] as Color).withValues(alpha: 0.3)),
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
            child:
                Icon(c['icon'] as IconData, color: _dcWhite, size: 15),
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
                    style: const TextStyle(
                        color: _dcDarkText, fontSize: 10)),
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
Widget _dcSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _dcWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _dcWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}
