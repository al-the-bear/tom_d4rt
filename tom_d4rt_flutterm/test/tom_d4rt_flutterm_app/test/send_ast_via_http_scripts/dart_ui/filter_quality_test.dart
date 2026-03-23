// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for FilterQuality from dart:ui
// FilterQuality controls the quality level of image sampling/filtering
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FilterQuality Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = ui.FilterQuality.values;
  print('FilterQuality values: $values');
  print('Count: ${values.length}');

  for (final q in values) {
    print('FilterQuality.${q.name}: index=${q.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final none = ui.FilterQuality.none;
  final low = ui.FilterQuality.low;
  final medium = ui.FilterQuality.medium;
  final high = ui.FilterQuality.high;

  print('none: $none, index=${none.index}');
  print('low: $low, index=${low.index}');
  print('medium: $medium, index=${medium.index}');
  print('high: $high, index=${high.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  print('none == none: ${none == ui.FilterQuality.none}');
  print('none == high: ${none == high}');
  print('hashCode equal: ${none.hashCode == ui.FilterQuality.none.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PAINT INTEGRATION
  // ═══════════════════════════════════════════════════════════════════════════

  for (final q in values) {
    final paint = Paint()..filterQuality = q;
    print('Paint with $q: filterQuality=${paint.filterQuality}');
  }

  print('FilterQuality demo complete');

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
                    colors: [Color(0xFF4527A0), Color(0xFF7E57C2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.tune, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FilterQuality Deep Demo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Image sampling quality levels',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Quality Level Cards ──
              _sectionTitle('1. FILTER QUALITY LEVELS'),
              _qualityCard(
                none,
                'none',
                'Nearest-neighbor sampling. Fastest but produces pixelated results when scaling.',
                Icons.grid_view,
                Color(0xFFC62828),
                0.0,
                1.0,
              ),
              _qualityCard(
                low,
                'low',
                'Bilinear interpolation. Good quality for most use cases with minimal cost.',
                Icons.blur_linear,
                Color(0xFFE65100),
                0.33,
                0.7,
              ),
              _qualityCard(
                medium,
                'medium',
                'Bilinear with mipmaps. Better for downscaling, reduces aliasing artifacts.',
                Icons.blur_on,
                Color(0xFF1565C0),
                0.66,
                0.4,
              ),
              _qualityCard(
                high,
                'high',
                'Bicubic resampling. Best quality, most expensive. Smooth scaling in all directions.',
                Icons.hd,
                Color(0xFF2E7D32),
                1.0,
                0.15,
              ),

              // ── Demo 2: Visual Quality Comparison ──
              _sectionTitle('2. VISUAL QUALITY COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    _qualityPreview('none', Color(0xFFC62828), true),
                    SizedBox(width: 8),
                    _qualityPreview('low', Color(0xFFE65100), false),
                    SizedBox(width: 8),
                    _qualityPreview('medium', Color(0xFF1565C0), false),
                    SizedBox(width: 8),
                    _qualityPreview('high', Color(0xFF2E7D32), false),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  'Simulated quality difference when scaling images',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),

              // ── Demo 3: Performance vs Quality Trade-off ──
              _sectionTitle('3. PERFORMANCE vs QUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _tradeoffRow('none', 1.0, 0.1, Color(0xFFC62828)),
                    SizedBox(height: 8),
                    _tradeoffRow('low', 0.7, 0.5, Color(0xFFE65100)),
                    SizedBox(height: 8),
                    _tradeoffRow('medium', 0.4, 0.75, Color(0xFF1565C0)),
                    SizedBox(height: 8),
                    _tradeoffRow('high', 0.15, 1.0, Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              color: Color(0xFFFFCDD2),
                            ),
                            SizedBox(width: 4),
                            Text('Speed', style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              color: Color(0xFFC8E6C9),
                            ),
                            SizedBox(width: 4),
                            Text('Quality', style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Demo 4: Sampling Methods ──
              _sectionTitle('4. SAMPLING ALGORITHMS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _algorithmRow(
                      'none',
                      'Nearest Neighbor',
                      'Picks closest pixel. No interpolation.',
                      Icons.grid_4x4,
                      Color(0xFFC62828),
                    ),
                    Divider(height: 20),
                    _algorithmRow(
                      'low',
                      'Bilinear',
                      'Weighted average of 4 nearest pixels.',
                      Icons.blur_linear,
                      Color(0xFFE65100),
                    ),
                    Divider(height: 20),
                    _algorithmRow(
                      'medium',
                      'Bilinear + Mipmaps',
                      'Pre-computed reduced versions for downscaling.',
                      Icons.blur_on,
                      Color(0xFF1565C0),
                    ),
                    Divider(height: 20),
                    _algorithmRow(
                      'high',
                      'Bicubic',
                      'Weighted average of 16 nearest pixels. Cubic curves.',
                      Icons.hd,
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Demo 5: Use Cases ──
              _sectionTitle('5. RECOMMENDED USE CASES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _useCaseRow(
                      Icons.videogame_asset,
                      'Pixel Art',
                      'none — preserves sharp pixel edges',
                      Color(0xFFC62828),
                    ),
                    Divider(height: 16),
                    _useCaseRow(
                      Icons.list,
                      'List Thumbnails',
                      'low — fast rendering for many items',
                      Color(0xFFE65100),
                    ),
                    Divider(height: 16),
                    _useCaseRow(
                      Icons.photo_library,
                      'Photo Gallery',
                      'medium — good balance for images',
                      Color(0xFF1565C0),
                    ),
                    Divider(height: 16),
                    _useCaseRow(
                      Icons.zoom_in,
                      'Image Zoom/Detail',
                      'high — maximum quality for key visuals',
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Demo 6: Equality ──
              _sectionTitle('6. EQUALITY & INDEX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow(
                      'none == none',
                      none == ui.FilterQuality.none,
                      true,
                    ),
                    SizedBox(height: 8),
                    _equalityRow('none == high', none == high, false),
                    SizedBox(height: 12),
                    ...values.map((q) => _indexRow(q)),
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

Widget _qualityCard(
  ui.FilterQuality quality,
  String name,
  String desc,
  IconData icon,
  Color color,
  double qualityLevel,
  double speedLevel,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Text(
              'FilterQuality.$name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'idx ${quality.index}',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        SizedBox(height: 8),
        Row(
          children: [
            Text('Quality ', style: TextStyle(fontSize: 10)),
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFFEEEEEE),
                ),
                child: FractionallySizedBox(
                  widthFactor: qualityLevel,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text('Speed ', style: TextStyle(fontSize: 10)),
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFFEEEEEE),
                ),
                child: FractionallySizedBox(
                  widthFactor: speedLevel,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0xFF78909C),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _qualityPreview(String name, Color color, bool pixelated) {
  return Expanded(
    child: Column(
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: pixelated
                ? null
                : LinearGradient(
                    colors: [color, color.withValues(alpha: 0.2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: pixelated ? null : null,
          ),
          child: pixelated
              ? _pixelGrid(color)
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.2)],
                    ),
                  ),
                ),
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _pixelGrid(Color color) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Column(
      children: List.generate(7, (row) {
        return Expanded(
          child: Row(
            children: List.generate(7, (col) {
              final alpha = ((row + col) % 3 == 0) ? 0.9 : 0.3;
              return Expanded(
                child: Container(color: color.withValues(alpha: alpha)),
              );
            }),
          ),
        );
      }),
    ),
  );
}

Widget _tradeoffRow(String name, double speed, double quality, Color color) {
  return Row(
    children: [
      Container(
        width: 60,
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      Expanded(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFFFCDD2),
          ),
          child: FractionallySizedBox(
            widthFactor: speed,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 4),
      Expanded(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFC8E6C9),
          ),
          child: FractionallySizedBox(
            widthFactor: quality,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _algorithmRow(
  String name,
  String algo,
  String desc,
  IconData icon,
  Color color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                SizedBox(width: 8),
                Text(algo, style: TextStyle(fontSize: 12)),
              ],
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _useCaseRow(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _equalityRow(String label, bool result, bool expected) {
  return Row(
    children: [
      Icon(
        result == expected ? Icons.check_circle : Icons.cancel,
        color: result == expected ? Colors.green : Colors.red,
        size: 20,
      ),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 13, fontFamily: 'monospace')),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
          ),
        ),
      ),
    ],
  );
}

Widget _indexRow(ui.FilterQuality q) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          q.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'index: ${q.index}',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}
