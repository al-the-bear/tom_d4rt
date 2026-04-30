import 'package:flutter/material.dart';

enum _TickProfile {
  minimal,
  balanced,
  bold,
  contrast,
  accessible,
}

class _TickPreset {
  const _TickPreset({
    required this.profile,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.tickRadius,
    required this.trackHeight,
    required this.defaultDivisions,
    required this.showStrongMilestones,
  });

  final _TickProfile profile;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final double tickRadius;
  final double trackHeight;
  final int defaultDivisions;
  final bool showStrongMilestones;
}

class _TickScenario {
  const _TickScenario({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.profile,
    required this.min,
    required this.max,
    required this.values,
    required this.divisions,
    required this.unit,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final _TickProfile profile;
  final double min;
  final double max;
  final RangeValues values;
  final int divisions;
  final String unit;
}

class _TickGuideRow {
  const _TickGuideRow({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class _TickSnapshot {
  const _TickSnapshot({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _QuickMetric {
  const _QuickMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

dynamic build(BuildContext context) {
  final DateTime startTime = DateTime.now();

  final List<_TickPreset> presets = <_TickPreset>[
    const _TickPreset(
      profile: _TickProfile.minimal,
      title: 'Minimal Grid',
      description:
          'Low-emphasis tick marks suitable for data-dense dashboards with subtle guides.',
      icon: Icons.drag_handle,
      color: Color(0xFF546E7A),
      tickRadius: 1.2,
      trackHeight: 3,
      defaultDivisions: 20,
      showStrongMilestones: false,
    ),
    const _TickPreset(
      profile: _TickProfile.balanced,
      title: 'Balanced Grid',
      description:
          'General-purpose tick mark treatment for common product range selection controls.',
      icon: Icons.tune,
      color: Color(0xFF1565C0),
      tickRadius: 2.0,
      trackHeight: 4,
      defaultDivisions: 24,
      showStrongMilestones: true,
    ),
    const _TickPreset(
      profile: _TickProfile.bold,
      title: 'Bold Steps',
      description:
          'High-visibility ticks for confident stepping in strongly segmented interfaces.',
      icon: Icons.grid_4x4,
      color: Color(0xFF6A1B9A),
      tickRadius: 3.3,
      trackHeight: 5.5,
      defaultDivisions: 16,
      showStrongMilestones: true,
    ),
    const _TickPreset(
      profile: _TickProfile.contrast,
      title: 'Contrast Markers',
      description:
          'High-contrast ticks for dark backgrounds and low-luminance viewing conditions.',
      icon: Icons.contrast,
      color: Color(0xFFEF6C00),
      tickRadius: 2.6,
      trackHeight: 4.6,
      defaultDivisions: 18,
      showStrongMilestones: true,
    ),
    const _TickPreset(
      profile: _TickProfile.accessible,
      title: 'Accessible Ladder',
      description:
          'Large and legible ticks for interfaces prioritizing assistive readability.',
      icon: Icons.accessibility,
      color: Color(0xFF2E7D32),
      tickRadius: 3.9,
      trackHeight: 6,
      defaultDivisions: 12,
      showStrongMilestones: true,
    ),
  ];

  final List<_TickScenario> scenarios = <_TickScenario>[
    const _TickScenario(
      title: 'Budget Ladder',
      subtitle:
          'Price intervals where each tick corresponds to a clear purchasing band.',
      icon: Icons.account_balance_wallet,
      profile: _TickProfile.balanced,
      min: 0,
      max: 3000,
      values: RangeValues(600, 2200),
      divisions: 30,
      unit: '\$ ',
    ),
    const _TickScenario(
      title: 'Focus Blocks',
      subtitle:
          'Discrete hour chunks for planning deep-work windows with fixed increments.',
      icon: Icons.calendar_view_day,
      profile: _TickProfile.minimal,
      min: 0,
      max: 12,
      values: RangeValues(2, 9),
      divisions: 24,
      unit: 'h',
    ),
    const _TickScenario(
      title: 'Quality Thresholds',
      subtitle:
          'Stepped acceptance ranges where each tick marks a quality checkpoint.',
      icon: Icons.verified,
      profile: _TickProfile.bold,
      min: 0,
      max: 100,
      values: RangeValues(45, 82),
      divisions: 20,
      unit: '%',
    ),
    const _TickScenario(
      title: 'Night Lighting Band',
      subtitle:
          'Contrast-oriented step markers for low-light adjustment controls.',
      icon: Icons.nightlight_round,
      profile: _TickProfile.contrast,
      min: 0,
      max: 100,
      values: RangeValues(18, 56),
      divisions: 20,
      unit: '%',
    ),
    const _TickScenario(
      title: 'Comfort Zone Tuning',
      subtitle:
          'Accessible tick spacing for thermostat and ambient comfort setup.',
      icon: Icons.thermostat,
      profile: _TickProfile.accessible,
      min: 16,
      max: 32,
      values: RangeValues(20, 26),
      divisions: 16,
      unit: ' C',
    ),
  ];

  final List<_TickGuideRow> guideRows = <_TickGuideRow>[
    const _TickGuideRow(
      title: 'Tick mark purpose',
      body:
          'RangeSliderTickMarkShape communicates discrete stepping. It helps users align thumbs to meaningful increments.',
    ),
    const _TickGuideRow(
      title: 'Discrete-only visibility',
      body:
          'Tick marks appear when divisions are provided. For continuous ranges, remove or soften tick emphasis.',
    ),
    const _TickGuideRow(
      title: 'Radius selection',
      body:
          'Use small radius in dense layouts and larger radius when readability and target confirmation are primary goals.',
    ),
    const _TickGuideRow(
      title: 'Milestone hierarchy',
      body:
          'Consider stronger milestone ticks every N steps to create visual rhythm without crowding the track.',
    ),
    const _TickGuideRow(
      title: 'Track harmony',
      body:
          'Tick radius should match track thickness and thumb scale for a consistent interaction language.',
    ),
    const _TickGuideRow(
      title: 'Color strategy',
      body:
          'Use enough contrast for active and inactive ticks while preserving the visual hierarchy of thumbs and labels.',
    ),
    const _TickGuideRow(
      title: 'Accessibility note',
      body:
          'For assistive contexts, pair stronger tick marks with larger thumbs and clearer value indicators.',
    ),
  ];

  final List<String> console = <String>[];
  final List<_TickSnapshot> timeline = <_TickSnapshot>[];

  _TickProfile selectedProfile = _TickProfile.balanced;
  int selectedScenario = 0;

  double min = 0;
  double max = 100;
  RangeValues values = const RangeValues(20, 74);
  int divisions = 20;

  bool enabled = true;
  bool showSecondaryRail = true;
  bool showComparison = true;
  bool showPainter = true;
  bool showGuide = true;
  bool showTimeline = true;
  bool showMilestoneHints = true;
  bool autoApplyScenario = true;

  _TickPreset presetFor(_TickProfile profile) {
    return presets.firstWhere((
      _TickPreset p,
    ) => p.profile == profile, orElse: () => presets.first);
  }

  String twoDigits(int value) => value.toString().padLeft(2, '0');

  String elapsed() {
    final Duration d = DateTime.now().difference(startTime);
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}';
  }

  void addLog(String message) {
    console.insert(0, '[${elapsed()}] $message');
    if (console.length > 36) {
      console.removeLast();
    }
  }

  String formatValue(double value, String unit) {
    if (unit.contains('\$')) {
      return '\$${value.toStringAsFixed(0)}';
    }
    if (unit.trim() == '%') {
      return '${value.toStringAsFixed(0)}%';
    }
    if (unit.trim() == 'h') {
      return '${value.toStringAsFixed(1)}h';
    }
    return '${value.toStringAsFixed(1)}$unit';
  }

  double normalized(double value, double min, double max) {
    final double span = (max - min).abs();
    if (span < 1e-9) {
      return 0;
    }
    return ((value - min) / span).clamp(0, 1);
  }

  SliderThemeData makeTheme(BuildContext context, _TickPreset preset, bool enabled) {
    final Color active = preset.color;
    final Color inactive = preset.color.withValues(alpha: 0.28);
    final Color disabledColor = Colors.blueGrey.shade300;

    return SliderTheme.of(context).copyWith(
      rangeTickMarkShape: RoundRangeSliderTickMarkShape(
        tickMarkRadius: preset.tickRadius,
      ),
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      rangeThumbShape: RoundRangeSliderThumbShape(
        enabledThumbRadius: preset.profile == _TickProfile.accessible ? 13 : 10,
        disabledThumbRadius: preset.profile == _TickProfile.accessible ? 10 : 8,
        elevation: preset.profile == _TickProfile.bold ? 2.2 : 1,
        pressedElevation: preset.profile == _TickProfile.bold ? 6 : 3,
      ),
      trackHeight: preset.trackHeight,
      activeTrackColor: enabled ? active : disabledColor,
      inactiveTrackColor: enabled ? inactive : disabledColor.withValues(alpha: 0.5),
      activeTickMarkColor: enabled
          ? active.withValues(alpha: 0.88)
          : disabledColor.withValues(alpha: 0.7),
      inactiveTickMarkColor: enabled
          ? active.withValues(alpha: 0.35)
          : disabledColor.withValues(alpha: 0.45),
      thumbColor: enabled ? active : disabledColor,
      overlayColor: active.withValues(alpha: 0.16),
      showValueIndicator: ShowValueIndicator.onDrag,
      rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
      valueIndicatorColor: active,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
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
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
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

  Widget metricTile(_QuickMetric metric) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: metric.color.withValues(alpha: 0.08),
        border: Border.all(color: metric.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            metric.label,
            style: TextStyle(
              color: metric.color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(metric.value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final _TickPreset selected = presetFor(selectedProfile);
      final String unit = scenarios[selectedScenario].unit;
      final double span = values.end - values.start;
      final double midpoint = (values.start + values.end) / 2;
      final double startNorm = normalized(values.start, min, max);
      final double endNorm = normalized(values.end, min, max);

      final List<_QuickMetric> metrics = <_QuickMetric>[
        _QuickMetric(
          label: 'tick radius',
          value: selected.tickRadius.toStringAsFixed(1),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'divisions',
          value: divisions.toString(),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'track height',
          value: selected.trackHeight.toStringAsFixed(1),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'start',
          value: formatValue(values.start, unit),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'end',
          value: formatValue(values.end, unit),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'span',
          value: formatValue(span, unit),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'midpoint',
          value: formatValue(midpoint, unit),
          color: selected.color,
        ),
        _QuickMetric(
          label: 'start norm',
          value: '${(startNorm * 100).toStringAsFixed(1)}%',
          color: selected.color,
        ),
        _QuickMetric(
          label: 'end norm',
          value: '${(endNorm * 100).toStringAsFixed(1)}%',
          color: selected.color,
        ),
      ];

      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF071B3B), Color(0xFF1D4E89)],
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
                    'RangeSliderTickMarkShape Lab',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This deep demo explores how tick mark shape controls discrete stepping clarity. '
                    'It demonstrates radius tuning, milestone emphasis, and multi-scenario range interactions '
                    'to help you design readable and meaningful stepped sliders.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.34,
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
                        avatar: const Icon(Icons.timeline, color: Colors.white),
                        label: Text(
                          'divisions $divisions',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.grain, color: Colors.white),
                        label: Text(
                          'tick ${selected.tickRadius.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.swap_horiz, color: Colors.white),
                        label: Text(
                          '${formatValue(values.start, unit)} - ${formatValue(values.end, unit)}',
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
              title: 'Tick Profile Composer',
              subtitle:
                  'Switch tick mark presets and inspect discrete step readability in real time.',
              icon: Icons.palette,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: presets.map((_TickPreset preset) {
                      final bool selectedChip = preset.profile == selectedProfile;
                      return ChoiceChip(
                        selected: selectedChip,
                        selectedColor: preset.color.withValues(alpha: 0.2),
                        avatar: Icon(
                          preset.icon,
                          size: 18,
                          color: selectedChip ? preset.color : Colors.blueGrey.shade600,
                        ),
                        labelStyle: TextStyle(
                          color: selectedChip ? preset.color : Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                        label: Text(preset.title),
                        onSelected: (bool value) {
                          if (!value) {
                            return;
                          }
                          setState(() {
                            selectedProfile = preset.profile;
                            divisions = preset.defaultDivisions;
                            showMilestoneHints = preset.showStrongMilestones;
                          });
                          addLog('Selected tick profile ${preset.title}.');
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selected.description,
                    style: TextStyle(
                      color: selected.color,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SliderTheme(
                    data: makeTheme(context, selected, enabled),
                    child: RangeSlider(
                      min: min,
                      max: max,
                      divisions: divisions,
                      values: values,
                      labels: RangeLabels(
                        formatValue(values.start, unit),
                        formatValue(values.end, unit),
                      ),
                      onChanged: !enabled
                          ? null
                          : (RangeValues next) {
                              setState(() {
                                values = next;
                              });
                            },
                    ),
                  ),
                  if (showSecondaryRail)
                    SliderTheme(
                      data: makeTheme(context, selected, enabled).copyWith(
                        trackHeight: selected.trackHeight + 2,
                        rangeTickMarkShape: RoundRangeSliderTickMarkShape(
                          tickMarkRadius: selected.tickRadius + 0.9,
                        ),
                      ),
                      child: RangeSlider(
                        min: min,
                        max: max,
                        divisions: divisions,
                        values: RangeValues(values.start, values.end),
                        labels: RangeLabels(
                          'S ${formatValue(values.start, unit)}',
                          'E ${formatValue(values.end, unit)}',
                        ),
                        onChanged: !enabled
                            ? null
                            : (RangeValues next) {
                                setState(() {
                                  values = next;
                                });
                              },
                      ),
                    ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilterChip(
                        label: const Text('Enabled state'),
                        selected: enabled,
                        onSelected: (bool value) {
                          setState(() {
                            enabled = value;
                          });
                          addLog('Enabled switched to ${value ? 'true' : 'false'}.');
                        },
                      ),
                      FilterChip(
                        label: const Text('Secondary rail'),
                        selected: showSecondaryRail,
                        onSelected: (bool value) {
                          setState(() {
                            showSecondaryRail = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Comparison matrix'),
                        selected: showComparison,
                        onSelected: (bool value) {
                          setState(() {
                            showComparison = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Painter diagnostics'),
                        selected: showPainter,
                        onSelected: (bool value) {
                          setState(() {
                            showPainter = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Guide'),
                        selected: showGuide,
                        onSelected: (bool value) {
                          setState(() {
                            showGuide = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Timeline'),
                        selected: showTimeline,
                        onSelected: (bool value) {
                          setState(() {
                            showTimeline = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Milestone hints'),
                        selected: showMilestoneHints,
                        onSelected: (bool value) {
                          setState(() {
                            showMilestoneHints = value;
                          });
                        },
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
                          setState(() {
                            timeline.insert(
                              0,
                              _TickSnapshot(
                                title: 'Snapshot (${selected.title})',
                                detail:
                                    'Range ${formatValue(values.start, unit)} -> ${formatValue(values.end, unit)}, divisions $divisions, tick ${selected.tickRadius.toStringAsFixed(1)}',
                                color: selected.color,
                              ),
                            );
                            if (timeline.length > 30) {
                              timeline.removeLast();
                            }
                          });
                          addLog('Captured snapshot for ${selected.title}.');
                        },
                        icon: const Icon(Icons.add_task),
                        label: const Text('Capture Snapshot'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedProfile = _TickProfile.balanced;
                            min = 0;
                            max = 100;
                            values = const RangeValues(20, 74);
                            divisions = 20;
                            selectedScenario = 0;
                            enabled = true;
                            showMilestoneHints = true;
                          });
                          addLog('Reset studio to baseline profile.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Baseline'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            timeline.clear();
                          });
                          addLog('Cleared timeline snapshots.');
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
              title: 'Tick Metrics Dashboard',
              subtitle: 'Quantitative view of division density, span, and tick geometry.',
              icon: Icons.dashboard,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: metrics
                  .map(
                    (_QuickMetric m) => SizedBox(
                      width: 220,
                      child: metricTile(m),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Gallery',
              subtitle:
                  'Load domain scenarios to validate whether tick treatment matches user intent.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarios.asMap().entries.map((MapEntry<int, _TickScenario> entry) {
                final int index = entry.key;
                final _TickScenario scenario = entry.value;
                final _TickPreset scenarioPreset = presetFor(scenario.profile);
                final bool active = index == selectedScenario;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: active
                        ? scenarioPreset.color.withValues(alpha: 0.14)
                        : scenarioPreset.color.withValues(alpha: 0.07),
                    border: Border.all(
                      color: active
                          ? scenarioPreset.color.withValues(alpha: 0.45)
                          : scenarioPreset.color.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scenarioPreset.color.withValues(alpha: 0.22),
                        ),
                        child: Icon(scenario.icon, color: scenarioPreset.color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              scenario.title,
                              style: TextStyle(
                                color: scenarioPreset.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scenario.subtitle,
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Profile ${scenarioPreset.title} • min ${scenario.min.toStringAsFixed(0)} • max ${scenario.max.toStringAsFixed(0)} • divisions ${scenario.divisions}',
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
                            selectedScenario = index;
                            if (autoApplyScenario) {
                              selectedProfile = scenario.profile;
                              min = scenario.min;
                              max = scenario.max;
                              values = scenario.values;
                              divisions = scenario.divisions;
                            }
                          });
                          addLog('Loaded scenario ${scenario.title}.');
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
                  value: autoApplyScenario,
                  onChanged: (bool? value) {
                    setState(() {
                      autoApplyScenario = value ?? true;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Auto-apply profile and numeric bounds when loading scenarios',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Tick Profile Comparison Matrix',
              subtitle:
                  'Same range values rendered through all tick mark profiles for side-by-side inspection.',
              icon: Icons.grid_view,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: showComparison ? Colors.white : Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showComparison
                  ? Column(
                      children: presets.map((_TickPreset preset) {
                        final bool highlight = preset.profile == selectedProfile;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: preset.color.withValues(alpha: highlight ? 0.16 : 0.08),
                            border: Border.all(
                              color: preset.color.withValues(alpha: highlight ? 0.45 : 0.25),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 12,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      color: preset.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${preset.title} • tick ${preset.tickRadius.toStringAsFixed(1)} • track ${preset.trackHeight.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        color: preset.color,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: makeTheme(context, preset, enabled),
                                child: RangeSlider(
                                  min: min,
                                  max: max,
                                  divisions: divisions,
                                  values: values,
                                  labels: RangeLabels(
                                    formatValue(values.start, unit),
                                    formatValue(values.end, unit),
                                  ),
                                  onChanged: !enabled
                                      ? null
                                      : (RangeValues next) {
                                          setState(() {
                                            values = next;
                                          });
                                        },
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
                          'Comparison matrix hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Tick Geometry Diagnostics',
              subtitle:
                  'Custom painter showing active span, major milestones, and tick density behavior.',
              icon: Icons.auto_awesome_motion,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showPainter
                  ? SizedBox(
                      height: 340,
                      child: CustomPaint(
                        painter: _TickDiagnosticsPainter(
                          preset: selected,
                          startNorm: startNorm,
                          endNorm: endNorm,
                          startLabel: formatValue(values.start, unit),
                          endLabel: formatValue(values.end, unit),
                          spanLabel: formatValue(span, unit),
                          divisions: divisions,
                          enabled: enabled,
                          showMilestones: showMilestoneHints,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'Painter diagnostics hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline Replay',
              subtitle: 'Captured snapshots of tick profile and range states.',
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
              child: !showTimeline
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Timeline hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'No snapshots yet. Capture snapshots to inspect profile evolution.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _TickSnapshot> entry) {
                        final _TickSnapshot row = entry.value;
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
                                    Text(
                                      row.title,
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                    ),
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
              title: 'RangeSliderTickMarkShape Guide',
              subtitle: 'Practical recommendations for designing stepped range interactions.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: !showGuide
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Guide hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: guideRows.map((_TickGuideRow row) {
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
                                row.body,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  height: 1.33,
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
              title: 'Reference Pattern',
              subtitle: 'Canonical SliderTheme usage for custom RangeSliderTickMarkShape behavior.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B132B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'final sliderTheme = SliderTheme.of(context).copyWith(\n'
                '  rangeTickMarkShape: RoundRangeSliderTickMarkShape(\n'
                '    tickMarkRadius: 2.5,\n'
                '  ),\n'
                '  rangeThumbShape: RoundRangeSliderThumbShape(),\n'
                '  showValueIndicator: ShowValueIndicator.onDrag,\n'
                ');\n\n'
                'SliderTheme(\n'
                '  data: sliderTheme,\n'
                '  child: RangeSlider(\n'
                '    divisions: 20,\n'
                '    values: values,\n'
                '    onChanged: (next) => setState(() => values = next),\n'
                '  ),\n'
                ')',
                style: TextStyle(
                  color: Color(0xFFD5E7FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle: 'Session log of profile changes, scenario loads, and state operations.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
              ),
              child: console.isEmpty
                  ? const Center(
                      child: Text(
                        'No diagnostics yet. Interact with profile controls and scenario loads.',
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
                'Summary: this demo frames RangeSliderTickMarkShape as a discrete interaction readability tool. '
                'By tuning tick radius, track relationship, and milestone emphasis across practical scenarios, '
                'it demonstrates how to design stepped ranges that are visually clear, instructional, and touch-friendly.',
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

class _TickDiagnosticsPainter extends CustomPainter {
  _TickDiagnosticsPainter({
    required this.preset,
    required this.startNorm,
    required this.endNorm,
    required this.startLabel,
    required this.endLabel,
    required this.spanLabel,
    required this.divisions,
    required this.enabled,
    required this.showMilestones,
  });

  final _TickPreset preset;
  final double startNorm;
  final double endNorm;
  final String startLabel;
  final String endLabel;
  final String spanLabel;
  final int divisions;
  final bool enabled;
  final bool showMilestones;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    final Paint background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFEAF2FD)],
      ).createShader(area);
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      background,
    );

    final Rect track = Rect.fromLTWH(24, size.height * 0.62, size.width - 48, 16);
    canvas.drawRRect(
      RRect.fromRectAndRadius(track, const Radius.circular(999)),
      Paint()..color = const Color(0xFFCFD8DC),
    );

    final int safeDivisions = divisions <= 0 ? 1 : divisions;

    for (int i = 0; i <= safeDivisions; i++) {
      final double x = track.left + (track.width * (i / safeDivisions));
      final bool milestone = showMilestones && (safeDivisions >= 4) && (i % (safeDivisions ~/ 4 == 0 ? 1 : safeDivisions ~/ 4) == 0);
      final double radius = milestone ? preset.tickRadius + 1.2 : preset.tickRadius;
      final Color color = milestone
          ? preset.color.withValues(alpha: enabled ? 0.88 : 0.5)
          : preset.color.withValues(alpha: enabled ? 0.44 : 0.24);
      canvas.drawCircle(Offset(x, track.center.dy), radius, Paint()..color = color);
    }

    final double sx = track.left + (track.width * startNorm);
    final double ex = track.left + (track.width * endNorm);
    final Rect active = Rect.fromLTRB(sx, track.top, ex, track.bottom);
    canvas.drawRRect(
      RRect.fromRectAndRadius(active, const Radius.circular(999)),
      Paint()..color = preset.color.withValues(alpha: enabled ? 0.85 : 0.42),
    );

    canvas.drawCircle(
      Offset(sx, track.center.dy),
      11,
      Paint()..color = enabled ? Colors.white : Colors.blueGrey.shade200,
    );
    canvas.drawCircle(
      Offset(ex, track.center.dy),
      11,
      Paint()..color = enabled ? Colors.white : Colors.blueGrey.shade200,
    );
    canvas.drawCircle(
      Offset(sx, track.center.dy),
      11,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = preset.color,
    );
    canvas.drawCircle(
      Offset(ex, track.center.dy),
      11,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = preset.color,
    );

    void drawBubble(Offset anchor, String text, bool left) {
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
      )..layout(maxWidth: 130);

      final double width = tp.width + 16;
      final double height = tp.height + 10;
      final double x = left ? anchor.dx - width - 8 : anchor.dx + 8;
      final Rect rect = Rect.fromLTWH(x, anchor.dy - 62, width, height);

      final Paint paint = Paint()..color = preset.color.withValues(alpha: 0.92);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(10)), paint);

      final Path tail = Path();
      if (left) {
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
      canvas.drawPath(tail, paint);
      tp.paint(canvas, Offset(rect.left + 8, rect.top + 5));
    }

    drawBubble(Offset(sx, track.center.dy), startLabel, true);
    drawBubble(Offset(ex, track.center.dy), endLabel, false);

    final TextPainter headline = TextPainter(
      text: TextSpan(
        text:
            '${preset.title} • divisions $divisions • tick ${preset.tickRadius.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    headline.paint(canvas, const Offset(8, 8));

    final Rect info = Rect.fromLTWH(14, size.height * 0.14, size.width - 28, 102);
    canvas.drawRRect(
      RRect.fromRectAndRadius(info, const Radius.circular(10)),
      Paint()..color = preset.color.withValues(alpha: 0.10),
    );

    final List<String> rows = <String>[
      'active span: $spanLabel',
      'normalized start ${(startNorm * 100).toStringAsFixed(1)}%, end ${(endNorm * 100).toStringAsFixed(1)}%',
      'milestone hints: ${showMilestones ? 'enabled' : 'disabled'}',
      'state: ${enabled ? 'enabled' : 'disabled'}',
    ];

    for (int i = 0; i < rows.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: rows[i],
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: info.width - 16);
      tp.paint(canvas, Offset(info.left + 8, info.top + 10 + i * 22));
    }
  }

  @override
  bool shouldRepaint(covariant _TickDiagnosticsPainter oldDelegate) {
    return oldDelegate.preset != preset ||
        oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.spanLabel != spanLabel ||
        oldDelegate.divisions != divisions ||
        oldDelegate.enabled != enabled ||
        oldDelegate.showMilestones != showMilestones;
  }
}
