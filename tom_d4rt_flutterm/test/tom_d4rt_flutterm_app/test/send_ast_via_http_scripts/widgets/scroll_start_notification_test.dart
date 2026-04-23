import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// ScrollStartNotification — "Scroll Ignition Observer"
// ---------------------------------------------------------------------------
//
// A deep visual exploration of ScrollStartNotification, the notification
// dispatched at the very beginning of a scroll activity.
//
// Fields of ScrollStartNotification (extends ScrollNotification):
//   - metrics       : ScrollMetrics       — snapshot at start (pixels,
//                                           min/maxScrollExtent, viewport).
//   - context       : BuildContext?       — the context where the notification
//                                           is dispatched.
//   - dragDetails   : DragStartDetails?   — non-null for user-initiated
//                                           pointer drags, null for
//                                           programmatic scrolls (animateTo,
//                                           jumpTo may not fire it at all).
//
// Every ScrollStartNotification is eventually paired with a
// ScrollEndNotification. Between them, the scroll activity dispatches
// ScrollUpdateNotifications (and possibly OverscrollNotifications).
//
// This demo is a hand-authored teaching surface. It is NOT a test — it is a
// rich widget built for a d4rt AST harness that returns MaterialApp(home:...)
// via `dynamic build(BuildContext context)`.
//
// Palette:
//   rocketRed     0xFFD7263D
//   inkBlack      0xFF0B0C10
//   ember         0xFFFF6B35
//   starfieldWhite 0xFFF6F7F8
// ---------------------------------------------------------------------------

const Color _rocketRed = Color(0xFFD7263D);
const Color _inkBlack = Color(0xFF0B0C10);
const Color _ember = Color(0xFFFF6B35);
const Color _starfield = Color(0xFFF6F7F8);
const Color _gunmetal = Color(0xFF1F2833);
const Color _steelGrey = Color(0xFF6B7280);
const Color _goldSpark = Color(0xFFFFD166);
const Color _cobalt = Color(0xFF1B4965);

dynamic build(BuildContext context) {
  return const _ScrollIgnitionObserverApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp
// ---------------------------------------------------------------------------

class _ScrollIgnitionObserverApp extends StatelessWidget {
  const _ScrollIgnitionObserverApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScrollStartNotification — Ignition Observer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _inkBlack,
        colorScheme: const ColorScheme.dark(
          primary: _rocketRed,
          secondary: _ember,
          surface: _gunmetal,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: _starfield,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
          titleMedium: TextStyle(
            color: _starfield,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(color: _starfield),
          bodySmall: TextStyle(color: _steelGrey),
        ),
        cardTheme: const CardThemeData(
          color: _gunmetal,
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
        ),
        dividerColor: Colors.white12,
      ),
      home: const _IgnitionObserverHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// Home — top-level layout
// ---------------------------------------------------------------------------

class _IgnitionObserverHome extends StatefulWidget {
  const _IgnitionObserverHome();

  @override
  State<_IgnitionObserverHome> createState() => _IgnitionObserverHomeState();
}

class _IgnitionObserverHomeState extends State<_IgnitionObserverHome>
    with TickerProviderStateMixin {
  // ---- Scroll controllers for the many list views we observe. -----------
  final ScrollController _liveController = ScrollController();
  final ScrollController _causeController = ScrollController();
  final ScrollController _leftController = ScrollController();
  final ScrollController _rightController = ScrollController();
  final ScrollController _timelineStripController = ScrollController();

  // ---- Master ignition log. --------------------------------------------
  final List<_IgnitionEvent> _log = <_IgnitionEvent>[];
  int _eventSerial = 0;

  // ---- Pair tracking (start <-> end). ----------------------------------
  final List<_StartEndPair> _pairs = <_StartEndPair>[];
  _StartEndPair? _openPair;

  // ---- Last DragStartDetails seen (for anatomy card). ------------------
  DragStartDetails? _lastDragDetails;
  String _lastDragSource = '—';

  // ---- Spark canvas state. ---------------------------------------------
  final List<_Spark> _sparks = <_Spark>[];
  late final AnimationController _sparkTicker;

  // ---- Hero flame idle animation. --------------------------------------
  late final AnimationController _flameController;

  // ---- Scroll metric highlights for the "latest" card. -----------------
  _IgnitionEvent? _latestLive;

  @override
  void initState() {
    super.initState();

    _sparkTicker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_advanceSparks);

    _flameController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _liveController.dispose();
    _causeController.dispose();
    _leftController.dispose();
    _rightController.dispose();
    _timelineStripController.dispose();
    _sparkTicker.dispose();
    _flameController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------------ spark
  void _advanceSparks() {
    final double dt = 1 / 60;
    bool dirty = false;
    for (final _Spark s in _sparks) {
      s.life -= dt / 0.6; // 600 ms lifetime
      if (s.life > 0) dirty = true;
    }
    _sparks.removeWhere((_Spark s) => s.life <= 0);
    if (dirty || _sparks.isEmpty) {
      if (mounted) setState(() {});
    }
    if (_sparks.isEmpty) {
      _sparkTicker.stop();
    }
  }

  void _emitSpark(Offset originLocal, Color tint, {double radius = 90}) {
    _sparks.add(_Spark(origin: originLocal, tint: tint, radius: radius));
    if (!_sparkTicker.isAnimating) {
      _sparkTicker.repeat();
    }
  }

  // ---------------------------------------------------------------- logging
  void _recordStart(
    ScrollStartNotification n, {
    required String source,
    Offset? sparkLocal,
    Color? sparkColor,
  }) {
    _eventSerial += 1;
    final _IgnitionEvent evt = _IgnitionEvent(
      id: _eventSerial,
      timestamp: DateTime.now(),
      source: source,
      pixels: n.metrics.pixels,
      min: n.metrics.minScrollExtent,
      max: n.metrics.maxScrollExtent,
      viewport: n.metrics.viewportDimension,
      axis: n.metrics.axis,
      axisDirection: n.metrics.axisDirection,
      hasDrag: n.dragDetails != null,
      globalPosition: n.dragDetails?.globalPosition,
      localPosition: n.dragDetails?.localPosition,
      sourceTimeStamp: n.dragDetails?.sourceTimeStamp,
      kind: n.dragDetails?.kind,
      hasContext: n.context != null,
    );

    // Close any previous open pair of the same source (defensive).
    _log.insert(0, evt);
    if (_log.length > 120) {
      _log.removeRange(120, _log.length);
    }

    _openPair = _StartEndPair(
      id: evt.id,
      source: source,
      startedAt: evt.timestamp,
      hasDrag: evt.hasDrag,
    );

    if (source == 'live') {
      _latestLive = evt;
    }
    if (evt.hasDrag) {
      _lastDragDetails = n.dragDetails;
      _lastDragSource = source;
    }

    if (sparkLocal != null) {
      _emitSpark(sparkLocal, sparkColor ?? _ember);
    }

    if (mounted) setState(() {});
  }

  void _recordEnd(ScrollEndNotification n, {required String source}) {
    final _StartEndPair? open = _openPair;
    if (open != null && open.source == source && open.endedAt == null) {
      open.endedAt = DateTime.now();
      _pairs.insert(0, open);
      if (_pairs.length > 40) {
        _pairs.removeRange(40, _pairs.length);
      }
      _openPair = null;
      if (mounted) setState(() {});
    }
  }

  // ------------------------------------------------------------ programmatic
  Future<void> _programmaticFire() async {
    if (!_causeController.hasClients) return;
    final double target = _causeController.offset > 400 ? 40.0 : 900.0;
    await _causeController.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _programmaticFireLive() async {
    if (!_liveController.hasClients) return;
    final double target = _liveController.offset > 500 ? 0.0 : 1200.0;
    await _liveController.animateTo(
      target,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  // ---------------------------------------------------------------- build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _inkBlack,
        elevation: 0,
        title: const Text('Scroll Ignition Observer'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                'events: ${_log.length}',
                style: const TextStyle(color: _steelGrey, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeroHeader(),
            const SizedBox(height: 24),
            _buildLiveIgnitionSection(),
            const SizedBox(height: 24),
            _buildSparkCanvasSection(),
            const SizedBox(height: 24),
            _buildCauseCompareSection(),
            const SizedBox(height: 24),
            _buildDragAnatomySection(),
            const SizedBox(height: 24),
            _buildIgnitionTimelineSection(),
            const SizedBox(height: 24),
            _buildTwoScrollerSection(),
            const SizedBox(height: 24),
            _buildPairingSection(),
            const SizedBox(height: 24),
            _buildTeachingPanel(),
            const SizedBox(height: 24),
            _buildUseCasesStrip(),
            const SizedBox(height: 24),
            _buildFooterSummary(),
          ],
        ),
      ),
    );
  }

  // ================================================================ HERO
  Widget _buildHeroHeader() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _rocketRed.withValues(alpha: 0.28),
            _ember.withValues(alpha: 0.18),
            _inkBlack,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _rocketRed.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 110,
            height: 110,
            child: AnimatedBuilder(
              animation: _flameController,
              builder: (BuildContext context, Widget? _) {
                return CustomPaint(
                  painter: _HeroFlamePainter(_flameController.value),
                );
              },
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ScrollStartNotification',
                  style: TextStyle(
                    color: _starfield,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "the 'spark' at the start of every scroll",
                  style: TextStyle(
                    color: _ember,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Every scroll activity begins with a single '
                  'ScrollStartNotification. It is the best place to '
                  'snapshot the pre-scroll state, distinguish user drags '
                  'from programmatic animations, and trigger side effects '
                  'like pausing autoplay or recording analytics.',
                  style: TextStyle(
                    color: _starfield,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================== LIVE LIST
  Widget _buildLiveIgnitionSection() {
    return _sectionCard(
      badge: '01',
      title: 'Live ignition catcher',
      subtitle:
          'Drag the list or tap the programmatic button. Every start is logged.',
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _iconButton(
                icon: Icons.play_arrow_rounded,
                label: 'Programmatic animateTo',
                onPressed: _programmaticFireLive,
              ),
              const SizedBox(width: 10),
              _iconButton(
                icon: Icons.restart_alt_rounded,
                label: 'Clear log',
                onPressed: () {
                  setState(() {
                    _log.clear();
                    _pairs.clear();
                    _openPair = null;
                    _latestLive = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Builder(
                    builder: (BuildContext ctx) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _inkBlack,
                            border: Border.all(
                              color: _rocketRed.withValues(alpha: 0.25),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification n) {
                              if (n is ScrollStartNotification) {
                                final RenderBox? box =
                                    ctx.findRenderObject() as RenderBox?;
                                Offset? sparkLocal;
                                if (box != null) {
                                  if (n.dragDetails != null) {
                                    final Offset global =
                                        n.dragDetails!.globalPosition;
                                    sparkLocal = box.globalToLocal(global);
                                  } else {
                                    sparkLocal = Offset(
                                      box.size.width / 2,
                                      box.size.height / 2,
                                    );
                                  }
                                }
                                _recordStart(
                                  n,
                                  source: 'live',
                                  sparkLocal: sparkLocal,
                                  sparkColor: n.dragDetails != null
                                      ? _rocketRed
                                      : _goldSpark,
                                );
                              } else if (n is ScrollEndNotification) {
                                _recordEnd(n, source: 'live');
                              }
                              return false;
                            },
                            child: ListView.builder(
                              controller: _liveController,
                              padding: const EdgeInsets.all(8),
                              itemCount: 40,
                              itemBuilder: (BuildContext c, int i) {
                                final Color tile = HSVColor.fromAHSV(
                                  1.0,
                                  (i * 9) % 360,
                                  0.55,
                                  0.75,
                                ).toColor();
                                return Container(
                                  height: 56,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: tile.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: _inkBlack
                                            .withValues(alpha: 0.45),
                                        child: Text(
                                          '${i + 1}',
                                          style: const TextStyle(
                                            color: _starfield,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Tile ${i + 1} — scroll me',
                                        style: const TextStyle(
                                          color: _starfield,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(flex: 6, child: _buildLatestStartCard()),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildLogPanel(),
        ],
      ),
    );
  }

  Widget _buildLatestStartCard() {
    final _IgnitionEvent? e = _latestLive;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _gunmetal,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _rocketRed.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Latest start (live list)',
            style: TextStyle(
              color: _ember,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          if (e == null)
            const Text(
              'No scroll started yet. Drag the list to ignite.',
              style: TextStyle(color: _steelGrey, fontSize: 12),
            )
          else ...<Widget>[
            _kv('event #', e.id.toString()),
            _kv('source', e.source),
            _kv('pixels', e.pixels.toStringAsFixed(2)),
            _kv(
              'min / max',
              '${e.min.toStringAsFixed(1)} .. ${e.max.toStringAsFixed(1)}',
            ),
            _kv('viewport', e.viewport.toStringAsFixed(1)),
            _kv('axis', '${e.axis}'),
            _kv('axisDirection', '${e.axisDirection}'),
            _kv('hasDrag', e.hasDrag ? 'true (user)' : 'false (programmatic)'),
            if (e.globalPosition != null)
              _kv(
                'globalPosition',
                '(${e.globalPosition!.dx.toStringAsFixed(1)}, '
                    '${e.globalPosition!.dy.toStringAsFixed(1)})',
              ),
            if (e.kind != null) _kv('pointer kind', '${e.kind}'),
          ],
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              k,
              style: const TextStyle(color: _steelGrey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                color: _starfield,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogPanel() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _inkBlack,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.terminal, size: 14, color: _ember),
              SizedBox(width: 6),
              Text(
                'ignition log',
                style: TextStyle(
                  color: _ember,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: _log.isEmpty
                ? const Center(
                    child: Text(
                      '(no starts yet)',
                      style: TextStyle(color: _steelGrey, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    itemCount: _log.length,
                    itemBuilder: (BuildContext c, int i) {
                      final _IgnitionEvent e = _log[i];
                      final Color chip = e.hasDrag ? _rocketRed : _goldSpark;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: chip,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _fmtTime(e.timestamp),
                              style: const TextStyle(
                                color: _steelGrey,
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 56,
                              child: Text(
                                '#${e.id}',
                                style: const TextStyle(
                                  color: _starfield,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 78,
                              child: Text(
                                e.source,
                                style: const TextStyle(
                                  color: _ember,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 76,
                              child: Text(
                                e.hasDrag ? 'DRAG' : 'PROG',
                                style: TextStyle(
                                  color: chip,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'px=${e.pixels.toStringAsFixed(1)}  '
                                'vp=${e.viewport.toStringAsFixed(0)}  '
                                '${e.globalPosition == null ? '' : 'g=(${e.globalPosition!.dx.toStringAsFixed(0)},${e.globalPosition!.dy.toStringAsFixed(0)})'}',
                                style: const TextStyle(
                                  color: _starfield,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================ SPARK CANVAS
  Widget _buildSparkCanvasSection() {
    return _sectionCard(
      badge: '02',
      title: 'Spark canvas',
      subtitle:
          'Each ignition drops an animated starburst where the drag began. '
          'Programmatic starts spark in the center.',
      child: SizedBox(
        height: 220,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            _cobalt.withValues(alpha: 0.35),
                            _inkBlack,
                          ],
                          radius: 0.9,
                        ),
                      ),
                      child: CustomPaint(
                        painter: _SparkCanvasPainter(sparks: _sparks),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: Row(
                    children: <Widget>[
                      _legendDot('drag start', _rocketRed),
                      const SizedBox(width: 10),
                      _legendDot('programmatic', _goldSpark),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.auto_awesome, size: 16),
                    label: const Text('test spark'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _rocketRed,
                      foregroundColor: _starfield,
                    ),
                    onPressed: () {
                      final double w = constraints.maxWidth;
                      final double h = constraints.maxHeight;
                      final math.Random r = math.Random();
                      _emitSpark(
                        Offset(r.nextDouble() * w, r.nextDouble() * h),
                        _ember,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _legendDot(String label, Color c) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: _starfield, fontSize: 11),
        ),
      ],
    );
  }

  // =========================================================== CAUSE COMPARE
  Widget _buildCauseCompareSection() {
    return _sectionCard(
      badge: '03',
      title: 'Cause of start — user vs programmatic',
      subtitle:
          'The same notification, two completely different origins. The '
          'dragDetails field is the giveaway.',
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _causeCard(
                  title: 'User drag start',
                  accent: _rocketRed,
                  bullet: 'dragDetails != null',
                  description:
                      'Finger / mouse / trackpad drag. Framework emits '
                      'ScrollStartNotification with DragStartDetails that '
                      'include globalPosition, localPosition, sourceTimeStamp '
                      'and PointerDeviceKind.',
                  action: const _HintText(
                      '↙ scroll the list on the right to fire'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _causeCard(
                  title: 'Programmatic animateTo',
                  accent: _goldSpark,
                  bullet: 'dragDetails == null',
                  description:
                      'controller.animateTo / ScrollPosition.goBallistic. '
                      'Fires ScrollStartNotification without drag metadata. '
                      'Use this to distinguish UI automation from human '
                      'scrolling for analytics.',
                  action: ElevatedButton.icon(
                    icon: const Icon(Icons.bolt, size: 16),
                    label: const Text('animateTo'),
                    onPressed: _programmaticFire,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _goldSpark,
                      foregroundColor: _inkBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: _inkBlack,
                  border: Border.all(color: _goldSpark.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification n) {
                    if (n is ScrollStartNotification) {
                      _recordStart(
                        n,
                        source: n.dragDetails == null ? 'cause/prog' : 'cause',
                        sparkLocal: Offset(220, 90),
                        sparkColor:
                            n.dragDetails == null ? _goldSpark : _rocketRed,
                      );
                    } else if (n is ScrollEndNotification) {
                      _recordEnd(n,
                          source: n.dragDetails == null
                              ? 'cause/prog'
                              : 'cause');
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: _causeController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: 32,
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              HSVColor.fromAHSV(1, (i * 11) % 360, 0.5, 0.8)
                                  .toColor(),
                              _inkBlack,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'card ${i + 1}',
                            style: const TextStyle(
                              color: _starfield,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _causeCard({
    required String title,
    required Color accent,
    required String bullet,
    required String description,
    required Widget action,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _gunmetal,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: _starfield,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              bullet,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _starfield,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          action,
        ],
      ),
    );
  }

  // ============================================================= DRAG ANATOMY
  Widget _buildDragAnatomySection() {
    final DragStartDetails? d = _lastDragDetails;
    return _sectionCard(
      badge: '04',
      title: 'DragStartDetails — anatomy',
      subtitle: 'Live-updated from the most recent user drag start.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _gunmetal,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _rocketRed.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'last drag',
                    style: TextStyle(
                      color: _ember,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (d == null)
                    const Text(
                      'No user drag yet. Touch the live list above.',
                      style: TextStyle(color: _steelGrey, fontSize: 12),
                    )
                  else ...<Widget>[
                    _kv('source', _lastDragSource),
                    _kv(
                      'globalPosition',
                      '(${d.globalPosition.dx.toStringAsFixed(2)}, '
                          '${d.globalPosition.dy.toStringAsFixed(2)})',
                    ),
                    _kv(
                      'localPosition',
                      '(${d.localPosition.dx.toStringAsFixed(2)}, '
                          '${d.localPosition.dy.toStringAsFixed(2)})',
                    ),
                    _kv(
                      'sourceTimeStamp',
                      d.sourceTimeStamp == null
                          ? '—'
                          : '${d.sourceTimeStamp!.inMicroseconds} µs',
                    ),
                    _kv('kind', '${d.kind}'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _inkBlack,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _AnatomyRow(
                    field: 'globalPosition',
                    type: 'Offset',
                    desc:
                        'Where the drag begins in logical pixels relative to '
                        'the screen.',
                  ),
                  _AnatomyRow(
                    field: 'localPosition',
                    type: 'Offset',
                    desc:
                        'Same point but relative to the gesture detector that '
                        'captured the pointer.',
                  ),
                  _AnatomyRow(
                    field: 'sourceTimeStamp',
                    type: 'Duration?',
                    desc:
                        "The platform's timestamp for the pointer down event "
                        'that caused the drag start.',
                  ),
                  _AnatomyRow(
                    field: 'kind',
                    type: 'PointerDeviceKind?',
                    desc:
                        'touch, mouse, stylus, trackpad, invertedStylus — '
                        'useful for input-specific handling.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================= IGNITION TIMELINE
  Widget _buildIgnitionTimelineSection() {
    final List<_IgnitionEvent> last = _log.take(20).toList().reversed.toList();
    return _sectionCard(
      badge: '05',
      title: 'Ignition timeline',
      subtitle: 'The last 20 starts as coloured chips (red = drag, '
          'grey/gold = programmatic).',
      child: SizedBox(
        height: 92,
        child: last.isEmpty
            ? _emptyStrip('drag or animateTo to begin')
            : ListView.builder(
                controller: _timelineStripController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                itemCount: last.length,
                itemBuilder: (BuildContext c, int i) {
                  final _IgnitionEvent e = last[i];
                  final bool drag = e.hasDrag;
                  final Color chip = drag ? _rocketRed : _goldSpark;
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: chip.withValues(alpha: 0.14),
                      border: Border.all(color: chip.withValues(alpha: 0.55)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              e.axis == Axis.horizontal
                                  ? Icons.swap_horiz
                                  : Icons.swap_vert,
                              size: 14,
                              color: chip,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '#${e.id}',
                              style: TextStyle(
                                color: chip,
                                fontFamily: 'monospace',
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          drag ? 'DRAG' : 'PROG',
                          style: TextStyle(
                            color: chip,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          e.source,
                          style: const TextStyle(
                            color: _starfield,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _fmtTime(e.timestamp),
                          style: const TextStyle(
                            color: _steelGrey,
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _emptyStrip(String msg) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _inkBlack,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        '($msg)',
        style: const TextStyle(color: _steelGrey, fontSize: 12),
      ),
    );
  }

  // ============================================================ TWO SCROLLERS
  Widget _buildTwoScrollerSection() {
    return _sectionCard(
      badge: '06',
      title: 'Two-scroller demo',
      subtitle:
          'Notifications are per-scrollable, but one observer hears both. '
          'The source label changes based on which list ignited.',
      child: SizedBox(
        height: 280,
        child: Row(
          children: <Widget>[
            Expanded(
              child: _scrollerPane(
                label: 'LEFT',
                accent: _ember,
                controller: _leftController,
                source: 'left',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _scrollerPane(
                label: 'RIGHT',
                accent: _cobalt,
                controller: _rightController,
                source: 'right',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollerPane({
    required String label,
    required Color accent,
    required ScrollController controller,
    required String source,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: _inkBlack,
          border: Border.all(color: accent.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: accent.withValues(alpha: 0.25),
              child: Row(
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'source="$source"',
                    style: const TextStyle(
                      color: _steelGrey,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification n) {
                  if (n is ScrollStartNotification) {
                    _recordStart(
                      n,
                      source: source,
                      sparkColor: accent,
                    );
                  } else if (n is ScrollEndNotification) {
                    _recordEnd(n, source: source);
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.all(8),
                  itemCount: 50,
                  itemBuilder: (BuildContext c, int i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$label item ${i + 1}',
                        style: const TextStyle(color: _starfield),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================ PAIRING VIEW
  Widget _buildPairingSection() {
    final List<_StartEndPair> closed =
        _pairs.take(10).toList().reversed.toList();
    return _sectionCard(
      badge: '07',
      title: 'Start / End pairing',
      subtitle: 'Every ScrollStartNotification eventually matches a '
          'ScrollEndNotification. Here are the last 10 spans.',
      child: Column(
        children: <Widget>[
          if (closed.isEmpty)
            _emptyStrip('no completed spans yet')
          else
            Column(
              children: closed.map(_pairRow).toList(),
            ),
          if (_openPair != null) ...<Widget>[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _ember.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _ember.withValues(alpha: 0.6)),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.radio_button_checked,
                      color: _ember, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'open pair — start #${_openPair!.id} '
                    '(${_openPair!.source}) — waiting for ScrollEndNotification',
                    style: const TextStyle(
                      color: _ember,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _pairRow(_StartEndPair p) {
    final Duration dur = p.endedAt!.difference(p.startedAt);
    final Color accent = p.hasDrag ? _rocketRed : _goldSpark;
    final double widthFactor =
        (dur.inMilliseconds.clamp(50, 1500)) / 1500.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 52,
            child: Text(
              '#${p.id}',
              style: const TextStyle(
                color: _starfield,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 84,
            child: Text(
              p.source,
              style: const TextStyle(
                color: _ember,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          accent,
                          accent.withValues(alpha: 0.25),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 76,
            child: Text(
              '${dur.inMilliseconds} ms',
              style: const TextStyle(
                color: _starfield,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================ TEACHING PANEL
  Widget _buildTeachingPanel() {
    return _sectionCard(
      badge: '08',
      title: 'Teaching panel',
      subtitle: 'Three rules worth internalising.',
      child: Column(
        children: const <Widget>[
          _TeachTile(
            icon: Icons.save_alt,
            accent: _rocketRed,
            title: 'Snapshot the pre-scroll state',
            body: 'Use ScrollStartNotification to capture the initial pixels '
                'and selection state — perfect for undo or restore flows that '
                'need to remember where the user began.',
          ),
          SizedBox(height: 10),
          _TeachTile(
            icon: Icons.call_split,
            accent: _ember,
            title: 'User vs programmatic = dragDetails != null',
            body: 'Programmatic animateTo still dispatches '
                'ScrollStartNotification. Differentiate by inspecting the '
                'dragDetails field: null means it was code-driven.',
          ),
          SizedBox(height: 10),
          _TeachTile(
            icon: Icons.schedule,
            accent: _goldSpark,
            title: "Don't setState synchronously for layout",
            body: 'If your listener triggers layout-changing rebuilds, '
                'defer to WidgetsBinding.instance.addPostFrameCallback — '
                'the notification fires mid-gesture dispatch.',
          ),
        ],
      ),
    );
  }

  // =========================================================== USE CASES STRIP
  Widget _buildUseCasesStrip() {
    return _sectionCard(
      badge: '09',
      title: 'Common use cases',
      subtitle: 'Four recurring patterns that key off the start notification.',
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.6,
        children: const <Widget>[
          _UseCaseTile(
            icon: Icons.pause_circle,
            title: 'Pause autoplay',
            body:
                'Pause a video or hero carousel the moment the user starts '
                'scrolling away from it.',
            accent: _rocketRed,
          ),
          _UseCaseTile(
            icon: Icons.hourglass_disabled,
            title: 'Hide loading indicator',
            body:
                'When the user scrolls, dismiss a floating "loading" hint — '
                'they already know content is coming.',
            accent: _ember,
          ),
          _UseCaseTile(
            icon: Icons.analytics,
            title: 'Analytics event',
            body:
                'Record a scroll_started event for funnel analytics, tagged '
                'with the starting offset.',
            accent: _goldSpark,
          ),
          _UseCaseTile(
            icon: Icons.center_focus_strong,
            title: 'Recompute snap target',
            body:
                'Recalculate the nearest snap point before the scroll '
                'continues — critical for custom ScrollPhysics.',
            accent: _cobalt,
          ),
        ],
      ),
    );
  }

  // ============================================================ FOOTER SUMMARY
  Widget _buildFooterSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _rocketRed.withValues(alpha: 0.35),
            _cobalt.withValues(alpha: 0.35),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ember.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.local_fire_department,
              color: _goldSpark, size: 40),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Recap',
                  style: TextStyle(
                    color: _starfield,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ScrollStartNotification is the single source of truth for '
                  '"a scroll just began". Listen for it once, branch on '
                  'dragDetails, snapshot whatever you need, and wait for the '
                  'matching ScrollEndNotification to close the loop.',
                  style: TextStyle(
                    color: _starfield,
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ helpers
  Widget _sectionCard({
    required String badge,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _rocketRed.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: _starfield,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _starfield,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: _steelGrey, fontSize: 12),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 16),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _ember,
        foregroundColor: _inkBlack,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static String _fmtTime(DateTime t) {
    String two(int n) => n < 10 ? '0$n' : '$n';
    String three(int n) {
      if (n < 10) return '00$n';
      if (n < 100) return '0$n';
      return '$n';
    }

    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.'
        '${three(t.millisecond)}';
  }
}

// ---------------------------------------------------------------------------
// Support widgets
// ---------------------------------------------------------------------------

class _HintText extends StatelessWidget {
  const _HintText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: _steelGrey, fontSize: 12),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.field,
    required this.type,
    required this.desc,
  });

  final String field;
  final String type;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                field,
                style: const TextStyle(
                  color: _ember,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: _goldSpark.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    color: _goldSpark,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            desc,
            style: const TextStyle(
              color: _starfield,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeachTile extends StatelessWidget {
  const _TeachTile({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _starfield,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _gunmetal,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: accent, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    color: _starfield,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data classes
// ---------------------------------------------------------------------------

class _IgnitionEvent {
  _IgnitionEvent({
    required this.id,
    required this.timestamp,
    required this.source,
    required this.pixels,
    required this.min,
    required this.max,
    required this.viewport,
    required this.axis,
    required this.axisDirection,
    required this.hasDrag,
    required this.globalPosition,
    required this.localPosition,
    required this.sourceTimeStamp,
    required this.kind,
    required this.hasContext,
  });

  final int id;
  final DateTime timestamp;
  final String source;
  final double pixels;
  final double min;
  final double max;
  final double viewport;
  final Axis axis;
  final AxisDirection axisDirection;
  final bool hasDrag;
  final Offset? globalPosition;
  final Offset? localPosition;
  final Duration? sourceTimeStamp;
  final Object? kind;
  final bool hasContext;
}

class _StartEndPair {
  _StartEndPair({
    required this.id,
    required this.source,
    required this.startedAt,
    required this.hasDrag,
  });

  final int id;
  final String source;
  final DateTime startedAt;
  final bool hasDrag;
  DateTime? endedAt;
}

class _Spark {
  _Spark({
    required this.origin,
    required this.tint,
    required this.radius,
  }) : life = 1.0;

  final Offset origin;
  final Color tint;
  final double radius;
  double life;
}

// ---------------------------------------------------------------------------
// Painters
// ---------------------------------------------------------------------------

class _HeroFlamePainter extends CustomPainter {
  _HeroFlamePainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double baseR = size.shortestSide * 0.38;

    // outer halo
    final Paint halo = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _goldSpark.withValues(alpha: 0.55),
          _ember.withValues(alpha: 0.25),
          _rocketRed.withValues(alpha: 0.0),
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: baseR * 1.4));
    canvas.drawCircle(c, baseR * 1.4, halo);

    // starburst lines
    final int rays = 16;
    final Paint rayPaint = Paint()
      ..color = _goldSpark.withValues(alpha: 0.9)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < rays; i++) {
      final double a = (i / rays) * math.pi * 2 + t * math.pi * 2;
      final double len =
          baseR * (0.55 + 0.25 * math.sin(t * math.pi * 2 + i * 0.7));
      final Offset p1 = c + Offset(math.cos(a) * baseR * 0.25,
          math.sin(a) * baseR * 0.25);
      final Offset p2 = c + Offset(math.cos(a) * len, math.sin(a) * len);
      canvas.drawLine(p1, p2, rayPaint);
    }

    // inner ember core
    final Paint core = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _starfield,
          _goldSpark,
          _ember,
          _rocketRed.withValues(alpha: 0.0),
        ],
        stops: const <double>[0.0, 0.25, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: baseR * 0.55));
    canvas.drawCircle(c, baseR * 0.55, core);

    // flickering inner dot
    final double flicker = 0.7 + 0.3 * math.sin(t * math.pi * 4);
    final Paint dot = Paint()
      ..color = _starfield.withValues(alpha: flicker);
    canvas.drawCircle(c, baseR * 0.12, dot);
  }

  @override
  bool shouldRepaint(covariant _HeroFlamePainter oldDelegate) =>
      oldDelegate.t != t;
}

class _SparkCanvasPainter extends CustomPainter {
  _SparkCanvasPainter({required this.sparks});

  final List<_Spark> sparks;

  @override
  void paint(Canvas canvas, Size size) {
    // faint grid
    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 36) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 36) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    for (final _Spark s in sparks) {
      final double t = 1 - s.life.clamp(0.0, 1.0);
      final double r = s.radius * (0.2 + 0.8 * t);
      final Color core = s.tint.withValues(alpha: (1 - t).clamp(0.0, 1.0));

      // halo
      final Paint halo = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            core.withValues(alpha: 0.55 * (1 - t)),
            core.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: s.origin, radius: r));
      canvas.drawCircle(s.origin, r, halo);

      // rays
      final int rays = 12;
      final Paint rayPaint = Paint()
        ..color = core
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;
      for (int i = 0; i < rays; i++) {
        final double a = (i / rays) * math.pi * 2;
        final Offset p1 =
            s.origin + Offset(math.cos(a) * r * 0.1, math.sin(a) * r * 0.1);
        final Offset p2 =
            s.origin + Offset(math.cos(a) * r, math.sin(a) * r);
        canvas.drawLine(p1, p2, rayPaint);
      }

      // center dot
      final Paint dot = Paint()
        ..color = Colors.white.withValues(alpha: (1 - t).clamp(0.0, 1.0));
      canvas.drawCircle(s.origin, 3, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _SparkCanvasPainter oldDelegate) => true;
}
