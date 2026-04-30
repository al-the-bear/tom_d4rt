// ignore_for_file: avoid_print, unused_element
import 'package:flutter/material.dart';

// ============================================================================
// SELECTED CONTENT RANGE — Deep Demo
// ============================================================================
//
// SelectedContentRange is a data class in Flutter's rendering-layer
// selection system that represents a contiguous range of selected
// content within a single Selectable.  It carries:
//
//   • startOffset — the character index where selection begins
//   • endOffset   — the character index where selection ends
//
// This class exists to communicate precisely WHICH portion of a
// Selectable's content is currently selected.  It is used internally
// by the selection system to:
//
//   1. Determine what text to include when the user copies
//   2. Calculate highlight rectangles for the selection overlay
//   3. Report selection state to accessibility services
//
// SelectedContentRange works alongside SelectedContent (which holds
// the actual text string) to form the complete picture of what the
// user has selected.
//
// Color theme : Burgundy (#800020) / Blush (#FFB6C1)
// Helper prefix: _cr
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _crBurgundy = Color(0xFF800020);
const Color _crBlush = Color(0xFFFFB6C1);
const Color _crDarkBurgundy = Color(0xFF550015);
const Color _crLightBlush = Color(0xFFFFE4E8);
const Color _crWine = Color(0xFF722F37);
const Color _crIvory = Color(0xFFFFF8F0);
const Color _crCharcoal = Color(0xFF36303A);
const Color _crGold = Color(0xFFD4A017);
const Color _crTeal = Color(0xFF008080);
const Color _crLavender = Color(0xFF967BB6);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _crSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_crBurgundy, _crDarkBurgundy],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _crInfoCard(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _crLightBlush,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _crBlush, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _crBurgundy, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _crCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _crCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _crCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _crBlush,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _crDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _crBlush.withValues(alpha: 0.4),
  );
}

Widget _crBadge(String label, Color bgColor, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _crSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _crBurgundy,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _crKeyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            key,
            style: const TextStyle(
              color: _crWine,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _crCharcoal,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Overview: What is SelectedContentRange?
// ---------------------------------------------------------------------------
Widget _crBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '1. What Is SelectedContentRange?',
        subtitle: 'A data class representing the range of selection within content',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'SelectedContentRange is a simple but essential data class in '
        'Flutter\'s selection architecture.  It represents the specific '
        'portion of a Selectable\'s content that is currently selected, '
        'described by a start offset and an end offset.',
      ),
      _crCodeBlock(
        'class SelectedContentRange {\n'
        '  const SelectedContentRange({\n'
        '    required this.startOffset,\n'
        '    required this.endOffset,\n'
        '  });\n'
        '\n'
        '  final int startOffset;\n'
        '  final int endOffset;\n'
        '}',
      ),
      _crInfoCard(
        'Think of it like highlighting text in an editor:\n\n'
        '  "Hello, World!"\n'
        '   0123456789...\n\n'
        'If you select "World", the range is:\n'
        '  startOffset = 7,  endOffset = 12\n\n'
        'The range is always in terms of character indices within '
        'the Selectable\'s content.',
        icon: Icons.text_fields,
      ),

      // Visual: Text with offset markers
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _crIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crBurgundy, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Character Offset Visualization',
              style: TextStyle(
                color: _crDarkBurgundy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            // The text with highlighted portion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._crBuildCharacterBoxes(
                  'Hello, World!',
                  highlightStart: 7,
                  highlightEnd: 12,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Offset numbers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 13; i++)
                  SizedBox(
                    width: 24,
                    child: Text(
                      '$i',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (i >= 7 && i < 12) ? _crBurgundy : _crWine,
                        fontSize: 9,
                        fontWeight: (i >= 7 && i < 12)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _crBadge('start: 7', _crBurgundy),
                const SizedBox(width: 8),
                _crBadge('end: 12', _crWine),
                const SizedBox(width: 8),
                _crBadge('"World"', _crTeal),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

List<Widget> _crBuildCharacterBoxes(
  String text, {
  required int highlightStart,
  required int highlightEnd,
}) {
  final result = <Widget>[];
  for (int i = 0; i < text.length; i++) {
    final isHighlighted = i >= highlightStart && i < highlightEnd;
    result.add(
      Container(
        width: 24,
        height: 32,
        decoration: BoxDecoration(
          color: isHighlighted
              ? _crBurgundy.withValues(alpha: 0.2)
              : Colors.white,
          border: Border.all(
            color: isHighlighted ? _crBurgundy : _crBlush,
            width: isHighlighted ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text[i],
            style: TextStyle(
              color: isHighlighted ? _crBurgundy : _crCharcoal,
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
  return result;
}

// ---------------------------------------------------------------------------
// Section 2 — Fields and Properties
// ---------------------------------------------------------------------------
Widget _crBuildFields() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '2. Fields and Properties',
        subtitle: 'The two integers that define a selection range',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'SelectedContentRange is intentionally minimal — just two fields.  '
        'This simplicity makes it easy to pass around, compare, and '
        'use for substring extraction.',
      ),

      // Visual: Field cards
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _crBurgundy),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _crBurgundy,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Text(
                'SelectedContentRange Fields',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            // startOffset
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              color: _crLightBlush,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _crBadge('int', _crTeal),
                      const SizedBox(width: 8),
                      const Text(
                        'startOffset',
                        style: TextStyle(
                          color: _crDarkBurgundy,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'The inclusive character index where the selection begins. '
                    'This is the position of the first selected character.',
                    style: TextStyle(
                      color: _crCharcoal,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: _crBlush),
            // endOffset
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _crBadge('int', _crTeal),
                      const SizedBox(width: 8),
                      const Text(
                        'endOffset',
                        style: TextStyle(
                          color: _crDarkBurgundy,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'The exclusive character index where the selection ends. '
                    'Characters from startOffset up to (not including) endOffset '
                    'are selected.',
                    style: TextStyle(
                      color: _crCharcoal,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      _crSubheading('Offset Conventions'),
      _crInfoCard(
        'The range uses the standard Dart/Flutter convention:\n\n'
        '• startOffset is INCLUSIVE (the character at this index IS selected)\n'
        '• endOffset is EXCLUSIVE (the character at this index is NOT selected)\n\n'
        'This matches String.substring(start, end) semantics, making it '
        'trivial to extract the selected text:\n'
        '  text.substring(range.startOffset, range.endOffset)',
        icon: Icons.rule,
      ),
      _crCodeBlock(
        'final text = "Flutter selection system";\n'
        'final range = SelectedContentRange(\n'
        '  startOffset: 8,\n'
        '  endOffset: 17,\n'
        ');\n'
        '// text.substring(8, 17) == "selection"',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Range Scenarios
// ---------------------------------------------------------------------------
Widget _crBuildRangeScenarios() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '3. Range Scenarios',
        subtitle: 'Different selection states visualized',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'Selection ranges can represent many different states — from '
        'a collapsed cursor to a full document selection.  Each has '
        'a distinct visual appearance and semantic meaning.',
      ),

      // Scenario 1: Single word selected
      _crSubheading('Scenario A: Single Word Selected'),
      _crRangeVisualization(
        'The quick brown fox',
        4, 9,
        'Selected: "quick" (offsets 4..9)',
        _crBurgundy,
      ),

      // Scenario 2: Full text selected
      _crSubheading('Scenario B: Full Text Selected'),
      _crRangeVisualization(
        'The quick brown fox',
        0, 19,
        'Selected: entire text (offsets 0..19)',
        _crWine,
      ),

      // Scenario 3: Collapsed cursor (empty selection)
      _crSubheading('Scenario C: Collapsed Cursor'),
      _crRangeVisualization(
        'The quick brown fox',
        10, 10,
        'Collapsed: cursor at offset 10 (no text selected)',
        _crTeal,
      ),

      // Scenario 4: Partial word
      _crSubheading('Scenario D: Partial Word'),
      _crRangeVisualization(
        'The quick brown fox',
        6, 14,
        'Selected: "ick brow" — selection can cross word boundaries',
        _crLavender,
      ),

      // Scenario 5: Single character
      _crSubheading('Scenario E: Single Character'),
      _crRangeVisualization(
        'The quick brown fox',
        3, 4,
        'Selected: " " (space) — even single characters have ranges',
        _crGold,
      ),

      _crInfoCard(
        'Notice that a collapsed selection (start == end) means the '
        'cursor is positioned but no text is actually highlighted.  '
        'This is how the selection system represents the blinking '
        'cursor state between characters.',
        icon: Icons.text_rotation_none,
      ),
    ],
  );
}

Widget _crRangeVisualization(
  String text,
  int start,
  int end,
  String description,
  Color highlightColor,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _crIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: highlightColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Character boxes
        Wrap(
          spacing: 1,
          runSpacing: 4,
          children: [
            for (int i = 0; i < text.length; i++)
              Container(
                width: 20,
                height: 28,
                decoration: BoxDecoration(
                  color: (i >= start && i < end)
                      ? highlightColor.withValues(alpha: 0.25)
                      : Colors.white,
                  border: Border.all(
                    color: (i >= start && i < end)
                        ? highlightColor
                        : _crBlush.withValues(alpha: 0.5),
                    width: (i >= start && i < end) ? 1.5 : 0.5,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    text[i],
                    style: TextStyle(
                      color: (i >= start && i < end)
                          ? highlightColor
                          : _crCharcoal,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: (i >= start && i < end)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _crBadge('start: $start', highlightColor),
            const SizedBox(width: 6),
            _crBadge('end: $end', highlightColor.withValues(alpha: 0.7)),
            const SizedBox(width: 6),
            _crBadge('len: ${end - start}', _crCharcoal),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: highlightColor,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — How It Connects to the Selection System
// ---------------------------------------------------------------------------
Widget _crBuildSystemConnection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '4. Role in the Selection System',
        subtitle: 'How SelectedContentRange connects to SelectionArea',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'SelectedContentRange fits into Flutter\'s selection pipeline '
        'at the point where a Selectable determines WHAT is selected.  '
        'Here is the flow:',
        icon: Icons.account_tree,
      ),

      // Visual: Pipeline diagram
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _crIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crBurgundy, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Selection Pipeline',
              style: TextStyle(
                color: _crDarkBurgundy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            _crPipelineStep('1', 'User drags finger/mouse', Icons.touch_app, _crWine),
            _crPipelineArrow(),
            _crPipelineStep('2', 'SelectableRegion creates\nSelectionEdgeUpdateEvent', Icons.gesture, _crBurgundy),
            _crPipelineArrow(),
            _crPipelineStep('3', 'Selectable.dispatchSelectionEvent()\ncomputes the affected offsets', Icons.calculate, _crTeal),
            _crPipelineArrow(),
            _crPipelineStep('4', 'SelectedContentRange created\nwith start/end offsets', Icons.highlight, _crGold),
            _crPipelineArrow(),
            _crPipelineStep('5', 'SelectionGeometry updated\nwith handle positions', Icons.crop_square, _crLavender),
            _crPipelineArrow(),
            _crPipelineStep('6', 'Overlay draws highlight\nand drag handles', Icons.brush, _crBurgundy),
          ],
        ),
      ),

      _crInfoCard(
        'Step 4 is where SelectedContentRange lives — it is the result '
        'of the Selectable figuring out which character offsets correspond '
        'to the user\'s gesture position.  This range then drives both '
        'the visual highlighting and the actual text extraction for copy.',
      ),

      _crSubheading('Copy Operation'),
      _crInfoCard(
        'When the user taps "Copy", the system asks each selected '
        'Selectable for its SelectedContent (which includes the text).  '
        'The SelectedContentRange determines exactly which substring '
        'to extract.\n\n'
        'SelectedContent.plainText = originalText.substring(\n'
        '  range.startOffset, range.endOffset\n'
        ')',
        icon: Icons.content_copy,
      ),
    ],
  );
}

Widget _crPipelineStep(String number, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          desc,
          style: const TextStyle(
            color: _crCharcoal,
            fontSize: 12,
            height: 1.3,
          ),
        ),
      ),
    ],
  );
}

Widget _crPipelineArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 14),
    child: Icon(Icons.arrow_downward, color: _crBlush, size: 18),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Real Selection Demo
// ---------------------------------------------------------------------------
Widget _crBuildSelectionDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '5. Live Selection Demo',
        subtitle: 'Interactive SelectionArea showing ranges in action',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'Below is a SelectionArea wrapping real text content.  When '
        'you select text, Flutter internally creates SelectedContentRange '
        'objects for each Selectable that participates in the selection.',
        icon: Icons.select_all,
      ),

      // Demo: Selectable article
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crBurgundy, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: _crBurgundy,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.highlight, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Select text to see ranges in action',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  _crBadge('selectable', _crTeal),
                ],
              ),
            ),
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Understanding Content Ranges',
                      style: TextStyle(
                        color: _crDarkBurgundy,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'When you select this paragraph, Flutter determines which '
                      'characters fall within the drag region.  For each Text '
                      'widget, a SelectedContentRange is created with the precise '
                      'startOffset and endOffset.',
                      style: TextStyle(
                        color: _crCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _crBurgundy.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: _crBurgundy, width: 3),
                        ),
                      ),
                      child: const Text(
                        'If your selection spans multiple Text widgets, each one '
                        'independently computes its own SelectedContentRange.  '
                        'The SelectableRegion then merges the extracted text from '
                        'all participating selectables.',
                        style: TextStyle(
                          color: _crWine,
                          fontSize: 13,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Try selecting across both paragraphs above.  Two separate '
                      'SelectedContentRange objects are created — one per Text '
                      'widget — and the combined text forms your clipboard content.',
                      style: TextStyle(
                        color: _crCharcoal,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Multi-Widget Range Visualization
// ---------------------------------------------------------------------------
Widget _crBuildMultiWidgetRange() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '6. Multi-Widget Selection',
        subtitle: 'How ranges work across multiple Selectables',
      ),
      const SizedBox(height: 12),
      _crInfoCard(
        'When a selection spans multiple Text widgets, each gets its own '
        'SelectedContentRange.  The first widget gets a range from the '
        'selection start to its end, and the last widget gets a range '
        'from its beginning to the selection end.',
      ),

      // Visual: Three text blocks with partial selection
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _crIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crBurgundy, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cross-Widget Selection',
              style: TextStyle(
                color: _crDarkBurgundy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // Widget A: partially selected at end
            _crMultiRangeBlock(
              'Widget A',
              'Hello, Flutter world!',
              14, 21, // "world!" selected
              _crBurgundy,
              'range: 14..21 (partial end)',
            ),
            const SizedBox(height: 8),

            // Widget B: fully selected
            _crMultiRangeBlock(
              'Widget B',
              'This entire text is selected.',
              0, 29,
              _crWine,
              'range: 0..29 (fully selected)',
            ),
            const SizedBox(height: 8),

            // Widget C: partially selected at start
            _crMultiRangeBlock(
              'Widget C',
              'Only the beginning here.',
              0, 8, // "Only the" selected
              _crTeal,
              'range: 0..8 (partial start)',
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _crLightBlush,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Combined clipboard text:\n'
                '"world!\\nThis entire text is selected.\\nOnly the"',
                style: TextStyle(
                  color: _crCharcoal,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
      _crInfoCard(
        'The SelectableRegion joins the text from each Selectable\'s '
        'SelectedContentRange, inserting newlines between widgets.  '
        'This produces the final clipboard string.',
        icon: Icons.join_full,
      ),
    ],
  );
}

Widget _crMultiRangeBlock(
  String widgetLabel,
  String text,
  int start,
  int end,
  Color color,
  String rangeDesc,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _crBadge(widgetLabel, color),
            const SizedBox(width: 8),
            Text(
              rangeDesc,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 1,
          children: [
            for (int i = 0; i < text.length; i++)
              Container(
                width: 16,
                height: 22,
                decoration: BoxDecoration(
                  color: (i >= start && i < end)
                      ? color.withValues(alpha: 0.2)
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: (i >= start && i < end) ? color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    text[i],
                    style: TextStyle(
                      color: (i >= start && i < end) ? color : _crCharcoal,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: (i >= start && i < end)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Comparison with Related Types
// ---------------------------------------------------------------------------
Widget _crBuildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '7. Related Types Comparison',
        subtitle: 'How SelectedContentRange relates to other selection classes',
      ),
      const SizedBox(height: 12),

      // Comparison table
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _crBurgundy),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _crBurgundy,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Contains', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Purpose', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            _crCompRow('SelectedContentRange', 'start, end offsets', 'Which chars are selected', false),
            _crCompRow('SelectedContent', 'plain text string', 'The actual selected text', true),
            _crCompRow('SelectionGeometry', 'handle positions', 'Where to draw handles', false),
            _crCompRow('SelectionPoint', 'offset + direction', 'One handle\'s location', true),
            _crCompRow('TextSelection', 'base + extent', 'TextField selection range', false),
          ],
        ),
      ),

      _crSubheading('SelectedContentRange vs TextSelection'),
      _crInfoCard(
        'TextSelection (from dart:ui) has base/extent offsets and is used '
        'by TextField and EditableText.  SelectedContentRange is the '
        'rendering-layer equivalent used by the SelectionArea system.\n\n'
        'Key difference: TextSelection has an "affinity" (upstream/downstream) '
        'and an "isDirectional" flag.  SelectedContentRange is simpler — '
        'just start and end, always normalized (start ≤ end).',
        icon: Icons.compare_arrows,
      ),

      // Visual: Side-by-side comparison
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _crLightBlush,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _crBurgundy),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SelectedContentRange',
                      style: TextStyle(
                        color: _crBurgundy,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _crFieldItem('startOffset', 'int'),
                    _crFieldItem('endOffset', 'int'),
                    const SizedBox(height: 6),
                    const Text(
                      'Simple, normalized',
                      style: TextStyle(color: _crWine, fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _crIvory,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _crTeal),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TextSelection',
                      style: TextStyle(
                        color: _crTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _crFieldItem('baseOffset', 'int'),
                    _crFieldItem('extentOffset', 'int'),
                    _crFieldItem('affinity', 'TextAffinity'),
                    _crFieldItem('isDirectional', 'bool'),
                    const SizedBox(height: 6),
                    const Text(
                      'Rich, directional',
                      style: TextStyle(color: _crTeal, fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _crCompRow(String type, String contains, String purpose, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _crLightBlush.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(type, style: const TextStyle(color: _crDarkBurgundy, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)),
        ),
        Expanded(
          flex: 2,
          child: Text(contains, style: const TextStyle(color: _crCharcoal, fontSize: 11)),
        ),
        Expanded(
          flex: 3,
          child: Text(purpose, style: const TextStyle(color: _crCharcoal, fontSize: 11)),
        ),
      ],
    ),
  );
}

Widget _crFieldItem(String name, String type) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: _crCharcoal,
          ),
        ),
        const Spacer(),
        Text(
          type,
          style: const TextStyle(
            fontSize: 10,
            color: _crWine,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Use Case Gallery
// ---------------------------------------------------------------------------
Widget _crBuildUseCases() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '8. Use Cases & Patterns',
        subtitle: 'Real-world scenarios involving content ranges',
      ),
      const SizedBox(height: 12),

      // Use case 1: Document viewer
      _crSubheading('Use Case 1: Document Viewer'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crWine),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _crWine,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.description, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Document Viewer',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chapter 1: The Selection System',
                      style: TextStyle(
                        color: _crDarkBurgundy,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Flutter introduced SelectionArea in version 3.3, enabling '
                      'native-like text selection across widget boundaries.  The '
                      'SelectedContentRange class tracks which portion of each '
                      'Text widget\'s content falls within the user\'s selection.',
                      style: TextStyle(
                        color: _crCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'In a document viewer, each paragraph is a separate '
                      'Selectable with its own SelectedContentRange.  The system '
                      'merges them to produce the final clipboard content.',
                      style: TextStyle(
                        color: _crCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Use case 2: Code block with line numbers
      _crSubheading('Use Case 2: Selectable Code Block'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crCharcoal),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _crCharcoal,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code, color: _crBlush, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'selectable_code.dart',
                    style: TextStyle(color: _crBlush, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _crBadge('Copy', _crTeal),
                ],
              ),
            ),
            SelectionArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                color: const Color(0xFF1E1E2E),
                child: const Text(
                  'final range = SelectedContentRange(\n'
                  '  startOffset: 0,\n'
                  '  endOffset: 42,\n'
                  ');\n'
                  '\n'
                  'final selected = text.substring(\n'
                  '  range.startOffset,\n'
                  '  range.endOffset,\n'
                  ');',
                  style: TextStyle(
                    color: _crBlush,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Use case 3: Chat with selectable messages
      _crSubheading('Use Case 3: Chat Messages'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _crIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _crBlush),
        ),
        child: SelectionArea(
          child: Column(
            children: [
              _crChatMessage('User', 'What is SelectedContentRange?', true),
              _crChatMessage(
                'Assistant',
                'It\'s a data class with startOffset and endOffset integers '
                'that represents which characters are selected within a Selectable.',
                false,
              ),
              _crChatMessage('User', 'How does it relate to the clipboard?', true),
              _crChatMessage(
                'Assistant',
                'When you copy, the system extracts text using '
                'text.substring(range.startOffset, range.endOffset) '
                'from each participating Selectable.',
                false,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _crChatMessage(String sender, String text, bool isUser) {
  return Padding(
    padding: EdgeInsets.only(
      left: isUser ? 0 : 32,
      right: isUser ? 32 : 0,
      bottom: 8,
    ),
    child: Column(
      crossAxisAlignment: isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          sender,
          style: TextStyle(
            color: isUser ? _crBurgundy : _crTeal,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isUser ? _crLightBlush : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUser ? _crBurgundy.withValues(alpha: 0.3) : _crTeal.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: _crCharcoal,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Summary
// ---------------------------------------------------------------------------
Widget _crBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _crSectionHeader(
        '9. Summary',
        subtitle: 'Key takeaways about SelectedContentRange',
      ),
      const SizedBox(height: 12),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_crBurgundy, _crDarkBurgundy],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _crGold, size: 20),
                SizedBox(width: 8),
                Text(
                  'SelectedContentRange — Key Takeaways',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _crSummaryItem('Simple structure', 'Just startOffset and endOffset — two integers'),
            _crSummaryItem('Inclusive/exclusive', 'Start is inclusive, end is exclusive (like substring)'),
            _crSummaryItem('Per-Selectable', 'Each Selectable in a cross-widget selection gets its own range'),
            _crSummaryItem('Drives clipboard', 'The range determines which text goes to the clipboard'),
            _crSummaryItem('Part of pipeline', 'Created after dispatchSelectionEvent, before geometry update'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _crSummaryItem(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(color: _crGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(color: _crBlush, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                TextSpan(
                  text: desc,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Main build function
// ============================================================================
dynamic build(BuildContext context) {
  print('--- SelectedContentRange Deep Demo ---');
  print('Demonstrates the SelectedContentRange data class from');
  print('Flutter\'s rendering-layer selection system.');
  print('');
  print('Sections:');
  print('  1. What Is SelectedContentRange?');
  print('  2. Fields and Properties');
  print('  3. Range Scenarios');
  print('  4. Role in the Selection System');
  print('  5. Live Selection Demo');
  print('  6. Multi-Widget Selection');
  print('  7. Related Types Comparison');
  print('  8. Use Cases & Patterns');
  print('  9. Summary');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _crBurgundy,
      scaffoldBackgroundColor: _crIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _crDarkBurgundy,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectedContentRange — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _crBlush.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.highlight, size: 14),
                SizedBox(width: 4),
                Text('Rendering', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _crBuildOverview(),
            _crDivider(),
            _crBuildFields(),
            _crDivider(),
            _crBuildRangeScenarios(),
            _crDivider(),
            _crBuildSystemConnection(),
            _crDivider(),
            _crBuildSelectionDemo(),
            _crDivider(),
            _crBuildMultiWidgetRange(),
            _crDivider(),
            _crBuildComparison(),
            _crDivider(),
            _crBuildUseCases(),
            _crDivider(),
            _crBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
