// ignore_for_file: avoid_print
// D4rt deep-demo: TextWidthBasis — Spruce / Moss theme, prefix wb
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget wbSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF3B6B4F), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D5240),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget wbChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget wbInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5240))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF4A7A5E))),
        ),
      ],
    ),
  );
}

Widget wbWidthVisualizer(String label, TextWidthBasis basis, Color accent) {
  // Shows a multi-line text block with a background that illustrates the
  // width that would be computed under the given basis.
  final sampleLines = [
    'Short',
    'A medium length line',
    'Tiny',
  ];
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            wbChip(label, accent),
            Expanded(
              child: Text('index: ${basis.index}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF999999))),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        // Visual: a Container whose width represents the computed width
        Container(
          width: basis == TextWidthBasis.parent ? double.infinity : null,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sampleLines
                .map((line) => Text(line,
                    style: TextStyle(fontSize: 12.0, color: Color(0xFF4A7A5E))))
                .toList(),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          basis == TextWidthBasis.parent
              ? 'Width stretches to fill parent container'
              : 'Width shrinks to longest line of content',
          style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFF3B6B4F)),
        ),
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('TextWidthBasis Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] TextWidthBasis Overview');
  print('  Enum that determines how text width is measured');
  print('  2 values: parent, longestLine');
  print('  Used in Text widget and TextPainter');

  final wbTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3B6B4F), Color(0xFF2D5240)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_textdirection_l_to_r, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('TextWidthBasis',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
            'Determines how the width of rendered text is calculated '
            '— by parent constraint or by content',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFC5E0CF))),
        SizedBox(height: 6.0),
        Row(
          children: [
            wbChip('parent', Color(0xFF5A9A6E)),
            wbChip('longestLine', Color(0xFF7AAF8E)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Two Values ───────────────────────────────────
  print('\n[2] The Two Modes');
  for (final v in TextWidthBasis.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final wbTwoValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      children: [
        wbWidthVisualizer('parent', TextWidthBasis.parent, Color(0xFF3B6B4F)),
        wbWidthVisualizer(
            'longestLine', TextWidthBasis.longestLine, Color(0xFF5A9A6E)),
      ],
    ),
  );

  // ── Section 3: Side-by-Side Comparison ───────────────────────
  print('\n[3] Side-by-Side Comparison');
  print('  parent: width = parent constraint');
  print('  longestLine: width = longest line of text');

  final wbSideBySide = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF3B6B4F).withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parent',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B6B4F))),
                SizedBox(height: 6.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(6.0),
                  color: Color(0xFF3B6B4F).withValues(alpha: 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello', style: TextStyle(fontSize: 11.0)),
                      Text('World of Flutter!',
                          style: TextStyle(fontSize: 11.0)),
                      Text('Hi', style: TextStyle(fontSize: 11.0)),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text('← full width →',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF3B6B4F))),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF5A9A6E).withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('longestLine',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5A9A6E))),
                SizedBox(height: 6.0),
                Container(
                  padding: EdgeInsets.all(6.0),
                  color: Color(0xFF5A9A6E).withValues(alpha: 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello', style: TextStyle(fontSize: 11.0)),
                      Text('World of Flutter!',
                          style: TextStyle(fontSize: 11.0)),
                      Text('Hi', style: TextStyle(fontSize: 11.0)),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text('← tight →',
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF5A9A6E))),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ── Section 4: How It Works ──────────────────────────────────
  print('\n[4] How It Works');
  print('  TextPainter calculates minIntrinsicWidth and maxIntrinsicWidth');
  print('  parent: width = maxWidth from layout constraints');
  print('  longestLine: width = max(line widths) among all lines');

  final wbHowItWorks = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Width Calculation Process',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 10.0),
        _wbStepCard('1', 'TextPainter.layout(maxWidth)',
            'Text is laid out with a maximum width constraint', Color(0xFF3B6B4F)),
        _wbStepCard('2', 'Lines are wrapped at maxWidth',
            'Each line gets its actual rendered width', Color(0xFF4A7A5E)),
        _wbStepCard('3a', 'parent → width = maxWidth',
            'The text box takes the full parent width even if text is shorter',
            Color(0xFF3B6B4F)),
        _wbStepCard('3b', 'longestLine → width = max(lineWidths)',
            'The text box shrinks to the widest actual text line',
            Color(0xFF5A9A6E)),
      ],
    ),
  );

  // ── Section 5: Text Widget Usage ─────────────────────────────
  print('\n[5] Text Widget Usage');
  print('  Text(textWidthBasis: TextWidthBasis.parent)');
  print('  Text(textWidthBasis: TextWidthBasis.longestLine)');

  final wbTextWidgetSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text Widget Property',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 8.0),
        wbInfoRow('Property:', 'Text.textWidthBasis'),
        wbInfoRow('Type:', 'TextWidthBasis?'),
        wbInfoRow('Default:', 'TextWidthBasis.parent'),
        wbInfoRow('Affects:', 'Text box width calculation'),
        wbInfoRow('Also in:', 'RichText, EditableText'),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFEAF5ED),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Text(\n'
            '  "Multi-line text here",\n'
            '  textWidthBasis: TextWidthBasis.longestLine,\n'
            '  textAlign: TextAlign.center,\n'
            ')',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF2D5240)),
          ),
        ),
      ],
    ),
  );

  // ── Section 6: Alignment Effects ─────────────────────────────
  print('\n[6] Alignment Effects');
  print('  Centered text + parent: text appears centered in wide box');
  print('  Centered text + longestLine: text centered in tight box');
  print('  Alignment visible difference when text is shorter than parent');

  final alignData = <Map<String, dynamic>>[
    {
      'align': 'Left',
      'textAlign': TextAlign.left,
      'icon': Icons.format_align_left,
    },
    {
      'align': 'Center',
      'textAlign': TextAlign.center,
      'icon': Icons.format_align_center,
    },
    {
      'align': 'Right',
      'textAlign': TextAlign.right,
      'icon': Icons.format_align_right,
    },
  ];

  final wbAlignSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      children: alignData.map((a) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(a['icon'] as IconData,
                      color: Color(0xFF3B6B4F), size: 18.0),
                  SizedBox(width: 6.0),
                  Text('TextAlign.${a['align']}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D5240))),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF3B6B4F).withValues(alpha: 0.08),
                        border: Border.all(
                            color: Color(0xFF3B6B4F).withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        'Short\nMedium line\nHi',
                        textAlign: a['textAlign'] as TextAlign,
                        style: TextStyle(
                            fontSize: 10.0, color: Color(0xFF4A7A5E)),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF5A9A6E).withValues(alpha: 0.08),
                      border: Border.all(
                          color: Color(0xFF5A9A6E).withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      'Short\nMedium line\nHi',
                      textAlign: a['textAlign'] as TextAlign,
                      style:
                          TextStyle(fontSize: 10.0, color: Color(0xFF4A7A5E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Expanded(
                      child: Text('parent (full width)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 9.0, color: Color(0xFF3B6B4F)))),
                  Text('longestLine',
                      style: TextStyle(
                          fontSize: 9.0, color: Color(0xFF5A9A6E))),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 7: Practical Scenarios ───────────────────────────
  print('\n[7] Practical Scenarios');
  print('  Centered captions, tooltips, price labels, badges');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Centered Caption',
      'icon': Icons.image,
      'color': Color(0xFF3B6B4F),
      'best': 'longestLine',
      'why': 'Caption shrinks to content width, appears neatly centered',
    },
    {
      'title': 'Form Label',
      'icon': Icons.edit,
      'color': Color(0xFF5A9A6E),
      'best': 'parent',
      'why': 'Label should fill full width for consistent form layout',
    },
    {
      'title': 'Tooltip Text',
      'icon': Icons.info_outline,
      'color': Color(0xFF3B6B4F),
      'best': 'longestLine',
      'why': 'Tooltip should be compact, wrapping tightly around text',
    },
    {
      'title': 'Data Table Cell',
      'icon': Icons.table_chart,
      'color': Color(0xFF5A9A6E),
      'best': 'parent',
      'why': 'Cell text fills column for alignment consistency',
    },
    {
      'title': 'Badge / Chip',
      'icon': Icons.label,
      'color': Color(0xFF3B6B4F),
      'best': 'longestLine',
      'why': 'Badge wraps tightly around text for visual density',
    },
    {
      'title': 'Paragraph',
      'icon': Icons.article,
      'color': Color(0xFF5A9A6E),
      'best': 'parent',
      'why': 'Text block fills available width for readability',
    },
  ];

  final wbScenarioSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: scenarios.map((s) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border:
                Border.all(color: Color(0xFFC0DCC8).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(s['icon'] as IconData,
                      color: s['color'] as Color, size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(
                      child: Text(s['title'] as String,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D5240)))),
                ],
              ),
              SizedBox(height: 4.0),
              wbChip(s['best'] as String, s['color'] as Color),
              SizedBox(height: 4.0),
              Text(s['why'] as String,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF4A7A5E))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: TextPainter Integration ───────────────────────
  print('\n[8] TextPainter Integration');
  print('  TextPainter.textWidthBasis property');
  print('  Affects computeLineMetrics widths');
  print('  Default: TextWidthBasis.parent');

  final wbPainterSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TextPainter Configuration',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEAF5ED),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'final painter = TextPainter(\n'
                  '  text: TextSpan(text: "Hello"),\n'
                  '  textDirection: TextDirection.ltr,\n'
                  '  textWidthBasis:\n'
                  '    TextWidthBasis.longestLine,\n'
                  ');\n'
                  'painter.layout(maxWidth: 300);\n'
                  '// painter.width = longestLine width\n'
                  '// not 300 (the maxWidth)',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF2D5240)),
                ),
              ),
              SizedBox(height: 8.0),
              wbInfoRow('Property:', 'textWidthBasis'),
              wbInfoRow('Affects:', 'width, size, computeLineMetrics'),
              wbInfoRow(
                  'Key insight:', 'Only matters when text is narrower than maxWidth'),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 9: Switch Pattern ────────────────────────────────
  print('\n[9] Switch Pattern');
  final testBasis = TextWidthBasis.longestLine;
  switch (testBasis) {
    case TextWidthBasis.parent:
      print('  → width = parent constraint');
    case TextWidthBasis.longestLine:
      print('  → width = longest text line');
  }

  final wbSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFEAF5ED),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final sizing = switch (basis) {\n'
            '  TextWidthBasis.parent\n'
            '    => "Full parent width",\n'
            '  TextWidthBasis.longestLine\n'
            '    => "Content-tight width",\n'
            '};',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF2D5240)),
          ),
        ),
        SizedBox(height: 8.0),
        ...TextWidthBasis.values.map((v) {
          final desc = switch (v) {
            TextWidthBasis.parent => 'Width = parent maxWidth',
            TextWidthBasis.longestLine => 'Width = longest rendered line',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Color(0xFF3B6B4F), size: 16.0),
                Text('${v.name} → $desc',
                    style:
                        TextStyle(fontSize: 11.0, color: Color(0xFF4A7A5E))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 10: When Lines Differ ────────────────────────────
  print('\n[10] When Lines Differ');
  print('  Same text → parent and longestLine give same result');
  print('  Multi-line with varying lengths → different widths');
  print('  Matters only when text does NOT fill available width');

  final wbLinesDiffer = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('When Does It Matter?',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 10.0),
        _wbMattersRow(Icons.check_circle, Color(0xFF5A9A6E),
            'Multi-line text where lines have different lengths'),
        _wbMattersRow(Icons.check_circle, Color(0xFF5A9A6E),
            'When center-aligning short text in a wide container'),
        _wbMattersRow(Icons.check_circle, Color(0xFF5A9A6E),
            'Tooltips and popups that should shrink-wrap'),
        _wbMattersRow(Icons.cancel, Color(0xFFCC7766),
            'Single-line text that fills the parent — no difference'),
        _wbMattersRow(Icons.cancel, Color(0xFFCC7766),
            'Text that wraps to fill the entire width — no difference'),
      ],
    ),
  );

  // ── Section 11: IntrinsicWidth + longestLine ─────────────────
  print('\n[11] IntrinsicWidth + longestLine');
  print('  IntrinsicWidth widget sizes child to intrinsic width');
  print('  longestLine gives tighter intrinsic measurement');
  print('  Together = compact text blocks');

  final wbIntrinsicSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Combining with IntrinsicWidth',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFEAF5ED),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'IntrinsicWidth(\n'
            '  child: Text(\n'
            '    "A short line\\n"\n'
            '    "A much longer line here\\n"\n'
            '    "Short",\n'
            '    textWidthBasis:\n'
            '      TextWidthBasis.longestLine,\n'
            '    textAlign: TextAlign.center,\n'
            '  ),\n'
            ')',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF2D5240)),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Result: The Text widget becomes only as wide as the '
            'longest line, and shorter lines are centered within that width.',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF4A7A5E)),
          ),
        ),
      ],
    ),
  );

  // ── Section 12: Equality & Hashing ───────────────────────────
  print('\n[12] Equality & Hashing');
  print('  parent == parent: ${TextWidthBasis.parent == TextWidthBasis.parent}');
  print('  parent == longestLine: ${TextWidthBasis.parent == TextWidthBasis.longestLine}');
  print('  hashCode parent: ${TextWidthBasis.parent.hashCode}');
  print('  hashCode longestLine: ${TextWidthBasis.longestLine.hashCode}');

  final wbEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wbInfoRow('parent == parent:',
            '${TextWidthBasis.parent == TextWidthBasis.parent}'),
        wbInfoRow(
            'parent == longestLine:',
            '${TextWidthBasis.parent == TextWidthBasis.longestLine}'),
        wbInfoRow('hashCode parent:', '${TextWidthBasis.parent.hashCode}'),
        wbInfoRow(
            'hashCode longestLine:',
            '${TextWidthBasis.longestLine.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFC0DCC8)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: TextWidthBasis.values
              .toSet()
              .map((v) => wbChip(v.name, Color(0xFF3B6B4F)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 13: Common Patterns ──────────────────────────────
  print('\n[13] Common Code Patterns');

  final wbPatterns = <Map<String, String>>[
    {
      'title': 'Centered Caption Under Image',
      'code': 'Column(\n'
          '  children: [\n'
          '    Image.asset("photo.jpg"),\n'
          '    Text(\n'
          '      "Photo caption here",\n'
          '      textAlign: TextAlign.center,\n'
          '      textWidthBasis:\n'
          '        TextWidthBasis.longestLine,\n'
          '    ),\n'
          '  ],\n'
          ')',
    },
    {
      'title': 'Full-Width Paragraph',
      'code': 'Text(\n'
          '  paragraph,\n'
          '  textWidthBasis:\n'
          '    TextWidthBasis.parent,\n'
          '  // default — fills container\n'
          ')',
    },
    {
      'title': 'Compact Tooltip',
      'code': 'Container(\n'
          '  decoration: tooltipDecor,\n'
          '  child: Text(\n'
          '    tipText,\n'
          '    textWidthBasis:\n'
          '      TextWidthBasis.longestLine,\n'
          '  ),\n'
          ')',
    },
  ];

  final wbPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      children: wbPatterns.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p['title']!,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3B6B4F))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEAF5ED),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF2D5240))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 14: Visual Width Bars ────────────────────────────
  print('\n[14] Visual Width Bars');
  print('  Showing relative widths for same text');

  final barData = <Map<String, dynamic>>[
    {'label': 'Line 1: "Hi"', 'parentPct': 1.0, 'contentPct': 0.15},
    {
      'label': 'Line 2: "Hello World"',
      'parentPct': 1.0,
      'contentPct': 0.55
    },
    {'label': 'Line 3: "OK"', 'parentPct': 1.0, 'contentPct': 0.12},
  ];

  final wbBarSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF2F8F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Width Visualization per Line',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D5240))),
        SizedBox(height: 10.0),
        ...barData.map((b) => Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(b['label'] as String,
                      style: TextStyle(
                          fontSize: 10.0, color: Color(0xFF4A7A5E))),
                  SizedBox(height: 4.0),
                  SizedBox(
                    height: 14.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: b['parentPct'] as double,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF3B6B4F).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  SizedBox(
                    height: 14.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: b['contentPct'] as double,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF5A9A6E),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: 4.0),
        Row(
          children: [
            Container(
                width: 12.0,
                height: 12.0,
                color: Color(0xFF3B6B4F).withValues(alpha: 0.2)),
            SizedBox(width: 4.0),
            Text('parent width',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF3B6B4F))),
            SizedBox(width: 12.0),
            Container(width: 12.0, height: 12.0, color: Color(0xFF5A9A6E)),
            SizedBox(width: 4.0),
            Text('line content width',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF5A9A6E))),
          ],
        ),
      ],
    ),
  );

  // ── Section 15: Default & Relationship ───────────────────────
  print('\n[15] Default & Relationship');
  print('  Default: TextWidthBasis.parent');
  print('  RenderParagraph: uses textWidthBasis internally');
  print('  Affects: width, preferredLineWidth');

  final wbDefaultSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F3EB),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DCC8)),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Framework Integration',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D5240))),
              SizedBox(height: 6.0),
              wbInfoRow('Text widget:', 'Passes to RenderParagraph'),
              wbInfoRow('RenderParagraph:', 'Pass to TextPainter'),
              wbInfoRow('TextPainter:', 'Uses in layout()'),
              wbInfoRow('Result:', 'Computed width / size'),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Total values: ${TextWidthBasis.values.length}');
  print('  Default: parent');
  print('  Tight sizing: longestLine');

  final wbSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2D5240), Color(0xFF3B6B4F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('TextWidthBasis Dashboard',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${TextWidthBasis.values.length}',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC5E0CF))),
                Text('Modes',
                    style:
                        TextStyle(fontSize: 11.0, color: Color(0xFFA0C8AD))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.aspect_ratio, color: Color(0xFFC5E0CF), size: 28.0),
                Text('Default: parent',
                    style:
                        TextStyle(fontSize: 11.0, color: Color(0xFFA0C8AD))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.compress, color: Color(0xFFC5E0CF), size: 28.0),
                Text('Tight: longestLine',
                    style:
                        TextStyle(fontSize: 11.0, color: Color(0xFFA0C8AD))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          alignment: WrapAlignment.center,
          children: TextWidthBasis.values
              .map((v) => wbChip(v.name, Color(0xFF5A9A6E)))
              .toList(),
        ),
      ],
    ),
  );

  print('\nTextWidthBasis Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        wbTitleSection,
        SizedBox(height: 16.0),
        // 2 Two Values
        wbSectionHeader('The Two Modes', Icons.tune),
        wbTwoValues,
        // 3 Side-by-Side
        wbSectionHeader('Side-by-Side Comparison', Icons.compare),
        wbSideBySide,
        // 4 How
        wbSectionHeader('How It Works', Icons.settings),
        wbHowItWorks,
        // 5 Text Widget
        wbSectionHeader('Text Widget Usage', Icons.text_snippet),
        wbTextWidgetSection,
        // 6 Alignment
        wbSectionHeader('Alignment Effects', Icons.format_align_center),
        wbAlignSection,
        // 7 Scenarios
        wbSectionHeader('Practical Scenarios', Icons.auto_awesome),
        wbScenarioSection,
        // 8 Painter
        wbSectionHeader('TextPainter Integration', Icons.brush),
        wbPainterSection,
        // 9 Switch
        wbSectionHeader('Switch Pattern', Icons.alt_route),
        wbSwitchSection,
        // 10 Matters
        wbSectionHeader('When Does It Matter?', Icons.help_outline),
        wbLinesDiffer,
        // 11 Intrinsic
        wbSectionHeader('IntrinsicWidth + longestLine', Icons.compress),
        wbIntrinsicSection,
        // 12 Equality
        wbSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        wbEqualitySection,
        // 13 Patterns
        wbSectionHeader('Common Code Patterns', Icons.code),
        wbPatternsSection,
        // 14 Bars
        wbSectionHeader('Visual Width Bars', Icons.bar_chart),
        wbBarSection,
        // 15 Default
        wbSectionHeader('Default & Framework Flow', Icons.account_tree),
        wbDefaultSection,
        // 16 Summary
        SizedBox(height: 8.0),
        wbSummarySection,
      ],
    ),
  );
}

// ── Top-level helpers ───────────────────────────────────────────
Widget _wbStepCard(
    String step, String title, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
          child: Text(step,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D5240))),
              SizedBox(height: 2.0),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11.0, color: Color(0xFF4A7A5E))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _wbMattersRow(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 11.0, color: Color(0xFF4A7A5E))),
        ),
      ],
    ),
  );
}
