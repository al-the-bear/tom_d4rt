// ignore_for_file: avoid_print
// D4rt deep demo: Orientation — portrait vs landscape layout enum
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Coral / Terracotta ────────────────────────────────────
  const deepCoral = Color(0xFFC62828);
  const coral = Color(0xFFE53935);
  const terracotta = Color(0xFFD84315);
  const softCoral = Color(0xFFEF5350);
  const lightTerracotta = Color(0xFFFFAB91);
  const paleCoral = Color(0xFFFFEBEE);
  const whiteTerra = Color(0xFFFFF3F0);
  const darkEmber = Color(0xFF3E2723);
  const accentTeal = Color(0xFF00695C);
  const accentNavy = Color(0xFF1A237E);

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
          style: TextStyle(fontSize: 13, color: darkEmber)),
    );
  }

  Widget fieldRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkEmber)),
          ),
        ],
      ),
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

  // Helper to simulate a phone screen shape
  Widget phoneMockup(String label, double w, double h, Orientation orient,
      Color border, Color headerBg) {
    final isPortrait = orient == Orientation.portrait;
    return Container(
      width: w + 12,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: 2),
        boxShadow: [
          BoxShadow(
              color: border.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Status bar mockup
          Container(
            width: double.infinity,
            height: 14,
            decoration: BoxDecoration(
              color: headerBg,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Center(
              child: Text(label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          // Screen area
          Container(
            width: w,
            height: h,
            color: paleCoral,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPortrait ? Icons.stay_primary_portrait : Icons.stay_primary_landscape,
                  size: isPortrait ? 28 : 22,
                  color: border,
                ),
                const SizedBox(height: 4),
                Text('${w.toInt()} \u00d7 ${h.toInt()}',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: border)),
                Text(isPortrait ? 'PORTRAIT' : 'LANDSCAPE',
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: border.withValues(alpha: 0.7))),
              ],
            ),
          ),
          // Home button
          Container(
            width: 20,
            height: 4,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: border.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('Orientation deep demo executing');
  print('=' * 60);

  print('\n--- What is Orientation ---');
  print('An enum with two values: portrait and landscape');
  print('Defined in widgets/media_query.dart');
  print('portrait = taller than wide (height > width)');
  print('landscape = wider than tall (width > height)');

  print('\n--- How it is derived ---');
  print('MediaQueryData.orientation: width > height ? landscape : portrait');
  print('OrientationBuilder: maxWidth > maxHeight ? landscape : portrait');

  print('\n--- Key consumers ---');
  print('OrientationBuilder — rebuilds on orientation change');
  print('Scrollbar — adjusts based on orientation');
  print('GridView — responsive column counts');

  final currentOrientation = MediaQuery.of(context).orientation;
  print('\nCurrent device orientation: $currentOrientation');
  print('Screen size: ${MediaQuery.of(context).size}');

  print('\n${'=' * 60}');
  print('Orientation deep demo completed');

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
              colors: [deepCoral, coral, terracotta],
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
                  Icon(Icons.screen_rotation, size: 28,
                      color: lightTerracotta),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Orientation',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A two-value enum that describes whether a surface '
                  'is taller than wide (portrait) or wider than tall '
                  '(landscape). Used by MediaQuery, OrientationBuilder, '
                  'and responsive layout patterns throughout Flutter.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('Orientation.portrait', coral, Colors.white),
                pill('Orientation.landscape', terracotta, Colors.white),
                pill('MediaQuery', lightTerracotta, darkEmber),
                pill('OrientationBuilder', paleCoral, darkEmber),
              ]),
            ],
          ),
        ),

        // ── 2. The enum definition ───────────────────────────────────
        sectionHeader('1 \u00b7 The Orientation Enum',
            'Two simple values with deep implications',
            deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Portrait card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: coral.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: coral),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.stay_primary_portrait,
                          size: 32, color: coral),
                      const SizedBox(height: 6),
                      Text('portrait',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: coral)),
                      const SizedBox(height: 4),
                      Text('Taller than wide',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, color: darkEmber)),
                      const SizedBox(height: 2),
                      Text('height > width',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: coral)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Landscape card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: terracotta.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: terracotta),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.stay_primary_landscape,
                          size: 32, color: terracotta),
                      const SizedBox(height: 6),
                      Text('landscape',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: terracotta)),
                      const SizedBox(height: 4),
                      Text('Wider than tall',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, color: darkEmber)),
                      const SizedBox(height: 2),
                      Text('width > height',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: terracotta)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. How MediaQuery derives it ─────────────────────────────
        sectionHeader('2 \u00b7 How MediaQuery Derives Orientation',
            'Width versus height comparison',
            coral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTerracotta),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: coral.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: coral.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'Orientation get orientation {\n'
                    '  return size.width > size.height\n'
                    '    ? Orientation.landscape\n'
                    '    : Orientation.portrait;\n'
                    '}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: deepCoral)),
              ),
              const SizedBox(height: 10),
              infoBox(
                'Note the \u201c>\u201d comparison: when width equals height '
                '(a perfect square), the result is portrait. This edge case '
                'rarely occurs on real devices but can happen in tests or '
                'custom layouts.',
                coral,
                paleCoral,
              ),
              const SizedBox(height: 8),
              // Current device info
              Builder(
                builder: (ctx) {
                  final mq = MediaQuery.of(ctx);
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentTeal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: accentTeal),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Device',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: accentTeal)),
                        fieldRow('Screen size',
                            '${mq.size.width.toStringAsFixed(0)} \u00d7 ${mq.size.height.toStringAsFixed(0)}',
                            accentTeal),
                        fieldRow('Orientation',
                            mq.orientation.toString(), accentTeal),
                        fieldRow('Pixel ratio',
                            mq.devicePixelRatio.toStringAsFixed(1),
                            accentTeal),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Visual: portrait vs landscape ─────────────────────────
        sectionHeader('3 \u00b7 Visual: Portrait vs Landscape',
            'Side-by-side device mockups',
            terracotta, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              phoneMockup('Portrait', 70, 120, Orientation.portrait,
                  coral, deepCoral),
              phoneMockup('Landscape', 120, 70, Orientation.landscape,
                  terracotta, terracotta),
            ],
          ),
        ),
        infoBox(
          'The same physical device produces different Orientation values '
          'depending on how it is held. Flutter responds to this via '
          'MediaQuery and OrientationBuilder.',
          terracotta,
          whiteTerra,
        ),
        const SizedBox(height: 14),

        // ── 5. OrientationBuilder ────────────────────────────────────
        sectionHeader('4 \u00b7 OrientationBuilder Widget',
            'Rebuilds its child when orientation changes',
            deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCoral.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCoral.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'OrientationBuilder(\n'
                    '  builder: (context, orientation) {\n'
                    '    if (orientation == Orientation.portrait) {\n'
                    '      return singleColumnLayout();\n'
                    '    }\n'
                    '    return twoColumnLayout();\n'
                    '  },\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCoral)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'OrientationBuilder uses the PARENT constraints, not '
                'MediaQuery. This means a constrained widget can see a '
                'different orientation than the full screen. '
                'maxWidth > maxHeight \u2192 landscape, else portrait.',
                deepCoral,
                paleCoral,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Live demo: constrained OrientationBuilder ─────────────
        sectionHeader('5 \u00b7 Live Demo: Constrained Orientation',
            'Same screen, different orientation per constraint box',
            coral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTerracotta),
          ),
          child: Column(
            children: [
              // Wide box → landscape
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 300, maxHeight: 80),
                  child: OrientationBuilder(
                    builder: (ctx, orient) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: terracotta.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: terracotta),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stay_primary_landscape,
                                size: 20, color: terracotta),
                            const SizedBox(width: 8),
                            Text('300\u00d780 \u2192 $orient',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: terracotta)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Tall box → portrait
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 120, maxHeight: 100),
                  child: OrientationBuilder(
                    builder: (ctx, orient) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: coral.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: coral),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stay_primary_portrait,
                                size: 20, color: coral),
                            Text('120\u00d7100 \u2192 $orient',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: coral)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Square box → portrait
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 100, maxHeight: 100),
                  child: OrientationBuilder(
                    builder: (ctx, orient) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: accentNavy.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: accentNavy),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.crop_square,
                                size: 20, color: accentNavy),
                            Text('100\u00d7100 \u2192 $orient',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: accentNavy)),
                            Text('(square = portrait)',
                                style: TextStyle(
                                    fontSize: 9, color: accentNavy)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'Three constraint boxes on the same screen produce different '
          'orientations. The wide one is landscape, the tall one is '
          'portrait, and the square defaults to portrait because the '
          'comparison is strict \u201c>\u201d (not \u201c>=\u201d).',
          coral,
          paleCoral,
        ),
        const SizedBox(height: 14),

        // ── 7. Orientation-based grid columns ────────────────────────
        sectionHeader('6 \u00b7 Responsive Grid Columns',
            'Changing column count based on Orientation',
            terracotta, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Simulated portrait grid (2 columns)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: coral.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: coral),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.stay_primary_portrait,
                            size: 14, color: coral),
                        const SizedBox(width: 4),
                        Text('Portrait \u2192 2 columns',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: coral)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 1; i <= 4; i++)
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: coral.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: coral.withValues(alpha: 0.4)),
                            ),
                            child: Text('Item $i',
                                style: TextStyle(
                                    fontSize: 10, color: deepCoral)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              // Simulated landscape grid (4 columns)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: terracotta.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: terracotta),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.stay_primary_landscape,
                            size: 14, color: terracotta),
                        const SizedBox(width: 4),
                        Text('Landscape \u2192 4 columns',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: terracotta)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 1; i <= 4; i++)
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: terracotta.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: terracotta.withValues(alpha: 0.4)),
                            ),
                            child: Text('Item $i',
                                style: TextStyle(
                                    fontSize: 10, color: darkEmber)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        infoBox(
          'A common pattern: portrait shows 2 columns, landscape shows 4. '
          'Use OrientationBuilder or MediaQuery.of(context).orientation '
          'to pick the crossAxisCount at build time.',
          terracotta,
          whiteTerra,
        ),
        const SizedBox(height: 14),

        // ── 8. Layout orientation ─────────────────────────────────
        sectionHeader('7 \u00b7 Layout vs Device Orientation',
            'Orientation is about constraints, not sensors',
            deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: deepCoral.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: deepCoral),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.screen_rotation,
                              size: 22, color: deepCoral),
                          const SizedBox(height: 4),
                          Text('Device Orientation',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: deepCoral)),
                          const SizedBox(height: 4),
                          Text('Sensor-based\nAccelerometer\nDeviceOrientation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('\u2260',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: softCoral)),
                  ),
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
                          Icon(Icons.aspect_ratio,
                              size: 22, color: accentTeal),
                          const SizedBox(height: 4),
                          Text('Layout Orientation',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentTeal)),
                          const SizedBox(height: 4),
                          Text('Size comparison\nWidth vs Height\nOrientation enum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkEmber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              infoBox(
                'Flutter\u0027s Orientation enum is purely about dimensions. '
                'A tablet in landscape mode can have an app window that is '
                'taller than wide (split-screen), resulting in '
                'Orientation.portrait despite the device being landscape.',
                deepCoral,
                paleCoral,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Live demo: orientation-aware layout ───────────────────
        sectionHeader('8 \u00b7 Live Demo: Adaptive Layout',
            'Column in portrait, Row in landscape',
            coral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTerracotta),
          ),
          child: OrientationBuilder(
            builder: (ctx, orient) {
              final cards = [
                for (final item in [
                  ('Inbox', Icons.inbox, coral),
                  ('Sent', Icons.send, terracotta),
                  ('Drafts', Icons.drafts, deepCoral),
                ])
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: item.$3.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: item.$3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item.$2, size: 18, color: item.$3),
                        const SizedBox(width: 6),
                        Text(item.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: item.$3)),
                      ],
                    ),
                  ),
              ];

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: accentNavy.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                        'Current: $orient \u2192 '
                        '${orient == Orientation.portrait ? "Column layout" : "Row layout"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: accentNavy)),
                  ),
                  const SizedBox(height: 8),
                  orient == Orientation.portrait
                      ? Column(children: cards)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: cards),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Orientation in scrolling ─────────────────────────────
        sectionHeader('9 \u00b7 Orientation and Scrollable Widgets',
            'How scrollable views adapt',
            terracotta, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('PageView', 'Adapts page size to available dimensions. '
                    'Portrait: tall pages; Landscape: wide pages.',
                    Icons.pages, coral),
                ('ListView', 'Item count stays the same, but visible count '
                    'differs. Landscape shows fewer tall items.',
                    Icons.list, terracotta),
                ('GridView', 'crossAxisCount can change. Portrait: fewer '
                    'columns; Landscape: more columns.',
                    Icons.grid_view, deepCoral),
                ('Scrollbar', 'Internally checks orientation to decide '
                    'scrollbar placement and size.',
                    Icons.swap_horiz, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scenario.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(scenario.$3, size: 18, color: scenario.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: scenario.$4)),
                            Text(scenario.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkEmber)),
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

        // ── 11. Live demo: orientation-aware spacing ─────────────────
        sectionHeader('10 \u00b7 Live Demo: Orientation-Aware Spacing',
            'Adjusting padding and gaps by orientation',
            deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTerracotta),
          ),
          child: Builder(
            builder: (ctx) {
              final orient = MediaQuery.of(ctx).orientation;
              final isPortrait = orient == Orientation.portrait;
              final spacing = isPortrait ? 12.0 : 6.0;
              final padding = isPortrait ? 16.0 : 8.0;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: deepCoral.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                        '$orient: padding=${padding.toInt()}, spacing=${spacing.toInt()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: deepCoral)),
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Row(
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          if (i > 0) SizedBox(width: spacing),
                          Expanded(
                            child: Container(
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    [coral, terracotta, deepCoral][i],
                                    [coral, terracotta, deepCoral][i]
                                        .withValues(alpha: 0.6),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Block ${i + 1}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Enum comparison ──────────────────────────────────────
        sectionHeader('11 \u00b7 Using Orientation in Switch/If',
            'Pattern matching on both values',
            coral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: coral.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: coral.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Switch expression (Dart 3+)\n'
                    'final columns = switch (orientation) {\n'
                    '  Orientation.portrait  => 2,\n'
                    '  Orientation.landscape => 4,\n'
                    '};\n'
                    '\n'
                    '// If-else\n'
                    'if (orientation == Orientation.portrait) {\n'
                    '  return singleColumn();\n'
                    '} else {\n'
                    '  return doubleColumn();\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCoral)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Since Orientation has only two values, the switch is '
                'exhaustive without a default case. Dart\u0027s pattern '
                'matching ensures you handle both values.',
                coral,
                paleCoral,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Live demo: tablet mockup ─────────────────────────────
        sectionHeader('12 \u00b7 Live Demo: Device Sizes and Orientation',
            'How different screen sizes produce different orientations',
            terracotta, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTerracotta),
          ),
          child: Column(
            children: [
              for (final device in [
                ('Phone (portrait)', 60.0, 100.0, coral),
                ('Phone (landscape)', 100.0, 60.0, terracotta),
                ('Tablet (portrait)', 80.0, 110.0, deepCoral),
                ('Tablet (landscape)', 130.0, 80.0, softCoral),
                ('Desktop (wide)', 160.0, 70.0, accentNavy),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: device.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: device.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      // Mini device shape
                      Container(
                        width: device.$2 * 0.3,
                        height: device.$3 * 0.3,
                        decoration: BoxDecoration(
                          color: device.$4.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: device.$4, width: 1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(device.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: device.$4)),
                            Text(
                                '${device.$2.toInt()}\u00d7${device.$3.toInt()} \u2192 '
                                '${device.$2 > device.$3 ? "landscape" : "portrait"}',
                                style: TextStyle(
                                    fontSize: 10, color: darkEmber)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: device.$4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            device.$2 > device.$3 ? 'L' : 'P',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Performance and gotchas ──────────────────────────────
        sectionHeader('13 \u00b7 Performance and Gotchas',
            'What to watch out for', deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final item in [
                ('OrientationBuilder rebuilds',
                    'Only rebuilds when orientation changes. If the size '
                    'changes but orientation stays the same, no rebuild.',
                    Icons.refresh, coral),
                ('MediaQuery dependency',
                    'MediaQuery.of(context).orientation registers a '
                    'dependency on the full MediaQuery. Use '
                    'MediaQuery.orientationOf(context) for narrower scope.',
                    Icons.link, terracotta),
                ('Split-screen edge case',
                    'On tablets in split-screen, orientation may flip as '
                    'the user adjusts the divider even though the device '
                    'has not physically rotated.',
                    Icons.splitscreen, deepCoral),
                ('No animation', 'Orientation changes are discrete, not '
                    'animated. Use AnimatedSwitcher to smooth transitions.',
                    Icons.animation, accentTeal),
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
                                    fontSize: 11, color: darkEmber)),
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

        // ── 15. Common responsive patterns ───────────────────────────
        sectionHeader('14 \u00b7 Common Responsive Patterns',
            'Real-world orientation usage',
            coral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTerra,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepCoral),
                children: [
                  for (final h in ['Pattern', 'Portrait', 'Landscape'])
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
                ('Grid columns', '2 cols', '4 cols', coral),
                ('Navigation', 'Bottom bar', 'Side rail', terracotta),
                ('Detail view', 'Stack', 'Side-by-side', deepCoral),
                ('Font size', 'Normal', 'Slightly smaller', softCoral),
                ('Padding', 'Generous', 'Compact', accentTeal),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: row.$4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkEmber)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkEmber)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionHeader('15 \u00b7 Summary',
            'Key takeaways', deepCoral, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCoral, coral],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Orientation is a simple two-value enum: portrait and landscape',
                'Derived from width > height comparison, not device sensors',
                'MediaQuery.orientation uses the screen size',
                'OrientationBuilder uses parent constraints (not MediaQuery)',
                'When width == height, the result is portrait (strict >)',
                'Common pattern: switch column count, layout axis, padding',
                'A widget can have different orientation than the screen',
                'Orientation changes are discrete \u2014 use AnimatedSwitcher to smooth them',
                'Use MediaQuery.orientationOf() for narrower rebuild scope',
                'Split-screen on tablets can flip orientation without device rotation',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightTerracotta,
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
