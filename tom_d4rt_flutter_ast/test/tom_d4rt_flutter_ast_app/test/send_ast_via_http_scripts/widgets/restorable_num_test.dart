import 'package:flutter/material.dart';

// =============================================================================
// RestorableNum<T extends num> Deep Demo — Recipe Scaler / Kitchen Math Studio
// -----------------------------------------------------------------------------
// Teaches:
//   * RestorableNum<num> stores whichever concrete numeric type you assign
//     (int vs double) and round-trips it through Flutter's restoration pipeline
//     without collapsing to a single numeric type.
//   * RestorableInt is the int-only subclass; RestorableDouble is double-only.
//   * The base class RestorableNum<num>(seed) is useful when the value is
//     sometimes an int and sometimes a double (tip percent 18 vs 17.5, scale
//     factor 2 vs 1.5, subtotal 42 vs 42.75 etc.).
//   * RestorationMixin + registerForRestoration ties these primitives to the
//     widget tree.
//
// This file is harness-safe: exposes a top-level `build(BuildContext)` that
// returns a MaterialApp. No main(), no runApp().
// =============================================================================

// -----------------------------------------------------------------------------
// Warm kitchen palette. Deliberately not the teal/indigo/amber used by sibling
// demo files — terracotta + cream + forest green evoke a real kitchen counter.
// -----------------------------------------------------------------------------
const Color _kTerracotta = Color(0xFFC96F4A);
const Color _kTerracottaDeep = Color(0xFF8F4A2E);
const Color _kCream = Color(0xFFF6EFE2);
const Color _kCreamDeep = Color(0xFFE8DDC6);
const Color _kForest = Color(0xFF2E5D3A);
const Color _kForestLight = Color(0xFF4F8862);
const Color _kCharcoal = Color(0xFF2B2420);
const Color _kMuted = Color(0xFF8A7F74);
const Color _kHighlight = Color(0xFFF2C14E);

// -----------------------------------------------------------------------------
// Top-level harness entry point.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('=== RestorableNum Kitchen Studio — harness build() invoked ===');
  return MaterialApp(
    title: 'Recipe Scaler / Kitchen Math Studio',
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'recipe_scaler_root',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kTerracotta,
        primary: _kTerracotta,
        secondary: _kForest,
        surface: _kCream,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: _kCream,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: _kCharcoal,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(color: _kCharcoal),
      ),
    ),
    home: const RecipeScalerDemo(),
  );
}

// -----------------------------------------------------------------------------
// A single ingredient entry used by the scaler card. Pure data, no restoration.
// -----------------------------------------------------------------------------
class _Ingredient {
  const _Ingredient({
    required this.name,
    required this.baseAmount,
    required this.unit,
    required this.icon,
    required this.accent,
  });

  final String name;
  final num baseAmount;
  final String unit;
  final IconData icon;
  final Color accent;
}

const List<_Ingredient> _kIngredients = <_Ingredient>[
  _Ingredient(
    name: 'Flour',
    baseAmount: 250,
    unit: 'g',
    icon: Icons.grain,
    accent: _kTerracotta,
  ),
  _Ingredient(
    name: 'Sugar',
    baseAmount: 120,
    unit: 'g',
    icon: Icons.cake_outlined,
    accent: _kHighlight,
  ),
  _Ingredient(
    name: 'Butter',
    baseAmount: 80,
    unit: 'g',
    icon: Icons.icecream_outlined,
    accent: _kTerracottaDeep,
  ),
  _Ingredient(
    name: 'Eggs',
    baseAmount: 3,
    unit: '',
    icon: Icons.egg_alt_outlined,
    accent: _kForest,
  ),
  _Ingredient(
    name: 'Vanilla',
    baseAmount: 5,
    unit: 'ml',
    icon: Icons.local_drink_outlined,
    accent: _kForestLight,
  ),
  _Ingredient(
    name: 'Salt',
    baseAmount: 1,
    unit: 'tsp',
    icon: Icons.dining_outlined,
    accent: _kMuted,
  ),
];

// -----------------------------------------------------------------------------
// Scale presets. Integer presets keep _scaleFactor as int; 0.5× and 1.5× store
// a double. This is the central teaching moment of the demo.
// -----------------------------------------------------------------------------
class _ScalePreset {
  const _ScalePreset({required this.label, required this.value});
  final String label;
  final num value;
}

const List<_ScalePreset> _kScalePresets = <_ScalePreset>[
  _ScalePreset(label: '0.5×', value: 0.5),
  _ScalePreset(label: '1×', value: 1),
  _ScalePreset(label: '1.5×', value: 1.5),
  _ScalePreset(label: '2×', value: 2),
  _ScalePreset(label: '3×', value: 3),
];

// -----------------------------------------------------------------------------
// Tip presets. "Custom" flips the held RestorableNum<num> to a double (17.25).
// -----------------------------------------------------------------------------
class _TipPreset {
  const _TipPreset({required this.label, required this.value});
  final String label;
  final num value;
}

const List<_TipPreset> _kTipPresets = <_TipPreset>[
  _TipPreset(label: '12%', value: 12),
  _TipPreset(label: '15%', value: 15),
  _TipPreset(label: '18%', value: 18),
  _TipPreset(label: '20%', value: 20),
  _TipPreset(label: 'Custom', value: 17.25),
];

// -----------------------------------------------------------------------------
// Unit converter options. Switching simply changes how the same num is
// rendered; the underlying RestorableNum value never changes.
// -----------------------------------------------------------------------------
const List<String> _kUnitSystems = <String>['Metric', 'Imperial', 'Vol→Wt'];
const List<IconData> _kUnitIcons = <IconData>[
  Icons.scale_outlined,
  Icons.straighten_outlined,
  Icons.kitchen_outlined,
];

// =============================================================================
// RecipeScalerDemo — the StatefulWidget that owns all the RestorableNum fields.
// =============================================================================
class RecipeScalerDemo extends StatefulWidget {
  const RecipeScalerDemo({super.key});

  @override
  State<RecipeScalerDemo> createState() => _RecipeScalerDemoState();
}

class _RecipeScalerDemoState extends State<RecipeScalerDemo>
    with RestorationMixin {
  // ---------------------------------------------------------------------------
  // The star of the show: RestorableNum<num> holds either int or double
  // depending on which preset the cook tapped.
  // ---------------------------------------------------------------------------
  final RestorableNum<num> _scaleFactor = RestorableNum<num>(1);

  // RestorableInt — servings are always whole. You can't have 2.5 diners.
  final RestorableInt _servings = RestorableInt(4);

  // RestorableNum<num> — tip preset flips between int (18) and double (17.25).
  final RestorableNum<num> _tipPercent = RestorableNum<num>(18);

  // RestorableInt — oven temp in celsius. Not scaled, just persisted.
  final RestorableInt _ovenTempC = RestorableInt(180);

  // RestorableNum<num> — dollar subtotal for tip calc. Starts as int 42;
  // user edits will flip it to double.
  final RestorableNum<num> _subtotalDollars = RestorableNum<num>(42);

  // RestorableInt — index into _kUnitSystems.
  final RestorableInt _unitSelection = RestorableInt(0);

  @override
  String? get restorationId => 'recipe_scaler_demo';

  @override
  void initState() {
    super.initState();
    debugPrint(
      '[RecipeScalerDemo] initState — seeding restorable kitchen state.',
    );
    debugPrint('  scaleFactor seed = ${_scaleFactor.value} '
        '(runtimeType=${_scaleFactor.value.runtimeType})');
    debugPrint('  servings seed = ${_servings.value}');
    debugPrint('  tipPercent seed = ${_tipPercent.value} '
        '(runtimeType=${_tipPercent.value.runtimeType})');
    debugPrint('  ovenTempC seed = ${_ovenTempC.value}');
    debugPrint('  subtotalDollars seed = ${_subtotalDollars.value}');
    debugPrint('  unitSelection seed = ${_unitSelection.value}');
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    debugPrint('[RecipeScalerDemo] restoreState — '
        'initialRestore=$initialRestore oldBucket=${oldBucket?.restorationId}');
    registerForRestoration(_scaleFactor, 'scale_factor');
    registerForRestoration(_servings, 'servings');
    registerForRestoration(_tipPercent, 'tip_percent');
    registerForRestoration(_ovenTempC, 'oven_temp_c');
    registerForRestoration(_subtotalDollars, 'subtotal_dollars');
    registerForRestoration(_unitSelection, 'unit_selection');
    debugPrint(
      '[RecipeScalerDemo] after restore — scale=${_scaleFactor.value} '
      '(${_scaleFactor.value.runtimeType}) tip=${_tipPercent.value} '
      '(${_tipPercent.value.runtimeType})',
    );
  }

  @override
  void dispose() {
    debugPrint('[RecipeScalerDemo] dispose — releasing RestorableNum fields.');
    _scaleFactor.dispose();
    _servings.dispose();
    _tipPercent.dispose();
    _ovenTempC.dispose();
    _subtotalDollars.dispose();
    _unitSelection.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Handlers. Each setState narrates what it did so the demo reads as a
  // teaching transcript when you scroll the debug console.
  // ---------------------------------------------------------------------------
  void _applyScalePreset(num value) {
    setState(() {
      _scaleFactor.value = value;
    });
    debugPrint('[scale] applied preset = $value '
        '(runtimeType=${value.runtimeType})');
  }

  void _applyTipPreset(num value) {
    setState(() {
      _tipPercent.value = value;
    });
    debugPrint('[tip] applied preset = $value '
        '(runtimeType=${value.runtimeType})');
  }

  void _bumpServings(int delta) {
    final int next = (_servings.value + delta).clamp(1, 24);
    setState(() {
      _servings.value = next;
    });
    debugPrint('[servings] bumped by $delta → ${_servings.value}');
  }

  void _bumpOvenTemp(int delta) {
    final int next = (_ovenTempC.value + delta).clamp(80, 260);
    setState(() {
      _ovenTempC.value = next;
    });
    debugPrint('[oven] bumped by $delta → ${_ovenTempC.value}°C');
  }

  void _bumpSubtotal(num delta) {
    // Whole-dollar bumps keep int identity; half-dollar bumps flip to double.
    final num raw = _subtotalDollars.value + delta;
    final num clamped = raw < 0 ? 0 : (raw > 9999 ? 9999 : raw);
    setState(() {
      _subtotalDollars.value = clamped;
    });
    debugPrint('[subtotal] bumped by $delta → '
        '${_subtotalDollars.value} (${_subtotalDollars.value.runtimeType})');
  }

  void _selectUnit(int index) {
    setState(() {
      _unitSelection.value = index;
    });
    debugPrint('[unit] selected ${_kUnitSystems[index]}');
  }

  // ---------------------------------------------------------------------------
  // Pretty-print a scaled amount. Integer values lose the .0 suffix; fractional
  // values show a single decimal digit (1.5, 2.3 etc.).
  // ---------------------------------------------------------------------------
  String _formatAmount(num value) {
    if (value is int) {
      return value.toString();
    }
    final double asDouble = value.toDouble();
    if (asDouble == asDouble.roundToDouble()) {
      return asDouble.toInt().toString();
    }
    return asDouble.toStringAsFixed(1);
  }

  // Does scaling this ingredient move it across an integer boundary relative
  // to its base amount? Used to highlight the row.
  bool _crossesIntegerBoundary(num base, num scaled) {
    final double b = base.toDouble();
    final double s = scaled.toDouble();
    return b.floor() != s.floor() || b.ceil() != s.ceil();
  }

  // ---------------------------------------------------------------------------
  // Build.
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      appBar: AppBar(
        backgroundColor: _kTerracotta,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kitchen Math Studio',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'RestorableNum demo',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          children: <Widget>[
            _buildIntro(),
            const SizedBox(height: 24),
            _buildScaleDial(),
            const SizedBox(height: 24),
            _buildIngredientCard(),
            const SizedBox(height: 24),
            _buildTipCard(),
            const SizedBox(height: 24),
            _buildUnitConverter(),
            const SizedBox(height: 24),
            _buildNumTypeTable(),
            const SizedBox(height: 24),
            _buildOvenStrip(),
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Intro header — sets the stage and explains why `num` matters here.
  // ---------------------------------------------------------------------------
  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kTerracotta, _kTerracottaDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kTerracotta.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Scale any recipe in one tap',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'RestorableNum<num> keeps whichever numeric flavour you hand it. '
            'Tap 2× and the scale factor is a plain int. Tap 1.5× and it '
            'flips to a double. Both survive restoration as the same concrete '
            'type.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _legendChip('RestorableNum<num>', Colors.white),
              const SizedBox(width: 8),
              _legendChip('RestorableInt', _kHighlight),
              const SizedBox(width: 8),
              _legendChip('RestorableDouble', _kForestLight),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendChip(String label, Color dotColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 — Scale dial hero.
  // ---------------------------------------------------------------------------
  Widget _buildScaleDial() {
    final num factor = _scaleFactor.value;
    final String typeLabel = factor is int ? 'int' : 'double';
    final Color typeColor = factor is int ? _kForest : _kTerracottaDeep;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.tune, color: _kForest),
                const SizedBox(width: 8),
                const Text(
                  'Scale dial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _kCharcoal,
                  ),
                ),
                const Spacer(),
                Text(
                  'runtimeType',
                  style: TextStyle(
                    fontSize: 11,
                    color: _kMuted.withValues(alpha: 0.9),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Tick marks — 24 radial rectangles rotated around centre.
                  ...List<Widget>.generate(24, (int i) {
                    final double angle = (i / 24) * 6.2831853;
                    final bool major = i % 6 == 0;
                    return Transform.rotate(
                      angle: angle,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: major ? 4 : 2,
                          height: major ? 16 : 10,
                          decoration: BoxDecoration(
                            color: major
                                ? _kTerracotta
                                : _kMuted.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    );
                  }),
                  // Dial face.
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      color: _kCream,
                      shape: BoxShape.circle,
                      border: Border.all(color: _kCreamDeep, width: 2),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _formatAmount(factor),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: _kTerracottaDeep,
                          ),
                        ),
                        const Text(
                          '× scale',
                          style: TextStyle(
                            fontSize: 13,
                            color: _kMuted,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pointer — a terracotta line rotated by the factor mapped
                  // into radians. Purely decorative.
                  Transform.rotate(
                    angle: _pointerAngle(factor),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 3,
                        height: 38,
                        decoration: BoxDecoration(
                          color: _kTerracotta,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Runtime-type chip under the dial.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: typeColor.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    factor is int
                        ? Icons.tag_outlined
                        : Icons.pin_outlined,
                    size: 16,
                    color: typeColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'scaleFactor.runtimeType = $typeLabel',
                    style: TextStyle(
                      color: typeColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Preset buttons — int for 1,2,3; double for 0.5 and 1.5.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _kScalePresets.map((_ScalePreset preset) {
                final bool active = preset.value == factor &&
                    preset.value.runtimeType == factor.runtimeType;
                return _presetButton(
                  label: preset.label,
                  active: active,
                  onTap: () => _applyScalePreset(preset.value),
                  activeColor: preset.value is int
                      ? _kForest
                      : _kTerracottaDeep,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              'Integer presets (1×, 2×, 3×) store an int. Fractional presets '
              '(0.5×, 1.5×) store a double. RestorableNum<num> remembers '
              'the exact concrete type across a restore.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _kMuted.withValues(alpha: 0.95),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _pointerAngle(num factor) {
    // Map 0.5 → -0.9 rad, 1 → -0.45, 1.5 → 0, 2 → 0.45, 3 → 1.35.
    final double f = factor.toDouble();
    return ((f - 1.5) * 0.9);
  }

  Widget _presetButton({
    required String label,
    required bool active,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? activeColor : _kCream,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active
                ? activeColor
                : _kCreamDeep.withValues(alpha: 0.9),
            width: active ? 2 : 1,
          ),
          boxShadow: active
              ? <BoxShadow>[
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : _kCharcoal,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 — Ingredient list card.
  // ---------------------------------------------------------------------------
  Widget _buildIngredientCard() {
    final num factor = _scaleFactor.value;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.menu_book_outlined, color: _kForest),
                  const SizedBox(width: 8),
                  const Text(
                    'Ingredients for ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _kCharcoal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _kForest.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          icon: const Icon(
                            Icons.remove,
                            size: 16,
                            color: _kForest,
                          ),
                          onPressed: () => _bumpServings(-1),
                        ),
                        Text(
                          '${_servings.value}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: _kForest,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                            color: _kForest,
                          ),
                          onPressed: () => _bumpServings(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'servings',
                    style: TextStyle(
                      color: _kMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _kCreamDeep),
            ..._kIngredients.map((_Ingredient ing) {
              final num scaled = ing.baseAmount * factor;
              return _buildIngredientRow(ing, scaled);
            }),
            const Divider(height: 1, color: _kCreamDeep),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: _kMuted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Scaled amounts are computed on the fly; restoration '
                      'rehydrates the scale factor with its exact numeric '
                      'type — an int stays an int, a double stays a double.',
                      style: TextStyle(
                        fontSize: 12,
                        color: _kMuted.withValues(alpha: 0.95),
                        height: 1.35,
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

  Widget _buildIngredientRow(_Ingredient ing, num scaled) {
    final bool crossed = _crossesIntegerBoundary(ing.baseAmount, scaled);
    return Container(
      decoration: BoxDecoration(
        color: crossed
            ? _kHighlight.withValues(alpha: 0.12)
            : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: crossed
                ? _kHighlight
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: ing.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(ing.icon, color: ing.accent, size: 18),
        ),
        title: Text(
          ing.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: _kCharcoal,
          ),
        ),
        subtitle: Text(
          'base ${_formatAmount(ing.baseAmount)}${ing.unit}',
          style: TextStyle(
            color: _kMuted.withValues(alpha: 0.95),
            fontSize: 12,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '${_formatAmount(scaled)}${ing.unit}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: crossed ? _kTerracottaDeep : _kCharcoal,
                fontSize: 16,
              ),
            ),
            Text(
              scaled is int ? 'int' : 'double',
              style: TextStyle(
                fontSize: 10,
                color: _kMuted.withValues(alpha: 0.95),
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 — Tip calculator.
  // ---------------------------------------------------------------------------
  Widget _buildTipCard() {
    final num subtotal = _subtotalDollars.value;
    final num tipPercent = _tipPercent.value;
    final double tip = subtotal.toDouble() * tipPercent.toDouble() / 100.0;
    final double total = subtotal.toDouble() + tip;
    final int servings = _servings.value;
    final double tipPerPerson = tip / servings;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.receipt_long_outlined, color: _kForest),
                const SizedBox(width: 8),
                const Text(
                  'Tip calculator',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _kCharcoal,
                  ),
                ),
                const Spacer(),
                Text(
                  tipPercent is int
                      ? 'tipPercent is int'
                      : 'tipPercent is double',
                  style: const TextStyle(
                    color: _kTerracottaDeep,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Subtotal row with +/- half/whole dollar steppers.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kCream,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _kCreamDeep),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        'Subtotal',
                        style: TextStyle(
                          color: _kMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${_formatAmount(subtotal)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: _kCharcoal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _subtotalStepper('-\$1', () => _bumpSubtotal(-1)),
                      _subtotalStepper(
                        '-\$0.50',
                        () => _bumpSubtotal(-0.5),
                      ),
                      _subtotalStepper(
                        '+\$0.50',
                        () => _bumpSubtotal(0.5),
                      ),
                      _subtotalStepper('+\$1', () => _bumpSubtotal(1)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tip preset',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: _kCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<num>(
              segments: _kTipPresets.map((_TipPreset p) {
                return ButtonSegment<num>(
                  value: p.value,
                  label: Text(p.label),
                );
              }).toList(),
              selected: <num>{tipPercent},
              onSelectionChanged: (Set<num> sel) {
                if (sel.isNotEmpty) {
                  _applyTipPreset(sel.first);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return _kTerracotta;
                  }
                  return _kCream;
                }),
                foregroundColor:
                    WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return _kCharcoal;
                }),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[_kForest, _kForestLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_formatAmount(tipPercent)}% → '
                        '\$${tip.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        'Tip ÷ $servings diners',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${tipPerPerson.toStringAsFixed(2)} each',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Switching the preset between 18 and "Custom" (17.25) mutates '
              'the very same RestorableNum<num> — its runtime type flips '
              'between int and double on the fly.',
              style: TextStyle(
                color: _kMuted.withValues(alpha: 0.95),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subtotalStepper(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kCreamDeep),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: _kTerracottaDeep,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — Unit converter.
  // ---------------------------------------------------------------------------
  Widget _buildUnitConverter() {
    final int selection = _unitSelection.value;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.swap_horiz, color: _kForest),
                const SizedBox(width: 8),
                const Text(
                  'Unit converter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _kCharcoal,
                  ),
                ),
                const Spacer(),
                Text(
                  'same num, 3 renderings',
                  style: TextStyle(
                    color: _kMuted.withValues(alpha: 0.95),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List<Widget>.generate(_kUnitSystems.length, (int i) {
                final bool active = i == selection;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == _kUnitSystems.length - 1 ? 0 : 8,
                    ),
                    child: InkWell(
                      onTap: () => _selectUnit(i),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: active ? _kTerracotta : _kCream,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: active ? _kTerracotta : _kCreamDeep,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              _kUnitIcons[i],
                              color: active ? Colors.white : _kForest,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _kUnitSystems[i],
                              style: TextStyle(
                                color:
                                    active ? Colors.white : _kCharcoal,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 18),
            ..._kIngredients.take(4).map((_Ingredient ing) {
              return _buildUnitRow(ing, selection);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitRow(_Ingredient ing, int unitIndex) {
    String rendering;
    switch (unitIndex) {
      case 0:
        rendering = '${_formatAmount(ing.baseAmount)} ${ing.unit}';
        break;
      case 1:
        rendering = _toImperial(ing);
        break;
      default:
        rendering = _toVolumeOrWeight(ing);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Icon(ing.icon, color: ing.accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              ing.name,
              style: const TextStyle(
                color: _kCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            rendering,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: _kTerracottaDeep,
            ),
          ),
        ],
      ),
    );
  }

  String _toImperial(_Ingredient ing) {
    if (ing.unit == 'g') {
      final double oz = ing.baseAmount.toDouble() / 28.3495;
      return '${oz.toStringAsFixed(1)} oz';
    }
    if (ing.unit == 'ml') {
      final double tsp = ing.baseAmount.toDouble() / 4.9289;
      return '${tsp.toStringAsFixed(1)} tsp';
    }
    if (ing.unit == 'tsp') {
      return '${_formatAmount(ing.baseAmount)} tsp';
    }
    return _formatAmount(ing.baseAmount);
  }

  String _toVolumeOrWeight(_Ingredient ing) {
    if (ing.name == 'Flour' && ing.unit == 'g') {
      final double cups = ing.baseAmount.toDouble() / 125.0;
      return '${cups.toStringAsFixed(1)} cups';
    }
    if (ing.name == 'Sugar' && ing.unit == 'g') {
      final double cups = ing.baseAmount.toDouble() / 200.0;
      return '${cups.toStringAsFixed(1)} cups';
    }
    if (ing.name == 'Butter' && ing.unit == 'g') {
      final double tbsp = ing.baseAmount.toDouble() / 14.2;
      return '${tbsp.toStringAsFixed(1)} tbsp';
    }
    return _toImperial(ing);
  }

  // ---------------------------------------------------------------------------
  // Section 5 — Int-vs-double comparison table.
  // ---------------------------------------------------------------------------
  Widget _buildNumTypeTable() {
    const List<List<String>> rows = <List<String>>[
      <String>['5 / 2', '2 (int trunc)', '2.5'],
      <String>['5 ~/ 2', '2', '2.0'],
      <String>['5 % 2', '1', '1.0'],
      <String>['2.pow(10)', '1024', '1024.0'],
      <String>['(1/3) precision', 'N/A', '0.3333…'],
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.compare_arrows_outlined, color: _kForest),
                SizedBox(width: 8),
                Text(
                  'int vs double at a glance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _kCharcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: _kCreamDeep),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: <Widget>[
                  _buildTableHeaderRow(),
                  ...rows.asMap().entries.map((MapEntry<int, List<String>> e) {
                    final bool shaded = e.key.isOdd;
                    return _buildTableBodyRow(e.value, shaded);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kForest.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.lightbulb_outline, color: _kForest),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: _kCharcoal,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Teaching point: ',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: 'RestorableNum<num> serialises the stored '
                                'primitive. An int round-trips as int, a '
                                'double as double — restoration never '
                                'silently widens or narrows your numeric '
                                'type.',
                            style: TextStyle(
                              color: _kCharcoal.withValues(alpha: 0.9),
                            ),
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

  Widget _buildTableHeaderRow() {
    return Container(
      decoration: const BoxDecoration(
        color: _kCreamDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Operation',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: _kCharcoal,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'int',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: _kForest,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'double',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: _kTerracottaDeep,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBodyRow(List<String> cells, bool shaded) {
    return Container(
      color: shaded ? _kCream : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              cells[0],
              style: const TextStyle(
                color: _kCharcoal,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cells[1],
              style: const TextStyle(color: _kForest),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cells[2],
              style: const TextStyle(color: _kTerracottaDeep),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Supporting strip — oven temp (a RestorableInt that never needs to be a
  // double, shown to contrast the flexible RestorableNum<num> fields).
  // ---------------------------------------------------------------------------
  Widget _buildOvenStrip() {
    return Card(
      color: _kCharcoal,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _kTerracotta.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_fire_department_outlined,
                color: _kHighlight,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Oven temperature',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'RestorableInt — strictly whole degrees.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () => _bumpOvenTemp(-10),
            ),
            Text(
              '${_ovenTempC.value}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _bumpOvenTemp(10),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Footer.
  // ---------------------------------------------------------------------------
  Widget _buildFooter() {
    return Column(
      children: <Widget>[
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 12),
          color: _kCreamDeep,
        ),
        Text(
          'Kitchen Math Studio — RestorableNum deep demo',
          style: TextStyle(
            color: _kMuted.withValues(alpha: 0.95),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'scaleFactor=${_scaleFactor.value} (${_scaleFactor.value.runtimeType}), '
          'tipPercent=${_tipPercent.value} (${_tipPercent.value.runtimeType}), '
          'subtotal=${_subtotalDollars.value} '
          '(${_subtotalDollars.value.runtimeType})',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _kMuted.withValues(alpha: 0.85),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
