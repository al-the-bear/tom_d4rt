import 'dart:math' as math;

import 'package:flutter/material.dart';

final List<_ThemeRecipe> _recipes = [
  _ThemeRecipe(
    id: 'calm-minimal',
    title: 'Calm Minimal',
    summary: 'A low-noise text button style for content-heavy surfaces.',
    usage: 'Use when text buttons should stay subtle but readable in dense UIs.',
    accent: Color(0xFF1F6F78),
    buildStyle: _buildCalmMinimalStyle,
  ),
  _ThemeRecipe(
    id: 'studio-contrast',
    title: 'Studio Contrast',
    summary: 'High-contrast style for command panels and utility overlays.',
    usage: 'Use in tools where commands must remain legible under visual noise.',
    accent: Color(0xFF0B4F8A),
    buildStyle: _buildStudioContrastStyle,
  ),
  _ThemeRecipe(
    id: 'sunset-callout',
    title: 'Sunset Callout',
    summary: 'Warm interactive emphasis for onboarding and educational prompts.',
    usage: 'Use where text buttons should invite action without heavy elevation.',
    accent: Color(0xFFB45309),
    buildStyle: _buildSunsetCalloutStyle,
  ),
  _ThemeRecipe(
    id: 'forest-link',
    title: 'Forest Link',
    summary: 'Link-like visual language that keeps textual hierarchy clear.',
    usage: 'Use for navigation-style actions inside cards and dashboards.',
    accent: Color(0xFF166534),
    buildStyle: _buildForestLinkStyle,
  ),
  _ThemeRecipe(
    id: 'night-command',
    title: 'Night Command',
    summary: 'Dark surface command style with intentional focus ring behavior.',
    usage: 'Use inside dark panes, editors, and compact command rails.',
    accent: Color(0xFF9AA4FF),
    buildStyle: _buildNightCommandStyle,
  ),
  _ThemeRecipe(
    id: 'playful-lab',
    title: 'Playful Lab',
    summary: 'Experimental rounded style for demos and exploratory workflows.',
    usage: 'Use for low-risk experimentation and creative tooling surfaces.',
    accent: Color(0xFFA21CAF),
    buildStyle: _buildPlayfulLabStyle,
  ),
];

final List<_ButtonScenario> _scenarios = [
  _ButtonScenario(
    id: 'quick-actions',
    title: 'Quick Actions',
    description: 'A command strip with short labels and icon affordances.',
    labels: ['Refresh', 'Share', 'Inspect', 'Bookmark'],
  ),
  _ButtonScenario(
    id: 'long-content',
    title: 'Long Labels',
    description: 'Stress test wrapping and spacing with verbose copy.',
    labels: [
      'Download Detailed Analytics Report',
      'Open Project Retrospective Timeline',
      'Schedule Follow-up Working Session',
      'Review Accessibility Checklist Notes',
    ],
  ),
  _ButtonScenario(
    id: 'mixed-tone',
    title: 'Mixed Tone',
    description: 'Primary, neutral, and destructive phrasing in one group.',
    labels: ['Approve', 'Remind Later', 'Archive', 'Delete'],
  ),
  _ButtonScenario(
    id: 'micro-actions',
    title: 'Micro Actions',
    description: 'Tiny utility controls inside compact cards.',
    labels: ['Edit', 'Pin', 'Mute', 'Close'],
  ),
];

final List<_StateSample> _stateSamples = [
  _StateSample('Enabled', <WidgetState>{}),
  _StateSample('Hovered', <WidgetState>{WidgetState.hovered}),
  _StateSample('Focused', <WidgetState>{WidgetState.focused}),
  _StateSample('Pressed', <WidgetState>{WidgetState.pressed}),
  _StateSample('Disabled', <WidgetState>{WidgetState.disabled}),
  _StateSample('Selected', <WidgetState>{WidgetState.selected}),
];

final List<String> _guidanceBullets = [
  'TextButtonThemeData centralizes text-button behavior so product language stays consistent across routes.',
  'Use a themed baseline for typography, spacing, and state overlays; then override per-button only for intentional exceptions.',
  'Prefer deterministic state colors for pressed, hover, and focus states to keep accessibility and QA validation predictable.',
  'When combining dense layouts and long labels, validate tap target constraints so compact visuals do not reduce usability.',
  'Nested TextButtonTheme widgets are a good pattern for local accents inside one feature area without changing global theme.',
  'Treat disabled styling as a first-class state: the visual tone should communicate non-interaction without disappearing.',
  'Use diagnostics panels during development to inspect resolved style values by state before shipping design tokens.',
];

final List<_QuestionAnswer> _faq = [
  _QuestionAnswer(
    question: 'When should I use TextButtonThemeData instead of TextButton.styleFrom on each button?',
    answer:
        'Use TextButtonThemeData when many buttons share a design language. It reduces duplication, improves consistency, and makes updates faster.',
  ),
  _QuestionAnswer(
    question: 'How do local feature-specific button styles coexist with app-wide themes?',
    answer:
        'Apply app-level TextButtonThemeData in ThemeData, then wrap a feature section with TextButtonTheme to locally override selected style tokens.',
  ),
  _QuestionAnswer(
    question: 'What makes a good pressed/hover overlay strategy?',
    answer:
        'Keep overlay opacity modest and predictable. Pressed should feel clearly stronger than hover while preserving text legibility.',
  ),
  _QuestionAnswer(
    question: 'Can TextButtonThemeData support both compact and roomy densities?',
    answer:
        'Yes. Use style variants with different padding and minimumSize, and preview both in the same scene as this demo does.',
  ),
];

const List<Color> _deckColors = [
  Color(0xFFEFF6FF),
  Color(0xFFECFEFF),
  Color(0xFFFAF5FF),
  Color(0xFFFFF7ED),
];

const List<Color> _panelColors = [
  Color(0xFFF8FAFC),
  Color(0xFFEFF6FF),
  Color(0xFFECFDF5),
  Color(0xFFFFF7ED),
  Color(0xFFFAF5FF),
  Color(0xFFFDF2F8),
];

dynamic build(BuildContext context) {
  var selectedRecipe = 0;
  var selectedScenario = 0;
  var denseMode = false;
  var useIcons = true;
  var highContrast = false;
  var disableAlternate = false;
  var localOverrideActive = true;
  var showStateDiagnostics = true;
  var enableDarkPreview = false;
  var fontScale = 1.0;
  var radiusScale = 1.0;
  var horizontalPadding = 20.0;
  var verticalPadding = 12.0;
  var pressedElevation = 0.0;
  var timelineTick = 0;
  var interactionCount = 0;
  final eventLog = <String>[];

  void logEvent(String message) {
    final stamp = DateTime.now();
    final line =
        '[${stamp.hour.toString().padLeft(2, '0')}:${stamp.minute.toString().padLeft(2, '0')}:${stamp.second.toString().padLeft(2, '0')}] $message';
    eventLog.insert(0, line);
    if (eventLog.length > 18) {
      eventLog.removeRange(18, eventLog.length);
    }
  }

  debugPrint('TextButtonThemeData deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final baseRecipe = _recipes[selectedRecipe];
      final scenario = _scenarios[selectedScenario];
      final colorScheme = _deriveColorScheme(baseRecipe.accent, highContrast);
      final style = baseRecipe.buildStyle(
        colorScheme,
        _StyleTuning(
          denseMode: denseMode,
          useIcons: useIcons,
          highContrast: highContrast,
          fontScale: fontScale,
          radiusScale: radiusScale,
          horizontalPadding: horizontalPadding,
          verticalPadding: verticalPadding,
          pressedElevation: pressedElevation,
        ),
      );
      final appTheme = Theme.of(context);
      final themeData = appTheme.copyWith(
        colorScheme: colorScheme,
        textButtonTheme: TextButtonThemeData(style: style),
      );
      final boardGradient = LinearGradient(
        colors: [
          colorScheme.surface,
          colorScheme.surfaceContainerHighest,
          colorScheme.surface,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      final headerStyle = appTheme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      );

      Widget body = Container(
        color: colorScheme.surface,
        child: Column(
          children: [
            _buildBanner(
              colorScheme: colorScheme,
              recipe: baseRecipe,
              scenario: scenario,
              interactionCount: interactionCount,
              timelineTick: timelineTick,
              headerStyle: headerStyle,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 360,
                    child: _buildControlDeck(
                      colorScheme: colorScheme,
                      selectedRecipe: selectedRecipe,
                      selectedScenario: selectedScenario,
                      denseMode: denseMode,
                      useIcons: useIcons,
                      highContrast: highContrast,
                      disableAlternate: disableAlternate,
                      localOverrideActive: localOverrideActive,
                      showStateDiagnostics: showStateDiagnostics,
                      enableDarkPreview: enableDarkPreview,
                      fontScale: fontScale,
                      radiusScale: radiusScale,
                      horizontalPadding: horizontalPadding,
                      verticalPadding: verticalPadding,
                      pressedElevation: pressedElevation,
                      onRecipeChanged: (value) {
                        setState(() {
                          selectedRecipe = value;
                          timelineTick += 1;
                          logEvent('Switched recipe to ${_recipes[value].title}.');
                        });
                      },
                      onScenarioChanged: (value) {
                        setState(() {
                          selectedScenario = value;
                          timelineTick += 1;
                          logEvent('Scenario changed to ${_scenarios[value].title}.');
                        });
                      },
                      onDenseModeChanged: (value) {
                        setState(() {
                          denseMode = value;
                          timelineTick += 1;
                          logEvent('Dense mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onUseIconsChanged: (value) {
                        setState(() {
                          useIcons = value;
                          timelineTick += 1;
                          logEvent('Icon usage ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onHighContrastChanged: (value) {
                        setState(() {
                          highContrast = value;
                          timelineTick += 1;
                          logEvent('Contrast mode ${value ? 'high' : 'normal'}.');
                        });
                      },
                      onDisableAlternateChanged: (value) {
                        setState(() {
                          disableAlternate = value;
                          timelineTick += 1;
                          logEvent('Alternate disable behavior ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onLocalOverrideChanged: (value) {
                        setState(() {
                          localOverrideActive = value;
                          timelineTick += 1;
                          logEvent('Local nested theme ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onStateDiagnosticsChanged: (value) {
                        setState(() {
                          showStateDiagnostics = value;
                          timelineTick += 1;
                          logEvent('State diagnostics ${value ? 'shown' : 'hidden'}.');
                        });
                      },
                      onDarkPreviewChanged: (value) {
                        setState(() {
                          enableDarkPreview = value;
                          timelineTick += 1;
                          logEvent('Dark preview ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onFontScaleChanged: (value) {
                        setState(() {
                          fontScale = value;
                          timelineTick += 1;
                        });
                      },
                      onRadiusScaleChanged: (value) {
                        setState(() {
                          radiusScale = value;
                          timelineTick += 1;
                        });
                      },
                      onHorizontalPaddingChanged: (value) {
                        setState(() {
                          horizontalPadding = value;
                          timelineTick += 1;
                        });
                      },
                      onVerticalPaddingChanged: (value) {
                        setState(() {
                          verticalPadding = value;
                          timelineTick += 1;
                        });
                      },
                      onPressedElevationChanged: (value) {
                        setState(() {
                          pressedElevation = value;
                          timelineTick += 1;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 12),
                      decoration: BoxDecoration(
                        gradient: boardGradient,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colorScheme.outlineVariant.withAlpha(120)),
                      ),
                      child: DefaultTabController(
                        length: 5,
                        child: Column(
                          children: [
                            _buildBoardTabs(colorScheme),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  _buildRecipeGallery(
                                    recipe: baseRecipe,
                                    style: style,
                                    scenario: scenario,
                                    disableAlternate: disableAlternate,
                                    useIcons: useIcons,
                                    colorScheme: colorScheme,
                                    onPressed: (label) {
                                      setState(() {
                                        interactionCount += 1;
                                        timelineTick += 1;
                                        logEvent('Gallery action tapped: $label');
                                      });
                                    },
                                  ),
                                  _buildComparisonMatrix(
                                    recipe: baseRecipe,
                                    style: style,
                                    disableAlternate: disableAlternate,
                                    useIcons: useIcons,
                                    colorScheme: colorScheme,
                                    onPressed: (label) {
                                      setState(() {
                                        interactionCount += 1;
                                        timelineTick += 1;
                                        logEvent('Matrix action tapped: $label');
                                      });
                                    },
                                  ),
                                  _buildNestedThemeLab(
                                    appTheme: themeData,
                                    style: style,
                                    recipe: baseRecipe,
                                    localOverrideActive: localOverrideActive,
                                    useIcons: useIcons,
                                    disableAlternate: disableAlternate,
                                    colorScheme: colorScheme,
                                    onPressed: (label) {
                                      setState(() {
                                        interactionCount += 1;
                                        timelineTick += 1;
                                        logEvent('Nested lab action tapped: $label');
                                      });
                                    },
                                  ),
                                  _buildStateResolutionExplorer(
                                    style: style,
                                    colorScheme: colorScheme,
                                    showStateDiagnostics: showStateDiagnostics,
                                  ),
                                  _buildInstructionAndTimeline(
                                    colorScheme: colorScheme,
                                    interactionCount: interactionCount,
                                    timelineTick: timelineTick,
                                    eventLog: eventLog,
                                    recipe: baseRecipe,
                                    scenario: scenario,
                                  ),
                                ],
                              ),
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

      if (enableDarkPreview) {
        body = Theme(
          data: themeData.copyWith(
            colorScheme: colorScheme.copyWith(
              surface: Color(0xFF0A1222),
              onSurface: Color(0xFFE2E8F0),
              surfaceContainerHighest: Color(0xFF16233C),
              outlineVariant: Color(0xFF36455F),
            ),
            textTheme: appTheme.textTheme.apply(
              bodyColor: Color(0xFFE2E8F0),
              displayColor: Color(0xFFE2E8F0),
            ),
          ),
          child: body,
        );
      } else {
        body = Theme(data: themeData, child: body);
      }

      return body;
    },
  );
}

Widget _buildBanner({
  required ColorScheme colorScheme,
  required _ThemeRecipe recipe,
  required _ButtonScenario scenario,
  required int interactionCount,
  required int timelineTick,
  required TextStyle? headerStyle,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(18, 16, 18, 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          recipe.accent.withAlpha(58),
          colorScheme.primary.withAlpha(44),
          colorScheme.tertiary.withAlpha(36),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: recipe.accent.withAlpha(120)),
      boxShadow: [
        BoxShadow(
          color: recipe.accent.withAlpha(28),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(160),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: recipe.accent.withAlpha(180)),
          ),
          child: CustomPaint(
            painter: _TokenBarsPainter(
              accent: recipe.accent,
              seed: timelineTick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TextButtonThemeData Studio', style: headerStyle),
              SizedBox(height: 6),
              Text(
                'Recipe: ${recipe.title}   Scenario: ${scenario.title}   Interactions: $interactionCount',
                style: TextStyle(
                  color: colorScheme.onSurface.withAlpha(180),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Text(
                recipe.summary,
                style: TextStyle(
                  color: colorScheme.onSurface.withAlpha(170),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoardTabs(ColorScheme scheme) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 8),
    decoration: BoxDecoration(
      color: scheme.surface.withAlpha(190),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: scheme.outlineVariant.withAlpha(120)),
    ),
    child: TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      dividerColor: Colors.transparent,
      labelColor: scheme.primary,
      unselectedLabelColor: scheme.onSurface.withAlpha(150),
      indicator: BoxDecoration(
        color: scheme.primaryContainer.withAlpha(160),
        borderRadius: BorderRadius.circular(10),
      ),
      tabs: [
        Tab(text: 'Recipe Gallery'),
        Tab(text: 'Matrix'),
        Tab(text: 'Nested Themes'),
        Tab(text: 'State Resolver'),
        Tab(text: 'Guide + Timeline'),
      ],
    ),
  );
}

Widget _buildControlDeck({
  required ColorScheme colorScheme,
  required int selectedRecipe,
  required int selectedScenario,
  required bool denseMode,
  required bool useIcons,
  required bool highContrast,
  required bool disableAlternate,
  required bool localOverrideActive,
  required bool showStateDiagnostics,
  required bool enableDarkPreview,
  required double fontScale,
  required double radiusScale,
  required double horizontalPadding,
  required double verticalPadding,
  required double pressedElevation,
  required ValueChanged<int> onRecipeChanged,
  required ValueChanged<int> onScenarioChanged,
  required ValueChanged<bool> onDenseModeChanged,
  required ValueChanged<bool> onUseIconsChanged,
  required ValueChanged<bool> onHighContrastChanged,
  required ValueChanged<bool> onDisableAlternateChanged,
  required ValueChanged<bool> onLocalOverrideChanged,
  required ValueChanged<bool> onStateDiagnosticsChanged,
  required ValueChanged<bool> onDarkPreviewChanged,
  required ValueChanged<double> onFontScaleChanged,
  required ValueChanged<double> onRadiusScaleChanged,
  required ValueChanged<double> onHorizontalPaddingChanged,
  required ValueChanged<double> onVerticalPaddingChanged,
  required ValueChanged<double> onPressedElevationChanged,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _deckColors[0],
          _deckColors[1],
          _deckColors[2],
          _deckColors[3],
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: colorScheme.outlineVariant.withAlpha(130)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control Deck',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Tune TextButtonThemeData tokens and inspect behavior instantly.',
            style: TextStyle(color: colorScheme.onSurface.withAlpha(180)),
          ),
          SizedBox(height: 12),
          Text('Recipe', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          DropdownButtonFormField<int>(
            initialValue: selectedRecipe,
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: [
              for (var i = 0; i < _recipes.length; i++)
                DropdownMenuItem<int>(
                  value: i,
                  child: Text(_recipes[i].title),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                onRecipeChanged(value);
              }
            },
          ),
          SizedBox(height: 10),
          Text('Scenario', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          DropdownButtonFormField<int>(
            initialValue: selectedScenario,
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: [
              for (var i = 0; i < _scenarios.length; i++)
                DropdownMenuItem<int>(
                  value: i,
                  child: Text(_scenarios[i].title),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                onScenarioChanged(value);
              }
            },
          ),
          SizedBox(height: 12),
          _buildSwitchTile(
            title: 'Dense mode',
            subtitle: 'Use tighter button geometry',
            value: denseMode,
            onChanged: onDenseModeChanged,
          ),
          _buildSwitchTile(
            title: 'Use icons',
            subtitle: 'Show icon + label combinations',
            value: useIcons,
            onChanged: onUseIconsChanged,
          ),
          _buildSwitchTile(
            title: 'High contrast',
            subtitle: 'Boost foreground/background contrast',
            value: highContrast,
            onChanged: onHighContrastChanged,
          ),
          _buildSwitchTile(
            title: 'Disable alternate buttons',
            subtitle: 'Inspect disabled styling behavior',
            value: disableAlternate,
            onChanged: onDisableAlternateChanged,
          ),
          _buildSwitchTile(
            title: 'Enable nested local override',
            subtitle: 'Activate secondary TextButtonTheme section',
            value: localOverrideActive,
            onChanged: onLocalOverrideChanged,
          ),
          _buildSwitchTile(
            title: 'Show state diagnostics',
            subtitle: 'Display resolved properties for each state',
            value: showStateDiagnostics,
            onChanged: onStateDiagnosticsChanged,
          ),
          _buildSwitchTile(
            title: 'Dark preview',
            subtitle: 'Render everything on dark surface',
            value: enableDarkPreview,
            onChanged: onDarkPreviewChanged,
          ),
          SizedBox(height: 8),
          _buildSlider(
            label: 'Font scale',
            value: fontScale,
            min: 0.85,
            max: 1.4,
            onChanged: onFontScaleChanged,
          ),
          _buildSlider(
            label: 'Radius scale',
            value: radiusScale,
            min: 0.6,
            max: 1.8,
            onChanged: onRadiusScaleChanged,
          ),
          _buildSlider(
            label: 'Horizontal padding',
            value: horizontalPadding,
            min: 10,
            max: 36,
            onChanged: onHorizontalPaddingChanged,
          ),
          _buildSlider(
            label: 'Vertical padding',
            value: verticalPadding,
            min: 6,
            max: 22,
            onChanged: onVerticalPaddingChanged,
          ),
          _buildSlider(
            label: 'Pressed elevation',
            value: pressedElevation,
            min: 0,
            max: 6,
            onChanged: onPressedElevationChanged,
          ),
        ],
      ),
    ),
  );
}

Widget _buildSwitchTile({
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(160),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(165)),
        ),
      ],
    ),
  );
}

Widget _buildSlider({
  required String label,
  required double value,
  required double min,
  required double max,
  required ValueChanged<double> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(170),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    ),
  );
}

Widget _buildRecipeGallery({
  required _ThemeRecipe recipe,
  required ButtonStyle style,
  required _ButtonScenario scenario,
  required bool disableAlternate,
  required bool useIcons,
  required ColorScheme colorScheme,
  required ValueChanged<String> onPressed,
}) {
  final children = <Widget>[];
  for (var i = 0; i < scenario.labels.length; i++) {
    final label = scenario.labels[i];
    final isDisabled = disableAlternate && i.isOdd;
    final icon = _iconForLabel(label);
    children.add(
      Padding(
        padding: EdgeInsets.only(right: 8, bottom: 8),
        child: useIcons
            ? TextButton.icon(
                style: style,
                onPressed: isDisabled ? null : () => onPressed(label),
                icon: Icon(icon),
                label: Text(label),
              )
            : TextButton(
                style: style,
                onPressed: isDisabled ? null : () => onPressed(label),
                child: Text(label),
              ),
      ),
    );
  }

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Recipe Gallery',
          subtitle: scenario.description,
          chipLabel: recipe.title,
          colorScheme: colorScheme,
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surface.withAlpha(190),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant.withAlpha(120)),
          ),
          child: Wrap(children: children),
        ),
        SizedBox(height: 14),
        Text(
          'What this board teaches',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        _infoBullet('Buttons inherit the active TextButtonThemeData style automatically.'),
        _infoBullet('Disabling alternating buttons helps verify disabled-state tone and legibility.'),
        _infoBullet('Icon and text combinations show how shape, spacing, and typography hold together.'),
        _infoBullet('Long labels reveal whether padding and minimumSize remain practical.'),
      ],
    ),
  );
}

Widget _buildComparisonMatrix({
  required _ThemeRecipe recipe,
  required ButtonStyle style,
  required bool disableAlternate,
  required bool useIcons,
  required ColorScheme colorScheme,
  required ValueChanged<String> onPressed,
}) {
  final matrixItems = [
    ('Enabled short', 'Run'),
    ('Enabled long', 'Open Detailed Daily Summary'),
    ('Disabled short', 'Pause'),
    ('Disabled long', 'Export Complete Diagnostic Archive'),
    ('Mixed icon', 'Resolve'),
    ('Mixed text', 'Learn More'),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Comparison Matrix',
          subtitle: 'Compare context combinations for one theme recipe.',
          chipLabel: '${recipe.title} matrix',
          colorScheme: colorScheme,
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: matrixItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 130,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final item = matrixItems[index];
            final disabled = item.$1.startsWith('Disabled') || (disableAlternate && index.isOdd);
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _panelColors[index % _panelColors.length],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant.withAlpha(120)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.$1, style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: useIcons && index % 2 == 0
                          ? TextButton.icon(
                              style: style,
                              onPressed: disabled ? null : () => onPressed(item.$2),
                              icon: Icon(_iconForLabel(item.$2)),
                              label: Text(item.$2),
                            )
                          : TextButton(
                              style: style,
                              onPressed: disabled ? null : () => onPressed(item.$2),
                              child: Text(item.$2),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 16),
        Text(
          'Matrix interpretation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        _infoBullet('Keep short and long labels readable under identical style tokens.'),
        _infoBullet('Ensure disabled states still communicate structure and hierarchy.'),
        _infoBullet('Use this matrix pattern to validate theme quality before global rollout.'),
      ],
    ),
  );
}

Widget _buildNestedThemeLab({
  required ThemeData appTheme,
  required ButtonStyle style,
  required _ThemeRecipe recipe,
  required bool localOverrideActive,
  required bool useIcons,
  required bool disableAlternate,
  required ColorScheme colorScheme,
  required ValueChanged<String> onPressed,
}) {
  final localColor = Color.alphaBlend(recipe.accent.withAlpha(54), colorScheme.secondaryContainer);
  final localStyle = style.copyWith(
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withAlpha(90);
      }
      if (states.contains(WidgetState.pressed)) {
        return colorScheme.onSecondaryContainer;
      }
      return colorScheme.secondary;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return localColor.withAlpha(220);
      }
      if (states.contains(WidgetState.hovered)) {
        return localColor.withAlpha(168);
      }
      return localColor.withAlpha(124);
    }),
  );

  Widget actionSet(String prefix, bool local) {
    final labels = [
      '$prefix Open',
      '$prefix Save',
      '$prefix Share',
      '$prefix Archive',
    ];
    return Wrap(
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: EdgeInsets.only(right: 8, bottom: 8),
            child: useIcons
                ? TextButton.icon(
                    onPressed: disableAlternate && i == 1 ? null : () => onPressed(labels[i]),
                    icon: Icon(_iconForLabel(labels[i])),
                    label: Text(labels[i]),
                  )
                : TextButton(
                    onPressed: disableAlternate && i == 1 ? null : () => onPressed(labels[i]),
                    child: Text(labels[i]),
                  ),
          ),
      ],
    );
  }

  final globalSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: colorScheme.primaryContainer.withAlpha(70),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colorScheme.primary.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Global theme section', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text('Uses application TextButtonThemeData as-is.'),
        SizedBox(height: 10),
        actionSet('Global', false),
      ],
    ),
  );

  final localSectionCore = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: colorScheme.secondaryContainer.withAlpha(84),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colorScheme.secondary.withAlpha(140)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nested local override section', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text(
          localOverrideActive
              ? 'This section wraps content with a local TextButtonTheme override.'
              : 'Local override disabled; this section falls back to global style.',
        ),
        SizedBox(height: 10),
        actionSet('Local', true),
      ],
    ),
  );

  final localSection = localOverrideActive
      ? TextButtonTheme(data: TextButtonThemeData(style: localStyle), child: localSectionCore)
      : localSectionCore;

  return Theme(
    data: appTheme,
    child: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: 'Nested Theme Lab',
            subtitle: 'Demonstrates local override patterns for feature surfaces.',
            chipLabel: localOverrideActive ? 'local override active' : 'global only',
            colorScheme: colorScheme,
          ),
          SizedBox(height: 12),
          globalSection,
          SizedBox(height: 10),
          localSection,
          SizedBox(height: 14),
          Text(
            'Why this matters',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          _infoBullet('Feature modules can tone buttons differently without rewriting button widgets.'),
          _infoBullet('Nested TextButtonTheme preserves maintainability while enabling localized emphasis.'),
          _infoBullet('Use local overrides sparingly and intentionally for coherent design systems.'),
        ],
      ),
    ),
  );
}

Widget _buildStateResolutionExplorer({
  required ButtonStyle style,
  required ColorScheme colorScheme,
  required bool showStateDiagnostics,
}) {
  final rows = <Widget>[];
  for (final sample in _stateSamples) {
    rows.add(
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface.withAlpha(180),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme.outlineVariant.withAlpha(120)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Text(sample.label, style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: showStateDiagnostics
                  ? _stateDiagnosticText(style: style, states: sample.states)
                  : Text('Diagnostics hidden. Enable from control deck.'),
            ),
          ],
        ),
      ),
    );
  }

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'State Resolution Explorer',
          subtitle: 'Inspect resolved style values for each WidgetState set.',
          chipLabel: showStateDiagnostics ? 'diagnostics on' : 'diagnostics off',
          colorScheme: colorScheme,
        ),
        SizedBox(height: 10),
        ...rows,
        SizedBox(height: 12),
        Text(
          'Practical guidance',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        _infoBullet('State-resolved values are the source of truth for final visuals.'),
        _infoBullet('Check foreground and background together to avoid low-contrast combinations.'),
        _infoBullet('Keep focus and pressed deltas visible enough for keyboard and touch users.'),
      ],
    ),
  );
}

Widget _stateDiagnosticText({
  required ButtonStyle style,
  required Set<WidgetState> states,
}) {
  final fg = style.foregroundColor?.resolve(states);
  final bg = style.backgroundColor?.resolve(states);
  final overlay = style.overlayColor?.resolve(states);
  final textStyle = style.textStyle?.resolve(states);
  final side = style.side?.resolve(states);
  final minimumSize = style.minimumSize?.resolve(states);
  final elevation = style.elevation?.resolve(states);

  return Text(
    'fg=${_colorToShort(fg)}  bg=${_colorToShort(bg)}  overlay=${_colorToShort(overlay)}\n'
    'font=${textStyle?.fontSize?.toStringAsFixed(1) ?? '-'}  '
    'weight=${textStyle?.fontWeight ?? '-'}  '
    'side=${side?.width.toStringAsFixed(1) ?? '-'}  '
    'min=${minimumSize?.width.toStringAsFixed(0) ?? '-'}x${minimumSize?.height.toStringAsFixed(0) ?? '-'}  '
    'elev=${elevation?.toStringAsFixed(1) ?? '-'}',
    style: TextStyle(fontFamily: 'monospace', fontSize: 12.5),
  );
}

Widget _buildInstructionAndTimeline({
  required ColorScheme colorScheme,
  required int interactionCount,
  required int timelineTick,
  required List<String> eventLog,
  required _ThemeRecipe recipe,
  required _ButtonScenario scenario,
}) {
  final rows = <Widget>[];
  for (var i = 0; i < _guidanceBullets.length; i++) {
    rows.add(_infoBullet(_guidanceBullets[i]));
  }

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Guide and Timeline',
          subtitle: 'Instructive notes plus live interaction history.',
          chipLabel: 'events: ${eventLog.length}',
          colorScheme: colorScheme,
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer.withAlpha(96),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.tertiary.withAlpha(120)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How to use TextButtonThemeData effectively',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              ...rows,
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withAlpha(134),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(height: 8),
              for (final item in _faq)
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.question, style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text(item.answer),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surface.withAlpha(186),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant.withAlpha(140)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interaction timeline', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(height: 8),
              Text('Recipe: ${recipe.title}  Scenario: ${scenario.title}'),
              Text('Timeline ticks: $timelineTick  |  Interactions: $interactionCount'),
              SizedBox(height: 10),
              if (eventLog.isEmpty)
                Text('No events yet. Tap buttons and controls to populate the log.')
              else
                for (final event in eventLog)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(event, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                  ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionHeader({
  required String title,
  required String subtitle,
  required String chipLabel,
  required ColorScheme colorScheme,
}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text(subtitle),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withAlpha(170),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(chipLabel, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      ),
    ],
  );
}

Widget _infoBullet(String text) {
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

ButtonStyle _buildCalmMinimalStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(12 * tuning.radiusScale);
  return ButtonStyle(
    textStyle: WidgetStateProperty.resolveWith((states) {
      final size = tuning.denseMode ? 12.5 : 13.5;
      return TextStyle(
        fontSize: size * tuning.fontScale,
        fontWeight: WidgetStateProperty.resolveAs(FontWeight.w600, states),
        letterSpacing: 0.15,
      );
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withAlpha(110);
      }
      if (states.contains(WidgetState.pressed)) {
        return scheme.primary;
      }
      return scheme.onSurface;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.primary.withAlpha(26);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return scheme.primary.withAlpha(18);
      }
      return scheme.surface;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.primary.withAlpha(44);
      }
      if (states.contains(WidgetState.hovered)) {
        return scheme.primary.withAlpha(26);
      }
      return null;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      final width = states.contains(WidgetState.focused) ? 1.4 : 1.0;
      return BorderSide(color: scheme.outline.withAlpha(130), width: width);
    }),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tuning.pressedElevation;
      }
      return 0.0;
    }),
    minimumSize: WidgetStatePropertyAll(Size(90, tuning.denseMode ? 32 : 40)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding,
        vertical: tuning.verticalPadding - (tuning.denseMode ? 4 : 0),
      ),
    ),
  );
}

ButtonStyle _buildStudioContrastStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(10 * tuning.radiusScale);
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: (tuning.denseMode ? 12 : 13) * tuning.fontScale,
        fontWeight: FontWeight.w700,
      ),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withAlpha(90);
      }
      return scheme.onPrimaryContainer;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.surfaceContainerHighest.withAlpha(160);
      }
      if (states.contains(WidgetState.pressed)) {
        return scheme.primary.withAlpha(230);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return scheme.primary.withAlpha(210);
      }
      return scheme.primary.withAlpha(180);
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white.withAlpha(40);
      }
      return null;
    }),
    side: WidgetStatePropertyAll(BorderSide(color: scheme.primary.withAlpha(200), width: 1.2)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    minimumSize: WidgetStatePropertyAll(Size(96, tuning.denseMode ? 34 : 42)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding + 2,
        vertical: tuning.verticalPadding - (tuning.denseMode ? 3 : 0),
      ),
    ),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tuning.pressedElevation + 0.5;
      }
      return 0.0;
    }),
  );
}

ButtonStyle _buildSunsetCalloutStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(16 * tuning.radiusScale);
  final warm = Color.lerp(scheme.primary, Color(0xFFF59E0B), 0.55) ?? scheme.primary;
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: (tuning.denseMode ? 12.5 : 14) * tuning.fontScale,
        fontWeight: FontWeight.w600,
      ),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withAlpha(95);
      }
      return warm.withAlpha(240);
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return warm.withAlpha(56);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return warm.withAlpha(38);
      }
      return warm.withAlpha(22);
    }),
    side: WidgetStateProperty.resolveWith((states) {
      return BorderSide(
        color: states.contains(WidgetState.focused) ? warm : warm.withAlpha(140),
        width: states.contains(WidgetState.focused) ? 1.8 : 1.2,
      );
    }),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding + 4,
        vertical: tuning.verticalPadding,
      ),
    ),
    minimumSize: WidgetStatePropertyAll(Size(104, tuning.denseMode ? 34 : 44)),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tuning.pressedElevation + 1.0;
      }
      return 0.0;
    }),
  );
}

ButtonStyle _buildForestLinkStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(8 * tuning.radiusScale);
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: (tuning.denseMode ? 12 : 13.5) * tuning.fontScale,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationThickness: 1.6,
      ),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withAlpha(100);
      }
      if (states.contains(WidgetState.pressed)) {
        return scheme.tertiary;
      }
      return scheme.primary;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.tertiary.withAlpha(28);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return scheme.tertiary.withAlpha(18);
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return BorderSide(color: scheme.tertiary, width: 1.3);
      }
      return BorderSide.none;
    }),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    minimumSize: WidgetStatePropertyAll(Size(88, tuning.denseMode ? 30 : 36)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding - 2,
        vertical: tuning.verticalPadding - (tuning.denseMode ? 5 : 3),
      ),
    ),
    elevation: WidgetStatePropertyAll(0.0),
  );
}

ButtonStyle _buildNightCommandStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(12 * tuning.radiusScale);
  final base = Color(0xFF17223C);
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: (tuning.denseMode ? 12 : 13) * tuning.fontScale,
        fontWeight: FontWeight.w700,
      ),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.white.withAlpha(95);
      }
      return Colors.white;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return base.withAlpha(120);
      }
      if (states.contains(WidgetState.pressed)) {
        return Color(0xFF253B70);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return Color(0xFF20315D);
      }
      return base;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white.withAlpha(30);
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.white.withAlpha(16);
      }
      return null;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      final color = states.contains(WidgetState.focused) ? Color(0xFF9AA4FF) : Color(0xFF455A82);
      return BorderSide(color: color, width: states.contains(WidgetState.focused) ? 1.8 : 1.2);
    }),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    minimumSize: WidgetStatePropertyAll(Size(94, tuning.denseMode ? 34 : 42)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding,
        vertical: tuning.verticalPadding - (tuning.denseMode ? 4 : 1),
      ),
    ),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tuning.pressedElevation + 1.4;
      }
      if (states.contains(WidgetState.hovered)) {
        return 0.6;
      }
      return 0.0;
    }),
  );
}

ButtonStyle _buildPlayfulLabStyle(ColorScheme scheme, _StyleTuning tuning) {
  final radius = BorderRadius.circular(22 * tuning.radiusScale);
  final baseA = Color(0xFFEC4899);
  final baseB = Color(0xFF8B5CF6);
  return ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: (tuning.denseMode ? 12 : 13.5) * tuning.fontScale,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.25,
      ),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withAlpha(90);
      }
      return Colors.white;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      final blend = states.contains(WidgetState.pressed)
          ? 0.75
          : states.contains(WidgetState.hovered)
              ? 0.55
              : 0.35;
      return Color.lerp(baseA, baseB, blend)?.withAlpha(states.contains(WidgetState.disabled) ? 90 : 220);
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.black.withAlpha(26);
      }
      return null;
    }),
    side: WidgetStatePropertyAll(BorderSide(color: Colors.white.withAlpha(120), width: 1.1)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
    minimumSize: WidgetStatePropertyAll(Size(104, tuning.denseMode ? 34 : 44)),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: tuning.horizontalPadding + 3,
        vertical: tuning.verticalPadding,
      ),
    ),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tuning.pressedElevation + 2;
      }
      if (states.contains(WidgetState.hovered)) {
        return 0.8;
      }
      return 0.0;
    }),
  );
}

ColorScheme _deriveColorScheme(Color accent, bool highContrast) {
  final base = ColorScheme.fromSeed(seedColor: accent);
  if (!highContrast) {
    return base;
  }
  return base.copyWith(
    primary: _boost(base.primary, 0.15),
    onPrimary: _boost(base.onPrimary, 0.2),
    secondary: _boost(base.secondary, 0.18),
    onSecondary: _boost(base.onSecondary, 0.2),
    tertiary: _boost(base.tertiary, 0.2),
    onTertiary: _boost(base.onTertiary, 0.2),
    surface: _boost(base.surface, 0.06),
    onSurface: _boost(base.onSurface, 0.22),
    outline: _boost(base.outline, 0.18),
    outlineVariant: _boost(base.outlineVariant, 0.12),
  );
}

Color _boost(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final saturation = (hsl.saturation + amount * 0.6).clamp(0.0, 1.0);
  final lightness = hsl.lightness < 0.5
      ? (hsl.lightness - amount * 0.35).clamp(0.0, 1.0)
      : (hsl.lightness + amount * 0.2).clamp(0.0, 1.0);
  return hsl.withSaturation(saturation).withLightness(lightness).toColor();
}

String _colorToShort(Color? color) {
  if (color == null) {
    return '-';
  }
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

IconData _iconForLabel(String text) {
  final lower = text.toLowerCase();
  if (lower.contains('refresh')) return Icons.refresh;
  if (lower.contains('share')) return Icons.share;
  if (lower.contains('inspect')) return Icons.search;
  if (lower.contains('book')) return Icons.bookmark;
  if (lower.contains('download')) return Icons.download;
  if (lower.contains('timeline')) return Icons.timeline;
  if (lower.contains('schedule')) return Icons.schedule;
  if (lower.contains('accessibility')) return Icons.accessibility_new;
  if (lower.contains('approve')) return Icons.check_circle_outline;
  if (lower.contains('archive')) return Icons.archive_outlined;
  if (lower.contains('delete')) return Icons.delete_outline;
  if (lower.contains('edit')) return Icons.edit;
  if (lower.contains('mute')) return Icons.volume_off;
  if (lower.contains('close')) return Icons.close;
  if (lower.contains('save')) return Icons.save_alt;
  if (lower.contains('open')) return Icons.open_in_new;
  if (lower.contains('resolve')) return Icons.task_alt;
  if (lower.contains('learn')) return Icons.school;
  return Icons.chevron_right;
}

class _ThemeRecipe {
  const _ThemeRecipe({
    required this.id,
    required this.title,
    required this.summary,
    required this.usage,
    required this.accent,
    required this.buildStyle,
  });

  final String id;
  final String title;
  final String summary;
  final String usage;
  final Color accent;
  final ButtonStyle Function(ColorScheme, _StyleTuning) buildStyle;
}

class _ButtonScenario {
  const _ButtonScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.labels,
  });

  final String id;
  final String title;
  final String description;
  final List<String> labels;
}

class _StyleTuning {
  const _StyleTuning({
    required this.denseMode,
    required this.useIcons,
    required this.highContrast,
    required this.fontScale,
    required this.radiusScale,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.pressedElevation,
  });

  final bool denseMode;
  final bool useIcons;
  final bool highContrast;
  final double fontScale;
  final double radiusScale;
  final double horizontalPadding;
  final double verticalPadding;
  final double pressedElevation;
}

class _StateSample {
  const _StateSample(this.label, this.states);

  final String label;
  final Set<WidgetState> states;
}

class _QuestionAnswer {
  const _QuestionAnswer({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _TokenBarsPainter extends CustomPainter {
  _TokenBarsPainter({required this.accent, required this.seed});

  final Color accent;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(6);
    final rect = RRect.fromRectAndRadius(Offset.zero & size, radius);
    final bg = Paint()..color = Colors.white.withAlpha(160);
    canvas.drawRRect(rect, bg);

    final r = math.Random(seed.toInt() + 37);
    final linePaint = Paint()..style = PaintingStyle.fill;
    final bars = 6;
    for (var i = 0; i < bars; i++) {
      final width = size.width * (0.35 + r.nextDouble() * 0.6);
      final top = 7 + i * 8.5;
      final c = Color.lerp(accent, Colors.white, i / bars)?.withAlpha(220) ?? accent;
      linePaint.color = c;
      final rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(8, top, width, 5.5),
        Radius.circular(4),
      );
      canvas.drawRRect(rr, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TokenBarsPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.seed != seed;
  }
}
