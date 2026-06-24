import 'dart:math' as math;

import 'package:flutter/material.dart';

enum _IndicatorFamily {
  paddle,
  roundedRect,
  rectangular,
}

class _IndicatorPreset {
  const _IndicatorPreset({
    required this.family,
    required this.title,
    required this.description,
    required this.icon,
    required this.primary,
    required this.secondary,
    required this.overlay,
    required this.trackHeight,
    required this.defaultDivisions,
    required this.instruction,
  });

  final _IndicatorFamily family;
  final String title;
  final String description;
  final IconData icon;
  final Color primary;
  final Color secondary;
  final Color overlay;
  final double trackHeight;
  final int defaultDivisions;
  final String instruction;
}

class _IndicatorScenario {
  const _IndicatorScenario({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.family,
    required this.min,
    required this.max,
    required this.values,
    required this.divisions,
    required this.unit,
    required this.gradient,
    required this.note,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final _IndicatorFamily family;
  final double min;
  final double max;
  final RangeValues values;
  final int divisions;
  final String unit;
  final List<Color> gradient;
  final String note;
}

class _GuideNote {
  const _GuideNote({
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

class _TimelineItem {
  const _TimelineItem({
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

class _ComparisonRow {
  const _ComparisonRow({
    required this.caption,
    required this.paddle,
    required this.rounded,
    required this.rectangular,
  });

  final String caption;
  final String paddle;
  final String rounded;
  final String rectangular;
}

dynamic build(BuildContext context) {
  final DateTime startTime = DateTime.now();

  final List<_IndicatorPreset> presets = <_IndicatorPreset>[
    const _IndicatorPreset(
      family: _IndicatorFamily.paddle,
      title: 'Paddle Indicator',
      description:
          'PaddleRangeSliderValueIndicatorShape is expressive and highly discoverable during drag interactions.',
      icon: Icons.sports_score,
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF90CAF9),
      overlay: Color(0x331565C0),
      trackHeight: 5,
      defaultDivisions: 24,
      instruction:
          'Use paddle style when value readability during drag is critical and you want a strong motion cue.',
    ),
    const _IndicatorPreset(
      family: _IndicatorFamily.roundedRect,
      title: 'Rounded Rect Indicator',
      description:
          'RoundedRectRangeSliderValueIndicatorShape provides compact labels with softer geometry.',
      icon: Icons.rounded_corner,
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFA5D6A7),
      overlay: Color(0x332E7D32),
      trackHeight: 6,
      defaultDivisions: 30,
      instruction:
          'Use rounded-rect style in balanced business UIs where clarity matters but you want lower visual intensity.',
    ),
    const _IndicatorPreset(
      family: _IndicatorFamily.rectangular,
      title: 'Rectangular Indicator',
      description:
          'RectangularRangeSliderValueIndicatorShape is strict and technical for precision-centric contexts.',
      icon: Icons.rectangle_outlined,
      primary: Color(0xFF37474F),
      secondary: Color(0xFFB0BEC5),
      overlay: Color(0x3337474F),
      trackHeight: 8,
      defaultDivisions: 40,
      instruction:
          'Use rectangular style for engineering or analytics tools where straight geometry signals exactness.',
    ),
  ];

  final List<_IndicatorScenario> scenarios = <_IndicatorScenario>[
    const _IndicatorScenario(
      title: 'Budget Envelope',
      subtitle: 'Set spending comfort zone for weekly planning.',
      icon: Icons.account_balance_wallet,
      family: _IndicatorFamily.roundedRect,
      min: 0,
      max: 1500,
      values: RangeValues(320, 860),
      divisions: 60,
      unit: '24',
      gradient: <Color>[Color(0xFFF1F8E9), Color(0xFFE8F5E9)],
      note:
          'Compact rounded labels keep currency values readable without over-dominating other planning cards.',
    ),
    const _IndicatorScenario(
      title: 'Workout Zone',
      subtitle: 'Select heart-rate range for interval training.',
      icon: Icons.favorite,
      family: _IndicatorFamily.paddle,
      min: 80,
      max: 200,
      values: RangeValues(128, 166),
      divisions: 60,
      unit: 'bpm',
      gradient: <Color>[Color(0xFFFFEBEE), Color(0xFFFFF3E0)],
      note:
          'Paddle labels support fast in-motion interpretation during repeated drags and frequent adjustments.',
    ),
    const _IndicatorScenario(
      title: 'Reading Session Planner',
      subtitle: 'Choose study interval in a focused block.',
      icon: Icons.menu_book,
      family: _IndicatorFamily.roundedRect,
      min: 10,
      max: 180,
      values: RangeValues(35, 90),
      divisions: 34,
      unit: 'min',
      gradient: <Color>[Color(0xFFE3F2FD), Color(0xFFE8EAF6)],
      note:
          'Rounded indicators pair well with calm productivity layouts while still surfacing exact values.',
    ),
    const _IndicatorScenario(
      title: 'Studio EQ Band',
      subtitle: 'Set favored gain range for quick preview loops.',
      icon: Icons.graphic_eq,
      family: _IndicatorFamily.rectangular,
      min: -24,
      max: 12,
      values: RangeValues(-8, 3),
      divisions: 72,
      unit: 'dB',
      gradient: <Color>[Color(0xFF1B1B1B), Color(0xFF263238)],
      note:
          'Rectangular labels and high precision divisions help users map gain values rapidly in technical UIs.',
    ),
    const _IndicatorScenario(
      title: 'Travel Window',
      subtitle: 'Pick departure and return day range in one gesture.',
      icon: Icons.flight_takeoff,
      family: _IndicatorFamily.paddle,
      min: 1,
      max: 31,
      values: RangeValues(6, 18),
      divisions: 30,
      unit: 'day',
      gradient: <Color>[Color(0xFFE0F7FA), Color(0xFFE1F5FE)],
      note:
          'Paddle indicators are very glanceable for date ranges where users drag repeatedly to compare options.',
    ),
  ];

  final List<_GuideNote> guideNotes = <_GuideNote>[
    const _GuideNote(
      title: 'What Value Indicator Shape Does',
      body:
          'RangeSliderValueIndicatorShape controls the floating value label visuals that appear while dragging slider thumbs.',
      icon: Icons.info,
      color: Color(0xFF1565C0),
    ),
    const _GuideNote(
      title: 'Visual Hierarchy',
      body:
          'Indicator form strongly affects hierarchy: paddle attracts attention, rounded rect balances, rectangular emphasizes precision.',
      icon: Icons.layers,
      color: Color(0xFF2E7D32),
    ),
    const _GuideNote(
      title: 'Readability During Motion',
      body:
          'Fast interactions benefit from bold, larger indicators. Dense UIs may require compact indicators to reduce overlap.',
      icon: Icons.speed,
      color: Color(0xFF8E24AA),
    ),
    const _GuideNote(
      title: 'Pairing With Track/Thumb',
      body:
          'Choose value indicators together with track height and thumb size to keep drag feedback coherent and legible.',
      icon: Icons.tune,
      color: Color(0xFFE65100),
    ),
    const _GuideNote(
      title: 'Theme Contrast',
      body:
          'In dark themes, ensure indicators retain sufficient contrast against rails and content backgrounds.',
      icon: Icons.dark_mode,
      color: Color(0xFF455A64),
    ),
    const _GuideNote(
      title: 'Interpreter Interaction Focus',
      body:
          'These demos validate interaction feedback behavior and rendering under interpreted execution, not Flutter engine correctness.',
      icon: Icons.integration_instructions,
      color: Color(0xFF00695C),
    ),
  ];

  final List<_ComparisonRow> comparisonRows = <_ComparisonRow>[
    const _ComparisonRow(
      caption: 'Visual tone',
      paddle: 'Expressive and prominent',
      rounded: 'Balanced and approachable',
      rectangular: 'Technical and strict',
    ),
    const _ComparisonRow(
      caption: 'Best for',
      paddle: 'Interactive consumer flows',
      rounded: 'General business apps',
      rectangular: 'Precision dashboards',
    ),
    const _ComparisonRow(
      caption: 'Label footprint',
      paddle: 'Large',
      rounded: 'Medium',
      rectangular: 'Medium to small',
    ),
    const _ComparisonRow(
      caption: 'Perceived precision',
      paddle: 'Medium',
      rounded: 'Medium-high',
      rectangular: 'High',
    ),
    const _ComparisonRow(
      caption: 'Drag discoverability',
      paddle: 'Very high',
      rounded: 'High',
      rectangular: 'Medium-high',
    ),
    const _ComparisonRow(
      caption: 'Dense layout fit',
      paddle: 'Moderate',
      rounded: 'Strong',
      rectangular: 'Strong',
    ),
  ];

  _IndicatorFamily selectedFamily = _IndicatorFamily.paddle;
  double min = 0;
  double max = 100;
  RangeValues values = const RangeValues(20, 72);
  int divisions = 24;
  bool enabled = true;
  bool darkCanvas = false;
  bool denseLabels = false;
  bool showThirdPreview = true;
  bool showMilestones = true;
  bool highContrastIndicators = false;
  double trackHeight = 6;
  int scenarioLoads = 0;
  int dragStarts = 0;
  int dragEnds = 0;
  final List<String> console = <String>[];
  final List<_TimelineItem> timeline = <_TimelineItem>[];

  String fmt(double value) {
    if ((value - value.roundToDouble()).abs() < 0.0001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  String valueWithUnit(double value, String unit) {
    if (unit == '24') {
      return '24${fmt(value)}';
    }
    return '${fmt(value)}$unit';
  }

  void logMessage(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    console.insert(0, '[$stamp] $message');
    if (console.length > 120) {
      console.removeLast();
    }
  }

  void pushTimeline(String title, String detail, Color color) {
    timeline.insert(0, _TimelineItem(title: title, detail: detail, color: color));
    if (timeline.length > 36) {
      timeline.removeLast();
    }
  }

  _IndicatorPreset currentPreset() {
    return presets.firstWhere((preset) => preset.family == selectedFamily);
  }

  _IndicatorPreset presetByFamily(_IndicatorFamily family) {
    return presets.firstWhere((preset) => preset.family == family);
  }

  RangeSliderValueIndicatorShape shapeForFamily(_IndicatorFamily family) {
    switch (family) {
      case _IndicatorFamily.paddle:
        return const PaddleRangeSliderValueIndicatorShape();
      case _IndicatorFamily.roundedRect:
        return const RoundedRectRangeSliderValueIndicatorShape();
      case _IndicatorFamily.rectangular:
        return const RectangularRangeSliderValueIndicatorShape();
    }
  }

  SliderThemeData themeForPreset(_IndicatorPreset preset, {bool emphasize = false}) {
    final double resolvedHeight = emphasize ? trackHeight + 1.2 : trackHeight;
    final Color active = highContrastIndicators
        ? preset.primary.withValues(alpha: 1)
        : preset.primary.withValues(alpha: 0.9);
    final Color inactive = darkCanvas
        ? preset.secondary.withValues(alpha: 0.35)
        : preset.secondary.withValues(alpha: 0.75);

    return SliderThemeData(
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      rangeValueIndicatorShape: shapeForFamily(preset.family),
      trackHeight: resolvedHeight,
      activeTrackColor: active,
      inactiveTrackColor: inactive,
      thumbColor: active,
      overlayColor: preset.overlay,
      activeTickMarkColor: active.withValues(alpha: 0.85),
      inactiveTickMarkColor: inactive.withValues(alpha: 0.8),
      valueIndicatorColor: active,
      valueIndicatorTextStyle: TextStyle(
        color: darkCanvas ? Colors.white : const Color(0xFFF8FBFF),
        fontWeight: FontWeight.w700,
      ),
      showValueIndicator: ShowValueIndicator.onDrag,
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

  Widget sectionTitle(_IndicatorPreset selected, {
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
            color: selected.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: selected.primary, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: selected.primary,
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
              showValueIndicator: ShowValueIndicator.onDrag,
              rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
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

  Widget comparisonTable(List<_ComparisonRow> rows) {
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

    final List<Widget> tableRows = <Widget>[
      Row(
        children: <Widget>[
          Expanded(flex: 2, child: cell('Signal', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(child: cell('Paddle', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(child: cell('Rounded', tint: const Color(0xFFF2F7FF), header: true)),
          Expanded(child: cell('Rectangular', tint: const Color(0xFFF2F7FF), header: true)),
        ],
      ),
    ];

    for (final _ComparisonRow row in rows) {
      tableRows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.caption, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(child: cell(row.paddle)),
            Expanded(child: cell(row.rounded)),
            Expanded(child: cell(row.rectangular)),
          ],
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: tableRows));
  }

  Widget timelinePanel(List<_TimelineItem> items) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF4F7FB),
          border: Border.all(color: const Color(0xFFD8E4F4)),
        ),
        child: Text(
          'Timeline starts empty. Load scenarios or drag sliders to inspect event chronology.',
          style: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: item.color.withValues(alpha: 0.35)),
            color: item.color.withValues(alpha: 0.08),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: item.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.detail,
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

  Widget consolePanel(List<String> entries) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1321),
        borderRadius: BorderRadius.circular(14),
      ),
      child: entries.isEmpty
          ? const Center(
              child: Text(
                'No logs yet. Trigger interactions to populate diagnostics.',
                style: TextStyle(
                  color: Color(0xFFB7C9EC),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    entries[index],
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

  Widget scenarioCard(
    _IndicatorScenario scenario,
    _IndicatorFamily selectedFamily,
    void Function(void Function()) setState,
  ) {
    final bool highlighted = scenario.family == selectedFamily;
    final _IndicatorPreset preset = presetByFamily(scenario.family);

    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: scenario.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: highlighted
              ? preset.primary.withValues(alpha: 0.95)
              : preset.primary.withValues(alpha: 0.4),
          width: highlighted ? 2 : 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(scenario.icon, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  scenario.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            scenario.subtitle,
            style: const TextStyle(
              color: Color(0xFFE3ECFF),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            scenario.note,
            style: const TextStyle(
              color: Color(0xFFD5E0F6),
              height: 1.33,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              pill('Range', '${fmt(scenario.values.start)}-${fmt(scenario.values.end)}${scenario.unit}'),
              pill('Divisions', '${scenario.divisions}'),
              pill('Style', preset.title),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  selectedFamily = scenario.family;
                  min = scenario.min;
                  max = scenario.max;
                  values = scenario.values;
                  divisions = scenario.divisions;
                  trackHeight = preset.trackHeight;
                  darkCanvas = scenario.gradient.first.computeLuminance() < 0.22;
                  scenarioLoads += 1;
                });
                logMessage('Loaded scenario ${scenario.title}.');
                pushTimeline(
                  scenario.title,
                  '${valueWithUnit(values.start, scenario.unit)} -> ${valueWithUnit(values.end, scenario.unit)}',
                  preset.primary,
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Scenario'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget previewPanel({
    required String title,
    required String subtitle,
    required SliderThemeData sliderTheme,
    required List<Color> gradient,
    required bool dense,
    required bool enabled,
    required String unit,
    required void Function(void Function()) setState,
  }) {
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
          color: dense
              ? sliderTheme.activeTrackColor!.withValues(alpha: 0.48)
              : sliderTheme.activeTrackColor!.withValues(alpha: 0.24),
          width: dense ? 1.6 : 1,
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
              color: darkCanvas
                  ? const Color(0xFFCFD8DC)
                  : Colors.blueGrey.shade700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          SliderTheme(
            data: sliderTheme,
            child: RangeSlider(
              min: min,
              max: max,
              divisions: divisions,
              labels: RangeLabels(
                valueWithUnit(values.start, unit),
                valueWithUnit(values.end, unit),
              ),
              values: values,
              onChanged: enabled
                  ? (RangeValues v) {
                      setState(() {
                        values = v;
                      });
                      logMessage('Panel "$title" values changed to ${fmt(v.start)}-${fmt(v.end)}.');
                    }
                  : null,
              onChangeStart: enabled
                  ? (RangeValues v) {
                      dragStarts += 1;
                      logMessage('Drag started at ${fmt(v.start)}-${fmt(v.end)} in "$title".');
                    }
                  : null,
              onChangeEnd: enabled
                  ? (RangeValues v) {
                      dragEnds += 1;
                      pushTimeline(
                        'Drag completed',
                        '$title -> ${fmt(v.start)} to ${fmt(v.end)}',
                        sliderTheme.activeTrackColor ?? const Color(0xFF1565C0),
                      );
                      logMessage('Drag ended at ${fmt(v.start)}-${fmt(v.end)} in "$title".');
                    }
                  : null,
            ),
          ),
          if (dense) ...<Widget>[
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Current span: ${fmt(values.end - values.start)}',
                    style: TextStyle(
                      color: darkCanvas
                          ? const Color(0xFFD7E3F8)
                          : Colors.blueGrey.shade900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'step ${fmt((max - min) / math.max(1, divisions))}',
                  style: TextStyle(
                    color: darkCanvas
                        ? const Color(0xFFB7C9E6)
                        : Colors.blueGrey.shade700,
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
      final _IndicatorPreset selected = currentPreset();
      final double span = values.end - values.start;
      final double normalizedStart =
          ((values.start - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double normalizedEnd =
          ((values.end - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final int safeDivisions = math.max(1, divisions);
      final double discreteStep = (max - min) / safeDivisions;

      final List<_QuickMetric> metrics = <_QuickMetric>[
        _QuickMetric(label: 'Start', value: fmt(values.start), color: selected.primary),
        _QuickMetric(label: 'End', value: fmt(values.end), color: selected.secondary),
        _QuickMetric(label: 'Span', value: fmt(span), color: const Color(0xFF6A1B9A)),
        _QuickMetric(label: 'Divisions', value: '$divisions', color: const Color(0xFF2E7D32)),
        _QuickMetric(label: 'Step', value: fmt(discreteStep), color: const Color(0xFFE65100)),
        _QuickMetric(label: 'Scenario loads', value: '$scenarioLoads', color: const Color(0xFF455A64)),
        _QuickMetric(label: 'Drag starts', value: '$dragStarts', color: const Color(0xFFAD1457)),
        _QuickMetric(label: 'Drag ends', value: '$dragEnds', color: const Color(0xFF283593)),
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
                          color: selected.primary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.label, color: selected.primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'RangeSliderValueIndicatorShape Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'A visual studio for comparing value indicator styles and understanding label readability during drag interactions.',
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
                      pill('Preset', selected.title),
                      pill('Family', selectedFamily.name),
                      pill('Range', '${fmt(min)}..${fmt(max)}'),
                      pill('Current', '${fmt(values.start)} -> ${fmt(values.end)}'),
                      pill('Track height', fmt(trackHeight)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Indicator Family Selector',
              subtitle:
                  'Switch between built-in RangeSliderValueIndicatorShape styles and review practical guidance.',
              icon: Icons.dashboard_customize,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD4E1F5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: presets.map((preset) {
                      final bool active = preset.family == selectedFamily;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFamily = preset.family;
                            trackHeight = preset.trackHeight;
                            divisions = preset.defaultDivisions;
                          });
                          logMessage('Preset switched to ${preset.title}.');
                          pushTimeline(
                            'Preset applied',
                            '${preset.title} | divisions=$divisions | trackHeight=${fmt(trackHeight)}',
                            preset.primary,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: 260,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: active
                                ? preset.primary.withValues(alpha: 0.11)
                                : const Color(0xFFFAFBFF),
                            border: Border.all(
                              color: active
                                  ? preset.primary.withValues(alpha: 0.9)
                                  : const Color(0xFFD5E2F2),
                              width: active ? 1.8 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(preset.icon, color: preset.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      preset.title,
                                      style: TextStyle(
                                        color: preset.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                preset.description,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  height: 1.28,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                preset.instruction,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Interaction Controls',
              subtitle:
                  'Tune value indicator behavior, contrast, and range model to stress-test readability in different contexts.',
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
                          min: 2,
                          max: 16,
                          divisions: 28,
                          value: trackHeight,
                          onChanged: (double v) {
                            setState(() {
                              trackHeight = v;
                            });
                            logMessage('Track height set to ${fmt(v)}.');
                          },
                          color: selected.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: labeledSlider(
                          label: 'Divisions',
                          valueLabel: '$divisions',
                          min: 4,
                          max: 120,
                          divisions: 116,
                          value: divisions.toDouble(),
                          onChanged: (double v) {
                            setState(() {
                              divisions = v.round();
                            });
                            logMessage('Divisions changed to $divisions.');
                          },
                          color: selected.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: labeledSlider(
                          label: 'Range Start',
                          valueLabel: fmt(values.start),
                          min: min,
                          max: values.end,
                          divisions: safeDivisions,
                          value: values.start,
                          onChanged: enabled
                              ? (double v) {
                                  setState(() {
                                    values = RangeValues(v, values.end);
                                  });
                                  logMessage('Start adjusted manually to ${fmt(v)}.');
                                }
                              : null,
                          color: const Color(0xFF8E24AA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: labeledSlider(
                          label: 'Range End',
                          valueLabel: fmt(values.end),
                          min: values.start,
                          max: max,
                          divisions: safeDivisions,
                          value: values.end,
                          onChanged: enabled
                              ? (double v) {
                                  setState(() {
                                    values = RangeValues(values.start, v);
                                  });
                                  logMessage('End adjusted manually to ${fmt(v)}.');
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
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: enabled,
                          title: const Text('Enable interaction'),
                          subtitle: const Text('Disables all preview sliders when off.'),
                          onChanged: (bool v) {
                            setState(() {
                              enabled = v;
                            });
                            logMessage(v ? 'Interaction enabled.' : 'Interaction disabled.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: darkCanvas,
                          title: const Text('Dark preview canvas'),
                          subtitle: const Text('Simulate dark-themed product surfaces.'),
                          onChanged: (bool v) {
                            setState(() {
                              darkCanvas = v;
                            });
                            logMessage(v ? 'Dark canvas enabled.' : 'Dark canvas disabled.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: denseLabels,
                          title: const Text('Dense label mode'),
                          subtitle: const Text('Adds stronger panel hints and compact visual rhythm.'),
                          onChanged: (bool v) {
                            setState(() {
                              denseLabels = v;
                            });
                            logMessage(v ? 'Dense label mode enabled.' : 'Dense label mode disabled.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showMilestones,
                          title: const Text('Milestone hints'),
                          subtitle: const Text('Show quarter markers in diagnostics canvas.'),
                          onChanged: (bool v) {
                            setState(() {
                              showMilestones = v;
                            });
                            logMessage(v ? 'Milestones shown.' : 'Milestones hidden.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: highContrastIndicators,
                          title: const Text('High contrast indicators'),
                          subtitle: const Text('Boost indicator emphasis for accessibility checks.'),
                          onChanged: (bool v) {
                            setState(() {
                              highContrastIndicators = v;
                            });
                            logMessage(v ? 'High contrast mode enabled.' : 'High contrast mode disabled.');
                          },
                        ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showThirdPreview,
                          title: const Text('Comparison preview'),
                          subtitle: const Text('Show a second style baseline for quick A/B reading.'),
                          onChanged: (bool v) {
                            setState(() {
                              showThirdPreview = v;
                            });
                            logMessage(v ? 'Comparison preview enabled.' : 'Comparison preview hidden.');
                          },
                        ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Live Visual Previews',
              subtitle:
                  'Interact with multiple surface styles and watch how value indicator shape changes drag feedback readability.',
              icon: Icons.widgets,
            ),
            const SizedBox(height: 10),
            previewPanel(
              title: 'Primary Theme Preview',
              subtitle: 'Current selected indicator family with default styling.',
              sliderTheme: themeForPreset(selected),
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF101820), const Color(0xFF1D2D44)]
                  : <Color>[const Color(0xFFFFFFFF), const Color(0xFFF4F8FF)],
              dense: denseLabels,
              enabled: enabled,
              unit: '',
              setState: setState,
            ),
            const SizedBox(height: 12),
            previewPanel(
              title: 'High Contrast Preview',
              subtitle: 'Same values with stronger label contrast for accessibility and low-light conditions.',
              sliderTheme: themeForPreset(selected, emphasize: true),
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF0B0F1A), const Color(0xFF1E293B)]
                  : <Color>[const Color(0xFFEFF5FF), const Color(0xFFFFFFFF)],
              dense: true,
              enabled: enabled,
              unit: '',
              setState: setState,
            ),
            if (showThirdPreview) ...<Widget>[
              const SizedBox(height: 12),
              previewPanel(
                title: 'Rounded Baseline Preview',
                subtitle: 'Reference panel using rounded-rect indicator for comparative reading.',
                sliderTheme: themeForPreset(presetByFamily(_IndicatorFamily.roundedRect)),
                gradient: darkCanvas
                    ? <Color>[const Color(0xFF132A13), const Color(0xFF1B4332)]
                    : <Color>[const Color(0xFFF3FFF7), const Color(0xFFE9FFF0)],
                dense: false,
                enabled: enabled,
                unit: '',
                setState: setState,
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Domain Scenarios',
              subtitle:
                  'Load realistic use cases to evaluate which indicator shape communicates values best under each context.',
              icon: Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(
              children: scenarios
                  .map((scenario) => scenarioCard(scenario, selectedFamily, setState))
                  .toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Indicator Diagnostics Canvas',
              subtitle:
                  'Painter representation of current value labels, active segment, and milestone rhythm based on current settings.',
              icon: Icons.insights,
            ),
            const SizedBox(height: 10),
            Container(
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBDCF5)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: CustomPaint(
                  painter: _IndicatorDiagnosticsPainter(
                    preset: selected,
                    startNorm: normalizedStart,
                    endNorm: normalizedEnd,
                    startLabel: fmt(values.start),
                    endLabel: fmt(values.end),
                    divisions: divisions,
                    enabled: enabled,
                    showMilestones: showMilestones,
                    family: selectedFamily,
                    trackHeight: trackHeight,
                    denseLabels: denseLabels,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Comparison Matrix',
              subtitle:
                  'Quick decision aid for selecting indicator styles by context, precision needs, and visual density.',
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
              child: comparisonTable(comparisonRows),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Guide Notes',
              subtitle:
                  'Practical recommendations for integrating value indicator shapes in production-grade range interactions.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guideNotes.map((note) {
                return Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: note.color.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(note.icon, color: note.color, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              note.title,
                              style: TextStyle(
                                color: note.color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note.body,
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
              selected,
              title: 'Code Walkthrough',
              subtitle:
                  'Core examples of wiring rangeValueIndicatorShape into SliderThemeData for each family.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF24406F)),
              ),
              child: const Text(
                'SliderThemeData(\n'
                '  rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),\n'
                '  showValueIndicator: ShowValueIndicator.onDrag,\n'
                ')\n\n'
                'SliderThemeData(\n'
                '  rangeValueIndicatorShape: RoundedRectRangeSliderValueIndicatorShape(),\n'
                '  showValueIndicator: ShowValueIndicator.onDrag,\n'
                ')\n\n'
                'SliderThemeData(\n'
                '  rangeValueIndicatorShape: RectangularRangeSliderValueIndicatorShape(),\n'
                '  showValueIndicator: ShowValueIndicator.onDrag,\n'
                ')',
                style: TextStyle(
                  color: Color(0xFFD7E8FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Interaction Timeline',
              subtitle:
                  'Chronological snapshots for preset changes, scenario loads, and drag completions.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(timeline),
            const SizedBox(height: 18),
            sectionTitle(
              selected,
              title: 'Diagnostics Console',
              subtitle:
                  'Low-level event stream for interpreter behavior checks while interacting with value indicators.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            consolePanel(console),
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
                'Summary: RangeSliderValueIndicatorShape defines how value labels appear while users drag both thumbs. '
                'This deep demo contrasts Paddle, RoundedRect, and Rectangular indicator families through multiple practical scenarios, '
                'with controls for density, contrast, and interaction telemetry. The result is a hands-on guide for choosing '
                'the right indicator style to maximize clarity and confidence in interpreter-driven Flutter range controls.',
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
              '${startTime.hour.toString().padLeft(2, '0')}:'
              '${startTime.minute.toString().padLeft(2, '0')}:'
              '${startTime.second.toString().padLeft(2, '0')}.',
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

class _IndicatorDiagnosticsPainter extends CustomPainter {
  _IndicatorDiagnosticsPainter({
    required this.preset,
    required this.startNorm,
    required this.endNorm,
    required this.startLabel,
    required this.endLabel,
    required this.divisions,
    required this.enabled,
    required this.showMilestones,
    required this.family,
    required this.trackHeight,
    required this.denseLabels,
  });

  final _IndicatorPreset preset;
  final double startNorm;
  final double endNorm;
  final String startLabel;
  final String endLabel;
  final int divisions;
  final bool enabled;
  final bool showMilestones;
  final _IndicatorFamily family;
  final double trackHeight;
  final bool denseLabels;

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

    final double railHeight = trackHeight.clamp(2, 18);
    final Rect rail = Rect.fromLTWH(24, size.height * 0.62, size.width - 48, railHeight);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rail, const Radius.circular(999)),
      Paint()..color = const Color(0xFFC7D4E7),
    );

    final double sx = rail.left + rail.width * startNorm;
    final double ex = rail.left + rail.width * endNorm;
    final Rect activeRect = Rect.fromLTRB(sx, rail.top, ex, rail.bottom);
    canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(999)),
      Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            preset.primary.withValues(alpha: enabled ? 0.78 : 0.46),
            preset.primary.withValues(alpha: enabled ? 1 : 0.64),
            preset.primary.withValues(alpha: enabled ? 0.78 : 0.46),
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
          ? preset.primary.withValues(alpha: 0.65)
          : const Color(0xFF8FA4C2).withValues(alpha: 0.52);
      canvas.drawLine(
        Offset(x, rail.bottom + 6),
        Offset(x, rail.bottom + 6 + h),
        Paint()
          ..color = c
          ..strokeWidth = milestone ? 1.7 : 1,
      );
    }

    final Paint thumbPaint = Paint()..color = preset.primary;
    canvas.drawCircle(Offset(sx, rail.center.dy), 8, thumbPaint);
    canvas.drawCircle(Offset(ex, rail.center.dy), 8, thumbPaint);
    canvas.drawCircle(
      Offset(sx, rail.center.dy),
      13,
      Paint()..color = preset.primary.withValues(alpha: 0.12),
    );
    canvas.drawCircle(
      Offset(ex, rail.center.dy),
      13,
      Paint()..color = preset.primary.withValues(alpha: 0.12),
    );

    final String familyName = family.name;
    final TextPainter top = TextPainter(
      text: TextSpan(
        text: '${preset.title} | family=$familyName | divisions=$divisions | rail=${trackHeight.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF294172),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 28);
    top.paint(canvas, const Offset(14, 12));

    void paintBubble(Offset anchor, String text, Color color) {
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: denseLabels ? 10 : 11,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final Rect rect = Rect.fromLTWH(
        anchor.dx - t.width / 2 - 9,
        anchor.dy - (denseLabels ? 30 : 35),
        t.width + 18,
        denseLabels ? 20 : 24,
      );

      RRect bubble;
      switch (family) {
        case _IndicatorFamily.paddle:
          bubble = RRect.fromRectAndRadius(rect, const Radius.circular(14));
          break;
        case _IndicatorFamily.roundedRect:
          bubble = RRect.fromRectAndRadius(rect, const Radius.circular(8));
          break;
        case _IndicatorFamily.rectangular:
          bubble = RRect.fromRectAndRadius(rect, Radius.zero);
          break;
      }

      canvas.drawRRect(bubble, Paint()..color = color);
      t.paint(canvas, Offset(rect.left + 9, rect.top + (denseLabels ? 4 : 6)));

      final Path tail = Path()
        ..moveTo(anchor.dx - 5, rect.bottom)
        ..lineTo(anchor.dx + 5, rect.bottom)
        ..lineTo(anchor.dx, rect.bottom + 6)
        ..close();
      canvas.drawPath(tail, Paint()..color = color);
    }

    paintBubble(Offset(sx, rail.top), startLabel, preset.primary.withValues(alpha: 0.92));
    paintBubble(Offset(ex, rail.top), endLabel, preset.primary.withValues(alpha: 0.82));

    final TextPainter footer = TextPainter(
      text: TextSpan(
        text: enabled
            ? 'Indicator labels previewed in diagnostics mode. Drag thumbs above to validate readability under motion.'
            : 'Interaction disabled: canvas displays passive state for value indicator label geometry.',
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
  bool shouldRepaint(covariant _IndicatorDiagnosticsPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.divisions != divisions ||
        oldDelegate.enabled != enabled ||
        oldDelegate.showMilestones != showMilestones ||
        oldDelegate.family != family ||
        oldDelegate.trackHeight != trackHeight ||
        oldDelegate.denseLabels != denseLabels ||
        oldDelegate.preset != preset;
  }
}
