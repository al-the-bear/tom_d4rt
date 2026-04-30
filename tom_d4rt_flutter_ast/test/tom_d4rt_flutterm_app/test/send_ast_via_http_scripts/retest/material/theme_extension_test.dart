import 'dart:math' as math;

import 'package:flutter/material.dart';

@immutable
class BrandTokens extends ThemeExtension<BrandTokens> {
  const BrandTokens({
    required this.brand,
    required this.brandOn,
    required this.brandSoft,
    required this.shell,
  });

  final Color brand;
  final Color brandOn;
  final Color brandSoft;
  final Color shell;

  @override
  BrandTokens copyWith({Color? brand, Color? brandOn, Color? brandSoft, Color? shell}) {
    return BrandTokens(
      brand: brand ?? this.brand,
      brandOn: brandOn ?? this.brandOn,
      brandSoft: brandSoft ?? this.brandSoft,
      shell: shell ?? this.shell,
    );
  }

  @override
  BrandTokens lerp(ThemeExtension<BrandTokens>? other, double t) {
    if (other is! BrandTokens) {
      return this;
    }
    return BrandTokens(
      brand: Color.lerp(brand, other.brand, t) ?? brand,
      brandOn: Color.lerp(brandOn, other.brandOn, t) ?? brandOn,
      brandSoft: Color.lerp(brandSoft, other.brandSoft, t) ?? brandSoft,
      shell: Color.lerp(shell, other.shell, t) ?? shell,
    );
  }
}

@immutable
class StatusTokens extends ThemeExtension<StatusTokens> {
  const StatusTokens({
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  @override
  StatusTokens copyWith({Color? success, Color? warning, Color? error, Color? info}) {
    return StatusTokens(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  StatusTokens lerp(ThemeExtension<StatusTokens>? other, double t) {
    if (other is! StatusTokens) {
      return this;
    }
    return StatusTokens(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      error: Color.lerp(error, other.error, t) ?? error,
      info: Color.lerp(info, other.info, t) ?? info,
    );
  }
}

@immutable
class ScaleTokens extends ThemeExtension<ScaleTokens> {
  const ScaleTokens({
    required this.compact,
    required this.comfortable,
    required this.expanded,
    required this.radius,
  });

  final double compact;
  final double comfortable;
  final double expanded;
  final double radius;

  @override
  ScaleTokens copyWith({double? compact, double? comfortable, double? expanded, double? radius}) {
    return ScaleTokens(
      compact: compact ?? this.compact,
      comfortable: comfortable ?? this.comfortable,
      expanded: expanded ?? this.expanded,
      radius: radius ?? this.radius,
    );
  }

  @override
  ScaleTokens lerp(ThemeExtension<ScaleTokens>? other, double t) {
    if (other is! ScaleTokens) {
      return this;
    }
    return ScaleTokens(
      compact: lerpDouble(compact, other.compact, t),
      comfortable: lerpDouble(comfortable, other.comfortable, t),
      expanded: lerpDouble(expanded, other.expanded, t),
      radius: lerpDouble(radius, other.radius, t),
    );
  }

  double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

@immutable
class BadgeTokens extends ThemeExtension<BadgeTokens> {
  const BadgeTokens({
    required this.bg,
    required this.fg,
    required this.dot,
    required this.border,
  });

  final Color bg;
  final Color fg;
  final Color dot;
  final Color border;

  @override
  BadgeTokens copyWith({Color? bg, Color? fg, Color? dot, Color? border}) {
    return BadgeTokens(
      bg: bg ?? this.bg,
      fg: fg ?? this.fg,
      dot: dot ?? this.dot,
      border: border ?? this.border,
    );
  }

  @override
  BadgeTokens lerp(ThemeExtension<BadgeTokens>? other, double t) {
    if (other is! BadgeTokens) {
      return this;
    }
    return BadgeTokens(
      bg: Color.lerp(bg, other.bg, t) ?? bg,
      fg: Color.lerp(fg, other.fg, t) ?? fg,
      dot: Color.lerp(dot, other.dot, t) ?? dot,
      border: Color.lerp(border, other.border, t) ?? border,
    );
  }
}

class _Recipe {
  const _Recipe({
    required this.id,
    required this.title,
    required this.summary,
    required this.seed,
    required this.brightness,
    required this.brand,
    required this.status,
    required this.scale,
    required this.badge,
  });

  final String id;
  final String title;
  final String summary;
  final Color seed;
  final Brightness brightness;
  final BrandTokens brand;
  final StatusTokens status;
  final ScaleTokens scale;
  final BadgeTokens badge;
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

const List<_Recipe> _recipes = [
  _Recipe(
    id: 'aurora',
    title: 'Aurora Workspace',
    summary: 'Balanced light design tokens with calm accent hierarchy.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
    brand: BrandTokens(
      brand: Color(0xFF0F766E),
      brandOn: Color(0xFFFFFFFF),
      brandSoft: Color(0xFFCFFAFE),
      shell: Color(0xFFF0FDFA),
    ),
    status: StatusTokens(
      success: Color(0xFF15803D),
      warning: Color(0xFFB45309),
      error: Color(0xFFB91C1C),
      info: Color(0xFF0369A1),
    ),
    scale: ScaleTokens(compact: 6, comfortable: 10, expanded: 16, radius: 14),
    badge: BadgeTokens(
      bg: Color(0xFFCCFBF1),
      fg: Color(0xFF115E59),
      dot: Color(0xFF14B8A6),
      border: Color(0xFF2DD4BF),
    ),
  ),
  _Recipe(
    id: 'midnight',
    title: 'Midnight Ops',
    summary: 'Dark operational tokens optimized for contrast and scan speed.',
    seed: Color(0xFF1E293B),
    brightness: Brightness.dark,
    brand: BrandTokens(
      brand: Color(0xFF60A5FA),
      brandOn: Color(0xFF0F172A),
      brandSoft: Color(0xFF1E3A5F),
      shell: Color(0xFF0B1220),
    ),
    status: StatusTokens(
      success: Color(0xFF4ADE80),
      warning: Color(0xFFFBBF24),
      error: Color(0xFFF87171),
      info: Color(0xFF38BDF8),
    ),
    scale: ScaleTokens(compact: 5, comfortable: 9, expanded: 14, radius: 12),
    badge: BadgeTokens(
      bg: Color(0xFF1E293B),
      fg: Color(0xFFE2E8F0),
      dot: Color(0xFF60A5FA),
      border: Color(0xFF334155),
    ),
  ),
  _Recipe(
    id: 'ember',
    title: 'Ember Control',
    summary: 'Warm action-oriented tokens for command-heavy views.',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
    brand: BrandTokens(
      brand: Color(0xFFC2410C),
      brandOn: Color(0xFFFFFFFF),
      brandSoft: Color(0xFFFFEDD5),
      shell: Color(0xFFFFF7ED),
    ),
    status: StatusTokens(
      success: Color(0xFF16A34A),
      warning: Color(0xFFEA580C),
      error: Color(0xFFDC2626),
      info: Color(0xFF0284C7),
    ),
    scale: ScaleTokens(compact: 7, comfortable: 11, expanded: 18, radius: 16),
    badge: BadgeTokens(
      bg: Color(0xFFFFEDD5),
      fg: Color(0xFF9A3412),
      dot: Color(0xFFFB923C),
      border: Color(0xFFF97316),
    ),
  ),
  _Recipe(
    id: 'violet',
    title: 'Violet Studio',
    summary: 'Creative dark token set with expressive badge language.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
    brand: BrandTokens(
      brand: Color(0xFFA78BFA),
      brandOn: Color(0xFF1E1B4B),
      brandSoft: Color(0xFF312E81),
      shell: Color(0xFF1E1B38),
    ),
    status: StatusTokens(
      success: Color(0xFF34D399),
      warning: Color(0xFFF59E0B),
      error: Color(0xFFFB7185),
      info: Color(0xFF22D3EE),
    ),
    scale: ScaleTokens(compact: 6, comfortable: 10, expanded: 17, radius: 18),
    badge: BadgeTokens(
      bg: Color(0xFF312E81),
      fg: Color(0xFFE9D5FF),
      dot: Color(0xFFA78BFA),
      border: Color(0xFF8B5CF6),
    ),
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario('ops', 'Ops Dashboard', 'Metric cards and status badges driven by custom extension tokens.'),
  _Scenario('forms', 'Form Builder', 'Input and validation states themed through extension values.'),
  _Scenario('catalog', 'Catalog Tiles', 'Tag-heavy tile layout influenced by badge and spacing tokens.'),
  _Scenario('shell', 'App Shell', 'Navigation shell with extension-branded controls and rails.'),
];

const List<_Faq> _faqs = [
  _Faq('Why use ThemeExtension?', 'It adds typed custom tokens to ThemeData without overloading ColorScheme or ad-hoc constants.'),
  _Faq('What methods are mandatory?', 'Implement copyWith and lerp so custom tokens can update and interpolate safely.'),
  _Faq('Can multiple extensions coexist?', 'Yes. This demo uses BrandTokens, StatusTokens, ScaleTokens, and BadgeTokens together.'),
  _Faq('How should interpolation be tested?', 'Blend two themes and inspect extension values plus widget behavior at several t checkpoints.'),
];

const List<String> _guide = [
  'ThemeExtension enables custom, strongly-typed design tokens in ThemeData.',
  'Keep extension classes immutable and small; group related values intentionally.',
  'Implement copyWith and lerp for smooth theme transitions and predictable updates.',
  'Use extension<T>() reads in widgets instead of global constants for consistency.',
  'Validate both static appearance and interpolation behavior between token sets.',
  'Status, spacing, and badge semantics are common extension categories in larger apps.',
  'Custom tokens should complement ColorScheme, not duplicate every built-in value.',
  'Use diagnostics boards to inspect extension values while scrubbing interpolation.',
];

dynamic build(BuildContext context) {
  var beginIndex = 0;
  var endIndex = 1;
  var scenarioIndex = 0;
  var boardIndex = 0;
  var t = 0.38;
  var autoPlay = false;
  var denseMode = false;
  var showDiagnostics = true;
  var iconBadges = true;
  var emphasisMode = false;
  var cardScale = 1.0;
  var interpolationSpeed = 1.0;
  var interactionCount = 0;
  var tick = 0;
  final log = <String>[];

  void addLog(String message) {
    final now = DateTime.now();
    final prefix =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    log.insert(0, '$prefix $message');
    if (log.length > 24) {
      log.removeRange(24, log.length);
    }
  }

  debugPrint('ThemeExtension deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      if (autoPlay) {
        final next = t + (0.006 * interpolationSpeed);
        t = next > 1.0 ? 0.0 : next;
      }

      final begin = _recipes[beginIndex];
      final end = _recipes[endIndex];
      final scenario = _scenarios[scenarioIndex];

      final beginTheme = _buildTheme(begin, denseMode: denseMode, emphasisMode: emphasisMode);
      final endTheme = _buildTheme(end, denseMode: denseMode, emphasisMode: emphasisMode);
      final tween = ThemeDataTween(begin: beginTheme, end: endTheme);
      final current = tween.lerp(t);

      return Theme(
        data: current,
        child: Container(
          color: current.colorScheme.surface,
          child: Column(
            children: [
              _topHeader(current, begin, end, scenario, t, interactionCount, tick),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _leftControls(
                      theme: current,
                      beginIndex: beginIndex,
                      endIndex: endIndex,
                      scenarioIndex: scenarioIndex,
                      boardIndex: boardIndex,
                      t: t,
                      autoPlay: autoPlay,
                      denseMode: denseMode,
                      showDiagnostics: showDiagnostics,
                      iconBadges: iconBadges,
                      emphasisMode: emphasisMode,
                      cardScale: cardScale,
                      interpolationSpeed: interpolationSpeed,
                      onBegin: (value) {
                        setState(() {
                          beginIndex = value;
                          tick += 1;
                          addLog('Begin recipe: ${_recipes[value].title}.');
                        });
                      },
                      onEnd: (value) {
                        setState(() {
                          endIndex = value;
                          tick += 1;
                          addLog('End recipe: ${_recipes[value].title}.');
                        });
                      },
                      onScenario: (value) {
                        setState(() {
                          scenarioIndex = value;
                          tick += 1;
                          addLog('Scenario: ${_scenarios[value].title}.');
                        });
                      },
                      onBoard: (value) {
                        setState(() {
                          boardIndex = value;
                          tick += 1;
                          addLog('Board: ${_boardName(value)}.');
                        });
                      },
                      onT: (value) {
                        setState(() {
                          t = value;
                          tick += 1;
                        });
                      },
                      onAutoPlay: (value) {
                        setState(() {
                          autoPlay = value;
                          tick += 1;
                          addLog('Auto-play ${value ? 'on' : 'off'}.');
                        });
                      },
                      onDense: (value) {
                        setState(() {
                          denseMode = value;
                          tick += 1;
                          addLog('Dense mode ${value ? 'on' : 'off'}.');
                        });
                      },
                      onDiagnostics: (value) {
                        setState(() {
                          showDiagnostics = value;
                          tick += 1;
                          addLog('Diagnostics ${value ? 'shown' : 'hidden'}.');
                        });
                      },
                      onIconBadges: (value) {
                        setState(() {
                          iconBadges = value;
                          tick += 1;
                          addLog('Badge icons ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onEmphasis: (value) {
                        setState(() {
                          emphasisMode = value;
                          tick += 1;
                          addLog('Emphasis mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onScale: (value) {
                        setState(() {
                          cardScale = value;
                          tick += 1;
                        });
                      },
                      onSpeed: (value) {
                        setState(() {
                          interpolationSpeed = value;
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
                              current.colorScheme.surface,
                              current.colorScheme.surfaceContainerHighest.withAlpha(156),
                              current.colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: current.colorScheme.outlineVariant.withAlpha(130)),
                        ),
                        child: AnimatedScale(
                          scale: cardScale,
                          duration: Duration(milliseconds: 220),
                          alignment: Alignment.topCenter,
                          child: _board(
                            boardIndex: boardIndex,
                            current: current,
                            beginTheme: beginTheme,
                            endTheme: endTheme,
                            tween: tween,
                            scenario: scenario,
                            t: t,
                            showDiagnostics: showDiagnostics,
                            iconBadges: iconBadges,
                            interactionCount: interactionCount,
                            tick: tick,
                            log: log,
                            onAction: (label) {
                              setState(() {
                                interactionCount += 1;
                                tick += 1;
                                addLog('Action: $label');
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

ThemeData _buildTheme(_Recipe recipe, {required bool denseMode, required bool emphasisMode}) {
  final scheme = ColorScheme.fromSeed(seedColor: recipe.seed, brightness: recipe.brightness);
  final base = ThemeData(useMaterial3: true, colorScheme: scheme, visualDensity: denseMode ? VisualDensity.compact : VisualDensity.standard);

  final textTheme = emphasisMode
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(recipe.scale.radius)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: recipe.brand.brandSoft.withAlpha(170),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(recipe.scale.radius - 3)),
      isDense: denseMode,
    ),
    extensions: <ThemeExtension<dynamic>>[
      recipe.brand,
      recipe.status,
      recipe.scale,
      recipe.badge,
    ],
  );
}

String _boardName(int index) {
  const names = [
    'Extension Gallery',
    'Lerp Matrix',
    'Component Scene',
    'Shell + Status',
    'Guide + Timeline',
  ];
  if (index < 0 || index >= names.length) {
    return names[0];
  }
  return names[index];
}

BrandTokens _brand(ThemeData theme) => theme.extension<BrandTokens>()!;
StatusTokens _status(ThemeData theme) => theme.extension<StatusTokens>()!;
ScaleTokens _scale(ThemeData theme) => theme.extension<ScaleTokens>()!;
BadgeTokens _badge(ThemeData theme) => theme.extension<BadgeTokens>()!;

Widget _topHeader(
  ThemeData theme,
  _Recipe begin,
  _Recipe end,
  _Scenario scenario,
  double t,
  int interactions,
  int tick,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _brand(theme).brandSoft.withAlpha(210),
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
            border: Border.all(color: _brand(theme).brand.withAlpha(180)),
          ),
          child: CustomPaint(
            painter: _TokenPainter(
              a: _brand(theme).brand,
              b: _status(theme).info,
              seed: tick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ThemeExtension Lab', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'begin: ${begin.title}  end: ${end.title}  t=${t.toStringAsFixed(2)}  interactions: $interactions',
                style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(scenario.description, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(170))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _leftControls({
  required ThemeData theme,
  required int beginIndex,
  required int endIndex,
  required int scenarioIndex,
  required int boardIndex,
  required double t,
  required bool autoPlay,
  required bool denseMode,
  required bool showDiagnostics,
  required bool iconBadges,
  required bool emphasisMode,
  required double cardScale,
  required double interpolationSpeed,
  required ValueChanged<int> onBegin,
  required ValueChanged<int> onEnd,
  required ValueChanged<int> onScenario,
  required ValueChanged<int> onBoard,
  required ValueChanged<double> onT,
  required ValueChanged<bool> onAutoPlay,
  required ValueChanged<bool> onDense,
  required ValueChanged<bool> onDiagnostics,
  required ValueChanged<bool> onIconBadges,
  required ValueChanged<bool> onEmphasis,
  required ValueChanged<double> onScale,
  required ValueChanged<double> onSpeed,
}) {
  return Container(
    width: 372,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.surfaceContainerHighest.withAlpha(125),
          theme.colorScheme.surfaceContainer.withAlpha(95),
          theme.colorScheme.surfaceContainerLow.withAlpha(82),
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
          Text('Extension Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Blend recipes, inspect extension values, and test component impact.'),
          SizedBox(height: 10),
          _dd('Begin Recipe', beginIndex, _recipes.map((e) => e.title).toList(), onBegin),
          _dd('End Recipe', endIndex, _recipes.map((e) => e.title).toList(), onEnd),
          _dd('Scenario', scenarioIndex, _scenarios.map((e) => e.title).toList(), onScenario),
          _dd('Board', boardIndex, List.generate(5, _boardName), onBoard),
          _sl('Interpolation t', t, 0, 1, onT),
          _sw('Auto-play', 'Animate extension interpolation continuously', autoPlay, onAutoPlay),
          _sw('Dense mode', 'Compact density for controls and cards', denseMode, onDense),
          _sw('Show diagnostics', 'Display extension token diagnostics panels', showDiagnostics, onDiagnostics),
          _sw('Icon badges', 'Render icons inside badge chips', iconBadges, onIconBadges),
          _sw('Typography emphasis', 'Strengthen hierarchy with heavier titles', emphasisMode, onEmphasis),
          _sl('Content scale', cardScale, 0.9, 1.12, onScale),
          _sl('Interpolation speed', interpolationSpeed, 0.5, 2.0, onSpeed),
        ],
      ),
    ),
  );
}

Widget _dd(String label, int value, List<String> options, ValueChanged<int> onChanged) {
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

Widget _sw(String t, String s, bool v, ValueChanged<bool> onChanged) {
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
            Expanded(child: Text(t, style: TextStyle(fontWeight: FontWeight.w700))),
            Switch(value: v, onChanged: onChanged),
          ],
        ),
        Text(s, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(160))),
      ],
    ),
  );
}

Widget _sl(String label, double value, double min, double max, ValueChanged<double> onChanged) {
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
  required ThemeData current,
  required ThemeData beginTheme,
  required ThemeData endTheme,
  required ThemeDataTween tween,
  required _Scenario scenario,
  required double t,
  required bool showDiagnostics,
  required bool iconBadges,
  required int interactionCount,
  required int tick,
  required List<String> log,
  required ValueChanged<String> onAction,
}) {
  switch (boardIndex) {
    case 0:
      return _galleryBoard(current, beginTheme, endTheme, tween, t, showDiagnostics, onAction);
    case 1:
      return _matrixBoard(current, beginTheme, endTheme, tween, t);
    case 2:
      return _componentBoard(current, scenario, iconBadges, onAction);
    case 3:
      return _shellBoard(current, iconBadges, onAction);
    default:
      return _guideBoard(current, interactionCount, tick, log);
  }
}

Widget _galleryBoard(
  ThemeData current,
  ThemeData beginTheme,
  ThemeData endTheme,
  ThemeDataTween tween,
  double t,
  bool showDiagnostics,
  ValueChanged<String> onAction,
) {
  final marks = [0.0, 0.25, 0.5, 0.75, 1.0];
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Extension Gallery', 'Visual snapshots at key interpolation checkpoints.', 't=${t.toStringAsFixed(2)}'),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final m in marks)
              _galleryCard(
                theme: tween.lerp(m),
                label: 't=${m.toStringAsFixed(2)}',
                onAction: () => onAction('gallery-${m.toStringAsFixed(2)}'),
              ),
          ],
        ),
        SizedBox(height: 10),
        if (showDiagnostics)
          _diagnostics(
            current,
            'Extension diagnostics',
            [
              'brand: ${_hex(_brand(current).brand)}',
              'brandSoft: ${_hex(_brand(current).brandSoft)}',
              'status.success: ${_hex(_status(current).success)}',
              'badge.bg: ${_hex(_badge(current).bg)}',
              'scale.compact: ${_scale(current).compact.toStringAsFixed(1)}',
            ],
          ),
      ],
    ),
  );
}

Widget _galleryCard({required ThemeData theme, required String label, required VoidCallback onAction}) {
  return Theme(
    data: theme,
    child: Container(
      width: 250,
      padding: EdgeInsets.all(_scale(theme).comfortable),
      decoration: BoxDecoration(
        color: _brand(theme).shell.withAlpha(180),
        borderRadius: BorderRadius.circular(_scale(theme).radius),
        border: Border.all(color: _badge(theme).border.withAlpha(160)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Row(
            children: [
              FilledButton(onPressed: onAction, child: Text('Action')),
              SizedBox(width: 6),
              Chip(label: Text('Badge'), side: BorderSide(color: _badge(theme).border)),
            ],
          ),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Extension input')),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(_scale(theme).compact + 2),
            decoration: BoxDecoration(
              color: _brand(theme).brandSoft,
              borderRadius: BorderRadius.circular(_scale(theme).radius - 4),
            ),
            child: Text('Custom shell surface with extension tokens'),
          ),
        ],
      ),
    ),
  );
}

Widget _matrixBoard(ThemeData current, ThemeData beginTheme, ThemeData endTheme, ThemeDataTween tween, double t) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Lerp Matrix', 'Compare begin/end/current extension values.', 'matrix'),
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
              _rowColor('brand', _brand(beginTheme).brand, _brand(endTheme).brand, _brand(current).brand),
              _rowColor('brandSoft', _brand(beginTheme).brandSoft, _brand(endTheme).brandSoft, _brand(current).brandSoft),
              _rowColor('status.success', _status(beginTheme).success, _status(endTheme).success, _status(current).success),
              _rowColor('status.warning', _status(beginTheme).warning, _status(endTheme).warning, _status(current).warning),
              _rowColor('badge.bg', _badge(beginTheme).bg, _badge(endTheme).bg, _badge(current).bg),
              _rowDouble('scale.compact', _scale(beginTheme).compact, _scale(endTheme).compact, _scale(current).compact, t),
              _rowDouble('scale.radius', _scale(beginTheme).radius, _scale(endTheme).radius, _scale(current).radius, t),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _rowColor(String label, Color begin, Color end, Color current) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        SizedBox(width: 130, child: Text(label, style: TextStyle(fontWeight: FontWeight.w700))),
        _swatch(begin),
        SizedBox(width: 8),
        _swatch(end),
        SizedBox(width: 8),
        _swatch(current),
        SizedBox(width: 10),
        Expanded(child: Text('b ${_hex(begin)}  e ${_hex(end)}  c ${_hex(current)}')),
      ],
    ),
  );
}

Widget _rowDouble(String label, double begin, double end, double current, double t) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        SizedBox(width: 130, child: Text(label, style: TextStyle(fontWeight: FontWeight.w700))),
        Expanded(
          child: Text('begin=${begin.toStringAsFixed(2)}  end=${end.toStringAsFixed(2)}  current=${current.toStringAsFixed(2)}  t=${t.toStringAsFixed(2)}'),
        ),
      ],
    ),
  );
}

Widget _componentBoard(ThemeData current, _Scenario scenario, bool iconBadges, ValueChanged<String> onAction) {
  final statuses = [
    ('Healthy', _status(current).success),
    ('Warning', _status(current).warning),
    ('Error', _status(current).error),
    ('Info', _status(current).info),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Component Scene', scenario.description, scenario.title),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(_scale(current).comfortable),
          decoration: BoxDecoration(
            color: _brand(current).shell.withAlpha(180),
            borderRadius: BorderRadius.circular(_scale(current).radius),
            border: Border.all(color: _badge(current).border.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Filter dataset',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: _scale(current).compact),
                  FilledButton.icon(
                    onPressed: () => onAction('refresh-components'),
                    icon: Icon(Icons.refresh),
                    label: Text('Refresh'),
                  ),
                ],
              ),
              SizedBox(height: _scale(current).comfortable),
              Wrap(
                spacing: _scale(current).compact,
                runSpacing: _scale(current).compact,
                children: [
                  for (final s in statuses)
                    _statusBadge(
                      theme: current,
                      label: s.$1,
                      color: s.$2,
                      iconBadges: iconBadges,
                    ),
                ],
              ),
              SizedBox(height: _scale(current).comfortable),
              Wrap(
                spacing: _scale(current).comfortable,
                runSpacing: _scale(current).comfortable,
                children: [
                  for (final metric in [
                    ('Active Jobs', '42'),
                    ('Pending Tasks', '18'),
                    ('Latency', '82ms'),
                    ('Error Rate', '0.7%'),
                  ])
                    SizedBox(
                      width: 250,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(_scale(current).comfortable),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(metric.$1, style: TextStyle(fontWeight: FontWeight.w700)),
                              SizedBox(height: _scale(current).compact),
                              Text(metric.$2, style: current.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                              SizedBox(height: _scale(current).compact),
                              OutlinedButton(
                                onPressed: () => onAction('open-${metric.$1}'),
                                child: Text('Inspect'),
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

Widget _statusBadge({required ThemeData theme, required String label, required Color color, required bool iconBadges}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: _scale(theme).comfortable, vertical: _scale(theme).compact),
    decoration: BoxDecoration(
      color: color.withAlpha(36),
      borderRadius: BorderRadius.circular(_scale(theme).radius - 4),
      border: Border.all(color: color.withAlpha(180)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconBadges) ...[
          Icon(Icons.circle, size: 9, color: color),
          SizedBox(width: 6),
        ],
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

Widget _shellBoard(ThemeData current, bool iconBadges, ValueChanged<String> onAction) {
  final nav = [
    ('Overview', Icons.dashboard_outlined),
    ('Streams', Icons.timeline),
    ('Alerts', Icons.notifications_active_outlined),
    ('Settings', Icons.settings_outlined),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Shell + Status', 'Extension tokens applied in app frame and nav context.', 'shell'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 470,
          decoration: BoxDecoration(
            color: _brand(current).shell.withAlpha(170),
            borderRadius: BorderRadius.circular(_scale(current).radius),
            border: Border.all(color: _badge(current).border.withAlpha(130)),
          ),
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: 1,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final n in nav)
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
                      title: Text('Extension-powered Shell'),
                      actions: [
                        IconButton(onPressed: () => onAction('search-shell'), icon: Icon(Icons.search)),
                        IconButton(onPressed: () => onAction('alerts-shell'), icon: Icon(Icons.notifications_none)),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(_scale(current).comfortable),
                        children: [
                          Card(
                            child: ListTile(
                              title: Text('Service health stream'),
                              subtitle: Text('Observe shell surfaces and controls while extension tokens interpolate.'),
                              trailing: FilledButton(onPressed: () => onAction('open-stream'), child: Text('Open')),
                            ),
                          ),
                          SizedBox(height: _scale(current).comfortable),
                          Wrap(
                            spacing: _scale(current).compact,
                            runSpacing: _scale(current).compact,
                            children: [
                              _statusBadge(theme: current, label: 'Healthy', color: _status(current).success, iconBadges: iconBadges),
                              _statusBadge(theme: current, label: 'Warning', color: _status(current).warning, iconBadges: iconBadges),
                              _statusBadge(theme: current, label: 'Error', color: _status(current).error, iconBadges: iconBadges),
                            ],
                          ),
                          SizedBox(height: _scale(current).comfortable),
                          Row(
                            children: [
                              Expanded(child: TextField(decoration: InputDecoration(labelText: 'Quick command'))),
                              SizedBox(width: _scale(current).compact),
                              FilledButton.tonal(onPressed: () => onAction('run-shell'), child: Text('Run')),
                            ],
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

Widget _guideBoard(ThemeData current, int interactionCount, int tick, List<String> log) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _section(current, 'Guide + Timeline', 'How to implement and validate ThemeExtension usage.', 'guide'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: current.colorScheme.tertiaryContainer.withAlpha(108),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.tertiary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ThemeExtension guidance', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              for (final g in _guide) _bullet(g),
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
            color: current.colorScheme.primaryContainer.withAlpha(102),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: current.colorScheme.primary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interaction timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              SizedBox(height: 8),
              Text('Interactions: $interactionCount  |  Ticks: $tick'),
              SizedBox(height: 8),
              if (log.isEmpty)
                Text('No events yet. Interact with controls and boards to populate timeline.')
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
          color: _brand(theme).brandSoft,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _badge(theme).border.withAlpha(150)),
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
      color: _brand(theme).brandSoft.withAlpha(166),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _badge(theme).border.withAlpha(140)),
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

Widget _swatch(Color c) {
  return Container(
    width: 30,
    height: 20,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.black.withAlpha(50)),
    ),
  );
}

String _hex(Color color) {
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

class _TokenPainter extends CustomPainter {
  _TokenPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed.toInt() + 71);
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.34 + rnd.nextDouble() * 0.56);
      final y = 8 + i * 8.2;
      paint.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(8, y, w, 5.3),
          Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TokenPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}
