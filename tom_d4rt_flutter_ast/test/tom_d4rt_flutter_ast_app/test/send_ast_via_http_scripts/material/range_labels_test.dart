import 'package:flutter/material.dart';

enum _LabelStyle {
  plain,
  currency,
  percent,
  duration,
  temperature,
  compact,
}

class _RangeScenario {
  const _RangeScenario({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.min,
    required this.max,
    required this.values,
    required this.divisions,
    required this.style,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final double min;
  final double max;
  final RangeValues values;
  final int? divisions;
  final _LabelStyle style;
}

class _TraceEntry {
  const _TraceEntry({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _LabelGuideRow {
  const _LabelGuideRow({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();
  final List<String> console = <String>[];
  final List<_TraceEntry> timeline = <_TraceEntry>[];

  double min = 0;
  double max = 100;
  RangeValues values = const RangeValues(20, 80);
  int? divisions = 20;

  _LabelStyle labelStyle = _LabelStyle.plain;
  int selectedScenario = 0;

  bool autoSyncScenario = true;
  bool showSegments = true;
  bool showComparisonTable = true;
  bool showSecondSlider = true;
  bool highlightMidpoint = true;

  final List<_RangeScenario> scenarios = <_RangeScenario>[
    const _RangeScenario(
      title: 'Budget Window',
      description:
          'Finance range with currency labels and discrete steps for allocation planning.',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF1565C0),
      min: 0,
      max: 2000,
      values: RangeValues(350, 1480),
      divisions: 40,
      style: _LabelStyle.currency,
    ),
    const _RangeScenario(
      title: 'Completion Funnel',
      description:
          'Percent labels are useful for progress targets and confidence bands.',
      icon: Icons.trending_up,
      color: Color(0xFF2E7D32),
      min: 0,
      max: 100,
      values: RangeValues(25, 72),
      divisions: 20,
      style: _LabelStyle.percent,
    ),
    const _RangeScenario(
      title: 'Quiet Hours Planner',
      description:
          'Duration labels turn numeric values into readable hh:mm style slots.',
      icon: Icons.nightlight_round,
      color: Color(0xFF6A1B9A),
      min: 0,
      max: 1440,
      values: RangeValues(1320, 1410),
      divisions: 48,
      style: _LabelStyle.duration,
    ),
    const _RangeScenario(
      title: 'Climate Comfort Range',
      description:
          'Temperature label formatting for thermostat and environment controls.',
      icon: Icons.thermostat,
      color: Color(0xFFEF6C00),
      min: -10,
      max: 45,
      values: RangeValues(18, 26),
      divisions: 55,
      style: _LabelStyle.temperature,
    ),
    const _RangeScenario(
      title: 'Compact Metrics',
      description:
          'Compact notation helps when large ranges must fit small indicator bubbles.',
      icon: Icons.compress,
      color: Color(0xFF006064),
      min: 0,
      max: 50000,
      values: RangeValues(7000, 32400),
      divisions: 50,
      style: _LabelStyle.compact,
    ),
  ];

  final List<_LabelGuideRow> guideRows = <_LabelGuideRow>[
    const _LabelGuideRow(
      title: 'RangeLabels role',
      text:
          'RangeLabels only stores the display text for start/end thumbs; the actual values are in RangeValues.',
    ),
    const _LabelGuideRow(
      title: 'Formatting strategy',
      text:
          'Always format labels close to the slider state so text updates stay in sync with onChanged values.',
    ),
    const _LabelGuideRow(
      title: 'Precision control',
      text:
          'Use domain-aware formatting (currency, percent, time) to avoid overly precise labels that hurt readability.',
    ),
    const _LabelGuideRow(
      title: 'Discrete vs continuous',
      text:
          'When divisions are provided, labels can represent stable buckets; without divisions, prefer concise rounded labels.',
    ),
    const _LabelGuideRow(
      title: 'Consistency with units',
      text:
          'Match label units to axis meaning, e.g., min, max, and tick captions should use the same unit style.',
    ),
    const _LabelGuideRow(
      title: 'Accessibility note',
      text:
          'Range labels should remain short and meaningful so assistive technologies announce clear thumb values.',
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

  String twoDigits(int value) => value.toString().padLeft(2, '0');

  String formatCompact(double value) {
    final double abs = value.abs();
    if (abs >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (abs >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
  }

  String formatDuration(double value) {
    final int minutesTotal = value.round().clamp(0, 24 * 60);
    final int h = minutesTotal ~/ 60;
    final int m = minutesTotal % 60;
    return '${twoDigits(h)}:${twoDigits(m)}';
  }

  String formatByStyle(double value, _LabelStyle style) {
    switch (style) {
      case _LabelStyle.plain:
        return value.toStringAsFixed(0);
      case _LabelStyle.currency:
        return '4{value.toStringAsFixed(0)}';
      case _LabelStyle.percent:
        return '${value.toStringAsFixed(0)}%';
      case _LabelStyle.duration:
        return formatDuration(value);
      case _LabelStyle.temperature:
        return '${value.toStringAsFixed(1)} C';
      case _LabelStyle.compact:
        return formatCompact(value);
    }
  }

  String styleName(_LabelStyle style) {
    switch (style) {
      case _LabelStyle.plain:
        return 'plain';
      case _LabelStyle.currency:
        return 'currency';
      case _LabelStyle.percent:
        return 'percent';
      case _LabelStyle.duration:
        return 'duration';
      case _LabelStyle.temperature:
        return 'temperature';
      case _LabelStyle.compact:
        return 'compact';
    }
  }

  String styleDescription(_LabelStyle style) {
    switch (style) {
      case _LabelStyle.plain:
        return 'Raw numeric text, no domain unit decoration.';
      case _LabelStyle.currency:
        return 'Currency prefixes suitable for budgets and pricing sliders.';
      case _LabelStyle.percent:
        return 'Percent output for progress, confidence, and thresholds.';
      case _LabelStyle.duration:
        return 'Hour-minute formatting from minute-based values.';
      case _LabelStyle.temperature:
        return 'Temperature unit formatting with decimal precision.';
      case _LabelStyle.compact:
        return 'Large-number compact notation for dense dashboards.';
    }
  }

  RangeLabels makeLabels(RangeValues value, _LabelStyle style) {
    return RangeLabels(
      formatByStyle(value.start, style),
      formatByStyle(value.end, style),
    );
  }

  double safeSpan(double min, double max) {
    return (max - min).abs().clamp(1e-9, double.infinity);
  }

  String percentInRange(double value, double min, double max) {
    final double p = ((value - min) / safeSpan(min, max)) * 100;
    return '${p.clamp(0, 100).toStringAsFixed(1)}%';
  }

  Color styleColor(_LabelStyle style) {
    switch (style) {
      case _LabelStyle.plain:
        return const Color(0xFF455A64);
      case _LabelStyle.currency:
        return const Color(0xFF1565C0);
      case _LabelStyle.percent:
        return const Color(0xFF2E7D32);
      case _LabelStyle.duration:
        return const Color(0xFF6A1B9A);
      case _LabelStyle.temperature:
        return const Color(0xFFEF6C00);
      case _LabelStyle.compact:
        return const Color(0xFF006064);
    }
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
              fontSize: 11,
              color: color.withValues(alpha: 0.88),
              fontWeight: FontWeight.w700,
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
      final RangeLabels labels = makeLabels(values, labelStyle);
      final double span = values.end - values.start;
      final double midpoint = (values.start + values.end) / 2;
      final Color accent = styleColor(labelStyle);

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
                    'RangeLabels Interaction Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'RangeLabels powers the visible thumb labels in RangeSlider. '
                    'This deep demo shows formatting strategies, scenario-driven label design, '
                    'and how label text should track numeric values in interactive flows.',
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
                        avatar: const Icon(Icons.label, color: Colors.white),
                        label: Text('start ${labels.start}', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        avatar: const Icon(Icons.label_important, color: Colors.white),
                        label: Text('end ${labels.end}', style: const TextStyle(color: Colors.white)),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        avatar: const Icon(Icons.palette, color: Colors.white),
                        label: Text('style ${styleName(labelStyle)}', style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Label Composer',
              subtitle:
                  'Adjust range values and label style to observe live RangeLabels updates.',
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
                    spacing: 10,
                    runSpacing: 10,
                    children: _LabelStyle.values.map((_LabelStyle style) {
                      final bool selected = style == labelStyle;
                      final Color color = styleColor(style);
                      return ChoiceChip(
                        selectedColor: color.withValues(alpha: 0.18),
                        labelStyle: TextStyle(
                          color: selected ? color : Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                        selected: selected,
                        label: Text(styleName(style)),
                        onSelected: (bool value) {
                          if (!value) {
                            return;
                          }
                          setState(() {
                            labelStyle = style;
                          });
                          addConsole('Label style switched to ${styleName(style)}.');
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Text(styleDescription(labelStyle),
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 10),
                  Text('RangeSlider with RangeLabels',
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w700,
                      )),
                  RangeSlider(
                    min: min,
                    max: max,
                    values: values,
                    divisions: divisions,
                    labels: labels,
                    onChanged: (RangeValues next) {
                      setState(() {
                        values = next;
                      });
                    },
                  ),
                  if (showSecondSlider)
                    RangeSlider(
                      min: min,
                      max: max,
                      values: RangeValues(values.start, values.end),
                      labels: RangeLabels(
                        'S ${labels.start}',
                        'E ${labels.end}',
                      ),
                      onChanged: (RangeValues next) {
                        setState(() {
                          values = next;
                        });
                      },
                    ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilterChip(
                        label: const Text('Segments'),
                        selected: showSegments,
                        onSelected: (bool v) => setState(() => showSegments = v),
                      ),
                      FilterChip(
                        label: const Text('Comparison table'),
                        selected: showComparisonTable,
                        onSelected: (bool v) =>
                            setState(() => showComparisonTable = v),
                      ),
                      FilterChip(
                        label: const Text('Second slider'),
                        selected: showSecondSlider,
                        onSelected: (bool v) => setState(() => showSecondSlider = v),
                      ),
                      FilterChip(
                        label: const Text('Midpoint highlight'),
                        selected: highlightMidpoint,
                        onSelected: (bool v) =>
                            setState(() => highlightMidpoint = v),
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
                          final String detail =
                              'Range ${values.start.toStringAsFixed(1)}..${values.end.toStringAsFixed(1)} -> labels ${labels.start} / ${labels.end}';
                          setState(() {
                            timeline.insert(
                              0,
                              _TraceEntry(
                                title: 'Snapshot',
                                detail: detail,
                                color: accent,
                              ),
                            );
                            if (timeline.length > 30) {
                              timeline.removeLast();
                            }
                          });
                          addConsole(detail);
                        },
                        icon: const Icon(Icons.add_task),
                        label: const Text('Record Snapshot'),
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
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            min = 0;
                            max = 100;
                            divisions = 20;
                            values = const RangeValues(20, 80);
                            labelStyle = _LabelStyle.plain;
                          });
                          addConsole('Composer reset to baseline plain labels.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Baseline'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Current Label Metrics',
              subtitle: 'Computed values and text output produced by RangeLabels.',
              icon: Icons.analytics,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'start value',
                    value: values.start.toStringAsFixed(2),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'end value',
                    value: values.end.toStringAsFixed(2),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'RangeLabels.start',
                    value: labels.start,
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'RangeLabels.end',
                    value: labels.end,
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'span',
                    value: span.toStringAsFixed(2),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'midpoint',
                    value: midpoint.toStringAsFixed(2),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'start in range',
                    value: percentInRange(values.start, min, max),
                    color: accent,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: metricTile(
                    label: 'end in range',
                    value: percentInRange(values.end, min, max),
                    color: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Label Visualization Canvas',
              subtitle: 'Visual track with start/end labels, midpoint markers, and optional segment grid.',
              icon: Icons.insights,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: SizedBox(
                height: 320,
                child: CustomPaint(
                  painter: _RangeLabelsPainter(
                    min: min,
                    max: max,
                    values: values,
                    labels: labels,
                    style: labelStyle,
                    showSegments: showSegments,
                    highlightMidpoint: highlightMidpoint,
                    accent: accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Gallery',
              subtitle: 'Load curated domain use-cases for RangeLabels formatting.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarios.asMap().entries.map((MapEntry<int, _RangeScenario> entry) {
                final int idx = entry.key;
                final _RangeScenario item = entry.value;
                final bool selected = idx == selectedScenario;
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
                              'min ${item.min.toStringAsFixed(0)}, max ${item.max.toStringAsFixed(0)}, values ${item.values.start.toStringAsFixed(0)}-${item.values.end.toStringAsFixed(0)}, style ${styleName(item.style)}',
                              style: TextStyle(
                                color: Colors.blueGrey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            selectedScenario = idx;
                            if (autoSyncScenario) {
                              min = item.min;
                              max = item.max;
                              values = item.values;
                              divisions = item.divisions;
                              labelStyle = item.style;
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
                    'Auto-sync controls when loading scenarios',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            sectionTitle(
              title: 'Cross-Style Comparison Table',
              subtitle: 'Same numeric values rendered with every RangeLabels formatting style.',
              icon: Icons.table_chart,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: showComparisonTable ? Colors.white : Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showComparisonTable
                  ? Column(
                      children: _LabelStyle.values.map((_LabelStyle style) {
                        final RangeLabels row = makeLabels(values, style);
                        final Color color = styleColor(style);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: color.withValues(alpha: 0.08),
                            border: Border.all(color: color.withValues(alpha: 0.30)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 12,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      styleName(style),
                                      style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'start: ${row.start}   end: ${row.end}',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(22),
                      child: Center(
                        child: Text(
                          'Comparison table hidden. Enable it from controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline Replay',
              subtitle: 'Chronological snapshots of generated RangeLabels output.',
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
              child: timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No snapshots yet. Record snapshots from the composer section.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _TraceEntry> entry) {
                        final _TraceEntry row = entry.value;
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
              title: 'RangeLabels Usage Guide',
              subtitle: 'Practical guidance for robust label text generation.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: Column(
                children: guideRows.map((_LabelGuideRow row) {
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
                          row.title,
                          style: TextStyle(
                            color: Colors.blueGrey.shade900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          row.text,
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
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
              title: 'Reference Snippet',
              subtitle: 'Typical pattern for producing and passing dynamic RangeLabels.',
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
                'RangeLabels labelsFor(RangeValues values) {\\n'
                '  return RangeLabels(\\n'
                '    formatValue(values.start),\\n'
                '    formatValue(values.end),\\n'
                '  );\\n'
                '}\\n\\n'
                'RangeSlider(\\n'
                '  values: values,\\n'
                '  labels: labelsFor(values),\\n'
                '  onChanged: (next) => setState(() => values = next),\\n'
                ')',
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
              subtitle: 'Interaction log for scenario and label-state transitions.',
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
                        'No diagnostics yet. Use controls or load scenarios.',
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
                'Summary: This deep demo focuses on RangeLabels as a formatting bridge between numeric range values and user-facing slider text. '
                'It demonstrates multiple formatting strategies, scenario-specific label semantics, and synchronized visuals '
                'that explain how to keep RangeLabels accurate, concise, and meaningful in production interactions.',
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

class _RangeLabelsPainter extends CustomPainter {
  _RangeLabelsPainter({
    required this.min,
    required this.max,
    required this.values,
    required this.labels,
    required this.style,
    required this.showSegments,
    required this.highlightMidpoint,
    required this.accent,
  });

  final double min;
  final double max;
  final RangeValues values;
  final RangeLabels labels;
  final _LabelStyle style;
  final bool showSegments;
  final bool highlightMidpoint;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect surface = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFEAF2FD)],
      ).createShader(surface);
    canvas.drawRRect(
      RRect.fromRectAndRadius(surface, const Radius.circular(12)),
      bg,
    );

    final Rect bar = Rect.fromLTWH(24, size.height * 0.56, size.width - 48, 16);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bar, const Radius.circular(999)),
      Paint()..color = const Color(0xFFCFD8DC),
    );

    if (showSegments) {
      for (int i = 0; i <= 20; i++) {
        final double x = bar.left + bar.width * (i / 20);
        canvas.drawLine(
          Offset(x, bar.top - 10),
          Offset(x, bar.bottom + 10),
          Paint()
            ..strokeWidth = i % 5 == 0 ? 1.6 : 0.8
            ..color = const Color(0x33546E7A),
        );
      }
    }

    final double startP = ((values.start - min) / (max - min)).clamp(0, 1);
    final double endP = ((values.end - min) / (max - min)).clamp(0, 1);
    final double xStart = bar.left + bar.width * startP;
    final double xEnd = bar.left + bar.width * endP;

    final Rect active = Rect.fromLTRB(xStart, bar.top, xEnd, bar.bottom);
    canvas.drawRRect(
      RRect.fromRectAndRadius(active, const Radius.circular(999)),
      Paint()..color = accent.withValues(alpha: 0.84),
    );

    final Paint thumb = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(xStart, bar.center.dy), 12, thumb);
    canvas.drawCircle(Offset(xEnd, bar.center.dy), 12, thumb);
    canvas.drawCircle(
      Offset(xStart, bar.center.dy),
      12,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = accent,
    );
    canvas.drawCircle(
      Offset(xEnd, bar.center.dy),
      12,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = accent,
    );

    if (highlightMidpoint) {
      final double mid = (xStart + xEnd) / 2;
      canvas.drawLine(
        Offset(mid, bar.top - 26),
        Offset(mid, bar.bottom + 26),
        Paint()
          ..strokeWidth = 1.6
          ..color = accent.withValues(alpha: 0.60),
      );
      canvas.drawCircle(
        Offset(mid, bar.center.dy),
        6,
        Paint()..color = accent.withValues(alpha: 0.75),
      );
    }

    void drawBubble(Offset anchor, String text, Alignment align, Color color) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 140);

      final double bubbleW = tp.width + 18;
      final double bubbleH = tp.height + 12;
      final double left = align == Alignment.centerLeft
          ? anchor.dx - bubbleW - 8
          : anchor.dx + 8;
      final Rect rect = Rect.fromLTWH(left, anchor.dy - 64, bubbleW, bubbleH);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()..color = color,
      );
      tp.paint(canvas, Offset(rect.left + 9, rect.top + 6));
      final Path tail = Path();
      if (align == Alignment.centerLeft) {
        tail
          ..moveTo(rect.right, rect.bottom - 10)
          ..lineTo(rect.right + 8, rect.bottom - 4)
          ..lineTo(rect.right, rect.bottom - 2)
          ..close();
      } else {
        tail
          ..moveTo(rect.left, rect.bottom - 10)
          ..lineTo(rect.left - 8, rect.bottom - 4)
          ..lineTo(rect.left, rect.bottom - 2)
          ..close();
      }
      canvas.drawPath(tail, Paint()..color = color);
    }

    drawBubble(
      Offset(xStart, bar.center.dy),
      labels.start,
      Alignment.centerLeft,
      accent.withValues(alpha: 0.90),
    );
    drawBubble(
      Offset(xEnd, bar.center.dy),
      labels.end,
      Alignment.centerRight,
      accent.withValues(alpha: 0.90),
    );

    final TextPainter caption = TextPainter(
      text: TextSpan(
        text:
            'Style: ${style.name}  •  range ${values.start.toStringAsFixed(1)} - ${values.end.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    caption.paint(canvas, const Offset(8, 8));

    final Rect lower = Rect.fromLTWH(14, size.height * 0.12, size.width - 28, 90);
    canvas.drawRRect(
      RRect.fromRectAndRadius(lower, const Radius.circular(10)),
      Paint()..color = accent.withValues(alpha: 0.10),
    );

    final String startPos =
        '${(startP * 100).toStringAsFixed(1)}% of track';
    final String endPos = '${(endP * 100).toStringAsFixed(1)}% of track';
    final String span =
        'Span ${(values.end - values.start).toStringAsFixed(2)} across ${(max - min).toStringAsFixed(1)} total';

    final List<String> info = <String>[
      'start label: ${labels.start} ($startPos)',
      'end label: ${labels.end} ($endPos)',
      span,
    ];

    for (int i = 0; i < info.length; i++) {
      final TextPainter row = TextPainter(
        text: TextSpan(
          text: info[i],
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: lower.width - 16);
      row.paint(canvas, Offset(lower.left + 8, lower.top + 12 + i * 24));
    }
  }

  @override
  bool shouldRepaint(covariant _RangeLabelsPainter oldDelegate) {
    return oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.values != values ||
        oldDelegate.labels != labels ||
        oldDelegate.style != style ||
        oldDelegate.showSegments != showSegments ||
        oldDelegate.highlightMidpoint != highlightMidpoint ||
        oldDelegate.accent != accent;
  }
}
