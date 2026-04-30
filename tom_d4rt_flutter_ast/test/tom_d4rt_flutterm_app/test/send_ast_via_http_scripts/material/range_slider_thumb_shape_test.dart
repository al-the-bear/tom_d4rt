import 'package:flutter/material.dart';

enum _ThumbProfile {
  compact,
  balanced,
  elevated,
  accessible,
  contrast,
}

class _ThumbPreset {
  const _ThumbPreset({
    required this.profile,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.baseColor,
    required this.radius,
    required this.disabledRadius,
    required this.elevation,
    required this.pressedElevation,
    required this.isDiscrete,
  });

  final _ThumbProfile profile;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color baseColor;
  final double radius;
  final double disabledRadius;
  final double elevation;
  final double pressedElevation;
  final bool isDiscrete;
}

class _UseCaseScenario {
  const _UseCaseScenario({
    required this.title,
    required this.description,
    required this.icon,
    required this.profile,
    required this.min,
    required this.max,
    required this.values,
    required this.divisions,
    required this.unit,
  });

  final String title;
  final String description;
  final IconData icon;
  final _ThumbProfile profile;
  final double min;
  final double max;
  final RangeValues values;
  final int? divisions;
  final String unit;
}

class _ThumbSnapshot {
  const _ThumbSnapshot({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _GuideRow {
  const _GuideRow({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();

  final List<_ThumbPreset> presets = <_ThumbPreset>[
    const _ThumbPreset(
      profile: _ThumbProfile.compact,
      title: 'Compact Precision',
      subtitle: 'Small thumb footprint for dense dashboards and analytics rails.',
      icon: Icons.fit_screen,
      baseColor: Color(0xFF455A64),
      radius: 7,
      disabledRadius: 5,
      elevation: 0.4,
      pressedElevation: 1.2,
      isDiscrete: true,
    ),
    const _ThumbPreset(
      profile: _ThumbProfile.balanced,
      title: 'Balanced Default',
      subtitle: 'General-purpose thumb profile for most material controls.',
      icon: Icons.tune,
      baseColor: Color(0xFF1565C0),
      radius: 10,
      disabledRadius: 8,
      elevation: 1,
      pressedElevation: 3,
      isDiscrete: true,
    ),
    const _ThumbPreset(
      profile: _ThumbProfile.elevated,
      title: 'Elevated Focus',
      subtitle: 'Higher lift and depth to emphasize direct-manipulation interactions.',
      icon: Icons.layers,
      baseColor: Color(0xFF7B1FA2),
      radius: 12,
      disabledRadius: 9,
      elevation: 3,
      pressedElevation: 8,
      isDiscrete: false,
    ),
    const _ThumbPreset(
      profile: _ThumbProfile.accessible,
      title: 'Accessible Reach',
      subtitle: 'Large touch target profile for accessibility-first interfaces.',
      icon: Icons.accessible,
      baseColor: Color(0xFF2E7D32),
      radius: 15,
      disabledRadius: 12,
      elevation: 2,
      pressedElevation: 5,
      isDiscrete: true,
    ),
    const _ThumbPreset(
      profile: _ThumbProfile.contrast,
      title: 'High Contrast',
      subtitle: 'Strong visual contrast for low-light and projection contexts.',
      icon: Icons.contrast,
      baseColor: Color(0xFFEF6C00),
      radius: 11,
      disabledRadius: 8,
      elevation: 1.5,
      pressedElevation: 4,
      isDiscrete: false,
    ),
  ];

  final List<_UseCaseScenario> scenarios = <_UseCaseScenario>[
    const _UseCaseScenario(
      title: 'Budget Corridor',
      description: 'Price planning with deliberate compact thumbs for dense controls.',
      icon: Icons.account_balance_wallet,
      profile: _ThumbProfile.compact,
      min: 0,
      max: 2500,
      values: RangeValues(320, 1680),
      divisions: 50,
      unit: '4',
    ),
    const _UseCaseScenario(
      title: 'Focus Window',
      description: 'Balanced profile for broad productivity zones.',
      icon: Icons.calendar_view_day,
      profile: _ThumbProfile.balanced,
      min: 0,
      max: 12,
      values: RangeValues(2, 8.5),
      divisions: 24,
      unit: 'h',
    ),
    const _UseCaseScenario(
      title: 'Creative Intensity',
      description: 'Elevated thumb treatment for highly interactive creative controls.',
      icon: Icons.brush,
      profile: _ThumbProfile.elevated,
      min: 0,
      max: 100,
      values: RangeValues(24, 77),
      divisions: null,
      unit: '%',
    ),
    const _UseCaseScenario(
      title: 'Comfort Band',
      description: 'Accessibility radius profile for thermostat and control panels.',
      icon: Icons.thermostat,
      profile: _ThumbProfile.accessible,
      min: 15,
      max: 34,
      values: RangeValues(21, 27),
      divisions: 19,
      unit: ' C',
    ),
    const _UseCaseScenario(
      title: 'Night Shift Contrast',
      description: 'High-contrast thumb profile for reduced-luminance environments.',
      icon: Icons.nightlight_round,
      profile: _ThumbProfile.contrast,
      min: 0,
      max: 100,
      values: RangeValues(30, 68),
      divisions: 20,
      unit: '%',
    ),
  ];

  final List<_GuideRow> guideRows = <_GuideRow>[
    const _GuideRow(
      title: 'Thumb shape role',
      body:
          'RangeSliderThumbShape controls geometry and interaction feedback for each thumb. It strongly impacts perceived precision and touch confidence.',
    ),
    const _GuideRow(
      title: 'Radius choices',
      body:
          'Smaller radii fit dense dashboards; larger radii improve targetability and confidence in touch-first contexts.',
    ),
    const _GuideRow(
      title: 'Elevation behavior',
      body:
          'Pressed elevation should communicate active drag state without becoming visually noisy or overpowering content.',
    ),
    const _GuideRow(
      title: 'Disabled state',
      body:
          'Provide a reduced disabled radius and subdued palette so users can distinguish inactive controls immediately.',
    ),
    const _GuideRow(
      title: 'Discrete and continuous',
      body:
          'In discrete sliders, thumb shape should support precise stepping. In continuous sliders, smooth movement feedback matters more.',
    ),
    const _GuideRow(
      title: 'Theme consistency',
      body:
          'Thumb shape should be harmonized with track height, value indicator style, and color hierarchy.',
    ),
    const _GuideRow(
      title: 'When to customize',
      body:
          'Customize thumb shape when your product needs clear mode signaling, accessibility emphasis, or branded interaction style.',
    ),
  ];

  final List<String> diagnostics = <String>[];
  final List<_ThumbSnapshot> timeline = <_ThumbSnapshot>[];

  _ThumbProfile selectedProfile = _ThumbProfile.balanced;
  int selectedScenario = 0;

  double min = 0;
  double max = 100;
  RangeValues values = const RangeValues(20, 74);
  int? divisions = 20;

  bool enableSecondaryRail = true;
  bool showComparisonGrid = true;
  bool showCrossSection = true;
  bool showTimeline = true;
  bool showGuide = true;
  bool autoApplyScenario = true;
  bool enabled = true;

  _ThumbPreset presetFor(_ThumbProfile profile) {
    return presets.firstWhere((
      _ThumbPreset p,
    ) => p.profile == profile, orElse: () => presets.first);
  }

  String twoDigits(int v) => v.toString().padLeft(2, '0');

  String elapsedStamp() {
    final Duration d = DateTime.now().difference(sessionStart);
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}';
  }

  void log(String line) {
    diagnostics.insert(0, '[${elapsedStamp()}] $line');
    if (diagnostics.length > 36) {
      diagnostics.removeLast();
    }
  }

  String formatRange(double value, String unit) {
    if (unit.contains('4')) {
      return '4{value.toStringAsFixed(0)}';
    }
    if (unit.trim() == '%') {
      return '${value.toStringAsFixed(0)}%';
    }
    if (unit.trim() == 'h') {
      return '${value.toStringAsFixed(1)}h';
    }
    return '${value.toStringAsFixed(1)}$unit';
  }

  String spanLabel(RangeValues current, String unit) {
    return formatRange(current.end - current.start, unit);
  }

  double normalized(double value, double min, double max) {
    final double span = (max - min).abs();
    if (span < 1e-9) {
      return 0;
    }
    return ((value - min) / span).clamp(0, 1);
  }

  SliderThemeData themed(
    BuildContext context,
    _ThumbPreset preset,
    bool enabled,
  ) {
    final Color active = preset.baseColor;
    final Color inactive = preset.baseColor.withValues(alpha: 0.25);
    final Color disabledColor = Colors.blueGrey.shade300;

    return SliderTheme.of(context).copyWith(
      rangeThumbShape: RoundRangeSliderThumbShape(
        enabledThumbRadius: preset.radius,
        disabledThumbRadius: preset.disabledRadius,
        elevation: preset.elevation,
        pressedElevation: preset.pressedElevation,
      ),
      trackHeight: preset.profile == _ThumbProfile.compact ? 3.5 : 4.8,
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      showValueIndicator: ShowValueIndicator.onDrag,
      rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
      activeTrackColor: enabled ? active : disabledColor,
      inactiveTrackColor: enabled ? inactive : disabledColor.withValues(alpha: 0.5),
      thumbColor: enabled ? active : disabledColor,
      overlayColor: active.withValues(alpha: 0.16),
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
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
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
      final _ThumbPreset selected = presetFor(selectedProfile);
      final String unit = scenarios[selectedScenario].unit;
      final double midpoint = (values.start + values.end) / 2;
      final double startNorm = normalized(values.start, min, max);
      final double endNorm = normalized(values.end, min, max);

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
                  colors: <Color>[Color(0xFF0A1F44), Color(0xFF1B4F93)],
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
                    'RangeSliderThumbShape Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This deep demo focuses on thumb geometry and interaction feedback. '
                    'It shows how radius, elevation, and pressed states influence precision, '
                    'touch confidence, and visual hierarchy across practical product scenarios.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.90),
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
                        avatar: const Icon(Icons.circle, color: Colors.white),
                        label: Text(
                          'radius ${selected.radius.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.vertical_align_top, color: Colors.white),
                        label: Text(
                          'elevation ${selected.elevation.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.touch_app, color: Colors.white),
                        label: Text(
                          'pressed ${selected.pressedElevation.toStringAsFixed(1)}',
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
              title: 'Thumb Profile Composer',
              subtitle:
                  'Switch profiles and observe how RangeSliderThumbShape parameters transform interaction feel.',
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
                    children: presets.map((_ThumbPreset preset) {
                      final bool chosen = preset.profile == selectedProfile;
                      return ChoiceChip(
                        selected: chosen,
                        selectedColor: preset.baseColor.withValues(alpha: 0.2),
                        labelStyle: TextStyle(
                          color: chosen ? preset.baseColor : Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                        avatar: Icon(
                          preset.icon,
                          size: 18,
                          color: chosen ? preset.baseColor : Colors.blueGrey.shade600,
                        ),
                        label: Text(preset.title),
                        onSelected: (bool value) {
                          if (!value) {
                            return;
                          }
                          setState(() {
                            selectedProfile = preset.profile;
                            divisions = preset.isDiscrete ? (divisions ?? 20) : null;
                          });
                          log('Selected profile ${preset.title}.');
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    selected.subtitle,
                    style: TextStyle(
                      color: selected.baseColor,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: themed(context, selected, enabled),
                    child: RangeSlider(
                      min: min,
                      max: max,
                      divisions: selected.isDiscrete ? divisions : null,
                      values: values,
                      labels: RangeLabels(
                        formatRange(values.start, unit),
                        formatRange(values.end, unit),
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
                  if (enableSecondaryRail)
                    SliderTheme(
                      data: themed(context, selected, enabled).copyWith(
                        trackHeight: 8,
                        rangeThumbShape: RoundRangeSliderThumbShape(
                          enabledThumbRadius: selected.radius + 1.5,
                          disabledThumbRadius: selected.disabledRadius + 1,
                          elevation: selected.elevation + 0.6,
                          pressedElevation: selected.pressedElevation + 1.4,
                        ),
                      ),
                      child: RangeSlider(
                        min: min,
                        max: max,
                        values: RangeValues(values.start, values.end),
                        labels: RangeLabels(
                          'S ${formatRange(values.start, unit)}',
                          'E ${formatRange(values.end, unit)}',
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
                        label: const Text('Secondary rail'),
                        selected: enableSecondaryRail,
                        onSelected: (bool value) {
                          setState(() {
                            enableSecondaryRail = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Comparison grid'),
                        selected: showComparisonGrid,
                        onSelected: (bool value) {
                          setState(() {
                            showComparisonGrid = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Cross section'),
                        selected: showCrossSection,
                        onSelected: (bool value) {
                          setState(() {
                            showCrossSection = value;
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
                        label: const Text('Guide'),
                        selected: showGuide,
                        onSelected: (bool value) {
                          setState(() {
                            showGuide = value;
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Enabled state'),
                        selected: enabled,
                        onSelected: (bool value) {
                          setState(() {
                            enabled = value;
                          });
                          log('Enabled state changed to ${value ? 'true' : 'false'}.');
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
                              _ThumbSnapshot(
                                title: 'Snapshot (${selected.title})',
                                detail:
                                    'Range ${formatRange(values.start, unit)} -> ${formatRange(values.end, unit)}, radius ${selected.radius.toStringAsFixed(1)}, elevation ${selected.elevation.toStringAsFixed(1)}',
                                color: selected.baseColor,
                              ),
                            );
                            if (timeline.length > 32) {
                              timeline.removeLast();
                            }
                          });
                          log('Captured profile snapshot for ${selected.title}.');
                        },
                        icon: const Icon(Icons.add_chart),
                        label: const Text('Capture Snapshot'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedProfile = _ThumbProfile.balanced;
                            min = 0;
                            max = 100;
                            values = const RangeValues(20, 74);
                            divisions = 20;
                            selectedScenario = 0;
                            enabled = true;
                          });
                          log('Reset composer to baseline profile.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Baseline'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            timeline.clear();
                          });
                          log('Cleared timeline snapshots.');
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
              title: 'Thumb Metrics Dashboard',
              subtitle:
                  'Quantify geometry decisions and current range position effects.',
              icon: Icons.dashboard,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'enabled radius',
                    value: selected.radius.toStringAsFixed(1),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'disabled radius',
                    value: selected.disabledRadius.toStringAsFixed(1),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'elevation',
                    value: selected.elevation.toStringAsFixed(1),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'pressed elevation',
                    value: selected.pressedElevation.toStringAsFixed(1),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'start',
                    value: formatRange(values.start, unit),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'end',
                    value: formatRange(values.end, unit),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'span',
                    value: spanLabel(values, unit),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'midpoint',
                    value: formatRange(midpoint, unit),
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'start normalized',
                    value: '${(startNorm * 100).toStringAsFixed(1)}%',
                    color: selected.baseColor,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: metricTile(
                    label: 'end normalized',
                    value: '${(endNorm * 100).toStringAsFixed(1)}%',
                    color: selected.baseColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Scenario Gallery',
              subtitle:
                  'Load realistic use-cases to inspect thumb shape behavior in domain-specific ranges.',
              icon: Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            Column(
              children: scenarios.asMap().entries.map((MapEntry<int, _UseCaseScenario> entry) {
                final int index = entry.key;
                final _UseCaseScenario scenario = entry.value;
                final _ThumbPreset scenarioPreset = presetFor(scenario.profile);
                final bool active = index == selectedScenario;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: active
                        ? scenarioPreset.baseColor.withValues(alpha: 0.14)
                        : scenarioPreset.baseColor.withValues(alpha: 0.07),
                    border: Border.all(
                      color: active
                          ? scenarioPreset.baseColor.withValues(alpha: 0.45)
                          : scenarioPreset.baseColor.withValues(alpha: 0.25),
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
                          color: scenarioPreset.baseColor.withValues(alpha: 0.22),
                        ),
                        child: Icon(scenario.icon, color: scenarioPreset.baseColor),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              scenario.title,
                              style: TextStyle(
                                color: scenarioPreset.baseColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scenario.description,
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Profile: ${scenarioPreset.title} • min ${scenario.min.toStringAsFixed(0)} • max ${scenario.max.toStringAsFixed(0)} • range ${scenario.values.start.toStringAsFixed(1)}-${scenario.values.end.toStringAsFixed(1)}',
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
                          log('Loaded scenario ${scenario.title}.');
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
                    'Auto-apply profile and numeric bounds when loading a scenario',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Profile Comparison Grid',
              subtitle:
                  'Compare RangeSliderThumbShape presets under the same numeric values.',
              icon: Icons.grid_view,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: showComparisonGrid ? Colors.white : Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showComparisonGrid
                  ? Column(
                      children: presets.map((_ThumbPreset p) {
                        final bool highlight = p.profile == selectedProfile;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: p.baseColor.withValues(alpha: highlight ? 0.16 : 0.08),
                            border: Border.all(
                              color: p.baseColor.withValues(alpha: highlight ? 0.45 : 0.25),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 12,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      color: p.baseColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${p.title} • radius ${p.radius.toStringAsFixed(1)} • pressed ${p.pressedElevation.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        color: p.baseColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: themed(context, p, enabled),
                                child: RangeSlider(
                                  min: min,
                                  max: max,
                                  divisions: p.isDiscrete ? divisions : null,
                                  values: values,
                                  labels: RangeLabels(
                                    formatRange(values.start, unit),
                                    formatRange(values.end, unit),
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
                          'Comparison grid hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Thumb Cross-Section Visualizer',
              subtitle:
                  'Custom painter illustrating radius, elevations, and normalized thumb placement.',
              icon: Icons.auto_awesome_motion,
            ),
            const SizedBox(height: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: showCrossSection
                  ? SizedBox(
                      height: 320,
                      child: CustomPaint(
                        painter: _ThumbSectionPainter(
                          preset: selected,
                          startNorm: startNorm,
                          endNorm: endNorm,
                          startLabel: formatRange(values.start, unit),
                          endLabel: formatRange(values.end, unit),
                          spanLabel: spanLabel(values, unit),
                          isEnabled: enabled,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'Cross-section view hidden. Enable it from composer controls.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Interaction Timeline',
              subtitle: 'Snapshots of thumb profile states captured during exploration.',
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
                          'No snapshots yet. Capture snapshots to track profile evolution.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _ThumbSnapshot> entry) {
                        final _ThumbSnapshot row = entry.value;
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
              title: 'RangeSliderThumbShape Guide',
              subtitle: 'Practical guidance for choosing and tuning thumb behavior.',
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
                      children: guideRows.map((_GuideRow row) {
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
              subtitle: 'Canonical SliderTheme usage with RoundRangeSliderThumbShape customization.',
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
                'final theme = SliderTheme.of(context).copyWith(\n'
                '  rangeThumbShape: RoundRangeSliderThumbShape(\n'
                '    enabledThumbRadius: 12,\n'
                '    disabledThumbRadius: 9,\n'
                '    elevation: 2,\n'
                '    pressedElevation: 6,\n'
                '  ),\n'
                '  showValueIndicator: ShowValueIndicator.always,\n'
                ');\n\n'
                'SliderTheme(\n'
                '  data: theme,\n'
                '  child: RangeSlider(\n'
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
              subtitle: 'Session trace of profile changes, scenario loads, and state updates.',
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
              child: diagnostics.isEmpty
                  ? const Center(
                      child: Text(
                        'No diagnostics yet. Interact with profile controls and scenarios.',
                        style: TextStyle(
                          color: Color(0xFFB7C9EC),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: diagnostics.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            diagnostics[index],
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
                'Summary: this demo positions RangeSliderThumbShape as a central interaction design tool. '
                'By comparing thumb radii, disabled geometry, and elevation dynamics across realistic scenarios, '
                'it shows how to tune slider controls for precision, accessibility, and visual clarity while preserving '
                'cohesive material behavior.',
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

class _ThumbSectionPainter extends CustomPainter {
  _ThumbSectionPainter({
    required this.preset,
    required this.startNorm,
    required this.endNorm,
    required this.startLabel,
    required this.endLabel,
    required this.spanLabel,
    required this.isEnabled,
  });

  final _ThumbPreset preset;
  final double startNorm;
  final double endNorm;
  final String startLabel;
  final String endLabel;
  final String spanLabel;
  final bool isEnabled;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFEAF2FD)],
      ).createShader(area);
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      bg,
    );

    final Rect track = Rect.fromLTWH(26, size.height * 0.62, size.width - 52, 14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(track, const Radius.circular(999)),
      Paint()..color = const Color(0xFFCFD8DC),
    );

    for (int i = 0; i <= 20; i++) {
      final double x = track.left + (track.width * (i / 20));
      canvas.drawLine(
        Offset(x, track.top - 9),
        Offset(x, track.bottom + 9),
        Paint()
          ..strokeWidth = i % 5 == 0 ? 1.4 : 0.7
          ..color = const Color(0x33546E7A),
      );
    }

    final double sx = track.left + track.width * startNorm;
    final double ex = track.left + track.width * endNorm;

    final Rect active = Rect.fromLTRB(sx, track.top, ex, track.bottom);
    canvas.drawRRect(
      RRect.fromRectAndRadius(active, const Radius.circular(999)),
      Paint()..color = preset.baseColor.withValues(alpha: isEnabled ? 0.85 : 0.42),
    );

    final double radius = isEnabled ? preset.radius : preset.disabledRadius;

    void drawThumb(Offset center, bool pressed) {
      final double shadow = pressed ? preset.pressedElevation : preset.elevation;
      if (shadow > 0) {
        canvas.drawCircle(
          center.translate(0, shadow * 0.9),
          radius + shadow * 0.16,
          Paint()..color = const Color(0x2A000000),
        );
      }
      canvas.drawCircle(center, radius, Paint()..color = Colors.white);
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = preset.baseColor,
      );
      canvas.drawCircle(
        center,
        radius * 0.28,
        Paint()..color = preset.baseColor.withValues(alpha: 0.3),
      );
    }

    drawThumb(Offset(sx, track.center.dy), false);
    drawThumb(Offset(ex, track.center.dy), true);

    void drawBubble(Offset anchor, String label, bool left) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 130);

      final double bubbleW = tp.width + 16;
      final double bubbleH = tp.height + 10;
      final double x = left ? anchor.dx - bubbleW - 8 : anchor.dx + 8;
      final Rect rect = Rect.fromLTWH(x, anchor.dy - 62, bubbleW, bubbleH);

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()..color = preset.baseColor.withValues(alpha: 0.92),
      );

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
      canvas.drawPath(tail, Paint()..color = preset.baseColor.withValues(alpha: 0.92));

      tp.paint(canvas, Offset(rect.left + 8, rect.top + 5));
    }

    drawBubble(Offset(sx, track.center.dy), startLabel, true);
    drawBubble(Offset(ex, track.center.dy), endLabel, false);

    final TextPainter headline = TextPainter(
      text: TextSpan(
        text:
            '${preset.title}  •  radius ${preset.radius.toStringAsFixed(1)}  •  disabled ${preset.disabledRadius.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    headline.paint(canvas, const Offset(8, 8));

    final Rect info = Rect.fromLTWH(14, size.height * 0.14, size.width - 28, 96);
    canvas.drawRRect(
      RRect.fromRectAndRadius(info, const Radius.circular(10)),
      Paint()..color = preset.baseColor.withValues(alpha: 0.10),
    );

    final List<String> lines = <String>[
      'active span: $spanLabel',
      'normalized start ${(startNorm * 100).toStringAsFixed(1)}%, normalized end ${(endNorm * 100).toStringAsFixed(1)}%',
      'elevation ${preset.elevation.toStringAsFixed(1)} -> pressed ${preset.pressedElevation.toStringAsFixed(1)}',
    ];

    for (int i = 0; i < lines.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: lines[i],
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: info.width - 16);
      tp.paint(canvas, Offset(info.left + 8, info.top + 12 + i * 24));
    }
  }

  @override
  bool shouldRepaint(covariant _ThumbSectionPainter oldDelegate) {
    return oldDelegate.preset != preset ||
        oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.spanLabel != spanLabel ||
        oldDelegate.isEnabled != isEnabled;
  }
}
