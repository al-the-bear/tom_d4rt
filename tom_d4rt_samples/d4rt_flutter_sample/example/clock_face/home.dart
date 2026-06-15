// Clock-face shell.
//
// Layout (top → bottom):
//   • AppBar with play/pause IconButton + the elapsed-seconds label.
//   • Big analog clock (200 × 200) showing the local time.
//   • Date pill.
//   • Row: small "world" clock (80 × 80) on the left, the
//     rotary `TimezoneDial` (110 × 110) on the right.
//   • UTC-offset label below the row.
//
// State:
//   • `_baseTime`        — `DateTime(2026, 5, 21, 12, 0, 0)` — a
//                          deterministic anchor so the painter math
//                          is reproducible across runs/tests.
//   • `_controller`      — `AnimationController(duration: 1 minute)`
//                          running on repeat. Provides smooth
//                          fractional-second sweep for the second
//                          hand.
//   • `_offsetMinutes`   — current dial setting in minutes.
//   • `_displayedSecond` — last whole second we printed a trail
//                          line for. Re-printed only when the second
//                          changes so the log stays readable.
//   • `_running`         — true when the controller is animating.
//
// Trail:
//   clock.boot base=<iso> offsetMin=0
//   clock.play / clock.pause
//   clock.tick second=<n>
//   dial.rotate offsetMin=<m>
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'package:flutter/material.dart';

import 'clock.dart';
import 'clock_painter.dart';
import 'timezone_dial.dart';

class ClockFaceApp extends StatelessWidget {
  const ClockFaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clock_face',
      theme: ThemeData(useMaterial3: true),
      home: const ClockHome(),
    );
  }
}

class ClockHome extends StatefulWidget {
  const ClockHome({super.key});

  @override
  State<ClockHome> createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome>
    with SingleTickerProviderStateMixin {
  late final DateTime _baseTime;
  late final AnimationController _controller;
  int _offsetMinutes = 0;
  int _displayedSecond = 0;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _baseTime = DateTime(2026, 5, 21, 12, 0, 0);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    _controller.addListener(_onTick);
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      print('clock.boot base=${_baseTime.toIso8601String()} offsetMin=0');
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.dispose();
    super.dispose();
  }

  Duration get _elapsed {
    // `controller.value` runs 0..1 over the 60-second duration; multiply
    // back into milliseconds so we keep sub-second precision for the
    // smooth sweep.
    final double ms = _controller.value * 60.0 * 1000.0;
    return Duration(milliseconds: ms.round());
  }

  ClockTime get _clockTime => ClockTime(
        instant: _baseTime.add(_elapsed),
        timezoneOffsetMinutes: _offsetMinutes,
      );

  void _onTick() {
    final int sec = _elapsed.inSeconds;
    if (sec != _displayedSecond) {
      _displayedSecond = sec;
      print('clock.tick second=$sec');
    }
    if (mounted) setState(() {});
  }

  void _togglePlay() {
    setState(() {
      _running = !_running;
    });
    if (_running) {
      _controller.repeat();
      print('clock.play');
    } else {
      _controller.stop();
      print('clock.pause');
    }
  }

  void _onDialChanged(int newOffsetMinutes) {
    if (newOffsetMinutes == _offsetMinutes) return;
    setState(() {
      _offsetMinutes = newOffsetMinutes;
    });
    print('dial.rotate offsetMin=$newOffsetMinutes');
  }

  String _formatDate(DateTime t) {
    final String mm = t.month < 10 ? '0${t.month}' : '${t.month}';
    final String dd = t.day < 10 ? '0${t.day}' : '${t.day}';
    return '${t.year}-$mm-$dd';
  }

  String _formatTime(DateTime t) {
    String pad(int v) => v < 10 ? '0$v' : '$v';
    return '${pad(t.hour)}:${pad(t.minute)}:${pad(t.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final ClockTime ct = _clockTime;
    return Scaffold(
      key: const Key('clock-scaffold'),
      appBar: AppBar(
        title: const Text('clock_face'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                _formatTime(ct.withOffset),
                key: const Key('time-label'),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          IconButton(
            key: const Key('play-button'),
            icon: Icon(_running ? Icons.pause : Icons.play_arrow),
            tooltip: _running ? 'Pause' : 'Play',
            onPressed: _togglePlay,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16.0),
            SizedBox(
              key: const Key('main-clock'),
              width: 200.0,
              height: 200.0,
              child: CustomPaint(
                size: const Size(200.0, 200.0),
                painter: ClockPainter(
                  hourAngle: ct.hourAngle,
                  minuteAngle: ct.minuteAngle,
                  secondAngle: ct.secondAngle,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              key: const Key('date-pill'),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                _formatDate(ct.withOffset),
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  key: const Key('world-clock'),
                  width: 80.0,
                  height: 80.0,
                  child: CustomPaint(
                    size: const Size(80.0, 80.0),
                    painter: ClockPainter(
                      hourAngle: ct.hourAngle,
                      minuteAngle: ct.minuteAngle,
                      secondAngle: ct.secondAngle,
                      showSecondHand: false,
                    ),
                  ),
                ),
                const SizedBox(width: 24.0),
                SizedBox(
                  width: 110.0,
                  height: 110.0,
                  child: TimezoneDial(
                    offsetMinutes: _offsetMinutes,
                    onChanged: _onDialChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              formatOffset(_offsetMinutes),
              key: const Key('offset-label'),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16.0),
            // Helper IconButtons so users — and tests — can step the
            // dial without simulating a real drag gesture.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  key: const Key('dial-minus'),
                  icon: const Icon(Icons.remove),
                  tooltip: 'Earlier zone',
                  onPressed: () => _onDialChanged(
                    quantizeOffsetMinutes(_offsetMinutes - 60),
                  ),
                ),
                IconButton(
                  key: const Key('dial-plus'),
                  icon: const Icon(Icons.add),
                  tooltip: 'Later zone',
                  onPressed: () => _onDialChanged(
                    quantizeOffsetMinutes(_offsetMinutes + 60),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
