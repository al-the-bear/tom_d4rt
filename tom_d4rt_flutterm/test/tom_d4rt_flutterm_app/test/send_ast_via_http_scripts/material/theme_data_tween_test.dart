import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemeRecipe> _recipes = [
  _ThemeRecipe(
    id: 'calm-day',
    title: 'Calm Day',
    summary: 'Soft daylight palette for editorial and reading-heavy surfaces.',
    accent: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemeRecipe(
    id: 'studio-night',
    title: 'Studio Night',
    summary: 'High-legibility dark scheme for tool-centric layouts.',
    accent: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemeRecipe(
    id: 'sunset-ops',
    title: 'Sunset Ops',
    summary: 'Warm operational style with strong CTA emphasis.',
    accent: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemeRecipe(
    id: 'violet-lab',
    title: 'Violet Lab',
    summary: 'Experimental palette for creative dashboards and playful data.',
    accent: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _ThemeRecipe(
    id: 'atlas-green',
    title: 'Atlas Green',
    summary: 'Navigation-oriented enterprise tone with clear structure contrast.',
    accent: Color(0xFF166534),
    brightness: Brightness.light,
  ),
  _ThemeRecipe(
    id: 'signal-red',
    title: 'Signal Red',
    summary: 'Alert-aware palette for monitoring and response interfaces.',
    accent: Color(0xFFB91C1C),
    brightness: Brightness.dark,
  ),
];

const List<_TransitionScenario> _scenarios = [
  _TransitionScenario(
    id: 'dashboard',
    title: 'Ops Dashboard',
    description: 'Cards, chips, filters, and action rows under interpolated themes.',
  ),
  _TransitionScenario(
    id: 'forms',
    title: 'Forms Workspace',
    description: 'Input, toggles, helper text, and validation accents across theme tweening.',
  ),
  _TransitionScenario(
    id: 'catalog',
    title: 'Content Catalog',
    description: 'Tile-heavy grids with mixed typography and tag components.',
  ),
  _TransitionScenario(
    id: 'shell',
    title: 'App Shell',
    description: 'Navigation rail, app bar, FAB, and surface hierarchy transitions.',
  ),
];

const List<String> _guidance = [
  'ThemeDataTween is a Tween<ThemeData> that delegates interpolation to ThemeData.lerp.',
  'Use it when you need controlled theme blending over time instead of abrupt theme swaps.',
  'Preview interpolation at multiple t values to catch contrast or hierarchy regressions early.',
  'Always test both light-to-dark and dark-to-light paths because text contrast can diverge.',
  'Monitor component-specific behavior: buttons, inputs, cards, chips, and app bars do not all shift equally.',
  'Theme transitions should preserve semantic emphasis, not only color aesthetics.',
  'In production flows, connect ThemeDataTween to animation controllers or TweenAnimationBuilder.',
  'Use diagnostics panels during tuning so design decisions are based on resolved theme values.',
  'Keep transition duration contextual: fast for mode toggles, slower for educational previews.',
  'When token systems evolve, ThemeDataTween demos can prevent visual regressions across feature modules.',
];

const List<_Qna> _faq = [
  _Qna(
    question: 'What is the main purpose of ThemeDataTween?',
    answer:
        'It interpolates complete ThemeData objects so UI surfaces can animate between design states smoothly.',
  ),
  _Qna(
    question: 'Do I have to animate every widget manually?',
    answer:
        'No. Wrap widget trees with Theme(data: tween.lerp(t), child: ...) to let themed widgets react automatically.',
  ),
  _Qna(
    question: 'How is this different from AnimatedTheme?',
    answer:
        'AnimatedTheme is convenient and implicit, while ThemeDataTween gives explicit control over interpolation value t.',
  ),
  _Qna(
    question: 'What should I validate during theme interpolation?',
    answer:
        'Check readability, hierarchy contrast, interactive states, spacing clarity, and component identity consistency.',
  ),
];

dynamic build(BuildContext context) {
  var beginIndex = 0;
  var endIndex = 1;
  var scenarioIndex = 0;
  var boardIndex = 0;
  var tValue = 0.35;
  var autoPlay = false;
  var highContrast = false;
  var denseMode = false;
  var showDiagnostics = true;
  var emphasizeTypography = false;
  var interactionCount = 0;
  var timelineTick = 0;
  var cardRoundness = 14.0;
  var contentScale = 1.0;
  var animationSpeed = 1.0;
  final eventLog = <String>[];

  void addEvent(String message) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    eventLog.insert(0, '$stamp $message');
    if (eventLog.length > 20) {
      eventLog.removeRange(20, eventLog.length);
    }
  }

  debugPrint('ThemeDataTween deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      if (autoPlay) {
        final step = 0.006 * animationSpeed;
        final next = tValue + step;
        tValue = next > 1.0 ? 0.0 : next;
      }

      final beginRecipe = _recipes[beginIndex];
      final endRecipe = _recipes[endIndex];

      ThemeData beginTheme = _buildThemeFromRecipe(
        beginRecipe,
        highContrast: highContrast,
        denseMode: denseMode,
        emphasizeTypography: emphasizeTypography,
        cardRoundness: cardRoundness,
      );
      ThemeData endTheme = _buildThemeFromRecipe(
        endRecipe,
        highContrast: highContrast,
        denseMode: denseMode,
        emphasizeTypography: emphasizeTypography,
        cardRoundness: cardRoundness,
      );

      final tween = ThemeDataTween(begin: beginTheme, end: endTheme);
      final current = tween.lerp(tValue);
      final scenario = _scenarios[scenarioIndex];

      return Theme(
        data: current,
        child: Container(
          color: current.colorScheme.surface,
          child: Column(
            children: [
              _header(
                theme: current,
                beginRecipe: beginRecipe,
                endRecipe: endRecipe,
                scenario: scenario,
                tValue: tValue,
                interactionCount: interactionCount,
                timelineTick: timelineTick,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controlPanel(
                      theme: current,
                      beginIndex: beginIndex,
                      endIndex: endIndex,
                      scenarioIndex: scenarioIndex,
                      boardIndex: boardIndex,
                      tValue: tValue,
                      autoPlay: autoPlay,
                      highContrast: highContrast,
                      denseMode: denseMode,
                      showDiagnostics: showDiagnostics,
                      emphasizeTypography: emphasizeTypography,
                      cardRoundness: cardRoundness,
                      contentScale: contentScale,
                      animationSpeed: animationSpeed,
                      onBeginChanged: (value) {
                        setState(() {
                          beginIndex = value;
                          timelineTick += 1;
                          addEvent('Begin theme: ${_recipes[value].title}.');
                        });
                      },
                      onEndChanged: (value) {
                        setState(() {
                          endIndex = value;
                          timelineTick += 1;
                          addEvent('End theme: ${_recipes[value].title}.');
                        });
                      },
                      onScenarioChanged: (value) {
                        setState(() {
                          scenarioIndex = value;
                          timelineTick += 1;
                          addEvent('Scenario: ${_scenarios[value].title}.');
                        });
                      },
                      onBoardChanged: (value) {
                        setState(() {
                          boardIndex = value;
                          timelineTick += 1;
                          addEvent('Board: ${_boardTitle(value)}.');
                        });
                      },
                      onTChanged: (value) {
                        setState(() {
                          tValue = value;
                          timelineTick += 1;
                        });
                      },
                      onAutoPlayChanged: (value) {
                        setState(() {
                          autoPlay = value;
                          timelineTick += 1;
                          addEvent('Auto-play ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onContrastChanged: (value) {
                        setState(() {
                          highContrast = value;
                          timelineTick += 1;
                          addEvent('High contrast ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDenseChanged: (value) {
                        setState(() {
                          denseMode = value;
                          timelineTick += 1;
                          addEvent('Dense mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDiagnosticsChanged: (value) {
                        setState(() {
                          showDiagnostics = value;
                          timelineTick += 1;
                          addEvent('Diagnostics ${value ? 'visible' : 'hidden'}.');
                        });
                      },
                      onTypographyChanged: (value) {
                        setState(() {
                          emphasizeTypography = value;
                          timelineTick += 1;
                          addEvent('Typography emphasis ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onRoundnessChanged: (value) {
                        setState(() {
                          cardRoundness = value;
                          timelineTick += 1;
                        });
                      },
                      onScaleChanged: (value) {
                        setState(() {
                          contentScale = value;
                          timelineTick += 1;
                        });
                      },
                      onSpeedChanged: (value) {
                        setState(() {
                          animationSpeed = value;
                          timelineTick += 1;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 12, 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              current.colorScheme.surface,
                              current.colorScheme.surfaceContainerHighest.withAlpha(168),
                              current.colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: AnimatedScale(
                          scale: contentScale,
                          duration: Duration(milliseconds: 220),
                          alignment: Alignment.topCenter,
                          child: _buildBoard(
                            boardIndex: boardIndex,
                            current: current,
                            begin: beginTheme,
                            end: endTheme,
                            tween: tween,
                            tValue: tValue,
                            scenario: scenario,
                            showDiagnostics: showDiagnostics,
                            interactionCount: interactionCount,
                            timelineTick: timelineTick,
                            eventLog: eventLog,
                            onAction: (label) {
                              setState(() {
                                interactionCount += 1;
                                timelineTick += 1;
                                addEvent('Action tapped: $label');
                              });
                            },
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

String _boardTitle(int index) {
  const titles = [
    'Transition Timeline',
    'Token Matrix',
    'Scene Playground',
    'Shell Preview',
    'Guide + Timeline',
  ];
  if (index < 0 || index >= titles.length) {
    return titles[0];
  }
  return titles[index];
}

ThemeData _buildThemeFromRecipe(
  _ThemeRecipe recipe, {
  required bool highContrast,
  required bool denseMode,
  required bool emphasizeTypography,
  required double cardRoundness,
}) {
  var scheme = ColorScheme.fromSeed(
    seedColor: recipe.accent,
    brightness: recipe.brightness,
  );

  if (highContrast) {
    scheme = scheme.copyWith(
      primary: _contrastShift(scheme.primary, 0.2),
      onPrimary: _contrastShift(scheme.onPrimary, 0.2),
      secondary: _contrastShift(scheme.secondary, 0.18),
      onSecondary: _contrastShift(scheme.onSecondary, 0.2),
      tertiary: _contrastShift(scheme.tertiary, 0.18),
      onTertiary: _contrastShift(scheme.onTertiary, 0.2),
      surface: _contrastShift(scheme.surface, 0.08),
      onSurface: _contrastShift(scheme.onSurface, 0.2),
      outline: _contrastShift(scheme.outline, 0.2),
      outlineVariant: _contrastShift(scheme.outlineVariant, 0.14),
    );
  }

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    visualDensity: denseMode ? VisualDensity.compact : VisualDensity.standard,
  );

  final textTheme = emphasizeTypography
      ? base.textTheme.copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          titleMedium: base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(letterSpacing: 0.12),
        )
      : base.textTheme;

  return base.copyWith(
    textTheme: textTheme,
    cardTheme: CardThemeData(
      elevation: denseMode ? 0.5 : 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRoundness)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withAlpha(140),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(cardRoundness - 4)),
      isDense: denseMode,
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRoundness - 6)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    navigationRailTheme: NavigationRailThemeData(
      selectedIconTheme: IconThemeData(color: scheme.onSecondaryContainer),
      selectedLabelTextStyle: TextStyle(color: scheme.onSecondaryContainer, fontWeight: FontWeight.w700),
      indicatorColor: scheme.secondaryContainer,
      backgroundColor: scheme.surface,
    ),
  );
}

Color _contrastShift(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final saturation = (hsl.saturation + amount * 0.55).clamp(0.0, 1.0);
  final lightness = hsl.lightness < 0.5
      ? (hsl.lightness - amount * 0.32).clamp(0.0, 1.0)
      : (hsl.lightness + amount * 0.2).clamp(0.0, 1.0);
  return hsl.withSaturation(saturation).withLightness(lightness).toColor();
}

Widget _header({
  required ThemeData theme,
  required _ThemeRecipe beginRecipe,
  required _ThemeRecipe endRecipe,
  required _TransitionScenario scenario,
  required double tValue,
  required int interactionCount,
  required int timelineTick,
}) {
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
      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: CustomPaint(
            painter: _TweenGlyphPainter(
              primary: theme.colorScheme.primary,
              secondary: theme.colorScheme.secondary,
              seed: timelineTick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ThemeDataTween Transition Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'begin: ${beginRecipe.title}  end: ${endRecipe.title}  t=${tValue.toStringAsFixed(2)}  interactions: $interactionCount',
                style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                scenario.description,
                style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(170)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _controlPanel({
  required ThemeData theme,
  required int beginIndex,
  required int endIndex,
  required int scenarioIndex,
  required int boardIndex,
  required double tValue,
  required bool autoPlay,
  required bool highContrast,
  required bool denseMode,
  required bool showDiagnostics,
  required bool emphasizeTypography,
  required double cardRoundness,
  required double contentScale,
  required double animationSpeed,
  required ValueChanged<int> onBeginChanged,
  required ValueChanged<int> onEndChanged,
  required ValueChanged<int> onScenarioChanged,
  required ValueChanged<int> onBoardChanged,
  required ValueChanged<double> onTChanged,
  required ValueChanged<bool> onAutoPlayChanged,
  required ValueChanged<bool> onContrastChanged,
  required ValueChanged<bool> onDenseChanged,
  required ValueChanged<bool> onDiagnosticsChanged,
  required ValueChanged<bool> onTypographyChanged,
  required ValueChanged<double> onRoundnessChanged,
  required ValueChanged<double> onScaleChanged,
  required ValueChanged<double> onSpeedChanged,
}) {
  return Container(
    width: 374,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          theme.colorScheme.surfaceContainer.withAlpha(90),
          theme.colorScheme.surfaceContainerLow.withAlpha(80),
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
          Text('Transition Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Tune tween endpoints, interpolation progress, and preview conditions.'),
          SizedBox(height: 10),
          _dropdown<int>(
            label: 'Begin Theme Recipe',
            value: beginIndex,
            items: [
              for (var i = 0; i < _recipes.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_recipes[i].title)),
            ],
            onChanged: onBeginChanged,
          ),
          _dropdown<int>(
            label: 'End Theme Recipe',
            value: endIndex,
            items: [
              for (var i = 0; i < _recipes.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_recipes[i].title)),
            ],
            onChanged: onEndChanged,
          ),
          _dropdown<int>(
            label: 'Scenario',
            value: scenarioIndex,
            items: [
              for (var i = 0; i < _scenarios.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_scenarios[i].title)),
            ],
            onChanged: onScenarioChanged,
          ),
          _dropdown<int>(
            label: 'Board',
            value: boardIndex,
            items: [
              for (var i = 0; i < 5; i++)
                DropdownMenuItem<int>(value: i, child: Text(_boardTitle(i))),
            ],
            onChanged: onBoardChanged,
          ),
          SizedBox(height: 8),
          _slider(
            label: 'Interpolation t',
            value: tValue,
            min: 0,
            max: 1,
            onChanged: onTChanged,
          ),
          _switch(
            title: 'Auto-play t',
            subtitle: 'Continuously animate tween progress',
            value: autoPlay,
            onChanged: onAutoPlayChanged,
          ),
          _switch(
            title: 'High contrast mode',
            subtitle: 'Increase contrast in both begin/end themes',
            value: highContrast,
            onChanged: onContrastChanged,
          ),
          _switch(
            title: 'Dense mode',
            subtitle: 'Apply compact visual density to components',
            value: denseMode,
            onChanged: onDenseChanged,
          ),
          _switch(
            title: 'Show diagnostics',
            subtitle: 'Display resolved token and interpolation values',
            value: showDiagnostics,
            onChanged: onDiagnosticsChanged,
          ),
          _switch(
            title: 'Typography emphasis',
            subtitle: 'Increase font weight and hierarchy strength',
            value: emphasizeTypography,
            onChanged: onTypographyChanged,
          ),
          _slider(
            label: 'Card roundness',
            value: cardRoundness,
            min: 8,
            max: 24,
            onChanged: onRoundnessChanged,
          ),
          _slider(
            label: 'Content scale',
            value: contentScale,
            min: 0.9,
            max: 1.12,
            onChanged: onScaleChanged,
          ),
          _slider(
            label: 'Auto-play speed',
            value: animationSpeed,
            min: 0.5,
            max: 2.0,
            onChanged: onSpeedChanged,
          ),
        ],
      ),
    ),
  );
}

Widget _dropdown<T>({
  required String label,
  required T value,
  required List<DropdownMenuItem<T>> items,
  required ValueChanged<T> onChanged,
}) {
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
        DropdownButtonFormField<T>(
          initialValue: value,
          isDense: true,
          isExpanded: true,
          decoration: InputDecoration(border: OutlineInputBorder()),
          items: items,
          onChanged: (next) {
            if (next != null) {
              onChanged(next);
            }
          },
        ),
      ],
    ),
  );
}

Widget _slider({
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

Widget _switch({
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
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

Widget _buildBoard({
  required int boardIndex,
  required ThemeData current,
  required ThemeData begin,
  required ThemeData end,
  required ThemeDataTween tween,
  required double tValue,
  required _TransitionScenario scenario,
  required bool showDiagnostics,
  required int interactionCount,
  required int timelineTick,
  required List<String> eventLog,
  required ValueChanged<String> onAction,
}) {
  switch (boardIndex) {
    case 0:
      return _timelineBoard(
        current: current,
        begin: begin,
        end: end,
        tween: tween,
        tValue: tValue,
        scenario: scenario,
        showDiagnostics: showDiagnostics,
        onAction: onAction,
      );
    case 1:
      return _tokenMatrixBoard(
        current: current,
        begin: begin,
        end: end,
        tween: tween,
        tValue: tValue,
      );
    case 2:
      return _sceneBoard(
        current: current,
        scenario: scenario,
        onAction: onAction,
      );
    case 3:
      return _shellBoard(
        current: current,
        onAction: onAction,
      );
    default:
      return _guideBoard(
        current: current,
        interactionCount: interactionCount,
        timelineTick: timelineTick,
        eventLog: eventLog,
      );
  }
}

Widget _timelineBoard({
  required ThemeData current,
  required ThemeData begin,
  required ThemeData end,
  required ThemeDataTween tween,
  required double tValue,
  required _TransitionScenario scenario,
  required bool showDiagnostics,
  required ValueChanged<String> onAction,
}) {
  final marks = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Transition Timeline', scenario.description, 't=${tValue.toStringAsFixed(2)}'),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final mark in marks)
              _timelineCard(
                theme: tween.lerp(mark),
                label: 't=${mark.toStringAsFixed(1)}',
                onAction: () => onAction('timeline-${mark.toStringAsFixed(1)}'),
              ),
          ],
        ),
        SizedBox(height: 12),
        if (showDiagnostics)
          _diagnosticCard(
            current,
            'Interpolation diagnostics',
            [
              'current primary: ${_colorHex(current.colorScheme.primary)}',
              'current surface: ${_colorHex(current.colorScheme.surface)}',
              'begin primary: ${_colorHex(begin.colorScheme.primary)}',
              'end primary: ${_colorHex(end.colorScheme.primary)}',
              't progress: ${tValue.toStringAsFixed(3)}',
            ],
          ),
      ],
    ),
  );
}

Widget _timelineCard({required ThemeData theme, required String label, required VoidCallback onAction}) {
  return Theme(
    data: theme,
    child: Container(
      width: 260,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(128)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Row(
            children: [
              Chip(label: Text('chip')),
              SizedBox(width: 6),
              FilledButton(onPressed: onAction, child: Text('Action')),
            ],
          ),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Input preview')),
          SizedBox(height: 8),
          Card(
            child: ListTile(
              title: Text('Card tile'),
              subtitle: Text('Theme tokens at $label'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _tokenMatrixBoard({
  required ThemeData current,
  required ThemeData begin,
  required ThemeData end,
  required ThemeDataTween tween,
  required double tValue,
}) {
  final rows = [
    ('primary', begin.colorScheme.primary, end.colorScheme.primary, current.colorScheme.primary),
    ('secondary', begin.colorScheme.secondary, end.colorScheme.secondary, current.colorScheme.secondary),
    ('surface', begin.colorScheme.surface, end.colorScheme.surface, current.colorScheme.surface),
    ('onSurface', begin.colorScheme.onSurface, end.colorScheme.onSurface, current.colorScheme.onSurface),
    ('outline', begin.colorScheme.outline, end.colorScheme.outline, current.colorScheme.outline),
    (
      'titleLarge size',
      Color(0x00000000),
      Color(0x00000000),
      Color(0x00000000),
    ),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Token Matrix', 'Compare begin/end/current tokens across the tween.', 'matrix'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: current.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: _matrixRow(current, rows[i].$1, rows[i].$2, rows[i].$3, rows[i].$4, i, tValue),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _matrixRow(
  ThemeData current,
  String label,
  Color begin,
  Color end,
  Color value,
  int index,
  double t,
) {
  if (label == 'titleLarge size') {
    final beginSize = current.textTheme.titleLarge?.fontSize ?? 0;
    final endSize = beginSize;
    final currentSize = beginSize;
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: TextStyle(fontWeight: FontWeight.w700))),
        Expanded(child: Text('begin=${beginSize.toStringAsFixed(1)}  end=${endSize.toStringAsFixed(1)}  current=${currentSize.toStringAsFixed(1)}  t=${t.toStringAsFixed(2)}')),
      ],
    );
  }

  return Row(
    children: [
      SizedBox(width: 120, child: Text(label, style: TextStyle(fontWeight: FontWeight.w700))),
      _swatch(begin),
      SizedBox(width: 8),
      _swatch(end),
      SizedBox(width: 8),
      _swatch(value),
      SizedBox(width: 10),
      Expanded(child: Text('begin ${_colorHex(begin)}  end ${_colorHex(end)}  current ${_colorHex(value)}')),
    ],
  );
}

Widget _swatch(Color color) {
  return Container(
    width: 30,
    height: 20,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.black.withAlpha(50)),
    ),
  );
}

Widget _sceneBoard({required ThemeData current, required _TransitionScenario scenario, required ValueChanged<String> onAction}) {
  final cards = [
    ('Pipeline Health', '76%', Icons.monitor_heart),
    ('Pending Reviews', '14', Icons.rate_review_outlined),
    ('Deploy Queue', '3', Icons.rocket_launch_outlined),
    ('Incident Alerts', '2', Icons.warning_amber_outlined),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Scene Playground', 'Live feature-style surface under interpolated theme.', scenario.title),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: current.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Filter widgets',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  FilledButton.icon(
                    onPressed: () => onAction('refresh-surface'),
                    icon: Icon(Icons.refresh),
                    label: Text('Refresh'),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final card in cards)
                    SizedBox(
                      width: 250,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(card.$3),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(card.$1, style: TextStyle(fontWeight: FontWeight.w700))),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(card.$2, style: current.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                children: [
                                  ActionChip(label: Text('Inspect'), onPressed: () => onAction('inspect-${card.$1}')),
                                  ActionChip(label: Text('Drill down'), onPressed: () => onAction('drill-${card.$1}')),
                                ],
                              ),
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

Widget _shellBoard({required ThemeData current, required ValueChanged<String> onAction}) {
  final navItems = [
    ('Overview', Icons.dashboard_outlined),
    ('Activity', Icons.timeline),
    ('Deployments', Icons.rocket_outlined),
    ('Settings', Icons.settings_outlined),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Shell Preview', 'Navigation + app frame behaviors under theme tween.', 'shell'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 460,
          decoration: BoxDecoration(
            color: current.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: 1,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final n in navItems)
                    NavigationRailDestination(
                      icon: Icon(n.$2),
                      label: Text(n.$1),
                    ),
                ],
              ),
              VerticalDivider(width: 1),
              Expanded(
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Interpolated App Shell'),
                      actions: [
                        IconButton(onPressed: () => onAction('search'), icon: Icon(Icons.search)),
                        IconButton(onPressed: () => onAction('notifications'), icon: Icon(Icons.notifications_none)),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(12),
                        children: [
                          Card(
                            child: ListTile(
                              title: Text('Primary workspace panel'),
                              subtitle: Text('Observe app bar, surface, and list tile token interpolation.'),
                              trailing: FilledButton(onPressed: () => onAction('open-panel'), child: Text('Open')),
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Theme-sensitive controls', style: TextStyle(fontWeight: FontWeight.w700)),
                                  SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      ElevatedButton(onPressed: () => onAction('elevated'), child: Text('Elevated')),
                                      OutlinedButton(onPressed: () => onAction('outlined'), child: Text('Outlined')),
                                      TextButton(onPressed: () => onAction('text'), child: Text('Text')),
                                      FilledButton.tonal(onPressed: () => onAction('tonal'), child: Text('Tonal')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideBoard({
  required ThemeData current,
  required int interactionCount,
  required int timelineTick,
  required List<String> eventLog,
}) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Guide + Timeline', 'Usage guidance, FAQ, and interaction history.', 'guide'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: current.colorScheme.tertiaryContainer.withAlpha(110),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.tertiary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ThemeDataTween usage guidance', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final g in _guidance) _bullet(g),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: current.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final q in _faq)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(q.question, style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text(q.answer),
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
            color: current.colorScheme.primaryContainer.withAlpha(102),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.primary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              Text('Interactions: $interactionCount  |  Ticks: $timelineTick'),
              SizedBox(height: 8),
              if (eventLog.isEmpty)
                Text('No events logged yet. Interact with controls and buttons to populate history.')
              else
                for (final e in eventLog)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(e, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
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

Widget _diagnosticCard(ThemeData theme, String title, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer.withAlpha(106),
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

String _colorHex(Color color) {
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

class _TweenGlyphPainter extends CustomPainter {
  _TweenGlyphPainter({required this.primary, required this.secondary, required this.seed});

  final Color primary;
  final Color secondary;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rnd = math.Random(seed.toInt() + 31);
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.32 + rnd.nextDouble() * 0.58);
      final y = 8 + i * 8.3;
      paint.color = Color.lerp(primary, secondary, i / 5)?.withAlpha(225) ?? primary;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.4), Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TweenGlyphPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary || oldDelegate.seed != seed;
  }
}

class _ThemeRecipe {
  const _ThemeRecipe({
    required this.id,
    required this.title,
    required this.summary,
    required this.accent,
    required this.brightness,
  });

  final String id;
  final String title;
  final String summary;
  final Color accent;
  final Brightness brightness;
}

class _TransitionScenario {
  const _TransitionScenario({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;
}

class _Qna {
  const _Qna({required this.question, required this.answer});

  final String question;
  final String answer;
}
