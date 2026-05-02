// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - TimePickerEntryMode (Material)
// Comprehensive demonstration of every TimePickerEntryMode value, paired with
// hand-rendered mock previews and live showTimePicker invocations. Each
// section explores a different facet:
//   - per-value live launchers (dial, input, dialOnly, inputOnly)
//   - hand-painted dial mock + numeric input mock
//   - locked vs switchable mode comparison
//   - TimePickerThemeData integration with custom palette
//   - result history list backed by ValueNotifier
//   - programmatic preselection (now / fixed / midnight)
//   - cancel handling with null-coalescing
//   - use-case recipes (alarm, report, child-friendly, accessibility)
//   - 24-hour vs 12-hour comparison
//   - decision-guide card
//
// Educational goal: help readers pick the right entry mode for their audience.
// Touch-first audiences, simplified UIs, and child-friendly apps usually want
// the dial or dialOnly. Keyboard-first audiences, data-entry forms, and
// accessibility-critical surfaces typically want the input or inputOnly mode.
import 'package:flutter/material.dart';

// =============================================================================
// CUSTOM PAINTER FOR THE STATIC DIAL MOCK
// =============================================================================
class _DialMockPainter extends CustomPainter {
  const _DialMockPainter({
    required this.faceColor,
    required this.tickColor,
    required this.handColor,
    required this.numeralColor,
  });

  final Color faceColor;
  final Color tickColor;
  final Color handColor;
  final Color numeralColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.shortestSide / 2.0 - 4.0;

    // Face
    final facePaint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    // Outer ring
    final ringPaint = Paint()
      ..color = tickColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, ringPaint);

    // Hour ticks (12 marks)
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 2.0;
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * 3.1415926535 / 180.0;
      final outer = Offset(
        center.dx + (radius - 2.0) * _sin(angle),
        center.dy - (radius - 2.0) * _cos(angle),
      );
      final inner = Offset(
        center.dx + (radius - 12.0) * _sin(angle),
        center.dy - (radius - 12.0) * _cos(angle),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    // Numerals at 12, 3, 6, 9
    final numerals = <int, String>{
      0: '12',
      3: '3',
      6: '6',
      9: '9',
    };
    numerals.forEach((position, label) {
      final angle = (position * 30) * 3.1415926535 / 180.0;
      final spot = Offset(
        center.dx + (radius - 24.0) * _sin(angle),
        center.dy - (radius - 24.0) * _cos(angle),
      );
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: numeralColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(spot.dx - tp.width / 2.0, spot.dy - tp.height / 2.0),
      );
    });

    // Hour hand (pointing to 10 = -60 degrees from 12 -> position 10)
    final hourAngle = (10 * 30) * 3.1415926535 / 180.0;
    final hourEnd = Offset(
      center.dx + (radius * 0.55) * _sin(hourAngle),
      center.dy - (radius * 0.55) * _cos(hourAngle),
    );
    final handPaint = Paint()
      ..color = handColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, hourEnd, handPaint);

    // Center dot
    final dotPaint = Paint()..color = handColor;
    canvas.drawCircle(center, 4.0, dotPaint);
  }

  // Tiny taylor approximations are unnecessary — use dart:math via simple
  // local helpers built from canvas math. We re-import via inline transform.
  double _sin(double rad) {
    // Use Newton-style polynomial approximation. Keep it simple & accurate
    // enough for a static mock (we only render once).
    // Normalize to -pi..pi
    double x = rad;
    const twoPi = 2.0 * 3.1415926535;
    while (x > 3.1415926535) {
      x -= twoPi;
    }
    while (x < -3.1415926535) {
      x += twoPi;
    }
    final x2 = x * x;
    return x -
        (x * x2) / 6.0 +
        (x * x2 * x2) / 120.0 -
        (x * x2 * x2 * x2) / 5040.0;
  }

  double _cos(double rad) {
    return _sin(rad + 1.5707963267948966);
  }

  @override
  bool shouldRepaint(covariant _DialMockPainter oldDelegate) {
    return oldDelegate.faceColor != faceColor ||
        oldDelegate.tickColor != tickColor ||
        oldDelegate.handColor != handColor ||
        oldDelegate.numeralColor != numeralColor;
  }
}

// =============================================================================
// BUILD ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  print('=== TimePickerEntryMode Deep Demo (Live + Mock) ===');
  for (final m in TimePickerEntryMode.values) {
    print('  ${m.index}: ${m.name}');
  }

  // History notifier shared across launcher sections.
  final ValueNotifier<List<TimeOfDay>> history =
      ValueNotifier<List<TimeOfDay>>(<TimeOfDay>[]);

  // Helper: launch picker and append to history.
  Future<TimeOfDay?> launchPicker(
    BuildContext ctx, {
    required TimePickerEntryMode mode,
    TimeOfDay? initial,
    bool use24Hour = false,
  }) async {
    final TimeOfDay seed = initial ?? const TimeOfDay(hour: 9, minute: 30);
    Widget Function(BuildContext, Widget?) wrapper;
    if (use24Hour) {
      wrapper = (innerCtx, child) => MediaQuery(
            data: MediaQuery.of(innerCtx)
                .copyWith(alwaysUse24HourFormat: true),
            child: child ?? const SizedBox.shrink(),
          );
    } else {
      wrapper = (innerCtx, child) => child ?? const SizedBox.shrink();
    }
    final result = await showTimePicker(
      context: ctx,
      initialTime: seed,
      initialEntryMode: mode,
      builder: wrapper,
    );
    if (result != null) {
      history.value = <TimeOfDay>[...history.value, result];
    }
    return result;
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TimePickerEntryMode Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TimePickerEntryMode'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: const Color(0xFFFFFFFF),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ==============================================================
              // HEADER
              // ==============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TimePickerEntryMode',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Deep Demo: dial, input, dialOnly, inputOnly',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xFFBBDEFB)),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Each section combines a real showTimePicker launch '
                      'with hand-rendered mock previews and educational '
                      'commentary. Use the launchers to see the actual '
                      'platform dialog, then refer to the mocks to recall '
                      'what each entry mode looks like.',
                      style: TextStyle(fontSize: 13.0, color: Color(0xFFE3F2FD)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ==============================================================
              // SECTION 1: ENUM OVERVIEW
              // ==============================================================
              _SectionCard(
                title: '1. The four entry modes',
                bg: const Color(0xFFE3F2FD),
                border: const Color(0xFF90CAF9),
                accent: const Color(0xFF0D47A1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TimePickerEntryMode controls which UI the dialog '
                      'starts with and whether the user can switch.',
                      style: TextStyle(fontSize: 13.0, height: 1.5),
                    ),
                    const SizedBox(height: 12.0),
                    for (final m in TimePickerEntryMode.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: [
                            Container(
                              width: 28.0,
                              height: 28.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1976D2),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${m.index}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                m.name,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              _modeDescription(m),
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF455A64),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 2: PER-VALUE LIVE LAUNCHERS
              // ==============================================================
              StatefulBuilder(
                builder: (ctx, setState) {
                  return _SectionCard(
                    title: '2. Per-value live launchers',
                    bg: const Color(0xFFE8F5E9),
                    border: const Color(0xFF81C784),
                    accent: const Color(0xFF1B5E20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tap each launcher to open showTimePicker with the '
                          'specified initialEntryMode. The chosen TimeOfDay '
                          'appears below.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        for (final mode in TimePickerEntryMode.values)
                          _LiveLauncherTile(
                            mode: mode,
                            onLaunch: () async {
                              final result =
                                  await launchPicker(ctx, mode: mode);
                              setState(() {});
                              return result;
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 3: STATIC DIAL MOCK
              // ==============================================================
              _SectionCard(
                title: '3. Mock preview — dial mode',
                bg: const Color(0xFFFFF3E0),
                border: const Color(0xFFFFB74D),
                accent: const Color(0xFFE65100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hand-painted approximation of the dial-style picker. '
                      'A circular face, hour ticks, four numerals, and a '
                      'single hand pointing to 10:00.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: const Color(0xFFFFD180),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '10:00',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE65100),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: CustomPaint(
                                painter: const _DialMockPainter(
                                  faceColor: Color(0xFFFFF8E1),
                                  tickColor: Color(0xFFFFB74D),
                                  handColor: Color(0xFFE65100),
                                  numeralColor: Color(0xFF6D4C41),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _ChipTag(
                                  label: 'AM',
                                  bg: const Color(0xFFE65100),
                                  fg: const Color(0xFFFFFFFF),
                                ),
                                const SizedBox(width: 8.0),
                                _ChipTag(
                                  label: 'PM',
                                  bg: const Color(0xFFFFE0B2),
                                  fg: const Color(0xFFE65100),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'In dial mode the user drags the hand around the face. '
                      'Touch-first audiences (mobile users, casual apps) tend '
                      'to find this faster than typing two numbers.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6D4C41),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 4: STATIC INPUT MOCK
              // ==============================================================
              _SectionCard(
                title: '4. Mock preview — input mode',
                bg: const Color(0xFFEDE7F6),
                border: const Color(0xFF9575CD),
                accent: const Color(0xFF311B92),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hand-rendered approximation of the keyboard-input '
                      'picker. Two TextFields surrounded by a colon, a '
                      'helper label, and an AM/PM toggle.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: const Color(0xFFB39DDB),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter time',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF5E35B1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  controller:
                                      TextEditingController(text: '10'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF311B92),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFEDE7F6),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0),
                                    ),
                                    labelText: 'Hour',
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 36.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF311B92),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  controller:
                                      TextEditingController(text: '30'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF311B92),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFEDE7F6),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0),
                                    ),
                                    labelText: 'Minute',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Column(
                                children: [
                                  _ChipTag(
                                    label: 'AM',
                                    bg: const Color(0xFF311B92),
                                    fg: const Color(0xFFFFFFFF),
                                  ),
                                  const SizedBox(height: 6.0),
                                  _ChipTag(
                                    label: 'PM',
                                    bg: const Color(0xFFEDE7F6),
                                    fg: const Color(0xFF311B92),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          const Text(
                            'Tip: numeric keyboard auto-focuses the hour '
                            'field. Tab moves to the minute field.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF5E35B1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Input mode is keyboard-first. Power users entering '
                      'precise times benefit from typing. Accessibility-'
                      'critical surfaces should default to inputOnly so '
                      'screen readers can interact with two TextFields.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF311B92),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 5: SWITCHABLE vs LOCKED
              // ==============================================================
              _SectionCard(
                title: '5. User can switch vs locked mode',
                bg: const Color(0xFFFCE4EC),
                border: const Color(0xFFF06292),
                accent: const Color(0xFF880E4F),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    TimeOfDay? lastSwitchable;
                    TimeOfDay? lastLocked;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'dial and input let the user toggle entry style '
                          'inside the dialog (a small icon at the bottom). '
                          'dialOnly and inputOnly hide that icon — the '
                          'chosen mode is locked.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            Expanded(
                              child: _ComparePane(
                                label: 'Switchable (dial)',
                                detail:
                                    'User can toggle to keyboard inside the '
                                    'dialog by tapping the keyboard icon.',
                                accent: const Color(0xFFC2185B),
                                onPressed: () async {
                                  final r = await launchPicker(
                                    ctx,
                                    mode: TimePickerEntryMode.dial,
                                  );
                                  lastSwitchable = r;
                                  setState(() {});
                                },
                                lastResult: lastSwitchable,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: _ComparePane(
                                label: 'Locked (dialOnly)',
                                detail:
                                    'No toggle button, the user must use the '
                                    'dial.',
                                accent: const Color(0xFFAD1457),
                                onPressed: () async {
                                  final r = await launchPicker(
                                    ctx,
                                    mode: TimePickerEntryMode.dialOnly,
                                  );
                                  lastLocked = r;
                                  setState(() {});
                                },
                                lastResult: lastLocked,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Lock the mode when (a) you only have one realistic '
                          'audience, (b) you want a simpler UI for children, '
                          'or (c) accessibility/keyboard-first users would '
                          'be confused by the dial. Allow switching when you '
                          'serve mixed audiences.',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF880E4F),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 6: TimePickerThemeData INTEGRATION
              // ==============================================================
              _SectionCard(
                title: '6. TimePickerThemeData integration',
                bg: const Color(0xFFE0F2F1),
                border: const Color(0xFF4DB6AC),
                accent: const Color(0xFF004D40),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    TimeOfDay? themed;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wrap the launcher in a Theme(...) using a custom '
                          'TimePickerThemeData. The dial color, hour/minute '
                          'color, and day-period color all change.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: const Color(0xFF00897B),
                            ),
                            useMaterial3: true,
                            timePickerTheme: TimePickerThemeData(
                              backgroundColor: const Color(0xFFE0F2F1),
                              dialBackgroundColor: const Color(0xFFB2DFDB),
                              dialHandColor: const Color(0xFF00695C),
                              dialTextColor: const Color(0xFF004D40),
                              hourMinuteColor: const Color(0xFF80CBC4),
                              hourMinuteTextColor: const Color(0xFF004D40),
                              dayPeriodColor: const Color(0xFF4DB6AC),
                              dayPeriodTextColor: const Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Builder(
                            builder: (themedCtx) => Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: [
                                FilledButton.icon(
                                  onPressed: () async {
                                    final r = await showTimePicker(
                                      context: themedCtx,
                                      initialTime:
                                          const TimeOfDay(hour: 8, minute: 15),
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                    );
                                    if (r != null) {
                                      history.value = <TimeOfDay>[
                                        ...history.value,
                                        r,
                                      ];
                                    }
                                    themed = r;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.palette),
                                  label: const Text('Themed dial'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () async {
                                    final r = await showTimePicker(
                                      context: themedCtx,
                                      initialTime:
                                          const TimeOfDay(hour: 8, minute: 15),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                    );
                                    if (r != null) {
                                      history.value = <TimeOfDay>[
                                        ...history.value,
                                        r,
                                      ];
                                    }
                                    themed = r;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.keyboard),
                                  label: const Text('Themed input'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB2DFDB),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            themed == null
                                ? 'No themed selection yet.'
                                : 'Selected: ${_format(themed!)}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13.0,
                              color: Color(0xFF004D40),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 7: HISTORY LIST
              // ==============================================================
              _SectionCard(
                title: '7. Result history',
                bg: const Color(0xFFE8EAF6),
                border: const Color(0xFF7986CB),
                accent: const Color(0xFF1A237E),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Every successful pick from any section in this demo is '
                      'appended to a ValueNotifier<List<TimeOfDay>>. The '
                      'list rebuilds reactively.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 12.0),
                    ValueListenableBuilder<List<TimeOfDay>>(
                      valueListenable: history,
                      builder: (ctx, items, _) {
                        if (items.isEmpty) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC5CAE9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text(
                              'No times picked yet — open any launcher above '
                              'to populate this list.',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF1A237E),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            for (int i = 0; i < items.length; i++)
                              Container(
                                margin: const EdgeInsets.only(bottom: 6.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC5CAE9),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          const Color(0xFF3F51B5),
                                      foregroundColor:
                                          const Color(0xFFFFFFFF),
                                      radius: 12.0,
                                      child: Text(
                                        '${i + 1}',
                                        style: const TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        _format(items[i]),
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 14.0,
                                          color: Color(0xFF1A237E),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 3.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3F51B5),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        items[i].period == DayPeriod.am
                                            ? 'AM'
                                            : 'PM',
                                        style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 6.0),
                            TextButton.icon(
                              onPressed: () {
                                history.value = <TimeOfDay>[];
                              },
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear history'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 8: PROGRAMMATIC PRESELECTION
              // ==============================================================
              _SectionCard(
                title: '8. Programmatic preselection (initialTime)',
                bg: const Color(0xFFFFF8E1),
                border: const Color(0xFFFFD54F),
                accent: const Color(0xFFFF6F00),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    TimeOfDay? choice;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'initialTime seeds the dialog. Three common '
                          'choices: now, a fixed business time, midnight.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            FilledButton(
                              onPressed: () async {
                                final now = TimeOfDay.now();
                                final r = await launchPicker(
                                  ctx,
                                  mode: TimePickerEntryMode.input,
                                  initial: now,
                                );
                                choice = r;
                                setState(() {});
                              },
                              child: const Text('Now'),
                            ),
                            FilledButton(
                              onPressed: () async {
                                final r = await launchPicker(
                                  ctx,
                                  mode: TimePickerEntryMode.input,
                                  initial:
                                      const TimeOfDay(hour: 9, minute: 0),
                                );
                                choice = r;
                                setState(() {});
                              },
                              child: const Text('09:00 (start of day)'),
                            ),
                            FilledButton(
                              onPressed: () async {
                                final r = await launchPicker(
                                  ctx,
                                  mode: TimePickerEntryMode.input,
                                  initial:
                                      const TimeOfDay(hour: 0, minute: 0),
                                );
                                choice = r;
                                setState(() {});
                              },
                              child: const Text('Midnight'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE082),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            choice == null
                                ? 'Pick a preset to see the dialog seed.'
                                : 'Picked: ${_format(choice!)}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13.0,
                              color: Color(0xFFFF6F00),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 9: CANCEL HANDLING
              // ==============================================================
              _SectionCard(
                title: '9. Cancel handling',
                bg: const Color(0xFFFFEBEE),
                border: const Color(0xFFEF9A9A),
                accent: const Color(0xFFB71C1C),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    String status = 'Idle — nothing picked yet.';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'showTimePicker returns null when the user taps '
                          'CANCEL. The launcher must guard against null '
                          'before using the result.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        FilledButton.icon(
                          onPressed: () async {
                            final result = await launchPicker(
                              ctx,
                              mode: TimePickerEntryMode.input,
                            );
                            if (result == null) {
                              status =
                                  'User cancelled — no time recorded. '
                                  '(returned null)';
                            } else {
                              status = 'User confirmed: ${_format(result)}.';
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.access_time),
                          label: const Text('Open and try cancel'),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFCDD2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13.0,
                              color: Color(0xFFB71C1C),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: const Color(0xFFEF9A9A),
                            ),
                          ),
                          child: const Text(
                            'final result = await showTimePicker(...);\n'
                            'if (result == null) { return; }\n'
                            'use(result);',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 10: USE-CASE RECIPES
              // ==============================================================
              _SectionCard(
                title: '10. Use-case recipes',
                bg: const Color(0xFFE0F7FA),
                border: const Color(0xFF4DD0E1),
                accent: const Color(0xFF006064),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    String? lastRecipe;
                    TimeOfDay? lastTime;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Each recipe pre-selects the right entry mode for '
                          'a real-world audience. Tap to launch.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        _RecipeTile(
                          icon: Icons.alarm,
                          title: 'Alarm setup',
                          subtitle:
                              'Touch-first, casual users. Use dial — fast '
                              'and tactile. Allow switching for power users.',
                          mode: TimePickerEntryMode.dial,
                          tint: const Color(0xFF00838F),
                          onLaunch: () async {
                            final r = await launchPicker(
                              ctx,
                              mode: TimePickerEntryMode.dial,
                              initial:
                                  const TimeOfDay(hour: 7, minute: 0),
                            );
                            lastRecipe = 'Alarm setup';
                            lastTime = r;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 8.0),
                        _RecipeTile(
                          icon: Icons.assignment,
                          title: 'Report start time',
                          subtitle:
                              'Office data entry. Use inputOnly so users '
                              'can type quickly without dragging.',
                          mode: TimePickerEntryMode.inputOnly,
                          tint: const Color(0xFF00ACC1),
                          onLaunch: () async {
                            final r = await launchPicker(
                              ctx,
                              mode: TimePickerEntryMode.inputOnly,
                              initial:
                                  const TimeOfDay(hour: 8, minute: 30),
                            );
                            lastRecipe = 'Report start time';
                            lastTime = r;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 8.0),
                        _RecipeTile(
                          icon: Icons.child_care,
                          title: 'Child-friendly app',
                          subtitle:
                              'Younger or non-technical users. Use dialOnly '
                              'so the keyboard does not appear.',
                          mode: TimePickerEntryMode.dialOnly,
                          tint: const Color(0xFF00ACC1),
                          onLaunch: () async {
                            final r = await launchPicker(
                              ctx,
                              mode: TimePickerEntryMode.dialOnly,
                              initial:
                                  const TimeOfDay(hour: 18, minute: 30),
                            );
                            lastRecipe = 'Child-friendly app';
                            lastTime = r;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 8.0),
                        _RecipeTile(
                          icon: Icons.accessibility_new,
                          title: 'Accessibility-first form',
                          subtitle:
                              'Screen-reader and keyboard users. Use '
                              'inputOnly so the surface is fully navigable '
                              'with two TextFields.',
                          mode: TimePickerEntryMode.inputOnly,
                          tint: const Color(0xFF006064),
                          onLaunch: () async {
                            final r = await launchPicker(
                              ctx,
                              mode: TimePickerEntryMode.inputOnly,
                              initial:
                                  const TimeOfDay(hour: 14, minute: 0),
                            );
                            lastRecipe = 'Accessibility-first form';
                            lastTime = r;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            lastRecipe == null
                                ? 'Try a recipe to see the entry mode in action.'
                                : 'Recipe: $lastRecipe → '
                                    '${lastTime == null ? 'cancelled' : _format(lastTime!)}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              color: Color(0xFF006064),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 11: 24-HOUR vs 12-HOUR
              // ==============================================================
              _SectionCard(
                title: '11. 24-hour vs 12-hour',
                bg: const Color(0xFFEFEBE9),
                border: const Color(0xFFA1887F),
                accent: const Color(0xFF3E2723),
                child: StatefulBuilder(
                  builder: (ctx, setState) {
                    TimeOfDay? r12;
                    TimeOfDay? r24;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MediaQuery alwaysUse24HourFormat controls whether '
                          'the dialog shows AM/PM or a single 0–23 dial. '
                          'Wrap your launcher in MediaQuery to override.',
                          style: TextStyle(fontSize: 13.0, height: 1.4),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  final r = await launchPicker(
                                    ctx,
                                    mode: TimePickerEntryMode.dial,
                                  );
                                  r12 = r;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.schedule),
                                label: const Text('12-hour'),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  final r = await launchPicker(
                                    ctx,
                                    mode: TimePickerEntryMode.dial,
                                    use24Hour: true,
                                  );
                                  r24 = r;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.schedule),
                                label: const Text('24-hour'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD7CCC8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '12-hour: ${r12 == null ? '—' : _format(r12!)}\n'
                            '24-hour: ${r24 == null ? '—' : _format24(r24!)}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13.0,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ==============================================================
              // SECTION 12: DECISION GUIDE
              // ==============================================================
              _SectionCard(
                title: '12. Decision guide',
                bg: const Color(0xFFF3E5F5),
                border: const Color(0xFFCE93D8),
                accent: const Color(0xFF4A148C),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick reference for picking the right mode.',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    const SizedBox(height: 10.0),
                    _GuideRow(
                      audience: 'Casual touch users',
                      mode: 'dial',
                      reason:
                          'Fast tactile selection, optional keyboard switch.',
                    ),
                    _GuideRow(
                      audience: 'Power data-entry users',
                      mode: 'input',
                      reason:
                          'Keyboard-first, can switch back to dial if needed.',
                    ),
                    _GuideRow(
                      audience: 'Children / simplified UI',
                      mode: 'dialOnly',
                      reason: 'No keyboard, single interaction style.',
                    ),
                    _GuideRow(
                      audience: 'Accessibility-critical forms',
                      mode: 'inputOnly',
                      reason:
                          'Screen readers, hardware keyboards, predictable '
                          'TAB order.',
                    ),
                    _GuideRow(
                      audience: 'Mixed audience (default)',
                      mode: 'dial',
                      reason:
                          'Lets the user choose their preferred style via '
                          'the in-dialog toggle.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ==============================================================
              // FOOTER SUMMARY
              // ==============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'TimePickerEntryMode has four values; pair the choice '
                      'with your audience and the lock decision (switchable '
                      'vs locked). Combine with TimePickerThemeData for a '
                      'fully branded picker, MediaQuery for 24-hour, and '
                      'initialTime for sensible defaults. Always handle the '
                      'null-cancel return.',
                      style:
                          TextStyle(color: Color(0xFFE3F2FD), fontSize: 12.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'Deep Demo • TimePickerEntryMode • Material',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS
// =============================================================================

String _format(TimeOfDay t) {
  final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final m = t.minute.toString().padLeft(2, '0');
  final p = t.period == DayPeriod.am ? 'AM' : 'PM';
  return '$h:$m $p';
}

String _format24(TimeOfDay t) {
  final h = t.hour.toString().padLeft(2, '0');
  final m = t.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

String _modeDescription(TimePickerEntryMode m) {
  switch (m) {
    case TimePickerEntryMode.dial:
      return 'dial first, switch allowed';
    case TimePickerEntryMode.input:
      return 'keyboard first, switch allowed';
    case TimePickerEntryMode.dialOnly:
      return 'dial only, locked';
    case TimePickerEntryMode.inputOnly:
      return 'keyboard only, locked';
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.bg,
    required this.border,
    required this.accent,
    required this.child,
  });

  final String title;
  final Color bg;
  final Color border;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: border, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    );
  }
}

class _ChipTag extends StatelessWidget {
  const _ChipTag({
    required this.label,
    required this.bg,
    required this.fg,
  });

  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _LiveLauncherTile extends StatefulWidget {
  const _LiveLauncherTile({
    required this.mode,
    required this.onLaunch,
  });

  final TimePickerEntryMode mode;
  final Future<TimeOfDay?> Function() onLaunch;

  @override
  State<_LiveLauncherTile> createState() => _LiveLauncherTileState();
}

class _LiveLauncherTileState extends State<_LiveLauncherTile> {
  TimeOfDay? _picked;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Icon(_iconFor(widget.mode),
                color: const Color(0xFFFFFFFF)),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mode.name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                Text(
                  _picked == null
                      ? 'Not picked yet'
                      : 'Picked: ${_format(_picked!)}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    final r = await widget.onLaunch();
                    if (!mounted) return;
                    setState(() {
                      _picked = r ?? _picked;
                      _busy = false;
                    });
                  },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(TimePickerEntryMode m) {
    switch (m) {
      case TimePickerEntryMode.dial:
      case TimePickerEntryMode.dialOnly:
        return Icons.access_time;
      case TimePickerEntryMode.input:
      case TimePickerEntryMode.inputOnly:
        return Icons.keyboard;
    }
  }
}

class _ComparePane extends StatelessWidget {
  const _ComparePane({
    required this.label,
    required this.detail,
    required this.accent,
    required this.onPressed,
    required this.lastResult,
  });

  final String label;
  final String detail;
  final Color accent;
  final VoidCallback onPressed;
  final TimeOfDay? lastResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: accent,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            detail,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFF424242)),
          ),
          const SizedBox(height: 8.0),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(backgroundColor: accent),
            child: const Text('Try it'),
          ),
          const SizedBox(height: 6.0),
          Text(
            lastResult == null ? '—' : _format(lastResult!),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.mode,
    required this.tint,
    required this.onLaunch,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final TimePickerEntryMode mode;
  final Color tint;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tint.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFFFFFFFF)),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: tint,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: tint.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        mode.name,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: tint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF424242),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6.0),
                FilledButton.tonal(
                  onPressed: onLaunch,
                  child: const Text('Launch recipe'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideRow extends StatelessWidget {
  const _GuideRow({
    required this.audience,
    required this.mode,
    required this.reason,
  });

  final String audience;
  final String mode;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              audience,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                color: Color(0xFF4A148C),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF7B1FA2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              mode,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: Text(
              reason,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
