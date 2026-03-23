// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for FramePhase from dart:ui
// FramePhase enum represents the specific phases of rendering a single frame
// Used with FrameTiming to measure per-phase timing for profiling
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FramePhase Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  print('FramePhase values:');
  for (final phase in ui.FramePhase.values) {
    print('  ${phase.name} (index ${phase.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PHASE DESCRIPTIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Phase descriptions:');
  print('  vsyncStart – VSync signal received from display');
  print(
    '  buildStart – Framework begin frame (animate + build + layout + paint)',
  );
  print('  buildFinish – Framework draw frame complete');
  print('  rasterStart – Rasterizer begins processing the scene');
  print('  rasterFinish – Rasterized frame submitted to display');
  print('  rasterFinishWallTime - Wall clock when raster finished');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: TIMING CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('FrameTiming.timestampInMicroseconds(FramePhase) → int');
  print('Build duration = buildFinish - buildStart');
  print('Raster duration = rasterFinish - rasterStart');
  print('Total frame time = rasterFinish - vsyncStart');

  // Simulated phase timing data
  final phases = <_PhaseData>[
    _PhaseData(
      'vsyncStart',
      0.0,
      0.0,
      Color(0xFF4A148C),
      Icons.signal_cellular_alt,
      'Display VSync signal',
    ),
    _PhaseData(
      'buildStart',
      0.8,
      0.0,
      Color(0xFF1565C0),
      Icons.build_circle,
      'Begin framework phase',
    ),
    _PhaseData(
      'buildFinish',
      0.0,
      7.2,
      Color(0xFF2E7D32),
      Icons.check_circle,
      'Framework phase complete',
    ),
    _PhaseData(
      'rasterStart',
      8.0,
      0.0,
      Color(0xFFE65100),
      Icons.gradient,
      'Begin GPU rasterization',
    ),
    _PhaseData(
      'rasterFinish',
      0.0,
      4.5,
      Color(0xFFC62828),
      Icons.done_all,
      'Frame rasterized and displayed',
    ),
  ];

  // Calculate derived values
  final buildDuration = 7.2; // buildFinish - buildStart
  final rasterDuration = 4.5; // rasterFinish - rasterStart
  final totalFrame = 12.5; // rasterFinish - vsyncStart
  final idleGap = 0.8; // buildStart - vsyncStart

  // Simulated comparison of fast vs slow frames
  final frameProfiles = <_FrameProfile>[
    _FrameProfile('Smooth', 2.1, 1.8, 0.2, false),
    _FrameProfile('Normal', 5.5, 3.2, 0.6, false),
    _FrameProfile('Busy', 9.8, 5.1, 0.8, false),
    _FrameProfile('Janky', 12.4, 8.3, 1.2, true),
    _FrameProfile('Frozen', 28.0, 14.0, 2.0, true),
  ];

  print('FramePhase demo complete');

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
                    colors: [Color(0xFF1A237E), Color(0xFF5C6BC0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.timeline, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FramePhase',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Enum identifying phases of the rendering pipeline for profiling',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _headerChip('vsync'),
                        SizedBox(width: 4),
                        _headerChip('build'),
                        SizedBox(width: 4),
                        _headerChip('raster'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: Enum Values ──
              _sectionTitle('1. FRAMEPHASE ENUM VALUES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: phases.map((p) => _phaseCard(p)).toList(),
                ),
              ),

              // ── Section 2: Timeline Visualization ──
              _sectionTitle('2. FRAME TIMELINE (SINGLE FRAME)'),
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
                      '16.67ms budget @ 60fps',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Timeline bar
                    _timelineBar(
                      'Idle',
                      0.0,
                      idleGap,
                      16.67,
                      Color(0xFF9E9E9E),
                    ),
                    _timelineBar(
                      'Build',
                      idleGap,
                      buildDuration,
                      16.67,
                      Color(0xFF1565C0),
                    ),
                    _timelineBar(
                      'Raster',
                      idleGap + buildDuration,
                      rasterDuration,
                      16.67,
                      Color(0xFFE65100),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _metricBadge(
                          'Build',
                          '${buildDuration}ms',
                          Color(0xFF1565C0),
                        ),
                        _metricBadge(
                          'Raster',
                          '${rasterDuration}ms',
                          Color(0xFFE65100),
                        ),
                        _metricBadge(
                          'Total',
                          '${totalFrame}ms',
                          Color(0xFF4A148C),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: totalFrame <= 16.67
                            ? Color(0xFFE8F5E9)
                            : Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        totalFrame <= 16.67
                            ? '✓ Within 16.67ms budget — smooth frame'
                            : '✗ Exceeds budget — jank detected',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: totalFrame <= 16.67
                              ? Color(0xFF2E7D32)
                              : Color(0xFFC62828),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 3: Phase Duration Formulas ──
              _sectionTitle('3. DURATION CALCULATIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _formulaRow(
                      'Build Duration',
                      'buildFinish − buildStart',
                      Color(0xFF1565C0),
                    ),
                    _formulaRow(
                      'Raster Duration',
                      'rasterFinish − rasterStart',
                      Color(0xFFE65100),
                    ),
                    _formulaRow(
                      'Total Frame',
                      'rasterFinish − vsyncStart',
                      Color(0xFF4A148C),
                    ),
                    _formulaRow(
                      'Idle Gap',
                      'buildStart − vsyncStart',
                      Color(0xFF9E9E9E),
                    ),
                    SizedBox(height: 10),
                    _codeBlock([
                      'final timing = frameTiming;',
                      '',
                      'int ts(FramePhase p) =>',
                      '    timing.timestampInMicroseconds(p);',
                      '',
                      'final build = ts(FramePhase.buildFinish)',
                      '            - ts(FramePhase.buildStart);',
                      '',
                      'final raster = ts(FramePhase.rasterFinish)',
                      '             - ts(FramePhase.rasterStart);',
                    ]),
                  ],
                ),
              ),

              // ── Section 4: Frame Profiles Comparison ──
              _sectionTitle('4. FRAME PROFILES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    // Header row
                    Row(
                      children: [
                        SizedBox(
                          width: 55,
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Build + Raster',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    ...frameProfiles.map((fp) => _profileRow(fp)),
                    SizedBox(height: 8),
                    // Budget line
                    Stack(
                      children: [
                        Container(
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 16.67 / 50.0,
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(0xFF2E7D32).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '60fps budget: 16.67ms',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 5: DevTools Integration ──
              _sectionTitle('5. DEVTOOLS FRAME DISPLAY'),
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
                      'Flutter DevTools shows these phases in Timeline:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _devtoolsRow(
                      'UI Thread',
                      'buildStart → buildFinish',
                      Color(0xFF1565C0),
                    ),
                    _devtoolsRow(
                      'Raster Thread',
                      'rasterStart → rasterFinish',
                      Color(0xFFE65100),
                    ),
                    _devtoolsRow(
                      'VSync',
                      'vsyncStart marker',
                      Color(0xFF4A148C),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'FramePhase enum values map directly to the columns in '
                        'DevTools Performance view. Use '
                        'SchedulerBinding.instance.addTimingsCallback to capture '
                        'FrameTiming data with phase timestamps.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: API Context ──
              _sectionTitle('6. API CONTEXT'),
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
                    _apiRow(
                      'FramePhase',
                      'Enum',
                      'Identifies each pipeline phase',
                      Color(0xFF1A237E),
                    ),
                    _apiRow(
                      'FrameTiming',
                      'Class',
                      'Contains timestamps for all phases',
                      Color(0xFF00695C),
                    ),
                    _apiRow(
                      'timestampInMicroseconds()',
                      'Method',
                      'Get phase timestamp',
                      Color(0xFFE65100),
                    ),
                    _apiRow(
                      'addTimingsCallback()',
                      'Method',
                      'Register for frame timings',
                      Color(0xFF4A148C),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'FramePhase is the key to FrameTiming. Each FrameTiming instance '
                        'stores microsecond timestamps indexed by FramePhase values. This '
                        'allows precise per-phase profiling of every rendered frame.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF455A64),
                        ),
                      ),
                    ),
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

// ─── DATA CLASSES ──────────────────────────────────────────────────────────

class _PhaseData {
  final String name;
  final double startMs;
  final double durationMs;
  final Color color;
  final IconData icon;
  final String desc;
  _PhaseData(
    this.name,
    this.startMs,
    this.durationMs,
    this.color,
    this.icon,
    this.desc,
  );
}

class _FrameProfile {
  final String label;
  final double buildMs;
  final double rasterMs;
  final double idleMs;
  final bool isJanky;
  _FrameProfile(
    this.label,
    this.buildMs,
    this.rasterMs,
    this.idleMs,
    this.isJanky,
  );
  double get totalMs => buildMs + rasterMs + idleMs;
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

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label, style: TextStyle(fontSize: 10, color: Colors.white)),
  );
}

Widget _phaseCard(_PhaseData phase) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: phase.color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(phase.icon, size: 14, color: Colors.white),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                phase.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: phase.color,
                ),
              ),
              Text(
                phase.desc,
                style: TextStyle(fontSize: 9, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _timelineBar(
  String label,
  double startMs,
  double durMs,
  double budget,
  Color color,
) {
  final startFrac = startMs / budget;
  final durFrac = durMs / budget;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            label,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth * startFrac,
                    child: Container(
                      width: (constraints.maxWidth * durFrac).clamp(
                        4,
                        constraints.maxWidth,
                      ),
                      height: 14,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: Text(
                          '${durMs}ms',
                          style: TextStyle(
                            fontSize: 7,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _metricBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _formulaRow(String label, String formula, Color color) {
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
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            formula,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _profileRow(_FrameProfile fp) {
  final maxMs = 50.0;
  final buildFrac = fp.buildMs / maxMs;
  final rasterFrac = fp.rasterMs / maxMs;
  final color = fp.isJanky ? Color(0xFFC62828) : Color(0xFF2E7D32);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 55,
          child: Row(
            children: [
              Icon(
                fp.isJanky ? Icons.warning : Icons.check_circle,
                size: 10,
                color: color,
              ),
              SizedBox(width: 3),
              Text(
                fp.label,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Container(
                  width: 0,
                  // Use LayoutBuilder in parent for exact sizing
                ),
                // Build segment
                FractionallySizedBox(child: SizedBox()),
              ],
            ),
          ),
        ),
        // Simplified visual: stacked bars
        SizedBox(width: 4),
        Container(
          width: 80,
          height: 12,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (buildFrac + rasterFrac).clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: buildFrac.clamp(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 4),
        SizedBox(
          width: 40,
          child: Text(
            '${fp.totalMs.toStringAsFixed(1)}ms',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _devtoolsRow(String thread, String phases, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            thread,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            phases,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _apiRow(String name, String kind, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 9,
              color: color,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(kind, style: TextStyle(fontSize: 8, color: color)),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      lines.join('\n'),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFF80CBC4),
        height: 1.4,
      ),
    ),
  );
}
