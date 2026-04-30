// ignore_for_file: avoid_print
// D4rt deep demo: OverflowBarAlignment — overflow alignment for OverflowBar
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Plum / Mauve ──────────────────────────────────────────
  const deepPlum = Color(0xFF4A148C);
  const plum = Color(0xFF6A1B9A);
  const mauve = Color(0xFF7B1FA2);
  const softPlum = Color(0xFF9C27B0);
  const lightMauve = Color(0xFFCE93D8);
  const palePlum = Color(0xFFF3E5F5);
  const whiteMauve = Color(0xFFFCF5FF);
  const darkGrape = Color(0xFF12005E);
  const accentAmber = Color(0xFFFF8F00);
  const accentTeal = Color(0xFF00695C);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionHeader(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.75)],
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

  Widget infoBox(String text, Color border, Color bg) {
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
          style: TextStyle(fontSize: 13, color: darkGrape)),
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // Builds an OverflowBar demo within a narrow container
  Widget overflowDemo(String label, OverflowBarAlignment alignment,
      Color accent, double containerWidth) {
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: accent)),
          const SizedBox(height: 6),
          OverflowBar(
            spacing: 6,
            overflowSpacing: 4,
            overflowAlignment: alignment,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  textStyle: const TextStyle(fontSize: 10),
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent.withValues(alpha: 0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  textStyle: const TextStyle(fontSize: 10),
                ),
                child: const Text('Save Draft'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent.withValues(alpha: 0.4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  textStyle: const TextStyle(fontSize: 10),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('OverflowBarAlignment deep demo executing');
  print('=' * 60);

  print('\n--- What is OverflowBarAlignment ---');
  print('An enum that controls how children align when OverflowBar overflows');
  print('Three values: start, end, center');
  print('Defined in widgets/overflow_bar.dart');

  print('\n--- Enum values ---');
  for (final v in OverflowBarAlignment.values) {
    print('  OverflowBarAlignment.$v  (index=${v.index})');
  }

  print('\n--- Key behaviors ---');
  print('start: left-aligned (LTR), right-aligned (RTL)');
  print('end: right-aligned (LTR), left-aligned (RTL)');
  print('center: horizontally centered regardless of TextDirection');
  print('Only applies when OverflowBar overflows into vertical layout');

  print('\n${'=' * 60}');
  print('OverflowBarAlignment deep demo completed');

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
              colors: [deepPlum, plum, mauve],
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
                  Icon(Icons.align_horizontal_left, size: 28,
                      color: lightMauve),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverflowBarAlignment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Controls how children are aligned along the '
                  'cross axis when an OverflowBar overflows from '
                  'horizontal to vertical layout. Used exclusively '
                  'by OverflowBar.overflowAlignment.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('start', plum, Colors.white),
                pill('end', mauve, Colors.white),
                pill('center', softPlum, Colors.white),
                pill('OverflowBar', lightMauve, darkGrape),
              ]),
            ],
          ),
        ),

        // ── 2. The three enum values ─────────────────────────────────
        sectionHeader('1 \u00b7 The Three Enum Values',
            'start, end, and center', deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final val in [
                ('start', 'Left-aligned in LTR, right-aligned in RTL. '
                    'The default value. Children hug the start edge.',
                    Icons.align_horizontal_left, plum),
                ('end', 'Right-aligned in LTR, left-aligned in RTL. '
                    'Children hug the end edge. Common for action buttons.',
                    Icons.align_horizontal_right, mauve),
                ('center', 'Horizontally centered regardless of '
                    'TextDirection. Children are equidistant from edges.',
                    Icons.align_horizontal_center, softPlum),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: val.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: val.$4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(val.$3, size: 22, color: val.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: val.$4)),
                            const SizedBox(height: 2),
                            Text(val.$2,
                                style: TextStyle(
                                    fontSize: 12, color: darkGrape)),
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

        // ── 3. OverflowBar mode diagram ──────────────────────────────
        sectionHeader('2 \u00b7 Normal vs Overflow Mode',
            'When does OverflowBarAlignment matter?',
            plum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Normal mode
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.view_stream, size: 20, color: accentTeal),
                      const SizedBox(height: 4),
                      Text('Normal Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentTeal)),
                      const SizedBox(height: 4),
                      Text('Children fit\nhorizontally',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: accentTeal.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Uses: alignment\n(MainAxisAlignment)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8,
                                fontFamily: 'monospace',
                                color: accentTeal)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.compare_arrows, size: 20, color: lightMauve),
              const SizedBox(width: 8),
              // Overflow mode
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: plum.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: plum),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.view_column, size: 20, color: plum),
                      const SizedBox(height: 4),
                      Text('Overflow Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: plum)),
                      const SizedBox(height: 4),
                      Text('Children do NOT\nfit horizontally',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: plum.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Uses: overflowAlignment\n(OverflowBarAlignment)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8,
                                fontFamily: 'monospace',
                                color: plum)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'OverflowBarAlignment ONLY applies when the OverflowBar has '
          'overflowed into vertical layout. When children fit horizontally, '
          'the alignment property (MainAxisAlignment) is used instead.',
          plum,
          palePlum,
        ),
        const SizedBox(height: 14),

        // ── 4. Live demo: start alignment ────────────────────────────
        sectionHeader('3 \u00b7 Live Demo: Start Alignment',
            'Children aligned to the start edge',
            deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMauve),
          ),
          child: Column(
            children: [
              // Narrow container forces overflow
              overflowDemo('overflowAlignment: start',
                  OverflowBarAlignment.start, plum, 160),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: plum.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.align_horizontal_left,
                        size: 14, color: plum),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          'All buttons align to the left (start) in this '
                          '160px narrow container.',
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Live demo: end alignment ──────────────────────────────
        sectionHeader('4 \u00b7 Live Demo: End Alignment',
            'Children aligned to the end edge',
            plum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMauve),
          ),
          child: Column(
            children: [
              overflowDemo('overflowAlignment: end',
                  OverflowBarAlignment.end, mauve, 160),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: mauve.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.align_horizontal_right,
                        size: 14, color: mauve),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          'All buttons align to the right (end). Common for '
                          'dialog actions like OK/Cancel.',
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Live demo: center alignment ───────────────────────────
        sectionHeader('5 \u00b7 Live Demo: Center Alignment',
            'Children horizontally centered',
            mauve, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMauve),
          ),
          child: Column(
            children: [
              overflowDemo('overflowAlignment: center',
                  OverflowBarAlignment.center, softPlum, 160),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: softPlum.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.align_horizontal_center,
                        size: 14, color: softPlum),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          'All buttons are centered. Independent of '
                          'TextDirection.',
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Side-by-side comparison ───────────────────────────────
        sectionHeader('6 \u00b7 Side-by-Side Comparison',
            'All three alignments in narrow containers',
            deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('start',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: plum)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: OverflowBar(
                        spacing: 4,
                        overflowSpacing: 3,
                        overflowAlignment: OverflowBarAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: plum,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: plum.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Button B',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('end',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: mauve)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: OverflowBar(
                        spacing: 4,
                        overflowSpacing: 3,
                        overflowAlignment: OverflowBarAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: mauve,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: mauve.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Button B',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('center',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: softPlum)),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: OverflowBar(
                        spacing: 4,
                        overflowSpacing: 3,
                        overflowAlignment: OverflowBarAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: softPlum,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('A',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: softPlum.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Button B',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9)),
                          ),
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

        // ── 8. TextDirection impact ──────────────────────────────────
        sectionHeader('7 \u00b7 TextDirection Impact',
            'How start and end flip with RTL',
            plum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // LTR demo
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: plum.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: plum),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.format_textdirection_l_to_r,
                            size: 16, color: plum),
                        const SizedBox(width: 6),
                        Text('LTR \u2192 start = left, end = right',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: plum)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: 120,
                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.end,
                          overflowSpacing: 3,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: plum,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('OK',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: plum.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // RTL demo
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentAmber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentAmber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.format_textdirection_r_to_l,
                            size: 16, color: accentAmber),
                        const SizedBox(width: 6),
                        Text('RTL \u2192 start = right, end = left',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: accentAmber)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        width: 120,
                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.end,
                          overflowSpacing: 3,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: accentAmber,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('\u0645\u0648\u0627\u0641\u0642',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: accentAmber.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('\u0625\u0644\u063a\u0627\u0621',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'center is unaffected by TextDirection. But start and end flip: '
          'in RTL, start means right and end means left.',
          plum,
          palePlum,
        ),
        const SizedBox(height: 14),

        // ── 9. OverflowBar anatomy ───────────────────────────────────
        sectionHeader('8 \u00b7 OverflowBar Constructor Anatomy',
            'How overflowAlignment fits into the full API',
            deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final param in [
                ('spacing', 'double', 'Horizontal spacing in normal mode', plum),
                ('alignment', 'MainAxisAlignment?', 'Alignment in normal mode', mauve),
                ('overflowSpacing', 'double', 'Vertical spacing in overflow mode', softPlum),
                ('overflowAlignment', 'OverflowBarAlignment', 'Alignment in overflow mode (THIS)', deepPlum),
                ('overflowDirection', 'VerticalDirection', 'Top-to-bottom or bottom-to-top in overflow', accentTeal),
                ('textDirection', 'TextDirection?', 'Affects start/end interpretation', accentAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: param.$4.withValues(alpha:
                        param.$1 == 'overflowAlignment' ? 0.10 : 0.04),
                    borderRadius: BorderRadius.circular(6),
                    border: param.$1 == 'overflowAlignment'
                        ? Border.all(color: param.$4, width: 2)
                        : Border(
                            left: BorderSide(
                                color: param.$4, width: 2)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(param.$1,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: param.$4)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(param.$2,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 9,
                                    color: param.$4.withValues(alpha: 0.7))),
                            Text(param.$3,
                                style: TextStyle(
                                    fontSize: 10, color: darkGrape)),
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

        // ── 10. overflowDirection interaction ────────────────────────
        sectionHeader('9 \u00b7 overflowDirection Interaction',
            'Combining alignment with vertical direction',
            plum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMauve),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Down direction
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: plum.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: plum),
                  ),
                  child: Column(
                    children: [
                      Text('down + end',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: plum)),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 80,
                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.end,
                          overflowDirection: VerticalDirection.down,
                          overflowSpacing: 3,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: plum,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text('1st',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: plum.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text('2nd',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Up direction
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: mauve.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: mauve),
                  ),
                  child: Column(
                    children: [
                      Text('up + end',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: mauve)),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 80,
                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.end,
                          overflowDirection: VerticalDirection.up,
                          overflowSpacing: 3,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: mauve,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text('1st',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: mauve.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text('2nd',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'overflowDirection controls top\u2192bottom vs bottom\u2192top, '
          'while overflowAlignment controls left/center/right. They are '
          'independent axes of control in the overflow layout.',
          plum,
          palePlum,
        ),
        const SizedBox(height: 14),

        // ── 11. Dialog button pattern ────────────────────────────────
        sectionHeader('10 \u00b7 Dialog Button Pattern',
            'The most common use case for OverflowBar',
            mauve, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Mock dialog
              Container(
                width: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: darkGrape.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delete File?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: darkGrape)),
                    const SizedBox(height: 6),
                    Text('This action cannot be undone.',
                        style: TextStyle(
                            fontSize: 11, color: darkGrape)),
                    const SizedBox(height: 12),
                    OverflowBar(
                      spacing: 8,
                      overflowSpacing: 6,
                      overflowAlignment: OverflowBarAlignment.end,
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Cancel',
                              style: TextStyle(
                                  fontSize: 11, color: plum)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: deepPlum,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 11),
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Material dialogs use OverflowBar for action buttons. '
                'When the dialog is narrow (small screen), buttons stack '
                'vertically with overflowAlignment: end.',
                mauve,
                palePlum,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Width threshold demo ─────────────────────────────────
        sectionHeader('11 \u00b7 Width Threshold Demo',
            'Same buttons at different container widths',
            deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMauve),
          ),
          child: Column(
            children: [
              for (final width in [300.0, 200.0, 120.0])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Width: ${width.toInt()}px',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: deepPlum)),
                      const SizedBox(height: 3),
                      Container(
                        width: width,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: deepPlum.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: deepPlum.withValues(alpha: 0.3)),
                        ),
                        child: OverflowBar(
                          spacing: 6,
                          overflowSpacing: 4,
                          overflowAlignment: OverflowBarAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: deepPlum,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: plum,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: mauve,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        infoBox(
          'At 300px all three buttons fit horizontally. At 200px they may '
          'start to squeeze. At 120px they overflow vertically. The '
          'overflowAlignment: center keeps them centered when stacked.',
          deepPlum,
          palePlum,
        ),
        const SizedBox(height: 14),

        // ── 13. Enum properties ──────────────────────────────────────
        sectionHeader('12 \u00b7 Enum Properties',
            'Standard Dart enum fields',
            plum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: plum),
                children: [
                  for (final h in ['Value', 'Index', 'Description'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('start', '0', 'Direction-aware start edge'),
                ('end', '1', 'Direction-aware end edge'),
                ('center', '2', 'Centered (direction-independent)'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: plum)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkGrape)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. When to use each ─────────────────────────────────────
        sectionHeader('13 \u00b7 When to Use Each Value',
            'Practical guidance', mauve, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final item in [
                ('start', 'Forms, data entry dialogs, left-aligned '
                    'confirmation flows. Natural for LTR reading.',
                    Icons.align_horizontal_left, plum),
                ('end', 'Dialog actions, footers, toolbars. Buttons '
                    'align to the far edge where users expect actions.',
                    Icons.align_horizontal_right, mauve),
                ('center', 'Splash screens, empty states, centered '
                    'CTA buttons. Direction-independent.',
                    Icons.align_horizontal_center, softPlum),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: item.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.$3, size: 18, color: item.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: item.$4)),
                            Text(item.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkGrape)),
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

        // ── 15. Performance ──────────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Considerations',
            'Lightweight by design', deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteMauve,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final note in [
                ('Single layout pass', 'OverflowBar measures children '
                    'once and decides normal or overflow mode in one pass.',
                    Icons.flash_on, plum),
                ('No animation', 'The switch between modes is instant. '
                    'Wrap in AnimatedSize for smooth transitions.',
                    Icons.animation, mauve),
                ('No rebuild overhead', 'The enum is checked during layout, '
                    'not during build. No extra widget rebuilds.',
                    Icons.memory, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: note.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: note.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(note.$3, size: 16, color: note.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${note.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: note.$4)),
                            TextSpan(
                                text: note.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkGrape)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionHeader('15 \u00b7 Summary',
            'Key takeaways', deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepPlum, plum],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'OverflowBarAlignment has three values: start, end, center',
                'Only applies when OverflowBar overflows into vertical layout',
                'In normal (horizontal) mode, MainAxisAlignment is used instead',
                'start and end are TextDirection-aware (flip in RTL)',
                'center is TextDirection-independent',
                'Material dialogs use end alignment for action buttons',
                'overflowDirection (up/down) is independent of overflowAlignment',
                'Single layout pass: no performance overhead',
                'Default value is OverflowBarAlignment.start',
                'Combine with overflowSpacing for complete overflow layout control',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightMauve,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
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
