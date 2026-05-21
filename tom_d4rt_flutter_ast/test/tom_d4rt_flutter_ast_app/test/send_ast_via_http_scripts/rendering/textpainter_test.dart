// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextPainter from rendering
// Deep Demo: Visual demonstration of TextPainter layout, painting and metrics
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextPainter Deep Demo executing');

  // ============================================================
  // SECTION 1: Understanding TextPainter
  // ============================================================
  print('=== Section 1: TextPainter Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is TextPainter
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.text_fields, size: 48.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'TextPainter',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Lays out and paints a TextSpan\ninto a canvas at low level',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Lifecycle
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _lifeStep(Icons.edit, 'configure', Colors.teal),
              Icon(Icons.arrow_forward, color: Colors.grey, size: 16.0),
              _lifeStep(Icons.view_in_ar, 'layout()', Colors.green),
              Icon(Icons.arrow_forward, color: Colors.grey, size: 16.0),
              _lifeStep(Icons.brush, 'paint()', Colors.cyan),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'Configure → layout() → paint()\nMeasure metrics in-between',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade800),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Parameters cheatsheet
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: Colors.orange.shade800, size: 22.0),
              SizedBox(width: 6.0),
              Text(
                'Key parameters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          _bullet('text — InlineSpan tree', Colors.orange.shade800),
          _bullet('textAlign / textDirection', Colors.orange.shade800),
          _bullet('maxLines + ellipsis', Colors.orange.shade800),
          _bullet('textScaler / strutStyle', Colors.orange.shade800),
          _bullet('textWidthBasis / locale', Colors.orange.shade800),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Basic TextPainter rendered via CustomPainter
  // ============================================================
  print('=== Section 2: Basic TextPainter — Side by Side ===');

  final basicSpan = TextSpan(
    text: 'Hello, TextPainter!',
    style: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Colors.indigo.shade900,
    ),
  );
  final basicPainter = TextPainter(
    text: basicSpan,
    textDirection: TextDirection.ltr,
  );
  basicPainter.layout(maxWidth: 320.0);
  print(
    'Basic: width=${basicPainter.width.toStringAsFixed(1)} height=${basicPainter.height.toStringAsFixed(1)}',
  );
  print('  size=${basicPainter.size}');
  print('  preferredLineHeight=${basicPainter.preferredLineHeight}');

  final basicMetricsRow = <Widget>[
    _metricChip('width', basicPainter.width.toStringAsFixed(1), Colors.indigo),
    _metricChip(
      'height',
      basicPainter.height.toStringAsFixed(1),
      Colors.indigo,
    ),
    _metricChip(
      'minIW',
      basicPainter.minIntrinsicWidth.toStringAsFixed(1),
      Colors.deepPurple,
    ),
    _metricChip(
      'maxIW',
      basicPainter.maxIntrinsicWidth.toStringAsFixed(1),
      Colors.deepPurple,
    ),
    _metricChip(
      'lineH',
      basicPainter.preferredLineHeight.toStringAsFixed(1),
      Colors.teal,
    ),
  ];

  final basicSection = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Input TextSpan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'CustomPaint',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            "TextSpan(text: 'Hello, TextPainter!',\n"
            "  style: TextStyle(fontSize: 22, fontWeight: w600))",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Rendered via _TextPainterDemoPainter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 80.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: CustomPaint(
            painter: _TextPainterDemoPainter(
              span: basicSpan,
              maxWidth: 320.0,
              offset: Offset(12.0, 22.0),
              showBaseline: true,
              baselineColor: Colors.indigo,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: basicMetricsRow),
      ],
    ),
  );
  print('Built basic side-by-side panel');

  // ============================================================
  // SECTION 3: textAlign gallery
  // ============================================================
  print('=== Section 3: textAlign Gallery ===');

  final alignEntries = <Map<String, dynamic>>[
    {
      'align': TextAlign.left,
      'label': 'TextAlign.left',
      'color': Colors.blue,
      'sample': 'Left aligned text inside a 280px box.',
    },
    {
      'align': TextAlign.center,
      'label': 'TextAlign.center',
      'color': Colors.green,
      'sample': 'Centered text inside a 280px box.',
    },
    {
      'align': TextAlign.right,
      'label': 'TextAlign.right',
      'color': Colors.orange,
      'sample': 'Right aligned text inside a 280px box.',
    },
    {
      'align': TextAlign.justify,
      'label': 'TextAlign.justify',
      'color': Colors.purple,
      'sample':
          'Justified text spreads across the available width to fill the line evenly.',
    },
  ];

  final alignWidgets = <Widget>[];
  for (final entry in alignEntries) {
    final align = entry['align'] as TextAlign;
    final label = entry['label'] as String;
    final color = entry['color'] as MaterialColor;
    final sample = entry['sample'] as String;

    final alignPainter = TextPainter(
      text: TextSpan(
        text: sample,
        style: TextStyle(fontSize: 14.0, color: color.shade900),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );
    alignPainter.layout(minWidth: 260.0, maxWidth: 260.0);
    print(
      '$label → width=${alignPainter.width.toStringAsFixed(1)} '
      'height=${alignPainter.height.toStringAsFixed(1)} '
      'lines=${alignPainter.computeLineMetrics().length}',
    );

    alignWidgets.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        width: 296.0,
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: color.shade100,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    'h=${alignPainter.height.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: color.shade900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              height: 70.0,
              width: 272.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color.shade200),
              ),
              child: CustomPaint(
                painter: _TextPainterDemoPainter(
                  span: TextSpan(
                    text: sample,
                    style: TextStyle(fontSize: 14.0, color: color.shade900),
                  ),
                  minWidth: 260.0,
                  maxWidth: 260.0,
                  textAlign: align,
                  offset: Offset(6.0, 6.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${alignWidgets.length} alignment frames');

  // ============================================================
  // SECTION 4: maxLines + ellipsis gallery
  // ============================================================
  print('=== Section 4: maxLines + Ellipsis Gallery ===');

  final maxLinesEntries = <Map<String, dynamic>>[
    {'maxLines': 1, 'ellipsis': null, 'color': Colors.red},
    {'maxLines': 1, 'ellipsis': '...', 'color': Colors.orange},
    {'maxLines': 2, 'ellipsis': '…', 'color': Colors.amber},
    {'maxLines': 3, 'ellipsis': ' ›', 'color': Colors.green},
    {'maxLines': null, 'ellipsis': null, 'color': Colors.blue},
  ];

  const longSample =
      'TextPainter can clip overflowing content using maxLines and ellipsis. '
      'It tells you whether the text exceeded the available lines through '
      'didExceedMaxLines, which is useful for overflow indicators.';

  final maxLinesWidgets = <Widget>[];
  for (final entry in maxLinesEntries) {
    final maxLines = entry['maxLines'] as int?;
    final ellipsis = entry['ellipsis'] as String?;
    final color = entry['color'] as MaterialColor;
    final span = TextSpan(
      text: longSample,
      style: TextStyle(fontSize: 13.0, color: color.shade900),
    );
    final p = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      ellipsis: ellipsis,
    );
    p.layout(maxWidth: 260.0);
    print(
      'maxLines=$maxLines ellipsis=$ellipsis → '
      'lines=${p.computeLineMetrics().length} '
      'didExceedMaxLines=${p.didExceedMaxLines} '
      'h=${p.height.toStringAsFixed(1)}',
    );

    final label = maxLines == null ? 'no limit' : 'maxLines=$maxLines';
    final ellLabel = ellipsis == null ? 'no ellipsis' : "ellipsis='$ellipsis'";

    maxLinesWidgets.add(
      Container(
        margin: EdgeInsets.all(8.0),
        width: 292.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.format_line_spacing, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  '$label · $ellLabel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              height: 80.0,
              width: 268.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color.shade200),
              ),
              child: CustomPaint(
                painter: _TextPainterDemoPainter(
                  span: span,
                  maxWidth: 260.0,
                  maxLines: maxLines,
                  ellipsis: ellipsis,
                  offset: Offset(6.0, 6.0),
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: p.didExceedMaxLines
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'didExceedMaxLines=${p.didExceedMaxLines}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: p.didExceedMaxLines
                          ? Colors.red.shade900
                          : Colors.green.shade900,
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  'lines=${p.computeLineMetrics().length}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${maxLinesWidgets.length} maxLines frames');

  // ============================================================
  // SECTION 5: textWidthBasis gallery
  // ============================================================
  print('=== Section 5: textWidthBasis Gallery ===');

  final twbSpan = TextSpan(
    text: 'Short\nMuch longer second line for comparison',
    style: TextStyle(fontSize: 14.0, color: Colors.deepPurple.shade900),
  );

  final twbLongest = TextPainter(
    text: twbSpan,
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.longestLine,
  );
  twbLongest.layout(maxWidth: 320.0);
  print(
    'longestLine → width=${twbLongest.width.toStringAsFixed(1)} '
    'size=${twbLongest.size}',
  );

  final twbParent = TextPainter(
    text: twbSpan,
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.parent,
  );
  twbParent.layout(maxWidth: 320.0);
  print(
    'parent → width=${twbParent.width.toStringAsFixed(1)} '
    'size=${twbParent.size}',
  );

  Widget twbCard(String label, TextPainter p, Color color) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 320.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 6.0),
          Container(
            height: 70.0,
            width: 296.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _TextPainterDemoPainter(
                      span: twbSpan,
                      maxWidth: 320.0,
                      textWidthBasis:
                          label.contains('parent')
                              ? TextWidthBasis.parent
                              : TextWidthBasis.longestLine,
                      offset: Offset(6.0, 6.0),
                      drawBox: true,
                      boxColor: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              _metricChip('width', p.width.toStringAsFixed(1), color),
              SizedBox(width: 6.0),
              _metricChip('height', p.height.toStringAsFixed(1), color),
              SizedBox(width: 6.0),
              _metricChip(
                'minIW',
                p.minIntrinsicWidth.toStringAsFixed(1),
                color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  final twbWidgets = <Widget>[
    twbCard('TextWidthBasis.longestLine', twbLongest, Colors.deepPurple),
    twbCard('TextWidthBasis.parent', twbParent, Colors.teal),
  ];

  // ============================================================
  // SECTION 6: Intrinsic width metrics
  // ============================================================
  print('=== Section 6: Intrinsic Width Metrics ===');

  final intrinsicSpan = TextSpan(
    text: 'Antidisestablishmentarianism is a long word',
    style: TextStyle(fontSize: 16.0, color: Colors.brown.shade900),
  );
  final intrinsicPainter = TextPainter(
    text: intrinsicSpan,
    textDirection: TextDirection.ltr,
  );
  intrinsicPainter.layout();
  final minIW = intrinsicPainter.minIntrinsicWidth;
  final maxIW = intrinsicPainter.maxIntrinsicWidth;
  print('minIntrinsicWidth=$minIW maxIntrinsicWidth=$maxIW');

  final intrinsicPanel = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.brown.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'minIntrinsicWidth vs maxIntrinsicWidth',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          intrinsicSpan.text!,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
        SizedBox(height: 12.0),
        // min intrinsic bar
        Row(
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                'minIW',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.brown.shade900,
                ),
              ),
            ),
            Container(
              width: minIW.clamp(20.0, 500.0),
              height: 22.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade400, Colors.brown.shade700],
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                minIW.toStringAsFixed(1),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        // max intrinsic bar
        Row(
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                'maxIW',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.brown.shade900,
                ),
              ),
            ),
            Container(
              width: maxIW.clamp(20.0, 500.0),
              height: 22.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.deepOrange.shade700],
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                maxIW.toStringAsFixed(1),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'minIW: width of the longest single word (no wrap).\n'
          'maxIW: width when laid out without any wrapping.',
          style: TextStyle(fontSize: 11.0, color: Colors.brown.shade700),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Line metrics visualization
  // ============================================================
  print('=== Section 7: computeLineMetrics() Visualization ===');

  final lineSpan = TextSpan(
    children: [
      TextSpan(
        text: 'First line of three.\n',
        style: TextStyle(fontSize: 14.0, color: Colors.blue.shade900),
      ),
      TextSpan(
        text: 'A second somewhat longer line that wraps demonstrates layout.\n',
        style: TextStyle(fontSize: 16.0, color: Colors.green.shade900),
      ),
      TextSpan(
        text: 'Third line.',
        style: TextStyle(fontSize: 12.0, color: Colors.purple.shade900),
      ),
    ],
  );
  final linePainter = TextPainter(
    text: lineSpan,
    textDirection: TextDirection.ltr,
  );
  linePainter.layout(maxWidth: 300.0);
  final lineMetrics = linePainter.computeLineMetrics();
  print('Number of computed line metrics: ${lineMetrics.length}');
  for (int i = 0; i < lineMetrics.length; i++) {
    final lm = lineMetrics[i];
    print(
      '  line[$i] height=${lm.height.toStringAsFixed(1)} '
      'width=${lm.width.toStringAsFixed(1)} '
      'baseline=${lm.baseline.toStringAsFixed(1)} '
      'ascent=${lm.ascent.toStringAsFixed(1)} '
      'descent=${lm.descent.toStringAsFixed(1)}',
    );
  }

  final lineBars = <Widget>[];
  for (int i = 0; i < lineMetrics.length; i++) {
    final lm = lineMetrics[i];
    final palette = <MaterialColor>[Colors.blue, Colors.green, Colors.purple];
    final color = palette[i % palette.length];
    lineBars.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.shade200,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$i',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Visual: ascent (above baseline) and descent (below)
                  Stack(
                    children: [
                      Container(
                        height: lm.height.clamp(8.0, 60.0),
                        decoration: BoxDecoration(
                          color: color.shade100,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: lm.ascent.clamp(0.0, 60.0),
                        child: Container(height: 1.5, color: color.shade700),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'h=${lm.height.toStringAsFixed(1)}  '
                    'w=${lm.width.toStringAsFixed(1)}  '
                    'baseline=${lm.baseline.toStringAsFixed(1)}  '
                    'asc=${lm.ascent.toStringAsFixed(1)}  '
                    'desc=${lm.descent.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: color.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Also display the actual painted text
  final lineMetricsRender = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 110.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: CustomPaint(
      painter: _TextPainterDemoPainter(
        span: lineSpan,
        maxWidth: 300.0,
        offset: Offset(8.0, 8.0),
        showBaseline: true,
        baselineColor: Colors.red,
      ),
    ),
  );

  // ============================================================
  // SECTION 8: Reflow strip — different widths
  // ============================================================
  print('=== Section 8: Layout Reflow Strip ===');

  const reflowText =
      'Reflow demonstration: TextPainter lays text out at the width you pass to layout().';
  final reflowSpan = TextSpan(
    text: reflowText,
    style: TextStyle(fontSize: 13.0, color: Colors.cyan.shade900),
  );

  final reflowWidths = [80.0, 160.0, 240.0, 320.0];
  final reflowWidgets = <Widget>[];
  for (final w in reflowWidths) {
    final rp = TextPainter(text: reflowSpan, textDirection: TextDirection.ltr);
    rp.layout(maxWidth: w);
    print(
      'reflow @ maxWidth=$w → width=${rp.width.toStringAsFixed(1)} '
      'height=${rp.height.toStringAsFixed(1)} '
      'lines=${rp.computeLineMetrics().length}',
    );
    reflowWidgets.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.cyan.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'maxWidth=${w.toInt()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              width: w,
              height: rp.height.clamp(20.0, 160.0) + 8.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyan.shade200),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: CustomPaint(
                painter: _TextPainterDemoPainter(
                  span: reflowSpan,
                  maxWidth: w,
                  offset: Offset(4.0, 4.0),
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'lines=${rp.computeLineMetrics().length} · '
              'h=${rp.height.toStringAsFixed(1)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 9: Caret, position and selection
  // ============================================================
  print('=== Section 9: Caret + Selection + Position ===');

  final caretSpan = TextSpan(
    text: 'Caret and selection demo!',
    style: TextStyle(fontSize: 18.0, color: Colors.deepOrange.shade900),
  );
  final caretPainter = TextPainter(
    text: caretSpan,
    textDirection: TextDirection.ltr,
  );
  caretPainter.layout(maxWidth: 360.0);
  final caretOffset = caretPainter.getOffsetForCaret(
    TextPosition(offset: 7),
    Rect.zero,
  );
  final caretHeight = caretPainter.getFullHeightForCaret(
    TextPosition(offset: 7),
    Rect.zero,
  );
  final selBoxes = caretPainter.getBoxesForSelection(
    TextSelection(baseOffset: 6, extentOffset: 15),
  );
  final posAt40 = caretPainter.getPositionForOffset(Offset(40.0, 8.0));
  print(
    'getOffsetForCaret(7) → ${caretOffset.dx.toStringAsFixed(1)},${caretOffset.dy.toStringAsFixed(1)}',
  );
  print('getFullHeightForCaret(7) → ${caretHeight.toStringAsFixed(1)}');
  print(
    'getPositionForOffset(40,8) → offset=${posAt40.offset} affinity=${posAt40.affinity}',
  );
  print('getBoxesForSelection(6..15) → ${selBoxes.length} boxes');

  final caretSection = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Caret offset, selection boxes, hit-test',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: CustomPaint(
            painter: _TextPainterDemoPainter(
              span: caretSpan,
              maxWidth: 360.0,
              offset: Offset(8.0, 12.0),
              caretAt: 7,
              selection: TextSelection(baseOffset: 6, extentOffset: 15),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            _metricChip(
              'caret(7).dx',
              caretOffset.dx.toStringAsFixed(1),
              Colors.deepOrange,
            ),
            _metricChip(
              'caret(7).dy',
              caretOffset.dy.toStringAsFixed(1),
              Colors.deepOrange,
            ),
            _metricChip(
              'caretH(7)',
              caretHeight.toStringAsFixed(1),
              Colors.deepOrange,
            ),
            _metricChip('selBoxes', '${selBoxes.length}', Colors.deepOrange),
            _metricChip('pos@40,8', '${posAt40.offset}', Colors.deepOrange),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Code Examples
  // ============================================================
  print('=== Section 10: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Configure, layout and paint a TextPainter\n'
            "final painter = TextPainter(\n"
            "  text: TextSpan(text: 'Hi!', style: TextStyle(fontSize: 18)),\n"
            "  textDirection: TextDirection.ltr,\n"
            "  textAlign: TextAlign.center,\n"
            "  maxLines: 2,\n"
            "  ellipsis: '...',\n"
            ");\n"
            "painter.layout(minWidth: 0, maxWidth: 200);\n"
            "painter.paint(canvas, Offset(10, 10));",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Inspect computed metrics\n'
            'final w = painter.width;\n'
            'final h = painter.height;\n'
            'final lh = painter.preferredLineHeight;\n'
            'final minIW = painter.minIntrinsicWidth;\n'
            'final maxIW = painter.maxIntrinsicWidth;\n'
            'final lines = painter.computeLineMetrics();\n'
            'final overflow = painter.didExceedMaxLines;',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amberAccent.shade400,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Hit-test, carets and selection boxes\n'
            'final pos = painter.getPositionForOffset(Offset(40, 8));\n'
            'final caret = painter.getOffsetForCaret(\n'
            '    TextPosition(offset: 5), Rect.zero);\n'
            'final boxes = painter.getBoxesForSelection(\n'
            '    TextSelection(baseOffset: 0, extentOffset: 5));',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.lightBlueAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built code examples panel');

  // ============================================================
  // SECTION 11: Summary
  // ============================================================
  print('=== Section 11: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.brush,
          'Low-level text drawing',
          'TextPainter is the primitive that backs the Text widget',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.straighten,
          'Always layout() first',
          'Must call layout() before paint() or reading metrics',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.format_line_spacing,
          'Wrapping & overflow',
          'maxLines + ellipsis + didExceedMaxLines control overflow',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.straighten,
          'Rich metrics',
          'minIntrinsicWidth, computeLineMetrics, preferredLineHeight',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.touch_app,
          'Hit-testing & carets',
          'getPositionForOffset, getOffsetForCaret, getBoxesForSelection',
          Colors.deepOrange,
        ),
      ],
    ),
  );

  print('TextPainter Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'TextPainter',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Low-level text layout and painting',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. What TextPainter Does',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Basic TextPainter via CustomPainter',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        basicSection,
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. textAlign Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.start, children: alignWidgets),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. maxLines + Ellipsis',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.start, children: maxLinesWidgets),
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. textWidthBasis',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.start, children: twbWidgets),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Intrinsic Width Metrics',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        intrinsicPanel,
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. computeLineMetrics() Visualization',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        lineMetricsRender,
        ...lineBars,
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Reflow at Different Widths',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.start, children: reflowWidgets),
        SizedBox(height: 32.0),

        // Section 9
        Text(
          '9. Caret, Selection, Hit-test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        caretSection,
        SizedBox(height: 32.0),

        // Section 10
        Text(
          '10. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 11
        Text(
          '11. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _lifeStep(IconData icon, String label, Color color) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.0, color: color),
      ),
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: color,
        ),
      ),
    ],
  );
}

Widget _bullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 6.0, color: color),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _metricChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label=',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// CustomPainter that wraps a TextPainter
// ============================================================

class _TextPainterDemoPainter extends CustomPainter {
  _TextPainterDemoPainter({
    required this.span,
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.ellipsis,
    this.textWidthBasis = TextWidthBasis.parent,
    this.offset = Offset.zero,
    this.showBaseline = false,
    this.baselineColor = const Color(0xFFEF5350),
    this.drawBox = false,
    this.boxColor = const Color(0xFF7E57C2),
    this.caretAt,
    this.selection,
  });

  final InlineSpan span;
  final double minWidth;
  final double maxWidth;
  final TextAlign textAlign;
  final int? maxLines;
  final String? ellipsis;
  final TextWidthBasis textWidthBasis;
  final Offset offset;
  final bool showBaseline;
  final Color baselineColor;
  final bool drawBox;
  final Color boxColor;
  final int? caretAt;
  final TextSelection? selection;

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: span,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      ellipsis: ellipsis,
      textWidthBasis: textWidthBasis,
    );
    final effectiveMax = maxWidth.isFinite ? maxWidth : size.width;
    tp.layout(minWidth: minWidth, maxWidth: effectiveMax);

    // Optional selection highlights (drawn before text so text overlays them).
    if (selection != null) {
      final paint = Paint()
        ..color = const Color(0x553F51B5)
        ..style = PaintingStyle.fill;
      final boxes = tp.getBoxesForSelection(selection!);
      for (final b in boxes) {
        canvas.drawRect(b.toRect().shift(offset), paint);
      }
    }

    // Optional bounding box around the layout extent.
    if (drawBox) {
      final boxPaint = Paint()
        ..color = boxColor.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawRect(
        Rect.fromLTWH(offset.dx, offset.dy, tp.width, tp.height),
        boxPaint,
      );
    }

    // Paint the laid-out text.
    tp.paint(canvas, offset);

    // Optional baseline indicators per line.
    if (showBaseline) {
      final basePaint = Paint()
        ..color = baselineColor.withValues(alpha: 0.6)
        ..strokeWidth = 1.0;
      double y = offset.dy;
      for (final lm in tp.computeLineMetrics()) {
        final by = y + lm.baseline;
        canvas.drawLine(
          Offset(offset.dx, by),
          Offset(offset.dx + lm.width, by),
          basePaint,
        );
        y += lm.height;
      }
    }

    // Optional caret indicator.
    if (caretAt != null) {
      final c = tp.getOffsetForCaret(
        TextPosition(offset: caretAt!),
        Rect.zero,
      );
      final h = tp.getFullHeightForCaret(
        TextPosition(offset: caretAt!),
        Rect.zero,
      );
      final caretPaint = Paint()
        ..color = const Color(0xFFD84315)
        ..strokeWidth = 2.0;
      final cx = offset.dx + c.dx;
      final cy = offset.dy + c.dy;
      canvas.drawLine(Offset(cx, cy), Offset(cx, cy + h), caretPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TextPainterDemoPainter oldDelegate) {
    return oldDelegate.span != span ||
        oldDelegate.minWidth != minWidth ||
        oldDelegate.maxWidth != maxWidth ||
        oldDelegate.textAlign != textAlign ||
        oldDelegate.maxLines != maxLines ||
        oldDelegate.ellipsis != ellipsis ||
        oldDelegate.textWidthBasis != textWidthBasis ||
        oldDelegate.offset != offset ||
        oldDelegate.showBaseline != showBaseline ||
        oldDelegate.baselineColor != baselineColor ||
        oldDelegate.drawBox != drawBox ||
        oldDelegate.boxColor != boxColor ||
        oldDelegate.caretAt != caretAt ||
        oldDelegate.selection != selection;
  }
}
