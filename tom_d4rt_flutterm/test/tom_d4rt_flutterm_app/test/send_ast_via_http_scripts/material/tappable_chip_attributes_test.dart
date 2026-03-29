import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ChipPreset {
  const _ChipPreset({
    required this.title,
    required this.subtitle,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.pressElevation,
    required this.enableTooltips,
    required this.denseMode,
    required this.note,
  });

  final String title;
  final String subtitle;
  final Color primary;
  final Color secondary;
  final Color surface;
  final double pressElevation;
  final bool enableTooltips;
  final bool denseMode;
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

class _MetricCard {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
}

class _TimelineEvent {
  const _TimelineEvent({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;
}

class _Snapshot {
  const _Snapshot({
    required this.id,
    required this.choiceIndex,
    required this.filterCount,
    required this.pressElevation,
    required this.note,
    required this.color,
  });

  final int id;
  final int choiceIndex;
  final int filterCount;
  final double pressElevation;
  final String note;
  final Color color;
}

class _MatrixRow {
  const _MatrixRow({
    required this.topic,
    required this.effect,
    required this.guidance,
  });

  final String topic;
  final String effect;
  final String guidance;
}

class _TapHeatPainter extends CustomPainter {
  _TapHeatPainter({
    required this.tapCounts,
    required this.primary,
  });

  final Map<String, int> tapCounts;
  final Color primary;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FAFE),
    );

    final List<String> keys = <String>[
      'raw',
      'input',
      'choice',
      'filter',
      'action',
      'disabled',
      'tooltip',
      'dense',
    ];

    final int maxCount = tapCounts.values.isEmpty ? 1 : tapCounts.values.reduce(math.max);
    final double cellWidth = (size.width - 24) / 4;
    final double cellHeight = (size.height - 30) / 2;

    for (int i = 0; i < keys.length; i++) {
      final int row = i ~/ 4;
      final int col = i % 4;
      final String key = keys[i];
      final int count = tapCounts[key] ?? 0;
      final double intensity = count / math.max(1, maxCount);

      final Rect rect = Rect.fromLTWH(
        12 + col * cellWidth,
        18 + row * cellHeight,
        cellWidth - 6,
        cellHeight - 8,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        Paint()..color = primary.withValues(alpha: 0.1 + intensity * 0.7),
      );

      final TextPainter label = TextPainter(
        text: TextSpan(
          text: '$key\n$count taps',
          style: TextStyle(
            color: const Color(0xFF123053),
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 6);

      label.paint(
        canvas,
        Offset(
          rect.left + (rect.width - label.width) / 2,
          rect.top + (rect.height - label.height) / 2,
        ),
      );
    }

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'Tap Intensity Map',
        style: TextStyle(
          color: Color(0xFF1A3458),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 12);
    title.paint(canvas, const Offset(8, 3));
  }

  @override
  bool shouldRepaint(covariant _TapHeatPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.tapCounts.toString() != tapCounts.toString();
  }
}

dynamic build(BuildContext context) {
  final DateTime startedAt = DateTime.now();

  final List<_ChipPreset> presets = <_ChipPreset>[
    const _ChipPreset(
      title: 'Balanced Actions',
      subtitle: 'General productivity interface with moderate emphasis.',
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF64B5F6),
      surface: Color(0xFFF4F8FF),
      pressElevation: 6,
      enableTooltips: true,
      denseMode: false,
      note: 'Balanced profile for most app-level interaction chips.',
    ),
    const _ChipPreset(
      title: 'Dense Tag Console',
      subtitle: 'Compact filtering workspace with high density.',
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFA5D6A7),
      surface: Color(0xFFF1F8F3),
      pressElevation: 4,
      enableTooltips: false,
      denseMode: true,
      note: 'Optimized for power-user screens with many quick chip toggles.',
    ),
    const _ChipPreset(
      title: 'High Contrast Ops',
      subtitle: 'Operational dashboard with strong press feedback.',
      primary: Color(0xFFE65100),
      secondary: Color(0xFFFFB74D),
      surface: Color(0xFFFFF7EE),
      pressElevation: 10,
      enableTooltips: true,
      denseMode: false,
      note: 'Highlights pressed state for mission-critical actions.',
    ),
    const _ChipPreset(
      title: 'Slate Review Mode',
      subtitle: 'Review board with subdued but clear interactions.',
      primary: Color(0xFF455A64),
      secondary: Color(0xFFB0BEC5),
      surface: Color(0xFFF2F5F7),
      pressElevation: 5,
      enableTooltips: true,
      denseMode: true,
      note: 'Good for audit trails where chips support metadata operations.',
    ),
    const _ChipPreset(
      title: 'Creative Highlight',
      subtitle: 'Expressive chips for ideation and categorization.',
      primary: Color(0xFF6A1B9A),
      secondary: Color(0xFFCE93D8),
      surface: Color(0xFFF8F1FF),
      pressElevation: 7,
      enableTooltips: true,
      denseMode: false,
      note: 'Adds visual energy while preserving tappable clarity.',
    ),
  ];

  final List<_GuideCard> guides = <_GuideCard>[
    const _GuideCard(
      title: 'What TappableChipAttributes Covers',
      body:
          'TappableChipAttributes defines tap-related chip behavior such as onPressed handling, pressElevation feedback, and tooltip support.',
      icon: Icons.touch_app,
      color: Color(0xFF1565C0),
    ),
    const _GuideCard(
      title: 'Press Elevation Purpose',
      body:
          'Press elevation adds tactile depth during interaction; tune it to reinforce feedback without creating visual noise.',
      icon: Icons.layers,
      color: Color(0xFF6A1B9A),
    ),
    const _GuideCard(
      title: 'Tooltip Guidance',
      body:
          'Tooltips are critical for chips with short labels; they improve discoverability and accessibility on dense surfaces.',
      icon: Icons.info_outline,
      color: Color(0xFF2E7D32),
    ),
    const _GuideCard(
      title: 'Disabled Semantics',
      body:
          'A chip with null onPressed should clearly communicate non-interactive state through color and hierarchy.',
      icon: Icons.block,
      color: Color(0xFFE65100),
    ),
    const _GuideCard(
      title: 'Chip Family Consistency',
      body:
          'RawChip, InputChip, ChoiceChip, FilterChip, and ActionChip can share tappable semantics while serving different UX intents.',
      icon: Icons.hub,
      color: Color(0xFF00838F),
    ),
    const _GuideCard(
      title: 'Interpreter Validation Goal',
      body:
          'This deep demo validates live chip interactions under interpreter execution rather than framework internals.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
  ];

  final List<_MatrixRow> matrixRows = <_MatrixRow>[
    const _MatrixRow(
      topic: 'onPressed != null',
      effect: 'Chip becomes interactive with tactile feedback.',
      guidance: 'Use for immediate actions where single-tap execution is expected.',
    ),
    const _MatrixRow(
      topic: 'onPressed == null',
      effect: 'Chip is visually and semantically disabled.',
      guidance: 'Reserve for unavailable states and explain why with helper text.',
    ),
    const _MatrixRow(
      topic: 'Higher pressElevation',
      effect: 'Pressed state appears stronger and more prominent.',
      guidance: 'Apply in contexts where action confirmation should feel explicit.',
    ),
    const _MatrixRow(
      topic: 'Tooltip enabled',
      effect: 'Long-press or hover reveals contextual details.',
      guidance: 'Use for abbreviations, tags, and compact action labels.',
    ),
    const _MatrixRow(
      topic: 'Dense chip layout',
      effect: 'Higher information density, less whitespace.',
      guidance: 'Pair with concise labels and optional search/filter support.',
    ),
    const _MatrixRow(
      topic: 'Mixed chip families',
      effect: 'Different behaviors can coexist with shared interaction language.',
      guidance: 'Unify colors and elevation values to maintain consistent UX.',
    ),
  ];

  Color primary = const Color(0xFF1565C0);
  Color secondary = const Color(0xFF64B5F6);
  Color surface = const Color(0xFFF4F8FF);

  bool enableTooltips = true;
  bool denseMode = false;
  bool highContrast = false;
  bool showThirdBoard = true;
  bool showHeatmap = true;
  bool chipActionsEnabled = true;
  bool showDisabledSamples = true;
  bool showLongLabels = false;

  double pressElevation = 6;
  double selectedShadow = 0.2;
  double borderRadius = 16;
  double labelScale = 1;
  int chipCount = 10;

  int choiceIndex = 0;
  bool inputSelected = false;
  bool filterA = true;
  bool filterB = false;
  bool filterC = true;
  bool filterD = false;

  int presetLoads = 0;
  int tapEvents = 0;
  int styleChanges = 0;
  int snapshotId = 0;

  final Map<String, int> tapMap = <String, int>{
    'raw': 0,
    'input': 0,
    'choice': 0,
    'filter': 0,
    'action': 0,
    'disabled': 0,
    'tooltip': 0,
    'dense': 0,
  };

  final List<String> console = <String>[];
  final List<_TimelineEvent> timeline = <_TimelineEvent>[];
  final List<_Snapshot> snapshots = <_Snapshot>[];

  void addLog(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    console.insert(0, '[$stamp] $message');
    if (console.length > 180) {
      console.removeLast();
    }
  }

  void addEvent(String title, String detail, Color color) {
    timeline.insert(0, _TimelineEvent(title: title, detail: detail, color: color));
    if (timeline.length > 40) {
      timeline.removeLast();
    }
  }

  void bumpTap(String key) {
    tapMap[key] = (tapMap[key] ?? 0) + 1;
    tapEvents += 1;
  }

  int selectedFilterCount() {
    int count = 0;
    if (filterA) count++;
    if (filterB) count++;
    if (filterC) count++;
    if (filterD) count++;
    return count;
  }

  void captureSnapshot(String note) {
    snapshotId += 1;
    snapshots.insert(
      0,
      _Snapshot(
        id: snapshotId,
        choiceIndex: choiceIndex,
        filterCount: selectedFilterCount(),
        pressElevation: pressElevation,
        note: note,
        color: primary,
      ),
    );
    if (snapshots.length > 24) {
      snapshots.removeLast();
    }
  }

  String f(double value) {
    if ((value - value.roundToDouble()).abs() < 0.0001) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  Color activeFill() {
    return highContrast ? primary.withValues(alpha: 0.3) : primary.withValues(alpha: 0.18);
  }

  TextStyle chipTextStyle() {
    return TextStyle(
      fontSize: (12 * labelScale).clamp(10, 18),
      fontWeight: denseMode ? FontWeight.w600 : FontWeight.w700,
      color: highContrast ? primary.withValues(alpha: 1) : primary.withValues(alpha: 0.95),
    );
  }

  Tooltip? maybeTooltip({required String message, required Widget child}) {
    if (!enableTooltips) {
      return null;
    }
    return Tooltip(message: message, child: child);
  }

  Widget wrapTooltip({required String message, required Widget child}) {
    final Tooltip? wrapped = maybeTooltip(message: message, child: child);
    return wrapped ?? child;
  }

  Widget sectionTitle(String title, String subtitle, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.15),
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
                style: TextStyle(color: primary, fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget chipBadge(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFC8D8EE)),
        color: Colors.white.withValues(alpha: 0.82),
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

  Widget metricGrid(List<_MetricCard> metrics) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: metrics.map((metric) {
        return Container(
          width: 132,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: metric.color.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: metric.color.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                metric.label,
                style: TextStyle(color: metric.color, fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                metric.value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget sliderControl({
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
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
              ),
              Text(valueLabel, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
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

  Widget presetCard(_ChipPreset preset, void Function(void Function()) setState) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[preset.primary.withValues(alpha: 0.1), Colors.white],
        ),
        border: Border.all(color: preset.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            preset.title,
            style: TextStyle(color: preset.primary, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(
            preset.subtitle,
            style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3),
          ),
          const SizedBox(height: 8),
          Text(
            preset.note,
            style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12, height: 1.34),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              chipBadge('Press', f(preset.pressElevation)),
              chipBadge('Tooltips', preset.enableTooltips ? 'on' : 'off'),
              chipBadge('Dense', preset.denseMode ? 'yes' : 'no'),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  primary = preset.primary;
                  secondary = preset.secondary;
                  surface = preset.surface;
                  pressElevation = preset.pressElevation;
                  enableTooltips = preset.enableTooltips;
                  denseMode = preset.denseMode;
                  presetLoads += 1;
                  styleChanges += 1;
                });
                addLog('Loaded preset ${preset.title}.');
                addEvent('Preset loaded', preset.title, preset.primary);
                captureSnapshot('Loaded ${preset.title}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Preset'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRawChipSet(void Function(void Function()) setState, {required bool compact}) {
    final List<Widget> chips = <Widget>[];
    final int count = chipCount.clamp(4, 14);
    for (int i = 0; i < count; i++) {
      final bool enabled = chipActionsEnabled || (i % 3 != 0);
      final String label = showLongLabels ? 'Raw action chip ${i + 1}' : 'Raw ${i + 1}';
      final Widget chip = RawChip(
        label: Text(label, style: chipTextStyle()),
        tooltip: enableTooltips ? 'RawChip $i action' : null,
        onPressed: enabled
            ? () {
                setState(() {
                  bumpTap('raw');
                });
                addLog('RawChip tapped: $i');
                addEvent('RawChip tap', 'Raw chip $i activated', primary);
              }
            : null,
        pressElevation: pressElevation,
        backgroundColor: secondary.withValues(alpha: compact ? 0.18 : 0.14),
        side: BorderSide(color: primary.withValues(alpha: enabled ? 0.3 : 0.14)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.clamp(6, 28)),
        ),
      );
      chips.add(wrapTooltip(message: 'raw-$i', child: chip));
    }
    return chips;
  }

  Widget chipPanel({
    required String title,
    required String subtitle,
    required Color panelColor,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: panelColor.withValues(alpha: 0.36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: panelColor, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.blueGrey.shade700)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget selectableBoard(void Function(void Function()) setState, {required bool compact}) {
    return chipPanel(
      title: compact ? 'Dense Selection Board' : 'Selection Matrix Board',
      subtitle: compact
          ? 'Compact chip interactions for high-density operations.'
          : 'Raw, choice, filter, and input chip patterns using tappable attributes.',
      panelColor: primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: denseMode ? 6 : 10,
            runSpacing: denseMode ? 6 : 10,
            children: buildRawChipSet(setState, compact: compact),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: denseMode ? 6 : 10,
            runSpacing: denseMode ? 6 : 10,
            children: <Widget>[
              wrapTooltip(
                message: 'input-chip-toggle',
                child: InputChip(
                  label: Text(showLongLabels ? 'Input Assignee' : 'Input', style: chipTextStyle()),
                  selected: inputSelected,
                  tooltip: enableTooltips ? 'Toggle input chip' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          setState(() {
                            inputSelected = value;
                            bumpTap('input');
                          });
                          addLog('InputChip selected=$value');
                          addEvent('InputChip', 'Input chip toggled', primary);
                        }
                      : null,
                  onPressed: chipActionsEnabled
                      ? () {
                          setState(() {
                            inputSelected = !inputSelected;
                            bumpTap('input');
                          });
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'choice-chip-0',
                child: ChoiceChip(
                  label: Text(showLongLabels ? 'Choice: Planning' : 'Plan', style: chipTextStyle()),
                  selected: choiceIndex == 0,
                  tooltip: enableTooltips ? 'Choose planning' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          if (!value) return;
                          setState(() {
                            choiceIndex = 0;
                            bumpTap('choice');
                          });
                          addEvent('ChoiceChip', 'Selected planning mode', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'choice-chip-1',
                child: ChoiceChip(
                  label: Text(showLongLabels ? 'Choice: Execution' : 'Exec', style: chipTextStyle()),
                  selected: choiceIndex == 1,
                  tooltip: enableTooltips ? 'Choose execution' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          if (!value) return;
                          setState(() {
                            choiceIndex = 1;
                            bumpTap('choice');
                          });
                          addEvent('ChoiceChip', 'Selected execution mode', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'choice-chip-2',
                child: ChoiceChip(
                  label: Text(showLongLabels ? 'Choice: Review' : 'Review', style: chipTextStyle()),
                  selected: choiceIndex == 2,
                  tooltip: enableTooltips ? 'Choose review' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          if (!value) return;
                          setState(() {
                            choiceIndex = 2;
                            bumpTap('choice');
                          });
                          addEvent('ChoiceChip', 'Selected review mode', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: denseMode ? 6 : 10,
            runSpacing: denseMode ? 6 : 10,
            children: <Widget>[
              wrapTooltip(
                message: 'filter-chip-a',
                child: FilterChip(
                  label: Text(showLongLabels ? 'Filter: Active Issues' : 'Active', style: chipTextStyle()),
                  selected: filterA,
                  tooltip: enableTooltips ? 'Toggle active filter' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          setState(() {
                            filterA = value;
                            bumpTap('filter');
                          });
                          addEvent('FilterChip', 'Active filter set to $value', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'filter-chip-b',
                child: FilterChip(
                  label: Text(showLongLabels ? 'Filter: Blocked Tasks' : 'Blocked', style: chipTextStyle()),
                  selected: filterB,
                  tooltip: enableTooltips ? 'Toggle blocked filter' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          setState(() {
                            filterB = value;
                            bumpTap('filter');
                          });
                          addEvent('FilterChip', 'Blocked filter set to $value', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'filter-chip-c',
                child: FilterChip(
                  label: Text(showLongLabels ? 'Filter: Waiting Review' : 'Review', style: chipTextStyle()),
                  selected: filterC,
                  tooltip: enableTooltips ? 'Toggle review filter' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          setState(() {
                            filterC = value;
                            bumpTap('filter');
                          });
                          addEvent('FilterChip', 'Review filter set to $value', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
              wrapTooltip(
                message: 'filter-chip-d',
                child: FilterChip(
                  label: Text(showLongLabels ? 'Filter: Archived Tags' : 'Archived', style: chipTextStyle()),
                  selected: filterD,
                  tooltip: enableTooltips ? 'Toggle archived filter' : null,
                  pressElevation: pressElevation,
                  onSelected: chipActionsEnabled
                      ? (bool value) {
                          setState(() {
                            filterD = value;
                            bumpTap('filter');
                          });
                          addEvent('FilterChip', 'Archived filter set to $value', primary);
                        }
                      : null,
                  selectedColor: activeFill(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commandBoard(void Function(void Function()) setState, {required bool compact}) {
    final List<Widget> actionChips = <Widget>[];
    final int count = chipCount.clamp(5, 12);
    for (int i = 0; i < count; i++) {
      final bool enabled = chipActionsEnabled || (i % 4 != 0);
      final String label = showLongLabels ? 'Action Command ${i + 1}' : 'Cmd ${i + 1}';
      actionChips.add(
        wrapTooltip(
          message: 'action-chip-$i',
          child: ActionChip(
            label: Text(label, style: chipTextStyle()),
            tooltip: enableTooltips ? 'Execute command $i' : null,
            pressElevation: pressElevation,
            onPressed: enabled
                ? () {
                    setState(() {
                      bumpTap('action');
                    });
                    addLog('ActionChip triggered: $label');
                    addEvent('ActionChip', 'Executed $label', secondary);
                  }
                : null,
            backgroundColor: secondary.withValues(alpha: compact ? 0.18 : 0.14),
            side: BorderSide(color: primary.withValues(alpha: enabled ? 0.3 : 0.12)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.clamp(6, 28)),
            ),
          ),
        ),
      );
    }

    return chipPanel(
      title: compact ? 'Compact Command Tray' : 'Action Command Tray',
      subtitle: compact
          ? 'Dense quick actions using tappable chip semantics.'
          : 'ActionChip-focused board for immediate one-tap operations.',
      panelColor: secondary,
      child: Wrap(
        spacing: denseMode ? 6 : 10,
        runSpacing: denseMode ? 6 : 10,
        children: actionChips,
      ),
    );
  }

  Widget disabledBoard(void Function(void Function()) setState) {
    return chipPanel(
      title: 'Disabled + Tooltip Accessibility Board',
      subtitle:
          'Compare disabled and enabled states while validating tooltip content for assistive context.',
      panelColor: const Color(0xFF455A64),
      child: Wrap(
        spacing: denseMode ? 6 : 10,
        runSpacing: denseMode ? 6 : 10,
        children: <Widget>[
          wrapTooltip(
            message: 'disabled-raw-sample',
            child: RawChip(
              label: Text('Disabled Raw', style: chipTextStyle()),
              tooltip: enableTooltips ? 'Raw chip unavailable' : null,
              onPressed: null,
              pressElevation: pressElevation,
              backgroundColor: const Color(0xFFECEFF1),
            ),
          ),
          wrapTooltip(
            message: 'disabled-action-sample',
            child: ActionChip(
              label: Text('Disabled Action', style: chipTextStyle()),
              tooltip: enableTooltips ? 'Action unavailable' : null,
              onPressed: null,
              pressElevation: pressElevation,
              backgroundColor: const Color(0xFFECEFF1),
            ),
          ),
          wrapTooltip(
            message: 'tooltip-enabled-sample',
            child: RawChip(
              label: Text('Tooltip sample', style: chipTextStyle()),
              tooltip: enableTooltips ? 'Shows extra contextual explanation' : null,
              onPressed: chipActionsEnabled
                  ? () {
                      setState(() {
                        bumpTap('tooltip');
                      });
                      addLog('Tooltip sample chip tapped.');
                      addEvent('Tooltip sample', 'Tooltip chip activated', const Color(0xFF455A64));
                    }
                  : null,
              pressElevation: pressElevation,
              backgroundColor: secondary.withValues(alpha: 0.12),
            ),
          ),
          wrapTooltip(
            message: 'dense-sample',
            child: RawChip(
              label: Text('Dense sample', style: chipTextStyle()),
              tooltip: enableTooltips ? 'Dense interaction sample' : null,
              onPressed: chipActionsEnabled
                  ? () {
                      setState(() {
                        bumpTap('dense');
                      });
                      addEvent('Dense sample', 'Dense chip activated', const Color(0xFF455A64));
                    }
                  : null,
              pressElevation: pressElevation,
              backgroundColor: secondary.withValues(alpha: 0.18),
            ),
          ),
          if (showDisabledSamples)
            wrapTooltip(
              message: 'disabled-filter-sample',
              child: FilterChip(
                label: Text('Disabled Filter', style: chipTextStyle()),
                selected: false,
                tooltip: enableTooltips ? 'Filter unavailable in this mode' : null,
                onSelected: null,
                pressElevation: pressElevation,
              ),
            ),
        ],
      ),
    );
  }

  Widget matrixTable() {
    Widget cell(String text, {bool header = false, Color? tint}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDCE7F5)),
          color: tint,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: header ? FontWeight.w800 : FontWeight.w500,
            fontSize: header ? 13 : 12,
          ),
        ),
      );
    }

    final List<Widget> rows = <Widget>[
      Row(
        children: <Widget>[
          Expanded(flex: 2, child: cell('Topic', header: true, tint: const Color(0xFFF0F6FF))),
          Expanded(flex: 3, child: cell('Effect', header: true, tint: const Color(0xFFF0F6FF))),
          Expanded(flex: 3, child: cell('Guidance', header: true, tint: const Color(0xFFF0F6FF))),
        ],
      ),
    ];

    for (final _MatrixRow row in matrixRows) {
      rows.add(
        Row(
          children: <Widget>[
            Expanded(flex: 2, child: cell(row.topic, tint: const Color(0xFFFBFDFF), header: true)),
            Expanded(flex: 3, child: cell(row.effect)),
            Expanded(flex: 3, child: cell(row.guidance)),
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
          color: const Color(0xFFF5F8FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD9E5F4)),
        ),
        child: Text(
          'Timeline empty. Tap chips, load presets, and toggle settings to capture interaction flow.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return Column(
      children: timeline.map((event) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: event.color.withValues(alpha: 0.08),
            border: Border.all(color: event.color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: event.color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.title,
                      style: TextStyle(color: event.color, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(event.detail, style: TextStyle(color: Colors.blueGrey.shade800, height: 1.3)),
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
          color: const Color(0xFFF7FAFD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDDE8F5)),
        ),
        child: Text(
          'No snapshots captured yet. Use Capture Snapshot to store current chip interaction state.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return Column(
      children: snapshots.map((snapshot) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: snapshot.color.withValues(alpha: 0.08),
            border: Border.all(color: snapshot.color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Snapshot #${snapshot.id} | choice ${snapshot.choiceIndex} | filters ${snapshot.filterCount}',
                style: TextStyle(color: snapshot.color, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 3),
              Text(
                'pressElevation ${f(snapshot.pressElevation)}',
                style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(snapshot.note, style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget consolePanel() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1321),
        borderRadius: BorderRadius.circular(12),
      ),
      child: console.isEmpty
          ? const Center(
              child: Text(
                'No logs yet. Trigger chip actions and selection changes to populate diagnostics.',
                style: TextStyle(color: Color(0xFFB7C9EA), fontWeight: FontWeight.w600),
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
                      color: Color(0xFFD4E5FF),
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
      final List<_MetricCard> metrics = <_MetricCard>[
        _MetricCard(label: 'Tap events', value: '$tapEvents', color: primary),
        _MetricCard(label: 'Choice index', value: '$choiceIndex', color: const Color(0xFF6A1B9A)),
        _MetricCard(label: 'Filters on', value: '${selectedFilterCount()}', color: const Color(0xFF2E7D32)),
        _MetricCard(label: 'Press elev.', value: f(pressElevation), color: const Color(0xFF00838F)),
        _MetricCard(label: 'Chip count', value: '$chipCount', color: const Color(0xFFE65100)),
        _MetricCard(label: 'Label scale', value: f(labelScale), color: const Color(0xFF455A64)),
        _MetricCard(label: 'Radius', value: f(borderRadius), color: const Color(0xFF283593)),
        _MetricCard(label: 'Shadow mix', value: f(selectedShadow), color: const Color(0xFFAD1457)),
        _MetricCard(label: 'Preset loads', value: '$presetLoads', color: const Color(0xFF5D4037)),
        _MetricCard(label: 'Style changes', value: '$styleChanges', color: const Color(0xFF1565C0)),
        _MetricCard(label: 'Tooltips', value: enableTooltips ? 'on' : 'off', color: const Color(0xFF827717)),
        _MetricCard(label: 'Dense', value: denseMode ? 'yes' : 'no', color: const Color(0xFF37474F)),
      ];

      return Container(
        color: surface,
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
                  colors: <Color>[Color(0xFFE6F0FF), Color(0xFFF2E8FF)],
                ),
                border: Border.all(color: const Color(0xFFC6D8F5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.touch_app, color: primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'TappableChipAttributes Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Chip Interaction Lab demonstrating tap behavior, press elevation, tooltip usage, and disabled/active semantics across chip families that implement TappableChipAttributes.',
                              style: TextStyle(color: Colors.blueGrey.shade700, height: 1.34),
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
                      chipBadge('Press', f(pressElevation)),
                      chipBadge('Filters', '${selectedFilterCount()}'),
                      chipBadge('Choice', '$choiceIndex'),
                      chipBadge('Tooltips', enableTooltips ? 'on' : 'off'),
                      chipBadge('Dense', denseMode ? 'yes' : 'no'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Preset Profiles',
              'Load curated chip interaction styles to compare tactile and accessibility behavior.',
              Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((preset) => presetCard(preset, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              'Interaction Controls',
              'Adjust TappableChipAttributes-related properties and watch all boards update in real time.',
              Icons.tune,
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
                        child: sliderControl(
                          label: 'Press elevation',
                          valueLabel: f(pressElevation),
                          min: 0,
                          max: 16,
                          divisions: 160,
                          value: pressElevation,
                          onChanged: (double value) {
                            setState(() {
                              pressElevation = value;
                              styleChanges += 1;
                            });
                            addLog('Press elevation set to ${f(pressElevation)}.');
                          },
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Border radius',
                          valueLabel: f(borderRadius),
                          min: 6,
                          max: 28,
                          divisions: 88,
                          value: borderRadius,
                          onChanged: (double value) {
                            setState(() {
                              borderRadius = value;
                              styleChanges += 1;
                            });
                            addLog('Border radius set to ${f(borderRadius)}.');
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
                        child: sliderControl(
                          label: 'Label scale',
                          valueLabel: f(labelScale),
                          min: 0.8,
                          max: 1.6,
                          divisions: 80,
                          value: labelScale,
                          onChanged: (double value) {
                            setState(() {
                              labelScale = value;
                              styleChanges += 1;
                            });
                            addLog('Label scale set to ${f(labelScale)}.');
                          },
                          color: const Color(0xFF6A1B9A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Selected shadow mix',
                          valueLabel: f(selectedShadow),
                          min: 0,
                          max: 0.6,
                          divisions: 60,
                          value: selectedShadow,
                          onChanged: (double value) {
                            setState(() {
                              selectedShadow = value;
                              styleChanges += 1;
                            });
                            addLog('Selected shadow mix set to ${f(selectedShadow)}.');
                          },
                          color: const Color(0xFF00838F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: sliderControl(
                          label: 'Chip count',
                          valueLabel: '$chipCount',
                          min: 4,
                          max: 14,
                          divisions: 10,
                          value: chipCount.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              chipCount = value.round();
                              styleChanges += 1;
                            });
                            addLog('Chip count set to $chipCount.');
                          },
                          color: const Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFD7E3F4)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    choiceIndex = 0;
                                    filterA = true;
                                    filterB = false;
                                    filterC = true;
                                    filterD = false;
                                  });
                                  addLog('Selection state reset.');
                                },
                                child: const Text('Reset Selection'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    chipActionsEnabled = !chipActionsEnabled;
                                  });
                                  addLog(chipActionsEnabled ? 'Chip actions enabled.' : 'Chip actions disabled.');
                                },
                                child: const Text('Toggle Actions'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  captureSnapshot('Manual snapshot');
                                  addLog('Snapshot captured.');
                                },
                                child: const Text('Capture Snapshot'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: chipActionsEnabled,
                          title: const Text('Chip actions enabled'),
                          subtitle: const Text('Enable/disable primary tap callbacks.'),
                          onChanged: (bool value) {
                            setState(() {
                              chipActionsEnabled = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Primary callbacks enabled.' : 'Primary callbacks disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: enableTooltips,
                          title: const Text('Enable tooltips'),
                          subtitle: const Text('Show chip tooltip hints.'),
                          onChanged: (bool value) {
                            setState(() {
                              enableTooltips = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Tooltips enabled.' : 'Tooltips disabled.');
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
                          value: denseMode,
                          title: const Text('Dense mode'),
                          subtitle: const Text('Compact chip spacing and labels.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseMode = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Dense mode enabled.' : 'Dense mode disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: highContrast,
                          title: const Text('High contrast'),
                          subtitle: const Text('Boost active chip readability.'),
                          onChanged: (bool value) {
                            setState(() {
                              highContrast = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'High contrast enabled.' : 'High contrast disabled.');
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
                          value: showDisabledSamples,
                          title: const Text('Show disabled samples'),
                          subtitle: const Text('Include extra disabled chip variants.'),
                          onChanged: (bool value) {
                            setState(() {
                              showDisabledSamples = value;
                            });
                            addLog(value ? 'Disabled samples shown.' : 'Disabled samples hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showLongLabels,
                          title: const Text('Long labels'),
                          subtitle: const Text('Use descriptive chip labels.'),
                          onChanged: (bool value) {
                            setState(() {
                              showLongLabels = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Long labels enabled.' : 'Long labels disabled.');
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
                          value: showThirdBoard,
                          title: const Text('Show third board'),
                          subtitle: const Text('Enable compact command board.'),
                          onChanged: (bool value) {
                            setState(() {
                              showThirdBoard = value;
                            });
                            addLog(value ? 'Third board shown.' : 'Third board hidden.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: showHeatmap,
                          title: const Text('Show tap heatmap'),
                          subtitle: const Text('Render interaction intensity map.'),
                          onChanged: (bool value) {
                            setState(() {
                              showHeatmap = value;
                            });
                            addLog(value ? 'Tap heatmap shown.' : 'Tap heatmap hidden.');
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
              'Chip Boards',
              'Multiple visual boards demonstrating tappable behavior across chip families and interaction contexts.',
              Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            selectableBoard(setState, compact: false),
            const SizedBox(height: 12),
            commandBoard(setState, compact: false),
            if (showThirdBoard) ...<Widget>[
              const SizedBox(height: 12),
              commandBoard(setState, compact: true),
            ],
            const SizedBox(height: 12),
            disabledBoard(setState),
            if (showHeatmap) ...<Widget>[
              const SizedBox(height: 18),
              sectionTitle(
                'Tap Heat Diagnostics',
                'Custom painter showing interaction intensity across chip categories.',
                Icons.thermostat,
              ),
              const SizedBox(height: 10),
              Container(
                height: 190,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD4E0F2)),
                ),
                child: CustomPaint(
                  painter: _TapHeatPainter(
                    tapCounts: tapMap,
                    primary: primary,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              'Inspector',
              'Metrics and implementation hints for TappableChipAttributes-driven component design.',
              Icons.analytics,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD7E3F4)),
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
                      border: Border.all(color: const Color(0xFF26476E)),
                    ),
                    child: Text(
                      'RawChip(\n'
                      '  onPressed: ${chipActionsEnabled ? 'callback' : 'null'},\n'
                      '  pressElevation: ${f(pressElevation)},\n'
                      '  tooltip: ${enableTooltips ? 'enabled' : 'disabled'},\n'
                      ')\n\n'
                      'Choice index: $choiceIndex\n'
                      'Filters selected: ${selectedFilterCount()}\n'
                      'chipCount: $chipCount\n'
                      'labelScale: ${f(labelScale)}\n'
                      'denseMode: ${denseMode ? 'true' : 'false'}\n'
                      'tapEvents: $tapEvents\n'
                      'styleChanges: $styleChanges',
                      style: const TextStyle(
                        color: Color(0xFFD5E7FF),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.34,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Guidance Cards',
              'Recommendations for choosing tap behavior, elevation, and tooltip strategy.',
              Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: guides.map((guide) {
                return Container(
                  width: 304,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: guide.color.withValues(alpha: 0.28)),
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
                              style: TextStyle(color: guide.color, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        guide.body,
                        style: TextStyle(color: Colors.blueGrey.shade800, height: 1.32, fontSize: 13),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Behavior Matrix',
              'Mapping of TappableChipAttributes choices to interaction outcomes and implementation guidance.',
              Icons.table_chart,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD7E3F4)),
              ),
              child: matrixTable(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Snapshots',
              'Captured chip states for comparing tap and selection behavior over time.',
              Icons.camera,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Timeline',
              'Event stream of chip taps, selection updates, and preset loads.',
              Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Diagnostics Console',
              'Low-level interaction trace for interpreter-side validation.',
              Icons.terminal,
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
                'Summary: TappableChipAttributes governs how chips react to taps, convey pressed depth, and communicate context through tooltips. '
                'This deep demo shows these semantics across RawChip, InputChip, ChoiceChip, FilterChip, and ActionChip using multiple visual boards, '
                'live controls, diagnostics, and interaction telemetry. It is a practical reference for designing consistent chip interactions '
                'in interpreter-driven Flutter applications.',
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
              style: TextStyle(color: Colors.blueGrey.shade600, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    },
  );
}
