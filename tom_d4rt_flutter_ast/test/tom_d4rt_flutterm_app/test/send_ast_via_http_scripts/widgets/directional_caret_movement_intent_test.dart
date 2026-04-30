// ignore_for_file: avoid_print
// Deep demo: DirectionalCaretMovementIntent — an intent that describes the
// desire to move the text editing caret in a specific direction (left, right,
// up, down, line start, line end, document start, document end) within an
// editable text field, supporting selection extension and word boundaries.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Royal Purple (#4A148C) on Lilac Mist (#F3E5F5)
// Prefix: _cm (caret movement)
// ────────────────────────────────────────────────────────────

const Color _cmPurple = Color(0xFF4A148C);
const Color _cmLilac = Color(0xFFF3E5F5);
const Color _cmDarkPurple = Color(0xFF311B92);
const Color _cmLightPurple = Color(0xFF7B1FA2);
const Color _cmMuted = Color(0xFF78909C);
const Color _cmAccent = Color(0xFFAB47BC);
const Color _cmSurface = Color(0xFFEDE7F6);
const Color _cmDivider = Color(0xFFD1C4E9);
const Color _cmWhite = Color(0xFFFFFFFF);
const Color _cmBlack = Color(0xFF212121);
const Color _cmError = Color(0xFFC62828);
const Color _cmSuccess = Color(0xFF2E7D32);
const Color _cmInfo = Color(0xFF1565C0);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_cmPurple, _cmDarkPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _cmPurple.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.text_fields, color: _cmLilac, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DirectionalCaretMovementIntent',
                      style: TextStyle(
                        color: _cmLilac,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An intent for moving the text editing caret in a specific '
                'direction — left, right, up, down, or to logical boundaries '
                'like word edges, line ends, and document boundaries.',
                style: TextStyle(
                  color: _cmLilac.withValues(alpha: 0.88),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _cmSection('1. What Is DirectionalCaretMovementIntent?'),
        _cmBody(
          'DirectionalCaretMovementIntent is part of Flutter\'s Actions and '
          'Shortcuts system for text editing. It represents the user\'s desire '
          'to move the caret (text cursor) in a particular direction within an '
          'editable text field. Unlike raw key events, this intent is platform '
          'and keyboard agnostic — it describes WHAT should happen (move caret '
          'left by one character) rather than HOW (the user pressed the left '
          'arrow key). This separation allows the same intent to be triggered '
          'by keyboard shortcuts, gestures, screen readers, or programmatic '
          'code.',
        ),
        const SizedBox(height: 12),
        _cmInfoBox(
          'Intent vs Action',
          'The Intent describes the desire ("move caret left"). The Action '
          'executes it ("update TextEditingValue.selection with offset - 1"). '
          'DirectionalCaretMovementIntent carries the direction and modifiers; '
          'the Action reads the current selection and applies the movement.',
        ),
        const SizedBox(height: 24),

        // ── 2. Direction Enumeration ──
        _cmSection('2. Movement Directions'),
        _cmBody(
          'The intent supports multiple movement directions, each mapping '
          'to different caret positioning behavior:',
        ),
        const SizedBox(height: 12),
        _buildDirectionGrid(),
        const SizedBox(height: 24),

        // ── 3. Intent Properties ──
        _cmSection('3. Intent Properties'),
        _cmBody(
          'DirectionalCaretMovementIntent carries several properties that '
          'modify how the caret moves:',
        ),
        const SizedBox(height: 12),
        _buildPropertiesTable(),
        const SizedBox(height: 12),
        _cmCodeBlock(
          '// Intent construction\n'
          'class DirectionalCaretMovementIntent\n'
          '    extends DirectionalTextEditingIntent {\n'
          '  const DirectionalCaretMovementIntent({\n'
          '    required this.forward,\n'
          '    required this.collapseSelection,\n'
          '    this.collapseAtReversal = false,\n'
          '    this.continuesAtWrap = false,\n'
          '  });\n'
          '\n'
          '  /// True = forward (right/down)\n'
          '  /// False = backward (left/up)\n'
          '  final bool forward;\n'
          '\n'
          '  /// If true, collapse selection to a point\n'
          '  /// If false, extend the selection range\n'
          '  final bool collapseSelection;\n'
          '\n'
          '  /// Collapse at reversal of direction\n'
          '  final bool collapseAtReversal;\n'
          '\n'
          '  /// Continue past line wraps\n'
          '  final bool continuesAtWrap;\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 4. Keyboard Mapping ──
        _cmSection('4. Keyboard Shortcut Mapping'),
        _cmBody(
          'Different keyboard combinations map to specific intent '
          'configurations. The mapping varies by platform:',
        ),
        const SizedBox(height: 12),
        _buildKeyboardMappingTable(),
        const SizedBox(height: 24),

        // ── 5. Selection Extension ──
        _cmSection('5. Selection Extension'),
        _cmBody(
          'When collapseSelection is false (typically when Shift is held), '
          'the caret movement extends the selection range rather than '
          'collapsing it to a point. The base offset stays fixed while '
          'the extent moves:',
        ),
        const SizedBox(height: 12),
        _buildSelectionExtensionDiagram(),
        const SizedBox(height: 12),
        _cmCodeBlock(
          '// Selection extension logic\n'
          'TextSelection _moveWithSelection(\n'
          '  TextSelection current,\n'
          '  int newOffset,\n'
          '  bool collapseSelection,\n'
          ') {\n'
          '  if (collapseSelection) {\n'
          '    return TextSelection.collapsed(\n'
          '      offset: newOffset,\n'
          '    );\n'
          '  }\n'
          '  // Extend selection, keeping base fixed\n'
          '  return current.copyWith(\n'
          '    extentOffset: newOffset,\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 6. Word Boundary Movement ──
        _cmSection('6. Word Boundary Movement'),
        _cmBody(
          'Moving by word boundaries uses text segmentation to skip to '
          'the next word edge. This interacts with Unicode word break '
          'rules and is locale-sensitive:',
        ),
        const SizedBox(height: 12),
        _buildWordBoundaryVisualization(),
        const SizedBox(height: 12),
        _cmCodeBlock(
          '// Word boundary detection\n'
          'int _findWordBoundary(\n'
          '  String text,\n'
          '  int offset,\n'
          '  bool forward,\n'
          ') {\n'
          '  final boundary = _wordBoundary(text, offset);\n'
          '  if (forward) {\n'
          '    // Move to end of current word,\n'
          '    // then skip whitespace to next word\n'
          '    var pos = boundary.end;\n'
          '    while (pos < text.length &&\n'
          '        _isWhitespace(text.codeUnitAt(pos))) {\n'
          '      pos++;\n'
          '    }\n'
          '    return pos;\n'
          '  }\n'
          '  // Move to start of current word,\n'
          '  // then skip whitespace backward\n'
          '  var pos = boundary.start;\n'
          '  while (pos > 0 &&\n'
          '      _isWhitespace(\n'
          '          text.codeUnitAt(pos - 1))) {\n'
          '    pos--;\n'
          '  }\n'
          '  return _wordBoundary(text, pos - 1).start;\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 7. Line Boundary Movement ──
        _cmSection('7. Line Boundary Movement'),
        _cmBody(
          'Home/End key behavior moves the caret to the beginning or end '
          'of the current line. This considers soft wraps (visual lines) '
          'versus hard line breaks:',
        ),
        const SizedBox(height: 12),
        _buildLineBoundaryComparison(),
        const SizedBox(height: 24),

        // ── 8. Vertical Movement ──
        _cmSection('8. Vertical Line Movement'),
        _cmBody(
          'Up/Down arrow movement maintains a "preferred column" offset '
          'so the caret returns to its horizontal position when navigating '
          'through lines of different lengths:',
        ),
        const SizedBox(height: 12),
        _buildVerticalMovementDiagram(),
        const SizedBox(height: 12),
        _cmCodeBlock(
          '// Vertical movement with sticky column\n'
          'int _moveVertically(\n'
          '  TextPosition current,\n'
          '  bool forward,\n'
          '  double preferredX,\n'
          ') {\n'
          '  final currentLine = _getLineForOffset(\n'
          '    current.offset,\n'
          '  );\n'
          '  final targetLine = forward\n'
          '      ? currentLine + 1\n'
          '      : currentLine - 1;\n'
          '  if (targetLine < 0 ||\n'
          '      targetLine >= _lineCount) {\n'
          '    return current.offset;\n'
          '  }\n'
          '  // Find offset at preferred X in target line\n'
          '  return _getOffsetForPosition(\n'
          '    Offset(preferredX,\n'
          '        _getLineTop(targetLine)),\n'
          '  );\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 9. RTL / BiDi ──
        _cmSection('9. Right-to-Left & Bidirectional Text'),
        _cmBody(
          'In RTL text or mixed-direction content, "forward" does not '
          'always mean "right". The intent respects the text direction '
          'of the current paragraph:',
        ),
        const SizedBox(height: 12),
        _buildBidiDirectionTable(),
        const SizedBox(height: 24),

        // ── 10. Action Resolution ──
        _cmSection('10. Action Resolution Chain'),
        _cmBody(
          'The intent flows through Flutter\'s action dispatch system '
          'to find the appropriate handler:',
        ),
        const SizedBox(height: 12),
        _buildActionResolutionFlow(),
        const SizedBox(height: 24),

        // ── 11. Platform Differences ──
        _cmSection('11. Platform-Specific Behavior'),
        _cmBody(
          'Different platforms have distinct expectations for caret '
          'movement, particularly around modifier keys and word boundaries:',
        ),
        const SizedBox(height: 12),
        _buildPlatformDifferencesGrid(),
        const SizedBox(height: 24),

        // ── 12. Practical Scenario ──
        _cmSection('12. Custom Editor Scenario'),
        _cmBody(
          'Implementing custom caret movement in a code editor that '
          'treats camelCase boundaries as word stops:',
        ),
        const SizedBox(height: 12),
        _buildCustomEditorScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _cmPurple.withValues(alpha: 0.08),
                _cmLilac,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _cmPurple.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _cmPurple, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _cmPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _cmSummaryRow('Type', 'Intent (extends DirectionalTextEditingIntent)'),
              _cmSummaryRow('Directions', 'Forward, Backward, Up, Down, Line, Document'),
              _cmSummaryRow('Selection', 'Collapse or extend via collapseSelection flag'),
              _cmSummaryRow('Word Stops', 'Unicode word break rules, locale-sensitive'),
              _cmSummaryRow('Vertical', 'Sticky preferred column across lines'),
              _cmSummaryRow('BiDi', 'Respects paragraph text direction'),
              _cmSummaryRow('Platforms', 'macOS/Windows/Linux shortcuts differ'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _cmSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _cmPurple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _cmBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _cmBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _cmCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _cmChip(String text, {Color? bg, Color? fg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg ?? _cmPurple.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg ?? _cmPurple,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _cmInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _cmInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _cmInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _cmBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _cmSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              color: _cmMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _cmBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildDirectionGrid() {
  final directions = <Map<String, dynamic>>[
    {
      'dir': 'Left (Backward)',
      'key': '\u2190 Arrow',
      'desc': 'Move caret one character left',
      'icon': Icons.arrow_back,
      'color': _cmPurple,
    },
    {
      'dir': 'Right (Forward)',
      'key': '\u2192 Arrow',
      'desc': 'Move caret one character right',
      'icon': Icons.arrow_forward,
      'color': _cmLightPurple,
    },
    {
      'dir': 'Up',
      'key': '\u2191 Arrow',
      'desc': 'Move caret to previous visual line',
      'icon': Icons.arrow_upward,
      'color': _cmAccent,
    },
    {
      'dir': 'Down',
      'key': '\u2193 Arrow',
      'desc': 'Move caret to next visual line',
      'icon': Icons.arrow_downward,
      'color': _cmDarkPurple,
    },
    {
      'dir': 'Word Left',
      'key': 'Ctrl+\u2190',
      'desc': 'Jump to previous word boundary',
      'icon': Icons.first_page,
      'color': _cmInfo,
    },
    {
      'dir': 'Word Right',
      'key': 'Ctrl+\u2192',
      'desc': 'Jump to next word boundary',
      'icon': Icons.last_page,
      'color': _cmSuccess,
    },
    {
      'dir': 'Line Start',
      'key': 'Home',
      'desc': 'Move caret to beginning of line',
      'icon': Icons.subdirectory_arrow_left,
      'color': _cmError,
    },
    {
      'dir': 'Line End',
      'key': 'End',
      'desc': 'Move caret to end of line',
      'icon': Icons.subdirectory_arrow_right,
      'color': _cmMuted,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var d in directions)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (d['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (d['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(d['icon'] as IconData,
                      color: d['color'] as Color, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      d['dir'] as String,
                      style: TextStyle(
                        color: d['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _cmChip(d['key'] as String),
              const SizedBox(height: 4),
              Text(
                d['desc'] as String,
                style: TextStyle(color: _cmBlack, fontSize: 11),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildPropertiesTable() {
  final props = <List<String>>[
    ['forward', 'bool', 'true = right/down, false = left/up'],
    ['collapseSelection', 'bool', 'true = collapse, false = extend selection'],
    ['collapseAtReversal', 'bool', 'Collapse when reversing selection direction'],
    ['continuesAtWrap', 'bool', 'Continue past soft line wraps'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _cmPurple.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text('Property', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Type', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 6,
                child: Text('Behavior', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in props)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _cmDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(row[0], style: TextStyle(
                    color: _cmDarkPurple, fontSize: 12,
                    fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[1], style: TextStyle(
                    color: _cmMuted, fontSize: 12)),
                ),
                Expanded(
                  flex: 6,
                  child: Text(row[2], style: TextStyle(
                    color: _cmBlack, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildKeyboardMappingTable() {
  final mappings = <List<String>>[
    ['\u2190', 'backward, collapse', 'Move left, collapse selection'],
    ['Shift+\u2190', 'backward, extend', 'Extend selection left'],
    ['Ctrl+\u2190', 'word backward, collapse', 'Jump to previous word'],
    ['Ctrl+Shift+\u2190', 'word backward, extend', 'Select previous word'],
    ['Home', 'line start, collapse', 'Jump to line start'],
    ['Shift+Home', 'line start, extend', 'Select to line start'],
    ['Ctrl+Home', 'doc start, collapse', 'Jump to document start'],
    ['Ctrl+Shift+Home', 'doc start, extend', 'Select to document start'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _cmPurple.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Shortcut', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Intent Config', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Result', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in mappings)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _cmDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _cmDarkPurple, fontSize: 12,
                    fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[1], style: TextStyle(
                    color: _cmBlack, fontSize: 11, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[2], style: TextStyle(
                    color: _cmMuted, fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildSelectionExtensionDiagram() {
  final examples = <Map<String, dynamic>>[
    {
      'label': 'Before: collapsed caret',
      'text': 'Hello |world',
      'desc': 'Caret at position 6, no selection',
      'color': _cmPurple,
    },
    {
      'label': 'After: Shift+Right x3',
      'text': 'Hello [wor]ld',
      'desc': 'Selection extends from 6 to 9',
      'color': _cmAccent,
    },
    {
      'label': 'After: Shift+Left x2',
      'text': 'Hello [w]orld',
      'desc': 'Extent moves back, selection shrinks to 6..7',
      'color': _cmLightPurple,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < examples.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: (examples[i]['color'] as Color).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: examples[i]['color'] as Color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      examples[i]['label'] as String,
                      style: TextStyle(
                        color: examples[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      examples[i]['text'] as String,
                      style: TextStyle(
                        color: _cmBlack,
                        fontSize: 14,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      examples[i]['desc'] as String,
                      style: TextStyle(color: _cmMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < examples.length - 1) const SizedBox(height: 10),
        ],
      ],
    ),
  );
}

Widget _buildWordBoundaryVisualization() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Word Boundary Detection',
          style: TextStyle(
            color: _cmPurple,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Text: "The quick_brown fox.jumps"',
          style: TextStyle(
            color: _cmBlack,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 6,
          children: [
            _cmChip('|The', bg: _cmPurple.withValues(alpha: 0.12)),
            _cmChip('|quick_brown', bg: _cmAccent.withValues(alpha: 0.12),
                fg: _cmAccent),
            _cmChip('|fox', bg: _cmLightPurple.withValues(alpha: 0.12),
                fg: _cmLightPurple),
            _cmChip('|.', bg: _cmMuted.withValues(alpha: 0.12),
                fg: _cmMuted),
            _cmChip('|jumps|', bg: _cmInfo.withValues(alpha: 0.12),
                fg: _cmInfo),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Each | marks a word boundary. Ctrl+Left/Right jumps between '
          'these positions. Unicode rules determine what constitutes '
          'a "word" — letters, digits, underscores group together.',
          style: TextStyle(
            color: _cmMuted,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLineBoundaryComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _cmPurple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _cmPurple.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.wrap_text, color: _cmPurple, size: 16),
                  const SizedBox(width: 6),
                  Text('Soft Wrap', style: TextStyle(
                    color: _cmPurple, fontSize: 13,
                    fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Visual line break caused by container width. '
                'Home/End moves to visual line boundary. No '
                'newline character in text.',
                style: TextStyle(
                  color: _cmBlack, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _cmAccent.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _cmAccent.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard_return, color: _cmAccent, size: 16),
                  const SizedBox(width: 6),
                  Text('Hard Break', style: TextStyle(
                    color: _cmAccent, fontSize: 13,
                    fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Explicit newline character. Home/End moves '
                'to hard line boundary. May span multiple '
                'visual lines if text wraps.',
                style: TextStyle(
                  color: _cmBlack, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildVerticalMovementDiagram() {
  final lines = <Map<String, String>>[
    {'text': 'Short line', 'caret': 'col 5', 'note': 'Start here at col 5'},
    {'text': 'A much longer line of text....', 'caret': 'col 5', 'note': 'Down: caret at col 5'},
    {'text': 'Tiny', 'caret': 'col 4', 'note': 'Down: clamped to col 4 (end)'},
    {'text': 'Back to medium length', 'caret': 'col 5', 'note': 'Down: returns to preferred col 5'},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Column ("Sticky" Cursor)',
          style: TextStyle(
            color: _cmPurple,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < lines.length; i++) ...[
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _cmPurple.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _cmPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"${lines[i]['text']}"  [${lines[i]['caret']}]',
                      style: TextStyle(
                        color: _cmBlack,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      lines[i]['note']!,
                      style: TextStyle(
                        color: _cmMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < lines.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}

Widget _buildBidiDirectionTable() {
  final rows = <List<String>>[
    ['LTR paragraph', 'forward=true', 'Right', 'Logical forward = visual right'],
    ['LTR paragraph', 'forward=false', 'Left', 'Logical backward = visual left'],
    ['RTL paragraph', 'forward=true', 'Left', 'Logical forward = visual left'],
    ['RTL paragraph', 'forward=false', 'Right', 'Logical backward = visual right'],
    ['Mixed (BiDi)', 'forward=true', 'Varies', 'Depends on current run direction'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _cmPurple.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Context', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Intent', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Visual', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 4,
                child: Text('Explanation', style: TextStyle(
                  color: _cmPurple, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in rows)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _cmDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _cmDarkPurple, fontSize: 11,
                    fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(row[1], style: TextStyle(
                    color: _cmBlack, fontSize: 11, fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[2], style: TextStyle(
                    color: _cmAccent, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 4,
                  child: Text(row[3], style: TextStyle(
                    color: _cmMuted, fontSize: 11)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildActionResolutionFlow() {
  final steps = <Map<String, String>>[
    {
      'step': 'Keyboard event received',
      'detail': 'RawKeyDownEvent with arrow key + modifiers',
    },
    {
      'step': 'Shortcut binding matches',
      'detail': 'Shortcuts widget maps key combo to Intent',
    },
    {
      'step': 'DirectionalCaretMovementIntent created',
      'detail': 'With forward, collapseSelection, etc.',
    },
    {
      'step': 'Actions.invoke dispatches',
      'detail': 'Walks up the widget tree looking for handler',
    },
    {
      'step': 'EditableText\'s Action handles',
      'detail': 'Reads current selection, computes new offset',
    },
    {
      'step': 'TextEditingValue updated',
      'detail': 'New selection applied, caret position changes',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _cmPurple,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _cmWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _cmDarkPurple,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(color: _cmMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 4, bottom: 4),
              child: Container(width: 2, height: 10, color: _cmDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildPlatformDifferencesGrid() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'macOS',
      'wordKey': 'Option (\u2325)',
      'lineKey': 'Cmd (\u2318)',
      'notes': 'Option+Arrow for word, Cmd+Arrow for line/doc',
      'icon': Icons.laptop_mac,
      'color': _cmPurple,
    },
    {
      'platform': 'Windows',
      'wordKey': 'Ctrl',
      'lineKey': 'Home/End',
      'notes': 'Ctrl+Arrow for word, Home/End for line',
      'icon': Icons.desktop_windows,
      'color': _cmInfo,
    },
    {
      'platform': 'Linux',
      'wordKey': 'Ctrl',
      'lineKey': 'Home/End',
      'notes': 'Same as Windows in most desktop environments',
      'icon': Icons.computer,
      'color': _cmSuccess,
    },
    {
      'platform': 'iOS / Android',
      'wordKey': 'N/A',
      'lineKey': 'N/A',
      'notes': 'Touch-based: tap to place, long-press to select',
      'icon': Icons.phone_android,
      'color': _cmAccent,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var p in platforms)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (p['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (p['color'] as Color).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(p['icon'] as IconData,
                      color: p['color'] as Color, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    p['platform'] as String,
                    style: TextStyle(
                      color: p['color'] as Color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Word: ${p['wordKey']}',
                style: TextStyle(color: _cmBlack, fontSize: 11),
              ),
              Text(
                'Line: ${p['lineKey']}',
                style: TextStyle(color: _cmBlack, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Text(
                p['notes'] as String,
                style: TextStyle(
                  color: _cmMuted,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildCustomEditorScenario() {
  final steps = <Map<String, String>>[
    {
      'step': 'Define custom word boundary',
      'detail': 'Override boundary detection to split on '
          'camelCase transitions (e.g., "myVariable" → "my" + "Variable")',
    },
    {
      'step': 'Create custom Action',
      'detail': 'Extend Action<DirectionalCaretMovementIntent> to use '
          'the custom boundary finder instead of the default Unicode rules',
    },
    {
      'step': 'Register in Actions widget',
      'detail': 'Wrap the EditableText with an Actions widget that '
          'provides the custom action for DirectionalCaretMovementIntent',
    },
    {
      'step': 'Bind shortcuts',
      'detail': 'Use Shortcuts widget to map Ctrl+Arrow to the intent '
          'with word-boundary movement configuration',
    },
    {
      'step': 'Test BiDi behavior',
      'detail': 'Verify camelCase splitting works correctly in RTL text '
          'and mixed-direction content',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cmSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _cmDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: _cmPurple, size: 20),
            const SizedBox(width: 8),
            Text(
              'CamelCase-Aware Code Editor',
              style: TextStyle(
                color: _cmPurple,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _cmPurple.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _cmPurple,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _cmDarkPurple,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _cmBlack,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1) const SizedBox(height: 10),
        ],
      ],
    ),
  );
}
