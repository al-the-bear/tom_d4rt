// -----------------------------------------------------------------------------
// restorable_value_test.dart
// -----------------------------------------------------------------------------
//
// Deep demonstration of `RestorableValue<T>` from package:flutter/widgets.dart
// (re-exported through material.dart).
//
// RestorableValue<T> vs RestorableProperty<T>
// -------------------------------------------
// `RestorableProperty<T>` is the abstract root of the restoration system. To
// subclass it directly you must implement `createDefaultValue`, `fromPrimitives`,
// `toPrimitives`, and `initWithValue` yourself, plus expose whatever accessor
// you want callers to use.
//
// `RestorableValue<T>` is the convenience tier just above that: it assumes the
// property wraps a single scalar `T value`, it pre-wires a `get value` / `set
// value` pair, and it pre-implements `initWithValue` to stash the incoming
// value. In exchange it asks subclasses to implement `didUpdateValue(T?
// oldValue)` — an abstract hook that fires every time the setter assigns a new
// value, so the subclass can call `notifyListeners()` if the primitive form of
// the state changed.
//
// Concretely: every scalar Restorable* class that Flutter ships
// (RestorableBool, RestorableInt, RestorableDouble, RestorableString,
// RestorableEnum, etc.) extends RestorableValue<T> via internal helpers like
// `_RestorablePrimitiveValue`. RestorableValue<T> is the class you subclass
// when you have a single scalar value to persist.
//
// This test file builds two REAL RestorableValue<T> subclasses:
//
//   * `_RestorableDuration`  — stores Duration as `inMicroseconds` int.
//   * `_RestorableOffset`    — stores Offset as `[dx, dy]` list of doubles.
//
// Both are used inside a StopwatchPointerDemo widget that narrates a
// stopwatch/laps/pointer-tracker UX. A RestorationInspector card reveals the
// live value vs. the primitive representation so you can see the serialisation
// contract.
//
// Harness notes:
//   * Entry point is `dynamic build(BuildContext context)` — NO main().
//   * Analyzer must emit zero issues. No ignore_for_file anywhere.
//   * Imports: only material.dart + dart:async.
//
// -----------------------------------------------------------------------------

import 'dart:async';

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — midnight navy + neon cyan + warm off-white.
// ---------------------------------------------------------------------------

const Color _kMidnight = Color(0xFF0B132B);
const Color _kDeepNavy = Color(0xFF111E3F);
const Color _kNavyCard = Color(0xFF17254B);
const Color _kNeonCyan = Color(0xFF3DE0FF);
const Color _kSoftCyan = Color(0xFF7DEEFF);
const Color _kOffWhite = Color(0xFFF4F1E8);
const Color _kWarmGrey = Color(0xFFBFB9A8);
const Color _kDangerRed = Color(0xFFFF6B6B);
const Color _kAmberTick = Color(0xFFFFC857);
const Color _kGreenLap = Color(0xFF6BE585);

// ---------------------------------------------------------------------------
// Entry point required by the test harness.
// ---------------------------------------------------------------------------

/// Builds the restorable_value_test demo root.
///
/// The harness injects a [BuildContext] and expects a [Widget]. We return a
/// [MaterialApp] so that Flutter's standard material theming, navigation, and
/// restoration wiring are available.
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'RestorableValue<T> Demo',
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'restorable_value_demo_root',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kMidnight,
      colorScheme: const ColorScheme.dark(
        primary: _kNeonCyan,
        secondary: _kSoftCyan,
        surface: _kNavyCard,
        onPrimary: _kMidnight,
        onSecondary: _kMidnight,
        onSurface: _kOffWhite,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kOffWhite, fontSize: 14),
        bodySmall: TextStyle(color: _kWarmGrey, fontSize: 12),
        titleLarge: TextStyle(
          color: _kOffWhite,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: _kOffWhite,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: _kMidnight,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    home: const StopwatchPointerDemo(),
  );
}

// ---------------------------------------------------------------------------
// Custom RestorableValue<T> subclasses. These are the pedagogical payload.
// ---------------------------------------------------------------------------

/// A [RestorableValue<Duration>] that persists a [Duration] as its
/// `inMicroseconds` integer representation.
///
/// Why microseconds? The restoration pipeline serialises primitives through
/// the `StandardMessageCodec`, which handles ints losslessly. Encoding a
/// `Duration` as its microsecond count is the canonical round-trippable form.
///
/// This class demonstrates the minimum viable `RestorableValue<T>` subclass:
/// four overrides plus a constructor that captures the default value. Because
/// `RestorableValue<T>` pre-implements `initWithValue` and the `value`
/// getter/setter, we do not need to touch them.
class _RestorableDuration extends RestorableValue<Duration> {
  _RestorableDuration(this._defaultValue);

  final Duration _defaultValue;

  @override
  Duration createDefaultValue() => _defaultValue;

  @override
  Duration fromPrimitives(Object? data) {
    if (data is int) {
      return Duration(microseconds: data);
    }
    // Defensive fallback — corrupted or missing data falls back to default.
    return _defaultValue;
  }

  @override
  Object? toPrimitives() => value.inMicroseconds;

  @override
  void didUpdateValue(Duration? oldValue) {
    // Notify listeners whenever the serialised form might change. For Duration
    // the primitive is the microsecond count, so any change to `value` changes
    // the primitive and therefore warrants a notification.
    notifyListeners();
  }
}

/// A [RestorableValue<Offset>] that persists an [Offset] as a two-element
/// list of doubles: `[dx, dy]`.
///
/// Lists of primitive types survive the restoration codec intact, which makes
/// `[dx, dy]` a safe serialised form. The reverse path tolerates absent or
/// malformed data by falling back to the default offset.
class _RestorableOffset extends RestorableValue<Offset> {
  _RestorableOffset(this._defaultValue);

  final Offset _defaultValue;

  @override
  Offset createDefaultValue() => _defaultValue;

  @override
  Offset fromPrimitives(Object? data) {
    if (data is List && data.length == 2) {
      final Object? dx = data[0];
      final Object? dy = data[1];
      if (dx is num && dy is num) {
        return Offset(dx.toDouble(), dy.toDouble());
      }
    }
    return _defaultValue;
  }

  @override
  Object? toPrimitives() => <double>[value.dx, value.dy];

  @override
  void didUpdateValue(Offset? oldValue) {
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------
// The StopwatchPointerDemo widget — the UX wrapper around the two custom
// RestorableValue subclasses above, plus a stock RestorableBool.
// ---------------------------------------------------------------------------

class StopwatchPointerDemo extends StatefulWidget {
  const StopwatchPointerDemo({super.key});

  @override
  State<StopwatchPointerDemo> createState() => _StopwatchPointerDemoState();
}

class _StopwatchPointerDemoState extends State<StopwatchPointerDemo>
    with RestorationMixin {
  // ---- Restorable fields --------------------------------------------------
  //
  // These four fields are the persistent state of the demo. Each one needs a
  // `dispose()` call and a `registerForRestoration` call in `restoreState`.
  //
  // `_laps` is intentionally NOT a RestorableProperty: Flutter's core widgets
  // library does not ship a RestorableStringList, and rolling a real one here
  // would distract from the RestorableValue<T> teaching goal. Lap history
  // therefore survives the widget tree but not a full restoration roundtrip —
  // this is called out explicitly in the RestorationInspector card.

  final _RestorableDuration _elapsed =
      _RestorableDuration(const Duration(seconds: 47));
  final _RestorableDuration _lapDuration =
      _RestorableDuration(Duration.zero);
  final _RestorableOffset _pointerPosition =
      _RestorableOffset(const Offset(120, 80));
  final RestorableBool _running = RestorableBool(false);

  final List<String> _laps = <String>[];

  Timer? _tickTimer;

  // ---- Lifecycle ----------------------------------------------------------

  @override
  String? get restorationId => 'stopwatch_pointer_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_elapsed, 'elapsed');
    registerForRestoration(_lapDuration, 'lap_duration');
    registerForRestoration(_pointerPosition, 'pointer_position');
    registerForRestoration(_running, 'running');

    // If we restored with the stopwatch already running, resume ticking.
    if (_running.value) {
      _startTicker();
    }
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    _tickTimer = null;

    _elapsed.dispose();
    _lapDuration.dispose();
    _pointerPosition.dispose();
    _running.dispose();

    super.dispose();
  }

  // ---- Ticker -------------------------------------------------------------

  void _startTicker() {
    debugPrint('[RestorableValue demo] Starting 100ms ticker.');
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      _onTick,
    );
  }

  void _stopTicker() {
    debugPrint('[RestorableValue demo] Stopping ticker.');
    _tickTimer?.cancel();
    _tickTimer = null;
  }

  void _onTick(Timer timer) {
    if (!mounted) {
      timer.cancel();
      return;
    }
    // Advance elapsed by 100ms. The assignment goes through the RestorableValue
    // setter, which fires didUpdateValue -> notifyListeners, so any listener
    // (and RestorationMixin's writer) sees the update.
    _elapsed.value = _elapsed.value + const Duration(milliseconds: 100);
    setState(() {});
  }

  // ---- Stopwatch controls -------------------------------------------------

  void _toggleRunning() {
    if (_running.value) {
      _running.value = false;
      _stopTicker();
    } else {
      _running.value = true;
      _startTicker();
    }
    setState(() {});
  }

  void _resetStopwatch() {
    debugPrint('[RestorableValue demo] Reset stopwatch.');
    _running.value = false;
    _stopTicker();
    _elapsed.value = Duration.zero;
    _lapDuration.value = Duration.zero;
    _laps.clear();
    setState(() {});
  }

  void _recordLap() {
    final Duration total = _elapsed.value;
    final Duration split = total - _lapDuration.value;
    _lapDuration.value = total;
    _laps.insert(0, _formatDuration(total));
    // Cap lap history — this is UI, not persisted state.
    if (_laps.length > 60) {
      _laps.removeRange(60, _laps.length);
    }
    debugPrint(
      '[RestorableValue demo] Lap recorded: total=${_formatDuration(total)} '
      'split=${_formatDuration(split)}',
    );
    setState(() {});
  }

  // ---- Pointer interaction ------------------------------------------------

  void _handlePointerMove(Offset local, Size canvasSize) {
    // Clamp to the canvas so the crosshair never renders outside the box.
    final double clampedX =
        local.dx.clamp(0.0, canvasSize.width - 1).toDouble();
    final double clampedY =
        local.dy.clamp(0.0, canvasSize.height - 1).toDouble();
    _pointerPosition.value = Offset(clampedX, clampedY);
    setState(() {});
  }

  // ---- Formatting helpers -------------------------------------------------

  /// Formats a [Duration] as `mm:ss.xx` with two decimal places on seconds.
  String _formatDuration(Duration d) {
    final int totalMs = d.inMilliseconds;
    final int minutes = (totalMs ~/ 60000).clamp(0, 999);
    final int seconds = (totalMs ~/ 1000) % 60;
    final int hundredths = (totalMs % 1000) ~/ 10;
    final String mm = minutes.toString().padLeft(2, '0');
    final String ss = seconds.toString().padLeft(2, '0');
    final String xx = hundredths.toString().padLeft(2, '0');
    return '$mm:$ss.$xx';
  }

  /// Parses `mm:ss.xx` back into a [Duration]. Returns [Duration.zero] on
  /// malformed input.
  Duration _parseFormattedDuration(String text) {
    final List<String> colonParts = text.split(':');
    if (colonParts.length != 2) {
      return Duration.zero;
    }
    final int? minutes = int.tryParse(colonParts[0]);
    final List<String> dotParts = colonParts[1].split('.');
    if (minutes == null || dotParts.length != 2) {
      return Duration.zero;
    }
    final int? seconds = int.tryParse(dotParts[0]);
    final int? hundredths = int.tryParse(dotParts[1]);
    if (seconds == null || hundredths == null) {
      return Duration.zero;
    }
    return Duration(
      minutes: minutes,
      seconds: seconds,
      milliseconds: hundredths * 10,
    );
  }

  // ---- Build --------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kDeepNavy,
        elevation: 0,
        title: const Text(
          'RestorableValue<T> — Stopwatch & Pointer',
          style: TextStyle(color: _kOffWhite, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: _kNeonCyan),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildIntroBanner(),
              const SizedBox(height: 18),
              _buildStopwatchHero(),
              const SizedBox(height: 18),
              _buildLapHistoryCard(),
              const SizedBox(height: 18),
              _buildPointerCanvas(),
              const SizedBox(height: 18),
              _buildRestorationInspector(),
              const SizedBox(height: 18),
              _buildTeachingPanel(),
              const SizedBox(height: 24),
              _buildFooterBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Section: intro banner ---------------------------------------------

  Widget _buildIntroBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kDeepNavy, _kNavyCard],
        ),
        border: Border.all(color: _kNeonCyan.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kNeonCyan.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kNeonCyan.withValues(alpha: 0.65)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.restore, color: _kNeonCyan, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RestorableValue<T> — the scalar tier of restoration',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'This harness persists a stopwatch, a lap splitter, and a '
                  'pointer position using two real RestorableValue<T> '
                  'subclasses: _RestorableDuration (Duration -> int '
                  'microseconds) and _RestorableOffset (Offset -> [dx, dy]). '
                  'The running flag uses stock RestorableBool for contrast.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section: stopwatch hero -------------------------------------------

  Widget _buildStopwatchHero() {
    final String formatted = _formatDuration(_elapsed.value);
    final bool running = _running.value;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          Text(
            'Elapsed time',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            width: 260,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildTickRing(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      formatted,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 46,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: _kOffWhite,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      running ? 'RUNNING' : 'PAUSED',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        letterSpacing: 4,
                        color: running ? _kGreenLap : _kWarmGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPrimaryButton(
                label: running ? 'STOP' : 'START',
                icon: running ? Icons.pause_circle_filled : Icons.play_arrow,
                onPressed: _toggleRunning,
                colour: running ? _kDangerRed : _kNeonCyan,
              ),
              const SizedBox(width: 14),
              _buildPrimaryButton(
                label: 'LAP',
                icon: Icons.flag_outlined,
                onPressed: running ? _recordLap : null,
                colour: _kSoftCyan,
              ),
              const SizedBox(width: 14),
              _buildSecondaryButton(
                label: 'RESET',
                icon: Icons.restart_alt,
                onPressed: _resetStopwatch,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTickRing() {
    // A ring of 60 small ticks. The tick matching the current second is
    // highlighted in amber; others use soft cyan. We rotate each tick around
    // the centre so the ring hints at the stopwatch "second hand".
    final int activeTick = _elapsed.value.inSeconds % 60;
    final List<Widget> ticks = <Widget>[];
    for (int i = 0; i < 60; i++) {
      final bool isActive = i == activeTick;
      final double angle = (i / 60.0) * 2 * 3.141592653589793;
      ticks.add(
        Transform.rotate(
          angle: angle,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              width: isActive ? 4 : 2,
              height: isActive ? 18 : (i % 5 == 0 ? 14 : 10),
              decoration: BoxDecoration(
                color: isActive
                    ? _kAmberTick
                    : (i % 5 == 0
                        ? _kSoftCyan.withValues(alpha: 0.8)
                        : _kSoftCyan.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(children: ticks),
    );
  }

  // ---- Section: lap history ---------------------------------------------

  Widget _buildLapHistoryCard() {
    final List<_LapEntry> entries = _computeLapEntries();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.history, color: _kNeonCyan, size: 20),
              const SizedBox(width: 10),
              Text(
                'Lap history',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '${entries.length} lap${entries.length == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Split time = delta from previous lap. Bars are colour-coded: '
            'green = fastest, amber = median, red = slowest.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'No laps yet. Press LAP while the stopwatch runs.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length > 10 ? 10 : entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildLapRow(entries[index], entries);
                },
              ),
            ),
        ],
      ),
    );
  }

  List<_LapEntry> _computeLapEntries() {
    // _laps is newest-first, containing the total time as "mm:ss.xx".
    // Reconstruct split times by diffing successive totals (oldest -> newest).
    final List<Duration> totals = <Duration>[];
    for (int i = _laps.length - 1; i >= 0; i--) {
      totals.add(_parseFormattedDuration(_laps[i]));
    }
    final List<_LapEntry> result = <_LapEntry>[];
    Duration prev = Duration.zero;
    for (int i = 0; i < totals.length; i++) {
      final Duration total = totals[i];
      final Duration split = total - prev;
      result.add(_LapEntry(index: i + 1, total: total, split: split));
      prev = total;
    }
    // Flip back to newest-first for display.
    return result.reversed.toList();
  }

  Widget _buildLapRow(_LapEntry entry, List<_LapEntry> all) {
    final Duration fastest = all
        .map((_LapEntry e) => e.split)
        .reduce((Duration a, Duration b) => a < b ? a : b);
    final Duration slowest = all
        .map((_LapEntry e) => e.split)
        .reduce((Duration a, Duration b) => a > b ? a : b);
    final List<Duration> sorted = all.map((_LapEntry e) => e.split).toList()
      ..sort();
    final Duration median = sorted[sorted.length ~/ 2];

    Color bucketColour;
    if (entry.split == fastest) {
      bucketColour = _kGreenLap;
    } else if (entry.split == slowest) {
      bucketColour = _kDangerRed;
    } else {
      bucketColour = _kAmberTick;
    }

    final double maxSplitMs =
        slowest.inMilliseconds.toDouble().clamp(1, 1e9).toDouble();
    final double widthFraction =
        (entry.split.inMilliseconds / maxSplitMs).clamp(0.04, 1.0).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 38,
            child: Text(
              '#${entry.index}',
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _kSoftCyan,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 96,
            child: Text(
              _formatDuration(entry.split),
              style: TextStyle(
                fontFamily: 'monospace',
                color: bucketColour,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 96,
            child: Text(
              _formatDuration(entry.total),
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _kOffWhite,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: _kNeonCyan.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: widthFraction,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: bucketColour.withValues(alpha: 0.78),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: 'median split ${_formatDuration(median)}',
            child: Icon(
              Icons.horizontal_rule,
              size: 14,
              color: _kWarmGrey.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section: pointer canvas -------------------------------------------

  Widget _buildPointerCanvas() {
    const double w = 340;
    const double h = 220;
    final Offset p = _pointerPosition.value;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.gesture, color: _kNeonCyan, size: 20),
              const SizedBox(width: 10),
              Text(
                'Pointer tracker',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                'drag inside the panel',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (TapDownDetails d) =>
                  _handlePointerMove(d.localPosition, const Size(w, h)),
              onPanUpdate: (DragUpdateDetails d) =>
                  _handlePointerMove(d.localPosition, const Size(w, h)),
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: _kMidnight,
                  border: Border.all(color: _kNeonCyan.withValues(alpha: 0.7)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: <Widget>[
                    // Grid overlay (horizontal lines).
                    for (int i = 1; i < 5; i++)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: (h / 5) * i,
                        child: Container(
                          height: 1,
                          color: _kNeonCyan.withValues(alpha: 0.08),
                        ),
                      ),
                    // Grid overlay (vertical lines).
                    for (int i = 1; i < 7; i++)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: (w / 7) * i,
                        child: Container(
                          width: 1,
                          color: _kNeonCyan.withValues(alpha: 0.08),
                        ),
                      ),
                    // Horizontal crosshair.
                    Positioned(
                      left: 0,
                      right: 0,
                      top: p.dy - 0.5,
                      child: Container(
                        height: 1,
                        color: _kNeonCyan.withValues(alpha: 0.55),
                      ),
                    ),
                    // Vertical crosshair.
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: p.dx - 0.5,
                      child: Container(
                        width: 1,
                        color: _kNeonCyan.withValues(alpha: 0.55),
                      ),
                    ),
                    // Position dot.
                    Positioned(
                      left: p.dx - 8,
                      top: p.dy - 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _kNeonCyan,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: _kNeonCyan.withValues(alpha: 0.7),
                              blurRadius: 14,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCoordBadge('dx', p.dx),
              const SizedBox(width: 18),
              _buildCoordBadge('dy', p.dy),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoordBadge(String label, double v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _kMidnight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kSoftCyan.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '$label:',
            style: const TextStyle(
              color: _kSoftCyan,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            v.toStringAsFixed(1),
            style: const TextStyle(
              color: _kOffWhite,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section: restoration inspector ------------------------------------

  Widget _buildRestorationInspector() {
    final Object? elapsedPrim = _elapsed.toPrimitives();
    final Object? lapPrim = _lapDuration.toPrimitives();
    final Object? pointerPrim = _pointerPosition.toPrimitives();
    final Object runningPrim = _running.toPrimitives();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.data_object, color: _kNeonCyan, size: 20),
              const SizedBox(width: 10),
              Text(
                'Restoration inspector',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'LIVE value vs. the primitive representation produced by '
            'toPrimitives(). This is the payload the restoration pipeline '
            'actually serialises.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          _buildInspectorRow(
            label: '_elapsed',
            live: _formatDuration(_elapsed.value),
            primitive: '${elapsedPrim.runtimeType}: $elapsedPrim',
          ),
          _buildInspectorRow(
            label: '_lapDuration',
            live: _formatDuration(_lapDuration.value),
            primitive: '${lapPrim.runtimeType}: $lapPrim',
          ),
          _buildInspectorRow(
            label: '_pointerPosition',
            live: '(${_pointerPosition.value.dx.toStringAsFixed(1)}, '
                '${_pointerPosition.value.dy.toStringAsFixed(1)})',
            primitive: '${pointerPrim.runtimeType}: $pointerPrim',
          ),
          _buildInspectorRow(
            label: '_running',
            live: _running.value.toString(),
            primitive: '${runningPrim.runtimeType}: $runningPrim',
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _kAmberTick.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAmberTick.withValues(alpha: 0.45)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.info_outline, size: 16, color: _kAmberTick),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Lap history (${_laps.length} entries) is held in a plain '
                    'List<String> because Flutter\'s core widgets library does '
                    'not ship a RestorableStringList. Substituting one here '
                    'would distract from the RestorableValue<T> focus.',
                    style: const TextStyle(
                      color: _kOffWhite,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectorRow({
    required String label,
    required String live,
    required String primitive,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _kSoftCyan,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              live,
              style: const TextStyle(
                color: _kOffWhite,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              primitive,
              style: const TextStyle(
                color: _kWarmGrey,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Section: teaching panel -------------------------------------------

  Widget _buildTeachingPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.menu_book, color: _kNeonCyan, size: 20),
              const SizedBox(width: 10),
              Text(
                'RestorableValue<T> vs RestorableProperty<T>',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildComparisonTable(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _buildCodeBox(_kSampleRestorableValue)),
              const SizedBox(width: 14),
              Expanded(child: _buildCodeBox(_kSampleRestorableProperty)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Rule of thumb: if your state is a single scalar T that you want '
            'restored exactly, reach for RestorableValue<T>. Drop down to '
            'RestorableProperty<T> only when you need full control over '
            'initWithValue or when the public shape of the property is not '
            '"get value / set value".',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    final BorderSide border = BorderSide(
      color: _kNeonCyan.withValues(alpha: 0.22),
    );
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1.3),
        1: FlexColumnWidth(1.1),
        2: FlexColumnWidth(1.1),
      },
      border: TableBorder(
        horizontalInside: border,
        top: border,
        bottom: border,
      ),
      children: <TableRow>[
        _headerRow(),
        _comparisonRow('Must implement createDefaultValue', true, true),
        _comparisonRow('Must implement fromPrimitives / toPrimitives', true, true),
        _comparisonRow('Must implement initWithValue yourself', false, true),
        _comparisonRow('didUpdateValue hook fires on set value', true, false),
        _comparisonRow('Ships a get value / set value for free', true, false),
      ],
    );
  }

  TableRow _headerRow() {
    const TextStyle head = TextStyle(
      color: _kNeonCyan,
      fontWeight: FontWeight.w700,
      fontSize: 13,
    );
    return const TableRow(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text('Capability', style: head),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text('RestorableValue<T>', style: head),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text('RestorableProperty<T>', style: head),
        ),
      ],
    );
  }

  TableRow _comparisonRow(String label, bool left, bool right) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text(
            label,
            style: const TextStyle(color: _kOffWhite, fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: _boolCell(left),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: _boolCell(right),
        ),
      ],
    );
  }

  Widget _boolCell(bool v) {
    return Row(
      children: <Widget>[
        Icon(
          v ? Icons.check_circle : Icons.cancel_outlined,
          size: 16,
          color: v ? _kGreenLap : _kWarmGrey,
        ),
        const SizedBox(width: 6),
        Text(
          v ? 'yes' : 'no',
          style: TextStyle(
            color: v ? _kOffWhite : _kWarmGrey,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildCodeBox(String code) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _kMidnight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kNeonCyan.withValues(alpha: 0.35)),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: _kSoftCyan,
          height: 1.35,
        ),
      ),
    );
  }

  // ---- Section: footer ---------------------------------------------------

  Widget _buildFooterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _kDeepNavy,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kNeonCyan.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.lock_clock, color: _kSoftCyan, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'restorationScopeId: restorable_value_demo_root  -  '
              'restorationId: stopwatch_pointer_demo  -  ticker: 100ms',
              style: TextStyle(
                color: _kWarmGrey.withValues(alpha: 0.9),
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Buttons ----------------------------------------------------------

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    required Color colour,
    required VoidCallback? onPressed,
  }) {
    final bool enabled = onPressed != null;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? colour : colour.withValues(alpha: 0.3),
        foregroundColor: _kMidnight,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: _kSoftCyan),
      label: Text(
        label,
        style: const TextStyle(
          color: _kSoftCyan,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: _kSoftCyan),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // ---- Shared card decoration -------------------------------------------

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _kNavyCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: _kNeonCyan.withValues(alpha: 0.25),
        width: 1,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kMidnight.withValues(alpha: 0.6),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Helper types.
// ---------------------------------------------------------------------------

/// Aggregate record describing a single lap: its 1-based ordinal, the total
/// elapsed time at the moment of the lap, and the split (delta from the
/// previous lap).
class _LapEntry {
  const _LapEntry({
    required this.index,
    required this.total,
    required this.split,
  });

  final int index;
  final Duration total;
  final Duration split;
}

// ---------------------------------------------------------------------------
// Code snippets shown inside the teaching panel.
// ---------------------------------------------------------------------------

const String _kSampleRestorableValue = '''
// RestorableValue<T> — only 4 overrides.
class _RestorableDuration
    extends RestorableValue<Duration> {
  _RestorableDuration(this._def);
  final Duration _def;

  @override
  Duration createDefaultValue() => _def;

  @override
  Duration fromPrimitives(Object? d) =>
      Duration(microseconds: d as int);

  @override
  Object? toPrimitives() =>
      value.inMicroseconds;

  @override
  void didUpdateValue(Duration? old) =>
      notifyListeners();
}
''';

const String _kSampleRestorableProperty = '''
// RestorableProperty<T> — you own initWithValue.
class RawDuration
    extends RestorableProperty<Duration> {
  RawDuration(this._def);
  final Duration _def;
  Duration _v = Duration.zero;

  Duration get value => _v;
  set value(Duration v) {
    _v = v;
    notifyListeners();
  }

  @override
  Duration createDefaultValue() => _def;

  @override
  void initWithValue(Duration v) {
    _v = v;
  }

  @override
  Duration fromPrimitives(Object? d) =>
      Duration(microseconds: d as int);

  @override
  Object? toPrimitives() =>
      _v.inMicroseconds;
}
''';
