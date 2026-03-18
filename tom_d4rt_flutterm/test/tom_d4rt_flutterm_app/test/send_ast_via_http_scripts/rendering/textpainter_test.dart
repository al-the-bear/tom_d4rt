// D4rt test script: Tests TextPainter from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering TextPainter test executing');

  // ========== TEXTPAINTER ==========
  print('--- TextPainter Tests ---');

  // Test basic TextPainter
  final basicPainter = TextPainter(
    text: TextSpan(text: 'Hello World'),
    textDirection: TextDirection.ltr,
  );
  print(
    'Basic TextPainter created: textDirection=${basicPainter.textDirection}',
  );

  // Test layout
  basicPainter.layout();
  print(
    'After layout: width=${basicPainter.width}, height=${basicPainter.height}',
  );
  print('  size=${basicPainter.size}');

  // Test with maxWidth
  final constrainedPainter = TextPainter(
    text: TextSpan(text: 'This is a longer text that should wrap'),
    textDirection: TextDirection.ltr,
  );
  constrainedPainter.layout(maxWidth: 100.0);
  print(
    'Constrained layout (maxWidth=100): width=${constrainedPainter.width}, height=${constrainedPainter.height}',
  );

  // Test minWidth
  final minWidthPainter = TextPainter(
    text: TextSpan(text: 'Short'),
    textDirection: TextDirection.ltr,
  );
  minWidthPainter.layout(minWidth: 200.0, maxWidth: 300.0);
  print('MinWidth layout (min=200): width=${minWidthPainter.width}');

  // Test with styled text
  final styledPainter = TextPainter(
    text: TextSpan(
      text: 'Styled',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
    textDirection: TextDirection.ltr,
  );
  styledPainter.layout();
  print(
    'Styled text: width=${styledPainter.width}, height=${styledPainter.height}',
  );

  // Test textAlign
  final leftAlignPainter = TextPainter(
    text: TextSpan(text: 'Left'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
  );
  print('TextAlign.left: ${leftAlignPainter.textAlign}');

  final centerAlignPainter = TextPainter(
    text: TextSpan(text: 'Center'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  print('TextAlign.center: ${centerAlignPainter.textAlign}');

  final rightAlignPainter = TextPainter(
    text: TextSpan(text: 'Right'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.right,
  );
  print('TextAlign.right: ${rightAlignPainter.textAlign}');

  final justifyAlignPainter = TextPainter(
    text: TextSpan(text: 'Justify this text to fill the line completely'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.justify,
  );
  print('TextAlign.justify: ${justifyAlignPainter.textAlign}');

  // Test textDirection
  final rtlPainter = TextPainter(
    text: TextSpan(text: 'مرحبا'),
    textDirection: TextDirection.rtl,
  );
  print('RTL direction: ${rtlPainter.textDirection}');

  // Test maxLines
  final maxLinesPainter = TextPainter(
    text: TextSpan(text: 'Line 1\nLine 2\nLine 3\nLine 4'),
    textDirection: TextDirection.ltr,
    maxLines: 2,
  );
  maxLinesPainter.layout();
  print('MaxLines=2: height=${maxLinesPainter.height}');

  // Test ellipsis
  final ellipsisPainter = TextPainter(
    text: TextSpan(
      text: 'This is a very long text that should be truncated with ellipsis',
    ),
    textDirection: TextDirection.ltr,
    maxLines: 1,
    ellipsis: '...',
  );
  ellipsisPainter.layout(maxWidth: 150.0);
  print('Ellipsis: didExceedMaxLines=${ellipsisPainter.didExceedMaxLines}');

  // Test textScaler
  final scaledPainter = TextPainter(
    text: TextSpan(text: 'Scaled'),
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.linear(2.0),
  );
  scaledPainter.layout();
  print(
    'Scaled 2x: width=${scaledPainter.width}, height=${scaledPainter.height}',
  );

  // Test strutStyle
  final strutPainter = TextPainter(
    text: TextSpan(text: 'Strut'),
    textDirection: TextDirection.ltr,
    strutStyle: StrutStyle(fontSize: 20.0, height: 1.5, forceStrutHeight: true),
  );
  strutPainter.layout();
  print('With strutStyle: height=${strutPainter.height}');

  // Test textHeightBehavior
  final heightBehaviorPainter = TextPainter(
    text: TextSpan(text: 'Height Behavior'),
    textDirection: TextDirection.ltr,
    textHeightBehavior: TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
  );
  heightBehaviorPainter.layout();
  print('With textHeightBehavior: height=${heightBehaviorPainter.height}');

  // Test textWidthBasis
  final longestLinePainter = TextPainter(
    text: TextSpan(text: 'Test'),
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.longestLine,
  );
  print('TextWidthBasis.longestLine: ${longestLinePainter.textWidthBasis}');

  final parentPainter = TextPainter(
    text: TextSpan(text: 'Test'),
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.parent,
  );
  print('TextWidthBasis.parent: ${parentPainter.textWidthBasis}');

  // Test getPositionForOffset
  basicPainter.layout();
  final position = basicPainter.getPositionForOffset(Offset(20.0, 10.0));
  print(
    'getPositionForOffset(20, 10): offset=${position.offset}, affinity=${position.affinity}',
  );

  // Test getOffsetForCaret
  final caretOffset = basicPainter.getOffsetForCaret(
    TextPosition(offset: 5),
    Rect.zero,
  );
  print(
    'getOffsetForCaret(offset=5): x=${caretOffset.dx}, y=${caretOffset.dy}',
  );

  // Test getFullHeightForCaret
  final caretHeight = basicPainter.getFullHeightForCaret(
    TextPosition(offset: 5),
    Rect.zero,
  );
  print('getFullHeightForCaret(offset=5): $caretHeight');

  // Test getBoxesForSelection
  final boxes = basicPainter.getBoxesForSelection(
    TextSelection(baseOffset: 0, extentOffset: 5),
  );
  print('getBoxesForSelection(0-5): ${boxes.length} boxes');

  // Test preferredLineHeight
  print('preferredLineHeight: ${basicPainter.preferredLineHeight}');

  // Test minIntrinsicWidth and maxIntrinsicWidth
  print('minIntrinsicWidth: ${basicPainter.minIntrinsicWidth}');
  print('maxIntrinsicWidth: ${basicPainter.maxIntrinsicWidth}');

  // Test computeLineMetrics
  final metrics = basicPainter.computeLineMetrics();
  print('computeLineMetrics: ${metrics.length} lines');
  if (metrics.isNotEmpty) {
    print(
      '  First line: height=${metrics.first.height}, baseline=${metrics.first.baseline}',
    );
  }

  // Test didExceedMaxLines
  print('didExceedMaxLines (basic): ${basicPainter.didExceedMaxLines}');
  print('didExceedMaxLines (ellipsis): ${ellipsisPainter.didExceedMaxLines}');

  // Test getWordBoundary
  final wordBoundary = basicPainter.getWordBoundary(TextPosition(offset: 2));
  print(
    'getWordBoundary(offset=2): start=${wordBoundary.start}, end=${wordBoundary.end}',
  );

  // Test getLineBoundary
  final lineBoundary = basicPainter.getLineBoundary(TextPosition(offset: 2));
  print(
    'getLineBoundary(offset=2): start=${lineBoundary.start}, end=${lineBoundary.end}',
  );

  // Test inlinePlaceholderBoxes
  print('inlinePlaceholderBoxes: ${basicPainter.inlinePlaceholderBoxes}');

  // Test with inline placeholder
  final placeholderPainter = TextPainter(
    text: TextSpan(
      children: [
        TextSpan(text: 'Before '),
        WidgetSpan(
          child: Container(width: 20.0, height: 20.0, color: Color(0xFFE53935)),
        ),
        TextSpan(text: ' After'),
      ],
    ),
    textDirection: TextDirection.ltr,
  );
  placeholderPainter.setPlaceholderDimensions([
    PlaceholderDimensions(
      size: Size(20.0, 20.0),
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
    ),
  ]);
  placeholderPainter.layout();
  print('With placeholder: width=${placeholderPainter.width}');

  // Test markNeedsLayout
  basicPainter.markNeedsLayout();
  print('After markNeedsLayout, needs re-layout');

  // Test dispose
  final disposablePainter = TextPainter(
    text: TextSpan(text: 'Disposable'),
    textDirection: TextDirection.ltr,
  );
  disposablePainter.layout();
  disposablePainter.dispose();
  print('Disposed painter');

  print('Rendering TextPainter test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextPainter Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Text Alignment:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Left aligned', textAlign: TextAlign.left),
            ),
            SizedBox(height: 4.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Center aligned', textAlign: TextAlign.center),
            ),
            SizedBox(height: 4.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Right aligned', textAlign: TextAlign.right),
            ),
            SizedBox(height: 16.0),

            Text(
              'Max Lines & Ellipsis:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFFFF3E0),
              child: Text(
                'This is a very long text that should be truncated with ellipsis when it exceeds the available width',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 16.0),

            Text('Text Scale:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('1x', style: TextStyle(fontSize: 14.0)),
                SizedBox(width: 8.0),
                Text('1.5x', style: TextStyle(fontSize: 21.0)),
                SizedBox(width: 8.0),
                Text('2x', style: TextStyle(fontSize: 28.0)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Direction:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFFE8F5E9),
                    child: Text('LTR: Hello', textDirection: TextDirection.ltr),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFFE8F5E9),
                    child: Text('RTL: مرحبا', textDirection: TextDirection.rtl),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
