// RestorableDateTime — Deep Visual Demo
//
// This script demonstrates `RestorableDateTime` — a `RestorableProperty<DateTime>`
// that ALWAYS holds a valid, non-null `DateTime`. It is the non-nullable sibling
// of `RestorableDateTimeN`, and is used with `RestorationMixin` to persist
// date/time state across app restarts (and for state restoration on mobile
// platforms that may kill background activities).
//
// Under the hood, `RestorableDateTime` stores its value as a millisecond-since-
// epoch integer (`DateTime.millisecondsSinceEpoch`) in the `RestorationBucket`.
// When the state is restored, the integer is read back and fed into
// `DateTime.fromMillisecondsSinceEpoch` — this is why the property can only
// host values that survive that round-trip (millisecond precision, no
// microseconds).
//
// Rules to remember:
//   * Every `RestorableDateTime` must be registered via `registerForRestoration`
//     inside `restoreState`, under a bucket-unique `restorationId` string.
//   * The enclosing `State` must override `restorationId` with a non-null,
//     widget-unique id.
//   * `RestorableDateTime` is non-null — there is no "not set" state. Use
//     `RestorableDateTimeN` if nullability is needed.
//   * The `initialRestore` parameter of `restoreState` is `true` the very first
//     time the state is restored (i.e. at construction), and `false` on later
//     re-registrations triggered by parent-bucket changes.
//   * Always `dispose()` each `RestorableDateTime` in `State.dispose()`.
//
// This demo wires five side-by-side scenarios into one stateful widget:
//
//   1. Hero "next appointment" card with an analog clock face.
//   2. 7-day calendar strip with anchor-driven highlight.
//   3. Three-timezone synchronized display.
//   4. Circular countdown ring rendered from 60 rotating ticks.
//   5. Vertical visit-history timeline with relative dates.
//
// Every scenario re-uses a different visual vocabulary so that no two
// renderings of a `DateTime` in this file look alike.

import 'package:flutter/material.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Formatting helpers
// ---------------------------------------------------------------------------
//
// These helpers are intentionally pure functions defined at the top of the
// file — the D4rt interpreter evaluates the script top-to-bottom, so keeping
// them near the top means they are in scope for every widget that needs them.

String _formatDate(DateTime d) {
  const months = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  const weekdays = <String>[
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];
  return '${weekdays[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}, ${d.year}';
}

String _formatDateShort(DateTime d) {
  const months = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${months[d.month - 1]} ${d.day}';
}

String _formatTime(DateTime d) {
  final int h24 = d.hour;
  final int h12 = h24 == 0 ? 12 : (h24 > 12 ? h24 - 12 : h24);
  final String suffix = h24 < 12 ? 'AM' : 'PM';
  final String mm = d.minute.toString().padLeft(2, '0');
  return '$h12:$mm $suffix';
}

String _formatTime24(DateTime d) {
  final String hh = d.hour.toString().padLeft(2, '0');
  final String mm = d.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}

String _formatWeekdayShort(DateTime d) {
  const weekdays = <String>[
    'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN',
  ];
  return weekdays[d.weekday - 1];
}

/// Compute a human-readable relative date label versus the fixed anchor.
String _relative(DateTime target, DateTime anchor) {
  // `difference` returns a `Duration` whose sign is target-minus-anchor.
  final Duration diff = target.difference(anchor);
  final int days = diff.inDays;
  if (days == 0) {
    return 'today';
  }
  if (days == 1) {
    return 'tomorrow';
  }
  if (days == -1) {
    return 'yesterday';
  }
  if (days > 1 && days < 7) {
    return 'in $days days';
  }
  if (days >= 7 && days < 14) {
    return 'next week';
  }
  if (days >= 14) {
    return 'in $days days';
  }
  if (days <= -2 && days > -7) {
    return '${-days} days ago';
  }
  if (days <= -7 && days > -14) {
    return 'last week';
  }
  return '${-days} days ago';
}

/// Build a signed-offset string like "+9:00" / "-5:30" / "+0:00".
String _formatOffset(Duration offset) {
  final int totalMinutes = offset.inMinutes;
  final String sign = totalMinutes >= 0 ? '+' : '-';
  final int abs = totalMinutes.abs();
  final int hours = abs ~/ 60;
  final int minutes = abs % 60;
  final String mm = minutes.toString().padLeft(2, '0');
  return '$sign$hours:$mm';
}

// ---------------------------------------------------------------------------
// Script entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('[RestorableDateTime demo] Building MaterialApp...');
  return MaterialApp(
    title: 'RestorableDateTime Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      useMaterial3: true,
    ),
    // The `restorationScopeId` on the `MaterialApp` enables state restoration
    // for the entire subtree — without this, `RestorationMixin` reports
    // restoration as disabled and `registerForRestoration` becomes a no-op.
    restorationScopeId: 'restorable_date_time_demo',
    home: const AppointmentSchedulerDemo(),
  );
}

// ---------------------------------------------------------------------------
// Top-level demo widget
// ---------------------------------------------------------------------------

class AppointmentSchedulerDemo extends StatefulWidget {
  const AppointmentSchedulerDemo({super.key});

  @override
  State<AppointmentSchedulerDemo> createState() =>
      _AppointmentSchedulerDemoState();
}

class _AppointmentSchedulerDemoState extends State<AppointmentSchedulerDemo>
    with RestorationMixin {
  // The "anchor now" is a deterministic, hard-coded timestamp so that the
  // demo's rendering is 100% reproducible regardless of the real wall-clock
  // time. This makes the file well-behaved inside the D4rt test harness —
  // which re-runs the script from a canonical state.
  static final DateTime _anchorNow = DateTime(2026, 4, 23, 10, 0);

  // Scenario 1 — hero "next appointment".
  // A classic `RestorableDateTime` use case: a single appointment that must
  // survive process death on mobile.
  final RestorableDateTime _appointment =
      RestorableDateTime(DateTime(2026, 5, 1, 14, 30));

  // Scenario 2 — Monday-aligned anchor for the calendar strip.
  final RestorableDateTime _anchorDate =
      RestorableDateTime(DateTime(2026, 4, 27));

  // Scenario 3 — master UTC instant for timezone conversion.
  final RestorableDateTime _masterUtc =
      RestorableDateTime(DateTime.utc(2026, 4, 23, 12, 0));

  // Scenario 4 — countdown target and its start anchor.
  final RestorableDateTime _target =
      RestorableDateTime(DateTime(2026, 12, 25, 0, 0));
  final RestorableDateTime _countdownStart =
      RestorableDateTime(DateTime(2026, 4, 23, 0, 0));

  // Scenario 5 — last five visit timestamps, each its own
  // `RestorableDateTime`. Storing them as separate properties makes each one
  // individually restorable under a stable id.
  final RestorableDateTime _visit1 =
      RestorableDateTime(DateTime(2026, 4, 20, 9, 15));
  final RestorableDateTime _visit2 =
      RestorableDateTime(DateTime(2026, 4, 16, 14, 2));
  final RestorableDateTime _visit3 =
      RestorableDateTime(DateTime(2026, 4, 8, 11, 30));
  final RestorableDateTime _visit4 =
      RestorableDateTime(DateTime(2026, 3, 29, 17, 45));
  final RestorableDateTime _visit5 =
      RestorableDateTime(DateTime(2026, 3, 10, 8, 0));

  // ------------------------------------------------------------------
  // RestorationMixin contract
  // ------------------------------------------------------------------

  @override
  String? get restorationId => 'appointment_scheduler_demo_state';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // `initialRestore` is `true` on the very first call following
    // `State.initState` — we register each property under a stable,
    // bucket-unique id. On subsequent parent-bucket swaps, the same ids
    // continue to uniquely identify each property.
    debugPrint(
      '[RestorableDateTime demo] restoreState (initialRestore=$initialRestore)',
    );
    registerForRestoration(_appointment, 'appointment');
    registerForRestoration(_anchorDate, 'anchor_date');
    registerForRestoration(_masterUtc, 'master_utc');
    registerForRestoration(_target, 'target');
    registerForRestoration(_countdownStart, 'countdown_start');
    registerForRestoration(_visit1, 'visit_1');
    registerForRestoration(_visit2, 'visit_2');
    registerForRestoration(_visit3, 'visit_3');
    registerForRestoration(_visit4, 'visit_4');
    registerForRestoration(_visit5, 'visit_5');
  }

  @override
  void dispose() {
    // Each `RestorableProperty` owns a `ChangeNotifier` — failing to dispose
    // leaks a listener registration.
    _appointment.dispose();
    _anchorDate.dispose();
    _masterUtc.dispose();
    _target.dispose();
    _countdownStart.dispose();
    _visit1.dispose();
    _visit2.dispose();
    _visit3.dispose();
    _visit4.dispose();
    _visit5.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------------
  // Mutation helpers — each bumps a `RestorableDateTime` inside setState
  // so the `State` rebuilds with the new value (which is also persisted
  // into the enclosing `RestorationBucket`).
  // ------------------------------------------------------------------

  void _advanceAnchorDay(int delta) {
    setState(() {
      _anchorDate.value = _anchorDate.value.add(Duration(days: delta));
    });
  }

  void _advanceMasterUtc(int hours) {
    setState(() {
      _masterUtc.value = _masterUtc.value.add(Duration(hours: hours));
    });
  }

  void _resetMasterUtc() {
    setState(() {
      _masterUtc.value = DateTime.utc(2026, 4, 23, 12, 0);
    });
  }

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    debugPrint('[RestorableDateTime demo] State.build()');
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestorableDateTime'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFF4F1FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSectionTitle(
              'Scenario 1 — Next appointment',
              'An analog clock face reading from a single RestorableDateTime.',
            ),
            _buildHeroSection(context),
            const SizedBox(height: 28),
            _buildSectionTitle(
              'Scenario 2 — Week strip',
              'A 7-day horizontal strip highlighting the anchor weekday.',
            ),
            _buildWeekStripSection(context),
            const SizedBox(height: 28),
            _buildSectionTitle(
              'Scenario 3 — Three timezones',
              'One master UTC instant, rendered in three offsets.',
            ),
            _buildTimezonesSection(context),
            const SizedBox(height: 28),
            _buildSectionTitle(
              'Scenario 4 — Countdown ring',
              'A 60-tick ring driven by (now - start) / (target - start).',
            ),
            _buildCountdownRingSection(context),
            const SizedBox(height: 28),
            _buildSectionTitle(
              'Scenario 5 — Visit history',
              'Vertical timeline of five independently restorable visits.',
            ),
            _buildVisitHistorySection(context),
            const SizedBox(height: 40),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Small shared helpers
  // ------------------------------------------------------------------

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF3D2A73),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: Colors.deepPurple.shade400, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Each scenario above reads from a RestorableDateTime. '
              'The non-nullable sibling guarantees a valid DateTime at all '
              'times — useful when "no appointment" is not a valid UI state.',
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.deepPurple.shade700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Scenario 1 — Hero next-appointment card with analog clock
  // ------------------------------------------------------------------

  Widget _buildHeroSection(BuildContext context) {
    final DateTime appointment = _appointment.value;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.deepPurple.shade700,
            Colors.indigo.shade500,
            Colors.blue.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Top row: big date on the left, big time on the right.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NEXT APPOINTMENT'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _formatDate(appointment),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                        shadows: <Shadow>[
                          Shadow(
                            color: Color(0x66000000),
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _relative(appointment, _anchorNow),
                      style: TextStyle(
                        color: Colors.amber.shade200,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Big time — contrasting color.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _formatTime(appointment),
                  style: TextStyle(
                    color: Colors.deepPurple.shade900,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Bottom row: analog clock face + meta info.
          Row(
            children: <Widget>[
              _buildAnalogClock(appointment, size: 160),
              const SizedBox(width: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeroMetaRow(
                      icon: Icons.schedule,
                      label: 'Local time',
                      value: _formatTime24(appointment),
                    ),
                    const SizedBox(height: 10),
                    _buildHeroMetaRow(
                      icon: Icons.calendar_today,
                      label: 'Weekday',
                      value: _formatWeekdayShort(appointment),
                    ),
                    const SizedBox(height: 10),
                    _buildHeroMetaRow(
                      icon: Icons.watch_later_outlined,
                      label: 'Epoch (ms)',
                      value: appointment.millisecondsSinceEpoch.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroMetaRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamilyFallback: <String>['monospace'],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Analog clock face rendered without CustomPaint — a Stack of rotated
  /// Containers acts as ticks and hands.
  Widget _buildAnalogClock(DateTime d, {required double size}) {
    final double radius = size / 2;
    final int hour = d.hour % 12;
    final int minute = d.minute;

    // Hour hand angle in radians, from 12 o'clock, clockwise.
    final double hourAngle = (hour + minute / 60.0) / 12.0 * 2 * math.pi;
    // Minute hand angle.
    final double minuteAngle = minute / 60.0 * 2 * math.pi;

    final List<Widget> ticks = <Widget>[];
    for (int i = 0; i < 12; i++) {
      final double angle = i / 12.0 * 2 * math.pi;
      final bool major = i % 3 == 0;
      ticks.add(
        Transform.translate(
          offset: Offset(
            (radius - 8) * math.sin(angle),
            -(radius - 8) * math.cos(angle),
          ),
          child: Transform.rotate(
            angle: angle,
            child: Container(
              width: major ? 3 : 2,
              height: major ? 12 : 7,
              decoration: BoxDecoration(
                color: major
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      );
    }

    // 12 numeral labels — small white digits.
    final List<Widget> numerals = <Widget>[];
    for (int i = 1; i <= 12; i++) {
      final double angle = i / 12.0 * 2 * math.pi;
      final double nx = (radius - 24) * math.sin(angle);
      final double ny = -(radius - 24) * math.cos(angle);
      numerals.add(
        Transform.translate(
          offset: Offset(nx, ny),
          child: Text(
            '$i',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            Colors.deepPurple.shade900,
            Colors.black.withValues(alpha: 0.55),
          ],
        ),
        border: Border.all(
          color: Colors.amber.shade300,
          width: 3,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ...ticks,
          ...numerals,
          // Hour hand — short, thick.
          Transform.rotate(
            angle: hourAngle,
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 5,
                height: radius * 0.55,
                margin: EdgeInsets.only(bottom: radius * 0.55),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          // Minute hand — long, thin.
          Transform.rotate(
            angle: minuteAngle,
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 3,
                height: radius * 0.82,
                margin: EdgeInsets.only(bottom: radius * 0.82),
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // Centre cap.
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.amber.shade300,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Scenario 2 — 7-day calendar strip
  // ------------------------------------------------------------------

  Widget _buildWeekStripSection(BuildContext context) {
    final DateTime anchor = _anchorDate.value;
    // Find the Monday of `anchor`'s ISO week — DateTime.weekday returns
    // 1 (Mon) ... 7 (Sun). Subtracting that offset anchors us back to Monday.
    final DateTime monday = anchor.subtract(Duration(days: anchor.weekday - 1));

    final List<Widget> dayCards = <Widget>[];
    for (int i = 0; i < 7; i++) {
      final DateTime day = monday.add(Duration(days: i));
      final bool isAnchor = day.year == anchor.year &&
          day.month == anchor.month &&
          day.day == anchor.day;
      dayCards.add(Expanded(child: _buildDayCard(day, highlighted: isAnchor)));
      if (i < 6) {
        dayCards.add(const SizedBox(width: 6));
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(children: dayCards),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Icon(
                Icons.place_outlined,
                size: 16,
                color: Colors.deepPurple.shade400,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Anchor date: ${_formatDate(anchor)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.deepPurple.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildStripButton(
                icon: Icons.chevron_left,
                label: 'Prev day',
                onPressed: () => _advanceAnchorDay(-1),
              ),
              const SizedBox(width: 8),
              _buildStripButton(
                icon: Icons.chevron_right,
                label: 'Next day',
                onPressed: () => _advanceAnchorDay(1),
                primary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool primary = false,
  }) {
    final Color bg =
        primary ? Colors.deepPurple.shade600 : Colors.deepPurple.shade50;
    final Color fg =
        primary ? Colors.white : Colors.deepPurple.shade800;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: primary
              ? null
              : Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: fg, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(DateTime day, {required bool highlighted}) {
    if (highlighted) {
      return Container(
        height: 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.deepPurple.shade500,
              Colors.indigo.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.amber.shade300, width: 2.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'TODAY',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple.shade900,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatWeekdayShort(day),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.85),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              '${day.day}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            Text(
              _formatDateShort(day),
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _formatWeekdayShort(day),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _formatDateShort(day),
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Scenario 3 — Three-timezone display
  // ------------------------------------------------------------------

  Widget _buildTimezonesSection(BuildContext context) {
    final DateTime utc = _masterUtc.value.toUtc();
    final DateTime local = utc.toLocal();
    final DateTime tokyo = utc.add(const Duration(hours: 9));
    final Duration localOffset = local.timeZoneOffset;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildTimezoneCard(
                  icon: Icons.place,
                  label: 'LOCAL',
                  dateTime: local,
                  stripe: Colors.green.shade600,
                  offsetLabel: _formatOffset(localOffset),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTimezoneCard(
                  icon: Icons.public,
                  label: 'UTC',
                  dateTime: utc,
                  stripe: Colors.blue.shade600,
                  offsetLabel: '+0:00',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTimezoneCard(
                  icon: Icons.flag,
                  label: 'TOKYO',
                  dateTime: tokyo,
                  stripe: Colors.deepPurple.shade400,
                  offsetLabel: '+9:00',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Master UTC instant: ${utc.toIso8601String()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamilyFallback: const <String>['monospace'],
                  ),
                ),
              ),
              _buildStripButton(
                icon: Icons.refresh,
                label: 'Reset',
                onPressed: _resetMasterUtc,
              ),
              const SizedBox(width: 8),
              _buildStripButton(
                icon: Icons.add,
                label: '+1 hour',
                onPressed: () => _advanceMasterUtc(1),
                primary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneCard({
    required IconData icon,
    required String label,
    required DateTime dateTime,
    required Color stripe,
    required String offsetLabel,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBFAFE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Colored stripe at the top.
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: stripe,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: stripe.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: stripe, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: stripe,
                        letterSpacing: 1.6,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: stripe.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        offsetLabel,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: stripe,
                          fontFamilyFallback: const <String>['monospace'],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _formatTime24(dateTime),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF27214A),
                    height: 1.05,
                    fontFamilyFallback: <String>['monospace'],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(dateTime),
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Scenario 4 — Countdown ring
  // ------------------------------------------------------------------

  Widget _buildCountdownRingSection(BuildContext context) {
    final DateTime start = _countdownStart.value;
    final DateTime target = _target.value;

    final Duration total = target.difference(start);
    final Duration elapsed = _anchorNow.difference(start);
    double fraction = total.inMinutes == 0
        ? 1.0
        : elapsed.inMinutes / total.inMinutes;
    if (fraction < 0) fraction = 0;
    if (fraction > 1) fraction = 1;

    final Duration remaining = target.difference(_anchorNow);
    final int remainingDays = remaining.inDays;
    final int remainingHours = remaining.inHours % 24;
    final int remainingMinutes = remaining.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A1046),
            Colors.indigo.shade900,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          _buildCountdownRing(fraction, size: 180),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'COUNTDOWN TO',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 11,
                    letterSpacing: 2.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(target),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                _buildCountdownStat(
                  '$remainingDays',
                  'days',
                  Colors.amber.shade300,
                ),
                const SizedBox(height: 6),
                _buildCountdownStat(
                  '$remainingHours',
                  'hours',
                  Colors.pink.shade300,
                ),
                const SizedBox(height: 6),
                _buildCountdownStat(
                  '$remainingMinutes',
                  'minutes',
                  Colors.cyan.shade300,
                ),
                const SizedBox(height: 14),
                Text(
                  'Elapsed ${(fraction * 100).toStringAsFixed(1)}% of the '
                  'window that started ${_formatDateShort(start)}.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
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

  Widget _buildCountdownStat(String value, String label, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamilyFallback: const <String>['monospace'],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  /// A 60-tick ring whose ticks up to `fraction * 60` are colored
  /// green→orange→red to signal "how close we are to the deadline".
  Widget _buildCountdownRing(double fraction, {required double size}) {
    final double radius = size / 2;
    final int activeTicks = (fraction * 60).round();

    final List<Widget> ticks = <Widget>[];
    for (int i = 0; i < 60; i++) {
      final double angle = i / 60.0 * 2 * math.pi;
      final bool active = i < activeTicks;
      final double t = activeTicks == 0 ? 0 : i / 60.0;
      final Color color = active
          ? Color.lerp(
              Colors.greenAccent.shade400,
              Colors.redAccent.shade200,
              t,
            )!
          : Colors.white.withValues(alpha: 0.12);
      ticks.add(
        Transform.translate(
          offset: Offset(
            (radius - 10) * math.sin(angle),
            -(radius - 10) * math.cos(angle),
          ),
          child: Transform.rotate(
            angle: angle,
            child: Container(
              width: 3,
              height: 14,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            Colors.indigo.shade900,
            Colors.black.withValues(alpha: 0.5),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ...ticks,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${(fraction * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  fontFamilyFallback: <String>['monospace'],
                ),
              ),
              Text(
                'elapsed',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Scenario 5 — Visit history timeline
  // ------------------------------------------------------------------

  Widget _buildVisitHistorySection(BuildContext context) {
    final List<DateTime> visits = <DateTime>[
      _visit1.value,
      _visit2.value,
      _visit3.value,
      _visit4.value,
      _visit5.value,
    ];
    final List<Color> accents = <Color>[
      Colors.deepPurple.shade400,
      Colors.teal.shade400,
      Colors.pink.shade400,
      Colors.orange.shade400,
      Colors.blue.shade400,
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < visits.length; i++)
            _buildVisitRow(
              index: i,
              visit: visits[i],
              accent: accents[i],
              isFirst: i == 0,
              isLast: i == visits.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _buildVisitRow({
    required int index,
    required DateTime visit,
    required Color accent,
    required bool isFirst,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Timeline spine with dot.
          SizedBox(
            width: 42,
            child: Column(
              children: <Widget>[
                // Top connector (empty for first row).
                Expanded(
                  child: Container(
                    width: 3,
                    color: isFirst
                        ? Colors.transparent
                        : _accentGradientTop(index, accent),
                  ),
                ),
                // Dot.
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: accent.withValues(alpha: 0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                // Bottom connector (empty for last row).
                Expanded(
                  child: Container(
                    width: 3,
                    color: isLast
                        ? Colors.transparent
                        : _accentGradientBottom(index, accent),
                  ),
                ),
              ],
            ),
          ),
          // Card.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Visit #${index + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              color: accent,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(visit),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF27214A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _relative(visit, _anchorNow),
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _formatTime(visit),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamilyFallback: <String>['monospace'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _accentGradientTop(int index, Color accent) {
    // Slightly darker tint for the portion above the dot — suggests flow
    // coming down from the previous dot.
    return accent.withValues(alpha: 0.55);
  }

  Color _accentGradientBottom(int index, Color accent) {
    return accent.withValues(alpha: 0.4);
  }
}
