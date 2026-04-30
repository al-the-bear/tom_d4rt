// Deep visual demo: IconThemeData — the immutable description of icon styling
// used by the Material framework. An IconThemeData bundles size, fill, weight,
// grade, opticalSize, color, opacity, shadows and applyTextScaling; it flows
// down the widget tree through the IconTheme inherited widget and is read by
// every Icon that does not override the field locally.
//
// Constructor signature (simplified):
//   IconThemeData({
//     double? size,
//     double? fill,                  // 0.0..1.0 for variable fonts
//     double? weight,                // 100..700 (some families up to 900)
//     double? grade,                 // -25, 0, 200 — visual weight adjustment
//     double? opticalSize,           // 20, 24, 40, 48 — stroke tuning
//     Color? color,
//     double? opacity,               // deprecated — bake alpha into color
//     List<Shadow>? shadows,
//     bool? applyTextScaling,
//   })
//
// This demo is deliberately stateless. Interactive surfaces are powered by
// top-level ValueNotifiers plus ValueListenableBuilder so the overall tree
// remains composed of StatelessWidgets only. It runs under the
// tom_d4rt_flutter_ast harness.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers. Stateless widgets use ValueListenableBuilder to
// subscribe to these. The notifiers are declared at the top of the file so
// their initial values are visible next to their documentation.
// ---------------------------------------------------------------------------

/// Drives the playground size slider (section 2).
final ValueNotifier<double> kPgSize = ValueNotifier<double>(40.0);

/// Drives the playground weight slider (section 2). Capped to the 100..700
/// range exposed by IconThemeData.
final ValueNotifier<double> kPgWeight = ValueNotifier<double>(400.0);

/// Drives the playground fill slider (0.0..1.0) (section 2).
final ValueNotifier<double> kPgFill = ValueNotifier<double>(0.0);

/// Drives the playground grade slider (section 2). Typical values are -25,
/// 0 and 200 although the range is continuous.
final ValueNotifier<double> kPgGrade = ValueNotifier<double>(0.0);

/// Drives the playground opticalSize slider (section 2). Common values are
/// 20, 24, 40 and 48.
final ValueNotifier<double> kPgOpticalSize = ValueNotifier<double>(24.0);

/// Drives the playground color choice (section 2).
final ValueNotifier<Color> kPgColor =
    ValueNotifier<Color>(const Color(0xFF6750A4));

/// Drives the lerp slider (section 7).
final ValueNotifier<double> kLerpT = ValueNotifier<double>(0.5);

/// Drives the active use-case highlight (section 9).
final ValueNotifier<int> kUseCaseHighlight = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Constants.
// ---------------------------------------------------------------------------

const Color _seedColor = Color(0xFF5B4CCB);

const List<_WeightStop> _weightStops = <_WeightStop>[
  _WeightStop(100, 'Thin 100', 'hairline — ideal for decorative chrome'),
  _WeightStop(300, 'Light 300', 'subtle — good for backgrounds'),
  _WeightStop(500, 'Medium 500', 'balanced — the default body icon weight'),
  _WeightStop(700, 'Bold 700', 'assertive — primary actions and CTAs'),
  _WeightStop(900, 'Black 900', 'extra bold — capped by font support'),
];

const List<_ColorChoice> _pgColors = <_ColorChoice>[
  _ColorChoice(Color(0xFF6750A4), 'Primary 674'),
  _ColorChoice(Color(0xFFB3261E), 'Error 322'),
  _ColorChoice(Color(0xFF2E7D32), 'Forest 737'),
  _ColorChoice(Color(0xFF1565C0), 'Ocean 15C'),
  _ColorChoice(Color(0xFFEF6C00), 'Sunset EF6'),
  _ColorChoice(Color(0xFF00838F), 'Teal 008'),
  _ColorChoice(Color(0xFF7B1FA2), 'Royal 7B1'),
  _ColorChoice(Color(0xFF455A64), 'Slate 455'),
];

const List<IconData> _pgIcons = <IconData>[
  Icons.home,
  Icons.favorite,
  Icons.star,
  Icons.settings,
  Icons.bolt,
  Icons.search,
];

const List<_ShadowRecipe> _shadowRecipes = <_ShadowRecipe>[
  _ShadowRecipe(
    'Soft Drop',
    'Classic material elevation. Small blur, tight offset, low alpha.',
    <Shadow>[
      Shadow(
        color: Color(0x40000000),
        blurRadius: 6.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  ),
  _ShadowRecipe(
    'Hard Offset',
    'No blur, long offset. Feels like a stamped sticker.',
    <Shadow>[
      Shadow(
        color: Color(0xFF1A1A1A),
        blurRadius: 0.0,
        offset: Offset(3.0, 3.0),
      ),
    ],
  ),
  _ShadowRecipe(
    'Double Glow',
    'Two overlapping shadows — inner and outer — simulate neon glow.',
    <Shadow>[
      Shadow(
        color: Color(0x80FFD54F),
        blurRadius: 4.0,
        offset: Offset.zero,
      ),
      Shadow(
        color: Color(0x66FF8F00),
        blurRadius: 14.0,
        offset: Offset.zero,
      ),
    ],
  ),
  _ShadowRecipe(
    'Directional',
    'Strong diagonal shadow suggesting a consistent light source.',
    <Shadow>[
      Shadow(
        color: Color(0x66000000),
        blurRadius: 10.0,
        offset: Offset(5.0, 7.0),
      ),
      Shadow(
        color: Color(0x20FFFFFF),
        blurRadius: 2.0,
        offset: Offset(-1.0, -1.0),
      ),
    ],
  ),
];

const List<Color> _matrixColors = <Color>[
  Color(0xFF6750A4),
  Color(0xFFB3261E),
  Color(0xFF1B5E20),
  Color(0xFF0D47A1),
];

const List<double> _matrixAlphas = <double>[0.35, 0.65, 1.0];

const List<_UseCase> _useCases = <_UseCase>[
  _UseCase(
    'Dark-mode contrast',
    'High-luminance icon on near-black surface for AMOLED-friendly UI.',
    Color(0xFF0B0B0D),
    Color(0xFFF5F5F5),
    Icons.dark_mode,
  ),
  _UseCase(
    'Brand accent',
    'Icon in brand hue with matching subtle glow shadow.',
    Color(0xFFFFF4E5),
    Color(0xFFFF7043),
    Icons.local_fire_department,
  ),
  _UseCase(
    'Action bar',
    'Uniform 22pt icons, medium weight, muted color for toolbar legibility.',
    Color(0xFFF4F1FF),
    Color(0xFF4A3E8A),
    Icons.edit_note,
  ),
  _UseCase(
    'Disabled state',
    'Reduced-alpha color encodes the disabled affordance without opacity.',
    Color(0xFFF5F5F5),
    Color(0x66000000),
    Icons.block,
  ),
  _UseCase(
    'Elevated card',
    'Large icon with soft drop shadow to align with the card elevation cue.',
    Color(0xFFFFFFFF),
    Color(0xFF1565C0),
    Icons.insights,
  ),
  _UseCase(
    'Compact vs expanded',
    'Adaptive sizing — 18pt on dense rows, 32pt on spacious hero cards.',
    Color(0xFFFAFAFA),
    Color(0xFF2E7D32),
    Icons.zoom_in_map,
  ),
];

const List<_CheatRow> _cheatSheet = <_CheatRow>[
  _CheatRow('size', 'double?', 'Logical pixel square for the glyph box.'),
  _CheatRow('fill', 'double? (0..1)',
      '0 = outlined, 1 = filled. Variable-font axis.'),
  _CheatRow('weight', 'double? (100..700)',
      'Stroke thickness axis. 400 ~ regular, 700 ~ bold.'),
  _CheatRow(
      'grade', 'double? (-25..0..200)', 'Finer weight tuning without resize.'),
  _CheatRow('opticalSize', 'double? (20/24/40/48)',
      'Stroke compensates for rendered size.'),
  _CheatRow('color', 'Color?', 'Applied as foreground; alpha encodes opacity.'),
  _CheatRow('opacity', 'double? (deprecated)',
      'Use color alpha channel instead.'),
  _CheatRow('shadows', 'List<Shadow>?',
      'List of drop shadows painted beneath the glyph.'),
  _CheatRow('applyTextScaling', 'bool?',
      'Scale size with MediaQuery.textScaler when true.'),
];

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    useMaterial3: true,
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'IconThemeData Deep Demo',
    theme: theme,
    home: const _IconThemeDataHome(),
  );
}

// ---------------------------------------------------------------------------
// Home scaffold — DefaultTabController drives a 9-tab structure.
// ---------------------------------------------------------------------------

class _IconThemeDataHome extends StatelessWidget {
  const _IconThemeDataHome();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero', icon: Icon(Icons.waves)),
    Tab(text: 'Playground', icon: Icon(Icons.tune)),
    Tab(text: 'Weight', icon: Icon(Icons.line_weight)),
    Tab(text: 'Shadows', icon: Icon(Icons.blur_on)),
    Tab(text: 'Color', icon: Icon(Icons.palette)),
    Tab(text: 'Inherit', icon: Icon(Icons.account_tree)),
    Tab(text: 'Ops', icon: Icon(Icons.merge)),
    Tab(text: 'Scaling', icon: Icon(Icons.text_fields)),
    Tab(text: 'Cases', icon: Icon(Icons.style)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IconThemeData Deep Demo'),
          bottom: const TabBar(tabs: _tabs, isScrollable: true),
        ),
        body: const TabBarView(
          children: <Widget>[
            _SectionHero(),
            _SectionPlayground(),
            _SectionWeightGallery(),
            _SectionShadowShowcase(),
            _SectionColorMatrix(),
            _SectionInheritance(),
            _SectionOps(),
            _SectionScaling(),
            _SectionUseCases(),
          ],
        ),
        bottomNavigationBar: const _BottomCheatSheet(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Hero banner.
// ---------------------------------------------------------------------------

class _SectionHero extends StatelessWidget {
  const _SectionHero();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  scheme.primary,
                  scheme.tertiary,
                  scheme.secondary,
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: const _HeroContent(),
          ),
        ),
        const SizedBox(height: 16),
        const _HeroInheritExplainer(),
        const SizedBox(height: 16),
        const _HeroQuickFacts(),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent();

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(
        color: Colors.white,
        size: 36,
        shadows: <Shadow>[
          Shadow(
            color: Color(0x66000000),
            blurRadius: 8.0,
            offset: Offset(2.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.auto_awesome),
              SizedBox(width: 12),
              Icon(Icons.brush),
              SizedBox(width: 12),
              Icon(Icons.palette),
              SizedBox(width: 12),
              Icon(Icons.format_paint),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'IconThemeData',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Immutable icon styling that flows down the widget tree.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Every Icon under an IconTheme reads size, weight, fill, grade, '
            'opticalSize, color, shadows and applyTextScaling from the '
            'nearest ancestor unless overridden locally.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _HeroInheritExplainer extends StatelessWidget {
  const _HeroInheritExplainer();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.account_tree, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'How IconTheme inheritance works',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'IconTheme is an InheritedWidget. Its data is read by any Icon '
              'via IconTheme.of(context). When you nest multiple IconTheme '
              'widgets, each layer merges its data with the ancestor — the '
              'nearest non-null field wins and the rest cascade through.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 12),
            const _InheritChain(),
          ],
        ),
      ),
    );
  }
}

class _InheritChain extends StatelessWidget {
  const _InheritChain();

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(color: Colors.black87, size: 28),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _ChainRow('root', Icon(Icons.folder), 'black87, 28pt'),
            const SizedBox(height: 6),
            IconTheme(
              data: const IconThemeData(color: Colors.blue),
              child: const _ChainRow(
                  'section', Icon(Icons.folder_open), 'blue, 28pt (size inherited)'),
            ),
            const SizedBox(height: 6),
            IconTheme(
              data: const IconThemeData(color: Colors.deepOrange, size: 36),
              child: const _ChainRow('leaf', Icon(Icons.star),
                  'deepOrange, 36pt (fully local)'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChainRow extends StatelessWidget {
  const _ChainRow(this.label, this.icon, this.desc);
  final String label;
  final Widget icon;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 64, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
        SizedBox(width: 40, child: icon),
        const SizedBox(width: 8),
        Expanded(child: Text(desc, style: const TextStyle(fontSize: 12))),
      ],
    );
  }
}

class _HeroQuickFacts extends StatelessWidget {
  const _HeroQuickFacts();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('Quick facts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _FactBullet('Immutable value class — create new instances via copyWith.'),
            _FactBullet('Consumed by Icon, IconButton and every Material icon renderer.'),
            _FactBullet('Supports variable-font axes: fill, weight, grade, opticalSize.'),
            _FactBullet('IconThemeData.fallback() provides the framework defaults.'),
            _FactBullet('IconThemeData.lerp(a, b, t) interpolates numeric fields and color.'),
          ],
        ),
      ),
    );
  }
}

class _FactBullet extends StatelessWidget {
  const _FactBullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.circle, size: 6),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — Field-by-field playground.
// ---------------------------------------------------------------------------

class _SectionPlayground extends StatelessWidget {
  const _SectionPlayground();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        _PlaygroundPreview(),
        SizedBox(height: 16),
        _PlaygroundControls(),
        SizedBox(height: 16),
        _PlaygroundExplainers(),
      ],
    );
  }
}

class _PlaygroundPreview extends StatelessWidget {
  const _PlaygroundPreview();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder<double>(
          valueListenable: kPgSize,
          builder: (_, double size, _) {
            return ValueListenableBuilder<double>(
              valueListenable: kPgWeight,
              builder: (_, double weight, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: kPgFill,
                  builder: (_, double fill, _) {
                    return ValueListenableBuilder<double>(
                      valueListenable: kPgGrade,
                      builder: (_, double grade, _) {
                        return ValueListenableBuilder<double>(
                          valueListenable: kPgOpticalSize,
                          builder: (_, double optical, _) {
                            return ValueListenableBuilder<Color>(
                              valueListenable: kPgColor,
                              builder: (_, Color color, _) {
                                return IconTheme(
                                  data: IconThemeData(
                                    size: size,
                                    weight: weight,
                                    fill: fill,
                                    grade: grade,
                                    opticalSize: optical,
                                    color: color,
                                  ),
                                  child: _PreviewGrid(),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _PreviewGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 14,
      children: _pgIcons.map((IconData i) => Icon(i)).toList(),
    );
  }
}

class _PlaygroundControls extends StatelessWidget {
  const _PlaygroundControls();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Live IconThemeData',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _SliderRow(
              label: 'size',
              notifier: kPgSize,
              min: 16,
              max: 72,
              decimals: 0,
              hint: 'Logical pixel square for each glyph.',
            ),
            _SliderRow(
              label: 'weight',
              notifier: kPgWeight,
              min: 100,
              max: 700,
              decimals: 0,
              hint: 'Variable-font stroke thickness axis.',
            ),
            _SliderRow(
              label: 'fill',
              notifier: kPgFill,
              min: 0,
              max: 1,
              decimals: 2,
              hint: '0 = outlined, 1 = filled (variable font).',
            ),
            _SliderRow(
              label: 'grade',
              notifier: kPgGrade,
              min: -25,
              max: 200,
              decimals: 0,
              hint: 'Finer weight tuning without size change.',
            ),
            _SliderRow(
              label: 'opticalSize',
              notifier: kPgOpticalSize,
              min: 20,
              max: 48,
              decimals: 0,
              hint: 'Stroke compensation for rendered size.',
            ),
            const SizedBox(height: 16),
            const Text('color',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const _ColorRow(),
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.notifier,
    required this.min,
    required this.max,
    required this.decimals,
    required this.hint,
  });

  final String label;
  final ValueNotifier<double> notifier;
  final double min;
  final double max;
  final int decimals;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ValueListenableBuilder<double>(
        valueListenable: notifier,
        builder: (_, double v, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 96,
                    child: Text(label,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    child: Slider(
                      min: min,
                      max: max,
                      value: v,
                      onChanged: (double nv) => notifier.value = nv,
                    ),
                  ),
                  SizedBox(
                    width: 52,
                    child: Text(v.toStringAsFixed(decimals),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontFeatures: <FontFeature>[
                          FontFeature.tabularFigures()
                        ])),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 96),
                child: Text(hint,
                    style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: kPgColor,
      builder: (_, Color current, _) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _pgColors.map((_ColorChoice c) {
            final bool selected = c.color.toARGB32() == current.toARGB32();
            return ChoiceChip(
              label: Text(c.label),
              avatar: CircleAvatar(backgroundColor: c.color, radius: 8),
              selected: selected,
              onSelected: (_) => kPgColor.value = c.color,
            );
          }).toList(),
        );
      },
    );
  }
}

class _PlaygroundExplainers extends StatelessWidget {
  const _PlaygroundExplainers();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Notes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _Note('Variable-font axes only render when the bundled font supports '
                'them. MaterialIcons respects size and color universally, while '
                'weight/fill/grade/opticalSize are honored by the material '
                'symbols variable families (MaterialSymbolsRounded/Outlined/Sharp).'),
            SizedBox(height: 6),
            _Note('IconTheme merges — a child IconTheme with only color set '
                'keeps the ancestor size/weight/fill. Use IconThemeData.merge '
                'to express that intent explicitly.'),
            SizedBox(height: 6),
            _Note('Color alpha is the recommended way to express translucency. '
                'The opacity field is deprecated — see the API cheat sheet.'),
          ],
        ),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.info_outline, size: 16),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12, height: 1.5))),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — Variable-font weight gallery.
// ---------------------------------------------------------------------------

class _SectionWeightGallery extends StatelessWidget {
  const _SectionWeightGallery();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const _WeightIntro(),
        const SizedBox(height: 16),
        for (final _WeightStop stop in _weightStops) ...<Widget>[
          _WeightCard(stop: stop),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 8),
        const _VariableAxesExplainer(),
      ],
    );
  }
}

class _WeightIntro extends StatelessWidget {
  const _WeightIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.line_weight, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('Weight axis',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Variable-font icon families expose a weight axis from 100 '
              '(thin) to 700 (bold). IconThemeData clamps to that range. '
              'The same glyph below is rendered at five weights — only '
              'supported weights will visibly differ.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard({required this.stop});
  final _WeightStop stop;

  @override
  Widget build(BuildContext context) {
    // IconThemeData clamps to 100..700. Anything beyond is silently capped.
    final double clamped = stop.value > 700 ? 700 : stop.value.toDouble();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                weight: clamped,
                size: 56,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Icon(Icons.favorite_border),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(stop.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      if (stop.value > 700)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('capped to 700',
                              style: TextStyle(fontSize: 10)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(stop.description,
                      style: const TextStyle(fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VariableAxesExplainer extends StatelessWidget {
  const _VariableAxesExplainer();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Variable-font behaviors',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _AxisExplain(
              icon: Icons.opacity,
              title: 'fill 0 → 1',
              body:
                  'Morphs between the outlined and filled variant of the same '
                  'glyph when rendered by a variable font such as Material '
                  'Symbols Rounded.',
            ),
            _AxisExplain(
              icon: Icons.swap_vert,
              title: 'grade -25 / 0 / 200',
              body: 'Finer stroke adjustment without touching size or weight. '
                  'Use positive grade on dark backgrounds to improve legibility.',
            ),
            _AxisExplain(
              icon: Icons.zoom_out_map,
              title: 'opticalSize 20 / 24 / 40 / 48',
              body: 'Selects a stroke design optimized for the target size. '
                  'Match opticalSize to the rendered size for sharpest strokes.',
            ),
          ],
        ),
      ),
    );
  }
}

class _AxisExplain extends StatelessWidget {
  const _AxisExplain(
      {required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(body,
                    style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — Shadows showcase.
// ---------------------------------------------------------------------------

class _SectionShadowShowcase extends StatelessWidget {
  const _SectionShadowShowcase();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const _ShadowIntro(),
        const SizedBox(height: 16),
        for (final _ShadowRecipe recipe in _shadowRecipes) ...<Widget>[
          _ShadowCard(recipe: recipe),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 4),
        const _ShadowTips(),
      ],
    );
  }
}

class _ShadowIntro extends StatelessWidget {
  const _ShadowIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.blur_on,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('Shadow list',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'The shadows field accepts a List<Shadow>. Shadows paint beneath '
              'the glyph in order. Color alpha drives softness; blurRadius '
              'creates the fuzz; offset anchors direction.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard({required this.recipe});
  final _ShadowRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(
                  size: 56,
                  color: Theme.of(context).colorScheme.primary,
                  shadows: recipe.shadows,
                ),
                child: const Icon(Icons.bolt),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(recipe.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(recipe.description,
                      style: const TextStyle(fontSize: 12, height: 1.4)),
                  const SizedBox(height: 10),
                  _ShadowDetails(shadows: recipe.shadows),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShadowDetails extends StatelessWidget {
  const _ShadowDetails({required this.shadows});
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < shadows.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '#$i blur=${shadows[i].blurRadius.toStringAsFixed(1)}  '
              'offset=(${shadows[i].offset.dx.toStringAsFixed(1)}, '
              '${shadows[i].offset.dy.toStringAsFixed(1)})',
              style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.black54),
            ),
          ),
      ],
    );
  }
}

class _ShadowTips extends StatelessWidget {
  const _ShadowTips();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tips',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _Note('Keep blurRadius proportional to size — a 6.0 blur on a 24pt '
                'icon feels like a 12.0 blur on a 48pt icon.'),
            _Note('Stack two shadows to simulate ambient + key lighting; pair '
                'a soft large-blur shadow with a small tight shadow.'),
            _Note('For glow effects, use a same-hue shadow with elevated alpha '
                'and a large blur, offset zero.'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — Color + alpha matrix.
// ---------------------------------------------------------------------------

class _SectionColorMatrix extends StatelessWidget {
  const _SectionColorMatrix();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const _ColorMatrixIntro(),
        const SizedBox(height: 16),
        _MatrixGrid(),
        const SizedBox(height: 16),
        const _OpacityExplain(),
      ],
    );
  }
}

class _ColorMatrixIntro extends StatelessWidget {
  const _ColorMatrixIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.palette,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('4 colors × 3 alpha levels',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Encode translucency through the alpha channel of color. The '
              'deprecated opacity field should be avoided — see the note '
              'at the bottom of this section.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MatrixGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            for (final Color base in _matrixColors)
              for (final double alpha in _matrixAlphas)
                _MatrixCell(base: base, alpha: alpha),
          ],
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({required this.base, required this.alpha});
  final Color base;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    final Color applied = base.withAlpha((alpha * 255).round());
    return Container(
      width: 80,
      height: 96,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme(
            data: IconThemeData(color: applied, size: 40),
            child: const Icon(Icons.favorite),
          ),
          const SizedBox(height: 6),
          Text('a=${(alpha * 100).round()}%',
              style: const TextStyle(fontSize: 11)),
          Text('#${applied.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
              style: const TextStyle(fontSize: 9, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _OpacityExplain extends StatelessWidget {
  const _OpacityExplain();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Why not opacity?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _Note('IconThemeData.opacity is deprecated. It existed before Color '
                'supported an alpha channel in the same way; the alpha was '
                'multiplied onto color at paint time.'),
            _Note('Encoding translucency through color alpha composes cleanly '
                'with blend modes, ShaderMask and image filters.'),
            _Note('Opacity also stacks awkwardly under IconTheme merging — two '
                'nested IconThemes with opacity 0.5 do not produce 0.25.'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Inheritance diagram via CustomPainter.
// ---------------------------------------------------------------------------

class _SectionInheritance extends StatelessWidget {
  const _SectionInheritance();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const _InheritIntro(),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 320,
              child: CustomPaint(
                painter: _InheritTreePainter(
                  primary: Theme.of(context).colorScheme.primary,
                  secondary: Theme.of(context).colorScheme.secondary,
                  tertiary: Theme.of(context).colorScheme.tertiary,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _InheritWinners(),
        const SizedBox(height: 16),
        const _LiveNestedIconTheme(),
      ],
    );
  }
}

class _InheritIntro extends StatelessWidget {
  const _InheritIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.account_tree,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('IconTheme inheritance diagram',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'The diagram below visualizes three nested IconTheme widgets. '
              'Each node shows the fields supplied at that depth; the "wins" '
              'column reports the effective IconThemeData read by an Icon at '
              'that depth after merging all ancestors.',
            ),
          ],
        ),
      ),
    );
  }
}

class _InheritTreePainter extends CustomPainter {
  _InheritTreePainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });
  final Color primary;
  final Color secondary;
  final Color tertiary;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final List<_TreeNode> nodes = <_TreeNode>[
      _TreeNode(
        center: Offset(size.width * 0.5, 40),
        radius: 28,
        fill: primary,
        label: 'root\ncolor,size=28',
      ),
      _TreeNode(
        center: Offset(size.width * 0.5, 160),
        radius: 26,
        fill: secondary,
        label: 'section\ncolor only',
      ),
      _TreeNode(
        center: Offset(size.width * 0.5, 270),
        radius: 24,
        fill: tertiary,
        label: 'leaf\nsize=40',
      ),
    ];

    // Connecting lines.
    for (int i = 0; i < nodes.length - 1; i++) {
      final _TreeNode a = nodes[i];
      final _TreeNode b = nodes[i + 1];
      final Offset start = Offset(a.center.dx, a.center.dy + a.radius);
      final Offset end = Offset(b.center.dx, b.center.dy - b.radius);
      canvas.drawLine(start, end, line);

      // Arrowhead.
      const double arrow = 8;
      final Paint arrowPaint = Paint()..color = Colors.black54;
      final Path path = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(end.dx - arrow / 2, end.dy - arrow)
        ..lineTo(end.dx + arrow / 2, end.dy - arrow)
        ..close();
      canvas.drawPath(path, arrowPaint);
    }

    // Side labels.
    const List<String> sideLabels = <String>[
      'supplies: color=P, size=28',
      'supplies: color=S (size inherited)',
      'supplies: size=40 (color inherited)',
    ];
    for (int i = 0; i < nodes.length; i++) {
      final _TreeNode n = nodes[i];
      _drawLabel(canvas, n.center, n.radius, n.label, n.fill);
      final TextPainter side = TextPainter(
        text: TextSpan(
          text: sideLabels[i],
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
      )..layout(maxWidth: size.width * 0.4);
      side.paint(canvas, Offset(n.center.dx + n.radius + 16,
          n.center.dy - side.height / 2));
    }

    // "Wins" column title.
    final TextPainter winsTitle = TextPainter(
      text: const TextSpan(
          text: 'effective',
          style: TextStyle(fontSize: 10, color: Colors.black45)),
      textDirection: TextDirection.ltr,
    )..layout();
    winsTitle.paint(canvas, Offset(8, 4));

    const List<String> wins = <String>[
      'color=P, size=28',
      'color=S, size=28',
      'color=S, size=40',
    ];
    for (int i = 0; i < nodes.length; i++) {
      final _TreeNode n = nodes[i];
      final TextPainter w = TextPainter(
        text: TextSpan(
            text: wins[i],
            style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 120);
      w.paint(canvas, Offset(8, n.center.dy - w.height / 2));
    }
  }

  void _drawLabel(
      Canvas canvas, Offset c, double r, String label, Color fill) {
    final Paint p = Paint()..color = fill;
    canvas.drawCircle(c, r, p);
    canvas.drawCircle(c, r,
        Paint()..color = Colors.white..strokeWidth = 2..style = PaintingStyle.stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
          text: label,
          style: const TextStyle(
              fontSize: 10, color: Colors.white, height: 1.1)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: r * 2.4);
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _InheritTreePainter old) =>
      old.primary != primary ||
      old.secondary != secondary ||
      old.tertiary != tertiary;
}

class _TreeNode {
  _TreeNode({
    required this.center,
    required this.radius,
    required this.fill,
    required this.label,
  });
  final Offset center;
  final double radius;
  final Color fill;
  final String label;
}

class _InheritWinners extends StatelessWidget {
  const _InheritWinners();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Who wins?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _Note('For every field, the nearest ancestor with a non-null value '
                'wins. Fields unset at the current depth fall through.'),
            _Note('IconThemeData.merge(other) replaces any field set on other, '
                'keeping the rest from this.'),
            _Note('Use IconThemeData.fallback() as the outermost base to '
                'guarantee no field is null when paint runs.'),
          ],
        ),
      ),
    );
  }
}

class _LiveNestedIconTheme extends StatelessWidget {
  const _LiveNestedIconTheme();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Live nested preview',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            IconTheme(
              data: const IconThemeData(color: Colors.deepPurple, size: 28),
              child: _NestedRow(
                label: 'root — purple 28',
                child: IconTheme(
                  data: const IconThemeData(color: Colors.teal),
                  child: _NestedRow(
                    label: 'section — teal (size inherited)',
                    child: IconTheme(
                      data: const IconThemeData(size: 40),
                      child: _NestedRow(
                        label: 'leaf — size 40 (color inherited)',
                        child: const Icon(Icons.bolt),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NestedRow extends StatelessWidget {
  const _NestedRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          const Icon(Icons.subdirectory_arrow_right, size: 18),
          const SizedBox(width: 6),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          const SizedBox(width: 12),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — copyWith / merge / lerp.
// ---------------------------------------------------------------------------

class _SectionOps extends StatelessWidget {
  const _SectionOps();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        _OpsIntro(),
        SizedBox(height: 16),
        _CopyWithPanel(),
        SizedBox(height: 12),
        _MergePanel(),
        SizedBox(height: 12),
        _LerpPanel(),
      ],
    );
  }
}

class _OpsIntro extends StatelessWidget {
  const _OpsIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.merge,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('copyWith · merge · lerp',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Three composition operators of IconThemeData. copyWith replaces '
              'only the given fields; merge layers another IconThemeData on top '
              '(other-wins for non-null fields); lerp interpolates numeric '
              'fields and color between two themes by t.',
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyWithPanel extends StatelessWidget {
  const _CopyWithPanel();

  @override
  Widget build(BuildContext context) {
    const IconThemeData base = IconThemeData(
      size: 40,
      color: Color(0xFF6750A4),
      weight: 400,
    );
    final IconThemeData derived = base.copyWith(color: const Color(0xFFB3261E));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _OpTitle('copyWith'),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                _OpColumn(
                  label: 'base',
                  code: 'IconThemeData(\n  size: 40,\n  color: 0xFF6750A4,\n  weight: 400,\n)',
                  data: base,
                ),
                const SizedBox(width: 16),
                _OpColumn(
                  label: 'base.copyWith(color: …)',
                  code: 'base.copyWith(\n  color: 0xFFB3261E,\n)',
                  data: derived,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MergePanel extends StatelessWidget {
  const _MergePanel();

  @override
  Widget build(BuildContext context) {
    const IconThemeData a = IconThemeData(
      size: 32,
      color: Color(0xFF1565C0),
      weight: 300,
    );
    const IconThemeData b = IconThemeData(
      size: 48,
      shadows: <Shadow>[
        Shadow(blurRadius: 6, color: Color(0x66000000), offset: Offset(0, 3)),
      ],
    );
    final IconThemeData merged = a.merge(b);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _OpTitle('merge'),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                _OpColumn(
                  label: 'a',
                  code: 'IconThemeData(\n  size: 32,\n  color: 0xFF1565C0,\n  weight: 300,\n)',
                  data: a,
                ),
                const SizedBox(width: 16),
                _OpColumn(
                  label: 'a.merge(b)',
                  code: 'merge({\n  size: 48,\n  shadows: [...],\n})\n// color,weight kept',
                  data: merged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LerpPanel extends StatelessWidget {
  const _LerpPanel();

  @override
  Widget build(BuildContext context) {
    const IconThemeData a = IconThemeData(
      size: 24,
      color: Color(0xFF2E7D32),
      weight: 200,
    );
    const IconThemeData b = IconThemeData(
      size: 64,
      color: Color(0xFFB3261E),
      weight: 700,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _OpTitle('lerp(a, b, t)'),
            const SizedBox(height: 8),
            ValueListenableBuilder<double>(
              valueListenable: kLerpT,
              builder: (_, double t, _) {
                final IconThemeData lerped =
                    IconThemeData.lerp(a, b, t);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _OpColumn(
                          label: 'a',
                          code: 'size: 24\ncolor: green\nweight: 200',
                          data: a,
                        ),
                        const SizedBox(width: 12),
                        _OpColumn(
                          label: 't=${t.toStringAsFixed(2)}',
                          code: 'size: ${lerped.size?.toStringAsFixed(1)}\n'
                              'weight: ${lerped.weight?.toStringAsFixed(0)}',
                          data: lerped,
                        ),
                        const SizedBox(width: 12),
                        _OpColumn(
                          label: 'b',
                          code: 'size: 64\ncolor: red\nweight: 700',
                          data: b,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 8),
                        const Text('t',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: 1,
                            value: t,
                            onChanged: (double v) => kLerpT.value = v,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OpTitle extends StatelessWidget {
  const _OpTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace'));
  }
}

class _OpColumn extends StatelessWidget {
  const _OpColumn({
    required this.label,
    required this.code,
    required this.data,
  });
  final String label;
  final String code;
  final IconThemeData data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Center(
              child: IconTheme(
                data: data,
                child: const Icon(Icons.star),
              ),
            ),
            const SizedBox(height: 8),
            Text(code,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — applyTextScaling.
// ---------------------------------------------------------------------------

class _SectionScaling extends StatelessWidget {
  const _SectionScaling();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        _ScalingIntro(),
        SizedBox(height: 16),
        _ScalingPair(scaler: 0.8, label: 'textScaler 0.8×'),
        SizedBox(height: 12),
        _ScalingPair(scaler: 1.0, label: 'textScaler 1.0× (device default)'),
        SizedBox(height: 12),
        _ScalingPair(scaler: 1.6, label: 'textScaler 1.6× (large accessibility)'),
        SizedBox(height: 16),
        _ScalingTips(),
      ],
    );
  }
}

class _ScalingIntro extends StatelessWidget {
  const _ScalingIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.text_fields,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('applyTextScaling',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'When applyTextScaling is true the rendered size is multiplied '
              'by MediaQuery.textScalerOf(context). When false the size stays '
              'fixed regardless of user accessibility settings — the legacy '
              'behavior before Flutter 3.10.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ScalingPair extends StatelessWidget {
  const _ScalingPair({required this.scaler, required this.label});
  final double scaler;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scaler)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Text('applyTextScaling: true',
                              style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 8),
                          IconTheme(
                            data: const IconThemeData(
                              size: 32,
                              applyTextScaling: true,
                            ),
                            child: const Icon(Icons.accessibility_new),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Text('applyTextScaling: false',
                              style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 8),
                          IconTheme(
                            data: const IconThemeData(
                              size: 32,
                              applyTextScaling: false,
                            ),
                            child: const Icon(Icons.accessibility_new),
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
    );
  }
}

class _ScalingTips extends StatelessWidget {
  const _ScalingTips();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Accessibility tips',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            _Note('Enable applyTextScaling on body icons that sit inside text '
                'runs — they need to grow with the surrounding typography.'),
            _Note('Leave applyTextScaling false on tightly laid-out chrome '
                '(app bar, bottom nav) where growth would break the layout.'),
            _Note('Combine with LayoutBuilder and minimum tap targets to keep '
                'controls reachable at 2× scaling.'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — Use cases.
// ---------------------------------------------------------------------------

class _SectionUseCases extends StatelessWidget {
  const _SectionUseCases();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const _UseCaseIntro(),
        const SizedBox(height: 16),
        _UseCaseGrid(),
        const SizedBox(height: 16),
        const _ComparisonTable(),
      ],
    );
  }
}

class _UseCaseIntro extends StatelessWidget {
  const _UseCaseIntro();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.style,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text('Use cases & comparison',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Six practical scenarios that benefit from a dedicated '
              'IconThemeData, followed by a comparison with the adjacent '
              'APIs (IconTheme, Icon and TextStyle glyphs).',
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<int>(
              valueListenable: kUseCaseHighlight,
              builder: (_, int idx, _) {
                return Row(
                  children: <Widget>[
                    const Icon(Icons.info_outline, size: 14),
                    const SizedBox(width: 6),
                    Text('Highlighted: ${_useCases[idx].title}',
                        style: const TextStyle(fontSize: 12)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UseCaseGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        for (int i = 0; i < _useCases.length; i++)
          SizedBox(
            width: 260,
            child: _UseCaseCard(index: i, useCase: _useCases[i]),
          ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.index, required this.useCase});
  final int index;
  final _UseCase useCase;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: kUseCaseHighlight,
      builder: (_, int active, _) {
        final bool selected = active == index;
        return Card(
          elevation: selected ? 6 : 1,
          child: InkWell(
            onTap: () => kUseCaseHighlight.value = index,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: useCase.bg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: IconTheme(
                      data: IconThemeData(
                        color: useCase.fg,
                        size: 40,
                        shadows: selected
                            ? const <Shadow>[
                                Shadow(
                                  color: Color(0x33000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                )
                              ]
                            : null,
                      ),
                      child: Icon(useCase.icon),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(useCase.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(useCase.description,
                      style: const TextStyle(fontSize: 11, height: 1.4)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('IconThemeData vs adjacent APIs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            _CmpHeader(),
            _CmpRow(
              what: 'IconThemeData',
              kind: 'data class',
              role: 'describes icon styling (size/color/weight/...)',
              mutability: 'immutable — copyWith/merge/lerp',
            ),
            _CmpRow(
              what: 'IconTheme',
              kind: 'InheritedWidget',
              role: 'propagates IconThemeData down the tree',
              mutability: 'rebuilds children on change',
            ),
            _CmpRow(
              what: 'Icon',
              kind: 'StatelessWidget',
              role: 'paints one glyph, reads IconTheme.of(context)',
              mutability: 'local fields override ancestor theme',
            ),
            _CmpRow(
              what: 'TextStyle(fontFamily: icon font)',
              kind: 'text styling',
              role: 'renders glyphs as text (Text+codePoint)',
              mutability: 'pure typography, no icon semantics',
            ),
          ],
        ),
      ),
    );
  }
}

class _CmpHeader extends StatelessWidget {
  const _CmpHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 2, child: _ColHeader('API')),
          Expanded(flex: 2, child: _ColHeader('Kind')),
          Expanded(flex: 4, child: _ColHeader('Role')),
          Expanded(flex: 3, child: _ColHeader('Mutability')),
        ],
      ),
    );
  }
}

class _ColHeader extends StatelessWidget {
  const _ColHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 11, fontWeight: FontWeight.w700));
  }
}

class _CmpRow extends StatelessWidget {
  const _CmpRow({
    required this.what,
    required this.kind,
    required this.role,
    required this.mutability,
  });
  final String what;
  final String kind;
  final String role;
  final String mutability;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(what,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text(kind, style: const TextStyle(fontSize: 11))),
          Expanded(flex: 4, child: Text(role, style: const TextStyle(fontSize: 11))),
          Expanded(
              flex: 3, child: Text(mutability, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom cheat sheet (always visible).
// ---------------------------------------------------------------------------

class _BottomCheatSheet extends StatelessWidget {
  const _BottomCheatSheet();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: SizedBox(
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          children: <Widget>[
            for (final _CheatRow row in _cheatSheet) _CheatChip(row: row),
          ],
        ),
      ),
    );
  }
}

class _CheatChip extends StatelessWidget {
  const _CheatChip({required this.row});
  final _CheatRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(row.field,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace')),
          const SizedBox(height: 2),
          Text(row.type,
              style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.black54)),
          const SizedBox(height: 4),
          Expanded(
            child: Text(row.description,
                style: const TextStyle(fontSize: 11, height: 1.3)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Plain data holder classes.
// ---------------------------------------------------------------------------

class _WeightStop {
  const _WeightStop(this.value, this.title, this.description);
  final int value;
  final String title;
  final String description;
}

class _ColorChoice {
  const _ColorChoice(this.color, this.label);
  final Color color;
  final String label;
}

class _ShadowRecipe {
  const _ShadowRecipe(this.title, this.description, this.shadows);
  final String title;
  final String description;
  final List<Shadow> shadows;
}

class _UseCase {
  const _UseCase(
      this.title, this.description, this.bg, this.fg, this.icon);
  final String title;
  final String description;
  final Color bg;
  final Color fg;
  final IconData icon;
}

class _CheatRow {
  const _CheatRow(this.field, this.type, this.description);
  final String field;
  final String type;
  final String description;
}
