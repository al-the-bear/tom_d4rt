import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ThemePreset {
  const _ThemePreset({
    required this.title,
    required this.subtitle,
    required this.primary,
    required this.secondary,
    required this.scaffold,
    required this.indicatorKind,
    required this.tabAlignment,
    required this.isScrollable,
    required this.indicatorSize,
    required this.note,
  });

  final String title;
  final String subtitle;
  final Color primary;
  final Color secondary;
  final Color scaffold;
  final _IndicatorKind indicatorKind;
  final TabAlignment tabAlignment;
  final bool isScrollable;
  final TabBarIndicatorSize indicatorSize;
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

class _Snapshot {
  const _Snapshot({
    required this.id,
    required this.activeIndex,
    required this.isScrollable,
    required this.indicatorKind,
    required this.note,
    required this.color,
  });

  final int id;
  final int activeIndex;
  final bool isScrollable;
  final _IndicatorKind indicatorKind;
  final String note;
  final Color color;
}

enum _IndicatorKind {
  underline,
  pill,
  segmented,
  framed,
}

class _IndicatorPreviewPainter extends CustomPainter {
  _IndicatorPreviewPainter({
    required this.kind,
    required this.primary,
    required this.secondary,
    required this.progress,
  });

  final _IndicatorKind kind;
  final Color primary;
  final Color secondary;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect area = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(area, const Radius.circular(12)),
      Paint()..color = const Color(0xFFF8FAFE),
    );

    final double left = 18;
    final double top = 28;
    final double width = size.width - 36;
    final double slotWidth = width / 4;

    for (int i = 0; i < 4; i++) {
      final Rect slot = Rect.fromLTWH(left + i * slotWidth, top, slotWidth - 6, 34);
      canvas.drawRRect(
        RRect.fromRectAndRadius(slot, const Radius.circular(8)),
        Paint()..color = const Color(0xFFE4ECF8),
      );
    }

    final double indicatorX = left + (slotWidth * progress.clamp(0, 3));
    final Rect target = Rect.fromLTWH(indicatorX, top, slotWidth - 6, 34);

    switch (kind) {
      case _IndicatorKind.underline:
        canvas.drawLine(
          Offset(target.left + 3, target.bottom + 8),
          Offset(target.right - 3, target.bottom + 8),
          Paint()
            ..color = primary
            ..strokeWidth = 4
            ..strokeCap = StrokeCap.round,
        );
      case _IndicatorKind.pill:
        canvas.drawRRect(
          RRect.fromRectAndRadius(target, const Radius.circular(999)),
          Paint()
            ..shader = LinearGradient(colors: <Color>[primary, secondary]).createShader(target),
        );
      case _IndicatorKind.segmented:
        canvas.drawRRect(
          RRect.fromRectAndRadius(target, const Radius.circular(8)),
          Paint()
            ..color = primary.withValues(alpha: 0.15)
            ..style = PaintingStyle.fill,
        );
        for (int i = 0; i < 5; i++) {
          final double x = target.left + 6 + i * ((target.width - 12) / 4);
          canvas.drawLine(
            Offset(x, target.top + 6),
            Offset(x, target.bottom - 6),
            Paint()
              ..color = primary.withValues(alpha: 0.7)
              ..strokeWidth = 1.4,
          );
        }
      case _IndicatorKind.framed:
        canvas.drawRRect(
          RRect.fromRectAndRadius(target, const Radius.circular(8)),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = primary,
        );
    }

    final TextPainter label = TextPainter(
      text: TextSpan(
        text: 'Indicator preview: ${kind.name}',
        style: const TextStyle(
          color: Color(0xFF1A3558),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    label.paint(canvas, const Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _IndicatorPreviewPainter oldDelegate) {
    return oldDelegate.kind != kind ||
        oldDelegate.primary != primary ||
        oldDelegate.secondary != secondary ||
        oldDelegate.progress != progress;
  }
}

dynamic build(BuildContext context) {
  final DateTime startedAt = DateTime.now();

  final List<_ThemePreset> presets = <_ThemePreset>[
    const _ThemePreset(
      title: 'Classic Underline',
      subtitle: 'Balanced default for dashboards and forms.',
      primary: Color(0xFF1565C0),
      secondary: Color(0xFF64B5F6),
      scaffold: Color(0xFFF4F8FF),
      indicatorKind: _IndicatorKind.underline,
      tabAlignment: TabAlignment.fill,
      isScrollable: false,
      indicatorSize: TabBarIndicatorSize.tab,
      note: 'Good baseline for familiar material navigation patterns.',
    ),
    const _ThemePreset(
      title: 'Pill Product Deck',
      subtitle: 'Soft modern cards with rounded indicator.',
      primary: Color(0xFF6A1B9A),
      secondary: Color(0xFFBA68C8),
      scaffold: Color(0xFFF8F1FF),
      indicatorKind: _IndicatorKind.pill,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      note: 'Great for category-heavy product tabs with expressive color.',
    ),
    const _ThemePreset(
      title: 'Segmented Insights',
      subtitle: 'Data workspace with segmented active feedback.',
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFFA5D6A7),
      scaffold: Color(0xFFF1F8F3),
      indicatorKind: _IndicatorKind.segmented,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.tab,
      note: 'Useful when tabs represent progressive analysis stages.',
    ),
    const _ThemePreset(
      title: 'Framed High Contrast',
      subtitle: 'Compliance UI with hard-edged focus state.',
      primary: Color(0xFFE65100),
      secondary: Color(0xFFFFB74D),
      scaffold: Color(0xFFFFF7EE),
      indicatorKind: _IndicatorKind.framed,
      tabAlignment: TabAlignment.center,
      isScrollable: false,
      indicatorSize: TabBarIndicatorSize.label,
      note: 'Clear active state where strict visual differentiation is required.',
    ),
    const _ThemePreset(
      title: 'Slate RTL Review',
      subtitle: 'Audit view with right-to-left reading support.',
      primary: Color(0xFF37474F),
      secondary: Color(0xFF90A4AE),
      scaffold: Color(0xFFF2F5F7),
      indicatorKind: _IndicatorKind.underline,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      note: 'Designed for multilingual admin workflows and review queues.',
    ),
  ];

  final List<_GuideCard> guides = <_GuideCard>[
    const _GuideCard(
      title: 'What TabBarThemeData Controls',
      body:
          'TabBarThemeData centralizes visual behavior for all TabBar instances, including indicator, label styles, and interaction overlays.',
      icon: Icons.palette,
      color: Color(0xFF1565C0),
    ),
    const _GuideCard(
      title: 'Indicator Strategy',
      body:
          'Use indicator shape and size to communicate hierarchy: underline for subtle state, pill or frame for stronger emphasis.',
      icon: Icons.straighten,
      color: Color(0xFF6A1B9A),
    ),
    const _GuideCard(
      title: 'Scrollable vs Fixed Tabs',
      body:
          'Scrollable tabs suit long labels and many sections, while fixed tabs provide stable rhythm for smaller sets.',
      icon: Icons.swap_horiz,
      color: Color(0xFF2E7D32),
    ),
    const _GuideCard(
      title: 'Density and Typography',
      body:
          'Label style, padding, and divider choices directly affect readability and information density.',
      icon: Icons.text_fields,
      color: Color(0xFFE65100),
    ),
    const _GuideCard(
      title: 'Interaction Feedback',
      body:
          'Overlay color and splash behavior should align with brand while preserving clear tap affordance.',
      icon: Icons.touch_app,
      color: Color(0xFF00838F),
    ),
    const _GuideCard(
      title: 'Interpreter Goal',
      body:
          'This demo verifies runtime TabBar theming behavior under interpretation, not Flutter framework internals.',
      icon: Icons.integration_instructions,
      color: Color(0xFF455A64),
    ),
  ];

  final List<_MatrixRow> matrixRows = <_MatrixRow>[
    const _MatrixRow(
      topic: 'indicatorSize.tab',
      effect: 'Active visual spans the full tab slot.',
      guidance: 'Use for symmetric layouts where equal tab width is desired.',
    ),
    const _MatrixRow(
      topic: 'indicatorSize.label',
      effect: 'Indicator hugs content width for lighter emphasis.',
      guidance: 'Preferred in scrollable sets with variable label lengths.',
    ),
    const _MatrixRow(
      topic: 'tabAlignment.start',
      effect: 'Tabs begin from leading edge, ideal for long lists.',
      guidance: 'Combine with isScrollable=true for content-rich categories.',
    ),
    const _MatrixRow(
      topic: 'tabAlignment.fill',
      effect: 'Tabs distribute evenly across available width.',
      guidance: 'Use for small, fixed navigation groups.',
    ),
    const _MatrixRow(
      topic: 'Overlay + splash',
      effect: 'Tap feedback can be subtle or strong depending on alpha.',
      guidance: 'Tune for accessibility and touch clarity in your theme.',
    ),
    const _MatrixRow(
      topic: 'Divider + label padding',
      effect: 'Affects visual separation and density balance.',
      guidance: 'Increase spacing for readability-heavy enterprise screens.',
    ),
  ];

  _IndicatorKind indicatorKind = _IndicatorKind.underline;
  TabAlignment tabAlignment = TabAlignment.fill;
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.tab;
  bool isScrollable = false;
  bool rtl = false;
  bool showDivider = true;
  bool useIcons = true;
  bool denseMode = false;
  bool highContrast = false;
  bool showThirdBoard = true;
  bool showHeatmap = true;

  Color primary = const Color(0xFF1565C0);
  Color secondary = const Color(0xFF64B5F6);
  Color scaffold = const Color(0xFFF4F8FF);

  double indicatorWeight = 3;
  double radius = 12;
  double labelScale = 1;
  double horizontalPadding = 16;
  double verticalPadding = 10;
  double overlayAlpha = 0.12;
  int tabCount = 5;
  int activeIndex = 0;

  int presetLoads = 0;
  int tabChanges = 0;
  int styleChanges = 0;
  int snapshotId = 0;

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
    if (timeline.length > 36) {
      timeline.removeLast();
    }
  }

  void captureSnapshot(String note) {
    snapshotId += 1;
    snapshots.insert(
      0,
      _Snapshot(
        id: snapshotId,
        activeIndex: activeIndex,
        isScrollable: isScrollable,
        indicatorKind: indicatorKind,
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

  BoxDecoration buildIndicatorDecoration() {
    final Color edge = highContrast ? primary.withValues(alpha: 1) : primary.withValues(alpha: 0.9);
    final Color fill = highContrast ? primary.withValues(alpha: 0.3) : primary.withValues(alpha: 0.16);

    switch (indicatorKind) {
      case _IndicatorKind.underline:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(color: edge, width: indicatorWeight),
          ),
        );
      case _IndicatorKind.pill:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius.clamp(4, 40)),
          gradient: LinearGradient(colors: <Color>[edge, secondary]),
        );
      case _IndicatorKind.segmented:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius.clamp(4, 24)),
          color: fill,
          border: Border.all(color: edge.withValues(alpha: 0.45), width: 1.5),
        );
      case _IndicatorKind.framed:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius.clamp(4, 24)),
          border: Border.all(color: edge, width: indicatorWeight.clamp(1, 6)),
        );
    }
  }

  List<Tab> buildTabs() {
    const List<IconData> icons = <IconData>[
      Icons.analytics,
      Icons.dashboard,
      Icons.bolt,
      Icons.map,
      Icons.settings,
      Icons.people,
      Icons.inventory,
      Icons.warning,
    ];

    final List<Tab> tabs = <Tab>[];
    for (int i = 0; i < tabCount; i++) {
      final String label = 'Tab ${i + 1}';
      if (useIcons) {
        tabs.add(Tab(icon: Icon(icons[i % icons.length], size: denseMode ? 16 : 18), text: label));
      } else {
        tabs.add(Tab(text: label));
      }
    }
    return tabs;
  }

  TabBarThemeData composeTheme() {
    final TextStyle baseSelected = TextStyle(
      color: highContrast ? primary.withValues(alpha: 1) : primary,
      fontWeight: FontWeight.w800,
      fontSize: (13 * labelScale).clamp(10, 20),
      letterSpacing: denseMode ? 0 : 0.2,
    );
    final TextStyle baseUnselected = TextStyle(
      color: secondary.withValues(alpha: highContrast ? 0.75 : 0.85),
      fontWeight: denseMode ? FontWeight.w500 : FontWeight.w600,
      fontSize: (12 * labelScale).clamp(9, 18),
    );

    return TabBarThemeData(
      indicator: buildIndicatorDecoration(),
      indicatorSize: indicatorSize,
      dividerColor: showDivider ? secondary.withValues(alpha: 0.4) : Colors.transparent,
      dividerHeight: showDivider ? 1.2 : 0,
      labelColor: baseSelected.color,
      unselectedLabelColor: baseUnselected.color,
      labelStyle: baseSelected,
      unselectedLabelStyle: baseUnselected,
      labelPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      tabAlignment: tabAlignment,
      overlayColor: WidgetStateProperty.all(primary.withValues(alpha: overlayAlpha.clamp(0.03, 0.5))),
      splashFactory: InkRipple.splashFactory,
      indicatorColor: primary,
    );
  }

  Widget chip(String label, String value) {
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
                style: TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.blueGrey.shade700, height: 1.3)),
            ],
          ),
        ),
      ],
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

  Widget presetCard(_ThemePreset preset, void Function(void Function()) setState) {
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
              chip('Indicator', preset.indicatorKind.name),
              chip('Align', preset.tabAlignment.name),
              chip('Scrollable', preset.isScrollable ? 'yes' : 'no'),
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
                  scaffold = preset.scaffold;
                  indicatorKind = preset.indicatorKind;
                  tabAlignment = preset.tabAlignment;
                  isScrollable = preset.isScrollable;
                  indicatorSize = preset.indicatorSize;
                  rtl = preset.title.contains('RTL');
                  presetLoads += 1;
                  styleChanges += 1;
                });
                addLog('Loaded preset ${preset.title}.');
                addEvent('Preset loaded', preset.title, preset.primary);
                captureSnapshot('Loaded preset ${preset.title}');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Load Theme Preset'),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBoard({
    required String title,
    required String subtitle,
    required TabBarThemeData theme,
    required int boardIndex,
    required bool compact,
    required bool emphasize,
    required void Function(void Function()) setState,
  }) {
    final List<Tab> tabs = buildTabs();
    final int selected = activeIndex.clamp(0, tabs.length - 1);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: emphasize ? primary.withValues(alpha: 0.44) : const Color(0xFFD5E2F2),
          width: emphasize ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: primary, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.blueGrey.shade700)),
          const SizedBox(height: 12),
          Directionality(
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            child: Container(
              decoration: BoxDecoration(
                color: scaffold,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: secondary.withValues(alpha: 0.38)),
              ),
              padding: EdgeInsets.all(compact ? 8 : 12),
              child: DefaultTabController(
                length: tabs.length,
                initialIndex: selected,
                child: Builder(
                  builder: (BuildContext context) {
                    final TabController? controller = DefaultTabController.maybeOf(context);
                    controller?.addListener(() {
                      if (controller.indexIsChanging) {
                        return;
                      }
                      if (controller.index != activeIndex) {
                        setState(() {
                          activeIndex = controller.index;
                          tabChanges += 1;
                        });
                        addLog('Tab changed to index $activeIndex on board $boardIndex.');
                      }
                    });

                    return SingleChildScrollView(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            tabBarTheme: theme,
                          ),
                          child: TabBar(
                            tabs: tabs,
                            isScrollable: isScrollable,
                            indicator: theme.indicator,
                            indicatorSize: theme.indicatorSize,
                            dividerColor: theme.dividerColor,
                            dividerHeight: theme.dividerHeight,
                            labelColor: theme.labelColor,
                            unselectedLabelColor: theme.unselectedLabelColor,
                            labelStyle: theme.labelStyle,
                            unselectedLabelStyle: theme.unselectedLabelStyle,
                            labelPadding: theme.labelPadding,
                            tabAlignment: theme.tabAlignment,
                            overlayColor: theme.overlayColor,
                            splashFactory: theme.splashFactory,
                            onTap: (int index) {
                              setState(() {
                                activeIndex = index;
                                tabChanges += 1;
                              });
                              addEvent('Tab tap', 'Board $boardIndex selected tab $index', primary);
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: compact ? 92 : 120,
                          child: TabBarView(
                            children: List<Widget>.generate(
                              tabs.length,
                              (int index) {
                                final bool active = index == activeIndex;
                                return Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: active
                                        ? primary.withValues(alpha: 0.12)
                                        : secondary.withValues(alpha: 0.12),
                                    border: Border.all(
                                      color: active
                                          ? primary.withValues(alpha: 0.4)
                                          : secondary.withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.layers,
                                        color: active ? primary : secondary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Panel ${index + 1}: ${active ? 'active' : 'inactive'} tab style preview.',
                                          style: TextStyle(
                                            color: Colors.blueGrey.shade800,
                                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ));
                  },
                ),
              ),
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

    return SingleChildScrollView(child: Column(children: rows));
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
          'Timeline empty. Load presets, change controls, and tap tabs to capture theming events.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
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
    ));
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
          'No snapshots captured yet. Use Capture Snapshot to store active theme states.',
          style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
        ),
      );
    }

    return SingleChildScrollView(child: Column(
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
                'Snapshot #${snapshot.id} | tab ${snapshot.activeIndex + 1} | ${snapshot.indicatorKind.name}',
                style: TextStyle(color: snapshot.color, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 3),
              Text(
                'scrollable ${snapshot.isScrollable ? 'yes' : 'no'}',
                style: TextStyle(color: Colors.blueGrey.shade700, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(snapshot.note, style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12)),
            ],
          ),
        );
      }).toList(),
    ));
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
                'No logs yet. Interact with tabs and controls to populate diagnostics.',
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
      final TabBarThemeData theme = composeTheme();
      final List<_MetricCard> metrics = <_MetricCard>[
        _MetricCard(label: 'Active tab', value: '${activeIndex + 1}/$tabCount', color: primary),
        _MetricCard(label: 'Indicator', value: indicatorKind.name, color: const Color(0xFF6A1B9A)),
        _MetricCard(label: 'Tab align', value: tabAlignment.name, color: const Color(0xFF2E7D32)),
        _MetricCard(label: 'Scrollable', value: isScrollable ? 'yes' : 'no', color: const Color(0xFF00838F)),
        _MetricCard(label: 'Size mode', value: indicatorSize.name, color: const Color(0xFFE65100)),
        _MetricCard(label: 'Radius', value: f(radius), color: const Color(0xFF455A64)),
        _MetricCard(label: 'Weight', value: f(indicatorWeight), color: const Color(0xFF283593)),
        _MetricCard(label: 'Label scale', value: f(labelScale), color: const Color(0xFFAD1457)),
        _MetricCard(label: 'Preset loads', value: '$presetLoads', color: const Color(0xFF5D4037)),
        _MetricCard(label: 'Tab changes', value: '$tabChanges', color: const Color(0xFF1565C0)),
        _MetricCard(label: 'Style changes', value: '$styleChanges', color: const Color(0xFF827717)),
        _MetricCard(label: 'Overlay alpha', value: f(overlayAlpha), color: const Color(0xFF37474F)),
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
                        child: Icon(Icons.tab, color: primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'TabBarThemeData Deep Demo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Interactive theme studio showing how TabBarThemeData changes tab indicators, typography, spacing, alignment, and interaction feedback across multiple boards.',
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
                      chip('Indicator', indicatorKind.name),
                      chip('Alignment', tabAlignment.name),
                      chip('Scrollable', isScrollable ? 'yes' : 'no'),
                      chip('Tab count', '$tabCount'),
                      chip('RTL', rtl ? 'on' : 'off'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              'Preset Themes',
              'Load curated tab-theme profiles to see immediate visual and behavioral changes.',
              Icons.auto_graph,
            ),
            const SizedBox(height: 10),
            Wrap(children: presets.map((preset) => presetCard(preset, setState)).toList()),
            const SizedBox(height: 18),
            sectionTitle(
              'Theme Controls',
              'Fine-tune TabBarThemeData properties and observe effects across all preview boards.',
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
                          label: 'Indicator weight',
                          valueLabel: f(indicatorWeight),
                          min: 1,
                          max: 8,
                          divisions: 70,
                          value: indicatorWeight,
                          onChanged: (double value) {
                            setState(() {
                              indicatorWeight = value;
                              styleChanges += 1;
                            });
                            addLog('Indicator weight set to ${f(indicatorWeight)}.');
                          },
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Indicator radius',
                          valueLabel: f(radius),
                          min: 4,
                          max: 40,
                          divisions: 72,
                          value: radius,
                          onChanged: (double value) {
                            setState(() {
                              radius = value;
                              styleChanges += 1;
                            });
                            addLog('Indicator radius set to ${f(radius)}.');
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
                          label: 'Overlay alpha',
                          valueLabel: f(overlayAlpha),
                          min: 0.03,
                          max: 0.5,
                          divisions: 94,
                          value: overlayAlpha,
                          onChanged: (double value) {
                            setState(() {
                              overlayAlpha = value;
                              styleChanges += 1;
                            });
                            addLog('Overlay alpha set to ${f(overlayAlpha)}.');
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
                          label: 'Horizontal padding',
                          valueLabel: f(horizontalPadding),
                          min: 6,
                          max: 32,
                          divisions: 52,
                          value: horizontalPadding,
                          onChanged: (double value) {
                            setState(() {
                              horizontalPadding = value;
                              styleChanges += 1;
                            });
                            addLog('Horizontal padding set to ${f(horizontalPadding)}.');
                          },
                          color: const Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Vertical padding',
                          valueLabel: f(verticalPadding),
                          min: 4,
                          max: 18,
                          divisions: 56,
                          value: verticalPadding,
                          onChanged: (double value) {
                            setState(() {
                              verticalPadding = value;
                              styleChanges += 1;
                            });
                            addLog('Vertical padding set to ${f(verticalPadding)}.');
                          },
                          color: const Color(0xFF455A64),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: sliderControl(
                          label: 'Tab count',
                          valueLabel: '$tabCount',
                          min: 3,
                          max: 8,
                          divisions: 5,
                          value: tabCount.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              tabCount = value.round();
                              activeIndex = activeIndex.clamp(0, tabCount - 1);
                              styleChanges += 1;
                            });
                            addLog('Tab count set to $tabCount.');
                          },
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: sliderControl(
                          label: 'Active index',
                          valueLabel: '${activeIndex + 1}',
                          min: 0,
                          max: math.max(0, tabCount - 1).toDouble(),
                          divisions: math.max(1, tabCount - 1),
                          value: activeIndex.toDouble().clamp(0, math.max(0, tabCount - 1).toDouble()),
                          onChanged: (double value) {
                            setState(() {
                              activeIndex = value.round();
                              tabChanges += 1;
                            });
                            addLog('Active index set to $activeIndex.');
                          },
                          color: const Color(0xFF283593),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<_IndicatorKind>(
                          decoration: const InputDecoration(
                            labelText: 'Indicator Kind',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          initialValue: indicatorKind,
                          items: _IndicatorKind.values
                              .map(
                                (_IndicatorKind value) => DropdownMenuItem<_IndicatorKind>(
                                  value: value,
                                  child: Text(value.name),
                                ),
                              )
                              .toList(),
                          onChanged: (_IndicatorKind? value) {
                            if (value == null) return;
                            setState(() {
                              indicatorKind = value;
                              styleChanges += 1;
                            });
                            addLog('Indicator kind changed to ${value.name}.');
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<TabAlignment>(
                          decoration: const InputDecoration(
                            labelText: 'Tab Alignment',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          initialValue: tabAlignment,
                          items: TabAlignment.values
                              .map(
                                (TabAlignment value) => DropdownMenuItem<TabAlignment>(
                                  value: value,
                                  child: Text(value.name),
                                ),
                              )
                              .toList(),
                          onChanged: (TabAlignment? value) {
                            if (value == null) return;
                            setState(() {
                              tabAlignment = value;
                              styleChanges += 1;
                            });
                            addLog('Tab alignment changed to ${value.name}.');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<TabBarIndicatorSize>(
                          decoration: const InputDecoration(
                            labelText: 'Indicator Size',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          initialValue: indicatorSize,
                          items: TabBarIndicatorSize.values
                              .map(
                                (TabBarIndicatorSize value) => DropdownMenuItem<TabBarIndicatorSize>(
                                  value: value,
                                  child: Text(value.name),
                                ),
                              )
                              .toList(),
                          onChanged: (TabBarIndicatorSize? value) {
                            if (value == null) return;
                            setState(() {
                              indicatorSize = value;
                              styleChanges += 1;
                            });
                            addLog('Indicator size changed to ${value.name}.');
                          },
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
                                    activeIndex = 0;
                                    tabChanges += 1;
                                  });
                                  addLog('Active tab reset to first.');
                                },
                                child: const Text('First Tab'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    activeIndex = tabCount - 1;
                                    tabChanges += 1;
                                  });
                                  addLog('Active tab moved to last.');
                                },
                                child: const Text('Last Tab'),
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
                          value: isScrollable,
                          title: const Text('Scrollable tabs'),
                          subtitle: const Text('Enable horizontal scrolling for large sets.'),
                          onChanged: (bool value) {
                            setState(() {
                              isScrollable = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Scrollable mode enabled.' : 'Scrollable mode disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: rtl,
                          title: const Text('RTL direction'),
                          subtitle: const Text('Preview right-to-left language layout.'),
                          onChanged: (bool value) {
                            setState(() {
                              rtl = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'RTL enabled.' : 'RTL disabled.');
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
                          value: showDivider,
                          title: const Text('Show divider'),
                          subtitle: const Text('Toggle TabBar divider line.'),
                          onChanged: (bool value) {
                            setState(() {
                              showDivider = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Divider enabled.' : 'Divider disabled.');
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: useIcons,
                          title: const Text('Icon + text tabs'),
                          subtitle: const Text('Show icon-assisted labels.'),
                          onChanged: (bool value) {
                            setState(() {
                              useIcons = value;
                              styleChanges += 1;
                            });
                            addLog(value ? 'Icon tabs enabled.' : 'Icon tabs disabled.');
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
                          subtitle: const Text('Compact typography and spacing.'),
                          onChanged: (bool value) {
                            setState(() {
                              denseMode = value;
                              if (denseMode) {
                                verticalPadding = verticalPadding.clamp(4, 8);
                              }
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
                          subtitle: const Text('Boost active readability.'),
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
                          value: showThirdBoard,
                          title: const Text('Show third board'),
                          subtitle: const Text('Enable compact board comparison.'),
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
                          title: const Text('Show indicator painter'),
                          subtitle: const Text('Display indicator diagnostics panel.'),
                          onChanged: (bool value) {
                            setState(() {
                              showHeatmap = value;
                            });
                            addLog(value ? 'Indicator painter shown.' : 'Indicator painter hidden.');
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
              'Tab Theme Boards',
              'Multiple visual boards that apply the same TabBarThemeData under different layout emphases.',
              Icons.view_carousel,
            ),
            const SizedBox(height: 10),
            tabBoard(
              title: 'Primary Navigation Board',
              subtitle: 'Main tab experience for app-level sections.',
              theme: theme,
              boardIndex: 1,
              compact: false,
              emphasize: true,
              setState: setState,
            ),
            const SizedBox(height: 12),
            tabBoard(
              title: 'Dense Workspace Board',
              subtitle: 'Compact layout emphasizing information density.',
              theme: theme.copyWith(
                labelStyle: theme.labelStyle?.copyWith(fontSize: (theme.labelStyle?.fontSize ?? 12) - 1),
                unselectedLabelStyle: theme.unselectedLabelStyle
                    ?.copyWith(fontSize: (theme.unselectedLabelStyle?.fontSize ?? 11) - 1),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: math.max(6, horizontalPadding - 4),
                  vertical: math.max(4, verticalPadding - 2),
                ),
              ),
              boardIndex: 2,
              compact: true,
              emphasize: false,
              setState: setState,
            ),
            if (showThirdBoard) ...<Widget>[
              const SizedBox(height: 12),
              tabBoard(
                title: 'Contrast Review Board',
                subtitle: 'Accessibility-focused board with stronger active state cues.',
                theme: theme.copyWith(
                  overlayColor: WidgetStateProperty.all(primary.withValues(alpha: 0.2)),
                  labelStyle: theme.labelStyle?.copyWith(fontWeight: FontWeight.w900),
                ),
                boardIndex: 3,
                compact: false,
                emphasize: false,
                setState: setState,
              ),
            ],
            if (showHeatmap) ...<Widget>[
              const SizedBox(height: 18),
              sectionTitle(
                'Indicator Painter Diagnostics',
                'Custom painter preview of indicator geometry and progression across tab slots.',
                Icons.brush,
              ),
              const SizedBox(height: 10),
              Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD4E0F2)),
                ),
                child: CustomPaint(
                  painter: _IndicatorPreviewPainter(
                    kind: indicatorKind,
                    primary: primary,
                    secondary: secondary,
                    progress: activeIndex.toDouble(),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
            const SizedBox(height: 18),
            sectionTitle(
              'Theme Inspector',
              'Metrics and implementation-oriented snippet for TabBarThemeData composition.',
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
                      'TabBarThemeData(\n'
                      '  indicator: ${indicatorKind.name},\n'
                      '  indicatorSize: ${indicatorSize.name},\n'
                      '  tabAlignment: ${tabAlignment.name},\n'
                      '  isScrollable: ${isScrollable ? 'true' : 'false'},\n'
                      '  labelPadding: EdgeInsets.symmetric(h: ${f(horizontalPadding)}, v: ${f(verticalPadding)}),\n'
                      '  overlayAlpha: ${f(overlayAlpha)},\n'
                      ')\n\n'
                      'activeTab: ${activeIndex + 1}/$tabCount\n'
                      'rtl: ${rtl ? 'true' : 'false'}\n'
                      'denseMode: ${denseMode ? 'true' : 'false'}\n'
                      'styleChanges: $styleChanges\n'
                      'tabChanges: $tabChanges',
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
              'Instructive notes for selecting and applying TabBarThemeData options effectively.',
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
              'Quick mapping of key TabBarThemeData choices to practical UI outcomes.',
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
              'Captured theme states for comparing indicator and layout settings over time.',
              Icons.camera,
            ),
            const SizedBox(height: 10),
            snapshotPanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Timeline',
              'Event stream of theme loads, tab changes, and style adjustments.',
              Icons.timeline,
            ),
            const SizedBox(height: 10),
            timelinePanel(),
            const SizedBox(height: 18),
            sectionTitle(
              'Diagnostics Console',
              'Text telemetry for interpreter-side theme behavior verification.',
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
                'Summary: TabBarThemeData defines the visual language of tab navigation. '
                'This deep demo shows how indicator geometry, typography, spacing, alignment, and interaction feedback combine to produce '
                'distinct tab experiences across primary, dense, and contrast-focused boards. It serves as a practical reference for '
                'building expressive and consistent tab theming in interpreter-driven Flutter apps.',
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
