// ignore_for_file: avoid_print
// D4rt deep demo: MagnifierInfo — positioning geometry for the text magnifier
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Topaz / Citrine ───────────────────────────────────────
  const deepTopaz = Color(0xFF451A03);
  const burnishedAmber = Color(0xFF78350F);
  const warmTopaz = Color(0xFFB45309);
  const citrine = Color(0xFFD97706);
  const goldenYellow = Color(0xFFF59E0B);
  const paleHoney = Color(0xFFFDE68A);
  const creamWhite = Color(0xFFFFFBEB);
  const richBrown = Color(0xFF92400E);
  const tealContrast = Color(0xFF0D9488);
  const roseContrast = Color(0xFFE11D48);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: deepTopaz)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepTopaz)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Create sample data ─────────────────────────────────────────────
  print('MagnifierInfo deep demo executing');
  print('=' * 60);

  final info = MagnifierInfo(
    globalGesturePosition: const Offset(150.0, 320.0),
    caretRect: const Rect.fromLTWH(148.0, 310.0, 2.0, 20.0),
    fieldBounds: const Rect.fromLTWH(20.0, 280.0, 340.0, 80.0),
    currentLineBoundaries: const Rect.fromLTWH(20.0, 310.0, 340.0, 20.0),
  );

  final emptyInfo = MagnifierInfo.empty;

  final altInfo = MagnifierInfo(
    globalGesturePosition: const Offset(250.0, 450.0),
    caretRect: const Rect.fromLTWH(245.0, 440.0, 2.0, 22.0),
    fieldBounds: const Rect.fromLTWH(30.0, 400.0, 320.0, 100.0),
    currentLineBoundaries: const Rect.fromLTWH(30.0, 440.0, 320.0, 22.0),
  );

  // Section 1
  print('\n--- What is MagnifierInfo ---');
  print('Data class with positioning geometry for magnifier');
  print('4 properties: globalGesturePosition, caretRect, fieldBounds, currentLineBoundaries');

  // Section 2
  print('\n--- Properties ---');
  print('globalGesturePosition: ${info.globalGesturePosition}');
  print('caretRect: ${info.caretRect}');
  print('fieldBounds: ${info.fieldBounds}');
  print('currentLineBoundaries: ${info.currentLineBoundaries}');

  // Section 3
  print('\n--- Empty constant ---');
  print('MagnifierInfo.empty: $emptyInfo');
  print('empty gesture: ${emptyInfo.globalGesturePosition}');

  // Section 4
  print('\n--- Equality ---');
  final infoCopy = MagnifierInfo(
    globalGesturePosition: const Offset(150.0, 320.0),
    caretRect: const Rect.fromLTWH(148.0, 310.0, 2.0, 20.0),
    fieldBounds: const Rect.fromLTWH(20.0, 280.0, 340.0, 80.0),
    currentLineBoundaries: const Rect.fromLTWH(20.0, 310.0, 340.0, 20.0),
  );
  print('info == infoCopy: ${info == infoCopy}');
  print('info == altInfo: ${info == altInfo}');
  print('info == emptyInfo: ${info == emptyInfo}');

  print('\n${'=' * 60}');
  print('MagnifierInfo deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepTopaz, burnishedAmber, warmTopaz],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.zoom_in_map, size: 28, color: paleHoney),
                  const SizedBox(width: 10),
                  const Text('MagnifierInfo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Positioning geometry for the text selection magnifier',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Data Class', warmTopaz, Colors.white),
                tag('4 Properties', citrine, Colors.white),
                tag('Immutable', paleHoney, deepTopaz),
                tag('Value Equality', goldenYellow, deepTopaz),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MagnifierInfo',
            'Geometry data for magnifier positioning',
            deepTopaz, Colors.white),
        noteBox(
          'MagnifierInfo is an immutable data class that carries positioning '
          'geometry needed to render a text selection magnifier. It includes '
          'the user\'s finger position, the text caret rectangle, the '
          'text field bounds, and the current line boundaries. These four '
          'pieces of geometry let the magnifier know where to position '
          'itself and what to magnify.',
          citrine,
          creamWhite,
        ),
        dataRow('Type', 'class (immutable data)', warmTopaz),
        dataRow('Constructor', 'const MagnifierInfo({...})', citrine),
        dataRow('Static', 'MagnifierInfo.empty (all zero)', burnishedAmber),
        dataRow('Equality', 'Custom == (value-based)', deepTopaz),
        const SizedBox(height: 14),

        // ── 3. The four properties ───────────────────────────────────
        sectionBanner('2 \u00b7 The Four Properties',
            'Each property describes a piece of positioning geometry',
            burnishedAmber, Colors.white),
        for (final prop in [
          ('globalGesturePosition', 'Offset',
              'User\'s finger/pointer position in global coordinates',
              'Where the user is touching — the magnifier tracks this point',
              info.globalGesturePosition.toString(),
              Icons.touch_app, citrine),
          ('caretRect', 'Rect',
              'Rectangle of the text cursor/caret',
              'Thin rectangle at the insertion point — 2px wide, line-height tall',
              info.caretRect.toString(),
              Icons.text_fields, warmTopaz),
          ('fieldBounds', 'Rect',
              'Bounds of the entire text field',
              'The outer rectangle of the TextField — magnifier stays within these bounds',
              info.fieldBounds.toString(),
              Icons.crop_square, burnishedAmber),
          ('currentLineBoundaries', 'Rect',
              'Bounds of the current text line',
              'First to last character of the line — without field padding',
              info.currentLineBoundaries.toString(),
              Icons.format_align_left, deepTopaz),
        ])
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: creamWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  left: BorderSide(color: prop.$7, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: prop.$7.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(prop.$6, size: 22, color: prop.$7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(prop.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: deepTopaz)),
                          const SizedBox(width: 6),
                          tag(prop.$2, prop.$7.withValues(alpha: 0.12),
                              prop.$7),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(prop.$3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: richBrown)),
                      Text(prop.$4,
                          style: TextStyle(
                              fontSize: 11,
                              color: deepTopaz.withValues(alpha: 0.7))),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: prop.$7.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(prop.$5,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: prop.$7)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),

        // ── 4. Visual coordinate diagram ─────────────────────────────
        sectionBanner('3 \u00b7 Coordinate Diagram',
            'Visual layout of how the four rects relate to each other',
            warmTopaz, Colors.white),
        Container(
          width: double.infinity,
          height: 220,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleHoney),
          ),
          child: Stack(
            children: [
              // fieldBounds — the whole text field
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 300,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: burnishedAmber, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: burnishedAmber.withValues(alpha: 0.06),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('fieldBounds',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: burnishedAmber)),
                    ),
                  ),
                ),
              ),
              // currentLineBoundaries — one line of text
              Positioned(
                left: 20,
                top: 70,
                child: Container(
                  width: 280,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: deepTopaz, width: 1.5),
                    color: deepTopaz.withValues(alpha: 0.08),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text('currentLineBoundaries',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: deepTopaz)),
                  ),
                ),
              ),
              // caretRect — the cursor
              Positioned(
                left: 140,
                top: 65,
                child: Container(
                  width: 3,
                  height: 34,
                  decoration: BoxDecoration(
                    color: warmTopaz,
                    borderRadius: BorderRadius.circular(1),
                    boxShadow: [
                      BoxShadow(
                        color: warmTopaz.withValues(alpha: 0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // caretRect label
              Positioned(
                left: 148,
                top: 60,
                child: Text('caretRect',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: warmTopaz)),
              ),
              // globalGesturePosition — the finger
              Positioned(
                left: 132,
                top: 38,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: citrine.withValues(alpha: 0.3),
                    border: Border.all(color: citrine, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.touch_app, size: 12, color: citrine),
                ),
              ),
              // gesture label
              Positioned(
                left: 155,
                top: 38,
                child: Text('gesture pos',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: citrine)),
              ),
              // Sample text lines
              Positioned(
                left: 25,
                top: 35,
                child: Text('The quick brown fox jumps',
                    style: TextStyle(
                        fontSize: 11,
                        color: deepTopaz.withValues(alpha: 0.5))),
              ),
              Positioned(
                left: 25,
                top: 73,
                child: Text('over the lazy dog today',
                    style: TextStyle(fontSize: 11, color: deepTopaz)),
              ),
              Positioned(
                left: 25,
                top: 100,
                child: Text('and ran through the field',
                    style: TextStyle(
                        fontSize: 11,
                        color: deepTopaz.withValues(alpha: 0.5))),
              ),
              // Legend
              Positioned(
                left: 10,
                bottom: 0,
                child: Row(
                  children: [
                    Container(width: 10, height: 3, color: burnishedAmber),
                    Text(' field  ', style: TextStyle(fontSize: 8, color: burnishedAmber)),
                    Container(width: 10, height: 3, color: deepTopaz),
                    Text(' line  ', style: TextStyle(fontSize: 8, color: deepTopaz)),
                    Container(width: 3, height: 10, color: warmTopaz),
                    Text(' caret  ', style: TextStyle(fontSize: 8, color: warmTopaz)),
                    Icon(Icons.touch_app, size: 10, color: citrine),
                    Text(' gesture', style: TextStyle(fontSize: 8, color: citrine)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. MagnifierInfo.empty ───────────────────────────────────
        sectionBanner('4 \u00b7 MagnifierInfo.empty',
            'The zero-valued constant',
            citrine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('static const MagnifierInfo.empty',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'monospace',
                      color: citrine)),
              const SizedBox(height: 8),
              for (final field in [
                ('globalGesturePosition', '${emptyInfo.globalGesturePosition}'),
                ('caretRect', '${emptyInfo.caretRect}'),
                ('fieldBounds', '${emptyInfo.fieldBounds}'),
                ('currentLineBoundaries', '${emptyInfo.currentLineBoundaries}'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(field.$1,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: warmTopaz)),
                      ),
                      Expanded(
                        child: Text(field.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: deepTopaz)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              noteBox(
                'MagnifierInfo.empty is used as an initial value or placeholder '
                'when no gesture data is available yet. All positions and rects '
                'are set to zero/Offset.zero/Rect.zero.',
                citrine,
                paleHoney.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Comparison of two instances ───────────────────────────
        sectionBanner('5 \u00b7 Comparing Instances',
            'Side-by-side view of two different MagnifierInfo objects',
            burnishedAmber, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepTopaz),
                children: [
                  for (final h in ['Property', 'info A', 'info B'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('gesturePosition',
                    '${info.globalGesturePosition}',
                    '${altInfo.globalGesturePosition}'),
                ('caretRect',
                    'LTWH(148, 310, 2, 20)',
                    'LTWH(245, 440, 2, 22)'),
                ('fieldBounds',
                    'LTWH(20, 280, 340, 80)',
                    'LTWH(30, 400, 320, 100)'),
                ('lineBoundaries',
                    'LTWH(20, 310, 340, 20)',
                    'LTWH(30, 440, 320, 22)'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: warmTopaz)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 9,
                              fontFamily: 'monospace',
                              color: citrine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 9,
                              fontFamily: 'monospace',
                              color: tealContrast)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Equality and hashCode ─────────────────────────────────
        sectionBanner('6 \u00b7 Value Equality',
            'MagnifierInfo uses custom == based on all four properties',
            deepTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final test in [
                ('info == infoCopy', info == infoCopy, 'Same values, different objects'),
                ('info == altInfo', info == altInfo, 'Different values'),
                ('info == emptyInfo', info == emptyInfo, 'Real vs empty'),
                ('emptyInfo == MagnifierInfo.empty', emptyInfo == MagnifierInfo.empty,
                    'Same static constant'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        test.$2 ? Icons.check_circle : Icons.cancel,
                        size: 18,
                        color: test.$2 ? tealContrast : roseContrast,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(test.$1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.w600,
                                    color: deepTopaz)),
                            Text('${test.$2} — ${test.$3}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: deepTopaz.withValues(alpha: 0.7))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepTopaz.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('hashCode values:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: warmTopaz)),
                    const SizedBox(height: 4),
                    for (final entry in [
                      ('info', info.hashCode),
                      ('infoCopy', infoCopy.hashCode),
                      ('altInfo', altInfo.hashCode),
                      ('empty', emptyInfo.hashCode),
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(entry.$1,
                                  style: TextStyle(
                                      fontSize: 11, color: deepTopaz)),
                            ),
                            Text('${entry.$2}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: citrine)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Magnifier pipeline ────────────────────────────────────
        sectionBanner('7 \u00b7 Magnifier Pipeline',
            'How MagnifierInfo flows through the magnifier system',
            warmTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'User drags selection handle', 'GestureDetector captures drag position',
                    citrine),
                (2, 'EditableText builds MagnifierInfo', 'Creates info from gesture + caret + field geometry',
                    warmTopaz),
                (3, 'ValueNotifier<MagnifierInfo> updated', 'Notifies listeners of new position data',
                    burnishedAmber),
                (4, 'Magnifier widget rebuilds', 'ValueListenableBuilder reads updated info',
                    richBrown),
                (5, 'RawMagnifier repositions', 'Positions the lens using globalGesturePosition',
                    deepTopaz),
                (6, 'Focal point clamped', 'fieldBounds ensures magnifier stays within field area',
                    tealContrast),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepTopaz)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: richBrown)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Simulated text field with magnifier zone ──────────────
        sectionBanner('8 \u00b7 Simulated Text Field Zones',
            'Where each MagnifierInfo rect maps to',
            citrine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleHoney),
          ),
          child: Column(
            children: [
              // Outer bounds = fieldBounds
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: burnishedAmber, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: burnishedAmber.withValues(alpha: 0.04),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('fieldBounds',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: burnishedAmber)),
                    const SizedBox(height: 6),
                    Text('First line of text in the field',
                        style: TextStyle(
                            fontSize: 12,
                            color: deepTopaz.withValues(alpha: 0.5))),
                    const SizedBox(height: 2),
                    // currentLineBoundaries + caretRect
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: deepTopaz.withValues(alpha: 0.06),
                        border: Border.all(color: deepTopaz, width: 1),
                      ),
                      child: Row(
                        children: [
                          Text('The cursor is ',
                              style: TextStyle(fontSize: 12, color: deepTopaz)),
                          Container(
                            width: 2,
                            height: 16,
                            color: warmTopaz,
                          ),
                          Text('here in the text',
                              style: TextStyle(fontSize: 12, color: deepTopaz)),
                        ],
                      ),
                    ),
                    Text('  \u2191 currentLineBoundaries',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: deepTopaz)),
                    const SizedBox(height: 2),
                    Text('Third line of text in the field',
                        style: TextStyle(
                            fontSize: 12,
                            color: deepTopaz.withValues(alpha: 0.5))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final zone in [
                    ('fieldBounds', 'Entire field', burnishedAmber),
                    ('lineBounds', 'Current line', deepTopaz),
                    ('caretRect', 'Cursor', warmTopaz),
                  ])
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: zone.$3.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Text(zone.$1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    color: zone.$3)),
                            Text(zone.$2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9, color: deepTopaz)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. toString output ──────────────────────────────────────
        sectionBanner('9 \u00b7 toString Representation',
            'Debug output for each instance',
            richBrown, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in [
                ('info', info.toString()),
                ('altInfo', altInfo.toString()),
                ('empty', emptyInfo.toString()),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: deepTopaz.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: warmTopaz)),
                      const SizedBox(height: 2),
                      Text(entry.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: deepTopaz)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Platform magnifier differences ───────────────────────
        sectionBanner('10 \u00b7 Platform Usage of MagnifierInfo',
            'How iOS and Android consume position data differently',
            burnishedAmber, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepTopaz),
                children: [
                  for (final h in ['Property', 'iOS (Cupertino)', 'Android (Material)'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('gesturePosition', 'Positions loupe above finger', 'Centers magnifier on gesture'),
                ('caretRect', 'Focal point for loupe lens', 'Focal point for lens'),
                ('fieldBounds', 'Clamps vertical position', 'Hides magnifier at boundaries'),
                ('lineBoundaries', 'Horizontal loupe bounds', 'Horizontal lens bounds'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: warmTopaz)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: citrine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: tealContrast)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Constructor parameters ───────────────────────────────
        sectionBanner('11 \u00b7 Constructor Parameters',
            'All four required named parameters',
            warmTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final param in [
                ('globalGesturePosition:', 'Offset', 'required', citrine),
                ('caretRect:', 'Rect', 'required', warmTopaz),
                ('fieldBounds:', 'Rect', 'required', burnishedAmber),
                ('currentLineBoundaries:', 'Rect', 'required', deepTopaz),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: param.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(param.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: param.$4)),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(param.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: richBrown)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: roseContrast.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(param.$3,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: roseContrast)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Relationship diagram ─────────────────────────────────
        sectionBanner('12 \u00b7 Relationship to Magnifier System',
            'How MagnifierInfo connects to other magnifier classes',
            deepTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final connection in [
                ('EditableText', '\u2192', 'Creates MagnifierInfo from text state', citrine),
                ('ValueNotifier', '\u2192', 'Wraps MagnifierInfo for reactive updates', warmTopaz),
                ('MagnifierController', '\u2192', 'Controls overlay based on info changes', burnishedAmber),
                ('RawMagnifier', '\u2192', 'Positions itself using info geometry', richBrown),
                ('CupertinoMagnifier', '\u2192', 'iOS-style loupe from info', deepTopaz),
                ('TextMagnifier', '\u2192', 'Android-style lens from info', tealContrast),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: connection.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(connection.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: connection.$4)),
                      ),
                      Text(connection.$2,
                          style: TextStyle(
                              fontSize: 14, color: deepTopaz)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(connection.$3,
                            style: TextStyle(
                                fontSize: 11, color: richBrown)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Immutability note ────────────────────────────────────
        sectionBanner('13 \u00b7 Immutability',
            'MagnifierInfo is fully immutable',
            citrine, Colors.white),
        noteBox(
          'All four properties are final fields set in the const constructor. '
          'To update magnifier position, a NEW MagnifierInfo instance is '
          'created each time the gesture position changes. This is efficient '
          'because the magnifier system uses ValueNotifier<MagnifierInfo> — '
          'only the reference changes, and equality checks prevent unnecessary '
          'rebuilds when the values haven\'t actually changed.',
          citrine,
          creamWhite,
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance ──────────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Where MagnifierInfo sits', deepTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 MagnifierInfo', 1, warmTopaz),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 12.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
              const SizedBox(height: 6),
              Text('Plain Dart class — no mixins, no extends, no implements',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: richBrown)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepTopaz, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepTopaz, burnishedAmber],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Immutable data class holding 4 geometry properties for magnifier',
                'globalGesturePosition — user finger location in global coords',
                'caretRect — text cursor rectangle (thin, tall)',
                'fieldBounds — entire text field bounds for clamping',
                'currentLineBoundaries — current text line bounds',
                'MagnifierInfo.empty — zero-valued constant for initial state',
                'Value equality: == compares all 4 properties',
                'hashCode uses Object.hash across all 4 properties',
                'Created by EditableText, consumed by RawMagnifier/platform magnifiers',
                'Wrapped in ValueNotifier for reactive updates on gesture changes',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: goldenYellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
