import 'dart:math' as math;

import 'package:flutter/material.dart';

class _HourScenario {
  const _HourScenario({
    required this.title,
    required this.description,
    required this.hour,
    required this.minute,
    required this.timeOfDayFormat,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final int hour;
  final int minute;
  final TimeOfDayFormat timeOfDayFormat;
  final Color color;
  final IconData icon;
}

class _TraceItem {
  const _TraceItem({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _ScheduleSlice {
  const _ScheduleSlice({
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

dynamic build(BuildContext context) {
  final DateTime start = DateTime.now();
  final List<String> console = <String>[];
  final List<_TraceItem> traces = <_TraceItem>[];

  int hour24 = 14;
  int minute = 5;
  bool highlightPadding = true;
  bool highlight12hWrap = true;
  bool showSchedule = true;
  bool autoSyncScenario = true;

  int selectedScenario = 0;
  TimeOfDayFormat selectedTimeFormat = TimeOfDayFormat.H_colon_mm;

  final List<_HourScenario> scenarios = <_HourScenario>[
    const _HourScenario(
      title: 'Morning Briefing',
      description:
          '8:05 should display clear differences between HH (08) and H (8).',
      hour: 8,
      minute: 5,
      timeOfDayFormat: TimeOfDayFormat.HH_colon_mm,
      color: Color(0xFF1565C0),
      icon: Icons.wb_sunny,
    ),
    const _HourScenario(
      title: 'Noon Boundary',
      description:
          '12:00 demonstrates h format without zero and 24h noon behavior.',
      hour: 12,
      minute: 0,
      timeOfDayFormat: TimeOfDayFormat.h_colon_mm_space_a,
      color: Color(0xFF2E7D32),
      icon: Icons.light_mode,
    ),
    const _HourScenario(
      title: 'Afternoon Sync',
      description:
          '14:45 exposes the 24h versus 12h conversion details for PM values.',
      hour: 14,
      minute: 45,
      timeOfDayFormat: TimeOfDayFormat.H_colon_mm,
      color: Color(0xFFEF6C00),
      icon: Icons.event,
    ),
    const _HourScenario(
      title: 'Late Night Ops',
      description:
          '23:15 highlights wrapping in h format where 11 PM is expected.',
      hour: 23,
      minute: 15,
      timeOfDayFormat: TimeOfDayFormat.h_colon_mm_space_a,
      color: Color(0xFF6A1B9A),
      icon: Icons.nights_stay,
    ),
    const _HourScenario(
      title: 'Midnight Reset',
      description:
          '00:30 is critical for padding and AM conversion correctness.',
      hour: 0,
      minute: 30,
      timeOfDayFormat: TimeOfDayFormat.HH_colon_mm,
      color: Color(0xFF006064),
      icon: Icons.bedtime,
    ),
  ];

  String twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  void addConsole(String message) {
    final Duration elapsed = DateTime.now().difference(start);
    final String row =
        '[${elapsed.inSeconds.toString().padLeft(2, '0')}s] $message';
    console.insert(0, row);
    if (console.length > 30) {
      console.removeLast();
    }
  }

  int hourOfPeriod(int h24) {
    final int value = h24 % 12;
    return value == 0 ? 12 : value;
  }

  DayPeriod periodOf24(int h24) {
    return h24 < 12 ? DayPeriod.am : DayPeriod.pm;
  }

  // D4RT-LIMITATION: enum exhaustiveness - interpreter cannot match bridged enum values exhaustively
  String formatByHourFormat(HourFormat format, int h24, int minute) {
    switch (format) {
      case HourFormat.HH:
        return '${twoDigits(h24)}:${twoDigits(minute)}';
      case HourFormat.H:
        return '$h24:${twoDigits(minute)}';
      case HourFormat.h:
        final int hp = hourOfPeriod(h24);
        final String meridiem = periodOf24(h24) == DayPeriod.am ? 'AM' : 'PM';
        return '$hp:${twoDigits(minute)} $meridiem';
      default:
        return '${twoDigits(h24)}:${twoDigits(minute)}';
    }
  }

  // D4RT-LIMITATION: enum exhaustiveness
  String describeHourFormat(HourFormat format) {
    switch (format) {
      case HourFormat.HH:
        return 'Zero-padded 24-hour, ideal for aligned tables and digital clocks.';
      case HourFormat.H:
        return 'Non-padded 24-hour, compact display for technical dashboards.';
      case HourFormat.h:
        return '12-hour format with AM/PM context for conversational user interfaces.';
      default:
        return 'Unknown hour format: ${format.name}';
    }
  }

  List<_ScheduleSlice> schedule() {
    return <_ScheduleSlice>[
      const _ScheduleSlice(
        label: 'Daily Standup',
        start: TimeOfDay(hour: 9, minute: 0),
        end: TimeOfDay(hour: 9, minute: 30),
        color: Color(0xFF1565C0),
      ),
      const _ScheduleSlice(
        label: 'Deep Work Session',
        start: TimeOfDay(hour: 10, minute: 0),
        end: TimeOfDay(hour: 12, minute: 30),
        color: Color(0xFF2E7D32),
      ),
      const _ScheduleSlice(
        label: 'Client Sync',
        start: TimeOfDay(hour: 14, minute: 0),
        end: TimeOfDay(hour: 15, minute: 0),
        color: Color(0xFFEF6C00),
      ),
      const _ScheduleSlice(
        label: 'Release Window',
        start: TimeOfDay(hour: 20, minute: 30),
        end: TimeOfDay(hour: 22, minute: 0),
        color: Color(0xFF6A1B9A),
      ),
    ];
  }

  // D4RT-LIMITATION: enum exhaustiveness
  Color colorForFormat(HourFormat format) {
    switch (format) {
      case HourFormat.HH:
        return const Color(0xFF1565C0);
      case HourFormat.H:
        return const Color(0xFF2E7D32);
      case HourFormat.h:
        return const Color(0xFFEF6C00);
      default:
        return Colors.grey;
    }
  }

  Widget sectionTitle({required String title, required String subtitle, required IconData icon}) {
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
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Text(subtitle,
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget metricTile(String label, String value, Color color) {
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
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final DayPeriod period = periodOf24(hour24);
      final HourFormat inferred = hourFormat(of: selectedTimeFormat);
      final Color accent = colorForFormat(inferred);
      final String hh = formatByHourFormat(HourFormat.HH, hour24, minute);
      final String h = formatByHourFormat(HourFormat.H, hour24, minute);
      final String h12 = formatByHourFormat(HourFormat.h, hour24, minute);

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
                    'HourFormat Observatory',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'HourFormat controls how hour digits are rendered (HH, H, h). '
                    'This deep demo visualizes conversion behavior, locale-style mappings via TimeOfDayFormat, '
                    'and practical schedule rendering differences in real UI containers.',
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
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        avatar: const Icon(Icons.schedule, color: Colors.white),
                        label: Text('Raw ${twoDigits(hour24)}:${twoDigits(minute)}', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        avatar: const Icon(Icons.translate, color: Colors.white),
                        label: Text('Inferred ${inferred.name}', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        avatar: const Icon(Icons.wb_twilight, color: Colors.white),
                        label: Text(period.name.toUpperCase(), style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Format Control Desk',
              subtitle: 'Manipulate hour/minute and TimeOfDayFormat to inspect HourFormat behavior.',
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
                  SizedBox(
                    width: 320,
                    child: DropdownButtonFormField<TimeOfDayFormat>(
                      initialValue: selectedTimeFormat,
                      decoration: const InputDecoration(
                        labelText: 'TimeOfDayFormat',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: TimeOfDayFormat.values.map((TimeOfDayFormat value) {
                        return DropdownMenuItem<TimeOfDayFormat>(
                          value: value,
                          child: Text('${value.name} -> ${hourFormat(of: value).name}'),
                        );
                      }).toList(),
                      onChanged: (TimeOfDayFormat? value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedTimeFormat = value;
                        });
                        addConsole('Selected TimeOfDayFormat ${value.name}.');
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Hour (24h)', style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w700)),
                  Slider(
                    value: hour24.toDouble(),
                    min: 0,
                    max: 23,
                    divisions: 23,
                    label: hour24.toString(),
                    onChanged: (double value) {
                      setState(() {
                        hour24 = value.round();
                      });
                    },
                  ),
                  Text('Minute', style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w700)),
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
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilterChip(
                        label: const Text('Highlight padding'),
                        selected: highlightPadding,
                        onSelected: (bool v) => setState(() => highlightPadding = v),
                      ),
                      FilterChip(
                        label: const Text('Highlight 12h wrap'),
                        selected: highlight12hWrap,
                        onSelected: (bool v) => setState(() => highlight12hWrap = v),
                      ),
                      FilterChip(
                        label: const Text('Show schedule lane'),
                        selected: showSchedule,
                        onSelected: (bool v) => setState(() => showSchedule = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          final String detail = 'Raw ${twoDigits(hour24)}:${twoDigits(minute)} -> HH $hh | H $h | h $h12';
                          setState(() {
                            traces.insert(
                              0,
                              _TraceItem(
                                title: 'Conversion snapshot',
                                detail: detail,
                                color: accent,
                              ),
                            );
                            if (traces.length > 30) {
                              traces.removeLast();
                            }
                          });
                          addConsole(detail);
                        },
                        icon: const Icon(Icons.add_task),
                        label: const Text('Record Conversion'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            traces.clear();
                          });
                          addConsole('Conversion timeline cleared.');
                        },
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('Clear Timeline'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            hour24 = 0;
                            minute = 0;
                            selectedTimeFormat = TimeOfDayFormat.HH_colon_mm;
                          });
                          addConsole('Reset to 00:00 with HH_colon_mm.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset To Midnight'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Direct Comparison Board',
              subtitle: 'See all three HourFormat outputs side-by-side for the same time.',
              icon: Icons.view_week,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 230,
                  child: metricTile('HourFormat.HH', hh, colorForFormat(HourFormat.HH)),
                ),
                SizedBox(
                  width: 230,
                  child: metricTile('HourFormat.H', h, colorForFormat(HourFormat.H)),
                ),
                SizedBox(
                  width: 230,
                  child: metricTile('HourFormat.h', h12, colorForFormat(HourFormat.h)),
                ),
                SizedBox(
                  width: 230,
                  child: metricTile('hourOfPeriod', hourOfPeriod(hour24).toString(), accent),
                ),
                SizedBox(
                  width: 230,
                  child: metricTile('period', period.name.toUpperCase(), accent),
                ),
                SizedBox(
                  width: 230,
                  child: metricTile('inferred via hourFormat()', inferred.name, accent),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Dial And Digit Visualizer',
              subtitle: 'Visual explanation of padded/non-padded/12h rendering behavior.',
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
                height: 360,
                child: CustomPaint(
                  painter: _HourFormatPainter(
                    hour24: hour24,
                    minute: minute,
                    inferred: inferred,
                    highlightPadding: highlightPadding,
                    highlight12hWrap: highlight12hWrap,
                    accent: accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Gallery',
              subtitle: 'Preset situations demonstrating practical formatting outcomes.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarios.asMap().entries.map((MapEntry<int, _HourScenario> entry) {
                final _HourScenario item = entry.value;
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
                              '${twoDigits(item.hour)}:${twoDigits(item.minute)} • ${item.timeOfDayFormat.name} -> ${hourFormat(of: item.timeOfDayFormat).name}',
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            selectedScenario = entry.key;
                            if (autoSyncScenario) {
                              hour24 = item.hour;
                              minute = item.minute;
                              selectedTimeFormat = item.timeOfDayFormat;
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
                  value: autoSyncScenario,
                  onChanged: (bool? value) {
                    setState(() {
                      autoSyncScenario = value ?? true;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Auto-sync controls when scenario is loaded',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            sectionTitle(
              title: 'TimeOfDayFormat Mapping Grid',
              subtitle: 'Complete mapping from TimeOfDayFormat values to inferred HourFormat.',
              icon: Icons.grid_view,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: TimeOfDayFormat.values.map((TimeOfDayFormat fmt) {
                  final HourFormat mapped = hourFormat(of: fmt);
                  final Color color = colorForFormat(mapped);
                  return Container(
                    width: 280,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color.withValues(alpha: 0.08),
                      border: Border.all(color: color.withValues(alpha: 0.30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fmt.name,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'hourFormat(of: ...) -> ${mapped.name}',
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          describeHourFormat(mapped),
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            height: 1.25,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
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
              title: 'Schedule Lane Comparison',
              subtitle: 'Render daily blocks with different hour formats to compare readability.',
              icon: Icons.calendar_month,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: showSchedule ? Colors.white : Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showSchedule
                  ? Column(
                      children: schedule().map((_ScheduleSlice item) {
                        final String hhRange =
                            '${formatByHourFormat(HourFormat.HH, item.start.hour, item.start.minute)} - ${formatByHourFormat(HourFormat.HH, item.end.hour, item.end.minute)}';
                        final String hRange =
                            '${formatByHourFormat(HourFormat.H, item.start.hour, item.start.minute)} - ${formatByHourFormat(HourFormat.H, item.end.hour, item.end.minute)}';
                        final String h12Range =
                            '${formatByHourFormat(HourFormat.h, item.start.hour, item.start.minute)} - ${formatByHourFormat(HourFormat.h, item.end.hour, item.end.minute)}';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: item.color.withValues(alpha: 0.08),
                            border: Border.all(color: item.color.withValues(alpha: 0.30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.label,
                                style: TextStyle(
                                  color: item.color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('HH: $hhRange', style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text('H:  $hRange', style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text('h:  $h12Range', style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Schedule lane disabled. Toggle it from controls to compare formatting styles.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Conversion Timeline',
              subtitle: 'Recorded snapshots for hour-format transitions while testing.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: traces.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Timeline is empty. Record conversion snapshots to build a trace.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: traces.asMap().entries.map((MapEntry<int, _TraceItem> entry) {
                        final _TraceItem row = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: row.color.withValues(alpha: 0.08),
                            border: Border.all(color: row.color.withValues(alpha: 0.30)),
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
                                    Text(row.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 3),
                                    Text(
                                      row.detail,
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
              title: 'HourFormat Guide',
              subtitle: 'When to use HH, H, or h in production UIs.',
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
                    title: 'HourFormat.HH',
                    detail: 'Use when alignment matters (dashboards, tables, logs) and every hour should have two digits.',
                  ),
                  _GuideRow(
                    title: 'HourFormat.H',
                    detail: 'Use for compact 24-hour displays where leading zero is visually unnecessary.',
                  ),
                  _GuideRow(
                    title: 'HourFormat.h',
                    detail: 'Use for user-facing conversational time with AM/PM context in regions preferring 12-hour clocks.',
                  ),
                  _GuideRow(
                    title: 'hourFormat(of: TimeOfDayFormat)',
                    detail: 'Map locale/style-specific TimeOfDayFormat values to core hour rendering behavior.',
                  ),
                  _GuideRow(
                    title: 'Boundary cases',
                    detail: 'Test 00:xx and 12:xx carefully because these values often reveal wrapping and period bugs.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Reference Snippet',
              subtitle: 'Typical helper pattern for rendering multiple hour styles from one source time.',
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
                'String formatHour(HourFormat hf, TimeOfDay t) {\\n'
                '  switch (hf) {\\n'
                '    case HourFormat.HH: return "${twoDigits(hour24)}:${twoDigits(minute)}";\\n'
                '    case HourFormat.H: return "$hour24:${twoDigits(minute)}";\\n'
                '    case HourFormat.h: return "${hourOfPeriod(hour24)}:${twoDigits(minute)} ${period.name.toUpperCase()}";\\n'
                '  }\\n'
                '}\\n\\n'
                'final HourFormat inferred = hourFormat(of: selectedTimeOfDayFormat);',
                style: const TextStyle(
                  color: Color(0xFFD5E7FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.36,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle: 'Interaction log for reproducible format conversion sessions.',
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
                        'No diagnostics yet. Adjust controls or load scenarios.',
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
                'Summary: This deep demo makes HourFormat behavior tangible through synchronized visuals, '
                'locale-style mappings, schedule rendering, and conversion traces. '
                'It demonstrates exactly how HH, H, and h differ, where padding matters, and how to apply hourFormat(of: ...) '
                'when adapting time UIs to formatting styles.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
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

class _HourFormatPainter extends CustomPainter {
  _HourFormatPainter({
    required this.hour24,
    required this.minute,
    required this.inferred,
    required this.highlightPadding,
    required this.highlight12hWrap,
    required this.accent,
  });

  final int hour24;
  final int minute;
  final HourFormat inferred;
  final bool highlightPadding;
  final bool highlight12hWrap;
  final Color accent;

  String twoDigits(int value) => value.toString().padLeft(2, '0');

  int hourOfPeriod(int value) {
    final int mod = value % 12;
    return mod == 0 ? 12 : mod;
  }

  DayPeriod periodOf24(int h) {
    return h < 12 ? DayPeriod.am : DayPeriod.pm;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFEAF2FD)],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final Offset dialCenter = Offset(size.width * 0.26, size.height * 0.52);
    final double radius = math.min(size.width, size.height) * 0.26;
    canvas.drawCircle(
      dialCenter,
      radius,
      Paint()..color = accent.withValues(alpha: 0.14),
    );
    canvas.drawCircle(
      dialCenter,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = accent.withValues(alpha: 0.60),
    );

    for (int i = 0; i < 12; i++) {
      final double angle = (math.pi * 2 / 12) * i - math.pi / 2;
      final Offset outer = dialCenter + Offset(math.cos(angle), math.sin(angle)) * radius;
      final Offset inner =
          dialCenter + Offset(math.cos(angle), math.sin(angle)) * (radius - (i % 3 == 0 ? 12 : 8));
      canvas.drawLine(
        inner,
        outer,
        Paint()
          ..strokeWidth = i % 3 == 0 ? 2 : 1
          ..color = Colors.blueGrey.withValues(alpha: 0.55),
      );
    }

    final double minuteAngle = (math.pi * 2) * (minute / 60) - math.pi / 2;
    final double hourAngle = (math.pi * 2) * (((hour24 % 12) + minute / 60) / 12) - math.pi / 2;

    canvas.drawLine(
      dialCenter,
      dialCenter + Offset(math.cos(hourAngle), math.sin(hourAngle)) * (radius * 0.52),
      Paint()
        ..color = accent
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      dialCenter,
      dialCenter + Offset(math.cos(minuteAngle), math.sin(minuteAngle)) * (radius * 0.74),
      Paint()
        ..color = const Color(0xFF263238)
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(dialCenter, 5, Paint()..color = accent);

    final String hh = '${twoDigits(hour24)}:${twoDigits(minute)}';
    final String h = '$hour24:${twoDigits(minute)}';
    final String h12 =
        '${hourOfPeriod(hour24)}:${twoDigits(minute)} ${periodOf24(hour24) == DayPeriod.am ? 'AM' : 'PM'}';

    final double panelX = size.width * 0.5;
    final double panelW = size.width * 0.44;
    final List<Map<String, dynamic>> rows = <Map<String, dynamic>>[
      <String, dynamic>{
        'label': 'HH',
        'value': hh,
        'color': const Color(0xFF1565C0),
        'flag': highlightPadding && hour24 < 10,
        'note': 'Leading zero visible for single-digit hours',
      },
      <String, dynamic>{
        'label': 'H',
        'value': h,
        'color': const Color(0xFF2E7D32),
        'flag': false,
        'note': 'No padding, compact 24-hour rendering',
      },
      <String, dynamic>{
        'label': 'h',
        'value': h12,
        'color': const Color(0xFFEF6C00),
        'flag': highlight12hWrap && (hour24 == 0 || hour24 == 12),
        'note': '12-hour display includes AM/PM context',
      },
    ];

    for (int i = 0; i < rows.length; i++) {
      final Map<String, dynamic> row = rows[i];
      final Rect r = Rect.fromLTWH(panelX, 54 + i * 90, panelW, 74);
      final Color color = row['color'] as Color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(12)),
        Paint()..color = color.withValues(alpha: 0.10),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(12)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = color.withValues(alpha: 0.38),
      );

      final TextPainter t1 = TextPainter(
        text: TextSpan(
          text: '${row['label']}  ${row['value']}',
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: panelW - 16);
      t1.paint(canvas, Offset(r.left + 8, r.top + 8));

      final TextPainter t2 = TextPainter(
        text: TextSpan(
          text: row['note'] as String,
          style: const TextStyle(
            color: Color(0xFF37474F),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: panelW - 16);
      t2.paint(canvas, Offset(r.left + 8, r.top + 35));

      if (row['flag'] as bool) {
        canvas.drawCircle(
          Offset(r.right - 14, r.top + 14),
          6,
          Paint()..color = const Color(0xFFC62828),
        );
      }
    }

    final TextPainter caption = TextPainter(
      text: TextSpan(
        text: 'Inferred from TimeOfDayFormat: ${inferred.name}',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    caption.paint(canvas, Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _HourFormatPainter oldDelegate) {
    return oldDelegate.hour24 != hour24 ||
        oldDelegate.minute != minute ||
        oldDelegate.inferred != inferred ||
        oldDelegate.highlightPadding != highlightPadding ||
        oldDelegate.highlight12hWrap != highlight12hWrap ||
        oldDelegate.accent != accent;
  }
}
