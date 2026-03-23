// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for miscellaneous dart:ui enums
// Covers: AppLifecycleState, Brightness, BoxHeightStyle, BoxWidthStyle,
//         Clip, BlendMode categories, and FontWeight constants
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== dart:ui Enums Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: AppLifecycleState
  // ═══════════════════════════════════════════════════════════════════════════

  for (final state in ui.AppLifecycleState.values) {
    print('AppLifecycleState.${state.name} (index ${state.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Brightness
  // ═══════════════════════════════════════════════════════════════════════════

  for (final b in ui.Brightness.values) {
    print('Brightness.${b.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxHeightStyle & BoxWidthStyle
  // ═══════════════════════════════════════════════════════════════════════════

  for (final s in ui.BoxHeightStyle.values) {
    print('BoxHeightStyle.${s.name}');
  }
  for (final s in ui.BoxWidthStyle.values) {
    print('BoxWidthStyle.${s.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Clip
  // ═══════════════════════════════════════════════════════════════════════════

  for (final c in ui.Clip.values) {
    print('Clip.${c.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: BlendMode categories
  // ═══════════════════════════════════════════════════════════════════════════

  print('BlendMode values: ${ui.BlendMode.values.length} total');
  for (final bm in ui.BlendMode.values) {
    print('  BlendMode.${bm.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: FontWeight
  // ═══════════════════════════════════════════════════════════════════════════

  final weights = [
    ui.FontWeight.w100,
    ui.FontWeight.w200,
    ui.FontWeight.w300,
    ui.FontWeight.w400,
    ui.FontWeight.w500,
    ui.FontWeight.w600,
    ui.FontWeight.w700,
    ui.FontWeight.w800,
    ui.FontWeight.w900,
  ];
  for (final w in weights) {
    print('FontWeight: ${w.value} (index ${w.index})');
  }

  print('Enums UI demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A148C), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.list_alt, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'dart:ui Enums',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'AppLifecycleState, Brightness, BoxHeight/WidthStyle, '
                      'Clip, BlendMode, FontWeight',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: AppLifecycleState ──
              _sectionTitle('1. APP LIFECYCLE STATE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _lifecycleRow(
                      ui.AppLifecycleState.detached,
                      'App not yet attached',
                      Icons.power_off,
                      Color(0xFF9E9E9E),
                    ),
                    _lifecycleArrow(),
                    _lifecycleRow(
                      ui.AppLifecycleState.resumed,
                      'Fully visible & interactive',
                      Icons.play_circle_fill,
                      Color(0xFF2E7D32),
                    ),
                    _lifecycleArrow(),
                    _lifecycleRow(
                      ui.AppLifecycleState.inactive,
                      'Visible but losing focus',
                      Icons.pause_circle,
                      Color(0xFFE65100),
                    ),
                    _lifecycleArrow(),
                    _lifecycleRow(
                      ui.AppLifecycleState.hidden,
                      'Not visible to user',
                      Icons.visibility_off,
                      Color(0xFF1565C0),
                    ),
                    _lifecycleArrow(),
                    _lifecycleRow(
                      ui.AppLifecycleState.paused,
                      'Suspended in background',
                      Icons.bedtime,
                      Color(0xFF6A1B9A),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'detached → resumed → inactive → hidden → paused → resumed ...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'monospace',
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Brightness ──
              _sectionTitle('2. BRIGHTNESS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              size: 32,
                              color: Color(0xFFF57F17),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Brightness.light',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Light backgrounds\nDark text on light',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF263238),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.dark_mode,
                              size: 32,
                              color: Color(0xFFB0BEC5),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Brightness.dark',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dark backgrounds\nLight text on dark',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 3: BoxHeightStyle & BoxWidthStyle ──
              _sectionTitle('3. BOX HEIGHT & WIDTH STYLES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BoxHeightStyle',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: ui.BoxHeightStyle.values
                          .map((s) => _enumChip(s.name, Color(0xFF0D47A1)))
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'BoxWidthStyle',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: ui.BoxWidthStyle.values
                          .map((s) => _enumChip(s.name, Color(0xFF2E7D32)))
                          .toList(),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Used with Paragraph.getBoxesForRange() to control how '
                        'text selection boxes are computed.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Clip ──
              _sectionTitle('4. CLIP BEHAVIOR'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _clipRow(
                      ui.Clip.none,
                      'No clipping applied',
                      'Fastest — content may overflow',
                      Color(0xFF9E9E9E),
                    ),
                    _clipRow(
                      ui.Clip.hardEdge,
                      'Hard pixel boundary clip',
                      'Fast — no anti-aliasing',
                      Color(0xFFE65100),
                    ),
                    _clipRow(
                      ui.Clip.antiAlias,
                      'Smooth-edge clipping',
                      'Moderate — anti-aliased edges',
                      Color(0xFF0D47A1),
                    ),
                    _clipRow(
                      ui.Clip.antiAliasWithSaveLayer,
                      'AA + save layer',
                      'Slow — full compositing',
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _perfIndicator('none', 5, Color(0xFF2E7D32)),
                        SizedBox(width: 4),
                        _perfIndicator('hard', 4, Color(0xFF2E7D32)),
                        SizedBox(width: 4),
                        _perfIndicator('AA', 3, Color(0xFFE65100)),
                        SizedBox(width: 4),
                        _perfIndicator('AA+SL', 1, Color(0xFFC62828)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Performance (higher = faster)',
                      style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              // ── Section 5: BlendMode Gallery ──
              _sectionTitle('5. BLEND MODES (${ui.BlendMode.values.length})'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _blendModeGroup('Porter-Duff', [
                      'clear',
                      'src',
                      'dst',
                      'srcOver',
                      'dstOver',
                      'srcIn',
                      'dstIn',
                      'srcOut',
                      'dstOut',
                      'srcATop',
                      'dstATop',
                      'xor',
                    ], Color(0xFF0D47A1)),
                    SizedBox(height: 12),
                    _blendModeGroup('Arithmetic', [
                      'plus',
                      'modulate',
                    ], Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    _blendModeGroup('Separable', [
                      'screen',
                      'overlay',
                      'darken',
                      'lighten',
                      'colorDodge',
                      'colorBurn',
                      'hardLight',
                      'softLight',
                      'difference',
                      'exclusion',
                      'multiply',
                    ], Color(0xFF6A1B9A)),
                    SizedBox(height: 12),
                    _blendModeGroup('Non-Separable', [
                      'hue',
                      'saturation',
                      'color',
                      'luminosity',
                    ], Color(0xFFBF360C)),
                  ],
                ),
              ),

              // ── Section 6: FontWeight ──
              _sectionTitle('6. FONT WEIGHT SPECTRUM'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: weights.map((w) {
                    final names = {
                      100: 'Thin',
                      200: 'ExtraLight',
                      300: 'Light',
                      400: 'Normal',
                      500: 'Medium',
                      600: 'SemiBold',
                      700: 'Bold',
                      800: 'ExtraBold',
                      900: 'Black',
                    };
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 35,
                            child: Text(
                              'w${w.value}',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A148C),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              names[w.value] ?? '',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: w.value / 900,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF4A148C),
                                        Color(0xFFCE93D8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Sample',
                            style: TextStyle(fontWeight: w, fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ── Section 7: Enum Summary Table ──
              _sectionTitle('7. ENUM SUMMARY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _summaryRow(
                      'AppLifecycleState',
                      ui.AppLifecycleState.values.length,
                      Color(0xFF2E7D32),
                    ),
                    _summaryRow(
                      'Brightness',
                      ui.Brightness.values.length,
                      Color(0xFFF57F17),
                    ),
                    _summaryRow(
                      'BoxHeightStyle',
                      ui.BoxHeightStyle.values.length,
                      Color(0xFF0D47A1),
                    ),
                    _summaryRow(
                      'BoxWidthStyle',
                      ui.BoxWidthStyle.values.length,
                      Color(0xFF2E7D32),
                    ),
                    _summaryRow(
                      'Clip',
                      ui.Clip.values.length,
                      Color(0xFFE65100),
                    ),
                    _summaryRow(
                      'BlendMode',
                      ui.BlendMode.values.length,
                      Color(0xFF6A1B9A),
                    ),
                    _summaryRow('FontWeight', 9, Color(0xFF4A148C)),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _lifecycleRow(
  ui.AppLifecycleState state,
  String desc,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 14),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}

Widget _enumChip(String name, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      name,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

Widget _clipRow(ui.Clip clip, String desc, String perf, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            clip.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(desc, style: TextStyle(fontSize: 10)),
              Text(
                perf,
                style: TextStyle(fontSize: 9, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _perfIndicator(String label, int bars, Color color) {
  return Column(
    children: [
      Row(
        children: List.generate(
          5,
          (i) => Container(
            width: 6,
            height: 12,
            margin: EdgeInsets.only(right: 1),
            decoration: BoxDecoration(
              color: i < bars ? color : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
      SizedBox(height: 2),
      Text(label, style: TextStyle(fontSize: 8, color: Colors.grey[600])),
    ],
  );
}

Widget _blendModeGroup(String group, List<String> modes, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$group (${modes.length})',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: color,
        ),
      ),
      SizedBox(height: 4),
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children: modes
            .map(
              (m) => Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Text(m, style: TextStyle(fontSize: 9, color: color)),
              ),
            )
            .toList(),
      ),
    ],
  );
}

Widget _summaryRow(String name, int count, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$count values',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}
