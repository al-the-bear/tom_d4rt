import 'dart:math' as math;

import 'package:flutter/material.dart';

class _TooltipZone {
  const _TooltipZone({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.brightness,
    required this.theme,
  });

  final String id;
  final String name;
  final String description;
  final Color seed;
  final Brightness brightness;
  final TooltipThemeData theme;
}

class _TooltipScenario {
  const _TooltipScenario(this.id, this.title, this.description);

  final String id;
  final String title;
  final String description;
}

class _FaqItem {
  const _FaqItem(this.q, this.a);

  final String q;
  final String a;
}

class _MetricTile {
  const _MetricTile({
    required this.title,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String title;
  final String value;
  final String note;
  final IconData icon;
}

const List<_TooltipZone> _zones = [
  _TooltipZone(
    id: 'ops',
    name: 'Ops Console',
    description: 'High-contrast tooltip style for operator-heavy interfaces.',
    seed: Color(0xFF0369A1),
    brightness: Brightness.dark,
    theme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Color(0xFFE0F2FE),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      textStyle: TextStyle(color: Color(0xFF082F49), fontWeight: FontWeight.w700),
      waitDuration: Duration(milliseconds: 450),
      showDuration: Duration(milliseconds: 2300),
      preferBelow: false,
      verticalOffset: 18,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 24),
      triggerMode: TooltipTriggerMode.longPress,
      enableFeedback: true,
    ),
  ),
  _TooltipZone(
    id: 'content',
    name: 'Content Studio',
    description: 'Neutral tooltip profile optimized for reading and editorial tools.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
    theme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Color(0xFF064E3B),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      waitDuration: Duration(milliseconds: 600),
      showDuration: Duration(milliseconds: 2600),
      preferBelow: true,
      verticalOffset: 16,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      triggerMode: TooltipTriggerMode.tap,
      enableFeedback: true,
    ),
  ),
  _TooltipZone(
    id: 'marketing',
    name: 'Campaign Surface',
    description: 'Expressive tooltip treatment used in guided walkthroughs.',
    seed: Color(0xFFEA580C),
    brightness: Brightness.light,
    theme: TooltipThemeData(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9A3412), Color(0xFFEA580C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      waitDuration: Duration(milliseconds: 300),
      showDuration: Duration(milliseconds: 1800),
      preferBelow: false,
      verticalOffset: 22,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      margin: EdgeInsets.symmetric(horizontal: 18),
      triggerMode: TooltipTriggerMode.manual,
      enableFeedback: true,
    ),
  ),
  _TooltipZone(
    id: 'lab',
    name: 'Prototype Lab',
    description: 'Experimental profile for state debugging and interactive tests.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
    theme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Color(0xFFEDE9FE),
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.fromBorderSide(BorderSide(color: Color(0xFFA78BFA), width: 1.5)),
      ),
      textStyle: TextStyle(color: Color(0xFF2E1065), fontWeight: FontWeight.w700),
      waitDuration: Duration(milliseconds: 520),
      showDuration: Duration(milliseconds: 3100),
      preferBelow: true,
      verticalOffset: 14,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 18),
      triggerMode: TooltipTriggerMode.tap,
      enableFeedback: false,
    ),
  ),
];

const List<_TooltipScenario> _scenarios = [
  _TooltipScenario(
    'triggers',
    'Trigger Behaviors',
    'Show TooltipState behavior across hover, tap, long press, and focus interaction styles.',
  ),
  _TooltipScenario(
    'timing',
    'Timing Behaviors',
    'Compare wait, show, and exit durations under practical widget density.',
  ),
  _TooltipScenario(
    'imperative',
    'Imperative Control',
    'Use TooltipState references and ensureTooltipVisible to trigger tooltips intentionally.',
  ),
  _TooltipScenario(
    'zones',
    'Theme Zones',
    'Inspect nested TooltipTheme zones and placement differences in one surface.',
  ),
];

const List<String> _guideLines = [
  'TooltipState is the state object behind Tooltip and manages visibility, timing, and transitions.',
  'Use a GlobalKey<TooltipState> when you need direct imperative access to TooltipState.',
  'Keep GlobalKey ownership local to the feature scope that triggers tooltip visibility.',
  'ensureTooltipVisible() is useful for guided onboarding and context-dependent help cues.',
  'Trigger behavior should be verified for tap, hover, long press, and keyboard focus pathways.',
  'Theme-level tooltip styling can improve consistency while local overrides support specialized zones.',
  'Always validate durations in crowded UIs to avoid tooltip flicker or delayed feedback.',
  'Test readability and contrast for every tooltip variant against the surrounding surface.',
  'Prefer concise, actionable tooltip copy; state transitions should reinforce, not distract.',
  'Use visual test boards to reveal real interactions, not just API value printing.',
];

const List<_FaqItem> _faq = [
  _FaqItem(
    'When should I call ensureTooltipVisible manually?',
    'Use it when user guidance depends on state transitions, onboarding, or failed validation steps.',
  ),
  _FaqItem(
    'What does TooltipState manage internally?',
    'It coordinates show/hide timing, animation state, and overlay lifecycle behavior for the tooltip.',
  ),
  _FaqItem(
    'Should all tooltips share one style?',
    'A global baseline is useful, but local TooltipTheme zones can differentiate contexts without global regressions.',
  ),
  _FaqItem(
    'How do I test tooltip reliability?',
    'Interact through all trigger modes and verify readability, placement, and state transitions across surfaces.',
  ),
];

dynamic build(BuildContext context) {
  var zoneIndex = 0;
  var scenarioIndex = 0;
  var boardIndex = 0;
  var diagnostics = true;
  var denseMode = false;
  var showGuide = true;
  var useRichTips = true;
  var compactCards = false;
  var manualPulse = false;
  var showTimeline = true;
  var widthScale = 1.0;
  var verticalOffsetDelta = 0.0;
  var interactions = 0;
  var tick = 0;

  var toolbarSelection = <bool>[true, false, false, false];
  var filterSelection = <bool>[true, true, false, false, true, false];
  var timingSelection = <bool>[true, false, false];
  var settingsSelection = <bool>[true, false, true, false];

  final timeline = <String>[];

  final manualKeys = List.generate(6, (_) => GlobalKey<TooltipState>());

  void addEvent(String text) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    timeline.insert(0, '$stamp $text');
    if (timeline.length > 28) {
      timeline.removeRange(28, timeline.length);
    }
  }

  debugPrint('TooltipState deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final zone = _zones[zoneIndex];
      final scenario = _scenarios[scenarioIndex];

      final baseScheme = ColorScheme.fromSeed(seedColor: zone.seed, brightness: zone.brightness);
      final baseTheme = ThemeData(
        useMaterial3: true,
        colorScheme: baseScheme,
        visualDensity: denseMode ? VisualDensity.compact : VisualDensity.standard,
      );

      final tunedTooltipTheme = _tunedTooltipTheme(
        zone.theme,
        widthScale: widthScale,
        verticalOffsetDelta: verticalOffsetDelta,
      );

      final pageTheme = baseTheme.copyWith(tooltipTheme: tunedTooltipTheme);

      return Theme(
        data: pageTheme,
        child: Container(
          color: pageTheme.colorScheme.surface,
          child: Column(
            children: [
              _header(
                theme: pageTheme,
                zone: zone,
                scenario: scenario,
                interactions: interactions,
                tick: tick,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controls(
                      theme: pageTheme,
                      zoneIndex: zoneIndex,
                      scenarioIndex: scenarioIndex,
                      boardIndex: boardIndex,
                      diagnostics: diagnostics,
                      denseMode: denseMode,
                      showGuide: showGuide,
                      useRichTips: useRichTips,
                      compactCards: compactCards,
                      manualPulse: manualPulse,
                      showTimeline: showTimeline,
                      widthScale: widthScale,
                      verticalOffsetDelta: verticalOffsetDelta,
                      onZoneChanged: (v) {
                        setState(() {
                          zoneIndex = v;
                          tick += 1;
                          addEvent('Zone changed to ${_zones[v].name}.');
                        });
                      },
                      onScenarioChanged: (v) {
                        setState(() {
                          scenarioIndex = v;
                          tick += 1;
                          addEvent('Scenario changed to ${_scenarios[v].title}.');
                        });
                      },
                      onBoardChanged: (v) {
                        setState(() {
                          boardIndex = v;
                          tick += 1;
                          addEvent('Board switched to ${_boardTitle(v)}.');
                        });
                      },
                      onDiagnosticsChanged: (v) {
                        setState(() {
                          diagnostics = v;
                          tick += 1;
                          addEvent('Diagnostics ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDenseChanged: (v) {
                        setState(() {
                          denseMode = v;
                          tick += 1;
                          addEvent('Dense mode ${v ? 'on' : 'off'}.');
                        });
                      },
                      onGuideChanged: (v) {
                        setState(() {
                          showGuide = v;
                          tick += 1;
                          addEvent('Guide panel ${v ? 'shown' : 'hidden'}.');
                        });
                      },
                      onRichTipsChanged: (v) {
                        setState(() {
                          useRichTips = v;
                          tick += 1;
                          addEvent('Rich tips ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onCompactCardsChanged: (v) {
                        setState(() {
                          compactCards = v;
                          tick += 1;
                          addEvent('Compact cards ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onManualPulseChanged: (v) {
                        setState(() {
                          manualPulse = v;
                          tick += 1;
                          addEvent('Manual pulse mode ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onTimelineChanged: (v) {
                        setState(() {
                          showTimeline = v;
                          tick += 1;
                          addEvent('Timeline ${v ? 'shown' : 'hidden'}.');
                        });
                      },
                      onWidthScaleChanged: (v) {
                        setState(() {
                          widthScale = v;
                          tick += 1;
                        });
                      },
                      onVerticalOffsetDeltaChanged: (v) {
                        setState(() {
                          verticalOffsetDelta = v;
                          tick += 1;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 12, 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              pageTheme.colorScheme.surface,
                              pageTheme.colorScheme.surfaceContainerHighest.withAlpha(162),
                              pageTheme.colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: pageTheme.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: _board(
                          boardIndex: boardIndex,
                          theme: pageTheme,
                          zone: zone,
                          tooltipTheme: tunedTooltipTheme,
                          scenario: scenario,
                          diagnostics: diagnostics,
                          showGuide: showGuide,
                          useRichTips: useRichTips,
                          compactCards: compactCards,
                          manualPulse: manualPulse,
                          showTimeline: showTimeline,
                          toolbarSelection: toolbarSelection,
                          filterSelection: filterSelection,
                          timingSelection: timingSelection,
                          settingsSelection: settingsSelection,
                          timeline: timeline,
                          interactions: interactions,
                          tick: tick,
                          manualKeys: manualKeys,
                          onToolbarTap: (i) {
                            setState(() {
                              toolbarSelection = _singleSelect(toolbarSelection, i);
                              interactions += 1;
                              tick += 1;
                              addEvent('Toolbar selection changed: index $i.');
                            });
                          },
                          onFilterTap: (i) {
                            setState(() {
                              filterSelection = _toggle(filterSelection, i);
                              interactions += 1;
                              tick += 1;
                              addEvent('Filter toggled: index $i.');
                            });
                          },
                          onTimingTap: (i) {
                            setState(() {
                              timingSelection = _singleSelect(timingSelection, i);
                              interactions += 1;
                              tick += 1;
                              addEvent('Timing profile selected: index $i.');
                            });
                          },
                          onSettingsTap: (i) {
                            setState(() {
                              settingsSelection = _toggle(settingsSelection, i);
                              interactions += 1;
                              tick += 1;
                              addEvent('Settings toggled: index $i.');
                            });
                          },
                          onManualShowAll: () {
                            for (final k in manualKeys) {
                              k.currentState?.ensureTooltipVisible();
                            }
                            setState(() {
                              interactions += 1;
                              tick += 1;
                              addEvent('Manual ensureTooltipVisible applied to all manual keys.');
                            });
                          },
                          onManualShowOne: (i) {
                            manualKeys[i].currentState?.ensureTooltipVisible();
                            setState(() {
                              interactions += 1;
                              tick += 1;
                              addEvent('Manual ensureTooltipVisible called for key $i.');
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

TooltipThemeData _tunedTooltipTheme(
  TooltipThemeData base, {
  required double widthScale,
  required double verticalOffsetDelta,
}) {
  final margin = base.margin ?? EdgeInsets.symmetric(horizontal: 20);
  return base.copyWith(
    margin: EdgeInsets.symmetric(horizontal: margin.horizontal / 2 * widthScale),
    verticalOffset: (base.verticalOffset ?? 16) + verticalOffsetDelta,
  );
}

List<bool> _singleSelect(List<bool> values, int index) {
  final next = List<bool>.filled(values.length, false);
  next[index] = true;
  return next;
}

List<bool> _toggle(List<bool> values, int index) {
  final next = List<bool>.from(values);
  next[index] = !next[index];
  return next;
}

String _boardTitle(int index) {
  const names = [
    'Trigger Lab',
    'Timing Lab',
    'Imperative State Lab',
    'Theme Zone Board',
    'Guide + Timeline',
  ];
  return names[index.clamp(0, names.length - 1)];
}

Widget _header({
  required ThemeData theme,
  required _TooltipZone zone,
  required _TooltipScenario scenario,
  required int interactions,
  required int tick,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.primaryContainer.withAlpha(178),
          theme.colorScheme.secondaryContainer.withAlpha(150),
          theme.colorScheme.tertiaryContainer.withAlpha(130),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(136)),
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
          ),
          child: CustomPaint(
            painter: _HeaderPainter(
              a: zone.seed,
              b: theme.colorScheme.tertiary,
              seed: tick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TooltipState Interaction Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'zone: ${zone.name}  scenario: ${scenario.title}  interactions: $interactions',
                style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(zone.description, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(175))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _controls({
  required ThemeData theme,
  required int zoneIndex,
  required int scenarioIndex,
  required int boardIndex,
  required bool diagnostics,
  required bool denseMode,
  required bool showGuide,
  required bool useRichTips,
  required bool compactCards,
  required bool manualPulse,
  required bool showTimeline,
  required double widthScale,
  required double verticalOffsetDelta,
  required ValueChanged<int> onZoneChanged,
  required ValueChanged<int> onScenarioChanged,
  required ValueChanged<int> onBoardChanged,
  required ValueChanged<bool> onDiagnosticsChanged,
  required ValueChanged<bool> onDenseChanged,
  required ValueChanged<bool> onGuideChanged,
  required ValueChanged<bool> onRichTipsChanged,
  required ValueChanged<bool> onCompactCardsChanged,
  required ValueChanged<bool> onManualPulseChanged,
  required ValueChanged<bool> onTimelineChanged,
  required ValueChanged<double> onWidthScaleChanged,
  required ValueChanged<double> onVerticalOffsetDeltaChanged,
}) {
  return Container(
    width: 382,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.surfaceContainerHighest.withAlpha(124),
          theme.colorScheme.surfaceContainer.withAlpha(98),
          theme.colorScheme.surfaceContainerLow.withAlpha(88),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tooltip Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Adjust TooltipState-related behavior and inspect visual outcomes per board.'),
          SizedBox(height: 10),
          _dropdownCard('Zone', zoneIndex, _zones.map((e) => e.name).toList(), onZoneChanged),
          _dropdownCard('Scenario', scenarioIndex, _scenarios.map((e) => e.title).toList(), onScenarioChanged),
          _dropdownCard('Board', boardIndex, List.generate(5, _boardTitle), onBoardChanged),
          _switchCard('Diagnostics', 'Show resolved state and theme details', diagnostics, onDiagnosticsChanged),
          _switchCard('Dense mode', 'Reduce padding/spacing for crowded surfaces', denseMode, onDenseChanged),
          _switchCard('Show guide', 'Display usage guidance cards where available', showGuide, onGuideChanged),
          _switchCard('Rich tooltips', 'Use richMessage for selected examples', useRichTips, onRichTipsChanged),
          _switchCard('Compact cards', 'Tighter layout in scene board cards', compactCards, onCompactCardsChanged),
          _switchCard('Manual pulse', 'Highlight imperative TooltipState controls', manualPulse, onManualPulseChanged),
          _switchCard('Show timeline', 'Display event timeline panel', showTimeline, onTimelineChanged),
          _sliderCard('Margin width scale', widthScale, 0.7, 1.7, onWidthScaleChanged),
          _sliderCard('Vertical offset delta', verticalOffsetDelta, -8, 14, onVerticalOffsetDeltaChanged),
        ],
      ),
    ),
  );
}

Widget _dropdownCard(String label, int value, List<String> options, ValueChanged<int> onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(130),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(22)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        DropdownButtonFormField<int>(
          initialValue: value,
          decoration: InputDecoration(border: OutlineInputBorder(), isDense: true),
          items: [
            for (var i = 0; i < options.length; i++) DropdownMenuItem<int>(value: i, child: Text(options[i])),
          ],
          onChanged: (v) {
            if (v != null) {
              onChanged(v);
            }
          },
        ),
      ],
    ),
  );
}

Widget _switchCard(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(130),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w700))),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(160))),
      ],
    ),
  );
}

Widget _sliderCard(String label, double value, double min, double max, ValueChanged<double> onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(130),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    ),
  );
}

Widget _board({
  required int boardIndex,
  required ThemeData theme,
  required _TooltipZone zone,
  required TooltipThemeData tooltipTheme,
  required _TooltipScenario scenario,
  required bool diagnostics,
  required bool showGuide,
  required bool useRichTips,
  required bool compactCards,
  required bool manualPulse,
  required bool showTimeline,
  required List<bool> toolbarSelection,
  required List<bool> filterSelection,
  required List<bool> timingSelection,
  required List<bool> settingsSelection,
  required List<String> timeline,
  required int interactions,
  required int tick,
  required List<GlobalKey<TooltipState>> manualKeys,
  required ValueChanged<int> onToolbarTap,
  required ValueChanged<int> onFilterTap,
  required ValueChanged<int> onTimingTap,
  required ValueChanged<int> onSettingsTap,
  required VoidCallback onManualShowAll,
  required ValueChanged<int> onManualShowOne,
}) {
  switch (boardIndex) {
    case 0:
      return _triggerLab(
        theme,
        scenario,
        tooltipTheme,
        diagnostics,
        useRichTips,
        toolbarSelection,
        filterSelection,
        onToolbarTap,
        onFilterTap,
      );
    case 1:
      return _timingLab(
        theme,
        tooltipTheme,
        diagnostics,
        useRichTips,
        timingSelection,
        onTimingTap,
      );
    case 2:
      return _imperativeLab(
        theme,
        zone,
        tooltipTheme,
        diagnostics,
        manualPulse,
        useRichTips,
        settingsSelection,
        manualKeys,
        onSettingsTap,
        onManualShowAll,
        onManualShowOne,
      );
    case 3:
      return _themeZoneLab(
        theme,
        compactCards,
        useRichTips,
        toolbarSelection,
        filterSelection,
        onToolbarTap,
        onFilterTap,
      );
    default:
      return _guideBoard(theme, showGuide, showTimeline, interactions, tick, timeline);
  }
}

Widget _triggerLab(
  ThemeData theme,
  _TooltipScenario scenario,
  TooltipThemeData tooltipTheme,
  bool diagnostics,
  bool useRichTips,
  List<bool> toolbarSelection,
  List<bool> filterSelection,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFilterTap,
) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Trigger Lab', scenario.description, 'triggers'),
        SizedBox(height: 10),
        _card(
          theme,
          'Tap Trigger Group',
          'Tooltips triggered by tap interactions for touch-first surfaces.',
          TooltipTheme(
            data: tooltipTheme.copyWith(triggerMode: TooltipTriggerMode.tap),
            child: ToggleButtons(
              isSelected: toolbarSelection,
              onPressed: onToolbarTap,
              children: [
                _tooltipAction(
                  message: 'Tap trigger: formatting control for emphasis.',
                  rich: _richTip(useRichTips, 'Bold', 'Tap to switch primary emphasis formatting.'),
                  child: _iconText(Icons.format_bold, 'Bold'),
                ),
                _tooltipAction(
                  message: 'Tap trigger: italics helps indicate secondary voice.',
                  rich: _richTip(useRichTips, 'Italic', 'Tap to apply typographic contrast.'),
                  child: _iconText(Icons.format_italic, 'Italic'),
                ),
                _tooltipAction(
                  message: 'Tap trigger: link insertion action.',
                  rich: _richTip(useRichTips, 'Link', 'Tap to attach URL references.'),
                  child: _iconText(Icons.link, 'Link'),
                ),
                _tooltipAction(
                  message: 'Tap trigger: code style action.',
                  rich: _richTip(useRichTips, 'Code', 'Tap to mark monospaced snippets.'),
                  child: _iconText(Icons.code, 'Code'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        _card(
          theme,
          'Long-Press Trigger Group',
          'Long-press tooltips for compact chips where accidental reveals should be reduced.',
          TooltipTheme(
            data: tooltipTheme.copyWith(triggerMode: TooltipTriggerMode.longPress),
            child: ToggleButtons(
              isSelected: filterSelection,
              onPressed: onFilterTap,
              children: [
                _tooltipAction(
                  message: 'Open items currently requiring review.',
                  rich: _richTip(useRichTips, 'Open', 'Long-press for pending workflow items.'),
                  child: _iconText(Icons.folder_open, 'Open'),
                ),
                _tooltipAction(
                  message: 'Assigned tasks in your ownership queue.',
                  rich: _richTip(useRichTips, 'Assigned', 'Long-press for ownership scope details.'),
                  child: _iconText(Icons.assignment_ind, 'Assigned'),
                ),
                _tooltipAction(
                  message: 'Blocked issues waiting on dependencies.',
                  rich: _richTip(useRichTips, 'Blocked', 'Long-press to inspect blockers.'),
                  child: _iconText(Icons.warning_amber, 'Blocked'),
                ),
                _tooltipAction(
                  message: 'Completed items for archived review.',
                  rich: _richTip(useRichTips, 'Done', 'Long-press to inspect completion criteria.'),
                  child: _iconText(Icons.check_circle, 'Done'),
                ),
                _tooltipAction(
                  message: 'Items assigned directly to current user.',
                  rich: _richTip(useRichTips, 'Mine', 'Long-press to isolate personal queue.'),
                  child: _iconText(Icons.person, 'Mine'),
                ),
                _tooltipAction(
                  message: 'High-priority issues requiring immediate attention.',
                  rich: _richTip(useRichTips, 'Urgent', 'Long-press to inspect escalation context.'),
                  child: _iconText(Icons.priority_high, 'Urgent'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        _card(
          theme,
          'Focus / Hover Examples',
          'Keyboard and pointer surfaces where focus and hover should reveal explanatory tips.',
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Tooltip(
                message: 'Focused button: keyboard users should get context quickly.',
                waitDuration: Duration(milliseconds: 180),
                child: OutlinedButton(onPressed: () {}, child: Text('Focus Path A')),
              ),
              Tooltip(
                message: 'Hover hint: summarize action cost before click.',
                waitDuration: Duration(milliseconds: 120),
                child: FilledButton.tonal(onPressed: () {}, child: Text('Hover Path B')),
              ),
              Tooltip(
                message: 'Icon-only controls rely heavily on tooltip clarity.',
                child: IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
              ),
            ],
          ),
        ),
        if (diagnostics) ...[
          SizedBox(height: 10),
          _diagnostics(theme, 'Trigger Diagnostics', [
            'triggerMode(default): ${tooltipTheme.triggerMode}',
            'waitDuration: ${tooltipTheme.waitDuration?.inMilliseconds ?? '-'} ms',
            'showDuration: ${tooltipTheme.showDuration?.inMilliseconds ?? '-'} ms',
            'preferBelow: ${tooltipTheme.preferBelow}',
            'verticalOffset: ${tooltipTheme.verticalOffset?.toStringAsFixed(1) ?? '-'}',
          ]),
        ],
      ],
    ),
  );
}

Widget _timingLab(
  ThemeData theme,
  TooltipThemeData tooltipTheme,
  bool diagnostics,
  bool useRichTips,
  List<bool> timingSelection,
  ValueChanged<int> onTimingTap,
) {
  final timingProfiles = [
    tooltipTheme.copyWith(waitDuration: Duration(milliseconds: 100), showDuration: Duration(milliseconds: 900)),
    tooltipTheme.copyWith(waitDuration: Duration(milliseconds: 500), showDuration: Duration(milliseconds: 2100)),
    tooltipTheme.copyWith(waitDuration: Duration(milliseconds: 900), showDuration: Duration(milliseconds: 3800)),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Timing Lab', 'Compare tooltip timing profiles in dense and sparse interaction blocks.', 'timing'),
        SizedBox(height: 10),
        _card(
          theme,
          'Timing Selector',
          'Choose active profile to compare perceived responsiveness.',
          ToggleButtons(
            isSelected: timingSelection,
            onPressed: onTimingTap,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Fast')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Balanced')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Long Read')),
            ],
          ),
        ),
        SizedBox(height: 10),
        for (var i = 0; i < timingProfiles.length; i++)
          TooltipTheme(
            data: timingProfiles[i],
            child: _card(
              theme,
              'Profile ${i + 1}: ${i == 0 ? 'Fast' : i == 1 ? 'Balanced' : 'Long Read'}',
              'wait ${timingProfiles[i].waitDuration?.inMilliseconds} ms / show ${timingProfiles[i].showDuration?.inMilliseconds} ms',
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Tooltip(
                    message: 'Primary action hint for timing profile ${i + 1}.',
                    richMessage: _richTip(useRichTips, 'Primary', 'Timing profile ${i + 1} detail for primary action.'),
                    child: FilledButton(onPressed: () {}, child: Text('Primary action')),
                  ),
                  Tooltip(
                    message: 'Secondary action hint for timing profile ${i + 1}.',
                    richMessage: _richTip(useRichTips, 'Secondary', 'Timing profile ${i + 1} detail for secondary action.'),
                    child: OutlinedButton(onPressed: () {}, child: Text('Secondary action')),
                  ),
                  Tooltip(
                    message: 'Icon explanation under profile ${i + 1}.',
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.tips_and_updates_outlined)),
                  ),
                  Tooltip(
                    message: 'Chip tooltip with profile ${i + 1}.',
                    child: Chip(label: Text('Chip ${i + 1}')),
                  ),
                ],
              ),
            ),
          ),
        if (diagnostics) ...[
          SizedBox(height: 10),
          _diagnostics(theme, 'Timing Diagnostics', [
            'Fast profile: wait 100 / show 900',
            'Balanced profile: wait 500 / show 2100',
            'Long read profile: wait 900 / show 3800',
            'Compare perceived latency vs readability for each profile.',
          ]),
        ],
      ],
    ),
  );
}

Widget _imperativeLab(
  ThemeData theme,
  _TooltipZone zone,
  TooltipThemeData tooltipTheme,
  bool diagnostics,
  bool manualPulse,
  bool useRichTips,
  List<bool> settingsSelection,
  List<GlobalKey<TooltipState>> manualKeys,
  ValueChanged<int> onSettingsTap,
  VoidCallback onManualShowAll,
  ValueChanged<int> onManualShowOne,
) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Imperative State Lab', 'Drive TooltipState directly through ensureTooltipVisible and local references.', 'imperative'),
        SizedBox(height: 10),
        _card(
          theme,
          'Manual Trigger Cluster',
          'Each icon is wired to a GlobalKey<TooltipState>; use buttons below to trigger tooltip state transitions.',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var i = 0; i < manualKeys.length; i++)
                    Tooltip(
                      key: manualKeys[i],
                      triggerMode: TooltipTriggerMode.manual,
                      message: 'Manual Tooltip #$i for ${zone.name}.',
                      richMessage: _richTip(useRichTips, 'Manual $i', 'Triggered via ensureTooltipVisible().'),
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: manualPulse ? theme.colorScheme.primaryContainer.withAlpha(170) : theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: Icon([Icons.info, Icons.help, Icons.lightbulb, Icons.ads_click, Icons.visibility, Icons.touch_app][i]),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onManualShowAll,
                    icon: Icon(Icons.play_circle_fill),
                    label: Text('Show all tooltips'),
                  ),
                  for (var i = 0; i < manualKeys.length; i++)
                    OutlinedButton(
                      onPressed: () => onManualShowOne(i),
                      child: Text('Show $i'),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _card(
          theme,
          'GlobalKey Pattern',
          'Demonstrate imperative TooltipState control by using a local GlobalKey<TooltipState>.',
          _OfContextDemo(
            richTips: useRichTips,
            theme: tooltipTheme,
          ),
        ),
        SizedBox(height: 10),
        _card(
          theme,
          'State-Linked Toggles',
          'Use tooltip-enhanced settings controls where imperative hints can be shown conditionally.',
          ToggleButtons(
            isSelected: settingsSelection,
            onPressed: onSettingsTap,
            children: [
              Tooltip(
                message: 'Hints enabled: show contextual helper overlays.',
                child: _iconText(Icons.tips_and_updates_outlined, 'Hints'),
              ),
              Tooltip(
                message: 'Autosave controls periodic persistence behavior.',
                child: _iconText(Icons.save_outlined, 'Autosave'),
              ),
              Tooltip(
                message: 'Wrap mode toggles line wrapping for text panes.',
                child: _iconText(Icons.wrap_text, 'Wrap'),
              ),
              Tooltip(
                message: 'Preview displays rendered output for current draft.',
                child: _iconText(Icons.preview_outlined, 'Preview'),
              ),
            ],
          ),
        ),
        if (diagnostics) ...[
          SizedBox(height: 10),
          _diagnostics(theme, 'Imperative Diagnostics', [
            'manual keys: ${manualKeys.length}',
            'triggerMode(manual controls): TooltipTriggerMode.manual',
            'Manual pattern: key.currentState?.ensureTooltipVisible()',
            'global key pattern: key.currentState?.ensureTooltipVisible()',
            'Current zone: ${zone.name}',
          ]),
        ],
      ],
    ),
  );
}

Widget _themeZoneLab(
  ThemeData theme,
  bool compactCards,
  bool useRichTips,
  List<bool> toolbarSelection,
  List<bool> filterSelection,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFilterTap,
) {
  final metrics = [
    _MetricTile(title: 'Requests', value: '14.8k', note: 'pipeline throughput', icon: Icons.http),
    _MetricTile(title: 'Latency', value: '88ms', note: 'p95 observed', icon: Icons.speed),
    _MetricTile(title: 'Errors', value: '0.4%', note: 'critical failures', icon: Icons.error_outline),
    _MetricTile(title: 'Utilization', value: '69%', note: 'resource pressure', icon: Icons.memory),
  ];

  final localA = theme.tooltipTheme.copyWith(
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w700),
    triggerMode: TooltipTriggerMode.tap,
  );

  final localB = theme.tooltipTheme.copyWith(
    decoration: BoxDecoration(
      color: theme.colorScheme.tertiary,
      borderRadius: BorderRadius.circular(18),
    ),
    textStyle: TextStyle(color: theme.colorScheme.onTertiary, fontWeight: FontWeight.w700),
    triggerMode: TooltipTriggerMode.longPress,
  );

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Theme Zone Board', 'Nested TooltipTheme wrappers showing local tooltip style precedence.', 'zones'),
        SizedBox(height: 10),
        TooltipTheme(
          data: localA,
          child: _card(
            theme,
            'Zone A: Header Controls',
            'Tap-trigger style for quick action discovery in top controls.',
            ToggleButtons(
              isSelected: toolbarSelection,
              onPressed: onToolbarTap,
              children: [
                Tooltip(
                  message: 'Filter items by selected dimensions.',
                  richMessage: _richTip(useRichTips, 'Filter', 'Tap to narrow metric set.'),
                  child: _iconText(Icons.filter_alt_outlined, 'Filter'),
                ),
                Tooltip(
                  message: 'Sort items by chosen field and direction.',
                  richMessage: _richTip(useRichTips, 'Sort', 'Tap to order visual list.'),
                  child: _iconText(Icons.sort_outlined, 'Sort'),
                ),
                Tooltip(
                  message: 'Pin chart to monitor strip for quick watch.',
                  richMessage: _richTip(useRichTips, 'Pin', 'Tap to keep context persistent.'),
                  child: _iconText(Icons.pin_outlined, 'Pin'),
                ),
                Tooltip(
                  message: 'Export filtered metrics snapshot.',
                  richMessage: _richTip(useRichTips, 'Export', 'Tap to prepare data extract.'),
                  child: _iconText(Icons.download_outlined, 'Export'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        TooltipTheme(
          data: localB,
          child: _card(
            theme,
            'Zone B: Facet Controls',
            'Long-press style for dense facets to reduce accidental popups.',
            ToggleButtons(
              isSelected: filterSelection,
              onPressed: onFilterTap,
              children: [
                Tooltip(message: 'Cloud systems', child: _iconText(Icons.cloud_outlined, 'Cloud')),
                Tooltip(message: 'Storage endpoints', child: _iconText(Icons.storage_outlined, 'Storage')),
                Tooltip(message: 'CPU pathways', child: _iconText(Icons.memory_outlined, 'CPU')),
                Tooltip(message: 'Power channels', child: _iconText(Icons.bolt_outlined, 'Power')),
                Tooltip(message: 'Security layer', child: _iconText(Icons.shield_outlined, 'Security')),
                Tooltip(message: 'User pathways', child: _iconText(Icons.people_outline, 'Users')),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        _card(
          theme,
          'Integrated Metric Scene',
          'Cards with local tooltip hints per metric action entry points.',
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final m in metrics)
                SizedBox(
                  width: compactCards ? 226 : 252,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(compactCards ? 10 : 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(m.icon),
                              SizedBox(width: 8),
                              Expanded(child: Text(m.title, style: TextStyle(fontWeight: FontWeight.w700))),
                              Tooltip(
                                message: 'Inspect ${m.title} trend details.',
                                child: IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(m.value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          Text(m.note),
                          SizedBox(height: 8),
                          Tooltip(
                            message: 'Open ${m.title} deep diagnostics.',
                            child: OutlinedButton(onPressed: () {}, child: Text('Inspect')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideBoard(
  ThemeData theme,
  bool showGuide,
  bool showTimeline,
  int interactions,
  int tick,
  List<String> timeline,
) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Guide + Timeline', 'Instructive summary of TooltipState usage and interaction history.', 'guide'),
        if (showGuide) ...[
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.tertiaryContainer.withAlpha(108),
              border: Border.all(color: theme.colorScheme.tertiary.withAlpha(120)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TooltipState Guide', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                SizedBox(height: 8),
                for (final line in _guideLines) _bullet(theme, line),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                SizedBox(height: 8),
                for (final item in _faq)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.q, style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text(item.a),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (showTimeline) ...[
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.primaryContainer.withAlpha(106),
              border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                SizedBox(height: 8),
                Text('interactions: $interactions  |  tick: $tick'),
                SizedBox(height: 8),
                if (timeline.isEmpty)
                  Text('No interactions yet. Use controls and boards to populate this timeline.')
                else
                  for (final event in timeline)
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(event, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                    ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _section(ThemeData theme, String title, String subtitle, String chip) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(175))),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withAlpha(170),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(chip, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      ),
    ],
  );
}

Widget _card(ThemeData theme, String title, String subtitle, Widget child) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surface.withAlpha(195),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
        SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180))),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

Widget _diagnostics(ThemeData theme, String title, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.primaryContainer.withAlpha(100),
      border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        SizedBox(height: 8),
        for (final line in lines)
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(line, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
          ),
      ],
    ),
  );
}

Widget _tooltipAction({
  required String message,
  required InlineSpan? rich,
  required Widget child,
}) {
  return Tooltip(
    message: message,
    richMessage: rich,
    child: child,
  );
}

InlineSpan? _richTip(bool enabled, String title, String body) {
  if (!enabled) {
    return null;
  }
  return TextSpan(
    text: '$title\n',
    style: TextStyle(fontWeight: FontWeight.w800),
    children: [
      TextSpan(text: body, style: TextStyle(fontWeight: FontWeight.w500)),
    ],
  );
}

Widget _iconText(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 5),
        Text(text),
      ],
    ),
  );
}

Widget _bullet(ThemeData theme, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 7, right: 8),
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
        ),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class _OfContextDemo extends StatefulWidget {
  const _OfContextDemo({required this.richTips, required this.theme});

  final bool richTips;
  final TooltipThemeData theme;

  @override
  State<_OfContextDemo> createState() => _OfContextDemoState();
}

class _OfContextDemoState extends State<_OfContextDemo> {
  final GlobalKey<TooltipState> _key = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return TooltipTheme(
      data: widget.theme.copyWith(triggerMode: TooltipTriggerMode.manual),
      child: Row(
        children: [
          Tooltip(
            key: _key,
            message: 'Local tooltip controlled through GlobalKey<TooltipState>.',
            richMessage: widget.richTips
                ? TextSpan(
                    text: 'GlobalKey<TooltipState>\n',
                    style: TextStyle(fontWeight: FontWeight.w800),
                    children: [TextSpan(text: 'Use key.currentState?.ensureTooltipVisible() for imperative triggers.')],
                  )
                : null,
            child: FilledButton.icon(
              onPressed: () {
                _key.currentState?.ensureTooltipVisible();
              },
              icon: Icon(Icons.touch_app),
              label: Text('Call key.currentState'),
            ),
          ),
          SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              _key.currentState?.ensureTooltipVisible();
            },
            child: Text('Trigger same tooltip'),
          ),
        ],
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  _HeaderPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed.toInt() + 73);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final width = size.width * (0.3 + random.nextDouble() * 0.62);
      final y = 8 + i * 8.0;
      paint.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, width, 5.2), Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeaderPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}
