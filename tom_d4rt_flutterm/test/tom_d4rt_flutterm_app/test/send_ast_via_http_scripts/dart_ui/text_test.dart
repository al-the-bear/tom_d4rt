// D4rt test script: Tests TextStyle, Paragraph, ParagraphBuilder from dart:ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Dart:ui text test executing');

  // ========== TEXTSTYLE (dart:ui) ==========
  print('--- TextStyle (dart:ui) Tests ---');

  // Basic TextStyle
  final basicStyle = TextStyle(color: const Color(0xFF000000), fontSize: 16.0);
  print('Basic TextStyle: $basicStyle');

  // Full TextStyle
  final fullStyle = TextStyle(
    color: const Color(0xFF2196F3),
    decoration: TextDecoration.underline,
    decorationColor: const Color(0xFFE53935),
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 2.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    textBaseline: TextBaseline.alphabetic,
    fontFamily: 'Roboto',
    fontFamilyFallback: ['Arial', 'Helvetica'],
    fontSize: 18.0,
    letterSpacing: 0.5,
    wordSpacing: 2.0,
    height: 1.5,
    leadingDistribution: TextLeadingDistribution.even,
    locale: const Locale('en', 'US'),
  );
  print('Full TextStyle: $fullStyle');

  // TextDecoration combinations
  print('--- TextDecoration Tests ---');
  print('TextDecoration.none: ${TextDecoration.none}');
  print('TextDecoration.underline: ${TextDecoration.underline}');
  print('TextDecoration.overline: ${TextDecoration.overline}');
  print('TextDecoration.lineThrough: ${TextDecoration.lineThrough}');

  // Combined decorations
  final combinedDeco = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.overline,
  ]);
  print('Combined decoration: $combinedDeco');

  // TextDecorationStyle
  print('--- TextDecorationStyle Tests ---');
  print('TextDecorationStyle.solid: ${TextDecorationStyle.solid}');
  print('TextDecorationStyle.double: ${TextDecorationStyle.double}');
  print('TextDecorationStyle.dotted: ${TextDecorationStyle.dotted}');
  print('TextDecorationStyle.dashed: ${TextDecorationStyle.dashed}');
  print('TextDecorationStyle.wavy: ${TextDecorationStyle.wavy}');

  // TextLeadingDistribution
  print('--- TextLeadingDistribution Tests ---');
  print(
    'TextLeadingDistribution.proportional: ${TextLeadingDistribution.proportional}',
  );
  print('TextLeadingDistribution.even: ${TextLeadingDistribution.even}');

  // ========== PARAGRAPHSTYLE ==========
  print('--- ParagraphStyle Tests ---');

  // Basic ParagraphStyle
  final basicParagraphStyle = ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
  );
  print('Basic ParagraphStyle: $basicParagraphStyle');

  // Full ParagraphStyle
  final fullParagraphStyle = ParagraphStyle(
    textAlign: TextAlign.justify,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontFamily: 'Roboto',
    fontSize: 16.0,
    height: 1.5,
    textHeightBehavior: const TextHeightBehavior(
      applyHeightToFirstAscent: true,
      applyHeightToLastDescent: true,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    strutStyle: StrutStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      height: 1.5,
      leading: 0.0,
      forceStrutHeight: true,
    ),
    ellipsis: '...',
    locale: const Locale('en', 'US'),
  );
  print('Full ParagraphStyle: $fullParagraphStyle');

  // ========== TEXTPOSITION ==========
  print('--- TextPosition Tests ---');

  final posDownstream = const TextPosition(offset: 5);
  print(
    'TextPosition(5) - default downstream: ${posDownstream.offset}, ${posDownstream.affinity}',
  );

  final posUpstream = const TextPosition(
    offset: 10,
    affinity: TextAffinity.upstream,
  );
  print(
    'TextPosition(10, upstream): ${posUpstream.offset}, ${posUpstream.affinity}',
  );

  // ========== TEXTBOX ==========
  print('--- TextBox Tests ---');

  final textBox = const TextBox.fromLTRBD(
    10.0,
    20.0,
    100.0,
    40.0,
    TextDirection.ltr,
  );
  print(
    'TextBox: left=${textBox.left}, top=${textBox.top}, right=${textBox.right}, bottom=${textBox.bottom}',
  );
  print('TextBox direction: ${textBox.direction}');
  print('TextBox start/end: start=${textBox.start}, end=${textBox.end}');
  print('TextBox toRect: ${textBox.toRect()}');

  // ========== TEXTRANGE ==========
  print('--- TextRange Tests ---');

  final range = const TextRange(start: 5, end: 10);
  print('TextRange(5, 10): start=${range.start}, end=${range.end}');
  print('isValid: ${range.isValid}');
  print('isCollapsed: ${range.isCollapsed}');
  print('isNormalized: ${range.isNormalized}');

  const collapsedRange = TextRange.collapsed(10);
  print(
    'TextRange.collapsed(10): ${collapsedRange.start}, ${collapsedRange.end}, isCollapsed=${collapsedRange.isCollapsed}',
  );

  print('TextRange.empty: ${TextRange.empty}');

  // Test textBefore/textAfter/textInside
  const testText = 'Hello, World!';
  print('textBefore: "${range.textBefore(testText)}"');
  print('textAfter: "${range.textAfter(testText)}"');
  print('textInside: "${range.textInside(testText)}"');

  // ========== PARAGRAPHCONSTRAINTS ==========
  print('--- ParagraphConstraints Tests ---');

  const constraints = ParagraphConstraints(width: 300.0);
  print('ParagraphConstraints(300): width=${constraints.width}');

  // ========== PARAGRAPHBUILDER & PARAGRAPH ==========
  print('--- ParagraphBuilder Tests ---');

  // Simple paragraph
  final builder1 = ParagraphBuilder(
    ParagraphStyle(textAlign: TextAlign.left, fontSize: 16.0),
  );
  builder1.addText('Hello, World!');
  final paragraph1 = builder1.build();
  paragraph1.layout(const ParagraphConstraints(width: 300.0));
  print(
    'Simple paragraph: width=${paragraph1.width}, height=${paragraph1.height}',
  );
  print('  minIntrinsicWidth: ${paragraph1.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${paragraph1.maxIntrinsicWidth}');
  print('  alphabeticBaseline: ${paragraph1.alphabeticBaseline}');
  print('  ideographicBaseline: ${paragraph1.ideographicBaseline}');
  print('  didExceedMaxLines: ${paragraph1.didExceedMaxLines}');

  // Paragraph with pushStyle
  final builder2 = ParagraphBuilder(
    ParagraphStyle(textAlign: TextAlign.left, fontSize: 14.0),
  );
  builder2.pushStyle(
    TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF000000)),
  );
  builder2.addText('Bold text');
  builder2.pop();
  builder2.addText(' normal text');
  final paragraph2 = builder2.build();
  paragraph2.layout(const ParagraphConstraints(width: 300.0));
  print(
    'Styled paragraph: width=${paragraph2.width}, height=${paragraph2.height}',
  );

  // Paragraph with multiple styles
  final builder3 = ParagraphBuilder(
    ParagraphStyle(textAlign: TextAlign.center, fontSize: 16.0),
  );
  builder3.pushStyle(TextStyle(color: const Color(0xFFE53935)));
  builder3.addText('Red ');
  builder3.pop();
  builder3.pushStyle(TextStyle(color: const Color(0xFF4CAF50)));
  builder3.addText('Green ');
  builder3.pop();
  builder3.pushStyle(TextStyle(color: const Color(0xFF2196F3)));
  builder3.addText('Blue');
  builder3.pop();
  final paragraph3 = builder3.build();
  paragraph3.layout(const ParagraphConstraints(width: 300.0));
  print('Multi-color paragraph: width=${paragraph3.width}');

  // Paragraph position methods
  final longBuilder = ParagraphBuilder(ParagraphStyle(fontSize: 16.0));
  longBuilder.addText('The quick brown fox jumps over the lazy dog.');
  final longParagraph = longBuilder.build();
  longParagraph.layout(const ParagraphConstraints(width: 200.0));

  // getPositionForOffset
  final position = longParagraph.getPositionForOffset(const Offset(50.0, 10.0));
  print(
    'Position at (50, 10): offset=${position.offset}, affinity=${position.affinity}',
  );

  // getBoxesForRange
  final boxes = longParagraph.getBoxesForRange(0, 10);
  print('Boxes for range 0-10: ${boxes.length} box(es)');
  for (final box in boxes) {
    print('  Box: ${box.left}-${box.right}, ${box.top}-${box.bottom}');
  }

  // getWordBoundary
  final wordBoundary = longParagraph.getWordBoundary(
    const TextPosition(offset: 4),
  );
  print('Word boundary at offset 4: ${wordBoundary.start}-${wordBoundary.end}');

  // getLineBoundary
  final lineBoundary = longParagraph.getLineBoundary(
    const TextPosition(offset: 4),
  );
  print('Line boundary at offset 4: ${lineBoundary.start}-${lineBoundary.end}');

  // computeLineMetrics
  final lineMetrics = longParagraph.computeLineMetrics();
  print('Line metrics: ${lineMetrics.length} line(s)');
  for (var i = 0; i < lineMetrics.length; i++) {
    final metric = lineMetrics[i];
    print(
      '  Line $i: ascent=${metric.ascent.toStringAsFixed(2)}, descent=${metric.descent.toStringAsFixed(2)}, height=${metric.height.toStringAsFixed(2)}, width=${metric.width.toStringAsFixed(2)}, left=${metric.left.toStringAsFixed(2)}, baseline=${metric.baseline.toStringAsFixed(2)}, lineNumber=${metric.lineNumber}',
    );
  }

  // Paragraph with maxLines and ellipsis
  final ellipsisBuilder = ParagraphBuilder(
    ParagraphStyle(fontSize: 16.0, maxLines: 2, ellipsis: '...'),
  );
  ellipsisBuilder.addText(
    'This is a very long text that should be truncated with an ellipsis when it exceeds the maximum number of lines specified in the paragraph style. The ellipsis should appear at the end.',
  );
  final ellipsisParagraph = ellipsisBuilder.build();
  ellipsisParagraph.layout(const ParagraphConstraints(width: 200.0));
  print(
    'Ellipsis paragraph: lines exceeded=${ellipsisParagraph.didExceedMaxLines}',
  );

  // ========== STROSTRING (placeholder) ==========
  print('--- Placeholder Tests ---');

  final placeholderBuilder = ParagraphBuilder(ParagraphStyle(fontSize: 16.0));
  placeholderBuilder.addText('Text with ');
  placeholderBuilder.addPlaceholder(24.0, 24.0, PlaceholderAlignment.middle);
  placeholderBuilder.addText(' placeholder.');
  final placeholderParagraph = placeholderBuilder.build();
  placeholderParagraph.layout(const ParagraphConstraints(width: 300.0));
  print('Placeholder paragraph: width=${placeholderParagraph.width}');

  // PlaceholderAlignment values
  print('PlaceholderAlignment.baseline: ${PlaceholderAlignment.baseline}');
  print(
    'PlaceholderAlignment.aboveBaseline: ${PlaceholderAlignment.aboveBaseline}',
  );
  print(
    'PlaceholderAlignment.belowBaseline: ${PlaceholderAlignment.belowBaseline}',
  );
  print('PlaceholderAlignment.top: ${PlaceholderAlignment.top}');
  print('PlaceholderAlignment.bottom: ${PlaceholderAlignment.bottom}');
  print('PlaceholderAlignment.middle: ${PlaceholderAlignment.middle}');

  print('Dart:ui text test completed');

  // Return visual demonstration
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dart:UI Text Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'TextDecoration:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'None',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  'Underline',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text(
                  'Overline',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.overline,
                  ),
                ),
                Text(
                  'LineThrough',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  'Combined',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'TextDecorationStyle:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Solid',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
                Text(
                  'Double',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                  ),
                ),
                Text(
                  'Dotted',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                  ),
                ),
                Text(
                  'Dashed',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                Text(
                  'Wavy',
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('FontWeight:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Text('w100', style: TextStyle(fontWeight: FontWeight.w100)),
                Text('w200', style: TextStyle(fontWeight: FontWeight.w200)),
                Text('w300', style: TextStyle(fontWeight: FontWeight.w300)),
                Text('w400', style: TextStyle(fontWeight: FontWeight.w400)),
                Text('w500', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('w600', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('w700', style: TextStyle(fontWeight: FontWeight.w700)),
                Text('w800', style: TextStyle(fontWeight: FontWeight.w800)),
                Text('w900', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('TextAlign:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                children: [
                  Text(
                    'Left aligned',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'Center aligned',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'Right aligned',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Styled Text Example:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.0, color: Color(0xFF000000)),
                children: [
                  TextSpan(
                    text: 'Bold ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Italic ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: 'Red ',
                    style: TextStyle(color: Color(0xFFE53935)),
                  ),
                  TextSpan(
                    text: 'Blue ',
                    style: TextStyle(color: Color(0xFF2196F3)),
                  ),
                  TextSpan(text: 'Large', style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Line Metrics:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ascent - height above baseline',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• descent - depth below baseline',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• height - total line height',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• width - line width',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• baseline - baseline y position',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'PlaceholderAlignment:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final align in [
                  'baseline',
                  'aboveBaseline',
                  'belowBaseline',
                  'top',
                  'bottom',
                  'middle',
                ])
                  Text('• $align', style: TextStyle(fontSize: 12.0)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
