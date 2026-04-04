import 'dart:math' as math;

import 'package:flutter/material.dart';

class _RangePreset {
  const _RangePreset({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.min,
    required this.max,
    required this.values,
    required this.divisions,
    required this.unit,
    required this.primary,
    required this.secondary,
    required this.gradient,
    required this.note,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final double min;
  final double max;
  final RangeValues values;
  final int divisions;
  final String unit;
  final Color primary;
  final Color secondary;
  final List<Color> gradient;
  final String note;
}

class _GuideCard {
  const _GuideCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
}

class _TimelineEntry {
  const _TimelineEntry({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _Metric {
  const _Metric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _ComparisonRow {
  const _ComparisonRow({
    required this.topic,
    required this.summary,
    required this.practice,
  });

  final String topic;
  final String summary;
  final String practice;
}

class _HistorySnapshot {
  const _HistorySnapshot({
    required this.id,
    required this.values,
    required this.min,
    required this.max,
    required this.note,
    required this.color,
  });

  final int id;
  final RangeValues values;
  final double min;
  final double max;
  final String note;
  final Color color;
}

dynamic build(BuildContext context) {
  final DateTime startedAt = DateTime.now();

  final List<_RangePreset> presets = <_RangePreset>[
    const _RangePreset(
      title: 'Budget Envelope',
      subtitle: 'Weekly spending comfort zone in currency values.',
      icon: Icons.account_balance_wallet,
      min: 0,
      max: 1500,
      values: RangeValues(260, 860),
      divisions: 60,
      unit: '24',
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF90CAF9),
      gradient: <Color>[Color(0xFFE3F2FD), Color(0xFFF1F8FF)],
      note:
          'Use immutable RangeValues for predictable updates when multiple financial widgets depend on the same interval state.',
    ),
    const _RangePreset(
      title: 'Comfort Temperature Band',
      subtitle: 'Acceptable room temperature range.',
      icon: Icons.thermostat,
      min: 12,
      max: 34,
      values: RangeValues(20, 24),
      divisions: 44,
      unit: '°C',
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFA5D6A7),
      gradient: <Color>[Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
      note:
          'RangeValues makes temperature band transitions easy to reason about in both user drags and policy-based updates.',
    ),
    const _RangePreset(
      title: 'Sleep Window',
      subtitle: 'Set bedtime and wake-up hours.',
      icon: Icons.bedtime,
      min: 0,
      max: 12,
      values: RangeValues(2.2, 9.6),
      divisions: 48,
      unit: 'h',
      primary: Color(0xFF6A1B9A),
      secondary: Color(0xFFCE93D8),
      gradient: <Color>[Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
      note:
          'By replacing the full RangeValues object on every change, state remains immutable and timeline snapshots are trivial to store.',
    ),
    const _RangePreset(
      title: 'Studio Gain Window',
      subtitle: 'Preferred gain range for monitoring.',
      icon: Icons.graphic_eq,
      min: -24,
      max: 12,
      values: RangeValues(-8, 3),
      divisions: 72,
      unit: 'dB',
      primary: Color(0xFF37474F),
      secondary: Color(0xFFB0BEC5),
      gradient: <Color>[Color(0xFFECEFF1), Color(0xFFF5F7F8)],
      note:
          'RangeValues enables explicit start/end semantics that are easier to test visually than ad-hoc dual-number state.',
    ),
    const _RangePreset(
      title: 'Learning Session Focus',
      subtitle: 'Concentration interval in minutes.',
      icon: Icons.menu_book,
      min: 10,
      max: 180,
      values: RangeValues(35, 95),
      divisions: 34,
      unit: 'min',
      primary: Color(0xFFE65100),
      secondary: Color(0xFFFFCC80),
      gradient: <Color>[Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
      note:
          'RangeValues lets multiple view models consume a single immutable interval and derive independent metrics like span or midpoint.',
    ),
  ];

  final List<_GuideCard> guideCards = <_GuideCard>[
    const _GuideCard(
      title: 'RangeValues Is Immutable',
      body:
          'You never mutate start/end directly. You create a new RangeValues object each update, which makes state transitions explicit.',
      icon: Icons.lock,
      color: Color(0xFF1565C0),
    ),
    const _GuideCard(
      title: 'Semantic Pair',
      body:
          'The class expresses an interval, not two unrelated doubles. This reduces ambiguity in UI logic and timeline history.',
      icon: Icons.compare_arrows,
      color: Color(0xFF2E7D32),
    ),
    const _GuideCard(
      title: 'Used By RangeSlider',
      body:
          'RangeSlider consumes and emits RangeValues through onChanged, onChangeStart, and onChangeEnd callbacks.',
      icon: Icons.linear_scale,
      color: Color(0xFF6A1B9A),
    ),
    const _GuideCard(
      title: 'Equality And Hashing',
      body:
          'Value equality allows quick visual checks: two objects with same start/end compare equal, simplifying caching and debug overlays.',
      icon: Icons.tag,
      color: Color(0xFFE65100),
    ),
    const _GuideCard(
      title: 'Normalization Patterns',
      body:
          'When min/max changes dynamically, normalize RangeValues by clamping and ordering to keep intervals valid and meaningful.',
      icon: Icons.transform,
      color: Color(0xFF00838F),
    ),
    const _GuideCard(
      title: 'Interpreter Focus',
      body:
          'These demos emphasize interaction behavior in interpreted execution: visual updates, state replacement, and telemetry flow.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
  ];

  final List<_ComparisonRow> comparisonRows = <_ComparisonRow>[
    const _ComparisonRow(
      topic: 'Creation',
      summary: 'const or runtime constructor with start/end doubles',
      practice: 'Prefer const for static presets to improve readability and stable identity in docs.',
    ),
    const _ComparisonRow(
      topic: 'Update pattern',
      summary: 'Replace entire object on every drag step',
      practice: 'Store RangeValues in one state field and assign new object in callback.',
    ),
    const _ComparisonRow(
      topic: 'Validation',
      summary: 'Must remain in min/max and start <= end semantics',
      practice: 'Clamp and sort via helper methods before publishing state to dependent widgets.',
    ),
    const _ComparisonRow(
      topic: 'Inter-widget sharing',
      summary: 'One object can drive charts, labels, and timelines',
      practice: 'Derive secondary metrics (span, midpoint) from RangeValues centrally.',
    ),
    const _ComparisonRow(
      topic: 'Debugging',
      summary: 'toString and equality are useful during replay',
      practice: 'Log RangeValues snapshots to compare expected state transitions.',
    ),
    const _ComparisonRow(
      topic: 'Persistence',
      summary: 'Serialize start/end pair for storage and restore',
      practice: 'Use explicit schema with min/max context to avoid ambiguous replay.',
    ),
  ];

  RangeValues current = const RangeValues(20, 72);
  double min = 0;
  double max = 100;
  int divisions = 24;
  String unit = '';
  Color primary = const Color(0xFF1565C0);
  Color secondary = const Color(0xFF90CAF9);
  bool enabled = true;
  bool darkCanvas = false;
  bool denseOverlay = false;
  bool showHistogram = true;
  bool showMilestones = true;
  bool snapToDivisions = true;
  int loads = 0;
  int dragStarts = 0;
  int dragEnds = 0;
  int updates = 0;
  final List<String> console = <String>[];
  final List<_TimelineEntry> timeline = <_TimelineEntry>[];
  final List<_HistorySnapshot> history = <_HistorySnapshot>[];
  int snapshotCounter = 0;

  String fmt(double value) {
    if ((value - value.roundToDouble()).abs() < 0.0001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  String withUnit(double value) {
    if (unit == '24') {
      return '24${fmt(value)}';
    }
    return '${fmt(value)}$unit';
  }

  RangeValues normalizeRange(RangeValues candidate) {
    final double a = candidate.start.clamp(min, max);
    final double b = candidate.end.clamp(min, max);
    if (a <= b) {
      return RangeValues(a, b);
    }
    return RangeValues(b, a);
  }

  RangeValues snappedRange(RangeValues input) {
    if (!snapToDivisions || divisions <= 0) {
      return normalizeRange(input);
    }
    final double step = (max - min) / divisions;
    double snap(double value) {
      final double index = ((value - min) / step).roundToDouble();
      return min + index * step;
    }

    final RangeValues normalized = normalizeRange(input);
    return normalizeRange(RangeValues(snap(normalized.start), snap(normalized.end)));
  }

  void addLog(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    console.insert(0, '[$stamp] $message');
    if (console.length > 140) {
      console.removeLast();
    }
  }

  void addTimeline(String title, String detail, Color color) {
    timeline.insert(0, _TimelineEntry(title: title, detail: detail, color: color));
    if (timeline.length > 36) {
      timeline.removeLast();
    }
  }

  void captureSnapshot(String note) {
    snapshotCounter += 1;
    history.insert(
      0,
      _HistorySnapshot(
        id: snapshotCounter,
        values: current,
        min: min,
        max: max,
        note: note,
        color: primary,
      ),
    );
    if (history.length > 20) {
      history.removeLast();
    }
  }

  Widget pill(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.75),
        border: Border.all(color: const Color(0xFFC7D8F3)),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF1D3557),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget sectionTitle({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primary, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget metricWrap(List<_Metric> items) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((metric) {
        return Container(
          width: 138,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: metric.color.withValues(alpha: 0.1),
            border: Border.all(color: metric.color.withValues(alpha: 0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                metric.label,
                style: TextStyle(
                  color: metric.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                metric.value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget labeledSlider({
    required String label,
    required String valueLabel,
    required double min,
    required double max,
    required int divisions,
    required double value,
    required ValueChanged<double>? onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                valueLabel,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: color.withValues(alpha: 0.28),
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.14),
            ),
            child: Slider(
              min: min,
              max: max,
              divisions: divisions,
              value: value.clamp(min, max),
              label: valueLabel,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget comparisonTable() {
    Widget cell(String text, {Color? tint, bool header = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: tint,
          border: Border.all(color: const Color(0xFFE3EAF6)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: header ? FontWeight.w800 : FontWeight.w500,
            color: header ? Colors.blueGrey.shade900 : Colors.blueGrey.shade800,
          ),
        ),
      );
    }

    final List<Widget> rows = <Widget>[
      Row(
        children: <Widget>[
          Expanded(flex: 2, child: cell('Topic', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(flex: 2, child: cell('Summary', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(flex: 3, child: cell('Practice', tint: const Color(0xFFF2F7FF), header: true)),
        ],
      ),
    ];

    for (final _ComparisonRow row in comparisonRows) {
      rows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.topic, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(flex: 2, child: cell(row.summary)),
            Expanded(flex: 3, child: cell(row.practice)),
          ],
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: rows));
  }

  Widget presetCard(_RangePreset preset, void Function(void Function()) setState) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: preset.gradient,
        ),
        border: Border.all(color: preset.primary.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(preset.icon, color: preset.primary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  preset.title,
                  style: TextStyle(
                    color: preset.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            preset.subtitle,
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            preset.note,
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              height: 1.32,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              pill('Range', '${fmt(preset.values.start)}..${fmt(preset.values.end)}${preset.unit}'),
              pill('Min/Max', '${fmt(preset.min)}..${fmt(preset.max)}'),
              pill('Div', '${preset.divisions}'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  min = preset.min;
                  max = preset.max;
                  divisions = preset.divisions;
                  unit = preset.unit;
                  primary = preset.primary;
                  secondary = preset.secondary;
                  current = normalizeRange(preset.values);
                  darkCanvas = preset.gradient.first.computeLuminance() < 0.2;
                  loads += 1;
                });
                addLog('Loaded preset ${preset.title}.');
                addTimeline(
                  'Preset loaded',
                  '${withUnit(current.start)} -> ${withUnit(current.end)}',
                  preset.primary,
                );
                captureSnapshot('Loaded preset ${preset.title}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Preset'),
            ),
          ),
        ],
      ),
    );
  }

  Widget timelinePanel() {
    if (timeline.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF4F7FB),
          border: Border.all(color: const Color(0xFFD8E4F4)),
        ),
        child: Text(
          'Timeline starts empty. Load presets or drag thumbs to capture RangeValues transitions.',
          style: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
      children: timeline.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: entry.color.withValues(alpha: 0.35)),
            color: entry.color.withValues(alpha: 0.08),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: entry.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: entry.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.detail,
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        height: 1.32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ));
  }

  Widget snapshotPanel() {
    if (history.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF7FAFD),
          border: Border.all(color: const Color(0xFFDCE8F5)),
        ),
        child: Text(
          'No snapshots yet. Use “Capture Snapshot” or load presets to record RangeValues history.',
          style: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
      children: history.map((snapshot) {
        final double span = snapshot.values.end - snapshot.values.start;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: snapshot.color.withValues(alpha: 0.34)),
            color: snapshot.color.withValues(alpha: 0.08),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Snapshot #${snapshot.id}',
                    style: TextStyle(
                      color: snapshot.color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Range: ${fmt(snapshot.values.start)}..${fmt(snapshot.values.end)}',
                    style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'min/max=${fmt(snapshot.min)}..${fmt(snapshot.max)} | span=${fmt(span)}',
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                snapshot.note,
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ));
  }

  Widget consolePanel() {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1321),
        borderRadius: BorderRadius.circular(14),
      ),
      child: console.isEmpty
          ? const Center(
              child: Text(
                'No logs yet. Move sliders or load presets to populate diagnostics.',
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
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    console[index],
                    style: const TextStyle(
                      color: Color(0xFFD5E4FF),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget previewPanel({
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required bool emphasize,
    required void Function(void Function()) setState,
  }) {
    final Color active = emphasize ? primary.withValues(alpha: 1) : primary.withValues(alpha: 0.9);
    final Color inactive = darkCanvas
        ? secondary.withValues(alpha: 0.36)
        : secondary.withValues(alpha: 0.74);

    final SliderThemeData theme = SliderThemeData(
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
      trackHeight: emphasize ? 7.5 : 6,
      activeTrackColor: active,
      inactiveTrackColor: inactive,
      thumbColor: active,
      overlayColor: active.withValues(alpha: 0.16),
      valueIndicatorColor: active,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      showValueIndicator: ShowValueIndicator.onDrag,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        border: Border.all(
          color: emphasize
              ? primary.withValues(alpha: 0.46)
              : primary.withValues(alpha: 0.24),
          width: emphasize ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: darkCanvas ? Colors.white : Colors.blueGrey.shade900,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: darkCanvas ? const Color(0xFFCFD8DC) : Colors.blueGrey.shade700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          SliderTheme(
            data: theme,
            child: RangeSlider(
              min: min,
              max: max,
              divisions: divisions,
              labels: RangeLabels(withUnit(current.start), withUnit(current.end)),
              values: current,
              onChanged: enabled
                  ? (RangeValues values) {
                      setState(() {
                        current = snappedRange(values);
                        updates += 1;
                      });
                      addLog('Preview "$title" changed: ${withUnit(current.start)} -> ${withUnit(current.end)}.');
                    }
                  : null,
              onChangeStart: enabled
                  ? (RangeValues values) {
                      dragStarts += 1;
                      addLog('Drag started on "$title" at ${fmt(values.start)}..${fmt(values.end)}.');
                    }
                  : null,
              onChangeEnd: enabled
                  ? (RangeValues values) {
                      dragEnds += 1;
                      addTimeline(
                        'Drag completed',
                        '$title -> ${withUnit(current.start)} to ${withUnit(current.end)}',
                        primary,
                      );
                      captureSnapshot('Drag completed in $title');
                    }
                  : null,
            ),
          ),
          if (denseOverlay) ...<Widget>[
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Span: ${fmt(current.end - current.start)}',
                    style: TextStyle(
                      color: darkCanvas ? const Color(0xFFD7E3F8) : Colors.blueGrey.shade900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'step ${fmt((max - min) / math.max(1, divisions))}',
                  style: TextStyle(
                    color: darkCanvas ? const Color(0xFFB7C9E6) : Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final double span = current.end - current.start;
      final double midpoint = (current.start + current.end) / 2;
      final double normalizedStart = ((current.start - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double normalizedEnd = ((current.end - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double progress = (span / math.max(0.0001, max - min)).clamp(0, 1);

      final RangeValues baseline = const RangeValues(20, 72);
      final bool equalToBaseline = normalizeRange(current) == normalizeRange(baseline);

      final List<_Metric> metrics = <_Metric>[
        _Metric(label: 'Start', value: withUnit(current.start), color: primary),
        _Metric(label: 'End', value: withUnit(current.end), color: secondary),
        _Metric(label: 'Span', value: fmt(span), color: const Color(0xFF6A1B9A)),
        _Metric(label: 'Midpoint', value: withUnit(midpoint), color: const Color(0xFF00838F)),
        _Metric(label: 'Divisions', value: '$divisions', color: const Color(0xFF2E7D32)),
        _Metric(label: 'Updates', value: '$updates', color: const Color(0xFFE65100)),
        _Metric(label: 'Drag starts', value: '$dragStarts', color: const Color(0xFFAD1457)),
        _Metric(label: 'Drag ends', value: '$dragEnds', color: const Color(0xFF283593)),
        _Metric(label: 'Preset loads', value: '$loads', color: const Color(0xFF455A64)),
      ];

      return Container(
        color: const Color(0xFFF3F7FE),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 26),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFE8F0FF), Color(0xFFF3E5F5)],
                ),
                border: Border.all(color: const Color(0xFFC5D7F7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.view_timeline, color: primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'RangeValues Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Comprehensive visual playground for immutable interval modeling with RangeValues across multiple interaction contexts.',
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      pill('Current', '${withUnit(current.start)} -> ${withUnit(current.end)}'),
                      pill('Min/Max', '${fmt(min)}..${fmt(max)}'),
                      pill('Normalized', '${fmt(normalizedStart)}..${fmt(normalizedEnd)}'),
                      pill('Equal baseline', equalToBaseline ? 'Yes' : 'No'),
                      pill('Progress', '${(progress * 100).toStringAsFixed(1)}%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Preset Scenarios',
              subtitle:
                  'Load practical intervals that show how RangeValues behaves as an immutable state model in different domains.',
              icon: Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((preset) => presetCard(preset, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'RangeValues Controls',
              subtitle:
                  'Edit interval bounds and update mechanics to demonstrate normalization, snapping, and immutable replacement.',
              icon: Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD6E3F4)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: labeledSlider(
                          label: 'Min',
                          valueLabel: fmt(min),
                          min: -100,
                          max: max - 1,
                          divisions: 200,
                          value: min,
                          onChanged: (double value) {
                            setState(() {
                              min = value;
                              current = normalizeRange(current);
                              updates += 1;
                            });
                            addLog('Min changed to ${fmt(min)} and range normalized.');
                          },
                          color: const Color(0xFF00695C),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: labeledSlider(
                          label: 'Max',
                          valueLabel: fmt(max),
                          min: min + 1,
                          max: 2000,
                          divisions: 200,
                          value: max,
                          onChanged: (double value) {
                            setState(() {
                              max = value;
                              current = normalizeRange(current);
                              updates += 1;
                            });
                            addLog('Max changed to ${fmt(max)} and range normalized.');
                          },
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: labeledSlider(
                          label: 'Start',
                          valueLabel: fmt(current.start),
                          min: min,
                          max: current.end,
                          divisions: math.max(1, divisions),
                          value: current.start,
                          onChanged: enabled
                              ? (double value) {
                                  setState(() {
                                    current = snappedRange(RangeValues(value, current.end));
                                    updates += 1;
                                  });
                                  addLog('Start manually set to ${fmt(current.start)}.');
                                }
                              : null,
                          color: const Color(0xFF8E24AA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: labeledSlider(
                          label: 'End',
                          valueLabel: fmt(current.end),
                          min: current.start,
                          max: max,
                          divisions: math.max(1, divisions),
                          value: current.end,
                          onChanged: enabled
                              ? (double value) {
                                  setState(() {
                                    current = snappedRange(RangeValues(current.start, value));
                                    updates += 1;
                                  });
                                  addLog('End manually set to ${fmt(current.end)}.');
                                }
                              : null,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: labeledSlider(
                          label: 'Divisions',
                          valueLabel: '$divisions',
                          min: 1,
                          max: 200,
                          divisions: 199,
                          value: divisions.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              divisions = value.round();
                              current = snappedRange(current);
                              updates += 1;
                            });
                            addLog('Divisions set to $divisions; range snapped.');
                          },
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF1E88E5).withValues(alpha: 0.08),
                            border: Border.all(color: const Color(0xFF1E88E5).withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Quick Actions',
                                style: TextStyle(
                                  color: Color(0xFF1E88E5),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        current = normalizeRange(RangeValues(min, max));
                                        updates += 1;
                                      });
                                      addLog('Expanded range to full bounds.');
                                      captureSnapshot('Expanded to full bounds');
                                    },
                                    child: const Text('Full Range'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        final double center = (min + max) / 2;
                                        final double quarter = (max - min) / 4;
                                        current = snappedRange(RangeValues(center - quarter, center + quarter));
                                        updates += 1;
                                      });
                                      addLog('Centered range around midpoint.');
                                      captureSnapshot('Centered around midpoint');
                                    },
                                    child: const Text('Center Band'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        current = snappedRange(RangeValues(current.start, current.start));
                                        updates += 1;
                                      });
                                      addLog('Collapsed range to single point.');
                                      captureSnapshot('Collapsed to point range');
                                    },
                                    child: const Text('Point Range'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      captureSnapshot('Manual snapshot');
                                      addLog('Manual snapshot captured.');
                                    },
                                    child: const Text('Capture Snapshot'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: enabled,
                          title: const Text('Enable interaction'),
                          subtitle: const Text('Disables slider interactions when off.'),
                          onChanged: (bool value) {
                            setState(() {
                              enabled = value;
                            });
                            addLog(value ? 'Interaction enabled.' : 'Interaction disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: darkCanvas,
                          title: const Text('Dark preview canvas'),
                          subtitle: const Text('Simulate dark surfaces for visual checks.'),
                          onChanged: (bool value) {
                            setState(() {
                              darkCanvas = value;
                            });
                            addLog(value ? 'Dark canvas enabled.' : 'Dark canvas disabled.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: denseOverlay,
                          title: const Text('Dense overlay hints'),
                          subtitle: const Text('Show extra span and step hints in previews.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseOverlay = value;
                            });
                            addLog(value ? 'Dense overlay hints enabled.' : 'Dense overlay hints disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showHistogram,
                          title: const Text('Show histogram'),
                          subtitle: const Text('Displays interval occupancy bars.'),
                          onChanged: (bool value) {
                            setState(() {
                              showHistogram = value;
                            });
                            addLog(value ? 'Histogram enabled.' : 'Histogram hidden.');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showMilestones,
                          title: const Text('Milestone lines'),
                          subtitle: const Text('Quarter markers in diagnostics strip.'),
                          onChanged: (bool value) {
                            setState(() {
                              showMilestones = value;
                            });
                            addLog(value ? 'Milestones visible.' : 'Milestones hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: snapToDivisions,
                          title: const Text('Snap to divisions'),
                          subtitle: const Text('Rounds updates to nearest step.'),
                          onChanged: (bool value) {
                            setState(() {
                              snapToDivisions = value;
                              current = snappedRange(current);
                            });
                            addLog(value ? 'Snapping enabled.' : 'Snapping disabled.');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Live RangeValues Previews',
              subtitle:
                  'Multiple synchronized views driven by the same immutable RangeValues state object.',
              icon: Icons.widgets,
            ),
            const SizedBox(height: 10),
            previewPanel(
              title: 'Primary Preview',
              subtitle: 'Core interval editing panel with value labels and change callbacks.',
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF101820), const Color(0xFF1D2D44)]
                  : <Color>[const Color(0xFFFFFFFF), const Color(0xFFF4F8FF)],
              emphasize: false,
              setState: setState,
            ),
            const SizedBox(height: 12),
            previewPanel(
              title: 'Contrast Preview',
              subtitle: 'Higher contrast surface for accessibility and dense-content stress testing.',
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF0B0F1A), const Color(0xFF1E293B)]
                  : <Color>[const Color(0xFFEFF5FF), const Color(0xFFFFFFFF)],
              emphasize: true,
              setState: setState,
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'RangeValues Object Inspector',
              subtitle:
                  'Visual diagnostics for equality, hash behavior, normalized coordinates, and toString output.',
              icon: Icons.analytics,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD6E2F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  metricWrap(metrics),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1321),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF254269)),
                    ),
                    child: Text(
                      'const baseline = RangeValues(20, 72);\n'
                      'final current = RangeValues(${fmt(current.start)}, ${fmt(current.end)});\n'
                      'current == baseline -> ${equalToBaseline ? 'true' : 'false'}\n'
                      'current.hashCode -> ${current.hashCode}\n'
                      'baseline.hashCode -> ${baseline.hashCode}\n'
                      'current.toString() -> $current',
                      style: const TextStyle(
                        color: Color(0xFFD7E8FF),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Interval Distribution View',
              subtitle:
                  'Histogram-like bar strip to visualize how much of the full range is currently active.',
              icon: Icons.bar_chart,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD4E0F2)),
              ),
              child: showHistogram
                  ? CustomPaint(
                      painter: _DistributionPainter(
                        startNorm: normalizedStart,
                        endNorm: normalizedEnd,
                        color: primary,
                        showMilestones: showMilestones,
                      ),
                      child: const SizedBox.expand(),
                    )
                  : Center(
                      child: Text(
                        'Histogram hidden. Enable "Show histogram" to visualize interval occupancy.',
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'RangeValues Diagnostics Painter',
              subtitle:
                  'Structured diagram of min/max rail, active interval, handles, and milestone anchors.',
              icon: Icons.insights,
            ),
            const SizedBox(height: 10),
            Container(
              height: 270,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD4E0F2)),
              ),
              child: CustomPaint(
                painter: _RangeDiagnosticsPainter(
                  startNorm: normalizedStart,
                  endNorm: normalizedEnd,
                  startLabel: fmt(current.start),
                  endLabel: fmt(current.end),
                  minLabel: fmt(min),
                  maxLabel: fmt(max),
                  color: primary,
                  showMilestones: showMilestones,
                  enabled: enabled,
                  divisions: divisions,
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Implementation Notes',
              subtitle:
                  'How RangeValues participates in UI state architecture and immutable update pipelines.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guideCards.map((card) {
                return Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: card.color.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(card.icon, color: card.color, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              card.title,
                              style: TextStyle(
                                color: card.color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        card.body,
                        style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          height: 1.32,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Comparison Matrix',
              subtitle:
                  'Concise guidance for building robust RangeValues-centric interaction systems.',
              icon: Icons.table_chart,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD6E2F2)),
              ),
              child: comparisonTable(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'History Snapshots',
              subtitle:
                  'Captured RangeValues instances for replay and visual comparison of interval evolution.',
              icon: Icons.history,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Interaction Timeline',
              subtitle:
                  'Chronological event feed for preset loads, drag completions, and normalization actions.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle:
                  'Low-level textual telemetry useful while verifying interpreter-side updates and event order.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            consolePanel(),
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
                'Summary: RangeValues is the immutable interval backbone of RangeSlider interactions. '
                'This deep demo shows how to create, normalize, compare, snapshot, and visualize RangeValues across practical product scenarios. '
                'By driving multiple synchronized views from one RangeValues object, it demonstrates a clear and robust state model '
                'for interpreter-driven Flutter UIs.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Session started at '
              '${startedAt.hour.toString().padLeft(2, '0')}:'
              '${startedAt.minute.toString().padLeft(2, '0')}:'
              '${startedAt.second.toString().padLeft(2, '0')}.',
              style: TextStyle(
                color: Colors.blueGrey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _DistributionPainter extends CustomPainter {
  _DistributionPainter({
    required this.startNorm,
    required this.endNorm,
    required this.color,
    required this.showMilestones,
  });

  final double startNorm;
  final double endNorm;
  final Color color;
  final bool showMilestones;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FBFF),
    );

    const int bars = 24;
    final double barWidth = (size.width - 28) / bars;
    final double startIndex = startNorm * bars;
    final double endIndex = endNorm * bars;

    for (int i = 0; i < bars; i++) {
      final bool active = i >= startIndex && i <= endIndex;
      final double h = active ? 58 : 24;
      final Rect bar = Rect.fromLTWH(14 + i * barWidth, size.height - h - 18, barWidth - 2, h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(bar, const Radius.circular(4)),
        Paint()
          ..color = active ? color.withValues(alpha: 0.85) : const Color(0xFFCFD8E6)
          ..style = PaintingStyle.fill,
      );
    }

    if (showMilestones) {
      for (int i = 0; i <= 4; i++) {
        final double x = 14 + (size.width - 28) * (i / 4);
        canvas.drawLine(
          Offset(x, 10),
          Offset(x, size.height - 6),
          Paint()
            ..color = const Color(0xFFB0C3DC).withValues(alpha: 0.4)
            ..strokeWidth = 1,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DistributionPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.color != color ||
        oldDelegate.showMilestones != showMilestones;
  }
}

class _RangeDiagnosticsPainter extends CustomPainter {
  _RangeDiagnosticsPainter({
    required this.startNorm,
    required this.endNorm,
    required this.startLabel,
    required this.endLabel,
    required this.minLabel,
    required this.maxLabel,
    required this.color,
    required this.showMilestones,
    required this.enabled,
    required this.divisions,
  });

  final double startNorm;
  final double endNorm;
  final String startLabel;
  final String endLabel;
  final String minLabel;
  final String maxLabel;
  final Color color;
  final bool showMilestones;
  final bool enabled;
  final int divisions;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF8FBFF), Color(0xFFE9F1FF)],
      ).createShader(area);
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      bg,
    );

    final Rect track = Rect.fromLTWH(24, size.height * 0.62, size.width - 48, 12);
    canvas.drawRRect(
      RRect.fromRectAndRadius(track, const Radius.circular(999)),
      Paint()..color = const Color(0xFFC7D4E7),
    );

    final double sx = track.left + track.width * startNorm;
    final double ex = track.left + track.width * endNorm;
    final Rect activeRect = Rect.fromLTRB(sx, track.top, ex, track.bottom);
    canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(999)),
      Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            color.withValues(alpha: enabled ? 0.78 : 0.46),
            color.withValues(alpha: enabled ? 1 : 0.64),
            color.withValues(alpha: enabled ? 0.78 : 0.46),
          ],
        ).createShader(activeRect),
    );

    final int safeDivisions = math.max(1, divisions);
    for (int i = 0; i <= safeDivisions; i++) {
      final double x = track.left + track.width * (i / safeDivisions);
      final bool milestone = showMilestones &&
          safeDivisions >= 4 &&
          i % (safeDivisions ~/ 4 == 0 ? 1 : safeDivisions ~/ 4) == 0;
      final double h = milestone ? 16 : 9;
      final Color c = milestone
          ? color.withValues(alpha: 0.65)
          : const Color(0xFF8FA4C2).withValues(alpha: 0.52);
      canvas.drawLine(
        Offset(x, track.bottom + 6),
        Offset(x, track.bottom + 6 + h),
        Paint()
          ..color = c
          ..strokeWidth = milestone ? 1.7 : 1,
      );
    }

    final Paint thumb = Paint()..color = color;
    canvas.drawCircle(Offset(sx, track.center.dy), 8, thumb);
    canvas.drawCircle(Offset(ex, track.center.dy), 8, thumb);
    canvas.drawCircle(
      Offset(sx, track.center.dy),
      13,
      Paint()..color = color.withValues(alpha: 0.12),
    );
    canvas.drawCircle(
      Offset(ex, track.center.dy),
      13,
      Paint()..color = color.withValues(alpha: 0.12),
    );

    void bubble(Offset anchor, String text) {
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final Rect r = Rect.fromLTWH(anchor.dx - t.width / 2 - 8, anchor.dy - 34, t.width + 16, 22);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(10)),
        Paint()..color = color.withValues(alpha: 0.9),
      );
      t.paint(canvas, Offset(r.left + 8, r.top + 4));
      canvas.drawPath(
        Path()
          ..moveTo(anchor.dx - 5, r.bottom)
          ..lineTo(anchor.dx + 5, r.bottom)
          ..lineTo(anchor.dx, r.bottom + 6)
          ..close(),
        Paint()..color = color.withValues(alpha: 0.9),
      );
    }

    bubble(Offset(sx, track.top), startLabel);
    bubble(Offset(ex, track.top), endLabel);

    final TextPainter header = TextPainter(
      text: TextSpan(
        text: 'RangeValues Diagnostics | min=$minLabel | max=$maxLabel | divisions=$divisions',
        style: const TextStyle(
          color: Color(0xFF294172),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 28);
    header.paint(canvas, const Offset(14, 12));

    final TextPainter footer = TextPainter(
      text: TextSpan(
        text: enabled
            ? 'Drag interactions active: each update replaces RangeValues immutably and updates downstream metrics.'
            : 'Interaction disabled: panel currently shows passive interval state.',
        style: const TextStyle(
          color: Color(0xFF4A5E7A),
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 28);
    footer.paint(canvas, Offset(14, size.height - 24));
  }

  @override
  bool shouldRepaint(covariant _RangeDiagnosticsPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.minLabel != minLabel ||
        oldDelegate.maxLabel != maxLabel ||
        oldDelegate.color != color ||
        oldDelegate.showMilestones != showMilestones ||
        oldDelegate.enabled != enabled ||
        oldDelegate.divisions != divisions;
  }
}
