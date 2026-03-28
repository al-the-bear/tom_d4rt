import 'dart:math' as math;

import 'package:flutter/material.dart';

enum _TrackFamily {
  rounded,
  rectangular,
  segmentedGlow,
}

class _TrackPreset {
  const _TrackPreset({
    required this.family,
    required this.title,
    required this.description,
    required this.icon,
    required this.primary,
    required this.secondary,
    required this.trackHeight,
    required this.defaultDivisions,
    required this.prefersMilestones,
    required this.instruction,
  });

  final _TrackFamily family;
  final String title;
  final String description;
  final IconData icon;
  final Color primary;
  final Color secondary;
  final double trackHeight;
  final int defaultDivisions;
  final bool prefersMilestones;
  final String instruction;
}

class _TrackScenario {
  const _TrackScenario({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.presetFamily,
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
  final _TrackFamily presetFamily;
  final double min;
  final double max;
  final RangeValues values;
  final int divisions;
  final String unit;
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

class _MetricTile {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _TrackComparisonRow {
  const _TrackComparisonRow({
    required this.caption,
    required this.rounded,
    required this.rectangular,
    required this.segmented,
  });

  final String caption;
  final String rounded;
  final String rectangular;
  final String segmented;
}

class _SegmentedGlowTrackShape extends RangeSliderTrackShape {
  const _SegmentedGlowTrackShape({
    this.trackHeight = 8,
    this.segmentCount = 24,
  });

  final double trackHeight;
  final int segmentCount;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double thumbWidth =
        sliderTheme.rangeThumbShape?.getPreferredSize(isEnabled, isDiscrete).width ??
            0;
    final double left = offset.dx + thumbWidth / 2;
    final double right = offset.dx + parentBox.size.width - thumbWidth / 2;
    final double top =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTRB(left, top, right, top + trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Canvas canvas = context.canvas;
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Color activeColor =
        (sliderTheme.activeTrackColor ?? const Color(0xFF1976D2))
            .withValues(alpha: isEnabled ? 1 : 0.55);
    final Color inactiveColor =
        (sliderTheme.inactiveTrackColor ?? const Color(0xFFB0BEC5))
            .withValues(alpha: isEnabled ? 0.55 : 0.28);

    final RRect outer =
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackHeight / 2));
    canvas.drawRRect(
      outer,
      Paint()
        ..shader = LinearGradient(
          colors: <Color>[inactiveColor, inactiveColor.withValues(alpha: 0.22)],
        ).createShader(trackRect),
    );

    final Rect activeRect = Rect.fromLTRB(
      startThumbCenter.dx,
      trackRect.top,
      endThumbCenter.dx,
      trackRect.bottom,
    );
    final RRect active =
      RRect.fromRectAndRadius(activeRect, Radius.circular(trackHeight / 2));
    canvas.drawRRect(
      active,
      Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            activeColor.withValues(alpha: 0.8),
            activeColor,
            activeColor.withValues(alpha: 0.74),
          ],
        ).createShader(activeRect),
    );

    final int safeSegments = math.max(1, segmentCount);
    final double segmentWidth = trackRect.width / safeSegments;
    for (int i = 1; i < safeSegments; i++) {
      final double x = trackRect.left + (segmentWidth * i);
      final bool insideActive = x >= activeRect.left && x <= activeRect.right;
      canvas.drawLine(
        Offset(x, trackRect.top + 1),
        Offset(x, trackRect.bottom - 1),
        Paint()
          ..color = insideActive
              ? Colors.white.withValues(alpha: 0.22)
              : Colors.black.withValues(alpha: 0.1)
          ..strokeWidth = 1,
      );
    }

    final Paint glow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
      ..color = activeColor.withValues(alpha: isEnabled ? 0.35 : 0.15);
    canvas.drawRRect(active.inflate(1.5), glow);
  }
}

dynamic build(BuildContext context) {
  final DateTime startTime = DateTime.now();

  final List<_TrackPreset> presets = <_TrackPreset>[
    const _TrackPreset(
      family: _TrackFamily.rounded,
      title: 'Rounded Rail',
      description:
          'RoundedRectRangeSliderTrackShape is smooth and calm. Great for modern dashboards and wellness settings.',
      icon: Icons.rounded_corner,
      primary: Color(0xFF1565C0),
      secondary: Color(0xFFBBDEFB),
      trackHeight: 6,
      defaultDivisions: 24,
      prefersMilestones: true,
      instruction:
          'Use for general-purpose range controls where visual softness improves trust and readability.',
    ),
    const _TrackPreset(
      family: _TrackFamily.rectangular,
      title: 'Rectangular Rail',
      description:
          'RectangularRangeSliderTrackShape is strict and technical, useful for precision and engineering contexts.',
      icon: Icons.crop_16_9,
      primary: Color(0xFF37474F),
      secondary: Color(0xFFCFD8DC),
      trackHeight: 8,
      defaultDivisions: 30,
      prefersMilestones: false,
      instruction:
          'Use where right angles and high geometry contrast communicate exact stepping and deterministic control.',
    ),
    const _TrackPreset(
      family: _TrackFamily.segmentedGlow,
      title: 'Segmented Glow Rail',
      description:
          'Custom RangeSliderTrackShape with segmented lanes and active glow for spotlighting the selected band.',
      icon: Icons.auto_awesome,
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFC8E6C9),
      trackHeight: 10,
      defaultDivisions: 36,
      prefersMilestones: true,
      instruction:
          'Use when designers need high active-band emphasis and explicit segment rhythm in dark or dense layouts.',
    ),
  ];

  final List<_TrackScenario> scenarios = <_TrackScenario>[
    const _TrackScenario(
      title: 'Energy Scheduler',
      subtitle: 'Pick cheap-hour charging window overnight.',
      icon: Icons.bolt,
      presetFamily: _TrackFamily.segmentedGlow,
      min: 0,
      max: 24,
      values: RangeValues(1.5, 6.0),
      divisions: 48,
      unit: 'h',
      gradient: <Color>[Color(0xFF102027), Color(0xFF1B5E20)],
      note:
          'Dense segmentation helps users map values directly to half-hour slots without extra labels.',
    ),
    const _TrackScenario(
      title: 'Climate Comfort Band',
      subtitle: 'Define acceptable indoor temperature range.',
      icon: Icons.thermostat,
      presetFamily: _TrackFamily.rounded,
      min: 14,
      max: 32,
      values: RangeValues(20, 24),
      divisions: 36,
      unit: '°C',
      gradient: <Color>[Color(0xFFE3F2FD), Color(0xFFFFEBEE)],
      note:
          'Rounded rails reduce visual stress in everyday controls where users revisit the setting frequently.',
    ),
    const _TrackScenario(
      title: 'Sleep Planner',
      subtitle: 'Set bedtime and wake-up span with low distraction.',
      icon: Icons.nightlight_round,
      presetFamily: _TrackFamily.rounded,
      min: 0,
      max: 12,
      values: RangeValues(2, 10.5),
      divisions: 48,
      unit: 'h',
      gradient: <Color>[Color(0xFF1A237E), Color(0xFF311B92)],
      note:
          'Gentle rounded tracks pair well with dim themes, keeping the control legible but not aggressive.',
    ),
    const _TrackScenario(
      title: 'Studio Loudness Window',
      subtitle: 'Configure safe mastering range for preview.',
      icon: Icons.graphic_eq,
      presetFamily: _TrackFamily.rectangular,
      min: -36,
      max: 6,
      values: RangeValues(-18, -6),
      divisions: 42,
      unit: 'dB',
      gradient: <Color>[Color(0xFF212121), Color(0xFF424242)],
      note:
          'Rectangular tracks communicate precision and intentional hard boundaries in audio engineering workflows.',
    ),
    const _TrackScenario(
      title: 'Video Clip Focus',
      subtitle: 'Select highlighted segment in a 20-minute timeline.',
      icon: Icons.video_collection,
      presetFamily: _TrackFamily.segmentedGlow,
      min: 0,
      max: 20,
      values: RangeValues(4.2, 13.6),
      divisions: 80,
      unit: 'min',
      gradient: <Color>[Color(0xFF0D1B2A), Color(0xFF003049)],
      note:
          'Segmented rails let users align to editorial beats while the glow highlights active selection in busy UIs.',
    ),
  ];

  final List<_GuideCard> guideCards = <_GuideCard>[
    const _GuideCard(
      title: 'What Track Shape Controls',
      body:
          'RangeSliderTrackShape determines geometry and paint behavior of the rail behind both thumbs, including active and inactive portions.',
      icon: Icons.architecture,
      color: Color(0xFF1565C0),
    ),
    const _GuideCard(
      title: 'Why Family Choice Matters',
      body:
          'Rounded tracks reduce harshness and feel approachable. Rectangular tracks feel technical and precise. Custom tracks can encode domain semantics.',
      icon: Icons.rule,
      color: Color(0xFF2E7D32),
    ),
    const _GuideCard(
      title: 'Interaction Readability',
      body:
          'Track thickness, contrast, and segmentation alter how quickly users estimate selected span during drag operations.',
      icon: Icons.visibility,
      color: Color(0xFF8E24AA),
    ),
    const _GuideCard(
      title: 'Accessibility Considerations',
      body:
          'Higher contrast and sufficient track height improve discoverability for low-vision users and touch interactions.',
      icon: Icons.accessibility_new,
      color: Color(0xFFE65100),
    ),
    const _GuideCard(
      title: 'Discrete vs Continuous',
      body:
          'For discrete controls, track segmentation and milestones improve snapping confidence. For continuous controls, subtle tracks avoid visual noise.',
      icon: Icons.linear_scale,
      color: Color(0xFF546E7A),
    ),
    const _GuideCard(
      title: 'Theme Integration',
      body:
          'Track shape is selected in SliderThemeData.rangeTrackShape and should be tuned with rangeThumbShape, active/inactive colors, and tick marks.',
      icon: Icons.palette,
      color: Color(0xFF00695C),
    ),
  ];

  final List<_TrackComparisonRow> comparisonRows = <_TrackComparisonRow>[
    const _TrackComparisonRow(
      caption: 'Visual personality',
      rounded: 'Friendly, modern, calm',
      rectangular: 'Precise, technical, strict',
      segmented: 'Expressive, high-energy, highlighted',
    ),
    const _TrackComparisonRow(
      caption: 'Best for',
      rounded: 'Consumer and wellness controls',
      rectangular: 'Professional engineering tools',
      segmented: 'Analytics timelines and spotlight interactions',
    ),
    const _TrackComparisonRow(
      caption: 'Perceived precision',
      rounded: 'Medium',
      rectangular: 'High',
      segmented: 'High with milestone rhythm',
    ),
    const _TrackComparisonRow(
      caption: 'Cognitive load',
      rounded: 'Low',
      rectangular: 'Medium',
      segmented: 'Medium to high depending on segment count',
    ),
    const _TrackComparisonRow(
      caption: 'Dark theme behavior',
      rounded: 'Needs contrast boost',
      rectangular: 'Usually stable',
      segmented: 'Excellent with glow and lane separators',
    ),
    const _TrackComparisonRow(
      caption: 'Customization flexibility',
      rounded: 'Low to medium',
      rectangular: 'Low to medium',
      segmented: 'High (segment count, glow, lane detail)',
    ),
  ];

    _TrackFamily selectedFamily = _TrackFamily.rounded;
    double min = 0;
    double max = 100;
    RangeValues values = const RangeValues(20, 70);
    int divisions = 24;
    bool enabled = true;
    bool showMilestones = true;
    bool showDenseGuide = false;
    bool darkCanvas = false;
    bool showThirdPreview = true;
    double customTrackHeight = 8;
    int customSegmentCount = 24;
    int scenarioLoads = 0;
    final List<String> console = <String>[];
    final List<_TimelineEntry> timeline = <_TimelineEntry>[];

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      String fmt(double value) {
        if ((value - value.roundToDouble()).abs() < 0.0001) {
          return value.toStringAsFixed(0);
        }
        return value.toStringAsFixed(1);
      }

      void addLog(String message) {
        final DateTime now = DateTime.now();
        final String stamp =
            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
        console.insert(0, '[$stamp] $message');
        if (console.length > 120) {
          console.removeLast();
        }
      }

      void pushTimeline(String title, String detail, Color color) {
        timeline.insert(
          0,
          _TimelineEntry(title: title, detail: detail, color: color),
        );
        if (timeline.length > 30) {
          timeline.removeLast();
        }
      }

      _TrackPreset selectedPreset() {
        return presets.firstWhere((p) => p.family == selectedFamily);
      }

      SliderThemeData buildTheme(_TrackPreset preset, {bool emphasize = false}) {
        final double height = emphasize ? customTrackHeight + 1 : customTrackHeight;
        final RangeSliderTrackShape shape;
        switch (preset.family) {
          case _TrackFamily.rounded:
            shape = const RoundedRectRangeSliderTrackShape();
            break;
          case _TrackFamily.rectangular:
            shape = const RectangularRangeSliderTrackShape();
            break;
          case _TrackFamily.segmentedGlow:
            shape = _SegmentedGlowTrackShape(
              trackHeight: height,
              segmentCount: customSegmentCount,
            );
            break;
        }

        final Color active = preset.primary;
        final Color inactive = preset.secondary.withValues(alpha: darkCanvas ? 0.45 : 0.72);

        return SliderThemeData(
          rangeTrackShape: shape,
          trackHeight: height,
          activeTrackColor: active,
          inactiveTrackColor: inactive,
          thumbColor: active,
          overlayColor: active.withValues(alpha: 0.14),
          activeTickMarkColor: active.withValues(alpha: 0.85),
          inactiveTickMarkColor: inactive.withValues(alpha: 0.82),
          rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.onDrag,
        );
      }

      _TrackPreset presetForFamily(_TrackFamily family) {
        return presets.firstWhere((p) => p.family == family);
      }

      void applyPreset(_TrackPreset preset) {
        setState(() {
          selectedFamily = preset.family;
          customTrackHeight = preset.trackHeight;
          divisions = preset.defaultDivisions;
          showMilestones = preset.prefersMilestones;
        });
        addLog('Preset switched to ${preset.title}.');
        pushTimeline(
          'Preset Applied',
          '${preset.title} | divisions=$divisions | trackHeight=${fmt(customTrackHeight)}',
          preset.primary,
        );
      }

      void loadScenario(_TrackScenario scenario) {
        final _TrackPreset preset = presetForFamily(scenario.presetFamily);
        setState(() {
          selectedFamily = scenario.presetFamily;
          min = scenario.min;
          max = scenario.max;
          values = scenario.values;
          divisions = scenario.divisions;
          customTrackHeight = preset.trackHeight;
          customSegmentCount = math.max(12, scenario.divisions ~/ 2);
          showMilestones = preset.prefersMilestones;
          darkCanvas = scenario.gradient.first.computeLuminance() < 0.2;
          scenarioLoads += 1;
        });
        addLog('Loaded scenario ${scenario.title}.');
        pushTimeline(
          scenario.title,
          '${fmt(values.start)}${scenario.unit} -> ${fmt(values.end)}${scenario.unit}',
          preset.primary,
        );
      }

      final _TrackPreset selected = selectedPreset();
      final double span = values.end - values.start;
      final double normalizedStart =
          ((values.start - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final double normalizedEnd =
          ((values.end - min) / math.max(0.0001, max - min)).clamp(0, 1);
      final int safeDivisions = math.max(1, divisions);
      final double discreteStep = (max - min) / safeDivisions;
      final String stepLabel = fmt(discreteStep);

      final List<_MetricTile> metrics = <_MetricTile>[
        _MetricTile(
          label: 'Start',
          value: fmt(values.start),
          color: selected.primary,
        ),
        _MetricTile(
          label: 'End',
          value: fmt(values.end),
          color: selected.secondary,
        ),
        _MetricTile(
          label: 'Span',
          value: '${fmt(span)} units',
          color: const Color(0xFF6A1B9A),
        ),
        _MetricTile(
          label: 'Divisions',
          value: '$divisions',
          color: const Color(0xFF2E7D32),
        ),
        _MetricTile(
          label: 'Step',
          value: stepLabel,
          color: const Color(0xFFE65100),
        ),
        _MetricTile(
          label: 'Loads',
          value: '$scenarioLoads',
          color: const Color(0xFF455A64),
        ),
      ];

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

      Widget metricGrid() {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: metrics.map((m) {
            return Container(
              width: 118,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: m.color.withValues(alpha: 0.1),
                border: Border.all(color: m.color.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    m.label,
                    style: TextStyle(
                      color: m.color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    m.value,
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

      Widget previewPanel({
        required String title,
        required String subtitle,
        required SliderThemeData sliderTheme,
        required List<Color> gradient,
        required bool dense,
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
                  ? selected.primary.withValues(alpha: 0.48)
                  : selected.primary.withValues(alpha: 0.24),
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
                  labels: RangeLabels(fmt(values.start), fmt(values.end)),
                  values: values,
                  onChanged: enabled
                      ? (RangeValues v) {
                          setState(() {
                            values = v;
                          });
                          addLog('Panel "$title" changed to ${fmt(v.start)}-${fmt(v.end)}.');
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
                        'Active span: ${fmt(span)}',
                        style: TextStyle(
                          color: darkCanvas
                              ? const Color(0xFFD7E3F8)
                              : Colors.blueGrey.shade900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'step $stepLabel',
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

      Widget scenarioCard(_TrackScenario scenario) {
        final bool highlighted = scenario.presetFamily == selectedFamily;
        final _TrackPreset p = presetForFamily(scenario.presetFamily);
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
                  ? p.primary.withValues(alpha: 0.95)
                  : p.primary.withValues(alpha: 0.4),
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
                  _pill('Range', '${fmt(scenario.values.start)}-${fmt(scenario.values.end)}${scenario.unit}'),
                  _pill('Divisions', '${scenario.divisions}'),
                  _pill('Family', p.title),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => loadScenario(scenario),
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
              Expanded(flex: 2, child: cell('Signal', tint: const Color(0xFFF2F7FF), header: true)),
              Expanded(child: cell('Rounded', tint: const Color(0xFFF2F7FF), header: true)),
              Expanded(child: cell('Rectangular', tint: const Color(0xFFF2F7FF), header: true)),
              Expanded(child: cell('Segmented', tint: const Color(0xFFF2F7FF), header: true)),
            ],
          ),
        ];

        for (final _TrackComparisonRow row in comparisonRows) {
          rows.add(
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: cell(row.caption, tint: const Color(0xFFFBFDFF), header: true),
                ),
                Expanded(child: cell(row.rounded)),
                Expanded(child: cell(row.rectangular)),
                Expanded(child: cell(row.segmented)),
              ],
            ),
          );
        }

        return Column(children: rows);
      }

      Widget codeWalkthrough() {
        final String snippet =
            'SliderThemeData(\n'
            '  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),\n'
            '  trackHeight: 6,\n'
            '  activeTrackColor: const Color(0xFF1565C0),\n'
            '  inactiveTrackColor: const Color(0xFFBBDEFB),\n'
            ')\n\n'
            'SliderThemeData(\n'
            '  rangeTrackShape: const RectangularRangeSliderTrackShape(),\n'
            '  trackHeight: 8,\n'
            ')\n\n'
            'SliderThemeData(\n'
            '  rangeTrackShape: _SegmentedGlowTrackShape(\n'
            '    trackHeight: 10,\n'
            '    segmentCount: 36,\n'
            '  ),\n'
            ')';

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1220),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF24406F)),
          ),
          child: Text(
            snippet,
            style: const TextStyle(
              color: Color(0xFFD7E8FF),
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.35,
            ),
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
              'Timeline starts empty. Apply presets, load scenarios, and drag ranges to see event history.',
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
                    'No logs yet. Change controls or scenarios to populate diagnostics.',
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
                        child: Icon(Icons.linear_scale, color: selected.primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'RangeSliderTrackShape Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Interactive studio for selecting and understanding track geometries in Flutter RangeSlider themes.',
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
                      _pill('Preset', selected.title),
                      _pill('Family', selectedFamily.name),
                      _pill('Range', '${fmt(min)}..${fmt(max)}'),
                      _pill('Current', '${fmt(values.start)} -> ${fmt(values.end)}'),
                      _pill('TrackHeight', fmt(customTrackHeight)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Track Family Selector',
              subtitle:
                  'Choose built-in and custom RangeSliderTrackShape families and inspect practical usage guidance.',
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
                        onTap: () => applyPreset(preset),
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
                  metricGrid(),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Interactive Controls',
              subtitle:
                  'Tune the selected track shape: geometry, segmentation, contrast and behavior flags.',
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
                        child: _labeledSlider(
                          label: 'Track Height',
                          valueLabel: fmt(customTrackHeight),
                          min: 2,
                          max: 16,
                          divisions: 28,
                          value: customTrackHeight,
                          onChanged: (double v) {
                            setState(() {
                              customTrackHeight = v;
                            });
                            addLog('Track height set to ${fmt(v)}.');
                          },
                          color: selected.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _labeledSlider(
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
                            addLog('Divisions changed to $divisions.');
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
                        child: _labeledSlider(
                          label: 'Segment Count',
                          valueLabel: '$customSegmentCount',
                          min: 8,
                          max: 96,
                          divisions: 88,
                          value: customSegmentCount.toDouble(),
                          onChanged: (double v) {
                            setState(() {
                              customSegmentCount = v.round();
                            });
                            addLog('Segment count updated to $customSegmentCount.');
                          },
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _labeledSlider(
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
                                  addLog('Start adjusted manually to ${fmt(v)}.');
                                }
                              : null,
                          color: const Color(0xFF8E24AA),
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
                          subtitle: const Text('Disables all preview sliders when off.'),
                          onChanged: (bool v) {
                            setState(() {
                              enabled = v;
                            });
                            addLog(v ? 'Interaction enabled.' : 'Interaction disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showMilestones,
                          title: const Text('Milestone hints'),
                          subtitle: const Text('Shows quarter marks in diagnostics panel.'),
                          onChanged: (bool v) {
                            setState(() {
                              showMilestones = v;
                            });
                            addLog(v ? 'Milestones shown.' : 'Milestones hidden.');
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
                          value: darkCanvas,
                          title: const Text('Dark preview canvas'),
                          subtitle: const Text('Simulate dark-themed product surfaces.'),
                          onChanged: (bool v) {
                            setState(() {
                              darkCanvas = v;
                            });
                            addLog(v ? 'Dark canvas enabled.' : 'Dark canvas disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showDenseGuide,
                          title: const Text('Dense overlay guide'),
                          subtitle: const Text('Adds stronger panel borders and quick hints.'),
                          onChanged: (bool v) {
                            setState(() {
                              showDenseGuide = v;
                            });
                            addLog(v ? 'Dense guide on.' : 'Dense guide off.');
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
                          title: const Text('Comparison preview'),
                          subtitle: const Text('Shows an alternate panel for quick A/B checks.'),
                          onChanged: (bool v) {
                            setState(() {
                              showThirdPreview = v;
                            });
                            addLog(v ? 'Third preview enabled.' : 'Third preview hidden.');
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
              title: 'Live Visual Panels',
              subtitle:
                  'Observe how track shape and geometry alter the visual reading of active/inactive range sections.',
              icon: Icons.widgets,
            ),
            const SizedBox(height: 10),
            previewPanel(
              title: 'Primary Theme Preview',
              subtitle: 'Current preset with direct values and drag feedback.',
              sliderTheme: buildTheme(selected),
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF101820), const Color(0xFF1D2D44)]
                  : <Color>[const Color(0xFFFFFFFF), const Color(0xFFF4F8FF)],
              dense: showDenseGuide,
            ),
            const SizedBox(height: 12),
            previewPanel(
              title: 'Contrast Stress Preview',
              subtitle:
                  'Same values with higher contrast and emphasized track height to inspect readability in crowded UIs.',
              sliderTheme: buildTheme(selected, emphasize: true).copyWith(
                activeTrackColor: selected.primary.withValues(alpha: 1),
                inactiveTrackColor: (darkCanvas
                        ? const Color(0xFF90A4AE)
                        : const Color(0xFFB0BEC5))
                    .withValues(alpha: darkCanvas ? 0.4 : 0.75),
              ),
              gradient: darkCanvas
                  ? <Color>[const Color(0xFF0B0F1A), const Color(0xFF1E293B)]
                  : <Color>[const Color(0xFFEFF5FF), const Color(0xFFFFFFFF)],
              dense: true,
            ),
            if (showThirdPreview) ...<Widget>[
              const SizedBox(height: 12),
              previewPanel(
                title: 'Alternate Family Preview',
                subtitle: 'Quick compare against Rounded family baseline.',
                sliderTheme: buildTheme(presetForFamily(_TrackFamily.rounded)),
                gradient: darkCanvas
                    ? <Color>[const Color(0xFF132A13), const Color(0xFF1B4332)]
                    : <Color>[const Color(0xFFF3FFF7), const Color(0xFFE9FFF0)],
                dense: false,
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Domain Scenarios',
              subtitle:
                  'Load concrete use cases to observe which track family best communicates context and value semantics.',
              icon: Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(
              children: scenarios.map(scenarioCard).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Track Diagnostics Canvas',
              subtitle:
                  'Painter view of active/inactive zones, handles, and optional milestone hints based on current settings.',
              icon: Icons.insights,
            ),
            const SizedBox(height: 10),
            Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBDCF5)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: CustomPaint(
                  painter: _TrackDiagnosticsPainter(
                    preset: selected,
                    startNorm: normalizedStart,
                    endNorm: normalizedEnd,
                    startLabel: fmt(values.start),
                    endLabel: fmt(values.end),
                    divisions: divisions,
                    enabled: enabled,
                    showMilestones: showMilestones,
                    family: selectedFamily,
                    segmentCount: customSegmentCount,
                    trackHeight: customTrackHeight,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Comparison Matrix',
              subtitle:
                  'Behavior summary to guide when each RangeSliderTrackShape style should be selected.',
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
              title: 'Guide Cards',
              subtitle:
                  'Instructive notes about using track shape to communicate interaction semantics and visual hierarchy.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guideCards.map((g) {
                return Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: g.color.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(g.icon, color: g.color, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              g.title,
                              style: TextStyle(
                                color: g.color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        g.body,
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
              title: 'Code Walkthrough',
              subtitle:
                  'Core snippets: selecting rangeTrackShape in SliderThemeData and pairing with geometry and colors.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            codeWalkthrough(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Interaction Timeline',
              subtitle:
                  'Chronological snapshots for preset changes, scenario loads, and value adjustments.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle:
                  'Low-level event feed for interpreter-side behavior checks while interacting with range controls.',
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
                'Summary: RangeSliderTrackShape controls the rail language of RangeSlider. '
                'This demo compares RoundedRect, Rectangular, and a custom segmented glow implementation across realistic scenarios. '
                'By adjusting track height, segmentation, contrast, and range boundaries, you can intentionally design sliders '
                'that match domain tone while preserving readability and interaction confidence in interpreter-driven UIs.',
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

Widget _pill(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0xFFC6D6F3)),
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

Widget _labeledSlider({
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

class _TrackDiagnosticsPainter extends CustomPainter {
  _TrackDiagnosticsPainter({
    required this.preset,
    required this.startNorm,
    required this.endNorm,
    required this.startLabel,
    required this.endLabel,
    required this.divisions,
    required this.enabled,
    required this.showMilestones,
    required this.family,
    required this.segmentCount,
    required this.trackHeight,
  });

  final _TrackPreset preset;
  final double startNorm;
  final double endNorm;
  final String startLabel;
  final String endLabel;
  final int divisions;
  final bool enabled;
  final bool showMilestones;
  final _TrackFamily family;
  final int segmentCount;
  final double trackHeight;

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

    final double safeHeight = trackHeight.clamp(2, 20);
    final Rect track = Rect.fromLTWH(
      24,
      size.height * 0.6,
      size.width - 48,
      safeHeight,
    );

    final Paint baseTrack = Paint()
      ..color = const Color(0xFFC7D4E7)
      ..style = PaintingStyle.fill;

    final RRect rail = family == _TrackFamily.rectangular
        ? RRect.fromRectAndRadius(track, Radius.zero)
        : RRect.fromRectAndRadius(track, const Radius.circular(999));
    canvas.drawRRect(rail, baseTrack);

    final double sx = track.left + (track.width * startNorm);
    final double ex = track.left + (track.width * endNorm);
    final Rect activeRect = Rect.fromLTRB(sx, track.top, ex, track.bottom);

    final Paint active = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          preset.primary.withValues(alpha: enabled ? 0.78 : 0.45),
          preset.primary.withValues(alpha: enabled ? 1.0 : 0.6),
          preset.primary.withValues(alpha: enabled ? 0.78 : 0.45),
        ],
      ).createShader(activeRect);

    final RRect activeR = family == _TrackFamily.rectangular
        ? RRect.fromRectAndRadius(activeRect, Radius.zero)
        : RRect.fromRectAndRadius(activeRect, const Radius.circular(999));
    canvas.drawRRect(activeR, active);

    if (family == _TrackFamily.segmentedGlow) {
      final int seg = math.max(1, segmentCount);
      final double width = track.width / seg;
      for (int i = 1; i < seg; i++) {
        final double x = track.left + width * i;
        final bool inActive = x >= activeRect.left && x <= activeRect.right;
        canvas.drawLine(
          Offset(x, track.top + 0.8),
          Offset(x, track.bottom - 0.8),
          Paint()
            ..strokeWidth = 1
            ..color = inActive
                ? Colors.white.withValues(alpha: 0.33)
                : Colors.black.withValues(alpha: 0.12),
        );
      }
      canvas.drawRRect(
        activeR.inflate(1.2),
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
          ..color = preset.primary.withValues(alpha: enabled ? 0.28 : 0.16),
      );
    }

    final int safeDivisions = math.max(1, divisions);
    for (int i = 0; i <= safeDivisions; i++) {
      final double x = track.left + track.width * (i / safeDivisions);
      final bool milestone =
          showMilestones && safeDivisions >= 4 && i % (safeDivisions ~/ 4 == 0 ? 1 : safeDivisions ~/ 4) == 0;
      final double h = milestone ? 16 : 10;
      final Color c = milestone
          ? preset.primary.withValues(alpha: 0.65)
          : const Color(0xFF8FA4C2).withValues(alpha: 0.55);
      canvas.drawLine(
        Offset(x, track.bottom + 6),
        Offset(x, track.bottom + 6 + h),
        Paint()
          ..color = c
          ..strokeWidth = milestone ? 1.7 : 1,
      );
    }

    final Paint thumb = Paint()..color = preset.primary;
    canvas.drawCircle(Offset(sx, track.center.dy), 8, thumb);
    canvas.drawCircle(Offset(ex, track.center.dy), 8, thumb);
    canvas.drawCircle(
      Offset(sx, track.center.dy),
      13,
      Paint()..color = preset.primary.withValues(alpha: 0.12),
    );
    canvas.drawCircle(
      Offset(ex, track.center.dy),
      13,
      Paint()..color = preset.primary.withValues(alpha: 0.12),
    );

    final TextPainter topLabel = TextPainter(
      text: TextSpan(
        text: '${preset.title}  |  family=${family.name}  |  divisions=$divisions  |  height=${trackHeight.toStringAsFixed(1)}',
        style: const TextStyle(
          color: Color(0xFF294172),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 28);
    topLabel.paint(canvas, const Offset(14, 12));

    void paintBubble(Offset anchor, String text, Color color) {
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
      final Rect rect = Rect.fromLTWH(
        anchor.dx - t.width / 2 - 8,
        anchor.dy - 34,
        t.width + 16,
        22,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()..color = color,
      );
      t.paint(canvas, Offset(rect.left + 8, rect.top + 4));
      canvas.drawPath(
        Path()
          ..moveTo(anchor.dx - 5, rect.bottom)
          ..lineTo(anchor.dx + 5, rect.bottom)
          ..lineTo(anchor.dx, rect.bottom + 6)
          ..close(),
        Paint()..color = color,
      );
    }

    paintBubble(Offset(sx, track.top), startLabel, preset.primary.withValues(alpha: 0.9));
    paintBubble(Offset(ex, track.top), endLabel, preset.primary.withValues(alpha: 0.82));

    final TextPainter footer = TextPainter(
      text: TextSpan(
        text: enabled
            ? 'Track diagnostics active: drag handles in preview panels to verify active/inactive track redraw.'
            : 'Interaction disabled: this panel now previews passive visual state rendering.',
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
  bool shouldRepaint(covariant _TrackDiagnosticsPainter oldDelegate) {
    return oldDelegate.startNorm != startNorm ||
        oldDelegate.endNorm != endNorm ||
        oldDelegate.divisions != divisions ||
        oldDelegate.enabled != enabled ||
        oldDelegate.showMilestones != showMilestones ||
        oldDelegate.family != family ||
        oldDelegate.segmentCount != segmentCount ||
        oldDelegate.trackHeight != trackHeight ||
        oldDelegate.preset != preset ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel;
  }
}
