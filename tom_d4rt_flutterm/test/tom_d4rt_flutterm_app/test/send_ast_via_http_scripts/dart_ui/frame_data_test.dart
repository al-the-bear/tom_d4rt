// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for FrameData from dart:ui
// FrameData carries per-frame metadata provided to onBeginFrame callback
// It replaces the raw Duration parameter with structured frame info
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FrameData Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT FRAME DATA
  // ═══════════════════════════════════════════════════════════════════════════

  print(
    'FrameData is the structured parameter for PlatformDispatcher.onBeginFrame',
  );
  print('It wraps the frame timestamp and provides typed access');

  // FrameData was introduced to provide rich frame metadata beyond just a Duration
  print('Previously: onBeginFrame(Duration timeStamp)');
  print('With FrameData: onBeginFrame(FrameData frameData)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: FRAME TIMING CONTEXT
  // ═══════════════════════════════════════════════════════════════════════════

  print('Frame timing in a 60fps pipeline:');
  print('  vsync → begin → build → layout → paint → composite');
  print('  16.67ms budget per frame at 60 fps');
  print('  8.33ms budget per frame at 120 fps');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: RENDERING PIPELINE
  // ═══════════════════════════════════════════════════════════════════════════

  print('Pipeline callbacks:');
  print('  onBeginFrame(FrameData data) → animate, prepare scene');
  print('  onDrawFrame() → build + layout + paint + composite');

  // Simulated frame data for visualization
  final phases = <_PipelinePhase>[
    _PipelinePhase(
      'VSync Signal',
      0.0,
      0.5,
      Color(0xFF4A148C),
      'Display requests new frame',
    ),
    _PipelinePhase(
      'onBeginFrame',
      0.5,
      2.5,
      Color(0xFF1565C0),
      'FrameData delivered with timestamp',
    ),
    _PipelinePhase(
      'Animation',
      2.5,
      5.0,
      Color(0xFF00695C),
      'Advance animations using FrameData timestamp',
    ),
    _PipelinePhase(
      'onDrawFrame',
      5.0,
      5.5,
      Color(0xFFE65100),
      'Framework begins rendering pass',
    ),
    _PipelinePhase(
      'Build',
      5.5,
      8.0,
      Color(0xFF2E7D32),
      'Widget tree construction',
    ),
    _PipelinePhase(
      'Layout',
      8.0,
      10.5,
      Color(0xFF6A1B9A),
      'Size and position calculation',
    ),
    _PipelinePhase(
      'Paint',
      10.5,
      13.5,
      Color(0xFFC62828),
      'Record canvas commands to layers',
    ),
    _PipelinePhase(
      'Composite',
      13.5,
      15.0,
      Color(0xFF455A64),
      'Submit scene to GPU via Scene',
    ),
    _PipelinePhase(
      'Rasterize',
      15.0,
      16.5,
      Color(0xFF880E4F),
      'GPU paints pixels to framebuffer',
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════

  print('FrameData vs Duration:');
  print('  Duration  → just a time value');
  print('  FrameData → frame number + timestamp + metadata');

  // Simulated timeline entries
  final frames = <_FrameEntry>[
    _FrameEntry(0, Duration(milliseconds: 0), 16.4, false),
    _FrameEntry(1, Duration(milliseconds: 16), 15.8, false),
    _FrameEntry(2, Duration(milliseconds: 33), 14.2, false),
    _FrameEntry(3, Duration(milliseconds: 50), 18.7, true),
    _FrameEntry(4, Duration(milliseconds: 67), 12.1, false),
    _FrameEntry(5, Duration(milliseconds: 83), 16.9, true),
    _FrameEntry(6, Duration(milliseconds: 100), 15.3, false),
    _FrameEntry(7, Duration(milliseconds: 116), 11.6, false),
    _FrameEntry(8, Duration(milliseconds: 133), 22.4, true),
    _FrameEntry(9, Duration(milliseconds: 150), 13.7, false),
  ];

  final jankyFrames = frames.where((f) => f.janked).length;
  final avgMs =
      frames.map((f) => f.renderMs).reduce((a, b) => a + b) / frames.length;

  print('FrameData demo complete');

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
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.timer_outlined, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FrameData',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Per-frame metadata for the rendering pipeline',
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
                        _headerChip('onBeginFrame'),
                        SizedBox(width: 6),
                        _headerChip('timestamp'),
                        SizedBox(width: 6),
                        _headerChip('frame #'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: About FrameData ──
              _sectionTitle('1. FRAMEDATA PURPOSE'),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow('Class', 'FrameData', Color(0xFF0D47A1)),
                      _infoRow('Library', 'dart:ui', Color(0xFF2E7D32)),
                      _infoRow(
                        'Delivered via',
                        'PlatformDispatcher.onBeginFrame',
                        Color(0xFFE65100),
                      ),
                      _infoRow(
                        'Contains',
                        'Frame timing information',
                        Color(0xFF4A148C),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'FrameData replaces the raw Duration parameter in '
                          'onBeginFrame, providing structured access to frame '
                          'metadata—particularly the elapsed time since app start.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Section 2: Rendering Pipeline ──
              _sectionTitle('2. RENDERING PIPELINE'),
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
                      '60 fps frame budget: 16.67 ms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...phases.map((p) => _pipelineRow(p, 16.67)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0ms',
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                        Expanded(child: Divider()),
                        Text(
                          '16.67ms',
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 3: Simulated Frame Timeline ──
              _sectionTitle('3. SIMULATED FRAME TIMELINE'),
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
                        _statCard(
                          'Frames',
                          '${frames.length}',
                          Color(0xFF0D47A1),
                        ),
                        SizedBox(width: 8),
                        _statCard('Janky', '$jankyFrames', Color(0xFFC62828)),
                        SizedBox(width: 8),
                        _statCard(
                          'Avg ms',
                          avgMs.toStringAsFixed(1),
                          Color(0xFF2E7D32),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...frames.map((f) => _frameRow(f)),
                  ],
                ),
              ),

              // ── Section 4: FrameData vs Duration ──
              _sectionTitle('4. FRAMEDATA VS DURATION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _comparisonCard('Duration (old)', [
                        'Just elapsed time',
                        'No frame metadata',
                        'Simple but limited',
                      ], Color(0xFF455A64)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _comparisonCard('FrameData (new)', [
                        'Structured metadata',
                        'Frame numbering',
                        'Extensible design',
                      ], Color(0xFF0D47A1)),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Usage Code ──
              _sectionTitle('5. USAGE PATTERN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _codeBlock([
                  'PlatformDispatcher.instance.onBeginFrame =',
                  '    (FrameData data) {',
                  '  // Access frame timing',
                  '  final elapsed = data.frameTimeStamp;',
                  '',
                  '  // Animate based on elapsed time',
                  '  updateAnimations(elapsed);',
                  '',
                  '  // Schedule the draw phase',
                  '  PlatformDispatcher.instance',
                  '      .scheduleFrame();',
                  '};',
                  '',
                  'PlatformDispatcher.instance.onDrawFrame = () {',
                  '  // Build, layout, paint, composite',
                  '  renderFrame();',
                  '};',
                ]),
              ),

              // ── Section 6: FPS Targets ──
              _sectionTitle('6. FPS TARGET BUDGETS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _fpsBudgetRow(30, Color(0xFF455A64)),
                    _fpsBudgetRow(60, Color(0xFF2E7D32)),
                    _fpsBudgetRow(90, Color(0xFF1565C0)),
                    _fpsBudgetRow(120, Color(0xFF4A148C)),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Higher refresh rates give less time per frame. '
                        'FrameData helps identify costly frames for profiling.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Frame Phases ──
              _sectionTitle('7. CALLBACK SEQUENCE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _callbackStep(
                      1,
                      'scheduleFrame()',
                      'Request a new frame from the engine',
                      Color(0xFF4A148C),
                    ),
                    _callbackArrow(),
                    _callbackStep(
                      2,
                      'onBeginFrame(FrameData)',
                      'FrameData delivered with timestamp',
                      Color(0xFF0D47A1),
                    ),
                    _callbackArrow(),
                    _callbackStep(
                      3,
                      'onDrawFrame()',
                      'Framework builds, lays out, paints',
                      Color(0xFF2E7D32),
                    ),
                    _callbackArrow(),
                    _callbackStep(
                      4,
                      'Scene submitted',
                      'Composited layers sent to GPU',
                      Color(0xFFE65100),
                    ),
                    _callbackArrow(),
                    _callbackStep(
                      5,
                      'VSync',
                      'Rasterized pixels displayed',
                      Color(0xFFC62828),
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

class _PipelinePhase {
  final String name;
  final double startMs;
  final double endMs;
  final Color color;
  final String desc;
  _PipelinePhase(this.name, this.startMs, this.endMs, this.color, this.desc);
}

class _FrameEntry {
  final int index;
  final Duration timestamp;
  final double renderMs;
  final bool janked;
  _FrameEntry(this.index, this.timestamp, this.renderMs, this.janked);
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

Widget _infoRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
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
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: Text(
            value,
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

Widget _pipelineRow(_PipelinePhase phase, double budget) {
  final fraction = (phase.endMs - phase.startMs) / budget;
  final offset = phase.startMs / budget;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1),
    child: Row(
      children: [
        SizedBox(
          width: 85,
          child: Text(
            phase.name,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth * offset,
                    child: Container(
                      height: 12,
                      width: (constraints.maxWidth * fraction).clamp(
                        2,
                        constraints.maxWidth,
                      ),
                      decoration: BoxDecoration(
                        color: phase.color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(width: 4),
        Text(
          '${phase.endMs - phase.startMs}ms',
          style: TextStyle(fontSize: 7, color: phase.color),
        ),
      ],
    ),
  );
}

Widget _frameRow(_FrameEntry f) {
  final color = f.janked ? Color(0xFFC62828) : Color(0xFF2E7D32);
  final barWidth = (f.renderMs / 25.0).clamp(0.0, 1.0);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 24,
          child: Text(
            '#${f.index}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${f.timestamp.inMilliseconds}ms',
            style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: barWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Text(
          '${f.renderMs.toStringAsFixed(1)}ms',
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4),
        f.janked
            ? Icon(Icons.warning, size: 10, color: Color(0xFFC62828))
            : Icon(Icons.check_circle, size: 10, color: Color(0xFF2E7D32)),
      ],
    ),
  );
}

Widget _statCard(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _comparisonCard(String title, List<String> points, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        ...points.map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Icon(Icons.check, size: 10, color: color),
                SizedBox(width: 4),
                Flexible(child: Text(p, style: TextStyle(fontSize: 9))),
              ],
            ),
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

Widget _fpsBudgetRow(int fps, Color color) {
  final budget = 1000.0 / fps;
  final barFraction = budget / 40.0; // Scale relative to 40ms
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            '$fps fps',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: barFraction.clamp(0, 1),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${budget.toStringAsFixed(1)} ms',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _callbackStep(int n, String label, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
            Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _callbackArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 9),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}
