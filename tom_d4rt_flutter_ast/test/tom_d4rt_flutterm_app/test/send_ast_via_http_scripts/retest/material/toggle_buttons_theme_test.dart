import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ThemeZone {
  const _ThemeZone({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.brightness,
    required this.toggleTheme,
  });

  final String id;
  final String name;
  final String description;
  final Color seed;
  final Brightness brightness;
  final ToggleButtonsThemeData toggleTheme;
}

class _Scenario {
  const _Scenario({required this.id, required this.title, required this.description});

  final String id;
  final String title;
  final String description;
}

class _MetricCard {
  const _MetricCard({required this.title, required this.value, required this.icon, required this.note});

  final String title;
  final String value;
  final IconData icon;
  final String note;
}

const List<_ThemeZone> _zones = [
  _ThemeZone(
    id: 'console',
    name: 'Console Zone',
    description: 'High-clarity controls for dense dashboards and operator workspaces.',
    seed: Color(0xFF0EA5E9),
    brightness: Brightness.dark,
    toggleTheme: ToggleButtonsThemeData(
      color: Color(0xFFCFEFFF),
      selectedColor: Color(0xFF082F49),
      disabledColor: Color(0xFF5B7386),
      fillColor: Color(0xFF7DD3FC),
      borderColor: Color(0xFF1D4ED8),
      selectedBorderColor: Color(0xFF7DD3FC),
      disabledBorderColor: Color(0xFF1E3A5F),
      borderWidth: 1.5,
      borderRadius: BorderRadius.all(Radius.circular(9)),
      textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      constraints: BoxConstraints(minHeight: 40, minWidth: 70),
      focusColor: Color(0x337DD3FC),
      hoverColor: Color(0x227DD3FC),
      splashColor: Color(0x337DD3FC),
      highlightColor: Color(0x227DD3FC),
    ),
  ),
  _ThemeZone(
    id: 'editorial',
    name: 'Editorial Zone',
    description: 'Softer controls intended for content and writing environments.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
    toggleTheme: ToggleButtonsThemeData(
      color: Color(0xFF065F46),
      selectedColor: Color(0xFFFFFFFF),
      disabledColor: Color(0xFF97AFA6),
      fillColor: Color(0xFF10B981),
      borderColor: Color(0xFF34D399),
      selectedBorderColor: Color(0xFF10B981),
      disabledBorderColor: Color(0xFFD1FAE5),
      borderWidth: 1.6,
      borderRadius: BorderRadius.all(Radius.circular(14)),
      textStyle: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
      constraints: BoxConstraints(minHeight: 42, minWidth: 74),
      focusColor: Color(0x3310B981),
      hoverColor: Color(0x2210B981),
      splashColor: Color(0x3310B981),
      highlightColor: Color(0x2210B981),
    ),
  ),
  _ThemeZone(
    id: 'campaign',
    name: 'Campaign Zone',
    description: 'Expressive rounded toggle sets for landing and marketing controls.',
    seed: Color(0xFFEA580C),
    brightness: Brightness.light,
    toggleTheme: ToggleButtonsThemeData(
      color: Color(0xFF9A3412),
      selectedColor: Color(0xFFFFFFFF),
      disabledColor: Color(0xFFC4A896),
      fillColor: Color(0xFFF97316),
      borderColor: Color(0xFFFB923C),
      selectedBorderColor: Color(0xFFF97316),
      disabledBorderColor: Color(0xFFFED7AA),
      borderWidth: 1.8,
      borderRadius: BorderRadius.all(Radius.circular(18)),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      constraints: BoxConstraints(minHeight: 44, minWidth: 78),
      focusColor: Color(0x33F97316),
      hoverColor: Color(0x22F97316),
      splashColor: Color(0x33F97316),
      highlightColor: Color(0x22F97316),
    ),
  ),
  _ThemeZone(
    id: 'night-lab',
    name: 'Night Lab',
    description: 'Creative, high-contrast visual language for experimentation and prototypes.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
    toggleTheme: ToggleButtonsThemeData(
      color: Color(0xFFE9D5FF),
      selectedColor: Color(0xFF312E81),
      disabledColor: Color(0xFF756B95),
      fillColor: Color(0xFFC4B5FD),
      borderColor: Color(0xFFA78BFA),
      selectedBorderColor: Color(0xFFC4B5FD),
      disabledBorderColor: Color(0xFF4C1D95),
      borderWidth: 1.7,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      textStyle: TextStyle(fontSize: 13.2, fontWeight: FontWeight.w700),
      constraints: BoxConstraints(minHeight: 42, minWidth: 72),
      focusColor: Color(0x33C4B5FD),
      hoverColor: Color(0x22C4B5FD),
      splashColor: Color(0x33C4B5FD),
      highlightColor: Color(0x22C4B5FD),
    ),
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    id: 'tooling',
    title: 'Tooling Ribbon',
    description: 'Theme scope around formatting and command actions in a top ribbon.',
  ),
  _Scenario(
    id: 'facets',
    title: 'Facet Filters',
    description: 'Per-panel theme zone for data filters with mixed density and disabled states.',
  ),
  _Scenario(
    id: 'settings',
    title: 'Settings Groups',
    description: 'Section-level inherited themes for preference controls.',
  ),
  _Scenario(
    id: 'mixed',
    title: 'Mixed Surface',
    description: 'Multiple ToggleButtonsTheme wrappers nested in one page to show precedence.',
  ),
];

const List<String> _guideLines = [
  'ToggleButtonsTheme is an InheritedTheme used to style descendant ToggleButtons widgets.',
  'Use ToggleButtonsTheme when you need local, scoped theming for part of the widget tree.',
  'Theme.of(context).toggleButtonsTheme is global; ToggleButtonsTheme can locally override it.',
  'Nested ToggleButtonsTheme widgets follow nearest-ancestor precedence for resolved values.',
  'Use scoped themes to keep toolbar controls visually separate from panel filters.',
  'Always validate selected, unselected, disabled, focus, hover, and splash states in context.',
  'Tune constraints and textStyle together so labels remain legible across compact and spacious layouts.',
  'Use side-by-side boards to verify that inherited scope boundaries produce expected styling.',
  'ToggleButtonsTheme is especially useful in modular UIs with reusable panel widgets.',
  'Document your theme intent to avoid accidental overrides from distant ancestors.',
];

const List<String> _faqQuestions = [
  'When should I prefer ToggleButtonsTheme over direct widget styling?',
  'Can I combine ToggleButtonsTheme with ThemeData.toggleButtonsTheme?',
  'How does nearest-ancestor precedence work in nested theme scopes?',
  'What should I test before shipping a scoped ToggleButtons theme?',
];

const List<String> _faqAnswers = [
  'Use direct widget styling for one-off controls. Use ToggleButtonsTheme when many descendants need a shared local style.',
  'Yes. The global ThemeData value provides baseline defaults, and local ToggleButtonsTheme wrappers can override per subtree.',
  'ToggleButtonsTheme.of(context) resolves to the closest wrapper above the current build context, so inner zones override outer zones.',
  'Check readability, touch target constraints, border/fill contrast, disabled affordance, and behavior inside nested wrappers.',
];

dynamic build(BuildContext context) {
  var zoneIndex = 0;
  var scenarioIndex = 0;
  var boardIndex = 0;
  var dense = false;
  var showDiagnostics = true;
  var showLegend = true;
  var iconLabels = true;
  var disableAlternating = false;
  var compactPanel = false;
  var widthFactor = 1.0;
  var radiusDelta = 0.0;
  var interactions = 0;
  var tick = 0;

  var toolbar = <bool>[true, false, false, false];
  var facets = <bool>[true, true, false, false, true, false];
  var settingsA = <bool>[true, false, true, false];
  var settingsB = <bool>[false, true, false, true];
  var compareLeft = <bool>[true, false, false];
  var compareRight = <bool>[false, true, false];

  final timeline = <String>[];

  void record(String message) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    timeline.insert(0, '$stamp $message');
    if (timeline.length > 28) {
      timeline.removeRange(28, timeline.length);
    }
  }

  debugPrint('ToggleButtonsTheme deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final zone = _zones[zoneIndex];
      final scenario = _scenarios[scenarioIndex];

      final scheme = ColorScheme.fromSeed(seedColor: zone.seed, brightness: zone.brightness);
      final rootTheme = ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        visualDensity: dense ? VisualDensity.compact : VisualDensity.standard,
      );

      final resolvedTheme = _resolvedToggleTheme(
        zone.toggleTheme,
        widthFactor: widthFactor,
        radiusDelta: radiusDelta,
      );

      final pageTheme = rootTheme.copyWith(toggleButtonsTheme: resolvedTheme);

      return Theme(
        data: pageTheme,
        child: Container(
          color: pageTheme.colorScheme.surface,
          child: Column(
            children: [
              _topBanner(
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
                    _controlRail(
                      theme: pageTheme,
                      zoneIndex: zoneIndex,
                      scenarioIndex: scenarioIndex,
                      boardIndex: boardIndex,
                      dense: dense,
                      showDiagnostics: showDiagnostics,
                      showLegend: showLegend,
                      iconLabels: iconLabels,
                      disableAlternating: disableAlternating,
                      compactPanel: compactPanel,
                      widthFactor: widthFactor,
                      radiusDelta: radiusDelta,
                      onZoneChanged: (v) {
                        setState(() {
                          zoneIndex = v;
                          tick += 1;
                          record('Theme zone switched to ${_zones[v].name}.');
                        });
                      },
                      onScenarioChanged: (v) {
                        setState(() {
                          scenarioIndex = v;
                          tick += 1;
                          record('Scenario switched to ${_scenarios[v].title}.');
                        });
                      },
                      onBoardChanged: (v) {
                        setState(() {
                          boardIndex = v;
                          tick += 1;
                          record('Board switched to ${_boardTitle(v)}.');
                        });
                      },
                      onDenseChanged: (v) {
                        setState(() {
                          dense = v;
                          tick += 1;
                          record('Dense mode ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDiagnosticsChanged: (v) {
                        setState(() {
                          showDiagnostics = v;
                          tick += 1;
                          record('Diagnostics ${v ? 'shown' : 'hidden'}.');
                        });
                      },
                      onLegendChanged: (v) {
                        setState(() {
                          showLegend = v;
                          tick += 1;
                          record('Legend ${v ? 'visible' : 'hidden'}.');
                        });
                      },
                      onIconLabelsChanged: (v) {
                        setState(() {
                          iconLabels = v;
                          tick += 1;
                          record('Icon labels ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDisableAlternatingChanged: (v) {
                        setState(() {
                          disableAlternating = v;
                          tick += 1;
                          record('Alternating disable ${v ? 'on' : 'off'}.');
                        });
                      },
                      onCompactPanelChanged: (v) {
                        setState(() {
                          compactPanel = v;
                          tick += 1;
                          record('Compact panel ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onWidthFactorChanged: (v) {
                        setState(() {
                          widthFactor = v;
                          tick += 1;
                        });
                      },
                      onRadiusDeltaChanged: (v) {
                        setState(() {
                          radiusDelta = v;
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
                              pageTheme.colorScheme.surfaceContainerHighest.withAlpha(170),
                              pageTheme.colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: pageTheme.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: _boardArea(
                          boardIndex: boardIndex,
                          theme: pageTheme,
                          toggleTheme: resolvedTheme,
                          zone: zone,
                          scenario: scenario,
                          showDiagnostics: showDiagnostics,
                          showLegend: showLegend,
                          iconLabels: iconLabels,
                          disableAlternating: disableAlternating,
                          compactPanel: compactPanel,
                          toolbarSelection: toolbar,
                          facetSelection: facets,
                          settingsSelectionA: settingsA,
                          settingsSelectionB: settingsB,
                          compareSelectionLeft: compareLeft,
                          compareSelectionRight: compareRight,
                          interactions: interactions,
                          tick: tick,
                          timeline: timeline,
                          onToolbarTap: (i) {
                            setState(() {
                              toolbar = _selectSingle(toolbar, i);
                              interactions += 1;
                              tick += 1;
                              record('Toolbar index $i pressed.');
                            });
                          },
                          onFacetTap: (i) {
                            setState(() {
                              facets = _toggleAt(facets, i);
                              interactions += 1;
                              tick += 1;
                              record('Facet index $i toggled.');
                            });
                          },
                          onSettingsATap: (i) {
                            setState(() {
                              settingsA = _toggleAt(settingsA, i);
                              interactions += 1;
                              tick += 1;
                              record('Settings A index $i toggled.');
                            });
                          },
                          onSettingsBTap: (i) {
                            setState(() {
                              settingsB = _toggleAt(settingsB, i);
                              interactions += 1;
                              tick += 1;
                              record('Settings B index $i toggled.');
                            });
                          },
                          onCompareLeftTap: (i) {
                            setState(() {
                              compareLeft = _selectSingle(compareLeft, i);
                              interactions += 1;
                              tick += 1;
                              record('Compare left index $i selected.');
                            });
                          },
                          onCompareRightTap: (i) {
                            setState(() {
                              compareRight = _selectSingle(compareRight, i);
                              interactions += 1;
                              tick += 1;
                              record('Compare right index $i selected.');
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

ToggleButtonsThemeData _resolvedToggleTheme(
  ToggleButtonsThemeData source, {
  required double widthFactor,
  required double radiusDelta,
}) {
  final constraints = source.constraints;
  final adjustedConstraints = constraints == null
      ? null
      : BoxConstraints(
          minWidth: constraints.minWidth * widthFactor,
          minHeight: constraints.minHeight,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        );

  final radius = source.borderRadius?.resolve(TextDirection.ltr).topLeft.x ?? 10;
  final adjustedRadius = BorderRadius.circular((radius + radiusDelta).clamp(3, 32).toDouble());

  return source.copyWith(
    constraints: adjustedConstraints,
    borderRadius: adjustedRadius,
  );
}

List<bool> _selectSingle(List<bool> values, int index) {
  final next = List<bool>.filled(values.length, false);
  next[index] = true;
  return next;
}

List<bool> _toggleAt(List<bool> values, int index) {
  final next = List<bool>.from(values);
  next[index] = !next[index];
  return next;
}

String _boardTitle(int index) {
  const titles = [
    'Global vs Local',
    'Nested Precedence',
    'Runtime Switchboard',
    'Real-World Scenes',
    'Guide + Timeline',
  ];
  return titles[index.clamp(0, titles.length - 1)];
}

Widget _topBanner({
  required ThemeData theme,
  required _ThemeZone zone,
  required _Scenario scenario,
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
          theme.colorScheme.primaryContainer.withAlpha(180),
          theme.colorScheme.secondaryContainer.withAlpha(150),
          theme.colorScheme.tertiaryContainer.withAlpha(130),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
            color: theme.colorScheme.surface,
          ),
          child: CustomPaint(
            painter: _BannerGlyphPainter(
              base: zone.toggleTheme.fillColor ?? theme.colorScheme.primary,
              accent: zone.toggleTheme.selectedBorderColor ?? theme.colorScheme.secondary,
              seed: tick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ToggleButtonsTheme Inherited Scope Lab', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'Zone: ${zone.name}  |  Scenario: ${scenario.title}  |  Interactions: $interactions',
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

Widget _controlRail({
  required ThemeData theme,
  required int zoneIndex,
  required int scenarioIndex,
  required int boardIndex,
  required bool dense,
  required bool showDiagnostics,
  required bool showLegend,
  required bool iconLabels,
  required bool disableAlternating,
  required bool compactPanel,
  required double widthFactor,
  required double radiusDelta,
  required ValueChanged<int> onZoneChanged,
  required ValueChanged<int> onScenarioChanged,
  required ValueChanged<int> onBoardChanged,
  required ValueChanged<bool> onDenseChanged,
  required ValueChanged<bool> onDiagnosticsChanged,
  required ValueChanged<bool> onLegendChanged,
  required ValueChanged<bool> onIconLabelsChanged,
  required ValueChanged<bool> onDisableAlternatingChanged,
  required ValueChanged<bool> onCompactPanelChanged,
  required ValueChanged<double> onWidthFactorChanged,
  required ValueChanged<double> onRadiusDeltaChanged,
}) {
  return Container(
    width: 378,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.surfaceContainerHighest.withAlpha(124),
          theme.colorScheme.surfaceContainer.withAlpha(96),
          theme.colorScheme.surfaceContainerLow.withAlpha(84),
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
          Text('Theme Scope Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Change inherited ToggleButtonsTheme scopes and inspect behavior per board.'),
          SizedBox(height: 10),
          _dropdownCard('Theme Zone', zoneIndex, _zones.map((e) => e.name).toList(), onZoneChanged),
          _dropdownCard('Scenario', scenarioIndex, _scenarios.map((e) => e.title).toList(), onScenarioChanged),
          _dropdownCard('Board', boardIndex, List.generate(5, _boardTitle), onBoardChanged),
          _switchCard('Dense visual density', 'Compact spacing in page controls', dense, onDenseChanged),
          _switchCard('Show diagnostics', 'Reveal resolved values and source precedence', showDiagnostics, onDiagnosticsChanged),
          _switchCard('Show legend', 'Display zone/precedence legends in each board', showLegend, onLegendChanged),
          _switchCard('Show icon labels', 'Render icons + text in toggle buttons', iconLabels, onIconLabelsChanged),
          _switchCard('Disable alternating items', 'Disable odd indices in interactive groups', disableAlternating, onDisableAlternatingChanged),
          _switchCard('Compact panels', 'Use compact cards in scene board', compactPanel, onCompactPanelChanged),
          _sliderCard('Min-width scale', widthFactor, 0.75, 1.55, onWidthFactorChanged),
          _sliderCard('Radius delta', radiusDelta, -6, 12, onRadiusDeltaChanged),
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
      color: Colors.white.withAlpha(135),
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
      color: Colors.white.withAlpha(135),
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
      color: Colors.white.withAlpha(135),
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

Widget _boardArea({
  required int boardIndex,
  required ThemeData theme,
  required ToggleButtonsThemeData toggleTheme,
  required _ThemeZone zone,
  required _Scenario scenario,
  required bool showDiagnostics,
  required bool showLegend,
  required bool iconLabels,
  required bool disableAlternating,
  required bool compactPanel,
  required List<bool> toolbarSelection,
  required List<bool> facetSelection,
  required List<bool> settingsSelectionA,
  required List<bool> settingsSelectionB,
  required List<bool> compareSelectionLeft,
  required List<bool> compareSelectionRight,
  required int interactions,
  required int tick,
  required List<String> timeline,
  required ValueChanged<int> onToolbarTap,
  required ValueChanged<int> onFacetTap,
  required ValueChanged<int> onSettingsATap,
  required ValueChanged<int> onSettingsBTap,
  required ValueChanged<int> onCompareLeftTap,
  required ValueChanged<int> onCompareRightTap,
}) {
  switch (boardIndex) {
    case 0:
      return _globalVsLocalBoard(
        theme,
        toggleTheme,
        showDiagnostics,
        showLegend,
        iconLabels,
        disableAlternating,
        toolbarSelection,
        facetSelection,
        onToolbarTap,
        onFacetTap,
      );
    case 1:
      return _nestedPrecedenceBoard(
        theme,
        showLegend,
        iconLabels,
        compareSelectionLeft,
        compareSelectionRight,
        onCompareLeftTap,
        onCompareRightTap,
      );
    case 2:
      return _runtimeSwitchboardBoard(
        theme,
        zone,
        scenario,
        showDiagnostics,
        iconLabels,
        disableAlternating,
        settingsSelectionA,
        settingsSelectionB,
        onSettingsATap,
        onSettingsBTap,
      );
    case 3:
      return _realWorldScenesBoard(
        theme,
        scenario,
        compactPanel,
        iconLabels,
        disableAlternating,
        toolbarSelection,
        facetSelection,
        onToolbarTap,
        onFacetTap,
      );
    default:
      return _guideBoard(theme, interactions, tick, timeline);
  }
}

Widget _globalVsLocalBoard(
  ThemeData theme,
  ToggleButtonsThemeData activeTheme,
  bool showDiagnostics,
  bool showLegend,
  bool iconLabels,
  bool disableAlternating,
  List<bool> toolbarSelection,
  List<bool> facetSelection,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFacetTap,
) {
  final localA = activeTheme.copyWith(
    fillColor: Color.lerp(activeTheme.fillColor, Colors.white, 0.15),
    borderRadius: BorderRadius.circular((activeTheme.borderRadius?.resolve(TextDirection.ltr).topLeft.x ?? 12) + 3),
  );
  final localB = activeTheme.copyWith(
    fillColor: Color.lerp(activeTheme.fillColor, Colors.black, 0.22),
    borderWidth: (activeTheme.borderWidth ?? 1.5) + 0.5,
  );

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(theme, 'Global vs Local Theme Scope', 'Compare root ThemeData.toggleButtonsTheme with nested ToggleButtonsTheme wrappers.', 'scope'),
        SizedBox(height: 10),
        if (showLegend) _legend(theme, [
          'Root page theme provides baseline ToggleButtonsThemeData.',
          'Local Zone A applies a mild override with larger radius.',
          'Local Zone B applies stronger border and darker fill override.',
        ]),
        if (showLegend) SizedBox(height: 10),
        _scopeCard(
          theme,
          title: 'Root Scope (ThemeData only)',
          subtitle: 'No local wrapper: ToggleButtonsTheme.of(context) resolves from ThemeData baseline.',
          child: ToggleButtons(
            isSelected: toolbarSelection,
            onPressed: (i) {
              if (disableAlternating && i.isOdd) return;
              onToolbarTap(i);
            },
            children: [
              _toggleLabel(iconLabels, Icons.format_bold, 'Bold'),
              _toggleLabel(iconLabels, Icons.format_italic, 'Italic'),
              _toggleLabel(iconLabels, Icons.link, 'Link'),
              _toggleLabel(iconLabels, Icons.code, 'Code'),
            ],
          ),
        ),
        SizedBox(height: 10),
        ToggleButtonsTheme(
          data: localA,
          child: _scopeCard(
            theme,
            title: 'Local Zone A Wrapper',
            subtitle: 'Wrapper overrides the nearest inherited theme for descendant buttons.',
            child: ToggleButtons(
              isSelected: facetSelection,
              onPressed: (i) {
                if (disableAlternating && i.isOdd) return;
                onFacetTap(i);
              },
              children: [
                _toggleLabel(iconLabels, Icons.folder_open, 'Open'),
                _toggleLabel(iconLabels, Icons.assignment_ind, 'Assigned'),
                _toggleLabel(iconLabels, Icons.warning_amber, 'Blocked'),
                _toggleLabel(iconLabels, Icons.check_circle, 'Done'),
                _toggleLabel(iconLabels, Icons.person, 'Mine'),
                _toggleLabel(iconLabels, Icons.priority_high, 'Urgent'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        ToggleButtonsTheme(
          data: localB,
          child: _scopeCard(
            theme,
            title: 'Local Zone B Wrapper',
            subtitle: 'Second local wrapper with different border/fill profile in same page.',
            child: ToggleButtons(
              isSelected: [true, false, true],
              onPressed: (_) {},
              children: [
                _toggleLabel(iconLabels, Icons.view_module, 'Grid'),
                _toggleLabel(iconLabels, Icons.view_list, 'List'),
                _toggleLabel(iconLabels, Icons.splitscreen, 'Split'),
              ],
            ),
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 10),
          _diagnosticCard(
            theme,
            title: 'Resolved Diagnostics',
            lines: [
              'Root fillColor: ${_formatColor(activeTheme.fillColor)}',
              'Root borderColor: ${_formatColor(activeTheme.borderColor)}',
              'Root selectedBorderColor: ${_formatColor(activeTheme.selectedBorderColor)}',
              'Root borderWidth: ${(activeTheme.borderWidth ?? 0).toStringAsFixed(2)}',
              'Root radius: ${activeTheme.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
              'Local A radius: ${localA.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
              'Local B borderWidth: ${(localB.borderWidth ?? 0).toStringAsFixed(2)}',
              'Key point: nearest ToggleButtonsTheme ancestor wins within its subtree.',
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _nestedPrecedenceBoard(
  ThemeData theme,
  bool showLegend,
  bool iconLabels,
  List<bool> leftSelection,
  List<bool> rightSelection,
  ValueChanged<int> onLeftTap,
  ValueChanged<int> onRightTap,
) {
  final outer = theme.toggleButtonsTheme.copyWith(
    fillColor: theme.colorScheme.primary,
    selectedColor: theme.colorScheme.onPrimary,
    borderRadius: BorderRadius.circular(8),
  );
  final middle = theme.toggleButtonsTheme.copyWith(
    fillColor: theme.colorScheme.tertiary,
    selectedColor: theme.colorScheme.onTertiary,
    borderRadius: BorderRadius.circular(14),
  );
  final inner = theme.toggleButtonsTheme.copyWith(
    fillColor: theme.colorScheme.secondary,
    selectedColor: theme.colorScheme.onSecondary,
    borderRadius: BorderRadius.circular(20),
  );

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(theme, 'Nested Precedence Map', 'Visualize how closest ToggleButtonsTheme wrapper takes precedence.', 'nested'),
        SizedBox(height: 10),
        if (showLegend) _legend(theme, [
          'Outer wrapper colors baseline controls.',
          'Middle wrapper overrides descendants inside its subtree.',
          'Inner wrapper overrides both outer and middle for its own subtree.',
        ]),
        if (showLegend) SizedBox(height: 10),
        ToggleButtonsTheme(
          data: outer,
          child: _scopeCard(
            theme,
            title: 'Outer Scope',
            subtitle: 'This zone inherits outer values unless a nested wrapper replaces them.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: leftSelection,
                  onPressed: onLeftTap,
                  children: [
                    _toggleLabel(iconLabels, Icons.looks_one, 'One'),
                    _toggleLabel(iconLabels, Icons.looks_two, 'Two'),
                    _toggleLabel(iconLabels, Icons.looks_3, 'Three'),
                  ],
                ),
                SizedBox(height: 10),
                ToggleButtonsTheme(
                  data: middle,
                  child: _scopeCard(
                    theme,
                    title: 'Middle Scope',
                    subtitle: 'Middle wrapper now overrides outer for this subtree.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ToggleButtons(
                          isSelected: rightSelection,
                          onPressed: onRightTap,
                          children: [
                            _toggleLabel(iconLabels, Icons.timeline, 'Flow'),
                            _toggleLabel(iconLabels, Icons.stacked_bar_chart, 'Stack'),
                            _toggleLabel(iconLabels, Icons.scatter_plot, 'Plot'),
                          ],
                        ),
                        SizedBox(height: 10),
                        ToggleButtonsTheme(
                          data: inner,
                          child: _scopeCard(
                            theme,
                            title: 'Inner Scope',
                            subtitle: 'Innermost wrapper wins for descendants here.',
                            child: ToggleButtons(
                              isSelected: [true, false, true],
                              onPressed: (_) {},
                              children: [
                                _toggleLabel(iconLabels, Icons.radio_button_checked, 'Inner A'),
                                _toggleLabel(iconLabels, Icons.radio_button_checked, 'Inner B'),
                                _toggleLabel(iconLabels, Icons.radio_button_checked, 'Inner C'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        _diagnosticCard(
          theme,
          title: 'Precedence Summary',
          lines: [
            'Outer radius: ${outer.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
            'Middle radius: ${middle.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
            'Inner radius: ${inner.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
            'Inside inner scope, ToggleButtonsTheme.of(context) resolves to inner data.',
            'Outside inner but inside middle, it resolves to middle.',
            'Outside middle but inside outer, it resolves to outer.',
          ],
        ),
      ],
    ),
  );
}

Widget _runtimeSwitchboardBoard(
  ThemeData theme,
  _ThemeZone zone,
  _Scenario scenario,
  bool showDiagnostics,
  bool iconLabels,
  bool disableAlternating,
  List<bool> settingsA,
  List<bool> settingsB,
  ValueChanged<int> onSettingsATap,
  ValueChanged<int> onSettingsBTap,
) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(theme, 'Runtime Switchboard', 'Interactively test ToggleButtonsTheme scope changes with live state groups.', 'runtime'),
        SizedBox(height: 10),
        _scopeCard(
          theme,
          title: 'Scenario Context',
          subtitle: scenario.description,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Zone: ${zone.name}', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final chip in [
                    'fill ${_formatColor(zone.toggleTheme.fillColor)}',
                    'border ${_formatColor(zone.toggleTheme.borderColor)}',
                    'selected ${_formatColor(zone.toggleTheme.selectedColor)}',
                    'radius ${zone.toggleTheme.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(0) ?? '-'}',
                  ])
                    Chip(label: Text(chip)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _scopeCard(
          theme,
          title: 'Settings Group A',
          subtitle: 'Multi-select group in active inherited zone.',
          child: ToggleButtons(
            isSelected: settingsA,
            onPressed: (i) {
              if (disableAlternating && i.isOdd) return;
              onSettingsATap(i);
            },
            children: [
              _toggleLabel(iconLabels, Icons.tips_and_updates_outlined, 'Hints'),
              _toggleLabel(iconLabels, Icons.save_outlined, 'Autosave'),
              _toggleLabel(iconLabels, Icons.wrap_text, 'Wrap'),
              _toggleLabel(iconLabels, Icons.preview_outlined, 'Preview'),
            ],
          ),
        ),
        SizedBox(height: 10),
        _scopeCard(
          theme,
          title: 'Settings Group B',
          subtitle: 'Second group to validate consistency under same inherited scope.',
          child: ToggleButtons(
            isSelected: settingsB,
            onPressed: (i) {
              if (disableAlternating && i.isOdd) return;
              onSettingsBTap(i);
            },
            children: [
              _toggleLabel(iconLabels, Icons.notifications_none, 'Alerts'),
              _toggleLabel(iconLabels, Icons.security_outlined, 'Security'),
              _toggleLabel(iconLabels, Icons.timer_outlined, 'Timers'),
              _toggleLabel(iconLabels, Icons.cloud_outlined, 'Sync'),
            ],
          ),
        ),
        SizedBox(height: 10),
        _scopeCard(
          theme,
          title: 'Disabled / Read-Only Behavior',
          subtitle: 'A disabled toggle row for checking inherited disabled colors and borders.',
          child: ToggleButtons(
            isSelected: [false, true, false, true],
            onPressed: null,
            children: [
              _toggleLabel(iconLabels, Icons.block, 'Off A'),
              _toggleLabel(iconLabels, Icons.block, 'Off B'),
              _toggleLabel(iconLabels, Icons.block, 'Off C'),
              _toggleLabel(iconLabels, Icons.block, 'Off D'),
            ],
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 10),
          _diagnosticCard(
            theme,
            title: 'Runtime Diagnostics',
            lines: [
              'Group A selected: ${settingsA.where((e) => e).length}/${settingsA.length}',
              'Group B selected: ${settingsB.where((e) => e).length}/${settingsB.length}',
              'constraints: ${zone.toggleTheme.constraints?.minWidth.toStringAsFixed(1) ?? '-'} x ${zone.toggleTheme.constraints?.minHeight.toStringAsFixed(1) ?? '-'}',
              'textStyle: ${zone.toggleTheme.textStyle?.fontWeight} ${zone.toggleTheme.textStyle?.fontSize?.toStringAsFixed(1) ?? '-'}',
              'of(context) usage: resolved from nearest ToggleButtonsTheme in this board subtree.',
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _realWorldScenesBoard(
  ThemeData theme,
  _Scenario scenario,
  bool compactPanel,
  bool iconLabels,
  bool disableAlternating,
  List<bool> toolbarSelection,
  List<bool> facetSelection,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFacetTap,
) {
  final cards = [
    _MetricCard(title: 'Requests', value: '17.2k', icon: Icons.http, note: 'throughput in the selected range'),
    _MetricCard(title: 'Latency', value: '91ms', icon: Icons.speed, note: 'p95 from current panel filters'),
    _MetricCard(title: 'Error Rate', value: '0.7%', icon: Icons.error_outline, note: 'service failures per hour'),
    _MetricCard(title: 'Utilization', value: '72%', icon: Icons.memory, note: 'compute saturation trend'),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(theme, 'Real-World Scene', scenario.description, 'scene'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(compactPanel ? 10 : 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search telemetry',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        isDense: compactPanel,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  FilledButton.icon(onPressed: () {}, icon: Icon(Icons.refresh), label: Text('Refresh')),
                ],
              ),
              SizedBox(height: 12),
              Text('Toolbar', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: toolbarSelection,
                onPressed: (i) {
                  if (disableAlternating && i.isOdd) return;
                  onToolbarTap(i);
                },
                children: [
                  _toggleLabel(iconLabels, Icons.filter_alt_outlined, 'Filter'),
                  _toggleLabel(iconLabels, Icons.sort_outlined, 'Sort'),
                  _toggleLabel(iconLabels, Icons.pin_outlined, 'Pin'),
                  _toggleLabel(iconLabels, Icons.download_outlined, 'Export'),
                ],
              ),
              SizedBox(height: 12),
              Text('Facets', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: facetSelection,
                onPressed: (i) {
                  if (disableAlternating && i.isOdd) return;
                  onFacetTap(i);
                },
                children: [
                  _toggleLabel(iconLabels, Icons.cloud_outlined, 'Cloud'),
                  _toggleLabel(iconLabels, Icons.storage_outlined, 'Storage'),
                  _toggleLabel(iconLabels, Icons.memory_outlined, 'CPU'),
                  _toggleLabel(iconLabels, Icons.bolt_outlined, 'Power'),
                  _toggleLabel(iconLabels, Icons.shield_outlined, 'Security'),
                  _toggleLabel(iconLabels, Icons.people_outline, 'Users'),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final c in cards)
                    SizedBox(
                      width: compactPanel ? 224 : 252,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(compactPanel ? 10 : 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(c.icon),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(c.title, style: TextStyle(fontWeight: FontWeight.w700))),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(c.value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              Text(c.note),
                              SizedBox(height: 8),
                              OutlinedButton(onPressed: () {}, child: Text('Inspect')),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideBoard(ThemeData theme, int interactions, int tick, List<String> timeline) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(theme, 'Guide + Timeline', 'How to use ToggleButtonsTheme and what to validate in real apps.', 'guide'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.tertiaryContainer.withAlpha(110),
            border: Border.all(color: theme.colorScheme.tertiary.withAlpha(120)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usage Guide', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final line in _guideLines) _bulletLine(theme, line),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(124),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (var i = 0; i < _faqQuestions.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_faqQuestions[i], style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text(_faqAnswers[i]),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.primaryContainer.withAlpha(105),
            border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interaction Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              Text('Total interactions: $interactions  |  Tick: $tick'),
              SizedBox(height: 8),
              if (timeline.isEmpty)
                Text('No events yet. Use boards and controls to generate timeline entries.')
              else
                for (final item in timeline)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(item, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                  ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _scopeCard(
  ThemeData theme, {
  required String title,
  required String subtitle,
  required Widget child,
}) {
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

Widget _sectionHeader(ThemeData theme, String title, String subtitle, String chip) {
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

Widget _legend(ThemeData theme, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: theme.colorScheme.secondaryContainer.withAlpha(120),
      border: Border.all(color: theme.colorScheme.secondary.withAlpha(120)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Legend', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        for (final line in lines) _bulletLine(theme, line),
      ],
    ),
  );
}

Widget _diagnosticCard(ThemeData theme, {required String title, required List<String> lines}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.primaryContainer.withAlpha(102),
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

Widget _toggleLabel(bool iconLabels, IconData icon, String text) {
  if (!iconLabels) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(text),
    );
  }
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

Widget _bulletLine(ThemeData theme, String text) {
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

String _formatColor(Color? color) {
  if (color == null) {
    return '-';
  }
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

class _BannerGlyphPainter extends CustomPainter {
  _BannerGlyphPainter({required this.base, required this.accent, required this.seed});

  final Color base;
  final Color accent;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed.toInt() + 91);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final width = size.width * (0.30 + random.nextDouble() * 0.60);
      final y = 8 + i * 7.8;
      paint.color = Color.lerp(base, accent, i / 5)?.withAlpha(220) ?? base;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, width, 5), Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BannerGlyphPainter oldDelegate) {
    return oldDelegate.base != base || oldDelegate.accent != accent || oldDelegate.seed != seed;
  }
}
