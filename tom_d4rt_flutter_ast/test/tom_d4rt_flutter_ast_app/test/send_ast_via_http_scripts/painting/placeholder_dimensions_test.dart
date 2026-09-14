// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlaceholderDimensions from painting
// Deep Demo: Visual demonstration of PlaceholderDimensions for inline widget
// placeholders inside RichText / Text.rich.
import 'package:flutter/material.dart';

// ============================================================
// Color palette (warm cream / charcoal / coral)
// ============================================================
const Color _kCream = Color(0xFFFFF6EC);
const Color _kCreamDeep = Color(0xFFFCE7CC);
const Color _kCharcoal = Color(0xFF2B2A29);
const Color _kCharcoalSoft = Color(0xFF4A4845);
const Color _kCoral = Color(0xFFE26D5A);
const Color _kCoralDeep = Color(0xFFB8463A);
const Color _kAmber = Color(0xFFE8A53C);
const Color _kSage = Color(0xFF6B8E6F);
const Color _kSlate = Color(0xFF748A9D);

dynamic build(BuildContext context) {
  print('PlaceholderDimensions Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCharcoal, _kCoralDeep, _kCoral],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.6, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _kCoralDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _kCharcoal.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _kCream.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: _kCream.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.format_shapes_outlined,
                size: 44.0,
                color: _kCream,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PlaceholderDimensions',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: _kCream,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Sizing & aligning inline widgets in text',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: _kCream.withValues(alpha: 0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _kCream.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kCream.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            'package:flutter/painting.dart  -  immutable, used by TextPainter',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kCream,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCream, _kCreamDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kCoral.withValues(alpha: 0.4), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _kCharcoal.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _kCoralDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of PlaceholderDimensions',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kCharcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildAnatomyRow(
          'size',
          'Size',
          'Width & height of the inline placeholder box.',
          Icons.crop_din,
          _kCoral,
        ),
        _buildAnatomyRow(
          'alignment',
          'PlaceholderAlignment',
          'How the box is anchored vertically in the line.',
          Icons.vertical_align_center,
          _kAmber,
        ),
        _buildAnatomyRow(
          'baseline',
          'TextBaseline?',
          'Required when alignment uses a baseline.',
          Icons.text_fields,
          _kSage,
        ),
        _buildAnatomyRow(
          'baselineOffset',
          'double?',
          'Distance from box top to baseline.',
          Icons.straighten,
          _kSlate,
        ),
      ],
    ),
  );
  print('Created anatomy block');

  // ============================================================
  // SECTION 3: Six instance cards (varying sizes)
  // ============================================================
  print('=== Section 3: Instance cards ===');

  final instances = <PlaceholderDimensions>[
    PlaceholderDimensions(
      size: Size(16.0, 16.0),
      alignment: PlaceholderAlignment.middle,
    ),
    PlaceholderDimensions(
      size: Size(24.0, 24.0),
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
      baselineOffset: 18.0,
    ),
    PlaceholderDimensions(
      size: Size(32.0, 48.0),
      alignment: PlaceholderAlignment.aboveBaseline,
      baseline: TextBaseline.alphabetic,
    ),
    PlaceholderDimensions(
      size: Size(64.0, 64.0),
      alignment: PlaceholderAlignment.top,
    ),
    PlaceholderDimensions(
      size: Size(100.0, 16.0),
      alignment: PlaceholderAlignment.bottom,
    ),
    PlaceholderDimensions(
      size: Size(8.0, 32.0),
      alignment: PlaceholderAlignment.belowBaseline,
      baseline: TextBaseline.ideographic,
    ),
  ];

  final instanceLabels = <String>[
    'tiny dot 16x16',
    'icon size 24x24',
    'tall chip 32x48',
    'avatar 64x64',
    'wide bar 100x16',
    'thin line 8x32',
  ];

  final instanceColors = <Color>[
    _kCoral,
    _kAmber,
    _kSage,
    _kSlate,
    _kCoralDeep,
    _kCharcoalSoft,
  ];

  final instanceCards = <Widget>[];
  for (int i = 0; i < instances.length; i++) {
    final dim = instances[i];
    final label = instanceLabels[i];
    final color = instanceColors[i];
    print(
      'Instance[$i]: size=${dim.size}, alignment=${dim.alignment.name}, '
      'baseline=${dim.baseline}, offset=${dim.baselineOffset}',
    );

    instanceCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 10.0),
            // Visualize the actual box at scale (clamped)
            Center(
              child: Container(
                width: dim.size.width.clamp(8.0, 120.0),
                height: dim.size.height.clamp(8.0, 80.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: _kCharcoal, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kCream,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Size(${dim.size.width.toInt()}, ${dim.size.height.toInt()})',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: _kCharcoal,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'align: ${dim.alignment.name}',
              style: TextStyle(fontSize: 10.0, color: _kCharcoalSoft),
            ),
            Text(
              'baseline: ${dim.baseline?.name ?? 'null'}',
              style: TextStyle(fontSize: 10.0, color: _kCharcoalSoft),
            ),
            Text(
              'offset: ${dim.baselineOffset?.toStringAsFixed(1) ?? 'null'}',
              style: TextStyle(fontSize: 10.0, color: _kCharcoalSoft),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${instanceCards.length} instance cards');

  // ============================================================
  // SECTION 4: PlaceholderAlignment gallery
  // ============================================================
  print('=== Section 4: Alignment gallery ===');

  final alignments = <PlaceholderAlignment>[
    PlaceholderAlignment.baseline,
    PlaceholderAlignment.aboveBaseline,
    PlaceholderAlignment.belowBaseline,
    PlaceholderAlignment.top,
    PlaceholderAlignment.bottom,
    PlaceholderAlignment.middle,
  ];

  final alignmentDescriptions = <String>[
    'box baseline aligned to text baseline',
    'box sits ABOVE the text baseline',
    'box sits BELOW the text baseline',
    'box top aligned to line top',
    'box bottom aligned to line bottom',
    'box vertically centered on the line',
  ];

  final alignmentIcons = <IconData>[
    Icons.format_underline,
    Icons.vertical_align_top,
    Icons.vertical_align_bottom,
    Icons.north,
    Icons.south,
    Icons.vertical_align_center,
  ];

  final alignmentColors = <Color>[
    _kCoral,
    _kAmber,
    _kSage,
    _kSlate,
    _kCoralDeep,
    _kCharcoal,
  ];

  final alignmentCards = <Widget>[];
  for (int i = 0; i < alignments.length; i++) {
    final align = alignments[i];
    final color = alignmentColors[i];
    print('Alignment[${align.name}] index=${align.index}');

    alignmentCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 9.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(alignmentIcons[i], color: color, size: 22.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    align.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Mini visual: a baseline line and the placeholder box
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: _kCream,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: _kCharcoalSoft, width: 0.8),
              ),
              child: _buildAlignmentVisual(align, color),
            ),
            SizedBox(height: 8.0),
            Text(
              alignmentDescriptions[i],
              style: TextStyle(fontSize: 10.5, color: _kCharcoalSoft),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'index ${align.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${alignmentCards.length} alignment cards');

  // ============================================================
  // SECTION 5: TextBaseline showcase
  // ============================================================
  print('=== Section 5: TextBaseline showcase ===');

  final baselineAlpha = PlaceholderDimensions(
    size: Size(28.0, 28.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 22.0,
  );
  final baselineIdeo = PlaceholderDimensions(
    size: Size(28.0, 28.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.ideographic,
    baselineOffset: 22.0,
  );
  print('Baseline alphabetic dim: ${baselineAlpha.baseline}');
  print('Baseline ideographic dim: ${baselineIdeo.baseline}');

  final baselineShowcase = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCream, _kCreamDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSage.withValues(alpha: 0.6), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _kSage.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: _kSage, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'TextBaseline Variants',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kCharcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildBaselineRow(
          'alphabetic',
          'Latin & most western scripts. Baseline at the bottom of '
              'characters like x, n, o.',
          baselineAlpha,
          _kSage,
        ),
        SizedBox(height: 12.0),
        _buildBaselineRow(
          'ideographic',
          'CJK scripts. Baseline below the descender, useful for '
              'Han / Kana / Hangul mixed runs.',
          baselineIdeo,
          _kSlate,
        ),
      ],
    ),
  );
  print('Created baseline showcase');

  // ============================================================
  // SECTION 6: baselineOffset variation
  // ============================================================
  print('=== Section 6: baselineOffset variation ===');

  final offsetValues = <double>[0.0, 4.0, 8.0, 12.0, 16.0];
  final offsetCards = <Widget>[];
  for (final offset in offsetValues) {
    final dim = PlaceholderDimensions(
      size: Size(28.0, 28.0),
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      baselineOffset: offset,
    );
    print(
      'Offset variant: ${dim.baselineOffset} -> '
      'effective baseline drop ${dim.baselineOffset}',
    );

    offsetCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _kAmber.withValues(alpha: 0.1 + (offset / 100.0)),
              _kCoral.withValues(alpha: 0.18 + (offset / 80.0)),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: _kAmber, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: _kAmber.withValues(alpha: 0.3),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'offset',
              style: TextStyle(fontSize: 11.0, color: _kCharcoalSoft),
            ),
            SizedBox(height: 4.0),
            Text(
              offset.toStringAsFixed(1),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _kCoralDeep,
              ),
            ),
            SizedBox(height: 8.0),
            // Visual: box with horizontal baseline marker offset
            Container(
              height: 60.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: _kCream,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: _kCharcoalSoft, width: 0.8),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 18.0,
                    top: 8.0,
                    child: Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: _kAmber.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: _kCharcoal, width: 0.8),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 8.0 + offset,
                    child: Container(
                      height: 1.5,
                      color: _kCoralDeep,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'baseline drop',
              style: TextStyle(fontSize: 9.5, color: _kCharcoalSoft),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${offsetCards.length} offset variant cards');

  // ============================================================
  // SECTION 7: Real-world mock with actual WidgetSpan placeholders
  // ============================================================
  print('=== Section 7: Real-world mock ===');

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCream, Color(0xFFFFE6CC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kCoral.withValues(alpha: 0.55), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _kCoral.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.article_outlined, color: _kCoralDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world: Inline placeholders in a paragraph',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _kCharcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kCream,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kCharcoalSoft, width: 0.8),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 15.0,
                color: _kCharcoal,
                height: 1.6,
              ),
              children: <InlineSpan>[
                TextSpan(text: 'Tap the '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.star, size: 18.0, color: _kAmber),
                ),
                TextSpan(text: ' star to favourite, share with '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: _kCoral.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '#flutter',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: _kCream,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' or attach photo '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_kSage, _kSlate],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: _kCharcoal, width: 1.0),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 16.0,
                      color: _kCream,
                    ),
                  ),
                ),
                TextSpan(text: ' to your post.'),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        // Second mock: alignment variants in same line
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kCream,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kCharcoalSoft, width: 0.8),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: _kCharcoal,
                height: 1.8,
              ),
              children: <InlineSpan>[
                TextSpan(text: 'top:'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: _miniBox(_kCoral),
                ),
                TextSpan(text: '  middle:'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _miniBox(_kAmber),
                ),
                TextSpan(text: '  bottom:'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: _miniBox(_kSage),
                ),
                TextSpan(text: '  baseline:'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: _miniBox(_kSlate),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Created real-world mock');

  // ============================================================
  // SECTION 8: Comparison table
  // ============================================================
  print('=== Section 8: Comparison table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCream, _kCreamDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSlate.withValues(alpha: 0.5), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: _kSlate.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: _kSlate, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Sizing types compared',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kCharcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: _kSlate.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _headerCell('Type', 130.0),
              _headerCell('Encodes', 120.0),
              _headerCell('Used by', 140.0),
              _headerCell('Inline?', 70.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _compareRow(
          'PlaceholderDimensions',
          'size + align + baseline',
          'TextPainter',
          true,
          _kCoral,
        ),
        _compareRow(
          'Size',
          'width & height only',
          'BoxConstraints, layout',
          false,
          _kAmber,
        ),
        _compareRow(
          'Rect',
          'origin + size',
          'Painting / hit-testing',
          false,
          _kSage,
        ),
        _compareRow(
          'BoxConstraints',
          'min/max width & height',
          'RenderBox layout',
          false,
          _kSlate,
        ),
      ],
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 9: Code block (TextPainter.setPlaceholderDimensions)
  // ============================================================
  print('=== Section 9: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCharcoal, Color(0xFF1B1A19)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _kCharcoal.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: _kCoral, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'TextPainter integration',
              style: TextStyle(
                color: _kCoral,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeLine('// 1. Build a TextSpan with WidgetSpans', _kSlate),
        _codeLine('final span = TextSpan(children: [', _kCream),
        _codeLine("  TextSpan(text: 'Hello '),", _kAmber),
        _codeLine('  WidgetSpan(child: Icon(Icons.star)),', _kAmber),
        _codeLine("  TextSpan(text: ' world'),", _kAmber),
        _codeLine(']);', _kCream),
        SizedBox(height: 8.0),
        _codeLine('// 2. Measure or fix sizes for each WidgetSpan', _kSlate),
        _codeLine('final dims = <PlaceholderDimensions>[', _kCream),
        _codeLine('  PlaceholderDimensions(', _kSage),
        _codeLine('    size: Size(24, 24),', _kSage),
        _codeLine('    alignment: PlaceholderAlignment.middle,', _kSage),
        _codeLine('  ),', _kSage),
        _codeLine('];', _kCream),
        SizedBox(height: 8.0),
        _codeLine('// 3. Hand them to the TextPainter BEFORE layout', _kSlate),
        _codeLine('final painter = TextPainter(text: span,', _kCream),
        _codeLine('    textDirection: TextDirection.ltr);', _kCream),
        _codeLine('painter.setPlaceholderDimensions(dims);', _kCoral),
        _codeLine('painter.layout(maxWidth: 320);', _kCoral),
      ],
    ),
  );
  print('Created code block');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footgun cards ===');

  final footgunData = <Map<String, Object>>[
    {
      'title': 'baseline alignments need a TextBaseline',
      'detail': 'When alignment is baseline / aboveBaseline / belowBaseline, '
          'the baseline field MUST be non-null. Otherwise the assertion in '
          'the constructor fails.',
      'icon': Icons.warning_amber_rounded,
      'color': _kCoralDeep,
    },
    {
      'title': 'PlaceholderDimensions.empty is a sentinel',
      'detail': 'Size.zero with PlaceholderAlignment.baseline. Use it as a '
          'safe default for un-measured WidgetSpans, not as a real layout.',
      'icon': Icons.crop_square,
      'color': _kAmber,
    },
    {
      'title': 'must call setPlaceholderDimensions BEFORE layout',
      'detail': 'TextPainter.layout() reads the dimensions list. Setting it '
          'after layout has no effect until the next layout pass.',
      'icon': Icons.timer_off_outlined,
      'color': _kSage,
    },
    {
      'title': 'list length must match WidgetSpan count',
      'detail': 'Mismatched arrays silently produce wrong line metrics. The '
          'order of the list mirrors the WidgetSpan traversal order.',
      'icon': Icons.format_list_numbered,
      'color': _kSlate,
    },
    {
      'title': 'baselineOffset is from the BOX TOP',
      'detail': 'It is the distance from the placeholder box top down to its '
          'baseline. Confusing it with line-height yields jittery glyph runs.',
      'icon': Icons.straighten,
      'color': _kCharcoalSoft,
    },
  ];

  final footgunCards = <Widget>[];
  for (final item in footgunData) {
    final color = item['color'] as Color;
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.20),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: color,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    item['detail'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _kCharcoalSoft,
                      height: 1.4,
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
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap
  // ============================================================
  print('=== Section 11: Recap ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCoralDeep, _kCoral, _kAmber],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.5, 1.0],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: _kCoralDeep.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _kCream, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: _kCream,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapBullet('Immutable description of an inline placeholder box.'),
        _recapBullet('Always paired with a WidgetSpan in a TextSpan tree.'),
        _recapBullet('Fed into TextPainter.setPlaceholderDimensions(...).'),
        _recapBullet('Alignment + baseline together drive vertical placement.'),
        _recapBullet('PlaceholderDimensions.empty is the safe zero default.'),
      ],
    ),
  );
  print('Created recap');

  print('PlaceholderDimensions Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: _kCream,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 22.0),
          _sectionHeader('1. Anatomy', Icons.account_tree_outlined),
          anatomy,
          SizedBox(height: 22.0),
          _sectionHeader('2. Six instance cards', Icons.collections_outlined),
          Wrap(alignment: WrapAlignment.center, children: instanceCards),
          SizedBox(height: 22.0),
          _sectionHeader(
            '3. PlaceholderAlignment gallery',
            Icons.grid_view_outlined,
          ),
          Wrap(alignment: WrapAlignment.center, children: alignmentCards),
          SizedBox(height: 22.0),
          _sectionHeader('4. TextBaseline showcase', Icons.text_fields),
          baselineShowcase,
          SizedBox(height: 22.0),
          _sectionHeader('5. baselineOffset variation', Icons.straighten),
          Wrap(alignment: WrapAlignment.center, children: offsetCards),
          SizedBox(height: 22.0),
          _sectionHeader('6. Real-world mock', Icons.article_outlined),
          realWorldMock,
          SizedBox(height: 22.0),
          _sectionHeader('7. Comparison table', Icons.compare_arrows),
          comparisonTable,
          SizedBox(height: 22.0),
          _sectionHeader('8. TextPainter code', Icons.code),
          codeBlock,
          SizedBox(height: 22.0),
          _sectionHeader('9. Footguns', Icons.report_problem_outlined),
          ...footgunCards,
          SizedBox(height: 22.0),
          _sectionHeader('10. Recap', Icons.summarize),
          recap,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers (top-level only)
// ============================================================

Widget _sectionHeader(String label, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCharcoal, _kCharcoalSoft],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: _kCharcoal.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: _kCoral, size: 20.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            color: _kCream,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(fontSize: 12.0, color: _kCharcoalSoft),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlignmentVisual(PlaceholderAlignment align, Color color) {
  // y-position of the placeholder box (16x16) inside a 60-tall container
  double top = 22.0;
  double baselineY = 40.0;
  if (align == PlaceholderAlignment.top) {
    top = 4.0;
  } else if (align == PlaceholderAlignment.bottom) {
    top = 40.0;
  } else if (align == PlaceholderAlignment.middle) {
    top = 22.0;
  } else if (align == PlaceholderAlignment.baseline) {
    top = baselineY - 16.0;
  } else if (align == PlaceholderAlignment.aboveBaseline) {
    top = baselineY - 22.0;
  } else if (align == PlaceholderAlignment.belowBaseline) {
    top = baselineY - 6.0;
  }
  return Stack(
    children: [
      // Baseline marker
      Positioned(
        left: 0.0,
        right: 0.0,
        top: baselineY,
        child: Container(height: 1.0, color: _kCoralDeep),
      ),
      // Placeholder box
      Positioned(
        left: 70.0,
        top: top,
        child: Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.85),
            border: Border.all(color: _kCharcoal, width: 0.8),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
      // Faux text glyphs
      Positioned(
        left: 8.0,
        top: baselineY - 12.0,
        child: Text(
          'abc',
          style: TextStyle(
            fontSize: 14.0,
            color: _kCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Positioned(
        left: 96.0,
        top: baselineY - 12.0,
        child: Text(
          'xyz',
          style: TextStyle(
            fontSize: 14.0,
            color: _kCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _buildBaselineRow(
  String name,
  String description,
  PlaceholderDimensions dim,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 12.0, color: _kCharcoalSoft),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: _kCream,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: color, width: 0.8),
                ),
                child: Text(
                  'baseline=${dim.baseline?.name}, '
                  'offset=${dim.baselineOffset?.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _miniBox(Color color) {
  return Container(
    width: 18.0,
    height: 18.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3.0),
      border: Border.all(color: _kCharcoal, width: 0.8),
    ),
  );
}

Widget _headerCell(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: _kCharcoal,
      ),
    ),
  );
}

Widget _compareRow(
  String type,
  String encodes,
  String usedBy,
  bool inline,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(
        left: BorderSide(color: color, width: 3.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            encodes,
            style: TextStyle(fontSize: 11.0, color: _kCharcoalSoft),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            usedBy,
            style: TextStyle(fontSize: 11.0, color: _kCharcoalSoft),
          ),
        ),
        SizedBox(
          width: 70.0,
          child: Icon(
            inline ? Icons.check_circle : Icons.remove_circle_outline,
            color: inline ? _kSage : _kCharcoalSoft,
            size: 18.0,
          ),
        ),
      ],
    ),
  );
}

Widget _codeLine(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: _kCream, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _kCream,
              fontSize: 13.5,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
