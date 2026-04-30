// ignore_for_file: avoid_print, unused_element
import 'package:flutter/material.dart';

// ============================================================================
// SELECTED CONTENT — Deep Demo
// ============================================================================
//
// SelectedContent is a data class in Flutter's rendering-layer
// selection system that holds the actual textual content that has
// been selected by the user within a Selectable widget.
//
// It carries:
//   • plainText — a String containing the selected text
//
// SelectedContent is the OUTPUT of the selection process.  When
// the user performs a copy action, each participating Selectable
// returns a SelectedContent instance containing the text that
// corresponds to its SelectedContentRange.
//
// The SelectableRegion then concatenates SelectedContent from all
// participating Selectables and places the combined string on
// the system clipboard.
//
// Color theme : Teal (#008080) / Aqua (#00CED1)
// Helper prefix: _sc
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _scTeal = Color(0xFF008080);
const Color _scAqua = Color(0xFF00CED1);
const Color _scDarkTeal = Color(0xFF005F5F);
const Color _scLightAqua = Color(0xFFE0FAFA);
const Color _scSeaGreen = Color(0xFF2E8B57);
const Color _scIvory = Color(0xFFFAFFF8);
const Color _scCharcoal = Color(0xFF2E3338);
const Color _scCoral = Color(0xFFFF6B6B);
const Color _scGold = Color(0xFFD4A017);
const Color _scPlum = Color(0xFF8E4585);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _scSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_scTeal, _scDarkTeal],
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

Widget _scInfoCard(String text, {IconData icon = Icons.info_outline}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _scLightAqua,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _scAqua, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _scTeal, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _scCharcoal,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _scCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _scCharcoal,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _scAqua,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.6,
      ),
    ),
  );
}

Widget _scDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: _scAqua.withValues(alpha: 0.4),
  );
}

Widget _scBadge(String label, Color bgColor, {Color textColor = Colors.white}) {
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

Widget _scSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _scTeal,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _scKeyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            key,
            style: const TextStyle(
              color: _scDarkTeal,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _scCharcoal,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Overview: What Is SelectedContent?
// ---------------------------------------------------------------------------
Widget _scBuildOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '1. What Is SelectedContent?',
        subtitle: 'The output of text selection — the actual selected string',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'SelectedContent is a simple data class that holds the text '
        'a user has selected within a Selectable widget.  It represents '
        'the END PRODUCT of the selection process — the string that '
        'will ultimately go to the clipboard.',
      ),
      _scCodeBlock(
        'class SelectedContent {\n'
        '  const SelectedContent({\n'
        '    required this.plainText,\n'
        '  });\n'
        '\n'
        '  final String plainText;\n'
        '}',
      ),
      _scInfoCard(
        'While SelectedContentRange tells the system WHICH offsets are '
        'selected, SelectedContent provides the actual text string.  '
        'Together they form the complete picture:\n\n'
        '  Range: "what to extract"\n'
        '  Content: "the extracted result"',
        icon: Icons.text_snippet,
      ),

      // Visual: Selection flow
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _scIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'From Range to Content',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // Source text
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _scAqua),
              ),
              child: const Column(
                children: [
                  Text('Source Text:', style: TextStyle(color: _scTeal, fontWeight: FontWeight.bold, fontSize: 11)),
                  SizedBox(height: 4),
                  Text(
                    '"Flutter makes building beautiful apps easy"',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: _scCharcoal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.arrow_downward, color: _scTeal, size: 20),
            const SizedBox(height: 8),
            // Range
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _scLightAqua,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _scTeal),
              ),
              child: const Column(
                children: [
                  Text('SelectedContentRange:', style: TextStyle(color: _scDarkTeal, fontWeight: FontWeight.bold, fontSize: 11)),
                  SizedBox(height: 4),
                  Text(
                    'startOffset: 16,  endOffset: 25',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: _scCharcoal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.arrow_downward, color: _scTeal, size: 20),
            const SizedBox(height: 8),
            // "Selected Content"
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _scTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Text('SelectedContent:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                  SizedBox(height: 4),
                  Text(
                    'plainText: "beautiful"',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: _scAqua),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2 — The plainText Field
// ---------------------------------------------------------------------------
Widget _scBuildPlainText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '2. The plainText Field',
        subtitle: 'A single String that carries the selected text',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'SelectedContent has exactly ONE field:\n\n'
        '  String plainText\n\n'
        'This field holds the raw text content without any formatting, '
        'styling, or rich-text decoration.  Regardless of how the text '
        'is styled in the UI (bold, italic, colored), the SelectedContent '
        'only stores the plain characters.',
      ),

      _scSubheading('Plain Text Extraction'),
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _scIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Styled Source',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            // Rich styled text
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Bold ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _scTeal),
                  ),
                  TextSpan(
                    text: 'italic ',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: _scSeaGreen),
                  ),
                  TextSpan(
                    text: 'colored ',
                    style: TextStyle(fontSize: 14, color: _scCoral),
                  ),
                  TextSpan(
                    text: 'underlined',
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 14, color: _scPlum),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: _scAqua.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            const Text(
              'SelectedContent Result',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _scCharcoal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'plainText: "Bold italic colored underlined"',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _scAqua,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _scBadge('All styling stripped', _scTeal),
          ],
        ),
      ),

      _scInfoCard(
        'This is intentional — the clipboard on most platforms works '
        'with plain text.  Rich text copying (with formatting) is a '
        'separate concern handled at a higher level.',
        icon: Icons.content_paste,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — How SelectedContent Is Created
// ---------------------------------------------------------------------------
Widget _scBuildCreation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '3. How SelectedContent Is Created',
        subtitle: 'The lifecycle from selection gesture to text extraction',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'SelectedContent is created by each Selectable when the system '
        'invokes getSelectedContent().  This happens when:\n\n'
        '• The user taps "Copy" in the context menu\n'
        '• The user presses Ctrl+C / Cmd+C\n'
        '• Code programmatically requests the selected content',
        icon: Icons.build_circle,
      ),

      // Creation flow
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _scIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Content Creation Pipeline',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            _scCreationStep(
              '1',
              'User Action',
              'User taps Copy or presses Ctrl+C',
              Icons.touch_app,
              _scCoral,
            ),
            _scArrow(),
            _scCreationStep(
              '2',
              'SelectableRegion',
              'Iterates all registered Selectables\nthat are in selected state',
              Icons.list_alt,
              _scTeal,
            ),
            _scArrow(),
            _scCreationStep(
              '3',
              'getSelectedContent()',
              'Each Selectable extracts its text\nusing its SelectedContentRange',
              Icons.text_fields,
              _scSeaGreen,
            ),
            _scArrow(),
            _scCreationStep(
              '4',
              'SelectedContent created',
              'plainText = fullText.substring(\n  range.startOffset, range.endOffset)',
              Icons.check_circle,
              _scGold,
            ),
            _scArrow(),
            _scCreationStep(
              '5',
              'Content merged',
              'All SelectedContent.plainText values\njoined with newlines → clipboard',
              Icons.merge_type,
              _scPlum,
            ),
          ],
        ),
      ),

      _scCodeBlock(
        '// Inside a Selectable implementation:\n'
        'SelectedContent? getSelectedContent() {\n'
        '  if (_range == null) return null;\n'
        '  final text = _fullText.substring(\n'
        '    _range!.startOffset,\n'
        '    _range!.endOffset,\n'
        '  );\n'
        '  return SelectedContent(plainText: text);\n'
        '}',
      ),

      _scInfoCard(
        'If a Selectable has no selection (no range), getSelectedContent() '
        'returns null.  This tells the system to skip this widget when '
        'building the clipboard string.',
        icon: Icons.not_interested,
      ),
    ],
  );
}

Widget _scCreationStep(String number, String title, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ),
      const SizedBox(width: 10),
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            Text(desc, style: const TextStyle(color: _scCharcoal, fontSize: 11, height: 1.3)),
          ],
        ),
      ),
    ],
  );
}

Widget _scArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 13),
    child: Icon(Icons.arrow_downward, color: _scAqua, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Multi-Selectable Content Merging
// ---------------------------------------------------------------------------
Widget _scBuildMerging() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '4. Multi-Selectable Merging',
        subtitle: 'How text from multiple widgets becomes one clipboard string',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'When a selection spans multiple Text widgets, each returns '
        'its own SelectedContent.  The SelectableRegion merges them '
        'by joining the plainText values with newline characters.',
      ),

      // Visual: Merging demo
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _scIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Content Merging Visualization',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // Three widget blocks
            _scMergeBlock('Heading Text Widget', 'SelectedContent( plainText: "Introduction" )', _scTeal),
            const SizedBox(height: 6),
            Center(child: _scBadge('+ "\\n"', _scGold)),
            const SizedBox(height: 6),
            _scMergeBlock('Paragraph Text Widget', 'SelectedContent( plainText: "Flutter is great" )', _scSeaGreen),
            const SizedBox(height: 6),
            Center(child: _scBadge('+ "\\n"', _scGold)),
            const SizedBox(height: 6),
            _scMergeBlock('Caption Text Widget', 'SelectedContent( plainText: "Figure 1" )', _scPlum),

            const SizedBox(height: 12),
            const Icon(Icons.arrow_downward, color: _scTeal, size: 20),
            const SizedBox(height: 8),

            // Result
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _scTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Final Clipboard Content',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _scDarkTeal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Introduction\\nFlutter is great\\nFigure 1',
                      style: TextStyle(
                        color: _scAqua,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      _scInfoCard(
        'The merging process respects widget order in the widget tree.  '
        'Widgets that appear higher in the tree (earlier in the layout) '
        'contribute their text first.  This ensures the clipboard text '
        'reads in the same order as the on-screen content.',
        icon: Icons.sort,
      ),
    ],
  );
}

Widget _scMergeBlock(String label, String content, Color color) {
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
        _scBadge(label, color),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            color: _scCharcoal,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — Live Selection Demos
// ---------------------------------------------------------------------------
Widget _scBuildLiveDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '5. Live Selection Demos',
        subtitle: 'Select text to see SelectedContent in action',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'Each demo below wraps content in a SelectionArea.  When you '
        'select text and copy, the system creates SelectedContent '
        'objects internally.  Try selecting across widget boundaries!',
        icon: Icons.select_all,
      ),

      // Demo A: Article
      _scSubheading('Demo A: Article Layout'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: _scTeal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.article, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Select across paragraphs',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _scBadge('3 widgets', _scSeaGreen),
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
                      'Understanding Text Selection',
                      style: TextStyle(
                        color: _scDarkTeal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Flutter\'s selection system works across multiple Text widgets.  '
                      'Each widget independently tracks which portion of its text '
                      'falls within the user\'s selection drag region.',
                      style: TextStyle(
                        color: _scCharcoal.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'When you copy, each widget creates a SelectedContent with '
                      'its portion of the selected text.  The system combines them '
                      'to produce the final clipboard string you see when pasting.',
                      style: TextStyle(
                        color: _scCharcoal.withValues(alpha: 0.9),
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

      // Demo B: Mixed content
      _scSubheading('Demo B: Mixed Content Types'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scSeaGreen, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: _scSeaGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.list, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Headers, bullets, and body text',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _scBadge('mixed', _scGold),
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
                      'Key Features',
                      style: TextStyle(
                        color: _scDarkTeal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._scBulletPoints([
                      'Cross-widget selection spans multiple Text widgets',
                      'Automatic newline insertion between widgets',
                      'Plain text extraction strips all styling',
                      'Null return when a widget has no selection',
                    ]),
                    const SizedBox(height: 10),
                    const Text(
                      'Each bullet above is a separate Text widget with its own '
                      'SelectedContent when copied.',
                      style: TextStyle(
                        color: _scCharcoal,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Demo C: Code snippet
      _scSubheading('Demo C: Selectable Code'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scCharcoal, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _scCharcoal,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code, color: _scAqua, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Copy code snippets',
                    style: TextStyle(color: _scAqua, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const Spacer(),
                  _scBadge('code', _scTeal),
                ],
              ),
            ),
            SelectionArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                color: const Color(0xFF1E1E2E),
                child: const Text(
                  '// Getting selected content from a Selectable\n'
                  'final selected = selectable.getSelectedContent();\n'
                  'if (selected != null) {\n'
                  '  print(selected.plainText);\n'
                  '  Clipboard.setData(\n'
                  '    ClipboardData(text: selected.plainText),\n'
                  '  );\n'
                  '}',
                  style: TextStyle(
                    color: _scAqua,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

List<Widget> _scBulletPoints(List<String> items) {
  return items.map((item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
              color: _scTeal,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              item,
              style: const TextStyle(color: _scCharcoal, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ---------------------------------------------------------------------------
// Section 6 — Null vs Empty Content
// ---------------------------------------------------------------------------
Widget _scBuildNullVsEmpty() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '6. Null vs Empty Content',
        subtitle: 'Understanding when getSelectedContent returns null',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'getSelectedContent() can return three different results:\n\n'
        '• SelectedContent with text — widget has selected text\n'
        '• SelectedContent with "" — selection exists but covers nothing\n'
        '• null — widget is not part of the selection at all',
        icon: Icons.help_outline,
      ),

      // Visual: Three states
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _scIvory,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          children: [
            const Text(
              'Three Return States',
              style: TextStyle(
                color: _scDarkTeal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // State 1: Has content
            _scReturnStateCard(
              'Has Content',
              'SelectedContent(plainText: "Hello")',
              'Widget has selected text — this contributes to clipboard',
              _scSeaGreen,
              Icons.check_circle,
            ),
            const SizedBox(height: 8),

            // State 2: Empty string
            _scReturnStateCard(
              'Empty String',
              'SelectedContent(plainText: "")',
              'Selection exists but range is collapsed (start == end)',
              _scGold,
              Icons.circle_outlined,
            ),
            const SizedBox(height: 8),

            // State 3: Null
            _scReturnStateCard(
              'Null Return',
              'null',
              'Widget is outside the selection — completely skipped',
              _scCoral,
              Icons.cancel,
            ),
          ],
        ),
      ),

      _scCodeBlock(
        'SelectedContent? getSelectedContent() {\n'
        '  // No selection at all\n'
        '  if (_range == null) return null;\n'
        '\n'
        '  // Has selection (could be empty or not)\n'
        '  return SelectedContent(\n'
        '    plainText: _text.substring(\n'
        '      _range!.startOffset,\n'
        '      _range!.endOffset,\n'
        '    ),\n'
        '  );\n'
        '}',
      ),
    ],
  );
}

Widget _scReturnStateCard(
  String title,
  String code,
  String explanation,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _scCharcoal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                explanation,
                style: TextStyle(
                  color: _scCharcoal.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — onSelectionChanged Callback
// ---------------------------------------------------------------------------
Widget _scBuildCallback() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '7. onSelectionChanged Callback',
        subtitle: 'Reacting to changes in SelectedContent',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'SelectionArea provides an onSelectionChanged callback that '
        'fires whenever the selection changes.  This callback receives '
        'a SelectedContent? parameter — the current combined content '
        'from all participating Selectables.',
        icon: Icons.notifications_active,
      ),

      _scCodeBlock(
        'SelectionArea(\n'
        '  onSelectionChanged: (SelectedContent? content) {\n'
        '    if (content != null) {\n'
        // ignore: unnecessary_string_escapes
        '      print("Selected: \${content.plainText}");\n'
        '    } else {\n'
        '      print("Selection cleared");\n'
        '    }\n'
        '  },\n'
        '  child: Column(\n'
        '    children: [\n'
        '      Text("Paragraph one..."),\n'
        '      Text("Paragraph two..."),\n'
        '    ],\n'
        '  ),\n'
        ')',
      ),

      _scSubheading('Callback Scenarios'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _scTeal),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _scTeal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Callback Receives', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            _scCallbackRow('User starts dragging', 'SelectedContent(plainText: "...")', false),
            _scCallbackRow('User extends selection', 'SelectedContent(plainText: "... more")', true),
            _scCallbackRow('User lifts finger', 'SelectedContent (final text)', false),
            _scCallbackRow('User taps elsewhere', 'null (selection cleared)', true),
          ],
        ),
      ),

      _scInfoCard(
        'The callback fires during the drag — not just at the end.  '
        'This means you can build UIs that react in real-time as the '
        'user adjusts their selection (e.g. showing a character count '
        'or preview of the selected text).',
        icon: Icons.speed,
      ),

      // Live demo with SelectionArea
      _scSubheading('Live Callback Demo'),
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _scTeal, width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: _scTeal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.touch_app, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'SelectionArea with onSelectionChanged',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
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
                      'The onSelectionChanged callback provides real-time updates as '
                      'you select text.  Each update delivers a new SelectedContent '
                      'object reflecting the current selection state.',
                      style: TextStyle(color: _scCharcoal, fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'In a production app, you might use this callback to show a '
                      'floating toolbar, update a word count, or enable/disable '
                      'formatting buttons.',
                      style: TextStyle(color: _scCharcoal, fontSize: 13, height: 1.6),
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

Widget _scCallbackRow(String action, String receives, bool isAlt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: isAlt ? _scLightAqua.withValues(alpha: 0.5) : Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(action, style: const TextStyle(color: _scDarkTeal, fontWeight: FontWeight.w600, fontSize: 11)),
        ),
        Expanded(
          flex: 3,
          child: Text(receives, style: const TextStyle(color: _scCharcoal, fontFamily: 'monospace', fontSize: 10)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — SelectedContent vs Clipboard
// ---------------------------------------------------------------------------
Widget _scBuildVsClipboard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '8. SelectedContent vs ClipboardData',
        subtitle: 'Two different representations of "copied text"',
      ),
      const SizedBox(height: 12),
      _scInfoCard(
        'SelectedContent and ClipboardData might seem similar — both '
        'hold text strings.  But they serve different purposes in the '
        'pipeline and have distinct characteristics.',
      ),

      // Side-by-side comparison
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _scLightAqua,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _scTeal, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SelectedContent',
                      style: TextStyle(
                        color: _scTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _scCompareItem('Scope', 'Per-Selectable'),
                    _scCompareItem('When', 'During selection'),
                    _scCompareItem('Field', 'plainText'),
                    _scCompareItem('Source', 'Widget tree'),
                    _scCompareItem('Multiple', 'One per widget'),
                    const SizedBox(height: 6),
                    _scBadge('Internal', _scTeal),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _scIvory,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _scPlum, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ClipboardData',
                      style: TextStyle(
                        color: _scPlum,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _scCompareItem('Scope', 'System-wide'),
                    _scCompareItem('When', 'On copy action'),
                    _scCompareItem('Field', 'text'),
                    _scCompareItem('Source', 'OS clipboard'),
                    _scCompareItem('Multiple', 'One combined'),
                    const SizedBox(height: 6),
                    _scBadge('Platform', _scPlum),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      _scCodeBlock(
        '// SelectedContent → ClipboardData pipeline:\n'
        'final contents = selectables\n'
        '    .map((s) => s.getSelectedContent())\n'
        '    .whereType<SelectedContent>()\n'
        '    .map((c) => c.plainText)\n'
        '    .join("\\n");\n'
        '\n'
        'Clipboard.setData(ClipboardData(text: contents));',
      ),
    ],
  );
}

Widget _scCompareItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            color: _scCharcoal,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: _scCharcoal,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Pattern Gallery
// ---------------------------------------------------------------------------
Widget _scBuildPatterns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '9. Pattern Gallery',
        subtitle: 'Common patterns involving SelectedContent',
      ),
      const SizedBox(height: 12),

      // Pattern 1: Selection preview
      _scSubheading('Pattern 1: Selection Preview'),
      _scInfoCard(
        'Show a live preview of the selected text as the user drags.',
        icon: Icons.preview,
      ),
      _scCodeBlock(
        'SelectionArea(\n'
        '  onSelectionChanged: (content) {\n'
        '    setState(() {\n'
        '      _preview = content?.plainText ?? "";\n'
        '      _charCount = _preview.length;\n'
        '    });\n'
        '  },\n'
        '  child: _buildArticle(),\n'
        ')',
      ),

      // Pattern 2: Custom copy behavior
      _scSubheading('Pattern 2: Custom Copy Action'),
      _scInfoCard(
        'Override the default copy behavior to add attribution '
        'or formatting to the copied text.',
        icon: Icons.content_copy,
      ),
      _scCodeBlock(
        '// Intercept the copy action:\n'
        'void handleCopy(SelectedContent? content) {\n'
        '  if (content == null) return;\n'
        '  final attributed = "\${content.plainText}\\n"\n'
        '      "— Copied from MyApp";\n'
        '  Clipboard.setData(\n'
        '    ClipboardData(text: attributed),\n'
        '  );\n'
        '}',
      ),

      // Pattern 3: Selection analytics
      _scSubheading('Pattern 3: Selection Analytics'),
      _scInfoCard(
        'Track which content users select most often to improve UX.',
        icon: Icons.analytics,
      ),
      _scCodeBlock(
        'SelectionArea(\n'
        '  onSelectionChanged: (content) {\n'
        '    if (content != null &&\n'
        '        content.plainText.length > 3) {\n'
        '      analytics.track(\n'
        '        "text_selected",\n'
        '        {"length": content.plainText.length},\n'
        '      );\n'
        '    }\n'
        '  },\n'
        '  child: _buildContent(),\n'
        ')',
      ),

      // Pattern 4: Conditional selection
      _scSubheading('Pattern 4: Restriction Patterns'),
      _scInfoCard(
        'Prevent selection of certain content by conditionally '
        'returning null from getSelectedContent().',
        icon: Icons.block,
      ),
      _scCodeBlock(
        'SelectedContent? getSelectedContent() {\n'
        '  if (!_allowCopy) return null;\n'
        '  if (_range == null) return null;\n'
        '  final text = _fullText.substring(\n'
        '    _range!.startOffset,\n'
        '    _range!.endOffset,\n'
        '  );\n'
        '  // Redact sensitive portions\n'
        '  return SelectedContent(\n'
        '    plainText: _redact(text),\n'
        '  );\n'
        '}',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Summary
// ---------------------------------------------------------------------------
Widget _scBuildSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionHeader(
        '10. Summary',
        subtitle: 'Key takeaways about SelectedContent',
      ),
      const SizedBox(height: 12),

      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_scTeal, _scDarkTeal],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: _scGold, size: 20),
                SizedBox(width: 8),
                Text(
                  'SelectedContent — Key Takeaways',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _scSummaryBullet('Single field', 'Just plainText — the actual selected string'),
            _scSummaryBullet('Plain text only', 'All styling and formatting is stripped'),
            _scSummaryBullet('Per-Selectable', 'Each widget produces its own SelectedContent'),
            _scSummaryBullet('Merged for clipboard', 'All SelectedContent values joined with newlines'),
            _scSummaryBullet('Nullable', 'Null means the widget has no selection'),
            _scSummaryBullet('Callback-friendly', 'onSelectionChanged delivers SelectedContent in real-time'),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget _scSummaryBullet(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6, height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(color: _scGold, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title — ',
                  style: const TextStyle(color: _scAqua, fontWeight: FontWeight.bold, fontSize: 12),
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
  print('--- SelectedContent Deep Demo ---');
  print('Demonstrates the SelectedContent data class from');
  print('Flutter\'s rendering-layer selection system.');
  print('');
  print('Sections:');
  print('  1. What Is SelectedContent?');
  print('  2. The plainText Field');
  print('  3. How SelectedContent Is Created');
  print('  4. Multi-Selectable Merging');
  print('  5. Live Selection Demos');
  print('  6. Null vs Empty Content');
  print('  7. onSelectionChanged Callback');
  print('  8. SelectedContent vs ClipboardData');
  print('  9. Pattern Gallery');
  print('  10. Summary');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _scTeal,
      scaffoldBackgroundColor: _scIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _scDarkTeal,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SelectedContent — Deep Demo'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _scAqua.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.text_snippet, size: 14),
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
            _scBuildOverview(),
            _scDivider(),
            _scBuildPlainText(),
            _scDivider(),
            _scBuildCreation(),
            _scDivider(),
            _scBuildMerging(),
            _scDivider(),
            _scBuildLiveDemo(),
            _scDivider(),
            _scBuildNullVsEmpty(),
            _scDivider(),
            _scBuildCallback(),
            _scDivider(),
            _scBuildVsClipboard(),
            _scDivider(),
            _scBuildPatterns(),
            _scDivider(),
            _scBuildSummary(),
          ],
        ),
      ),
    ),
  );
}
