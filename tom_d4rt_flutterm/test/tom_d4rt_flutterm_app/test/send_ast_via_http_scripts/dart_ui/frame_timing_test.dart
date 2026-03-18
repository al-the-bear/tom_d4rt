// D4rt test script: Deep Demo for FrameTiming from dart:ui
// FrameTiming stores microsecond timestamps for each rendering phase of a frame
// Obtained via SchedulerBinding.instance.addTimingsCallback
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FrameTiming Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT FRAMETIMING
  // ═══════════════════════════════════════════════════════════════════════════

  print('FrameTiming stores timestamps for each rendering phase:');
  print('  vsyncStart, buildStart, buildFinish, rasterStart, rasterFinish');
  print('Accessed via: timing.timestampInMicroseconds(FramePhase.*)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CONVENIENCE GETTERS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Convenience durations:');
  print('  .buildDuration → Duration (build phase)');
  print('  .rasterDuration → Duration (raster phase)');
  print('  .vsyncOverhead → Duration (idle gap before build)');
  print('  .totalSpan → Duration (vsyncStart → rasterFinish)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: FRAME NUMBER AND LAYER CACHE
  // ═══════════════════════════════════════════════════════════════════════════

  print('  .frameNumber → int (sequential frame identifier)');
  print('  .layerCacheCount → int (cached engine layers)');
  print('  .layerCacheMegabytes → double (cache memory)');

  // Simulated FrameTiming data for visualization
  final timings = <_SimTiming>[
    _SimTiming(1, 0, 500, 6200, 7000, 10500, 3, 2.1, false),
    _SimTiming(2, 16670, 17100, 22800, 23500, 26300, 5, 3.4, false),
    _SimTiming(3, 33340, 33900, 41200, 42000, 48500, 4, 2.8, true),
    _SimTiming(4, 50010, 50500, 55800, 56200, 59100, 6, 4.1, false),
    _SimTiming(5, 66680, 67200, 74100, 74800, 81200, 3, 2.5, true),
    _SimTiming(6, 83350, 83800, 88200, 88700, 91500, 7, 5.2, false),
    _SimTiming(7, 100020, 100600, 106400, 107000, 111800, 4, 3.0, false),
    _SimTiming(8, 116690, 117200, 128900, 129500, 138200, 2, 1.8, true),
  ];

  print('FrameTiming demo complete');

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
                    colors: [Color(0xFF880E4F), Color(0xFFF06292)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.pink.withValues(alpha: 0.3),
                      blurRadius: 12, offset: Offset(0, 6)),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.speed, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text('FrameTiming',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    SizedBox(height: 6),
                    Text('Per-frame performance data with microsecond timestamps',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85))),
                    SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _headerChip('buildDuration'),
                      SizedBox(width: 4),
                      _headerChip('rasterDuration'),
                      SizedBox(width: 4),
                      _headerChip('totalSpan'),
                    ]),
                  ],
                ),
              ),

              // ── Section 1: Properties ──
              _sectionTitle('1. FRAMETIMING PROPERTIES'),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _propRow('buildDuration', 'Duration', 'Build phase time',
                        Color(0xFF1565C0)),
                      _propRow('rasterDuration', 'Duration', 'Raster phase time',
                        Color(0xFFE65100)),
                      _propRow('vsyncOverhead', 'Duration', 'Idle before build',
                        Color(0xFF9E9E9E)),
                      _propRow('totalSpan', 'Duration', 'Full frame time',
                        Color(0xFF880E4F)),
                      _propRow('frameNumber', 'int', 'Sequential frame ID',
                        Color(0xFF2E7D32)),
                      _propRow('layerCacheCount', 'int', 'Cached layer count',
                        Color(0xFF4A148C)),
                      _propRow('layerCacheMegabytes', 'double', 'Cache memory MB',
                        Color(0xFF00695C)),
                    ],
                  ),
                ),
              ),

              // ── Section 2: Frame Timeline ──
              _sectionTitle('2. FRAME TIMELINES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: timings.map((t) => _frameTimeline(t)).toList(),
                ),
              ),

              // ── Section 3: Build vs Raster Bars ──
              _sectionTitle('3. BUILD VS RASTER COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _legendDot('Build', Color(0xFF1565C0)),
                        SizedBox(width: 12),
                        _legendDot('Raster', Color(0xFFE65100)),
                        SizedBox(width: 12),
                        _legendDot('Janky', Color(0xFFC62828)),
                      ],
                    ),
                    SizedBox(height: 10),
                    ...timings.map((t) => _dualBar(t)),
                  ],
                ),
              ),

              // ── Section 4: Layer Cache ──
              _sectionTitle('4. LAYER CACHE STATS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    ...timings.map((t) => _cacheRow(t)),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Engine layer caching reuses layers across frames. '
                        'Higher cache counts reduce raster work but use more memory. '
                        'layerCacheMegabytes tracks the GPU memory cost.',
                        style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32))),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Usage Code ──
              _sectionTitle('5. CAPTURING FRAME TIMINGS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _codeBlock([
                  'void initTimingCapture() {',
                  '  SchedulerBinding.instance',
                  '      .addTimingsCallback((timings) {',
                  '    for (final t in timings) {',
                  '      final build = t.buildDuration;',
                  '      final raster = t.rasterDuration;',
                  '      final total = t.totalSpan;',
                  '      final frame = t.frameNumber;',
                  '',
                  '      if (total > const Duration(',
                  '          milliseconds: 16)) {',
                  '        debugPrint(\'Jank frame #\$frame: \'',
                  '            \'\${total.inMilliseconds}ms\');',
                  '      }',
                  '    }',
                  '  });',
                  '}',
                ]),
              ),

              // ── Section 6: Statistics Summary ──
              _sectionTitle('6. STATISTICS SUMMARY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _buildStatsSummary(timings),
              ),

              // ── Section 7: API Map ──
              _sectionTitle('7. API MAP'),
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
                    _apiNode('SchedulerBinding', 0, Color(0xFF455A64)),
                    _apiNode('addTimingsCallback(List<FrameTiming>)', 1,
                      Color(0xFF880E4F)),
                    _apiNode('FrameTiming', 2, Color(0xFF1565C0)),
                    _apiNode('.buildDuration', 3, Color(0xFF1565C0)),
                    _apiNode('.rasterDuration', 3, Color(0xFFE65100)),
                    _apiNode('.totalSpan', 3, Color(0xFF880E4F)),
                    _apiNode('.frameNumber', 3, Color(0xFF2E7D32)),
                    _apiNode('.timestampInMicroseconds(FramePhase)', 3,
                      Color(0xFF4A148C)),
                    _apiNode('FramePhase', 2, Color(0xFF00695C)),
                    _apiNode('.vsyncStart / .buildStart / .rasterFinish ...', 3,
                      Color(0xFF00695C)),
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

// ─── DATA CLASS ────────────────────────────────────────────────────────────

class _SimTiming {
  final int frame;
  final int vsyncUs;
  final int buildStartUs;
  final int buildFinishUs;
  final int rasterStartUs;
  final int rasterFinishUs;
  final int cacheCount;
  final double cacheMB;
  final bool janky;
  _SimTiming(this.frame, this.vsyncUs, this.buildStartUs, this.buildFinishUs,
    this.rasterStartUs, this.rasterFinishUs, this.cacheCount, this.cacheMB, this.janky);

  double get buildMs => (buildFinishUs - buildStartUs) / 1000.0;
  double get rasterMs => (rasterFinishUs - rasterStartUs) / 1000.0;
  double get totalMs => (rasterFinishUs - vsyncUs) / 1000.0;
  double get vsyncOverheadMs => (buildStartUs - vsyncUs) / 1000.0;
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(title, style: TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700,
      color: Color(0xFF455A64), letterSpacing: 1.0,
    )),
  );
}

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: TextStyle(fontSize: 10, color: Colors.white)),
  );
}

Widget _propRow(String name, String type, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(width: 6, height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        SizedBox(width: 110, child: Text('.$name',
          style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold,
            fontSize: 10, color: color))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3)),
          child: Text(type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 6),
        Expanded(child: Text(desc,
          style: TextStyle(fontSize: 9, color: Colors.grey[600]))),
      ],
    ),
  );
}

Widget _frameTimeline(_SimTiming t) {
  final total = t.totalMs;
  final maxWidth = 25.0; // scale factor
  final buildFrac = t.buildMs / maxWidth;
  final rasterFrac = t.rasterMs / maxWidth;
  final idleFrac = t.vsyncOverheadMs / maxWidth;
  final color = t.janky ? Color(0xFFC62828) : Color(0xFF2E7D32);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 18, child: Text('#${t.frame}',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color))),
        Expanded(
          child: Container(
            height: 12,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(3))),
                // Idle
                FractionallySizedBox(
                  widthFactor: idleFrac.clamp(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF9E9E9E).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3)))),
                ),
                // Build
                Positioned(
                  left: 0,
                  child: FractionallySizedBox(
                    child: Container(
                      width: (100.0 * (idleFrac + buildFrac)).clamp(0, 200),
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(0xFF1565C0).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ),
                // Full frame overlay
                FractionallySizedBox(
                  widthFactor: ((idleFrac + buildFrac + rasterFrac) * 0.7 + 0.05).clamp(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF9E9E9E).withValues(alpha: 0.2),
                        Color(0xFF1565C0).withValues(alpha: 0.5),
                        Color(0xFFE65100).withValues(alpha: 0.5),
                      ]),
                      borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 6),
        SizedBox(width: 40, child: Text('${total.toStringAsFixed(1)}ms',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color))),
        SizedBox(width: 3),
        Icon(t.janky ? Icons.warning : Icons.check_circle,
          size: 10, color: color),
      ],
    ),
  );
}

Widget _dualBar(_SimTiming t) {
  final maxMs = 22.0;
  final color = t.janky ? Color(0xFFC62828) : Colors.grey[700]!;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 18, child: Text('#${t.frame}',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color))),
        Expanded(child: Column(
          children: [
            Container(
              height: 6,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (t.buildMs / maxMs).clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(2))),
              ),
            ),
            SizedBox(height: 1),
            Container(
              height: 6,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (t.rasterMs / maxMs).clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(2))),
              ),
            ),
          ],
        )),
        SizedBox(width: 4),
        Text('${t.buildMs.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 8, color: Color(0xFF1565C0))),
        Text('/', style: TextStyle(fontSize: 8, color: Colors.grey)),
        Text('${t.rasterMs.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 8, color: Color(0xFFE65100))),
      ],
    ),
  );
}

Widget _cacheRow(_SimTiming t) {
  final maxCache = 8;
  final maxMB = 6.0;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 18, child: Text('#${t.frame}',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
        // Cache count dots
        SizedBox(width: 60, child: Row(
          children: List.generate(t.cacheCount.clamp(0, maxCache), (_) =>
            Container(width: 6, height: 6, margin: EdgeInsets.only(right: 1),
              decoration: BoxDecoration(
                color: Color(0xFF4A148C), shape: BoxShape.circle))),
        )),
        // MB bar
        Expanded(child: Container(
          height: 10,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (t.cacheMB / maxMB).clamp(0, 1),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
                borderRadius: BorderRadius.circular(3)),
            ),
          ),
        )),
        SizedBox(width: 4),
        Text('${t.cacheMB}MB',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold,
            color: Color(0xFF00695C))),
      ],
    ),
  );
}

Widget _buildStatsSummary(List<_SimTiming> timings) {
  final builds = timings.map((t) => t.buildMs).toList();
  final rasters = timings.map((t) => t.rasterMs).toList();
  final totals = timings.map((t) => t.totalMs).toList();
  final janky = timings.where((t) => t.janky).length;

  builds.sort();
  rasters.sort();
  totals.sort();

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statBadge('${timings.length}', 'frames', Color(0xFF455A64)),
          _statBadge('$janky', 'janky', Color(0xFFC62828)),
          _statBadge('${(janky / timings.length * 100).toStringAsFixed(0)}%', 'jank rate',
            Color(0xFFE65100)),
        ],
      ),
      SizedBox(height: 12),
      _statRow('Build avg', '${(builds.reduce((a, b) => a + b) / builds.length).toStringAsFixed(1)}ms',
        Color(0xFF1565C0)),
      _statRow('Build p95', '${builds[(builds.length * 0.95).floor().clamp(0, builds.length - 1)].toStringAsFixed(1)}ms',
        Color(0xFF1565C0)),
      _statRow('Raster avg', '${(rasters.reduce((a, b) => a + b) / rasters.length).toStringAsFixed(1)}ms',
        Color(0xFFE65100)),
      _statRow('Total avg', '${(totals.reduce((a, b) => a + b) / totals.length).toStringAsFixed(1)}ms',
        Color(0xFF880E4F)),
    ],
  );
}

Widget _statBadge(String value, String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8)),
    child: Column(children: [
      Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      Text(label, style: TextStyle(fontSize: 9, color: color)),
    ]),
  );
}

Widget _statRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(width: 6, height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        SizedBox(width: 80, child: Text(label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
      ],
    ),
  );
}

Widget _legendDot(String label, Color color) {
  return Row(children: [
    Container(width: 8, height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    SizedBox(width: 4),
    Text(label, style: TextStyle(fontSize: 9, color: color)),
  ]);
}

Widget _apiNode(String name, int indent, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 16.0, top: 2, bottom: 2),
    child: Row(children: [
      Container(width: 6, height: 6,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      SizedBox(width: 6),
      Flexible(child: Text(name, style: TextStyle(
        fontFamily: 'monospace', fontSize: 10,
        fontWeight: indent < 2 ? FontWeight.bold : FontWeight.w500,
        color: color))),
    ]),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8)),
    child: Text(
      lines.join('\n'),
      style: TextStyle(fontFamily: 'monospace', fontSize: 10,
        color: Color(0xFFF06292), height: 1.4)),
  );
}
