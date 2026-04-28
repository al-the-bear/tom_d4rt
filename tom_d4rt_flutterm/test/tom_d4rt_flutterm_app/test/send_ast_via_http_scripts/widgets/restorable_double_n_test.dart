import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// =============================================================================
// RestorableDoubleN — Deep Visual Demo
// =============================================================================
//
// `RestorableDoubleN` is a `RestorableProperty<double?>` — a nullable double
// persisted automatically across Flutter engine restarts (state restoration).
//
// Serialization model:
//   * `double?` stored either as a raw IEEE-754 double, or as the engine's
//     null sentinel in the restoration bucket.
//   * Unlike `RestorableDouble` (non-nullable), this one explicitly models
//     the "missing / not-yet-set / user-skipped" case.
//
// Why not just keep `double?` in a regular StatefulWidget field?
//   * A plain field lives on the Dart heap only. If the Flutter engine
//     tears down and restores the isolate (Android back-stack restore,
//     iOS state restoration, hot-restart-with-persistence), the field is
//     reset to its constructor default. `RestorableDoubleN` survives all
//     of that, because the framework writes its payload into the per-route
//     `RestorationBucket`.
//
// Semantic fit:
//   * Nullable is the right choice whenever "no entry today" is itself
//     meaningful information — e.g. a fitness log where skipping a day
//     is distinct from logging 0 kg.
//
// UX story — "Fitness Log — Optional Weight Tracker":
//   Five visually distinct scenarios showcase how `RestorableDoubleN`
//   expresses both present and absent values across real UI surfaces.
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('[RestorableDoubleN demo] Building...');
  return MaterialApp(
    title: 'RestorableDoubleN Deep Demo',
    theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
    restorationScopeId: 'restorable_double_n_demo',
    home: const WeightLogDemo(),
  );
}

// -----------------------------------------------------------------------------
// Root demo widget
// -----------------------------------------------------------------------------

class WeightLogDemo extends StatefulWidget {
  const WeightLogDemo({super.key});

  @override
  State<WeightLogDemo> createState() => _WeightLogDemoState();
}

class _WeightLogDemoState extends State<WeightLogDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------------
  // Restorable state — all nullable doubles.
  // Each represents a measurement that may or may not have been logged.
  // ---------------------------------------------------------------------------

  /// The user's most recent measurement (Scenario 1 hero card).
  final RestorableDoubleN _todayWeight = RestorableDoubleN(72.4);

  /// The draft value being composed in the input form (Scenario 4).
  final RestorableDoubleN _pendingEntry = RestorableDoubleN(null);

  /// Seven distinct day slots for the week strip and trend chart
  /// (Scenarios 2, 3, 5). Pre-populated to demonstrate both present
  /// and skipped days.
  final RestorableDoubleN _day0 = RestorableDoubleN(70.1);
  final RestorableDoubleN _day1 = RestorableDoubleN(null);
  final RestorableDoubleN _day2 = RestorableDoubleN(70.8);
  final RestorableDoubleN _day3 = RestorableDoubleN(71.2);
  final RestorableDoubleN _day4 = RestorableDoubleN(null);
  final RestorableDoubleN _day5 = RestorableDoubleN(70.5);
  final RestorableDoubleN _day6 = RestorableDoubleN(70.9);

  /// Non-restored UI proxy for the slider in Scenario 4. We intentionally
  /// keep this as a plain `double` — it's ephemeral, recomputed on every
  /// session, and should not persist. Contrast with `_pendingEntry` which
  /// is what the user has *committed* to remember.
  double _localPendingSliderValue = 70.0;

  // ---------------------------------------------------------------------------
  // Visual constants
  // ---------------------------------------------------------------------------

  static const double _targetWeight = 70.0;
  static const double _minDisplay = 65.0;
  static const double _maxDisplay = 75.0;

  // ---------------------------------------------------------------------------
  // RestorationMixin plumbing
  // ---------------------------------------------------------------------------

  @override
  String? get restorationId => 'weight_log_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Every RestorableProperty must be registered with a unique id under
    // this widget's restoration bucket. After registration, the framework
    // rehydrates `value` from the serialized payload (if present).
    registerForRestoration(_todayWeight, 'today_weight');
    registerForRestoration(_pendingEntry, 'pending_entry');
    registerForRestoration(_day0, 'day_0');
    registerForRestoration(_day1, 'day_1');
    registerForRestoration(_day2, 'day_2');
    registerForRestoration(_day3, 'day_3');
    registerForRestoration(_day4, 'day_4');
    registerForRestoration(_day5, 'day_5');
    registerForRestoration(_day6, 'day_6');
  }

  @override
  void dispose() {
    // Restorable properties must be disposed to release the bucket slot
    // and unsubscribe listeners.
    _todayWeight.dispose();
    _pendingEntry.dispose();
    _day0.dispose();
    _day1.dispose();
    _day2.dispose();
    _day3.dispose();
    _day4.dispose();
    _day5.dispose();
    _day6.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Map the seven day slots to a list, preserving order.
  List<RestorableDoubleN> get _allDays =>
      <RestorableDoubleN>[_day0, _day1, _day2, _day3, _day4, _day5, _day6];

  /// Normalize a weight into [0, 1] for vertical scaling between
  /// `_minDisplay` and `_maxDisplay`.
  ///
  /// Uses `clampDouble` from `package:flutter/foundation.dart` — the
  /// foundation-provided, non-virtual clamp primitive (slightly faster
  /// than `double.clamp` because it avoids the dynamic dispatch path).
  double _normalize(double v) {
    final double clamped = clampDouble(v, _minDisplay, _maxDisplay);
    return (clamped - _minDisplay) / (_maxDisplay - _minDisplay);
  }

  /// Number of days that have a logged (non-null) value.
  int get _loggedCount =>
      _allDays.where((RestorableDoubleN d) => d.value != null).length;

  /// Arithmetic mean of the non-null day entries, or null if all skipped.
  double? get _averageLogged {
    final List<double> logged = <double>[];
    for (final RestorableDoubleN d in _allDays) {
      final double? v = d.value;
      if (v != null) {
        logged.add(v);
      }
    }
    if (logged.isEmpty) {
      return null;
    }
    double sum = 0.0;
    for (final double v in logged) {
      sum += v;
    }
    return sum / logged.length;
  }

  /// Longest consecutive run of non-null days in the week.
  int get _longestStreak {
    int best = 0;
    int current = 0;
    for (final RestorableDoubleN d in _allDays) {
      if (d.value != null) {
        current += 1;
        if (current > best) {
          best = current;
        }
      } else {
        current = 0;
      }
    }
    return best;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Log — Optional Weight Tracker'),
        backgroundColor: Colors.orange.shade100,
      ),
      backgroundColor: const Color(0xFFFFF9F2),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _buildSectionHeader(
              number: 1,
              title: "Today's weight",
              subtitle: 'Hero card with optional value state',
            ),
            _buildHeroSection(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              number: 2,
              title: '7-day bar strip',
              subtitle: 'Logged vs skipped days',
            ),
            _buildWeekBarSection(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              number: 3,
              title: 'Trend line',
              subtitle: 'Null entries create gaps',
            ),
            _buildTrendSection(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              number: 4,
              title: 'Log or skip entry',
              subtitle: 'Slider proxy + RestorableDoubleN commit',
            ),
            _buildInputFormSection(),
            const SizedBox(height: 24),
            _buildSectionHeader(
              number: 5,
              title: 'Logged vs skipped stats',
              subtitle: 'Aggregate view of week',
            ),
            _buildStatsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Small shared visual primitives
  // ---------------------------------------------------------------------------

  Widget _buildSectionHeader({
    required int number,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.orange.shade200,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SCENARIO 1 — Hero card: today's weight with optional gauge
  // ===========================================================================
  //
  // The hero card has two radically different visual modes. When a value is
  // present we render a big number + a vertical gauge + a target-delta chip.
  // When `_todayWeight.value` is null we render a dashed placeholder card.
  // This is the canonical "present vs absent" transition that motivates
  // `RestorableDoubleN` in the first place.
  // ===========================================================================

  Widget _buildHeroSection() {
    final double? value = _todayWeight.value;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.orange.shade100,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: value != null
                ? _buildHeroFilled(value)
                : _buildHeroEmpty(),
          ),
          const SizedBox(height: 8),
          _buildHeroControls(),
        ],
      ),
    );
  }

  Widget _buildHeroFilled(double value) {
    final double delta = value - _targetWeight;
    final bool onTarget = delta.abs() <= 1.0;
    final Color deltaColor =
        onTarget ? Colors.green.shade600 : Colors.amber.shade800;
    final String deltaLabel = delta >= 0
        ? '+${delta.toStringAsFixed(1)} kg'
        : '${delta.toStringAsFixed(1)} kg';

    return Container(
      key: const ValueKey<String>('hero_filled'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                        color: Colors.orange.shade900,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'kg',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: deltaColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'vs target (${_targetWeight.toStringAsFixed(0)} kg)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: deltaColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: deltaColor, width: 1),
                  ),
                  child: Text(
                    onTarget ? 'On target: $deltaLabel' : 'Off target: $deltaLabel',
                    style: TextStyle(
                      color: deltaColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildHeroGauge(value),
        ],
      ),
    );
  }

  Widget _buildHeroGauge(double value) {
    const double gaugeHeight = 160.0;
    const double gaugeWidth = 34.0;
    final double fraction = _normalize(value);
    final double filledHeight = gaugeHeight * fraction;

    // Vertical gauge: background track + a gradient-filled bar scaled to
    // match the current value's position in [minDisplay, maxDisplay].
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          _maxDisplay.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: gaugeHeight,
          width: gaugeWidth + 24,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              // Background track
              Container(
                width: gaugeWidth,
                height: gaugeHeight,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(gaugeWidth / 2),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              // Filled portion (gradient)
              Container(
                width: gaugeWidth,
                height: filledHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      Colors.orange.shade300,
                      Colors.orange.shade700,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(gaugeWidth / 2),
                ),
              ),
              // Target marker line (horizontal)
              Positioned(
                bottom: gaugeHeight * _normalize(_targetWeight),
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.green.shade700,
                ),
              ),
              // Current-value indicator dot
              Positioned(
                bottom: filledHeight - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.orange.shade900,
                      width: 2,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _minDisplay.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroEmpty() {
    // Dashed-border placeholder: emphasizes that "no value" is a real,
    // first-class state — not just an empty textbox.
    return Container(
      key: const ValueKey<String>('hero_empty'),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: _DashedRectFrame(
        color: Colors.grey.shade400,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.monitor_weight_outlined,
                size: 54,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              Text(
                'Skip — no measurement today',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '(_todayWeight.value == null)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _todayWeight.value = 72.4;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Log weight'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroControls() {
    return Row(
      children: <Widget>[
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Save 72.4 kg'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange.shade800,
              side: BorderSide(color: Colors.orange.shade300),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              setState(() {
                _todayWeight.value = 72.4;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Skip today (clear)'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              side: BorderSide(color: Colors.grey.shade400),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              setState(() {
                // Assigning null clears the persisted value — the
                // restoration bucket records the absence explicitly.
                _todayWeight.value = null;
              });
            },
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SCENARIO 2 — 7-day bar strip
  // ===========================================================================
  //
  // Each column is a visual vote for either "logged" (colored bar) or
  // "skipped" (dashed placeholder). The width of a column, its corner radius,
  // and its label are purposefully identical — only the inner render diverges
  // based on nullability.
  // ===========================================================================

  Widget _buildWeekBarSection() {
    const List<String> dayLabels = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'This week',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Logged: $_loggedCount/7 days',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buildDayBar(label: dayLabels[0], value: _day0.value),
                _buildDayBar(label: dayLabels[1], value: _day1.value),
                _buildDayBar(label: dayLabels[2], value: _day2.value),
                _buildDayBar(label: dayLabels[3], value: _day3.value),
                _buildDayBar(label: dayLabels[4], value: _day4.value),
                _buildDayBar(label: dayLabels[5], value: _day5.value),
                _buildDayBar(label: dayLabels[6], value: _day6.value),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLegendSwatch(
                color: Colors.orange.shade500,
                label: 'Logged',
              ),
              const SizedBox(width: 16),
              _buildLegendSwatch(
                color: Colors.grey.shade300,
                label: 'Skipped',
                dashed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar({
    required String label,
    required double? value,
  }) {
    const double maxBarHeight = 140.0;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Top label — present numeric value or "skip"
            SizedBox(
              height: 20,
              child: value != null
                  ? Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      'skip',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
            ),
            const SizedBox(height: 4),
            // Bar track
            Container(
              height: maxBarHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              alignment: Alignment.bottomCenter,
              child: value != null
                  ? _buildFilledBar(value, maxBarHeight)
                  : _buildSkippedBar(maxBarHeight),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilledBar(double value, double maxHeight) {
    final double h = _normalize(value) * maxHeight;
    // Color gradient shifts from amber (below target) through green (on)
    // to red (over) — purely derived, no extra state.
    final Color topColor;
    if ((value - _targetWeight).abs() <= 0.5) {
      topColor = Colors.green.shade500;
    } else if (value > _targetWeight) {
      topColor = Colors.red.shade400;
    } else {
      topColor = Colors.amber.shade500;
    }

    return Container(
      height: h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Colors.orange.shade300,
            topColor,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildSkippedBar(double maxHeight) {
    // A short dashed placeholder at the bottom of the track to make the
    // "absent" state visually legible at a glance.
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < 3; i++) ...<Widget>[
            Container(
              height: 2,
              color: Colors.grey.shade400,
            ),
            if (i < 2) const SizedBox(height: 3),
          ],
        ],
      ),
    );
  }

  Widget _buildLegendSwatch({
    required Color color,
    required String label,
    bool dashed = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (dashed)
          SizedBox(
            width: 18,
            height: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 2; i++) ...<Widget>[
                  Container(height: 2, color: color),
                  if (i < 1) const SizedBox(height: 2),
                ],
              ],
            ),
          )
        else
          Container(
            width: 14,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SCENARIO 3 — Trend line via Stack + rotated Container segments
  // ===========================================================================
  //
  // We position colored dots for each non-null day by (x, y) absolute
  // coordinates inside a Stack. Consecutive non-null days are joined by
  // a thin rotated Container that acts as a line segment; null days
  // create natural gaps.
  // ===========================================================================

  Widget _buildTrendSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.show_chart,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 8),
              const Text(
                'Weekly trend',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double chartHeight = 180.0;
              const double axisLabelWidth = 32.0;
              final double chartWidth =
                  constraints.maxWidth - axisLabelWidth - 8;
              return SizedBox(
                height: chartHeight + 28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildYAxisLabels(chartHeight, axisLabelWidth),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: chartWidth,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: chartHeight,
                            child: _buildTrendPlot(chartWidth, chartHeight),
                          ),
                          const SizedBox(height: 6),
                          _buildXAxisLabels(chartWidth),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildYAxisLabels(double chartHeight, double width) {
    // Three horizontal gridlines: 75 / 70 / 65.
    return SizedBox(
      width: width,
      height: chartHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Text(
              '75',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Positioned(
            top: chartHeight / 2 - 7,
            right: 0,
            child: Text(
              '70',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              '65',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXAxisLabels(double chartWidth) {
    const List<String> xs = <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return SizedBox(
      width: chartWidth,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < xs.length; i++)
            Expanded(
              child: Center(
                child: Text(
                  xs[i],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendPlot(double chartWidth, double chartHeight) {
    // Convert each day to a (x, y) pair; null values yield null.
    final List<Offset?> points = <Offset?>[];
    final List<RestorableDoubleN> days = _allDays;
    final double slotWidth = chartWidth / days.length;
    for (int i = 0; i < days.length; i++) {
      final double? v = days[i].value;
      if (v == null) {
        points.add(null);
      } else {
        final double x = slotWidth * (i + 0.5);
        final double y = chartHeight - _normalize(v) * chartHeight;
        points.add(Offset(x, y));
      }
    }

    final List<Widget> overlay = <Widget>[];

    // Horizontal gridlines
    for (int i = 0; i < 3; i++) {
      final double t = i / 2.0;
      overlay.add(
        Positioned(
          left: 0,
          right: 0,
          top: chartHeight * t,
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      );
    }

    // Target reference line (70 kg, dashed look)
    final double targetY =
        chartHeight - _normalize(_targetWeight) * chartHeight;
    overlay.add(
      Positioned(
        left: 0,
        right: 0,
        top: targetY - 0.5,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < 24; i++)
              Expanded(
                child: Container(
                  height: 1,
                  color: i.isEven
                      ? Colors.green.shade400
                      : Colors.transparent,
                ),
              ),
          ],
        ),
      ),
    );

    // Connect consecutive non-null points with rotated containers
    for (int i = 0; i < points.length - 1; i++) {
      final Offset? a = points[i];
      final Offset? b = points[i + 1];
      if (a != null && b != null) {
        overlay.add(_buildLineSegment(a, b));
      } else {
        // Dotted gap: a column of small dots between slot centers.
        overlay.add(_buildDottedGap(
          x1: slotWidth * (i + 0.5),
          x2: slotWidth * (i + 1.5),
          y: chartHeight / 2,
        ));
      }
    }

    // Draw dots on top of segments
    for (final Offset? p in points) {
      if (p != null) {
        overlay.add(
          Positioned(
            left: p.dx - 6,
            top: p.dy - 6,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.orange.shade200,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return SizedBox(
      width: chartWidth,
      height: chartHeight,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: overlay,
      ),
    );
  }

  Widget _buildLineSegment(Offset a, Offset b) {
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double length = _hypot(dx, dy);
    final double angle = _atan2(dy, dx);
    return Positioned(
      left: a.dx,
      top: a.dy - 1.5,
      width: length,
      height: 3,
      child: Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()..rotateZ(angle),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.orange.shade400,
                Colors.orange.shade700,
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildDottedGap({
    required double x1,
    required double x2,
    required double y,
  }) {
    // A visual indicator that a day is skipped: three tiny dots
    // hovering near the midline between the two slots.
    final double midX = (x1 + x2) / 2;
    return Positioned(
      left: midX - 10,
      top: y - 2,
      width: 20,
      height: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  // Lightweight math helpers — keeping this file self-contained and
  // avoiding imports of `dart:math` to stay friendly with the harness.
  double _hypot(double dx, double dy) {
    double ax = dx.abs();
    double ay = dy.abs();
    if (ax < ay) {
      final double tmp = ax;
      ax = ay;
      ay = tmp;
    }
    if (ax == 0.0) {
      return 0.0;
    }
    final double r = ay / ax;
    return ax * _sqrt(1.0 + r * r);
  }

  double _sqrt(double x) {
    if (x <= 0.0) {
      return 0.0;
    }
    double guess = x < 1.0 ? 1.0 : x / 2.0;
    for (int i = 0; i < 20; i++) {
      guess = 0.5 * (guess + x / guess);
    }
    return guess;
  }

  double _atan2(double y, double x) {
    // Minimal atan2 via Taylor-series-ish piecewise; sufficient for
    // line-segment rendering at visual precision.
    const double pi = 3.141592653589793;
    if (x > 0) {
      return _atan(y / x);
    }
    if (x < 0 && y >= 0) {
      return _atan(y / x) + pi;
    }
    if (x < 0 && y < 0) {
      return _atan(y / x) - pi;
    }
    if (y > 0) {
      return pi / 2;
    }
    if (y < 0) {
      return -pi / 2;
    }
    return 0.0;
  }

  double _atan(double x) {
    // Reasonable approximation for |x| small-ish; our inputs are
    // always bounded by chart dimensions.
    if (x.abs() > 1.0) {
      const double pi = 3.141592653589793;
      final double sign = x >= 0 ? 1.0 : -1.0;
      return sign * (pi / 2) - _atan(1.0 / x);
    }
    final double x2 = x * x;
    final double x3 = x2 * x;
    final double x5 = x3 * x2;
    final double x7 = x5 * x2;
    return x - x3 / 3.0 + x5 / 5.0 - x7 / 7.0;
  }

  // ===========================================================================
  // SCENARIO 4 — Input form
  // ===========================================================================
  //
  // Slider provides a non-restored UI proxy. The user then commits their
  // choice to `_pendingEntry` (a RestorableDoubleN) via Save, or clears it
  // by tapping Skip. This distinction matters: the slider position itself
  // shouldn't survive a restart; the "decision" the user made should.
  // ===========================================================================

  Widget _buildInputFormSection() {
    final double? pending = _pendingEntry.value;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.tune,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 8),
              const Text(
                'Adjust and commit',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Value bubble above slider
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.orange.shade100,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.drag_indicator,
                      size: 16,
                      color: Colors.orange.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Slider: ${_localPendingSliderValue.toStringAsFixed(1)} kg',
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.orange.shade600,
              inactiveTrackColor: Colors.orange.shade100,
              thumbColor: Colors.orange.shade800,
              overlayColor: Colors.orange.withValues(alpha: 0.15),
              valueIndicatorColor: Colors.orange.shade700,
              trackHeight: 6,
            ),
            child: Slider(
              value: _localPendingSliderValue,
              min: _minDisplay,
              max: _maxDisplay,
              divisions: 100,
              label: '${_localPendingSliderValue.toStringAsFixed(1)} kg',
              onChanged: (double v) {
                setState(() {
                  _localPendingSliderValue = v;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    setState(() {
                      _pendingEntry.value = _localPendingSliderValue;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.block),
                  label: const Text('Skip'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    setState(() {
                      _pendingEntry.value = null;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Preview card: reflects committed state only.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: pending != null
                  ? Colors.orange.shade50
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: pending != null
                    ? Colors.orange.shade200
                    : Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Committed pending entry',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                if (pending != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        pending.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.orange.shade900,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'kg',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.remove_circle_outline,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(skipped)',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 6),
                Text(
                  pending != null
                      ? '_pendingEntry.value = ${pending.toStringAsFixed(1)}'
                      : '_pendingEntry.value = null',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SCENARIO 5 — Logged vs skipped stats
  // ===========================================================================
  //
  // Pure derivations over the seven `RestorableDoubleN` day slots.
  // The split bar visualizes proportion; the two stat cards surface
  // useful aggregate facts (mean, longest streak).
  // ===========================================================================

  Widget _buildStatsSection() {
    final int logged = _loggedCount;
    final int skipped = 7 - logged;
    final double? avg = _averageLogged;
    final int streak = _longestStreak;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildSplitBar(logged: logged, skipped: skipped),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up,
                accent: Colors.green,
                title: 'Average',
                valueText: avg == null
                    ? '—'
                    : '${avg.toStringAsFixed(2)} kg',
                subtitle: avg == null
                    ? 'no logged days'
                    : 'across $logged logged days',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.local_fire_department,
                accent: Colors.red,
                title: 'Longest streak',
                valueText: '$streak day${streak == 1 ? '' : 's'}',
                subtitle: 'consecutive non-skip',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSkippedListExplainer(),
      ],
    );
  }

  Widget _buildSplitBar({required int logged, required int skipped}) {
    // Total / denominator guarded for visual display. If both are zero we
    // still render a neutral track.
    final int total = logged + skipped;
    final int safeTotal = total == 0 ? 1 : total;
    final double loggedFraction = logged / safeTotal;
    final double skippedFraction = skipped / safeTotal;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Logged vs skipped',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final double totalWidth = c.maxWidth;
              final double loggedWidth = totalWidth * loggedFraction;
              final double skippedWidth = totalWidth * skippedFraction;
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 24,
                  width: totalWidth,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: loggedWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.orange.shade400,
                              Colors.orange.shade700,
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: loggedWidth > 40
                            ? Text(
                                '$logged logged',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Container(
                        width: skippedWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        alignment: Alignment.center,
                        child: skippedWidth > 40
                            ? Text(
                                '$skipped skipped',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _buildLegendSwatch(
                color: Colors.orange.shade500,
                label: '$logged logged',
              ),
              const SizedBox(width: 12),
              _buildLegendSwatch(
                color: Colors.grey.shade400,
                label: '$skipped skipped',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required MaterialColor accent,
    required String title,
    required String valueText,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.shade100),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.shade50,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent.shade700, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valueText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: accent.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkippedListExplainer() {
    // A tiny per-day readout reinforces that `null` is meaningful and
    // is being preserved by `RestorableDoubleN`, not silently coerced
    // to zero.
    const List<String> dayNames = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    final List<RestorableDoubleN> days = _allDays;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                'Serialized values',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < days.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 44,
                    child: Text(
                      dayNames[i],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: days[i].value != null
                          ? Colors.orange.shade500
                          : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    days[i].value != null
                        ? '_day$i.value = ${days[i].value!.toStringAsFixed(1)}'
                        : '_day$i.value = null  (skipped)',
                    style: TextStyle(
                      fontSize: 12,
                      color: days[i].value != null
                          ? Colors.orange.shade900
                          : Colors.grey.shade600,
                      fontFamily: 'monospace',
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

// =============================================================================
// Dashed-border frame used by the hero card's empty state.
//
// Intentionally built from `Container` + `Row` + `Column` primitives — no
// `CustomPaint`. Four LEGO-like edges composed of small dash Containers.
// =============================================================================

class _DashedRectFrame extends StatelessWidget {
  const _DashedRectFrame({
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  static const double _dashLen = 6.0;
  static const double _dashGap = 4.0;
  static const double _stroke = 1.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // The inner child sits in its natural size.
        child,
        // Top edge
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: _HorizontalDashStrip(color: color),
        ),
        // Bottom edge
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _HorizontalDashStrip(color: color),
        ),
        // Left edge
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: _VerticalDashStrip(color: color),
        ),
        // Right edge
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: _VerticalDashStrip(color: color),
        ),
      ],
    );
  }
}

class _HorizontalDashStrip extends StatelessWidget {
  const _HorizontalDashStrip({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        const double dashLen = _DashedRectFrame._dashLen;
        const double dashGap = _DashedRectFrame._dashGap;
        final int count =
            (c.maxWidth / (dashLen + dashGap)).floor().clamp(1, 200);
        return SizedBox(
          height: _DashedRectFrame._stroke,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (int i = 0; i < count; i++)
                Container(
                  width: dashLen,
                  height: _DashedRectFrame._stroke,
                  color: color,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _VerticalDashStrip extends StatelessWidget {
  const _VerticalDashStrip({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        const double dashLen = _DashedRectFrame._dashLen;
        const double dashGap = _DashedRectFrame._dashGap;
        final int count =
            (c.maxHeight / (dashLen + dashGap)).floor().clamp(1, 200);
        return SizedBox(
          width: _DashedRectFrame._stroke,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (int i = 0; i < count; i++)
                Container(
                  width: _DashedRectFrame._stroke,
                  height: dashLen,
                  color: color,
                ),
            ],
          ),
        );
      },
    );
  }
}
