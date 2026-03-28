import 'dart:math' as math;

import 'package:flutter/material.dart';

class _RectTrackPreset {
  const _RectTrackPreset({
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
    required this.trackHeight,
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
  final double trackHeight;
}

class _RectGuide {
  const _RectGuide({
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

class _RectMetric {
  const _RectMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _RectTimelineItem {
  const _RectTimelineItem({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _RectComparisonRow {
  const _RectComparisonRow({
    required this.topic,
    required this.description,
    required this.recommendation,
  });

  final String topic;
  final String description;
  final String recommendation;
}

class _RectSnapshot {
  const _RectSnapshot({
    required this.id,
    required this.values,
    required this.note,
    required this.color,
  });

  final int id;
  final RangeValues values;
  final String note;
  final Color color;
}

dynamic build(BuildContext context) {
  final DateTime startedAt = DateTime.now();

  final List<_RectTrackPreset> presets = <_RectTrackPreset>[
    const _RectTrackPreset(
      title: 'Audio Gain Rail',
      subtitle: 'Set target monitoring window with strict boundaries.',
      icon: Icons.graphic_eq,
      min: -30,
      max: 12,
      values: RangeValues(-9, 1.5),
      divisions: 84,
      unit: 'dB',
      primary: Color(0xFF263238),
      secondary: Color(0xFF90A4AE),
      gradient: <Color>[Color(0xFFECEFF1), Color(0xFFF5F7F8)],
      note:
          'Rectangular tracks communicate engineering precision and hard thresholds in studio tooling.',
      trackHeight: 8,
    ),
    const _RectTrackPreset(
      title: 'Tolerance Window',
      subtitle: 'Manufacturing pass-band boundaries.',
      icon: Icons.precision_manufacturing,
      min: 0,
      max: 100,
      values: RangeValues(42, 58),
      divisions: 100,
      unit: '%',
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF90CAF9),
      gradient: <Color>[Color(0xFFE3F2FD), Color(0xFFF1F8FF)],
      note:
          'Use rectangular rails for tolerance workflows where users interpret strict edge alignment at a glance.',
      trackHeight: 7,
    ),
    const _RectTrackPreset(
      title: 'Voltage Guardrail',
      subtitle: 'Operational voltage band for safety envelope.',
      icon: Icons.bolt,
      min: 180,
      max: 260,
      values: RangeValues(210, 238),
      divisions: 80,
      unit: 'V',
      primary: Color(0xFFE65100),
      secondary: Color(0xFFFFCC80),
      gradient: <Color>[Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
      note:
          'Rectangular shape aligns with safety dashboards where each side of the active range reads as a hard bound.',
      trackHeight: 9,
    ),
    const _RectTrackPreset(
      title: 'Thermal Process Band',
      subtitle: 'Batch heating process operating zone.',
      icon: Icons.local_fire_department,
      min: 100,
      max: 350,
      values: RangeValues(165, 290),
      divisions: 100,
      unit: 'C',
      primary: Color(0xFFAD1457),
      secondary: Color(0xFFF48FB1),
      gradient: <Color>[Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
      note:
          'For process dashboards, rectangular tracks reduce ambiguity around transition points and control bands.',
      trackHeight: 10,
    ),
    const _RectTrackPreset(
      title: 'Response SLA Corridor',
      subtitle: 'Allowed backend response latency corridor.',
      icon: Icons.speed,
      min: 50,
      max: 1200,
      values: RangeValues(180, 460),
      divisions: 115,
      unit: 'ms',
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFA5D6A7),
      gradient: <Color>[Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
      note:
          'Rectangular rails suit operational dashboards where exact edge interpretation affects escalation decisions.',
      trackHeight: 8,
    ),
  ];

  final List<_RectGuide> guides = <_RectGuide>[
    const _RectGuide(
      title: 'Why Rectangular Track Shape',
      body:
          'RectangularRangeSliderTrackShape paints rails with square edges, emphasizing exact boundaries over soft visual flow.',
      icon: Icons.crop_16_9,
      color: Color(0xFF1565C0),
    ),
    const _RectGuide(
      title: 'Precision-first UI Tone',
      body:
          'In engineering, instrumentation, and compliance tools, rectangular rails visually suggest deterministic limits.',
      icon: Icons.rule,
      color: Color(0xFF2E7D32),
    ),
    const _RectGuide(
      title: 'Active vs Inactive Readability',
      body:
          'Square track transitions can make active window edges easier to parse in dense dashboards with many concurrent controls.',
      icon: Icons.visibility,
      color: Color(0xFF6A1B9A),
    ),
    const _RectGuide(
      title: 'Discrete Grid Alignment',
      body:
          'Rectangular rails pair effectively with high-division discrete settings where each step should feel like a grid cell.',
      icon: Icons.grid_on,
      color: Color(0xFFE65100),
    ),
    const _RectGuide(
      title: 'Theming Considerations',
      body:
          'Pair rectangular rails with adequate contrast and balanced thumb size to avoid visual harshness while preserving precision cues.',
      icon: Icons.palette,
      color: Color(0xFF00838F),
    ),
    const _RectGuide(
      title: 'Interpreter Validation Focus',
      body:
          'This demo checks interaction consistency and rendering behavior under interpreter execution rather than API correctness asserts.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
  ];

  final List<_RectComparisonRow> comparisonRows = <_RectComparisonRow>[
    const _RectComparisonRow(
      topic: 'Edge semantics',
      description: 'Rectangular rails produce hard visual starts and stops.',
      recommendation: 'Use when users must read interval boundaries as strict cut lines.',
    ),
    const _RectComparisonRow(
      topic: 'Perceived precision',
      description: 'Square geometry implies measured, deterministic control.',
      recommendation: 'Prefer in technical dashboards and calibration workflows.',
    ),
    const _RectComparisonRow(
      topic: 'Cognitive tone',
      description: 'Feels formal and operational rather than playful.',
      recommendation: 'Match with concise labels and neutral palette for data-heavy surfaces.',
    ),
    const _RectComparisonRow(
      topic: 'Discrete mode fit',
      description: 'Aligns well with many divisions and tick overlays.',
      recommendation: 'Enable snapping in workflows requiring repeatable selections.',
    ),
    const _RectComparisonRow(
      topic: 'Accessibility tradeoff',
      description: 'Sharp edges need strong contrast to remain obvious at speed.',
      recommendation: 'Increase track thickness and active/inactive contrast when needed.',
    ),
    const _RectComparisonRow(
      topic: 'Interaction telemetry',
      description: 'Rectangular rails make edge-related event debugging easier to reason about.',
      recommendation: 'Log start/end changes and compare with domain thresholds.',
    ),
  ];

  RangeValues current = const RangeValues(22, 68);
  double min = 0;
  double max = 100;
  int divisions = 24;
  double trackHeight = 8;
  String unit = '';
  Color primary = const Color(0xFF263238);
  Color secondary = const Color(0xFF90A4AE);
  bool enabled = true;
  bool darkCanvas = false;
  bool denseOverlay = false;
  bool showGridOverlay = true;
  bool showMilestones = true;
  bool snapToDivisions = true;
  bool showThirdPreview = true;
  int loads = 0;
  int updates = 0;
  int dragStarts = 0;
  int dragEnds = 0;
  final List<String> console = <String>[];
  final List<_RectTimelineItem> timeline = <_RectTimelineItem>[];
  final List<_RectSnapshot> snapshots = <_RectSnapshot>[];
  int snapshotId = 0;

  String fmt(double value) {
    if ((value - value.roundToDouble()).abs() < 0.0001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  String withUnit(double value) {
    return '${fmt(value)}$unit';
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
    timeline.insert(0, _RectTimelineItem(title: title, detail: detail, color: color));
    if (timeline.length > 36) {
      timeline.removeLast();
    }
  }

  RangeValues normalizeRange(RangeValues input) {
    final double a = input.start.clamp(min, max);
    final double b = input.end.clamp(min, max);
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

  void captureSnapshot(String note) {
    snapshotId += 1;
    snapshots.insert(
      0,
      _RectSnapshot(
        id: snapshotId,
        values: current,
        note: note,
        color: primary,
      ),
    );
    if (snapshots.length > 20) {
      snapshots.removeLast();
    }
  }

  SliderThemeData buildRectTheme({required bool emphasize}) {
    final Color active = primary.withValues(alpha: 0.95);
    final Color inactive = darkCanvas
        ? secondary.withValues(alpha: 0.38)
        : secondary.withValues(alpha: 0.74);

    return SliderThemeData(
      rangeTrackShape: const RectangularRangeSliderTrackShape(),
      rangeValueIndicatorShape: const RectangularRangeSliderValueIndicatorShape(),
      trackHeight: emphasize ? trackHeight + 1.2 : trackHeight,
      activeTrackColor: active,
      inactiveTrackColor: inactive,
      thumbColor: active,
      overlayColor: active.withValues(alpha: 0.16),
      activeTickMarkColor: active.withValues(alpha: 0.85),
      inactiveTickMarkColor: inactive.withValues(alpha: 0.8),
      showValueIndicator: ShowValueIndicator.onDrag,
      valueIndicatorColor: active,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    );
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

  Widget metricGrid(List<_RectMetric> metrics) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: metrics.map((metric) {
        return Container(
          width: 132,
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

  Widget previewPanel({
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required bool emphasize,
    required bool enabled,
    required void Function(void Function()) setState,
  }) {
    final SliderThemeData theme = buildRectTheme(emphasize: emphasize);

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
                  ? (RangeValues value) {
                      setState(() {
                        current = snappedRange(value);
                        updates += 1;
                      });
                      addLog('Panel "$title" changed to ${withUnit(current.start)} - ${withUnit(current.end)}.');
                    }
                  : null,
              onChangeStart: enabled
                  ? (RangeValues value) {
                      dragStarts += 1;
                      addLog('Drag start in "$title" at ${fmt(value.start)}..${fmt(value.end)}.');
                    }
                  : null,
              onChangeEnd: enabled
                  ? (RangeValues value) {
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

  Widget presetCard(_RectTrackPreset preset, void Function(void Function()) setState) {
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
                  trackHeight = preset.trackHeight;
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
          Expanded(flex: 2, child: cell('Description', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(flex: 3, child: cell('Recommendation', tint: const Color(0xFFF2F7FF), header: true)),
        ],
      ),
    ];

    for (final _RectComparisonRow row in comparisonRows) {
      rows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.topic, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(flex: 2, child: cell(row.description)),
            Expanded(flex: 3, child: cell(row.recommendation)),
          ],
        ),
      );
    }

    return Column(children: rows);
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
          'Timeline starts empty. Load a preset or drag sliders to capture rectangular rail events.',
          style: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
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
    );
  }

  Widget snapshotPanel() {
    if (snapshots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF7FAFD),
          border: Border.all(color: const Color(0xFFDCE8F5)),
        ),
        child: Text(
          'No snapshots yet. Capture one manually or complete a drag operation.',
          style: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      children: snapshots.map((snapshot) {
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
              Text(
                'Snapshot #${snapshot.id} | ${fmt(snapshot.values.start)}..${fmt(snapshot.values.end)} | span ${fmt(span)}',
                style: TextStyle(
                  color: snapshot.color,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
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
    );
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
                'No logs yet. Interact with sliders and controls to populate diagnostics.',
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

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final double span = current.end - current.start;
      final double midpoint = (current.start + current.end) / 2;
      final double normalizedStart = ((current.start - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double normalizedEnd = ((current.end - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double activeRatio = (span / math.max(0.0001, max - min)).clamp(0, 1);

      final List<_RectMetric> metrics = <_RectMetric>[
        _RectMetric(label: 'Start', value: withUnit(current.start), color: primary),
        _RectMetric(label: 'End', value: withUnit(current.end), color: secondary),
        _RectMetric(label: 'Span', value: fmt(span), color: const Color(0xFF6A1B9A)),
        _RectMetric(label: 'Midpoint', value: withUnit(midpoint), color: const Color(0xFF00838F)),
        _RectMetric(label: 'Divisions', value: '$divisions', color: const Color(0xFF2E7D32)),
        _RectMetric(label: 'Track Height', value: fmt(trackHeight), color: const Color(0xFF455A64)),
        _RectMetric(label: 'Updates', value: '$updates', color: const Color(0xFFE65100)),
        _RectMetric(label: 'Drag Starts', value: '$dragStarts', color: const Color(0xFFAD1457)),
        _RectMetric(label: 'Drag Ends', value: '$dragEnds', color: const Color(0xFF283593)),
        _RectMetric(label: 'Preset Loads', value: '$loads', color: const Color(0xFF37474F)),
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
                        child: Icon(Icons.crop_16_9, color: primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'RectangularRangeSliderTrackShape Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Precision-first workshop for rectangular range rails with strict geometry, domain presets, and interaction telemetry.',
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
                      pill('Active Ratio', '${(activeRatio * 100).toStringAsFixed(1)}%'),
                      pill('Snapping', snapToDivisions ? 'On' : 'Off'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Preset Scenarios',
              subtitle:
                  'Load precision-oriented rectangular rail contexts to explore strict boundary readability.',
              icon: Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((preset) => presetCard(preset, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Rectangular Rail Controls',
              subtitle:
                  'Adjust geometry, bounds, and snapping to inspect how rectangular tracks communicate strict intervals.',
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
                          label: 'Track Height',
                          valueLabel: fmt(trackHeight),
                          min: 3,
                          max: 18,
                          divisions: 30,
                          value: trackHeight,
                          onChanged: (double value) {
                            setState(() {
                              trackHeight = value;
                              updates += 1;
                            });
                            addLog('Track height changed to ${fmt(trackHeight)}.');
                          },
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: labeledSlider(
                          label: 'Divisions',
                          valueLabel: '$divisions',
                          min: 1,
                          max: 220,
                          divisions: 219,
                          value: divisions.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              divisions = value.round();
                              current = snappedRange(current);
                              updates += 1;
                            });
                            addLog('Divisions set to $divisions; range snapped.');
                          },
                          color: secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: labeledSlider(
                          label: 'Min',
                          valueLabel: fmt(min),
                          min: -200,
                          max: max - 1,
                          divisions: 300,
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
                          max: 2500,
                          divisions: 300,
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
                                  addLog('Start adjusted to ${fmt(current.start)}.');
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
                                  addLog('End adjusted to ${fmt(current.end)}.');
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
                                'Quick Precision Actions',
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
                                        current = snappedRange(RangeValues(min, max));
                                        updates += 1;
                                      });
                                      addLog('Expanded to full rectangular bounds.');
                                      captureSnapshot('Full rectangular bounds');
                                    },
                                    child: const Text('Full Bounds'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        final double center = (min + max) / 2;
                                        final double half = (max - min) / 5;
                                        current = snappedRange(RangeValues(center - half, center + half));
                                        updates += 1;
                                      });
                                      addLog('Centered precision corridor.');
                                      captureSnapshot('Centered corridor');
                                    },
                                    child: const Text('Center Corridor'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        current = snappedRange(RangeValues(current.start, current.start));
                                        updates += 1;
                                      });
                                      addLog('Collapsed to point range.');
                                      captureSnapshot('Point range');
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
                          subtitle: const Text('Disables slider updates when off.'),
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
                          subtitle: const Text('Simulate dark engineering surfaces.'),
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
                          subtitle: const Text('Show additional precision hints.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseOverlay = value;
                            });
                            addLog(value ? 'Dense overlay enabled.' : 'Dense overlay disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showGridOverlay,
                          title: const Text('Grid overlay'),
                          subtitle: const Text('Displays strict division lattice.'),
                          onChanged: (bool value) {
                            setState(() {
                              showGridOverlay = value;
                            });
                            addLog(value ? 'Grid overlay enabled.' : 'Grid overlay disabled.');
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
                          title: const Text('Milestone marks'),
                          subtitle: const Text('Show quarter markers on diagnostics rail.'),
                          onChanged: (bool value) {
                            setState(() {
                              showMilestones = value;
                            });
                            addLog(value ? 'Milestone marks visible.' : 'Milestone marks hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: snapToDivisions,
                          title: const Text('Snap to divisions'),
                          subtitle: const Text('Rounds values to nearest discrete step.'),
                          onChanged: (bool value) {
                            setState(() {
                              snapToDivisions = value;
                              current = snappedRange(current);
                            });
                            addLog(value ? 'Division snapping enabled.' : 'Division snapping disabled.');
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
                          value: showThirdPreview,
                          title: const Text('Third preview panel'),
                          subtitle: const Text('Show compact audit preview.'),
                          onChanged: (bool value) {
                            setState(() {
                              showThirdPreview = value;
                            });
                            addLog(value ? 'Third preview shown.' : 'Third preview hidden.');
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
              title: 'Rectangular Track Previews',
              subtitle:
                  'Multiple synchronized visual panels demonstrating strict rectangular active and inactive rails.',
              icon: Icons.widgets,
            ),
            const SizedBox(height: 10),
            previewPanel(
              title: 'Primary Rectangular Preview',
              subtitle: 'Main panel for precise interval dragging and value feedback.',
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF101820), const Color(0xFF1D2D44)]
                  : <Color>[const Color(0xFFFFFFFF), const Color(0xFFF4F8FF)],
              emphasize: false,
              enabled: enabled,
              setState: setState,
            ),
            const SizedBox(height: 12),
            previewPanel(
              title: 'Contrast Stress Preview',
              subtitle: 'Higher contrast and thicker rectangular rail for accessibility checks.',
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF0B0F1A), const Color(0xFF1E293B)]
                  : <Color>[const Color(0xFFEFF5FF), const Color(0xFFFFFFFF)],
              emphasize: true,
              enabled: enabled,
              setState: setState,
            ),
            if (showThirdPreview) ...<Widget>[
              const SizedBox(height: 12),
              previewPanel(
                title: 'Audit Preview',
                subtitle: 'Compact panel for quick verification of edge alignment and active span.',
                gradient: darkCanvas
                    ? <Color>[const Color(0xFF132A13), const Color(0xFF1B4332)]
                    : <Color>[const Color(0xFFF3FFF7), const Color(0xFFE9FFF0)],
                emphasize: false,
                enabled: enabled,
                setState: setState,
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Rectangular Rail Inspector',
              subtitle:
                  'Metrics and code cues for active span, normalized positions, and strict-edge semantics.',
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
                  metricGrid(metrics),
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
                      'SliderThemeData(\n'
                      '  rangeTrackShape: const RectangularRangeSliderTrackShape(),\n'
                      '  trackHeight: ${fmt(trackHeight)},\n'
                        '  activeTrackColor: const Color(0x${primary.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),\n'
                        '  inactiveTrackColor: const Color(0x${secondary.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),\n'
                      ')\n\n'
                      'current RangeValues: ${fmt(current.start)} .. ${fmt(current.end)}\n'
                      'normalized: ${fmt(normalizedStart)} .. ${fmt(normalizedEnd)}\n'
                      'divisions: $divisions\n'
                      'snapToDivisions: ${snapToDivisions ? 'true' : 'false'}',
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
              title: 'Grid Distribution View',
              subtitle:
                  'Division lattice and active occupancy overlay to inspect discrete alignment with rectangular rails.',
              icon: Icons.grid_view,
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
              child: showGridOverlay
                  ? CustomPaint(
                      painter: _RectGridPainter(
                        startNorm: normalizedStart,
                        endNorm: normalizedEnd,
                        color: primary,
                        showMilestones: showMilestones,
                        dense: denseOverlay,
                      ),
                      child: const SizedBox.expand(),
                    )
                  : Center(
                      child: Text(
                        'Grid overlay hidden. Enable it to inspect division alignment.',
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Rectangular Track Diagnostics',
              subtitle:
                  'Custom painter for strict-edge rails, active band, handles, and quarter milestones.',
              icon: Icons.insights,
            ),
            const SizedBox(height: 10),
            Container(
              height: 280,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD4E0F2)),
              ),
              child: CustomPaint(
                painter: _RectTrackDiagnosticsPainter(
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
                  trackHeight: trackHeight,
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Implementation Guidance',
              subtitle:
                  'When and how to choose rectangular rails for precision-centric range interactions.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guides.map((guide) {
                return Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: guide.color.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(guide.icon, color: guide.color, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              guide.title,
                              style: TextStyle(
                                color: guide.color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        guide.body,
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
                  'Decision support for adopting rectangular track rails in production scenarios.',
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
              title: 'Snapshots',
              subtitle:
                  'Stored interval states for replay and edge-boundary verification.',
              icon: Icons.history,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline',
              subtitle:
                  'Chronological event stream for preset loads, drag completions, and precision actions.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle:
                  'Detailed textual telemetry for interpreter-side interaction tracking.',
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
                'Summary: RectangularRangeSliderTrackShape emphasizes strict interval boundaries through square rail geometry. '
                'This deep demo shows how to tune rectangular tracks for precision-heavy workflows, with synchronized previews, '
                'grid diagnostics, event timelines, and snapshot-based validation. '
                'The result is a practical guide for implementing robust, precision-first range interactions in interpreter-driven Flutter UIs.',
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

class _RectGridPainter extends CustomPainter {
  _RectGridPainter({
    required this.startNorm,
    required this.endNorm,
    required this.color,
    required this.showMilestones,
    required this.dense,
  });

  final double startNorm;
  final double endNorm;
  final Color color;
  final bool showMilestones;
  final bool dense;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FBFF),
    );

    const int columns = 28;
    final double columnWidth = (size.width - 28) / columns;
    final double startColumn = startNorm * columns;
    final double endColumn = endNorm * columns;

    for (int i = 0; i < columns; i++) {
      final bool active = i >= startColumn && i <= endColumn;
      final Rect bar = Rect.fromLTWH(
        14 + i * columnWidth,
        dense ? 18 : 34,
        columnWidth - 1,
        dense ? size.height - 34 : size.height - 52,
      );
      canvas.drawRect(
        bar,
        Paint()..color = active ? color.withValues(alpha: 0.82) : const Color(0xFFD3DEED),
      );
    }

    if (showMilestones) {
      for (int i = 0; i <= 4; i++) {
        final double x = 14 + (size.width - 28) * (i / 4);
        canvas.drawLine(
          Offset(x, 8),
          Offset(x, size.height - 8),
          Paint()
            ..color = const Color(0xFF9BB0CB).withValues(alpha: 0.5)
            ..strokeWidth = 1,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RectGridPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.color != color ||
        oldDelegate.showMilestones != showMilestones ||
        oldDelegate.dense != dense;
  }
}

class _RectTrackDiagnosticsPainter extends CustomPainter {
  _RectTrackDiagnosticsPainter({
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
    required this.trackHeight,
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
  final double trackHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    final Paint background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF8FBFF), Color(0xFFE9F1FF)],
      ).createShader(area);
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      background,
    );

    final double railHeight = trackHeight.clamp(3, 20);
    final Rect rail = Rect.fromLTWH(24, size.height * 0.62, size.width - 48, railHeight);
    canvas.drawRect(rail, Paint()..color = const Color(0xFFC7D4E7));

    final double sx = rail.left + rail.width * startNorm;
    final double ex = rail.left + rail.width * endNorm;
    final Rect activeRect = Rect.fromLTRB(sx, rail.top, ex, rail.bottom);
    canvas.drawRect(
      activeRect,
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
      final double x = rail.left + rail.width * (i / safeDivisions);
      final bool milestone = showMilestones &&
          safeDivisions >= 4 &&
          i % (safeDivisions ~/ 4 == 0 ? 1 : safeDivisions ~/ 4) == 0;
      final double h = milestone ? 16 : 9;
      final Color c = milestone
          ? color.withValues(alpha: 0.65)
          : const Color(0xFF8FA4C2).withValues(alpha: 0.52);
      canvas.drawLine(
        Offset(x, rail.bottom + 6),
        Offset(x, rail.bottom + 6 + h),
        Paint()
          ..color = c
          ..strokeWidth = milestone ? 1.7 : 1,
      );
    }

    final Paint thumb = Paint()..color = color;
    canvas.drawCircle(Offset(sx, rail.center.dy), 8, thumb);
    canvas.drawCircle(Offset(ex, rail.center.dy), 8, thumb);
    canvas.drawCircle(
      Offset(sx, rail.center.dy),
      13,
      Paint()..color = color.withValues(alpha: 0.12),
    );
    canvas.drawCircle(
      Offset(ex, rail.center.dy),
      13,
      Paint()..color = color.withValues(alpha: 0.12),
    );

    void labelBubble(Offset anchor, String text) {
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
      canvas.drawRect(r, Paint()..color = color.withValues(alpha: 0.9));
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

    labelBubble(Offset(sx, rail.top), startLabel);
    labelBubble(Offset(ex, rail.top), endLabel);

    final TextPainter header = TextPainter(
      text: TextSpan(
        text: 'Rectangular Rail Diagnostics | min=$minLabel | max=$maxLabel | divisions=$divisions',
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
            ? 'Rectangular track interactions active: each drag updates strict active/inactive rail boundaries.'
            : 'Interaction disabled: diagnostics currently display passive rail state.',
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
  bool shouldRepaint(covariant _RectTrackDiagnosticsPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.minLabel != minLabel ||
        oldDelegate.maxLabel != maxLabel ||
        oldDelegate.color != color ||
        oldDelegate.showMilestones != showMilestones ||
        oldDelegate.enabled != enabled ||
        oldDelegate.divisions != divisions ||
        oldDelegate.trackHeight != trackHeight;
  }
}
