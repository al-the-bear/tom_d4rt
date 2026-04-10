// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Deep visual demo — SingleTickerProviderStateMixin
///
/// SingleTickerProviderStateMixin is the standard mixin for State subclasses
/// that need exactly ONE AnimationController. It implements TickerProvider,
/// vending a single Ticker tied to the widget's lifecycle. When the State is
/// disposed, the ticker is automatically cleaned up — preventing leaked
/// animation callbacks and "ticker was not disposed" assertions.
///
/// Sections
/// ─────────
/// 1. What is SingleTickerProviderStateMixin?
/// 2. Mixin anatomy & lifecycle
/// 3. Comparison: Single vs Multi TickerProviderStateMixin
/// 4. Live: pulsing ring animation
/// 5. Live: progress bar with curve control
/// 6. Live: rotation + scale combined animation
/// 7. Common pitfalls
/// 8. Best practices

// ─── palette ───────────────────────────────────────────────
const _kAmber      = Color(0xFFFFA000);
const _kAmberLight = Color(0xFFFFF8E1);
const _kAmberDark  = Color(0xFFE65100);
const _kTealDk     = Color(0xFF00695C);
const _kTealLt     = Color(0xFFB2DFDB);
const _kTealAccent = Color(0xFF00BFA5);
const _kSurface    = Color(0xFFFFFDE7);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── 1. Overview data ──────────────────────────────────────
const _kOverview = 'SingleTickerProviderStateMixin adds TickerProvider to a '
    'State, enabling it to create exactly one Ticker. A Ticker fires a callback '
    'every frame (via SchedulerBinding), which is what drives AnimationController. '
    'By tying the Ticker to the State lifecycle, the mixin ensures animations '
    'are paused when the widget is off-screen and stopped on dispose — no leaks.';

// ─── 2. Lifecycle steps ────────────────────────────────────
class _LifecycleStep {
  const _LifecycleStep(this.stage, this.action, this.detail);
  final String stage;
  final String action;
  final String detail;
}

const _kLifecycle = <_LifecycleStep>[
  _LifecycleStep('initState', 'Create AnimationController(vsync: this)',
      'The mixin becomes the vsync parameter. Internally, createTicker() '
      'is called by the controller, returning a single Ticker.'),
  _LifecycleStep('build / animate', 'Ticker fires every frame',
      'The Ticker callback (via SchedulerBinding.scheduleFrameCallback) '
      'drives the controller\'s value each frame.'),
  _LifecycleStep('deactivate', 'Ticker silenced',
      'When the widget is removed from the tree, the Ticker stops firing. '
      'If the widget is reinserted, the Ticker resumes.'),
  _LifecycleStep('dispose', 'Controller.dispose() disposes Ticker',
      'Calling controller.dispose() in your State\'s dispose method cleans '
      'up the Ticker. The mixin asserts that the Ticker was properly disposed.'),
];

// ─── 3. Comparison rows ────────────────────────────────────
class _CompRow {
  const _CompRow(this.feature, this.single, this.multi);
  final String feature;
  final String single;
  final String multi;
}

const _kComparison = <_CompRow>[
  _CompRow('Tickers allowed', 'Exactly 1', 'Unlimited'),
  _CompRow('Mixin name', 'SingleTickerProviderStateMixin', 'TickerProviderStateMixin'),
  _CompRow('Assertion on >1', 'Throws at runtime', 'No — creates multiple'),
  _CompRow('Performance', 'Slightly lighter', 'Manages a Set<Ticker>'),
  _CompRow('Use when', '1 AnimationController', '2+ AnimationControllers'),
  _CompRow('Common with', 'Simple animated widgets', 'TabController, complex UIs'),
];

// ─── 7. Pitfalls ───────────────────────────────────────────
class _Pitfall {
  const _Pitfall(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}

const _kPitfalls = <_Pitfall>[
  _Pitfall(Icons.warning_amber, 'Creating two controllers',
      'If you need two AnimationControllers, use TickerProviderStateMixin '
      'instead. Single will throw an assertion on the second createTicker().'),
  _Pitfall(Icons.warning_amber, 'Forgetting controller.dispose()',
      'Not disposing the controller in State.dispose() causes a "Ticker was '
      'not disposed" assertion. Always call controller.dispose() explicitly.'),
  _Pitfall(Icons.warning_amber, 'Using outside of State',
      'This mixin is designed for State subclasses only. It relies on the '
      'widget lifecycle (activate/deactivate/dispose). Don\'t use it in '
      'standalone classes — create a Ticker manually instead.'),
  _Pitfall(Icons.warning_amber, 'Mixing with TickerProviderStateMixin',
      'Never mix both SingleTickerProviderStateMixin and '
      'TickerProviderStateMixin on the same State. They both implement '
      'TickerProvider and will conflict.'),
];

// ─── 8. Best practices ─────────────────────────────────────
class _Practice {
  const _Practice(this.tip, this.detail);
  final String tip;
  final String detail;
}

const _kBestPractices = <_Practice>[
  _Practice(
    'Default to Single',
    'Start with SingleTickerProviderStateMixin. Only upgrade to '
    'TickerProviderStateMixin when you genuinely need 2+ controllers.',
  ),
  _Practice(
    'late final for controllers',
    'Declare controllers as late final and initialise in initState. This '
    'documents the intent and prevents accidental reassignment.',
  ),
  _Practice(
    'Pair with AnimatedBuilder',
    'Prefer AnimatedBuilder or AnimatedWidget to avoid calling setState '
    'in animation listeners. Let the builder pattern handle repaints.',
  ),
  _Practice(
    'Respect the mute flag',
    'Tickers are automatically muted when the State is deactivated '
    '(e.g., pushed off-screen). Don\'t try to override this — it\'s how '
    'Flutter avoids wasted frames for invisible animations.',
  ),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kAmberDark, _kTealDk]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kAmber, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('SingleTickerProviderStateMixin deep visual demo');
  print('─' * 48);
  print('Sections: overview, lifecycle, comparison, pulsing ring,');
  print('progress bar, rotation + scale, pitfalls, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAmber, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleTickerProviderStateMixin'),
        backgroundColor: _kAmberDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _PulseDemoPage(), _ProgressDemoPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kAmberDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.radio_button_checked), label: 'Pulse'),
          BottomNavigationBarItem(icon: Icon(Icons.timelapse_outlined), label: 'Progress'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1 ──
        _sectionHeader('1 · What Is SingleTickerProviderStateMixin?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('MINIMAL USAGE'),
              SizedBox(height: 8),
              _mono('class _MyState extends State<MyWidget>'),
              _mono('    with SingleTickerProviderStateMixin {'),
              _mono(''),
              _mono('  late final AnimationController _ctrl;'),
              _mono(''),
              _mono('  @override'),
              _mono('  void initState() {'),
              _mono('    super.initState();'),
              _mono('    _ctrl = AnimationController('),
              _mono('      vsync: this,  // ← the mixin'),
              _mono('      duration: Duration(seconds: 1),'),
              _mono('    );'),
              _mono('  }'),
              _mono(''),
              _mono('  @override'),
              _mono('  void dispose() {'),
              _mono('    _ctrl.dispose();'),
              _mono('    super.dispose();'),
              _mono('  }'),
              _mono('}'),
              SizedBox(height: 8),
              _bullet('vsync: this — the mixin IS the TickerProvider.'),
              _bullet('One AnimationController max. Need more? Use TickerProviderStateMixin.'),
              _bullet('Dispose is mandatory. The mixin asserts it.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2 ──
        _sectionHeader('2 · Mixin Anatomy & Lifecycle', Icons.timeline),
        SizedBox(height: 8),
        ..._kLifecycle.asMap().entries.map((e) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: _kAmber.withOpacity(0.2), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('${e.key + 1}',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: _kAmberDark)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: _kTealLt, borderRadius: BorderRadius.circular(4)),
                      child: Text(e.value.stage,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                              fontWeight: FontWeight.w700, color: _kTealDk)),
                    ),
                    SizedBox(height: 4),
                    Text(e.value.action,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5,
                            color: _kAmberDark)),
                    SizedBox(height: 2),
                    Text(e.value.detail,
                        style: TextStyle(fontSize: 12, color: _kTextDark, height: 1.35)),
                  ],
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · Single vs Multi TickerProvider', Icons.compare_arrows),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('COMPARISON TABLE'),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                border: TableBorder.all(color: _kDivider, width: 0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: _kAmberLight),
                    children: ['Feature', 'Single', 'Multi'].map((h) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(h, style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 10.5, color: _kAmberDark)),
                    )).toList(),
                  ),
                  ..._kComparison.map((r) => TableRow(
                    children: [r.feature, r.single, r.multi].map((c) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
                    )).toList(),
                  )),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 7 ──
        _sectionHeader('7 · Common Pitfalls', Icons.dangerous_outlined),
        SizedBox(height: 8),
        ..._kPitfalls.map((p) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(p.icon, color: _kAmberDark, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13,
                            color: _kAmberDark)),
                    SizedBox(height: 2),
                    Text(p.description,
                        style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                  ],
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kBestPractices.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kTealAccent, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.tip,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                            color: _kTealDk)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(p.detail,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Pulsing ring animation
// ═══════════════════════════════════════════════════════════
class _PulseDemoPage extends StatefulWidget {
  @override
  State<_PulseDemoPage> createState() => _PulseDemoPageState();
}

class _PulseDemoPageState extends State<_PulseDemoPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnim;
  late final Animation<double> _opacityAnim;

  double _durationMs = 1200;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationMs.toInt()),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.5, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOutCubic))
        .animate(_controller);
    _opacityAnim = Tween<double>(begin: 0.3, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
  }

  void _updateDuration(double ms) {
    setState(() {
      _durationMs = ms;
      _controller.duration = Duration(milliseconds: ms.toInt());
      if (_isRunning) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: _kAmberDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PULSING RING — 1 CONTROLLER, 2 ANIMATIONS',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('A single AnimationController drives both scale and '
                  'opacity via chained Tween/CurveTween animations.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5, height: 1.3)),
            ],
          ),
        ),
        // Controls
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: _kAmberDark.withOpacity(0.85),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Duration: ${_durationMs.toInt()} ms',
                      style: TextStyle(color: Colors.white, fontSize: 11)),
                  Expanded(
                    child: Slider(
                      value: _durationMs, min: 200, max: 3000,
                      activeColor: _kTealAccent,
                      onChanged: _updateDuration,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _toggleRunning,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 18),
                    label: Text(_isRunning ? 'Pause' : 'Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kTealDk, foregroundColor: Colors.white),
                  ),
                  SizedBox(width: 12),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Text('value: ${_controller.value.toStringAsFixed(3)}',
                          style: TextStyle(fontFamily: 'monospace', color: Colors.white70,
                              fontSize: 12));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // Visual
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = _pulseAnim.value;
              final opacity = _opacityAnim.value;
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Concentric rings
                    SizedBox(
                      width: 260, height: 260,
                      child: Stack(
                        alignment: Alignment.center,
                        children: List.generate(4, (i) {
                          final ringScale = scale * (0.4 + i * 0.2);
                          final ringOpacity = (opacity * (1.0 - i * 0.2)).clamp(0.0, 1.0);
                          return Transform.scale(
                            scale: ringScale,
                            child: Container(
                              width: 200, height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _kAmber.withOpacity(ringOpacity),
                                  width: 4 - i * 0.8,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Metrics
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _metricBox('Scale', scale.toStringAsFixed(3)),
                        SizedBox(width: 16),
                        _metricBox('Opacity', opacity.toStringAsFixed(3)),
                        SizedBox(width: 16),
                        _metricBox('Status', _controller.isAnimating ? 'Animating' : 'Stopped'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _metricBox(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kAmberLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kAmber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: _kTextMuted, fontWeight: FontWeight.w700)),
          Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 13,
              color: _kAmberDark, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Progress bar with curve selection
// ═══════════════════════════════════════════════════════════
class _ProgressDemoPage extends StatefulWidget {
  @override
  State<_ProgressDemoPage> createState() => _ProgressDemoPageState();
}

class _ProgressDemoPageState extends State<_ProgressDemoPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int _curveIndex = 0;
  static const _curves = <String, Curve>{
    'linear':       Curves.linear,
    'easeIn':       Curves.easeIn,
    'easeOut':      Curves.easeOut,
    'easeInOut':    Curves.easeInOut,
    'bounceOut':    Curves.bounceOut,
    'elasticInOut': Curves.elasticInOut,
    'decelerate':   Curves.decelerate,
    'fastOutSlowIn': Curves.fastOutSlowIn,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = _curves.entries.toList();
    final curveName = entries[_curveIndex].key;
    final curve = entries[_curveIndex].value;
    final curvedAnim = CurvedAnimation(parent: _controller, curve: curve);

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: _kAmberDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PROGRESS & CURVE — ROTATION + SCALE',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('One controller drives a CurvedAnimation. '
                  'Tap the chips below to change the curve live.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5, height: 1.3)),
            ],
          ),
        ),
        // Curve selector
        Container(
          height: 42,
          color: _kAmberDark.withOpacity(0.85),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            itemCount: entries.length,
            itemBuilder: (context, i) {
              final selected = i == _curveIndex;
              return Padding(
                padding: EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _curveIndex = i),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: selected ? _kTealAccent : Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: selected ? _kTealDk : Colors.white24),
                    ),
                    child: Text(entries[i].key,
                        style: TextStyle(
                          fontSize: 10.5, fontWeight: FontWeight.w600,
                          color: selected ? _kTealDk : Colors.white70)),
                  ),
                ),
              );
            },
          ),
        ),
        // Animated display
        Expanded(
          child: AnimatedBuilder(
            animation: curvedAnim,
            builder: (context, child) {
              final t = curvedAnim.value;
              return Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progress: $curveName',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,
                                    color: _kAmberDark)),
                            Text('${(t * 100).toStringAsFixed(1)}%',
                                style: TextStyle(fontFamily: 'monospace', fontSize: 12,
                                    color: _kTealDk, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(height: 6),
                        Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: _kDivider,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: t.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [_kAmber, _kTealAccent]),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    // Rotating + scaling shape
                    Expanded(
                      child: Center(
                        child: Transform.rotate(
                          angle: t * 2 * math.pi,
                          child: Transform.scale(
                            scale: 0.4 + t * 0.6,
                            child: Container(
                              width: 120, height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                                  colors: [
                                    _kAmber.withOpacity(0.3 + t * 0.7),
                                    _kTealAccent.withOpacity(0.3 + t * 0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16 + t * 40),
                                boxShadow: [
                                  BoxShadow(
                                    color: _kAmber.withOpacity(t * 0.4),
                                    blurRadius: 20 + t * 30,
                                    spreadRadius: t * 4,
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text('${(t * 100).toInt()}',
                                  style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w900,
                                    color: Colors.white.withOpacity(0.9),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Raw vs curved values
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _metricTile('Raw value', _controller.value.toStringAsFixed(3)),
                        _metricTile('Curved value', t.toStringAsFixed(3)),
                        _metricTile('Rotation', '${(t * 360).toStringAsFixed(0)}°'),
                        _metricTile('Scale', (0.4 + t * 0.6).toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _metricTile(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kAmberLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kAmber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: _kTextMuted, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 12,
              color: _kAmberDark, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
