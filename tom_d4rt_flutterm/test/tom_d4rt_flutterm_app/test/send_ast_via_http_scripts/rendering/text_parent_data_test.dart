// ignore_for_file: avoid_print
// Deep demo: TextParentData
// Demonstrates TextParentData — the parent data class used by
// RenderParagraph for inline widget children embedded via WidgetSpan.
import 'package:flutter/material.dart';

// ─── palette: Cyan / Light Cyan ───────────────────────────────────
const Color _tpCyan = Color(0xFF006064);
const Color _tpLight = Color(0xFFE0F7FA);
const Color _tpAccent = Color(0xFF00ACC1);
const Color _tpDark = Color(0xFF212121);
const Color _tpGood = Color(0xFF2E7D32);
const Color _tpWarn = Color(0xFFE65100);
const Color _tpBlue = Color(0xFF1565C0);
const Color _tpPurple = Color(0xFF6A1B9A);

// ─── text helpers ─────────────────────────────────────────────────
Widget _tpTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _tpCyan,
              letterSpacing: 0.3)),
    );

Widget _tpSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _tpAccent)),
    );

Widget _tpBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _tpCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tpDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFF80DEEA),
              height: 1.5)),
    );

Widget _tpNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tpLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tpCyan.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _tpCyan),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _tpCyan, height: 1.4)),
          ),
        ],
      ),
    );

Widget _tpDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _tpCyan.withValues(alpha: 0.12)),
    );

Widget _tpBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _tpAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _tpTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _tpLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _tpCyan,
        letterSpacing: 0.2));

Widget _tpSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual blocks ────────────────────────────────────────────────

/// Simulates an inline widget inside text flow.
Widget _tpInlineChip(String label, Color bg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
    );

/// A hierarchy box.
Widget _tpHierBox(String name, Color bg, {bool highlight = false}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: highlight
            ? Border.all(color: _tpCyan, width: 2)
            : Border.all(color: bg),
      ),
      child: Text(name,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: highlight ? _tpCyan : Colors.white)),
    );

Widget _tpArrow() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, size: 16, color: _tpAccent),
    );

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _tpBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_tpCyan, Color(0xFF00838F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.short_text, size: 48, color: _tpLight),
          const SizedBox(height: 10),
          const Text('TextParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Parent data for inline widgets in rich text',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _tpTag('rendering', _tpAccent),
              _tpTag('parent data', _tpBlue),
              _tpTag('text layout', _tpPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is TextParentData? ──────────────────────────────────
List<Widget> _tpWhatIs() => [
      _tpTitle('§2  What Is TextParentData?'),
      _tpBody(
          'TextParentData is the parent data class attached to each '
          'inline widget child of a RenderParagraph (the render object '
          'behind Text and RichText widgets).'),
      _tpBody(
          'When you use WidgetSpan inside a TextSpan tree, each widget '
          'becomes a child of the RenderParagraph. Flutter needs to know '
          'where that widget sits in the text and at what scale — that '
          'is what TextParentData stores.'),
      _tpCode(
          'class TextParentData\n'
          '    extends ContainerBoxParentData<RenderBox> {\n'
          '  /// The text range that this inline widget replaces.\n'
          '  TextRange? range;\n'
          '\n'
          '  /// The scale factor for this inline widget.\n'
          '  double scale = 1.0;\n'
          '}'),
      _tpNote(
          'ContainerBoxParentData provides offset (position) and '
          'linked-list pointers (previousSibling, nextSibling) for '
          'iterating through children.'),
    ];

// ─── §3 Hierarchy and fields ─────────────────────────────────────
List<Widget> _tpHierarchy() => [
      _tpDivider(),
      _tpTitle('§3  Class Hierarchy & Fields'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _tpHierBox('ParentData', Colors.grey),
            _tpArrow(),
            _tpHierBox('BoxParentData', _tpBlue),
            _tpArrow(),
            _tpHierBox('ContainerBoxParentData<RenderBox>', _tpPurple),
            _tpArrow(),
            _tpHierBox('TextParentData', _tpLight, highlight: true),
          ],
        ),
      ),
      _tpSubtitle('Inherited fields'),
      _tpBullet('offset', 'Position of the child within RenderParagraph'),
      _tpBullet('previousSibling / nextSibling',
          'Linked-list pointers for child iteration'),
      _tpSubtitle('Own fields'),
      _tpBullet('range',
          'TextRange indicating which text positions this widget replaces'),
      _tpBullet('scale',
          'Scale factor (from TextScaler) applied to the inline widget'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tpFieldRow('Field', 'Type', 'Source', isHeader: true),
            _tpFieldRow('offset', 'Offset', 'BoxParentData'),
            _tpFieldRow('previousSibling', 'RenderBox?', 'Container...'),
            _tpFieldRow('nextSibling', 'RenderBox?', 'Container...'),
            _tpFieldRow('range', 'TextRange?', 'TextParentData'),
            _tpFieldRow('scale', 'double', 'TextParentData'),
          ],
        ),
      ),
    ];

Widget _tpFieldRow(String name, String type, String src,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tpCyan : Colors.black87,
    fontFamily: isHeader ? null : 'monospace',
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 100, child: Text(name, style: style)),
        SizedBox(
            width: 80,
            child: Text(type,
                style: style.copyWith(fontFamily: null))),
        Expanded(
            child: Text(src,
                style: style.copyWith(fontFamily: null))),
      ],
    ),
  );
}

// ─── §4 How WidgetSpan creates inline children ───────────────────
List<Widget> _tpWidgetSpan() => [
      _tpDivider(),
      _tpTitle('§4  How WidgetSpan Creates Inline Children'),
      _tpBody(
          'WidgetSpan is a special InlineSpan that embeds a widget directly '
          'in a text flow. When the RichText widget builds its render tree, '
          'each WidgetSpan adds a child to the RenderParagraph:'),
      _tpCode(
          'RichText(\n'
          '  text: TextSpan(\n'
          '    text: "Hello ",\n'
          '    children: [\n'
          '      WidgetSpan(\n'
          '        child: Icon(Icons.star, size: 16),\n'
          '      ),\n'
          '      TextSpan(text: " world!"),\n'
          '    ],\n'
          '  ),\n'
          ')'),
      _tpBody(
          'The Icon becomes a child of the RenderParagraph. Flutter sets '
          'up TextParentData on that child to track where in the text '
          'range the icon sits and what scale to apply.'),
      _tpSubtitle('The setup flow'),
      _tpBullet('Step 1',
          'RichText creates RenderParagraph as its render object'),
      _tpBullet('Step 2',
          'Each WidgetSpan child is added as a child of RenderParagraph'),
      _tpBullet('Step 3',
          'setupParentData() creates TextParentData for each child'),
      _tpBullet('Step 4',
          'During layout, range and scale are populated'),
    ];

// ─── §5 Visual: text with inline widgets ─────────────────────────
List<Widget> _tpInlineVisual() => [
      _tpDivider(),
      _tpTitle('§5  Visual: Text With Inline Widgets'),
      _tpBody(
          'Inline widgets participate in the text flow. They wrap with '
          'the text and sit on the text baseline:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tpLabel('RichText with WidgetSpans'),
            const SizedBox(height: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Check out the ',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
                _tpInlineChip('NEW', _tpAccent),
                const Text(' features in ',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
                _tpInlineChip('Flutter 3.22', _tpCyan),
                const Text(' including improved ',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: _tpPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, size: 12, color: Colors.white),
                ),
                const Text(' rendering performance.',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 12),
            // Annotated version showing parentData
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _tpCyan.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tpSmall('ParentData for each inline child:'),
                  const SizedBox(height: 6),
                  _tpPdAnnotation(
                      'NEW chip', 'range: TextRange(15, 16)', 'scale: 1.0',
                      _tpAccent),
                  _tpPdAnnotation(
                      'Flutter chip', 'range: TextRange(31, 32)',
                      'scale: 1.0', _tpCyan),
                  _tpPdAnnotation(
                      'Star icon', 'range: TextRange(53, 54)', 'scale: 1.0',
                      _tpPurple),
                ],
              ),
            ),
          ],
        ),
      ),
      _tpSmall('Each inline widget has its own TextParentData with range and scale'),
    ];

Widget _tpPdAnnotation(
        String widget, String range, String scale, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          SizedBox(
            width: 80,
            child: Text(widget,
                style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
          ),
          Expanded(
            child: Text('$range  |  $scale',
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── §6 Where scale comes from ───────────────────────────────────
List<Widget> _tpScale() => [
      _tpDivider(),
      _tpTitle('§6  Where Scale Comes From'),
      _tpBody(
          'The scale field comes from the TextScaler (or deprecated '
          'textScaleFactor). When the system font size is changed, '
          'inline widgets need to scale proportionally with the text.'),
      _tpCode(
          '// RenderParagraph sets the scale on each child:\n'
          'final pd = child.parentData as TextParentData;\n'
          'pd.scale = textScaler.scale(fontSize);'),
      _tpSubtitle('Visual: scale = 1.0 vs scale = 1.5'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _tpLabel('scale = 1.0'),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('Price: ',
                          style: TextStyle(fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _tpGood,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('\$42',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(width: 1, height: 60, color: _tpCyan.withValues(alpha: 0.2)),
            Expanded(
              child: Column(
                children: [
                  _tpLabel('scale = 1.5'),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('Price: ',
                          style: TextStyle(fontSize: 21)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: _tpGood,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('\$42',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      _tpNote(
          'The scale is applied when laying out the child. '
          'RenderParagraph multiplies the child constraints by the scale '
          'factor, places the child placeholder into the text layout, '
          'then positions the actual child widget at the same location.'),
    ];

// ─── §7 How RenderParagraph uses TextParentData ──────────────────
List<Widget> _tpLayout() => [
      _tpDivider(),
      _tpTitle('§7  How RenderParagraph Uses TextParentData'),
      _tpBody(
          'During layout and painting, RenderParagraph reads the '
          'TextParentData to position inline widgets correctly:'),
      _tpSubtitle('Layout phase'),
      _tpCode(
          'void performLayout() {\n'
          '  // 1. Build the InlineSpan tree\n'
          '  // 2. Lay out the text with TextPainter\n'
          '  // 3. For each inline child:\n'
          '  var child = firstChild;\n'
          '  while (child != null) {\n'
          '    final pd = child.parentData as TextParentData;\n'
          '    // Layout child at scaled constraints\n'
          '    child.layout(\n'
          '      BoxConstraints(maxWidth: width * pd.scale),\n'
          '      parentUsesSize: true);\n'
          '    child = pd.nextSibling;\n'
          '  }\n'
          '  // 4. Get inline box positions from TextPainter\n'
          '  final boxes = _textPainter.getBoxesForPlaceholders();\n'
          '  child = firstChild;\n'
          '  int i = 0;\n'
          '  while (child != null) {\n'
          '    final pd = child.parentData as TextParentData;\n'
          '    pd.offset = Offset(boxes[i].left, boxes[i].top);\n'
          '    child = pd.nextSibling;\n'
          '    i++;\n'
          '  }\n'
          '}'),
      _tpSubtitle('Paint phase'),
      _tpBody(
          'During paint, the inline children are painted at their '
          'parentData.offset positions — just like any other child:'),
      _tpCode(
          'void paint(PaintingContext context, Offset offset) {\n'
          '  _textPainter.paint(context.canvas, offset);\n'
          '  var child = firstChild;\n'
          '  while (child != null) {\n'
          '    final pd = child.parentData as TextParentData;\n'
          '    context.paintChild(child, pd.offset + offset);\n'
          '    child = pd.nextSibling;\n'
          '  }\n'
          '}'),
    ];

// ─── §8 Multiple inline widgets ──────────────────────────────────
List<Widget> _tpMultiple() => [
      _tpDivider(),
      _tpTitle('§8  Multiple Inline Widgets in One Paragraph'),
      _tpBody(
          'A single RichText can have many WidgetSpans. Each gets its own '
          'TextParentData with distinct range values:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tpLabel('Paragraph with 4 inline widgets'),
            const SizedBox(height: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 2,
              runSpacing: 4,
              children: [
                const Text('Status: ',
                    style: TextStyle(fontSize: 13, color: Colors.black87)),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _tpGood,
                    shape: BoxShape.circle,
                  ),
                ),
                const Text(' Active  User: ',
                    style: TextStyle(fontSize: 13, color: Colors.black87)),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _tpAccent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Center(
                    child: Text('A',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
                const Text('  Rating: ',
                    style: TextStyle(fontSize: 13, color: Colors.black87)),
                ...List.generate(
                  3,
                  (_) => const Icon(Icons.star,
                      size: 14, color: Color(0xFFFFA000)),
                ),
                ...List.generate(
                  2,
                  (_) => const Icon(Icons.star_border,
                      size: 14, color: Color(0xFFFFA000)),
                ),
                const Text('  Level: ',
                    style: TextStyle(fontSize: 13, color: Colors.black87)),
                _tpInlineChip('Pro', _tpPurple),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _tpCyan.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tpSmall('Linked list of children via parentData:'),
                  const SizedBox(height: 6),
                  _tpLinkedListRow('Green dot', 'Avatar', _tpGood, _tpAccent),
                  _tpLinkedListRow('Avatar', 'Star 1', _tpAccent, _tpWarn),
                  _tpLinkedListRow('Star 5', 'Pro chip', _tpWarn, _tpPurple),
                ],
              ),
            ),
          ],
        ),
      ),
      _tpSmall('Children form a linked list via nextSibling/previousSibling'),
    ];

Widget _tpLinkedListRow(
        String from, String to, Color fc, Color tc) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: fc, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(from,
              style: const TextStyle(fontSize: 10, color: Colors.black87)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, size: 12, color: _tpAccent),
          const SizedBox(width: 4),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: tc, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(to,
              style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ],
      ),
    );

// ─── §9 Comparison with other ParentData ─────────────────────────
List<Widget> _tpComparison() => [
      _tpDivider(),
      _tpTitle('§9  Comparison With Other ParentData'),
      _tpBody(
          'TextParentData is one of several ContainerBoxParentData '
          'subclasses. Each adds fields specific to its parent:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tpLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tpCmpRow('Class', 'Extra Fields', 'Parent', isHeader: true),
            _tpCmpRow('TextParentData', 'range, scale', 'RenderParagraph'),
            _tpCmpRow('FlexParentData', 'flex, fit', 'RenderFlex'),
            _tpCmpRow('StackParentData', 'top,left...', 'RenderStack'),
            _tpCmpRow('WrapParentData', '(none added)', 'RenderWrap'),
          ],
        ),
      ),
      _tpSubtitle('What makes TextParentData unique'),
      _tpBullet('range',
          'No other ParentData tracks a text position range'),
      _tpBullet('scale',
          'Font scaling affects child widgets — unique to text layout'),
      _tpBullet('Linked list',
          'From ContainerBoxParentData — shared with Flex, Stack, Wrap'),
      _tpNote(
          'TextParentData is unusual because its extra data (range, scale) '
          'is written by the parent during layout, not by a '
          'ParentDataWidget. There is no equivalent of Flexible or '
          'Positioned for inline text children.'),
    ];

Widget _tpCmpRow(String cls, String fields, String parent,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10.5,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tpCyan : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 110, child: Text(cls, style: style)),
        Expanded(child: Text(fields, style: style)),
        SizedBox(width: 100, child: Text(parent, style: style)),
      ],
    ),
  );
}

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _tpSummary() => [
      _tpDivider(),
      _tpTitle('§10  Summary'),
      _tpBody(
          'TextParentData is the glue that connects inline widgets to the '
          'text layout system. It tells RenderParagraph where each widget '
          'sits in the text range and how to scale it.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _tpCyan.withValues(alpha: 0.08),
              _tpLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _tpCyan.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _tpCyan)),
            const SizedBox(height: 10),
            _tpSumPt('Extends ContainerBoxParentData',
                'Inherits offset + linked-list iteration'),
            _tpSumPt('range field',
                'TextRange marking position in text'),
            _tpSumPt('scale field',
                'Font scale factor for proportional sizing'),
            _tpSumPt('Created by RenderParagraph',
                'setupParentData() in the render object'),
            _tpSumPt('Written during layout',
                'Not set by ParentDataWidget — parent writes directly'),
            _tpSumPt('WidgetSpan is the trigger',
                'Each WidgetSpan adds a child with TextParentData'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _tpCyan,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of TextParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _tpSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _tpGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _tpCyan)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tpBanner(),
        const SizedBox(height: 20),
        ..._tpWhatIs(),
        ..._tpHierarchy(),
        ..._tpWidgetSpan(),
        ..._tpInlineVisual(),
        ..._tpScale(),
        ..._tpLayout(),
        ..._tpMultiple(),
        ..._tpComparison(),
        ..._tpSummary(),
      ],
    ),
  );
}
