import 'dart:math' as math;

import 'package:flutter/material.dart';

class _PeriodScenario {
  const _PeriodScenario({
    required this.title,
    required this.description,
    required this.period,
    required this.hour,
    required this.minute,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final DayPeriod period;
  final int hour;
  final int minute;
  final Color color;
  final IconData icon;
}

class _PlannerBlock {
  const _PlannerBlock({
    required this.label,
    required this.start,
    required this.end,
    required this.color,
  });

  final String label;
  final TimeOfDay start;
  final TimeOfDay end;
  final Color color;
}

class _TraceRow {
  const _TraceRow({
    required this.title,
    required this.message,
    required this.color,
  });

  final String title;
  final String message;
  final Color color;
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();
  final List<String> console = <String>[];
  final List<_TraceRow> timeline = <_TraceRow>[];

  DayPeriod selectedPeriod = DayPeriod.am;
  int hourOfPeriod = 9;
  int minute = 30;
  int selectedScenario = 0;
  bool showBusinessHighlights = true;
  bool showSunPath = true;
  bool showShiftPlanner = true;
  bool autoSyncFromScenario = true;

  final List<_PeriodScenario> scenarios = <_PeriodScenario>[
    const _PeriodScenario(
      title: 'Midnight Kickoff',
      description:
          '12:00 AM should map to DayPeriod.am and represent the first minute of the day.',
      period: DayPeriod.am,
      hour: 12,
      minute: 0,
      color: Color(0xFF1565C0),
      icon: Icons.nights_stay,
    ),
    const _PeriodScenario(
      title: 'Early Morning Routine',
      description:
          '6:30 AM demonstrates pre-noon logic in schedules and notifications.',
      period: DayPeriod.am,
      hour: 6,
      minute: 30,
      color: Color(0xFF0277BD),
      icon: Icons.wb_sunny,
    ),
    const _PeriodScenario(
      title: 'Noon Boundary',
      description:
          '12:00 PM is the exact transition point from DayPeriod.am to DayPeriod.pm.',
      period: DayPeriod.pm,
      hour: 12,
      minute: 0,
      color: Color(0xFF2E7D32),
      icon: Icons.light_mode,
    ),
    const _PeriodScenario(
      title: 'Afternoon Planning',
      description:
          '2:45 PM is a common post-noon business slot and should always resolve as pm.',
      period: DayPeriod.pm,
      hour: 2,
      minute: 45,
      color: Color(0xFFEF6C00),
      icon: Icons.work,
    ),
    const _PeriodScenario(
      title: 'Late Evening Wrap-up',
      description:
          '9:15 PM confirms PM handling in reminder and scheduling UX.',
      period: DayPeriod.pm,
      hour: 9,
      minute: 15,
      color: Color(0xFF6A1B9A),
      icon: Icons.bedtime,
    ),
  ];

  void addConsole(String line) {
    final Duration elapsed = DateTime.now().difference(sessionStart);
    final String row =
        '[${elapsed.inSeconds.toString().padLeft(2, '0')}s] $line';
    console.insert(0, row);
    if (console.length > 28) {
      console.removeLast();
    }
  }

  String pad2(int value) {
    return value.toString().padLeft(2, '0');
  }

  int to24Hour(DayPeriod period, int hourInPeriod) {
    final int normalized = hourInPeriod == 12 ? 0 : hourInPeriod;
    if (period == DayPeriod.am) {
      return normalized;
    }
    return normalized + 12;
  }

  String format12Hour(DayPeriod period, int hourInPeriod, int minute) {
    return '${hourInPeriod.toString().padLeft(2, '0')}:${pad2(minute)} ${period.name.toUpperCase()}';
  }

  String describePeriod(DayPeriod period) {
    if (period == DayPeriod.am) {
      return 'Ante meridiem (00:00–11:59)';
    }
    return 'Post meridiem (12:00–23:59)';
  }

  List<_PlannerBlock> buildPlanner() {
    return <_PlannerBlock>[
      const _PlannerBlock(
        label: 'Focus Block',
        start: TimeOfDay(hour: 8, minute: 30),
        end: TimeOfDay(hour: 11, minute: 0),
        color: Color(0xFF1565C0),
      ),
      const _PlannerBlock(
        label: 'Lunch + Reset',
        start: TimeOfDay(hour: 12, minute: 0),
        end: TimeOfDay(hour: 13, minute: 0),
        color: Color(0xFF2E7D32),
      ),
      const _PlannerBlock(
        label: 'Meetings',
        start: TimeOfDay(hour: 14, minute: 0),
        end: TimeOfDay(hour: 17, minute: 30),
        color: Color(0xFFEF6C00),
      ),
      const _PlannerBlock(
        label: 'Evening Review',
        start: TimeOfDay(hour: 19, minute: 0),
        end: TimeOfDay(hour: 20, minute: 0),
        color: Color(0xFF6A1B9A),
      ),
    ];
  }

  Color colorForPeriod(DayPeriod period) {
    return period == DayPeriod.am
        ? const Color(0xFF0277BD)
        : const Color(0xFFEF6C00);
  }

  IconData iconForPeriod(DayPeriod period) {
    return period == DayPeriod.am ? Icons.wb_sunny : Icons.nightlight_round;
  }

  Widget sectionTitle({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget metricTile({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color.withValues(alpha: 0.88),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final int hour24 = to24Hour(selectedPeriod, hourOfPeriod);
      final TimeOfDay current = TimeOfDay(hour: hour24, minute: minute);
      final Color accent = colorForPeriod(selectedPeriod);
      final _PeriodScenario activeScenario = scenarios[selectedScenario];

      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF001B2E), Color(0xFF1D4E89)],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'DayPeriod Experience Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DayPeriod has two values (am, pm), but it powers a large amount of UX logic: '
                    'time pickers, reminders, scheduling boundaries, and readable 12-hour displays. '
                    'This deep demo shows those interactions visually through clocks, timelines, and planners.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar:
                            Icon(iconForPeriod(selectedPeriod), color: Colors.white),
                        label: Text(
                          'Active ${selectedPeriod.name.toUpperCase()}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.schedule, color: Colors.white),
                        label: Text(
                          format12Hour(selectedPeriod, hourOfPeriod, minute),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.timelapse, color: Colors.white),
                        label: Text(
                          '24h ${hour24.toString().padLeft(2, '0')}:${pad2(minute)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Period Control Desk',
              subtitle:
                  'Compose a TimeOfDay value and inspect how DayPeriod and hourOfPeriod behave.',
              icon: Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: <Widget>[
                      ChoiceChip(
                        selectedColor: const Color(0xFFB3E5FC),
                        selected: selectedPeriod == DayPeriod.am,
                        onSelected: (bool value) {
                          if (!value) {
                            return;
                          }
                          setState(() {
                            selectedPeriod = DayPeriod.am;
                          });
                          addConsole('Period switched to AM.');
                        },
                        label: const Text('AM (before noon)'),
                      ),
                      ChoiceChip(
                        selectedColor: const Color(0xFFFFE0B2),
                        selected: selectedPeriod == DayPeriod.pm,
                        onSelected: (bool value) {
                          if (!value) {
                            return;
                          }
                          setState(() {
                            selectedPeriod = DayPeriod.pm;
                          });
                          addConsole('Period switched to PM.');
                        },
                        label: const Text('PM (after noon)'),
                      ),
                      FilterChip(
                        label: const Text('Business highlights'),
                        selected: showBusinessHighlights,
                        onSelected: (bool value) {
                          setState(() {
                            showBusinessHighlights = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Sun path overlay'),
                        selected: showSunPath,
                        onSelected: (bool value) {
                          setState(() {
                            showSunPath = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Shift planner'),
                        selected: showShiftPlanner,
                        onSelected: (bool value) {
                          setState(() {
                            showShiftPlanner = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hour In Period (${selectedPeriod.name.toUpperCase()})',
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Slider(
                    value: hourOfPeriod.toDouble(),
                    min: 1,
                    max: 12,
                    divisions: 11,
                    label: hourOfPeriod.toString(),
                    onChanged: (double value) {
                      setState(() {
                        hourOfPeriod = value.round();
                      });
                    },
                  ),
                  Text(
                    'Minute',
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Slider(
                    value: minute.toDouble(),
                    min: 0,
                    max: 59,
                    divisions: 59,
                    label: minute.toString(),
                    onChanged: (double value) {
                      setState(() {
                        minute = value.round();
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          final String message =
                              'Composed ${format12Hour(selectedPeriod, hourOfPeriod, minute)} '
                              '=> ${hour24.toString().padLeft(2, '0')}:${pad2(minute)}';
                          setState(() {
                            timeline.insert(
                              0,
                              _TraceRow(
                                title: 'Manual composition',
                                message: message,
                                color: accent,
                              ),
                            );
                            if (timeline.length > 24) {
                              timeline.removeLast();
                            }
                          });
                          addConsole(message);
                        },
                        icon: const Icon(Icons.add_task),
                        label: const Text('Record Current Time'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            hourOfPeriod = 12;
                            minute = 0;
                            selectedPeriod = DayPeriod.am;
                          });
                          addConsole('Reset to 12:00 AM baseline.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset To Midnight'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            timeline.clear();
                          });
                          addConsole('Timeline cleared.');
                        },
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('Clear Timeline'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Derived Values Inspector',
              subtitle:
                  'Directly inspect values exposed through TimeOfDay and DayPeriod APIs.',
              icon: Icons.analytics,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'DayPeriod',
                    value: selectedPeriod.name,
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'TimeOfDay.hour',
                    value: current.hour.toString(),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'TimeOfDay.hourOfPeriod',
                    value: current.hourOfPeriod.toString(),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'Formatted 12h',
                    value: format12Hour(selectedPeriod, hourOfPeriod, minute),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'Formatted 24h',
                    value: '${hour24.toString().padLeft(2, '0')}:${pad2(minute)}',
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'Period Meaning',
                    value: describePeriod(selectedPeriod),
                    color: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Dual Clock View',
              subtitle:
                  'Visual AM/PM comparison with active time highlight and optional sun path.',
              icon: Icons.watch_later,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: SizedBox(
                height: 330,
                child: CustomPaint(
                  painter: _DualClockPainter(
                    period: selectedPeriod,
                    hourInPeriod: hourOfPeriod,
                    minute: minute,
                    showSunPath: showSunPath,
                    accent: accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Daylight Timeline',
              subtitle:
                  'How DayPeriod separates the day into morning and afternoon/evening segments.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: CustomPaint(
                painter: _DayPeriodBandPainter(
                  current24Hour: hour24,
                  currentMinute: minute,
                  period: selectedPeriod,
                  highlightBusiness: showBusinessHighlights,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Gallery',
              subtitle:
                  'Curated period boundary scenarios to test AM/PM logic in your app flows.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarios.asMap().entries.map((MapEntry<int, _PeriodScenario> entry) {
                final _PeriodScenario item = entry.value;
                final bool selected = selectedScenario == entry.key;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: selected
                        ? item.color.withValues(alpha: 0.14)
                        : item.color.withValues(alpha: 0.07),
                    border: Border.all(
                      color: selected
                          ? item.color.withValues(alpha: 0.50)
                          : item.color.withValues(alpha: 0.24),
                      width: selected ? 1.4 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.color.withValues(alpha: 0.24),
                        ),
                        child: Icon(item.icon, color: item.color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: TextStyle(
                                color: item.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              format12Hour(item.period, item.hour, item.minute),
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            selectedScenario = entry.key;
                            if (autoSyncFromScenario) {
                              selectedPeriod = item.period;
                              hourOfPeriod = item.hour;
                              minute = item.minute;
                            }
                          });
                          addConsole('Loaded scenario ${item.title}.');
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Load'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: autoSyncFromScenario,
                  onChanged: (bool? value) {
                    setState(() {
                      autoSyncFromScenario = value ?? true;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Auto-sync controls when loading scenarios',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            sectionTitle(
              title: 'Shift Planner View',
              subtitle:
                  'See how AM/PM determines planning labels in real productivity schedules.',
              icon: Icons.calendar_month,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: showShiftPlanner
                    ? Colors.white
                    : Colors.blueGrey.shade50,
              ),
              child: showShiftPlanner
                  ? Column(
                      children: buildPlanner().map((_PlannerBlock block) {
                        final DayPeriod startPeriod = block.start.period;
                        final DayPeriod endPeriod = block.end.period;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: block.color.withValues(alpha: 0.08),
                            border: Border.all(
                              color: block.color.withValues(alpha: 0.28),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: block.color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      block.label,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: block.color,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${block.start.hourOfPeriod == 0 ? 12 : block.start.hourOfPeriod}:${pad2(block.start.minute)} ${startPeriod.name.toUpperCase()} '
                                      '-> '
                                      '${block.end.hourOfPeriod == 0 ? 12 : block.end.hourOfPeriod}:${pad2(block.end.minute)} ${endPeriod.name.toUpperCase()}',
                                      style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: startPeriod == endPeriod
                                      ? block.color.withValues(alpha: 0.20)
                                      : Colors.red.withValues(alpha: 0.18),
                                ),
                                child: Text(
                                  startPeriod == endPeriod
                                      ? startPeriod.name.toUpperCase()
                                      : 'AM->PM',
                                  style: TextStyle(
                                    color: startPeriod == endPeriod
                                        ? block.color
                                        : Colors.red.shade700,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'Shift planner hidden. Enable it from controls to inspect AM/PM schedule slices.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline Replay',
              subtitle:
                  'Recorded examples of period conversions and scenario applications.',
              icon: Icons.history,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Timeline is empty. Record current time to track period transformations.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _TraceRow> entry) {
                        final _TraceRow row = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: row.color.withValues(alpha: 0.08),
                            border: Border.all(
                              color: row.color.withValues(alpha: 0.30),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '#${entry.key + 1}',
                                style: TextStyle(
                                  color: row.color,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      row.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      row.message,
                                      style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'DayPeriod Usage Guide',
              subtitle:
                  'When and why to use DayPeriod in practical Flutter app logic.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: const Column(
                children: <Widget>[
                  _GuideRow(
                    title: 'Time picker output',
                    detail:
                        'Use TimeOfDay.period to determine if selected input belongs to am or pm and format labels accordingly.',
                  ),
                  _GuideRow(
                    title: '12h to 24h conversion',
                    detail:
                        'Combine DayPeriod with hourOfPeriod to compute canonical 24-hour values for storage and APIs.',
                  ),
                  _GuideRow(
                    title: 'Boundary rules',
                    detail:
                        'Remember 12:00 AM maps to hour 00 while 12:00 PM maps to hour 12; this is where most bugs happen.',
                  ),
                  _GuideRow(
                    title: 'Schedule grouping',
                    detail:
                        'Group calendar sections by DayPeriod (Morning/Afternoon) for readable agenda and reminder lists.',
                  ),
                  _GuideRow(
                    title: 'Accessibility copy',
                    detail:
                        'Expose explicit AM/PM phrasing in semantics labels so screen readers announce time contexts clearly.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Reference Conversion Snippet',
              subtitle:
                  'A minimal helper pattern often used in apps that persist TimeOfDay values.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B132B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'int to24(DayPeriod period, int hourOfPeriod) {\\n'
                '  final int normalized = hourOfPeriod == 12 ? 0 : hourOfPeriod;\\n'
                '  return period == DayPeriod.am ? normalized : normalized + 12;\\n'
                '}\\n\\n'
                'TimeOfDay parsed = TimeOfDay(hour: to24(period, hour12), minute: minute);\\n'
                'final DayPeriod p = parsed.period;\\n'
                'final int h = parsed.hourOfPeriod == 0 ? 12 : parsed.hourOfPeriod;',
                style: const TextStyle(
                  color: Color(0xFFD5E7FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.38,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle:
                  'Interaction history for reproducible AM/PM conversion debugging.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            Container(
              height: 190,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
              ),
              child: console.isEmpty
                  ? const Center(
                      child: Text(
                        'No diagnostic rows yet. Change controls or load scenarios.',
                        style: TextStyle(
                          color: Color(0xFFB7C9EC),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: console.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            console[index],
                            style: const TextStyle(
                              color: Color(0xFFC8D9FF),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFE8F5E9), Color(0xFFE3F2FD)],
                ),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Text(
                'Summary: This deep demo turns DayPeriod from a two-value enum into a practical scheduling lab. '
                'You can visualize AM/PM differences, test boundary cases like midnight/noon, convert between 12h and 24h, '
                'and inspect how period-driven logic influences planners, labels, and user-facing time flows.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (autoSyncFromScenario)
              FilledButton.icon(
                onPressed: () {
                  final _PeriodScenario sc = activeScenario;
                  setState(() {
                    selectedPeriod = sc.period;
                    hourOfPeriod = sc.hour;
                    minute = sc.minute;
                    timeline.insert(
                      0,
                      _TraceRow(
                        title: 'Scenario sync',
                        message:
                            '${sc.title} -> ${format12Hour(sc.period, sc.hour, sc.minute)}',
                        color: sc.color,
                      ),
                    );
                    if (timeline.length > 24) {
                      timeline.removeLast();
                    }
                  });
                  addConsole('Applied active scenario ${sc.title} to controls.');
                },
                icon: const Icon(Icons.sync),
                label: const Text('Apply Active Scenario To Controls'),
              ),
          ],
        ),
      );
    },
  );
}

class _GuideRow extends StatelessWidget {
  const _GuideRow({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey.shade50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DualClockPainter extends CustomPainter {
  _DualClockPainter({
    required this.period,
    required this.hourInPeriod,
    required this.minute,
    required this.showSunPath,
    required this.accent,
  });

  final DayPeriod period;
  final int hourInPeriod;
  final int minute;
  final bool showSunPath;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFE9F2FF)],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final Offset leftCenter = Offset(size.width * 0.28, size.height * 0.52);
    final Offset rightCenter = Offset(size.width * 0.72, size.height * 0.52);
    final double radius = math.min(size.width, size.height) * 0.26;

    void drawClockFace(Offset center, DayPeriod p) {
      final bool active = p == period;
      final Color tone = p == DayPeriod.am
          ? const Color(0xFF0277BD)
          : const Color(0xFFEF6C00);
      final Paint face = Paint()
        ..color = tone.withValues(alpha: active ? 0.16 : 0.08);
      canvas.drawCircle(center, radius, face);
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = active ? 2.4 : 1.4
          ..color = tone.withValues(alpha: active ? 0.75 : 0.32),
      );

      for (int i = 0; i < 12; i++) {
        final double angle = (math.pi * 2 / 12) * i - math.pi / 2;
        final Offset outer = center + Offset(math.cos(angle), math.sin(angle)) * radius;
        final Offset inner =
            center + Offset(math.cos(angle), math.sin(angle)) * (radius - (i % 3 == 0 ? 12 : 8));
        canvas.drawLine(
          inner,
          outer,
          Paint()
            ..strokeWidth = i % 3 == 0 ? 2 : 1
            ..color = Colors.blueGrey.withValues(alpha: 0.55),
        );
      }

      final TextPainter label = TextPainter(
        text: TextSpan(
          text: p == DayPeriod.am ? 'AM' : 'PM',
          style: TextStyle(
            color: tone,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, Offset(center.dx - label.width / 2, center.dy + radius + 8));

      if (active) {
        canvas.drawCircle(
          center,
          radius + 8,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = accent.withValues(alpha: 0.48),
        );
      }
    }

    drawClockFace(leftCenter, DayPeriod.am);
    drawClockFace(rightCenter, DayPeriod.pm);

    final Offset activeCenter = period == DayPeriod.am ? leftCenter : rightCenter;
    final double minuteAngle = (math.pi * 2) * (minute / 60) - math.pi / 2;
    final double hourProgress = (hourInPeriod % 12) + minute / 60;
    final double hourAngle = (math.pi * 2) * (hourProgress / 12) - math.pi / 2;

    final Paint hourPaint = Paint()
      ..color = accent
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final Paint minutePaint = Paint()
      ..color = const Color(0xFF263238)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      activeCenter,
      activeCenter + Offset(math.cos(hourAngle), math.sin(hourAngle)) * (radius * 0.5),
      hourPaint,
    );
    canvas.drawLine(
      activeCenter,
      activeCenter + Offset(math.cos(minuteAngle), math.sin(minuteAngle)) * (radius * 0.74),
      minutePaint,
    );
    canvas.drawCircle(activeCenter, 5, Paint()..color = accent);

    if (showSunPath) {
      final Rect pathRect = Rect.fromLTWH(size.width * 0.1, size.height * 0.08, size.width * 0.8, 54);
      canvas.drawArc(
        pathRect,
        math.pi,
        math.pi,
        false,
        Paint()
          ..color = const Color(0xFF90CAF9)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
      final double t = period == DayPeriod.am
          ? (hourInPeriod + minute / 60) / 12
          : 1 - ((hourInPeriod + minute / 60) / 12);
      final double x = pathRect.left + pathRect.width * t;
      final double y = pathRect.center.dy - math.sin(math.pi * t) * (pathRect.height / 2);
      canvas.drawCircle(Offset(x, y), 7, Paint()..color = const Color(0xFFFFC107));
    }

    final TextPainter title = TextPainter(
      text: TextSpan(
        text: 'Active: ${period.name.toUpperCase()} ${hourInPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    title.paint(canvas, const Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _DualClockPainter oldDelegate) {
    return oldDelegate.period != period ||
        oldDelegate.hourInPeriod != hourInPeriod ||
        oldDelegate.minute != minute ||
        oldDelegate.showSunPath != showSunPath ||
        oldDelegate.accent != accent;
  }
}

class _DayPeriodBandPainter extends CustomPainter {
  _DayPeriodBandPainter({
    required this.current24Hour,
    required this.currentMinute,
    required this.period,
    required this.highlightBusiness,
  });

  final int current24Hour;
  final int currentMinute;
  final DayPeriod period;
  final bool highlightBusiness;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect band = Rect.fromLTWH(12, 44, size.width - 24, 48);
    final RRect rr = RRect.fromRectAndRadius(band, const Radius.circular(999));
    canvas.drawRRect(
      rr,
      Paint()
        ..shader = const LinearGradient(
          colors: <Color>[Color(0xFFB3E5FC), Color(0xFFFFE0B2)],
        ).createShader(band),
    );

    final double noonX = band.left + band.width * 0.5;
    canvas.drawLine(
      Offset(noonX, band.top - 10),
      Offset(noonX, band.bottom + 10),
      Paint()
        ..strokeWidth = 2
        ..color = const Color(0xFF455A64),
    );

    final TextPainter am = TextPainter(
      text: const TextSpan(
        text: 'AM',
        style: TextStyle(
          color: Color(0xFF01579B),
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    am.paint(canvas, Offset(band.left + 8, band.top - 26));

    final TextPainter pm = TextPainter(
      text: const TextSpan(
        text: 'PM',
        style: TextStyle(
          color: Color(0xFFE65100),
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    pm.paint(canvas, Offset(band.right - pm.width - 8, band.top - 26));

    if (highlightBusiness) {
      final Rect morning = Rect.fromLTWH(
        band.left + band.width * (8 / 24),
        band.top + 6,
        band.width * (3 / 24),
        band.height - 12,
      );
      final Rect afternoon = Rect.fromLTWH(
        band.left + band.width * (13 / 24),
        band.top + 6,
        band.width * (4 / 24),
        band.height - 12,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(morning, const Radius.circular(999)),
        Paint()..color = const Color(0x550156A5),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(afternoon, const Radius.circular(999)),
        Paint()..color = const Color(0x55EF6C00),
      );
    }

    final double now = current24Hour + currentMinute / 60;
    final double x = band.left + band.width * (now / 24);
    final Color indicator =
        period == DayPeriod.am ? const Color(0xFF0277BD) : const Color(0xFFEF6C00);
    canvas.drawCircle(Offset(x, band.center.dy), 11, Paint()..color = indicator);
    canvas.drawCircle(
      Offset(x, band.center.dy),
      15,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = indicator.withValues(alpha: 0.5),
    );

    for (int hour = 0; hour <= 24; hour += 3) {
      final double tickX = band.left + band.width * (hour / 24);
      canvas.drawLine(
        Offset(tickX, band.bottom + 4),
        Offset(tickX, band.bottom + 10),
        Paint()..color = const Color(0xFF607D8B),
      );
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: hour.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Color(0xFF455A64),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      t.paint(canvas, Offset(tickX - t.width / 2, band.bottom + 12));
    }
  }

  @override
  bool shouldRepaint(covariant _DayPeriodBandPainter oldDelegate) {
    return oldDelegate.current24Hour != current24Hour ||
        oldDelegate.currentMinute != currentMinute ||
        oldDelegate.period != period ||
        oldDelegate.highlightBusiness != highlightBusiness;
  }
}
