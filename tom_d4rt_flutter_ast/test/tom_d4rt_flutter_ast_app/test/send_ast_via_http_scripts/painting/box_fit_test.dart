// ignore_for_file: avoid_print
// D4rt test script: Deep demo for BoxFit enum from painting
// Demonstrates all 7 scaling modes inside FittedBox containers,
// aspect-ratio behavior, DecorationImage fit, and real-world use cases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxFit Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color bfPrimary = Color(0xFFFF8F00); // amber 800
  final Color bfAccent = Color(0xFFFFA726); // orange 400
  final Color bfSurface = Color(0xFFFFF8E1); // amber 50
  final Color bfDark = Color(0xFF4E342E); // brown 800
  final Color bfClip = Color(0xFFC62828); // red 800
  final Color bfFit = Color(0xFF2E7D32); // green 800

  // A simulated "source image" placeholder — a wide landscape rectangle
  Widget bfSourcePlaceholder({double width = 100.0, double height = 60.0}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1565C0), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(children: [
        // "hills" at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF388E3C), Color(0xFF1B5E20)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              ),
            ),
          ),
        ),
        // "sun" in corner
        Positioned(
          top: 6.0,
          right: 8.0,
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFD54F),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Text('IMG',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  Widget bfBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11.0, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget bfSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bfPrimary, bfAccent]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  Widget bfCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: bfPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: bfPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget bfInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 130.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: bfDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? bfPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final bfTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bfDark, bfPrimary, bfAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: bfDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(children: [
      Icon(Icons.aspect_ratio, size: 48.0, color: Colors.white),
      SizedBox(height: 10.0),
      Text('BoxFit',
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 4.0),
      Text('painting library — enum',
          style: TextStyle(
              color: Colors.white70,
              fontSize: 13.0,
              fontStyle: FontStyle.italic)),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Controls how a child or image scales to fit within its '
          'allocated box. With 7 modes — from stretching (fill) to '
          'passive centering (none) — BoxFit is the key enum for '
          'Image, FittedBox, and DecorationImage.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
      ),
    ]),
  );

  // ============================================================
  // SECTION 2: All 7 Values — Quick Gallery
  // ============================================================
  print('=== Section 2: All 7 Values ===');

  final bfDescriptions = <BoxFit, String>{
    BoxFit.fill: 'Stretch to fill exactly — may distort aspect ratio',
    BoxFit.contain: 'Scale to fit inside — preserves ratio, may letterbox',
    BoxFit.cover: 'Scale to cover all — preserves ratio, may clip',
    BoxFit.fitWidth: 'Scale width to match — may overflow vertically',
    BoxFit.fitHeight: 'Scale height to match — may overflow horizontally',
    BoxFit.none: 'No scaling — center at original size',
    BoxFit.scaleDown: 'Like contain but never scales up',
  };

  final bfQuickCards = <Widget>[];
  for (final fit in BoxFit.values) {
    print('  BoxFit.${fit.name}: index=${fit.index}');
    bfQuickCards.add(Container(
      width: 130.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bfSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: bfPrimary.withValues(alpha: 0.25)),
      ),
      child: Column(children: [
        Container(
          width: 110.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: bfPrimary.withValues(alpha: 0.3)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FittedBox(
              fit: fit,
              child: bfSourcePlaceholder(width: 120.0, height: 60.0),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(fit.name,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: bfDark)),
        SizedBox(height: 2.0),
        Text(bfDescriptions[fit] ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600, height: 1.2)),
      ]),
    ));
  }

  final bfGallerySection = bfCard(Column(children: [
    Text('All 7 BoxFit Values',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Same wide-landscape source in a square container with each fit',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: bfQuickCards,
    ),
  ]));

  // ============================================================
  // SECTION 3: Aspect Ratio Behavior Table
  // ============================================================
  print('=== Section 3: Behavior Table ===');

  final bfBehaviorData = [
    {'fit': 'fill', 'preserves': 'No', 'clips': 'No', 'stretches': 'Yes',
      'letterbox': 'No'},
    {'fit': 'contain', 'preserves': 'Yes', 'clips': 'No', 'stretches': 'No',
      'letterbox': 'Yes'},
    {'fit': 'cover', 'preserves': 'Yes', 'clips': 'Yes', 'stretches': 'No',
      'letterbox': 'No'},
    {'fit': 'fitWidth', 'preserves': 'Yes', 'clips': 'Maybe', 'stretches': 'No',
      'letterbox': 'Maybe'},
    {'fit': 'fitHeight', 'preserves': 'Yes', 'clips': 'Maybe', 'stretches': 'No',
      'letterbox': 'Maybe'},
    {'fit': 'none', 'preserves': 'Yes', 'clips': 'Maybe', 'stretches': 'No',
      'letterbox': 'Maybe'},
    {'fit': 'scaleDown', 'preserves': 'Yes', 'clips': 'No', 'stretches': 'No',
      'letterbox': 'Yes'},
  ];

  final bfTableRows = <TableRow>[
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('BoxFit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Preserves\nRatio',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('May\nClip',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('May\nStretch',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('May\nLetterbox',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: bfDark))),
    ]),
  ];
  for (var i = 0; i < bfBehaviorData.length; i++) {
    final b = bfBehaviorData[i];
    bfTableRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : bfSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(b['fit']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bfPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(b['preserves']!,
            style: TextStyle(fontSize: 11.0,
                color: b['preserves'] == 'Yes' ? bfFit : bfClip))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(b['clips']!,
            style: TextStyle(fontSize: 11.0,
                color: b['clips'] == 'Yes' ? bfClip : b['clips'] == 'No' ? bfFit : bfPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(b['stretches']!,
            style: TextStyle(fontSize: 11.0,
                color: b['stretches'] == 'Yes' ? bfClip : bfFit))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(b['letterbox']!,
            style: TextStyle(fontSize: 11.0,
                color: b['letterbox'] == 'Yes' ? bfPrimary : bfFit))),
      ],
    ));
  }

  final bfBehaviorTable = bfCard(Column(children: [
    Text('Behavior Comparison',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: bfPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(80.0),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
      },
      children: bfTableRows,
    ),
  ]));

  // ============================================================
  // SECTION 4: FittedBox — Landscape Source in Square Container
  // ============================================================
  print('=== Section 4: FittedBox with Wide Source ===');

  Widget bfFittedSample(BoxFit fit, double containerW, double containerH,
      double srcW, double srcH) {
    return Container(
      width: containerW + 20.0,
      margin: EdgeInsets.all(4.0),
      child: Column(children: [
        Container(
          width: containerW,
          height: containerH,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: bfDark.withValues(alpha: 0.3), width: 1.5),
          ),
          child: ClipRect(
            child: FittedBox(
              fit: fit,
              child: bfSourcePlaceholder(width: srcW, height: srcH),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(fit.name,
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.bold, color: bfDark)),
      ]),
    );
  }

  final bfFittedLandscape = bfCard(Column(children: [
    Text('FittedBox: Wide Source in Square Box',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Source 120×60 in a 90×90 container — observe scaling behavior',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 8.0,
      children: BoxFit.values
          .map((f) => bfFittedSample(f, 90.0, 90.0, 120.0, 60.0))
          .toList(),
    ),
  ]));

  // ============================================================
  // SECTION 5: FittedBox — Tall Source in Wide Container
  // ============================================================
  print('=== Section 5: FittedBox with Tall Source ===');

  final bfFittedPortrait = bfCard(Column(children: [
    Text('FittedBox: Tall Source in Wide Box',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Source 50×100 in a 120×70 container — portrait in landscape frame',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 8.0,
      children: BoxFit.values
          .map((f) => bfFittedSample(f, 120.0, 70.0, 50.0, 100.0))
          .toList(),
    ),
  ]));

  // ============================================================
  // SECTION 6: fill vs contain vs cover — The Big Three
  // ============================================================
  print('=== Section 6: Fill vs Contain vs Cover ===');

  Widget bfBigThreeCard(BoxFit fit, String subtitle, Color accent) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          Text(fit.name,
              style: TextStyle(
                  fontSize: 14.0, fontWeight: FontWeight.bold, color: accent)),
          SizedBox(height: 4.0),
          Container(
            width: 100.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: accent),
            ),
            child: ClipRect(
              child: FittedBox(
                fit: fit,
                child: bfSourcePlaceholder(width: 120.0, height: 60.0),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
    );
  }

  final bfBigThree = bfCard(Column(children: [
    Text('The Big Three: fill vs contain vs cover',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('The three most commonly used BoxFit values',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bfBigThreeCard(BoxFit.fill,
            'Stretches to fill.\nDistorts if sizes\ndon\'t match.',
            Color(0xFFE65100)),
        SizedBox(width: 8.0),
        bfBigThreeCard(BoxFit.contain,
            'Fits inside box.\nMay have empty\nspace (letterbox).',
            Color(0xFF1565C0)),
        SizedBox(width: 8.0),
        bfBigThreeCard(BoxFit.cover,
            'Covers all space.\nMay clip edges\noff the source.',
            Color(0xFF2E7D32)),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 7: scaleDown vs none
  // ============================================================
  print('=== Section 7: scaleDown vs none ===');

  final bfScaleDownSection = bfCard(Column(children: [
    Text('scaleDown vs none',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Both center the source, but scaleDown will shrink if needed; '
        'none never changes size',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Text('BoxFit.none',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: bfDark)),
          SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: bfDark.withValues(alpha: 0.3)),
            ),
            child: ClipRect(
              child: FittedBox(
                fit: BoxFit.none,
                child: bfSourcePlaceholder(width: 200.0, height: 100.0),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('Large source overflows\n(clipped by ClipRect)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Column(children: [
          Text('BoxFit.scaleDown',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: bfDark)),
          SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: bfDark.withValues(alpha: 0.3)),
            ),
            child: ClipRect(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: bfSourcePlaceholder(width: 200.0, height: 100.0),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('Large source shrinks\nto fit (like contain)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
    ]),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Text('Small source (none)',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bfDark)),
          SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: bfDark.withValues(alpha: 0.3)),
            ),
            child: FittedBox(
              fit: BoxFit.none,
              child: bfSourcePlaceholder(width: 40.0, height: 20.0),
            ),
          ),
          Text('Stays small, centered',
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Column(children: [
          Text('Small source (scaleDown)',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bfDark)),
          SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: bfDark.withValues(alpha: 0.3)),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: bfSourcePlaceholder(width: 40.0, height: 20.0),
            ),
          ),
          Text('Also stays small, same',
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 8: fitWidth vs fitHeight
  // ============================================================
  print('=== Section 8: fitWidth vs fitHeight ===');

  final bfDimensionSection = bfCard(Column(children: [
    Text('fitWidth vs fitHeight',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Each locks one dimension and lets the other vary freely',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: bfPrimary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: bfPrimary.withValues(alpha: 0.25)),
            ),
            child: Column(children: [
              Text('BoxFit.fitWidth',
                  style: TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold, color: bfPrimary)),
              SizedBox(height: 6.0),
              Container(
                width: 120.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: bfPrimary),
                ),
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: bfSourcePlaceholder(width: 120.0, height: 60.0),
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text('Width matches container.\n'
                  'Height may overflow or underflow.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
            ]),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: bfAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: bfAccent.withValues(alpha: 0.3)),
            ),
            child: Column(children: [
              Text('BoxFit.fitHeight',
                  style: TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold, color: bfPrimary)),
              SizedBox(height: 6.0),
              Container(
                width: 120.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: bfAccent),
                ),
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: bfSourcePlaceholder(width: 120.0, height: 60.0),
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text('Height matches container.\n'
                  'Width may overflow or underflow.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
            ]),
          ),
        ),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 9: Real-World Use Cases
  // ============================================================
  print('=== Section 9: Use Cases ===');

  Widget bfUseCaseBlock(String name, BoxFit fit, Color color,
      String explanation, IconData icon) {
    return Container(
      width: 150.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Icon(icon, color: color, size: 24.0),
        SizedBox(height: 4.0),
        Text(name,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 2.0),
        bfBadge(fit.name, color),
        SizedBox(height: 6.0),
        Text(explanation,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
      ]),
    );
  }

  final bfUseCaseSection = bfCard(Column(children: [
    Text('Real-World Use Cases',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        bfUseCaseBlock('Profile Avatar', BoxFit.cover,
            Color(0xFF6A1B9A),
            'Fills circular frame.\nClips edges, never letterboxes.', Icons.account_circle),
        bfUseCaseBlock('App Logo', BoxFit.contain,
            Color(0xFF00695C),
            'Fits inside space.\nNever distorts the logo.', Icons.branding_watermark),
        bfUseCaseBlock('Background', BoxFit.cover,
            Color(0xFF1565C0),
            'Covers full screen.\nMay crop edges off.', Icons.wallpaper),
        bfUseCaseBlock('Product Photo', BoxFit.contain,
            Color(0xFFE65100),
            'Show full product.\nLetterbox is acceptable.', Icons.shopping_bag),
        bfUseCaseBlock('Thumbnail', BoxFit.cover,
            Color(0xFF2E7D32),
            'Uniform grid cards.\nConsistent size, may crop.', Icons.grid_view),
        bfUseCaseBlock('Icon Badge', BoxFit.scaleDown,
            Color(0xFF546E7A),
            'Never enlarge small icons.\nShrink if too large.', Icons.badge),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 10: Widgets That Use BoxFit
  // ============================================================
  print('=== Section 10: Widgets ===');

  final bfWidgetData = [
    {'widget': 'Image', 'prop': 'fit', 'note': 'Primary consumer — controls image scaling'},
    {'widget': 'FittedBox', 'prop': 'fit', 'note': 'Scales any child widget, not just images'},
    {'widget': 'DecorationImage', 'prop': 'fit', 'note': 'Background/foreground images in BoxDecoration'},
    {'widget': 'Ink.image', 'prop': 'fit', 'note': 'Material ripple over an image'},
    {'widget': 'FadeInImage', 'prop': 'fit', 'note': 'Crossfade placeholder → final with same fit'},
    {'widget': 'ExactAssetImage', 'prop': 'Used with fit', 'note': 'Provides image at exact scale'},
  ];

  final bfWidgetRows = <TableRow>[
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('Widget',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Property',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bfDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bfDark))),
    ]),
  ];
  for (var i = 0; i < bfWidgetData.length; i++) {
    final w = bfWidgetData[i];
    bfWidgetRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : bfSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['widget']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bfPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['prop']!,
            style: TextStyle(fontSize: 11.0))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['note']!,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600))),
      ],
    ));
  }

  final bfWidgetTable = bfCard(Column(children: [
    Text('Widgets Using BoxFit',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: bfPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(110.0),
        1: FixedColumnWidth(100.0),
        2: FlexColumnWidth(),
      },
      children: bfWidgetRows,
    ),
  ]));

  // ============================================================
  // SECTION 11: Clipping Indicator
  // ============================================================
  print('=== Section 11: Clip Indicator ===');

  Widget bfClipIndicator(BoxFit fit) {
    final clips = fit == BoxFit.cover ||
        fit == BoxFit.fitWidth ||
        fit == BoxFit.fitHeight ||
        fit == BoxFit.none;
    final c = clips ? bfClip : bfFit;
    return Container(
      width: 80.0,
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Icon(clips ? Icons.content_cut : Icons.check,
            color: c, size: 20.0),
        SizedBox(height: 4.0),
        Text(fit.name,
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.bold, color: c)),
        Text(clips ? 'may clip' : 'safe',
            style: TextStyle(fontSize: 9.0, color: c)),
      ]),
    );
  }

  final bfClipSection = bfCard(Column(children: [
    Text('Clipping Risk',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('Which modes may clip source content outside the container',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: BoxFit.values.map((f) => bfClipIndicator(f)).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 12: Container with DecorationImage
  // ============================================================
  print('=== Section 12: DecorationImage Pattern ===');

  final bfDecoSection = bfCard(Column(children: [
    Text('DecorationImage Pattern',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('BoxDecoration.image uses BoxFit to position a background image',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bfSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Container(\n'
            '  decoration: BoxDecoration(\n'
            '    image: DecorationImage(\n'
            '      image: AssetImage("bg.png"),\n'
            '      fit: BoxFit.cover,  // ← here\n'
            '    ),\n'
            '  ),\n'
            ')',
            style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: bfDark, height: 1.4)),
      ]),
    ),
    SizedBox(height: 10.0),
    bfInfoRow('fit: cover', 'Best for full-bleed backgrounds'),
    bfInfoRow('fit: contain', 'For centered watermarks'),
    bfInfoRow('fit: fill', 'When distortion is acceptable'),
  ]));

  // ============================================================
  // SECTION 13: Enum Equality & Properties
  // ============================================================
  print('=== Section 13: Equality ===');

  final bfEq1 = BoxFit.fill == BoxFit.fill;
  final bfEq2 = BoxFit.fill == BoxFit.contain;
  print('  fill == fill: $bfEq1');
  print('  fill == contain: $bfEq2');

  final bfEqualitySection = bfCard(Column(children: [
    Text('Enum Equality & Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 10.0),
    bfInfoRow('fill == fill', '$bfEq1', valueColor: Colors.teal.shade700),
    bfInfoRow('fill == contain', '$bfEq2', valueColor: Colors.red.shade700),
    bfInfoRow('values.length', '${BoxFit.values.length}'),
    Divider(color: bfPrimary.withValues(alpha: 0.15)),
    ...BoxFit.values.map((f) => bfInfoRow('${f.name}.index', '${f.index}')),
  ]));

  // ============================================================
  // SECTION 14: Decision Flowchart
  // ============================================================
  print('=== Section 14: Decision Flowchart ===');

  Widget bfFlowStep(String question, String yes, BoxFit? yesFit,
      String no, {Color? color}) {
    final c = color ?? bfPrimary;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(question,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 4.0),
        Row(children: [
          Icon(Icons.check, size: 14.0, color: bfFit),
          SizedBox(width: 4.0),
          Expanded(
            child: Text('Yes → $yes${yesFit != null ? " (${yesFit.name})" : ""}',
                style: TextStyle(fontSize: 11.0, color: bfFit)),
          ),
        ]),
        Row(children: [
          Icon(Icons.close, size: 14.0, color: bfClip),
          SizedBox(width: 4.0),
          Expanded(
            child: Text('No → $no',
                style: TextStyle(fontSize: 11.0, color: bfClip)),
          ),
        ]),
      ]),
    );
  }

  final bfFlowSection = bfCard(Column(children: [
    Text('Choosing the Right BoxFit',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 10.0),
    bfFlowStep('Must the box be fully covered with no gaps?',
        'Use', BoxFit.cover, 'Continue…'),
    bfFlowStep('Must the full source be visible?',
        'Use', BoxFit.contain, 'Continue…'),
    bfFlowStep('Is distortion acceptable?',
        'Use', BoxFit.fill, 'Continue…'),
    bfFlowStep('Should it never scale up?',
        'Use', BoxFit.scaleDown, 'Use fitWidth / fitHeight'),
  ]));

  // ============================================================
  // SECTION 15: Alignment Interaction
  // ============================================================
  print('=== Section 15: Alignment Interaction ===');

  final bfAlignSection = bfCard(Column(children: [
    Text('Alignment + BoxFit',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bfDark)),
    SizedBox(height: 4.0),
    Text('FittedBox.alignment controls where the scaled child sits inside the box',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.0,
      runSpacing: 6.0,
      children: [
        {'align': Alignment.topLeft, 'label': 'topLeft'},
        {'align': Alignment.center, 'label': 'center'},
        {'align': Alignment.bottomRight, 'label': 'bottomRight'},
      ].map((entry) {
        final align = entry['align'] as Alignment;
        final label = entry['label'] as String;
        return SizedBox(
          width: 100.0,
          child: Column(children: [
            Container(
              width: 90.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: bfPrimary),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: align,
                child: bfSourcePlaceholder(width: 120.0, height: 60.0),
              ),
            ),
            SizedBox(height: 4.0),
            Text(label,
                style: TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.w600, color: bfDark)),
          ]),
        );
      }).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  final bfSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [bfDark, bfPrimary]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('BoxFit — Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 12.0),
      Row(children: [
        Expanded(child: Column(children: [
          Text('7', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('values', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('3', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('may clip', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('1', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('may distort', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('6+', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('widgets', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
      ]),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'BoxFit is essential for every Flutter app that displays images or '
          'scales widgets. The three most common choices — contain, cover, '
          'and fill — cover 90% of use cases. Understanding clipping vs '
          'letterboxing tradeoffs is the key to choosing correctly.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('BoxFit Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        bfTitleSection,
        SizedBox(height: 16.0),
        // 2 Gallery
        bfSectionHeader('All 7 Values', Icons.view_module),
        bfGallerySection,
        // 3 Behavior
        bfSectionHeader('Behavior Comparison', Icons.table_chart),
        bfBehaviorTable,
        // 4 Fitted Landscape
        bfSectionHeader('Wide Source in Square', Icons.crop_landscape),
        bfFittedLandscape,
        // 5 Fitted Portrait
        bfSectionHeader('Tall Source in Wide Box', Icons.crop_portrait),
        bfFittedPortrait,
        // 6 Big Three
        bfSectionHeader('Fill vs Contain vs Cover', Icons.compare),
        bfBigThree,
        // 7 scaleDown vs none
        bfSectionHeader('scaleDown vs none', Icons.zoom_out),
        bfScaleDownSection,
        // 8 fitWidth/Height
        bfSectionHeader('fitWidth vs fitHeight', Icons.straighten),
        bfDimensionSection,
        // 9 Use Cases
        bfSectionHeader('Real-World Use Cases', Icons.auto_awesome),
        bfUseCaseSection,
        // 10 Widgets
        bfSectionHeader('Widgets Using BoxFit', Icons.widgets),
        bfWidgetTable,
        // 11 Clipping
        bfSectionHeader('Clipping Risk', Icons.content_cut),
        bfClipSection,
        // 12 Deco
        bfSectionHeader('DecorationImage Pattern', Icons.image),
        bfDecoSection,
        // 13 Equality
        bfSectionHeader('Equality & Properties', Icons.check_circle_outline),
        bfEqualitySection,
        // 14 Flow
        bfSectionHeader('Decision Flowchart', Icons.account_tree),
        bfFlowSection,
        // 15 Alignment
        bfSectionHeader('Alignment Interaction', Icons.format_align_center),
        bfAlignSection,
        // 16 Summary
        SizedBox(height: 8.0),
        bfSummarySection,
      ],
    ),
  );
}
