import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ThemeRecipe {
  const _ThemeRecipe({
    required this.id,
    required this.title,
    required this.summary,
    required this.seed,
    required this.brightness,
    required this.data,
  });

  final String id;
  final String title;
  final String summary;
  final Color seed;
  final Brightness brightness;
  final ToggleButtonsThemeData data;
}

class _Scenario {
  const _Scenario(this.id, this.title, this.description);

  final String id;
  final String title;
  final String description;
}

class _Faq {
  const _Faq(this.q, this.a);

  final String q;
  final String a;
}

const List<_ThemeRecipe> _recipes = [
  _ThemeRecipe(
    id: 'calm-grid',
    title: 'Calm Grid',
    summary: 'Balanced shape and subtle fill for utility panels.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
    data: ToggleButtonsThemeData(
      color: Color(0xFF115E59),
      selectedColor: Color(0xFFFFFFFF),
      disabledColor: Color(0xFF9CA3AF),
      fillColor: Color(0xFF0F766E),
      focusColor: Color(0x330F766E),
      hoverColor: Color(0x220F766E),
      highlightColor: Color(0x220F766E),
      splashColor: Color(0x330F766E),
      borderColor: Color(0xFF2DD4BF),
      selectedBorderColor: Color(0xFF0F766E),
      disabledBorderColor: Color(0xFFCBD5E1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderWidth: 1.6,
      textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
      constraints: BoxConstraints(minHeight: 40, minWidth: 68),
    ),
  ),
  _ThemeRecipe(
    id: 'night-console',
    title: 'Night Console',
    summary: 'Dark command rail style with strong selected contrast.',
    seed: Color(0xFF1E293B),
    brightness: Brightness.dark,
    data: ToggleButtonsThemeData(
      color: Color(0xFFCBD5E1),
      selectedColor: Color(0xFF0F172A),
      disabledColor: Color(0xFF64748B),
      fillColor: Color(0xFF93C5FD),
      focusColor: Color(0x3393C5FD),
      hoverColor: Color(0x2293C5FD),
      highlightColor: Color(0x2293C5FD),
      splashColor: Color(0x3393C5FD),
      borderColor: Color(0xFF334155),
      selectedBorderColor: Color(0xFF93C5FD),
      disabledBorderColor: Color(0xFF1E293B),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderWidth: 1.4,
      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      constraints: BoxConstraints(minHeight: 38, minWidth: 62),
    ),
  ),
  _ThemeRecipe(
    id: 'sunset-actions',
    title: 'Sunset Actions',
    summary: 'Warm and expressive style for marketing or onboarding control sets.',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
    data: ToggleButtonsThemeData(
      color: Color(0xFF9A3412),
      selectedColor: Color(0xFFFFFFFF),
      disabledColor: Color(0xFFBFA89A),
      fillColor: Color(0xFFEA580C),
      focusColor: Color(0x33EA580C),
      hoverColor: Color(0x22EA580C),
      highlightColor: Color(0x22EA580C),
      splashColor: Color(0x33EA580C),
      borderColor: Color(0xFFF97316),
      selectedBorderColor: Color(0xFFEA580C),
      disabledBorderColor: Color(0xFFFED7AA),
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderWidth: 1.8,
      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      constraints: BoxConstraints(minHeight: 44, minWidth: 74),
    ),
  ),
  _ThemeRecipe(
    id: 'violet-lab',
    title: 'Violet Lab',
    summary: 'Creative rounded controls with playful but clear state transitions.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
    data: ToggleButtonsThemeData(
      color: Color(0xFFE9D5FF),
      selectedColor: Color(0xFF312E81),
      disabledColor: Color(0xFF7C6F96),
      fillColor: Color(0xFFC4B5FD),
      focusColor: Color(0x33C4B5FD),
      hoverColor: Color(0x22C4B5FD),
      highlightColor: Color(0x22C4B5FD),
      splashColor: Color(0x33C4B5FD),
      borderColor: Color(0xFF8B5CF6),
      selectedBorderColor: Color(0xFFC4B5FD),
      disabledBorderColor: Color(0xFF4C1D95),
      borderRadius: BorderRadius.all(Radius.circular(18)),
      borderWidth: 1.7,
      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.2),
      constraints: BoxConstraints(minHeight: 42, minWidth: 68),
    ),
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario('toolbar', 'Editor Toolbar', 'Formatting controls for content editing surfaces.'),
  _Scenario('filters', 'Filter Cluster', 'Faceted filter controls with selected and disabled states.'),
  _Scenario('layout', 'Layout Switcher', 'View-mode toggles embedded in dashboard headers.'),
  _Scenario('settings', 'Settings Panel', 'Grouped preferences where spacing and readability matter.'),
];

const List<_Faq> _faqs = [
  _Faq('What is ToggleButtonsThemeData for?', 'It defines the default visual behavior of ToggleButtons across a subtree or theme.'),
  _Faq('When should I theme instead of styling per widget?', 'Use theme data when multiple toggle groups share style language and state behavior.'),
  _Faq('Which properties matter most first?', 'Start with fillColor, selectedColor, borderColor, borderRadius, and constraints.'),
  _Faq('How do I test state quality?', 'Preview selected, unselected, disabled, and mixed groups under realistic interaction density.'),
];

const List<String> _guideBullets = [
  'ToggleButtonsThemeData centralizes ToggleButtons style and state behavior.',
  'A robust demo should inspect colors, borders, radius, text style, and constraints together.',
  'Selected and disabled states must stay legible in both light and dark surfaces.',
  'Constraints directly influence accessibility and layout compactness.',
  'Theme-level styling reduces duplication and keeps control sets consistent.',
  'Use diagnostics views to inspect resulting values while interacting with toggle groups.',
  'Validate border and fill contrast under hover, focus, and splash interactions.',
  'Prefer scenario-based previews over isolated toy widgets to avoid regressions.',
];

dynamic build(BuildContext context) {
  var recipeIndex = 0;
  var scenarioIndex = 0;
  var boardIndex = 0;
  var denseMode = false;
  var highContrast = false;
  var showDiagnostics = true;
  var disableAlternate = false;
  var iconMode = true;
  var emphasizeType = false;
  var cardScale = 1.0;
  var widthScale = 1.0;
  var radiusBoost = 0.0;
  var interactionCount = 0;
  var tick = 0;

  var toolbarSelected = <bool>[true, false, false, false];
  var filterSelected = <bool>[true, true, false, true, false, false];
  var layoutSelected = <bool>[false, true, false];
  var settingsSelected = <bool>[true, false, true, false];

  final log = <String>[];

  void addLog(String msg) {
    final n = DateTime.now();
    final stamp =
        '[${n.hour.toString().padLeft(2, '0')}:${n.minute.toString().padLeft(2, '0')}:${n.second.toString().padLeft(2, '0')}]';
    log.insert(0, '$stamp $msg');
    if (log.length > 24) {
      log.removeRange(24, log.length);
    }
  }

  debugPrint('ToggleButtonsThemeData deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final recipe = _recipes[recipeIndex];
      final scenario = _scenarios[scenarioIndex];

      final scheme = ColorScheme.fromSeed(
        seedColor: recipe.seed,
        brightness: highContrast
            ? (recipe.brightness == Brightness.light ? Brightness.light : Brightness.dark)
            : recipe.brightness,
      );

      final baseTheme = ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        visualDensity: denseMode ? VisualDensity.compact : VisualDensity.standard,
      );

      final themedData = _effectiveToggleData(
        recipe.data,
        widthScale: widthScale,
        radiusBoost: radiusBoost,
      );

      final themed = baseTheme.copyWith(
        toggleButtonsTheme: themedData,
        textTheme: emphasizeType
            ? baseTheme.textTheme.copyWith(
                titleLarge: baseTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              )
            : baseTheme.textTheme,
      );

      return Theme(
        data: themed,
        child: Container(
          color: themed.colorScheme.surface,
          child: Column(
            children: [
              _topHeader(themed, recipe, scenario, interactionCount, tick),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controls(
                      theme: themed,
                      recipeIndex: recipeIndex,
                      scenarioIndex: scenarioIndex,
                      boardIndex: boardIndex,
                      denseMode: denseMode,
                      highContrast: highContrast,
                      showDiagnostics: showDiagnostics,
                      disableAlternate: disableAlternate,
                      iconMode: iconMode,
                      emphasizeType: emphasizeType,
                      cardScale: cardScale,
                      widthScale: widthScale,
                      radiusBoost: radiusBoost,
                      onRecipe: (v) {
                        setState(() {
                          recipeIndex = v;
                          tick += 1;
                          addLog('Recipe changed to ${_recipes[v].title}.');
                        });
                      },
                      onScenario: (v) {
                        setState(() {
                          scenarioIndex = v;
                          tick += 1;
                          addLog('Scenario changed to ${_scenarios[v].title}.');
                        });
                      },
                      onBoard: (v) {
                        setState(() {
                          boardIndex = v;
                          tick += 1;
                          addLog('Board changed to ${_boardName(v)}.');
                        });
                      },
                      onDense: (v) {
                        setState(() {
                          denseMode = v;
                          tick += 1;
                          addLog('Dense mode ${v ? 'on' : 'off'}.');
                        });
                      },
                      onContrast: (v) {
                        setState(() {
                          highContrast = v;
                          tick += 1;
                          addLog('Contrast mode ${v ? 'on' : 'off'}.');
                        });
                      },
                      onDiagnostics: (v) {
                        setState(() {
                          showDiagnostics = v;
                          tick += 1;
                          addLog('Diagnostics ${v ? 'visible' : 'hidden'}.');
                        });
                      },
                      onDisableAlternate: (v) {
                        setState(() {
                          disableAlternate = v;
                          tick += 1;
                          addLog('Alternate disable ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onIconMode: (v) {
                        setState(() {
                          iconMode = v;
                          tick += 1;
                          addLog('Icon mode ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onEmphasis: (v) {
                        setState(() {
                          emphasizeType = v;
                          tick += 1;
                          addLog('Typography emphasis ${v ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onCardScale: (v) {
                        setState(() {
                          cardScale = v;
                          tick += 1;
                        });
                      },
                      onWidthScale: (v) {
                        setState(() {
                          widthScale = v;
                          tick += 1;
                        });
                      },
                      onRadiusBoost: (v) {
                        setState(() {
                          radiusBoost = v;
                          tick += 1;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 12, 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themed.colorScheme.surface,
                              themed.colorScheme.surfaceContainerHighest.withAlpha(160),
                              themed.colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: themed.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: AnimatedScale(
                          scale: cardScale,
                          duration: Duration(milliseconds: 220),
                          alignment: Alignment.topCenter,
                          child: _board(
                            boardIndex: boardIndex,
                            theme: themed,
                            data: themedData,
                            scenario: scenario,
                            showDiagnostics: showDiagnostics,
                            disableAlternate: disableAlternate,
                            iconMode: iconMode,
                            toolbarSelected: toolbarSelected,
                            filterSelected: filterSelected,
                            layoutSelected: layoutSelected,
                            settingsSelected: settingsSelected,
                            onToolbarTap: (i) {
                              setState(() {
                                toolbarSelected = _singleSelect(toolbarSelected, i);
                                interactionCount += 1;
                                tick += 1;
                                addLog('Toolbar toggled index $i.');
                              });
                            },
                            onFilterTap: (i) {
                              setState(() {
                                filterSelected = _toggleAt(filterSelected, i);
                                interactionCount += 1;
                                tick += 1;
                                addLog('Filter toggled index $i.');
                              });
                            },
                            onLayoutTap: (i) {
                              setState(() {
                                layoutSelected = _singleSelect(layoutSelected, i);
                                interactionCount += 1;
                                tick += 1;
                                addLog('Layout toggled index $i.');
                              });
                            },
                            onSettingsTap: (i) {
                              setState(() {
                                settingsSelected = _toggleAt(settingsSelected, i);
                                interactionCount += 1;
                                tick += 1;
                                addLog('Settings toggled index $i.');
                              });
                            },
                            interactionCount: interactionCount,
                            tick: tick,
                            log: log,
                          ),
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

ToggleButtonsThemeData _effectiveToggleData(
  ToggleButtonsThemeData base, {
  required double widthScale,
  required double radiusBoost,
}) {
  final constraints = base.constraints;
  final scaledConstraints = constraints == null
      ? null
      : BoxConstraints(
          minHeight: constraints.minHeight,
          minWidth: constraints.minWidth * widthScale,
          maxHeight: constraints.maxHeight,
          maxWidth: constraints.maxWidth,
        );

  final radius = base.borderRadius?.resolve(TextDirection.ltr);
  final newRadius = radius == null
      ? BorderRadius.circular(10 + radiusBoost)
      : BorderRadius.circular((radius.topLeft.x + radiusBoost).clamp(2, 36).toDouble());

  return base.copyWith(
    constraints: scaledConstraints,
    borderRadius: newRadius,
  );
}

List<bool> _singleSelect(List<bool> list, int index) {
  final next = List<bool>.filled(list.length, false);
  next[index] = true;
  return next;
}

List<bool> _toggleAt(List<bool> list, int index) {
  final next = List<bool>.from(list);
  next[index] = !next[index];
  return next;
}

String _boardName(int i) {
  const names = ['Recipe Gallery', 'Border Matrix', 'State Lab', 'Integrated Scenes', 'Guide + Timeline'];
  return names[i.clamp(0, names.length - 1)];
}

Widget _topHeader(ThemeData theme, _ThemeRecipe recipe, _Scenario scenario, int interactions, int tick) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.primaryContainer.withAlpha(180),
          theme.colorScheme.secondaryContainer.withAlpha(150),
          theme.colorScheme.tertiaryContainer.withAlpha(130),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
          ),
          child: CustomPaint(
            painter: _GlyphPainter(
              a: recipe.data.fillColor ?? theme.colorScheme.primary,
              b: recipe.data.selectedBorderColor ?? theme.colorScheme.secondary,
              seed: tick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ToggleButtonsThemeData Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'recipe: ${recipe.title}  scenario: ${scenario.title}  interactions: $interactions',
                style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(recipe.summary, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(170))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _controls({
  required ThemeData theme,
  required int recipeIndex,
  required int scenarioIndex,
  required int boardIndex,
  required bool denseMode,
  required bool highContrast,
  required bool showDiagnostics,
  required bool disableAlternate,
  required bool iconMode,
  required bool emphasizeType,
  required double cardScale,
  required double widthScale,
  required double radiusBoost,
  required ValueChanged<int> onRecipe,
  required ValueChanged<int> onScenario,
  required ValueChanged<int> onBoard,
  required ValueChanged<bool> onDense,
  required ValueChanged<bool> onContrast,
  required ValueChanged<bool> onDiagnostics,
  required ValueChanged<bool> onDisableAlternate,
  required ValueChanged<bool> onIconMode,
  required ValueChanged<bool> onEmphasis,
  required ValueChanged<double> onCardScale,
  required ValueChanged<double> onWidthScale,
  required ValueChanged<double> onRadiusBoost,
}) {
  return Container(
    width: 374,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.surfaceContainerHighest.withAlpha(122),
          theme.colorScheme.surfaceContainer.withAlpha(98),
          theme.colorScheme.surfaceContainerLow.withAlpha(84),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Theme Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Tune ToggleButtonsThemeData tokens and inspect behavior in context.'),
          SizedBox(height: 10),
          _dropdown('Recipe', recipeIndex, _recipes.map((e) => e.title).toList(), onRecipe),
          _dropdown('Scenario', scenarioIndex, _scenarios.map((e) => e.title).toList(), onScenario),
          _dropdown('Board', boardIndex, List.generate(5, _boardName), onBoard),
          _switchCard('Dense mode', 'Compact visual density for button groups', denseMode, onDense),
          _switchCard('High contrast', 'High contrast color scheme generation', highContrast, onContrast),
          _switchCard('Show diagnostics', 'Reveal resolved theme token values', showDiagnostics, onDiagnostics),
          _switchCard('Disable alternates', 'Disable every second toggle in groups', disableAlternate, onDisableAlternate),
          _switchCard('Icon mode', 'Display icons in toggle labels', iconMode, onIconMode),
          _switchCard('Typography emphasis', 'Strengthen title and label hierarchy', emphasizeType, onEmphasis),
          _slider('Card scale', cardScale, 0.9, 1.12, onCardScale),
          _slider('Constraint width scale', widthScale, 0.8, 1.5, onWidthScale),
          _slider('Radius boost', radiusBoost, -4, 12, onRadiusBoost),
        ],
      ),
    ),
  );
}

Widget _dropdown(String label, int value, List<String> options, ValueChanged<int> onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(130),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        DropdownButtonFormField<int>(
          initialValue: value,
          isDense: true,
          decoration: InputDecoration(border: OutlineInputBorder()),
          items: [for (var i = 0; i < options.length; i++) DropdownMenuItem(value: i, child: Text(options[i]))],
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
      border: Border.all(color: Colors.black.withAlpha(18)),
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

Widget _slider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
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
  required ToggleButtonsThemeData data,
  required _Scenario scenario,
  required bool showDiagnostics,
  required bool disableAlternate,
  required bool iconMode,
  required List<bool> toolbarSelected,
  required List<bool> filterSelected,
  required List<bool> layoutSelected,
  required List<bool> settingsSelected,
  required ValueChanged<int> onToolbarTap,
  required ValueChanged<int> onFilterTap,
  required ValueChanged<int> onLayoutTap,
  required ValueChanged<int> onSettingsTap,
  required int interactionCount,
  required int tick,
  required List<String> log,
}) {
  switch (boardIndex) {
    case 0:
      return _galleryBoard(theme, data, iconMode, disableAlternate, onToolbarTap, onFilterTap, toolbarSelected, filterSelected, showDiagnostics);
    case 1:
      return _borderMatrixBoard(theme, data);
    case 2:
      return _stateLabBoard(theme, data, iconMode, disableAlternate, layoutSelected, settingsSelected, onLayoutTap, onSettingsTap, showDiagnostics);
    case 3:
      return _integratedBoard(theme, scenario, iconMode, disableAlternate, toolbarSelected, filterSelected, onToolbarTap, onFilterTap);
    default:
      return _guideBoard(theme, interactionCount, tick, log);
  }
}

Widget _galleryBoard(
  ThemeData theme,
  ToggleButtonsThemeData data,
  bool iconMode,
  bool disableAlternate,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFilterTap,
  List<bool> toolbarSelected,
  List<bool> filterSelected,
  bool showDiagnostics,
) {
  final toolbar = ['Bold', 'Italic', 'Link', 'Code'];
  final filters = ['Open', 'Assigned', 'Blocked', 'Done', 'Mine', 'Urgent'];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Recipe Gallery', 'Core toggle groups under active ToggleButtonsThemeData.', 'gallery'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Editor Toolbar', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: toolbarSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onToolbarTap(i);
                },
                children: [
                  for (var i = 0; i < toolbar.length; i++)
                    _buttonChild(iconMode, _toolbarIcon(i), toolbar[i]),
                ],
              ),
              SizedBox(height: 14),
              Text('Filter Cluster', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: filterSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onFilterTap(i);
                },
                children: [
                  for (var i = 0; i < filters.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: _buttonChild(iconMode, _filterIcon(i), filters[i]),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 10),
          _diagnostics(
            theme,
            'ThemeData diagnostics',
            [
              'color: ${_color(data.color)}',
              'selectedColor: ${_color(data.selectedColor)}',
              'fillColor: ${_color(data.fillColor)}',
              'borderColor: ${_color(data.borderColor)}',
              'selectedBorderColor: ${_color(data.selectedBorderColor)}',
              'borderWidth: ${data.borderWidth?.toStringAsFixed(2) ?? '-'}',
              'radius: ${data.borderRadius?.resolve(TextDirection.ltr).topLeft.x.toStringAsFixed(1) ?? '-'}',
              'constraints.min: ${data.constraints?.minWidth.toStringAsFixed(1) ?? '-'} x ${data.constraints?.minHeight.toStringAsFixed(1) ?? '-'}',
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _buttonChild(bool iconMode, IconData icon, String text) {
  if (!iconMode) {
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

IconData _toolbarIcon(int i) {
  const icons = [Icons.format_bold, Icons.format_italic, Icons.link, Icons.code];
  return icons[i % icons.length];
}

IconData _filterIcon(int i) {
  const icons = [Icons.folder_open, Icons.assignment_ind, Icons.warning_amber, Icons.check_circle, Icons.person, Icons.priority_high];
  return icons[i % icons.length];
}

Widget _borderMatrixBoard(ThemeData theme, ToggleButtonsThemeData data) {
  final widths = [0.8, 1.2, 1.8, 2.4];
  final radii = [4.0, 8.0, 14.0, 20.0];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Border Matrix', 'Visual matrix for border width/radius behavior.', 'matrix'),
        SizedBox(height: 10),
        for (var r = 0; r < radii.length; r++)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withAlpha(190),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(128)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Radius ${radii[r].toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var w = 0; w < widths.length; w++)
                      _matrixGroup(
                        theme,
                        data.copyWith(
                          borderWidth: widths[w],
                          borderRadius: BorderRadius.circular(radii[r]),
                        ),
                        'w ${widths[w].toStringAsFixed(1)}',
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

Widget _matrixGroup(ThemeData theme, ToggleButtonsThemeData data, String label) {
  final local = theme.copyWith(toggleButtonsTheme: data);
  return Theme(
    data: local,
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          ToggleButtons(
            isSelected: [true, false, true],
            onPressed: (_) {},
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('A')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('B')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('C')),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _stateLabBoard(
  ThemeData theme,
  ToggleButtonsThemeData data,
  bool iconMode,
  bool disableAlternate,
  List<bool> layoutSelected,
  List<bool> settingsSelected,
  ValueChanged<int> onLayoutTap,
  ValueChanged<int> onSettingsTap,
  bool showDiagnostics,
) {
  final layout = ['Grid', 'List', 'Split'];
  final settings = ['Hints', 'Autosave', 'Wrap', 'Preview'];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'State Lab', 'Selected, unselected, and disabled behavior checks.', 'state'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Layout Switcher', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: layoutSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onLayoutTap(i);
                },
                children: [
                  for (var i = 0; i < layout.length; i++) _buttonChild(iconMode, _layoutIcon(i), layout[i]),
                ],
              ),
              SizedBox(height: 14),
              Text('Settings Cluster', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: settingsSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onSettingsTap(i);
                },
                children: [
                  for (var i = 0; i < settings.length; i++) _buttonChild(iconMode, _settingsIcon(i), settings[i]),
                ],
              ),
              SizedBox(height: 14),
              Text('Disabled preview', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: [false, true, false],
                onPressed: null,
                children: [
                  _buttonChild(iconMode, Icons.visibility_outlined, 'One'),
                  _buttonChild(iconMode, Icons.visibility_off_outlined, 'Two'),
                  _buttonChild(iconMode, Icons.remove_red_eye_outlined, 'Three'),
                ],
              ),
            ],
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 10),
          _diagnostics(
            theme,
            'State diagnostics',
            [
              'selected count(layout): ${layoutSelected.where((e) => e).length}',
              'selected count(settings): ${settingsSelected.where((e) => e).length}',
              'disableAlternate: $disableAlternate',
              'textStyle: ${data.textStyle?.fontWeight} ${data.textStyle?.fontSize?.toStringAsFixed(1) ?? '-'}',
            ],
          ),
        ],
      ],
    ),
  );
}

IconData _layoutIcon(int i) {
  const icons = [Icons.grid_view, Icons.view_list, Icons.splitscreen];
  return icons[i % icons.length];
}

IconData _settingsIcon(int i) {
  const icons = [Icons.tips_and_updates_outlined, Icons.save_outlined, Icons.wrap_text, Icons.preview_outlined];
  return icons[i % icons.length];
}

Widget _integratedBoard(
  ThemeData theme,
  _Scenario scenario,
  bool iconMode,
  bool disableAlternate,
  List<bool> toolbarSelected,
  List<bool> filterSelected,
  ValueChanged<int> onToolbarTap,
  ValueChanged<int> onFilterTap,
) {
  final metrics = [
    ('Requests', '12.4k', Icons.http),
    ('Latency', '84ms', Icons.speed),
    ('Errors', '0.6%', Icons.error_outline),
    ('Saturation', '71%', Icons.thermostat),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Integrated Scenes', scenario.description, scenario.title),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'Search metrics'))),
                  SizedBox(width: 10),
                  FilledButton.icon(onPressed: () {}, icon: Icon(Icons.refresh), label: Text('Refresh')),
                ],
              ),
              SizedBox(height: 12),
              Text('Toolbar', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: toolbarSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onToolbarTap(i);
                },
                children: [
                  _buttonChild(iconMode, Icons.filter_alt_outlined, 'Filter'),
                  _buttonChild(iconMode, Icons.sort_outlined, 'Sort'),
                  _buttonChild(iconMode, Icons.pin_outlined, 'Pin'),
                  _buttonChild(iconMode, Icons.download_outlined, 'Export'),
                ],
              ),
              SizedBox(height: 12),
              Text('Facets', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ToggleButtons(
                isSelected: filterSelected,
                onPressed: (i) {
                  if (disableAlternate && i.isOdd) return;
                  onFilterTap(i);
                },
                children: [
                  _buttonChild(iconMode, Icons.cloud_outlined, 'Cloud'),
                  _buttonChild(iconMode, Icons.storage_outlined, 'Storage'),
                  _buttonChild(iconMode, Icons.memory_outlined, 'CPU'),
                  _buttonChild(iconMode, Icons.bolt_outlined, 'Power'),
                  _buttonChild(iconMode, Icons.shield_outlined, 'Security'),
                  _buttonChild(iconMode, Icons.people_outline, 'Users'),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final m in metrics)
                    SizedBox(
                      width: 245,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(m.$3),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(m.$1, style: TextStyle(fontWeight: FontWeight.w700))),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(m.$2, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
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

Widget _guideBoard(ThemeData theme, int interactionCount, int tick, List<String> log) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(theme, 'Guide + Timeline', 'Practical guidance and interaction history.', 'guide'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer.withAlpha(108),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.tertiary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ToggleButtonsThemeData guidance', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final g in _guideBullets) _bullet(g),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final f in _faqs)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.q, style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text(f.a),
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
            color: theme.colorScheme.primaryContainer.withAlpha(102),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              Text('Interactions: $interactionCount  |  Ticks: $tick'),
              SizedBox(height: 8),
              if (log.isEmpty)
                Text('No events yet. Interact with controls and groups to populate this log.')
              else
                for (final line in log)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(line, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                  ),
            ],
          ),
        ),
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
            Text(title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
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
        child: Text(chip, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      ),
    ],
  );
}

Widget _diagnostics(ThemeData theme, String title, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer.withAlpha(102),
      borderRadius: BorderRadius.circular(12),
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

String _color(Color? c) {
  if (c == null) return '-';
  return '#${c.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 7, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: Color(0xFF0F766E), shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class _GlyphPainter extends CustomPainter {
  _GlyphPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed.toInt() + 57);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.35 + rnd.nextDouble() * 0.55);
      final y = 8 + i * 8.3;
      p.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.3), Radius.circular(4)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}
