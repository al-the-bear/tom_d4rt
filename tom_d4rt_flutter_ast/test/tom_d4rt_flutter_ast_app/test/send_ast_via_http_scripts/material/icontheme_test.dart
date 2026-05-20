// D4rt test script: Tests IconTheme & IconThemeData from material
// Deep Demo: A visual atlas of IconTheme inheritance, Material Symbol axes,
// merge semantics, light/dark adaptation, and shadow/opacity composition.
//
// Authored manually. Every section narrates a facet of how IconTheme propagates
// styling down a Flutter widget subtree. The script intentionally uses many
// small composed widgets so that the rendered output reads like a printed
// reference page: heading, paragraph, demo strip, caption, repeat.
//
// IMPORTANT D4rt notes:
//   - Closure captures in `for` loops are SHARED across iterations under D4rt,
//     so all dynamic builders go through `List.generate` or `.map(...)`.
//   - `withValues(alpha: ...)` is used everywhere instead of the deprecated
//     `withOpacity(...)`, which keeps the analyzer silent without ignores.
//   - The whole file returns a Scaffold so the SendTestRunner harness can mount
//     it directly under its own MaterialApp.
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 0: PROLOGUE — what IconTheme actually does
  // ==========================================================================
  // IconTheme is an InheritedWidget that injects an IconThemeData into the
  // subtree. Any descendant Icon widget that does not override color/size/etc.
  // pulls those defaults from the nearest enclosing IconTheme. Inside Material
  // apps a default IconTheme is already provided by ThemeData.iconTheme and
  // surfaces like AppBar, ListTile, Drawer, BottomNavigationBar each install
  // their own IconTheme wrapper for context-appropriate defaults.

  final prologueCard = _SectionCard(
    accent: const Color(0xFF3F51B5),
    title: 'IconTheme — the propagation lens',
    subtitle: 'InheritedWidget that styles Icons by default',
    body: const <Widget>[
      Text(
        'IconTheme(data: IconThemeData(...), child: ...) is the canonical '
        'way to provide styling defaults — color, size, opacity, shadows, '
        'and Material Symbols axes (weight, grade, opticalSize, fill) — to '
        'an entire subtree of Icon widgets.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      SizedBox(height: 8.0),
      Text(
        'Children read the theme with IconTheme.of(context). The data flows '
        'with normal inherited-widget semantics, so a nested IconTheme can '
        'either fully replace the parent (IconTheme(...)) or merge on top of '
        'it (IconTheme.merge(...)) — exactly like TextStyle.merge.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 1: IconThemeData CONSTRUCTORS — every named parameter
  // ==========================================================================
  // We instantiate IconThemeData in many shapes so the harness logs cover the
  // full constructor surface area. Each instance also feeds a tiny demo tile
  // so the reader can see the visual difference.

  final basicIconTheme = const IconThemeData();
  final coloredIconTheme = const IconThemeData(color: Color(0xFF2196F3));
  final opacityIconTheme = const IconThemeData(opacity: 0.5);
  final sizedIconTheme = const IconThemeData(size: 32.0);
  final filledIconTheme = const IconThemeData(fill: 1.0);
  final weightedIconTheme = const IconThemeData(weight: 700.0);
  final gradedIconTheme = const IconThemeData(grade: 200.0);
  final opticalIconTheme = const IconThemeData(opticalSize: 48.0);
  final scaledIconTheme = const IconThemeData(applyTextScaling: true);

  final shadowedIconTheme = IconThemeData(
    shadows: <Shadow>[
      Shadow(
        color: Colors.black.withValues(alpha: 0.3),
        offset: const Offset(2.0, 2.0),
        blurRadius: 4.0,
      ),
    ],
  );

  final fullIconTheme = IconThemeData(
    color: const Color(0xFF7E57C2),
    opacity: 0.85,
    size: 28.0,
    fill: 0.5,
    weight: 500.0,
    grade: 100.0,
    opticalSize: 40.0,
    shadows: <Shadow>[
      Shadow(
        color: const Color(0xFF7E57C2).withValues(alpha: 0.25),
        offset: const Offset(1.0, 1.5),
        blurRadius: 3.0,
      ),
    ],
    applyTextScaling: false,
  );

  // copyWith — pick up a few values from `fullIconTheme` and override.
  final copiedIconTheme = fullIconTheme.copyWith(
    color: const Color(0xFFFB8C00),
    size: 36.0,
  );

  // merge — start from a base, layer override on top.
  final baseTheme = const IconThemeData(color: Color(0xFFE53935), size: 24.0);
  final overrideTheme = const IconThemeData(size: 32.0, opacity: 0.9);
  final mergedTheme = baseTheme.merge(overrideTheme);

  // resolve — supplies a BuildContext so MaterialStateColors etc. can resolve.
  final resolvedTheme =
      const IconThemeData(color: Color(0xFF43A047)).resolve(context);

  // isConcrete — true when color, size, opacity are all set to non-null.
  final concreteTheme = const IconThemeData(
    color: Color(0xFF1E88E5),
    size: 24.0,
    opacity: 1.0,
  );
  final concreteFlag = concreteTheme.isConcrete;

  // Capture a few summarized labels so the readout strip below can list them
  // without having to call `.toString()` in build for every IconThemeData.
  final dataSpecimens = <Map<String, Object?>>[
    <String, Object?>{
      'name': 'basic',
      'color': basicIconTheme.color,
      'size': basicIconTheme.size,
      'opacity': basicIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'colored',
      'color': coloredIconTheme.color,
      'size': coloredIconTheme.size,
      'opacity': coloredIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'opacity 0.5',
      'color': opacityIconTheme.color,
      'size': opacityIconTheme.size,
      'opacity': opacityIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'size 32',
      'color': sizedIconTheme.color,
      'size': sizedIconTheme.size,
      'opacity': sizedIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'fill 1.0',
      'color': filledIconTheme.color,
      'size': filledIconTheme.size,
      'opacity': filledIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'weight 700',
      'color': weightedIconTheme.color,
      'size': weightedIconTheme.size,
      'opacity': weightedIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'grade 200',
      'color': gradedIconTheme.color,
      'size': gradedIconTheme.size,
      'opacity': gradedIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'optical 48',
      'color': opticalIconTheme.color,
      'size': opticalIconTheme.size,
      'opacity': opticalIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'applyText',
      'color': scaledIconTheme.color,
      'size': scaledIconTheme.size,
      'opacity': scaledIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'shadowed',
      'color': shadowedIconTheme.color,
      'size': shadowedIconTheme.size,
      'opacity': shadowedIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'full',
      'color': fullIconTheme.color,
      'size': fullIconTheme.size,
      'opacity': fullIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'copyWith',
      'color': copiedIconTheme.color,
      'size': copiedIconTheme.size,
      'opacity': copiedIconTheme.opacity,
    },
    <String, Object?>{
      'name': 'merged',
      'color': mergedTheme.color,
      'size': mergedTheme.size,
      'opacity': mergedTheme.opacity,
    },
    <String, Object?>{
      'name': 'resolved',
      'color': resolvedTheme.color,
      'size': resolvedTheme.size,
      'opacity': resolvedTheme.opacity,
    },
    <String, Object?>{
      'name': 'concrete=$concreteFlag',
      'color': concreteTheme.color,
      'size': concreteTheme.size,
      'opacity': concreteTheme.opacity,
    },
  ];

  final dataSpecimenTiles = List<Widget>.generate(
    dataSpecimens.length,
    (int i) {
      final spec = dataSpecimens[i];
      final Color tint =
          (spec['color'] as Color?) ?? const Color(0xFF607D8B);
      final double? sz = spec['size'] as double?;
      final double? op = spec['opacity'] as double?;
      return Container(
        width: 132.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              tint.withValues(alpha: 0.10),
              tint.withValues(alpha: 0.22),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: tint.withValues(alpha: 0.55),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              spec['name'] as String,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: tint,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'color: ${_describeColor(tint)}',
              style: const TextStyle(fontSize: 10.0, height: 1.2),
            ),
            Text(
              'size:    ${sz?.toStringAsFixed(1) ?? '—'}',
              style: const TextStyle(
                fontSize: 10.0,
                height: 1.2,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              'opacity: ${op?.toStringAsFixed(2) ?? '—'}',
              style: const TextStyle(
                fontSize: 10.0,
                height: 1.2,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 2: COLOR PALETTE — IconTheme.color cascading down
  // ==========================================================================
  // The most common job of IconTheme is to give a region of the UI a single
  // tint. We render a palette of swatches; each swatch wraps an Icon in an
  // IconTheme whose color matches the swatch background's deeper sibling.

  final paletteEntries = <Map<String, Object>>[
    <String, Object>{
      'name': 'Coral',
      'color': const Color(0xFFFF7043),
      'icon': Icons.local_fire_department,
    },
    <String, Object>{
      'name': 'Amber',
      'color': const Color(0xFFFFB300),
      'icon': Icons.wb_sunny,
    },
    <String, Object>{
      'name': 'Lime',
      'color': const Color(0xFFC0CA33),
      'icon': Icons.eco,
    },
    <String, Object>{
      'name': 'Mint',
      'color': const Color(0xFF26A69A),
      'icon': Icons.spa,
    },
    <String, Object>{
      'name': 'Sky',
      'color': const Color(0xFF29B6F6),
      'icon': Icons.cloud_queue,
    },
    <String, Object>{
      'name': 'Indigo',
      'color': const Color(0xFF5C6BC0),
      'icon': Icons.nights_stay,
    },
    <String, Object>{
      'name': 'Violet',
      'color': const Color(0xFF8E24AA),
      'icon': Icons.auto_awesome,
    },
    <String, Object>{
      'name': 'Rose',
      'color': const Color(0xFFEC407A),
      'icon': Icons.favorite,
    },
    <String, Object>{
      'name': 'Slate',
      'color': const Color(0xFF455A64),
      'icon': Icons.terrain,
    },
    <String, Object>{
      'name': 'Sand',
      'color': const Color(0xFFA1887F),
      'icon': Icons.coffee,
    },
  ];

  final paletteTiles = List<Widget>.generate(
    paletteEntries.length,
    (int i) {
      final entry = paletteEntries[i];
      final Color tint = entry['color'] as Color;
      final IconData iconData = entry['icon'] as IconData;
      final String label = entry['name'] as String;
      return Container(
        width: 96.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: tint.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(color: tint, size: 36.0),
              child: Icon(iconData),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: tint,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              _describeColor(tint),
              style: const TextStyle(
                fontSize: 9.5,
                fontFamily: 'monospace',
                color: Color(0xFF455A64),
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 3: SIZE LADDER — IconTheme.size from 12 to 96
  // ==========================================================================
  // Same icon, scaled by progressively larger IconThemes. Each tile wraps a
  // single Icon in its own IconTheme so the size cascades from the wrapper.

  final sizeLadder = <double>[12.0, 16.0, 20.0, 24.0, 28.0, 32.0, 40.0, 48.0, 64.0, 96.0];
  final sizeTiles = List<Widget>.generate(
    sizeLadder.length,
    (int i) {
      final double s = sizeLadder[i];
      final double t = i / (sizeLadder.length - 1);
      final Color tint = Color.lerp(
        const Color(0xFF00ACC1),
        const Color(0xFF1A237E),
        t,
      )!;
      return Container(
        width: math.max(60.0, s + 28.0),
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              tint.withValues(alpha: 0.10),
              tint.withValues(alpha: 0.25),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(size: s, color: tint),
              child: const Icon(Icons.flag_circle),
            ),
            const SizedBox(height: 6.0),
            Text(
              '${s.toStringAsFixed(0)} px',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: tint,
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 4: OPACITY LANE — IconTheme.opacity from 0.10 to 1.00
  // ==========================================================================

  final opacityRamp = <double>[0.10, 0.25, 0.40, 0.55, 0.70, 0.85, 1.00];
  final opacityTiles = List<Widget>.generate(
    opacityRamp.length,
    (int i) {
      final double op = opacityRamp[i];
      return Container(
        width: 78.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xFF263238).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color(0xFF263238).withValues(alpha: 0.30),
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                color: const Color(0xFF263238),
                size: 36.0,
                opacity: op,
              ),
              child: const Icon(Icons.brightness_high),
            ),
            const SizedBox(height: 6.0),
            Text(
              op.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 5: SHADOWS — IconTheme.shadows composition
  // ==========================================================================
  // Each tile applies a different shadow recipe to the same icon. Shadows are
  // a list, so we can stack multiple Shadow objects for a layered drop.

  final shadowRecipes = <Map<String, Object>>[
    <String, Object>{
      'name': 'soft drop',
      'icon': Icons.brightness_5,
      'tint': const Color(0xFFFB8C00),
      'shadows': <Shadow>[
        Shadow(
          color: const Color(0xFFFB8C00).withValues(alpha: 0.35),
          offset: const Offset(0.0, 3.0),
          blurRadius: 6.0,
        ),
      ],
    },
    <String, Object>{
      'name': 'long shadow',
      'icon': Icons.cloud,
      'tint': const Color(0xFF1E88E5),
      'shadows': <Shadow>[
        Shadow(
          color: const Color(0xFF1E88E5).withValues(alpha: 0.5),
          offset: const Offset(4.0, 4.0),
          blurRadius: 2.0,
        ),
      ],
    },
    <String, Object>{
      'name': 'glow',
      'icon': Icons.bolt,
      'tint': const Color(0xFFFFD54F),
      'shadows': <Shadow>[
        Shadow(
          color: const Color(0xFFFFD54F).withValues(alpha: 0.95),
          offset: Offset.zero,
          blurRadius: 14.0,
        ),
        Shadow(
          color: const Color(0xFFFF6F00).withValues(alpha: 0.55),
          offset: Offset.zero,
          blurRadius: 28.0,
        ),
      ],
    },
    <String, Object>{
      'name': 'duotone',
      'icon': Icons.star,
      'tint': const Color(0xFF8E24AA),
      'shadows': <Shadow>[
        Shadow(
          color: const Color(0xFFEC407A).withValues(alpha: 0.7),
          offset: const Offset(-2.0, 2.0),
          blurRadius: 0.0,
        ),
        Shadow(
          color: const Color(0xFF5C6BC0).withValues(alpha: 0.7),
          offset: const Offset(2.0, -2.0),
          blurRadius: 0.0,
        ),
      ],
    },
    <String, Object>{
      'name': 'press',
      'icon': Icons.touch_app,
      'tint': const Color(0xFF455A64),
      'shadows': <Shadow>[
        Shadow(
          color: Colors.black.withValues(alpha: 0.20),
          offset: const Offset(0.0, 1.0),
          blurRadius: 1.0,
        ),
        Shadow(
          color: Colors.black.withValues(alpha: 0.10),
          offset: const Offset(0.0, 2.0),
          blurRadius: 4.0,
        ),
      ],
    },
    <String, Object>{
      'name': 'inset-ish',
      'icon': Icons.circle,
      'tint': const Color(0xFFEEEEEE),
      'shadows': <Shadow>[
        Shadow(
          color: Colors.black.withValues(alpha: 0.45),
          offset: const Offset(2.0, 2.0),
          blurRadius: 2.0,
        ),
      ],
    },
  ];

  final shadowTiles = List<Widget>.generate(
    shadowRecipes.length,
    (int i) {
      final Map<String, Object> rec = shadowRecipes[i];
      final String name = rec['name'] as String;
      final IconData iconData = rec['icon'] as IconData;
      final Color tint = rec['tint'] as Color;
      final List<Shadow> shadows = rec['shadows'] as List<Shadow>;
      return Container(
        width: 130.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: tint.withValues(alpha: 0.45),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                color: tint,
                size: 44.0,
                shadows: shadows,
              ),
              child: Icon(iconData),
            ),
            const SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: tint,
              ),
            ),
            Text(
              '${shadows.length} layer${shadows.length == 1 ? '' : 's'}',
              style: const TextStyle(
                fontSize: 10.0,
                color: Color(0xFF607D8B),
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 6: NESTED INHERITANCE — parent + child IconTheme
  // ==========================================================================
  // Outer IconTheme defines a blue 28px style. Inner IconTheme is `merge`d in
  // and only overrides size, so color is inherited. We render three rows:
  //   - outer-only (uniform blue 28px)
  //   - inner replace (full override -> orange 48px)
  //   - inner merge (size 48 from inner, color inherited blue)

  final outerColor = const Color(0xFF1E88E5);
  final innerColor = const Color(0xFFFB8C00);
  final iconSet = <IconData>[
    Icons.cloud,
    Icons.wb_sunny,
    Icons.ac_unit,
    Icons.thunderstorm,
    Icons.water_drop,
  ];

  final outerOnlyRow = IconTheme(
    data: IconThemeData(color: outerColor, size: 28.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        iconSet.length,
        (int i) => Icon(iconSet[i]),
      ),
    ),
  );

  final innerReplaceRow = IconTheme(
    data: IconThemeData(color: outerColor, size: 28.0),
    child: IconTheme(
      data: IconThemeData(color: innerColor, size: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          iconSet.length,
          (int i) => Icon(iconSet[i]),
        ),
      ),
    ),
  );

  final innerMergeRow = IconTheme(
    data: IconThemeData(color: outerColor, size: 28.0),
    child: IconTheme.merge(
      data: const IconThemeData(size: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          iconSet.length,
          (int i) => Icon(iconSet[i]),
        ),
      ),
    ),
  );

  // ==========================================================================
  // SECTION 7: MATERIAL SYMBOLS AXES — weight, grade, opticalSize, fill
  // ==========================================================================
  // Material Symbols expose four variable-font axes. They only render visibly
  // when the font itself is a variable Material Symbols font, but the
  // IconThemeData fields are always valid. We display each axis as a row of
  // chips showing the parameter values being threaded through IconTheme.

  final weightSteps = <double>[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0];
  final weightTiles = List<Widget>.generate(
    weightSteps.length,
    (int i) {
      final double w = weightSteps[i];
      final double t = (w - 100.0) / 600.0;
      final Color tint = Color.lerp(
        const Color(0xFFB0BEC5),
        const Color(0xFF263238),
        t,
      )!;
      return _AxisTile(
        label: 'w ${w.toStringAsFixed(0)}',
        tint: tint,
        data: IconThemeData(color: tint, size: 38.0, weight: w),
        icon: Icons.brightness_4,
      );
    },
  );

  final gradeSteps = <double>[-25.0, 0.0, 100.0, 200.0];
  final gradeTiles = List<Widget>.generate(
    gradeSteps.length,
    (int i) {
      final double g = gradeSteps[i];
      final double t = (g + 25.0) / 225.0;
      final Color tint = Color.lerp(
        const Color(0xFF80DEEA),
        const Color(0xFF006064),
        t,
      )!;
      return _AxisTile(
        label: 'g ${g.toStringAsFixed(0)}',
        tint: tint,
        data: IconThemeData(color: tint, size: 38.0, grade: g),
        icon: Icons.tune,
      );
    },
  );

  final opticalSteps = <double>[20.0, 24.0, 40.0, 48.0];
  final opticalTiles = List<Widget>.generate(
    opticalSteps.length,
    (int i) {
      final double o = opticalSteps[i];
      final double t = (o - 20.0) / 28.0;
      final Color tint = Color.lerp(
        const Color(0xFFCE93D8),
        const Color(0xFF4A148C),
        t,
      )!;
      return _AxisTile(
        label: 'o ${o.toStringAsFixed(0)}',
        tint: tint,
        data: IconThemeData(color: tint, size: o, opticalSize: o),
        icon: Icons.bubble_chart,
      );
    },
  );

  final fillSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final fillTiles = List<Widget>.generate(
    fillSteps.length,
    (int i) {
      final double f = fillSteps[i];
      final Color tint = Color.lerp(
        const Color(0xFFFFCDD2),
        const Color(0xFFB71C1C),
        f,
      )!;
      return _AxisTile(
        label: 'f ${f.toStringAsFixed(2)}',
        tint: tint,
        data: IconThemeData(color: tint, size: 38.0, fill: f),
        icon: Icons.favorite,
      );
    },
  );

  // ==========================================================================
  // SECTION 8: LIGHT vs DARK ADAPTATION
  // ==========================================================================
  // Two surfaces — light card and dark card — show the same icon set with
  // an IconTheme tuned to each. Demonstrates the common pattern of letting
  // Theme.of(context).iconTheme pick contrasting colors per brightness.

  final adaptiveIcons = <IconData>[
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.settings,
    Icons.person,
  ];

  final lightSurface = _BrightnessSurface(
    label: 'Light surface',
    background: const Color(0xFFF5F7FA),
    foreground: const Color(0xFF1A237E),
    accent: const Color(0xFF3949AB),
    data: const IconThemeData(color: Color(0xFF1A237E), size: 30.0),
    icons: adaptiveIcons,
  );

  final darkSurface = _BrightnessSurface(
    label: 'Dark surface',
    background: const Color(0xFF1A237E),
    foreground: const Color(0xFFE8EAF6),
    accent: const Color(0xFF7986CB),
    data: const IconThemeData(color: Color(0xFFE8EAF6), size: 30.0),
    icons: adaptiveIcons,
  );

  // ==========================================================================
  // SECTION 9: REAL-WORLD WRAPPERS — toolbar, badge, tile
  // ==========================================================================
  // Patterns where IconTheme is the natural integration point: toolbars
  // override the size+color for action icons, badges shrink and recolor,
  // ListTile leading uses inherited IconTheme via IconTheme.of(context).

  final toolbar = Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1B5E20).withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: IconTheme(
      data: const IconThemeData(color: Colors.white, size: 22.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.menu),
          const SizedBox(width: 14.0),
          const Text(
            'Toolbar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.search),
          const SizedBox(width: 14.0),
          const Icon(Icons.notifications_none),
          const SizedBox(width: 14.0),
          const Icon(Icons.more_vert),
        ],
      ),
    ),
  );

  final badgeRow = IconTheme(
    data: const IconThemeData(color: Color(0xFFAD1457), size: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _badge(const Icon(Icons.shopping_cart), '3'),
        _badge(const Icon(Icons.email_outlined), '12'),
        _badge(const Icon(Icons.chat_bubble_outline), '99+'),
        _badge(const Icon(Icons.cloud_download), 'new'),
      ],
    ),
  );

  final listTileColumn = Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFFBC02D), width: 1.0),
    ),
    child: IconTheme(
      data: const IconThemeData(color: Color(0xFFF57F17), size: 26.0),
      child: Column(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Inbox'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1.0),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('Sent'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1.0),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Archive'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 1.0),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Trash'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 10: IconTheme.of(context) — reading the ambient theme
  // ==========================================================================
  // IconTheme.of(context) walks up to the nearest IconTheme. We expose the
  // ambient IconThemeData and render a fact box.

  final IconThemeData ambient = IconTheme.of(context);
  final ambientBox = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFF43A047), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.info_outline,
              color: Color(0xFF1B5E20),
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'IconTheme.of(context)',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _factLine('color', _describeColor(ambient.color)),
        _factLine('size', _formatDouble(ambient.size)),
        _factLine('opacity', _formatDouble(ambient.opacity)),
        _factLine('fill', _formatDouble(ambient.fill)),
        _factLine('weight', _formatDouble(ambient.weight)),
        _factLine('grade', _formatDouble(ambient.grade)),
        _factLine('opticalSize', _formatDouble(ambient.opticalSize)),
        _factLine(
          'applyTextScaling',
          ambient.applyTextScaling == null
              ? 'null'
              : ambient.applyTextScaling.toString(),
        ),
        _factLine(
          'shadows',
          ambient.shadows == null
              ? 'null'
              : '${ambient.shadows!.length} shadow(s)',
        ),
        _factLine('isConcrete', ambient.isConcrete.toString()),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 11: CASCADING DEMO — a deeply nested IconTheme chain
  // ==========================================================================
  // Each level adds one attribute via IconTheme.merge so the leaf icon inherits
  // attributes contributed at four different depths.

  final cascadingChain = IconTheme(
    data: const IconThemeData(color: Color(0xFF6A1B9A)), // level 1: color
    child: IconTheme.merge(
      data: const IconThemeData(size: 40.0), // level 2: size
      child: IconTheme.merge(
        data: const IconThemeData(opacity: 0.85), // level 3: opacity
        child: IconTheme.merge(
          data: IconThemeData(
            shadows: <Shadow>[
              Shadow(
                color: const Color(0xFF6A1B9A).withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ], // level 4: shadows
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.spa),
              Icon(Icons.local_florist),
              Icon(Icons.park),
              Icon(Icons.eco),
              Icon(Icons.forest),
            ],
          ),
        ),
      ),
    ),
  );

  // ==========================================================================
  // SECTION 12: SIDE-BY-SIDE — raw Icon (size param) vs IconTheme override
  // ==========================================================================
  // Demonstrates that direct Icon arguments still win over IconTheme defaults.

  final overrideMatrix = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: _MiniSurface(
          title: 'Theme default only',
          subtitle: 'IconTheme(blue, 32) → no overrides',
          child: IconTheme(
            data: const IconThemeData(
              color: Color(0xFF1976D2),
              size: 32.0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.bookmark_outline),
                Icon(Icons.bookmark),
                Icon(Icons.bookmark_added),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: _MiniSurface(
          title: 'Per-icon override',
          subtitle: 'IconTheme(blue, 32) + color/size on Icon',
          child: IconTheme(
            data: const IconThemeData(
              color: Color(0xFF1976D2),
              size: 32.0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.bookmark_outline),
                Icon(Icons.bookmark, color: Color(0xFFFF7043), size: 48.0),
                Icon(Icons.bookmark_added),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 13: PROVENANCE LINE — every IconThemeData factory we touched
  // ==========================================================================

  final provenanceLog = <String>[
    'basicIconTheme.color=${_describeColor(basicIconTheme.color)}',
    'coloredIconTheme.color=${_describeColor(coloredIconTheme.color)}',
    'opacityIconTheme.opacity=${_formatDouble(opacityIconTheme.opacity)}',
    'sizedIconTheme.size=${_formatDouble(sizedIconTheme.size)}',
    'filledIconTheme.fill=${_formatDouble(filledIconTheme.fill)}',
    'weightedIconTheme.weight=${_formatDouble(weightedIconTheme.weight)}',
    'gradedIconTheme.grade=${_formatDouble(gradedIconTheme.grade)}',
    'opticalIconTheme.opticalSize=${_formatDouble(opticalIconTheme.opticalSize)}',
    'shadowedIconTheme.shadows.length=${shadowedIconTheme.shadows?.length ?? 0}',
    'scaledIconTheme.applyTextScaling=${scaledIconTheme.applyTextScaling}',
    'fullIconTheme.color=${_describeColor(fullIconTheme.color)} size=${_formatDouble(fullIconTheme.size)}',
    'copiedIconTheme.color=${_describeColor(copiedIconTheme.color)} size=${_formatDouble(copiedIconTheme.size)}',
    'mergedTheme.color=${_describeColor(mergedTheme.color)} size=${_formatDouble(mergedTheme.size)} opacity=${_formatDouble(mergedTheme.opacity)}',
    'resolvedTheme.color=${_describeColor(resolvedTheme.color)}',
    'concreteTheme.isConcrete=$concreteFlag',
    'ambient(IconTheme.of).color=${_describeColor(ambient.color)}',
  ];
  final provenanceTiles = List<Widget>.generate(
    provenanceLog.length,
    (int i) {
      final String entry = provenanceLog[i];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 22.0,
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF455A64).withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF455A64),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                entry,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: Color(0xFF263238),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 14: FINAL COMPOSITION — every piece together
  // ==========================================================================

  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFC),
    appBar: AppBar(
      backgroundColor: const Color(0xFF3F51B5),
      foregroundColor: Colors.white,
      title: const Text(
        'IconTheme — Deep Visual Atlas',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: const <Widget>[
        IconTheme(
          data: IconThemeData(color: Colors.white, size: 22.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.palette_outlined),
                SizedBox(width: 14.0),
                Icon(Icons.tune),
                SizedBox(width: 14.0),
                Icon(Icons.info_outline),
              ],
            ),
          ),
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // --- Prologue ---
          prologueCard,
          const SizedBox(height: 18.0),

          // --- Section 1: data specimens ---
          _SectionHeader(
            number: 1,
            title: 'IconThemeData constructors',
            blurb:
                'Every named parameter has its own specimen tile. Click through '
                'them mentally: each card answers "what does this single field '
                'actually mean?"',
            accent: const Color(0xFF3949AB),
          ),
          Wrap(children: dataSpecimenTiles),
          const SizedBox(height: 8.0),

          // Inline reference samples to ensure the named theme objects above are
          // visually exercised (not just constructed).
          _MiniSurface(
            title: 'Sample renders from named themes',
            subtitle: 'colored / shadowed / full / merged / copied',
            child: Wrap(
              spacing: 14.0,
              runSpacing: 10.0,
              children: <Widget>[
                _NamedThemeChip(label: 'colored', data: coloredIconTheme, icon: Icons.bookmark),
                _NamedThemeChip(label: 'sized', data: sizedIconTheme, icon: Icons.work),
                _NamedThemeChip(label: 'opacity', data: opacityIconTheme, icon: Icons.visibility),
                _NamedThemeChip(label: 'shadowed', data: shadowedIconTheme, icon: Icons.star),
                _NamedThemeChip(label: 'full', data: fullIconTheme, icon: Icons.auto_awesome),
                _NamedThemeChip(label: 'copied', data: copiedIconTheme, icon: Icons.style),
                _NamedThemeChip(label: 'merged', data: mergedTheme, icon: Icons.merge_type),
                _NamedThemeChip(label: 'resolved', data: resolvedTheme, icon: Icons.check_circle),
                _NamedThemeChip(label: 'concrete', data: concreteTheme, icon: Icons.fact_check),
              ],
            ),
          ),
          const SizedBox(height: 22.0),

          // --- Section 2: palette ---
          _SectionHeader(
            number: 2,
            title: 'Color palette',
            blurb:
                'Each tile wraps a single Icon in its own IconTheme. The icon '
                'has no color argument; the only way the tint reaches the '
                'glyph is the inherited IconThemeData.color.',
            accent: const Color(0xFF8E24AA),
          ),
          Wrap(children: paletteTiles),
          const SizedBox(height: 22.0),

          // --- Section 3: size ladder ---
          _SectionHeader(
            number: 3,
            title: 'Size ladder',
            blurb:
                'IconTheme.size scales the same glyph from 12 px to 96 px. '
                'The default Icon size of 24 lives somewhere in the middle.',
            accent: const Color(0xFF00897B),
          ),
          Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: sizeTiles),
          const SizedBox(height: 22.0),

          // --- Section 4: opacity ramp ---
          _SectionHeader(
            number: 4,
            title: 'Opacity ramp',
            blurb:
                'IconThemeData.opacity multiplies the final glyph color\'s '
                'alpha. Values outside [0, 1] are clamped.',
            accent: const Color(0xFF455A64),
          ),
          Wrap(children: opacityTiles),
          const SizedBox(height: 22.0),

          // --- Section 5: shadows ---
          _SectionHeader(
            number: 5,
            title: 'Shadow recipes',
            blurb:
                'IconThemeData.shadows accepts a list of Shadow objects. '
                'Stacking multiple shadows lets you compose glow + offset + '
                'duotone effects without touching the Icon directly.',
            accent: const Color(0xFFD84315),
          ),
          Wrap(children: shadowTiles),
          const SizedBox(height: 22.0),

          // --- Section 6: nested inheritance ---
          _SectionHeader(
            number: 6,
            title: 'Nested IconTheme inheritance',
            blurb:
                'Outer IconTheme is blue-28. Inner full IconTheme replaces it '
                'entirely; IconTheme.merge only overrides what it specifies.',
            accent: const Color(0xFF1565C0),
          ),
          _LabeledRow(
            label: 'Outer only — IconTheme(blue, 28)',
            child: outerOnlyRow,
          ),
          const SizedBox(height: 12.0),
          _LabeledRow(
            label:
                'Inner replace — IconTheme(orange, 48) inside IconTheme(blue, 28)',
            child: innerReplaceRow,
          ),
          const SizedBox(height: 12.0),
          _LabeledRow(
            label: 'Inner merge — IconTheme.merge(size: 48) keeps blue color',
            child: innerMergeRow,
          ),
          const SizedBox(height: 22.0),

          // --- Section 7: material symbol axes ---
          _SectionHeader(
            number: 7,
            title: 'Material Symbols axes',
            blurb:
                'Variable-font axes — weight, grade, opticalSize, fill — are '
                'all first-class IconThemeData fields. They\'re inherited just '
                'like color and size.',
            accent: const Color(0xFF4E342E),
          ),
          _LabeledRow(label: 'weight (100 → 700)', child: Wrap(children: weightTiles)),
          const SizedBox(height: 10.0),
          _LabeledRow(label: 'grade (-25 → 200)', child: Wrap(children: gradeTiles)),
          const SizedBox(height: 10.0),
          _LabeledRow(label: 'opticalSize (20 → 48)', child: Wrap(children: opticalTiles)),
          const SizedBox(height: 10.0),
          _LabeledRow(label: 'fill (0.0 → 1.0)', child: Wrap(children: fillTiles)),
          const SizedBox(height: 22.0),

          // --- Section 8: light / dark adaptation ---
          _SectionHeader(
            number: 8,
            title: 'Light / dark adaptation',
            blurb:
                'In a real app, Theme.of(context).iconTheme would already '
                'carry brightness-appropriate defaults. Here we install two '
                'explicit IconThemes side by side.',
            accent: const Color(0xFF263238),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: lightSurface),
              const SizedBox(width: 14.0),
              Expanded(child: darkSurface),
            ],
          ),
          const SizedBox(height: 22.0),

          // --- Section 9: real-world wrappers ---
          _SectionHeader(
            number: 9,
            title: 'Real-world wrappers',
            blurb:
                'Toolbars, badge clusters, and ListTile leading slots are the '
                'canonical places to install an IconTheme.',
            accent: const Color(0xFF2E7D32),
          ),
          toolbar,
          const SizedBox(height: 14.0),
          _LabeledRow(label: 'Badges (IconTheme provides tint+size)', child: badgeRow),
          const SizedBox(height: 14.0),
          _LabeledRow(label: 'ListTile cluster', child: listTileColumn),
          const SizedBox(height: 22.0),

          // --- Section 10: IconTheme.of ---
          _SectionHeader(
            number: 10,
            title: 'Reading the ambient theme',
            blurb:
                'IconTheme.of(context) returns the merged IconThemeData '
                'inherited from above. This is what every Icon widget calls '
                'internally to find its defaults.',
            accent: const Color(0xFF1B5E20),
          ),
          ambientBox,
          const SizedBox(height: 22.0),

          // --- Section 11: cascading chain ---
          _SectionHeader(
            number: 11,
            title: 'Cascading IconTheme.merge chain',
            blurb:
                'Four nested IconTheme.merge widgets each contribute one '
                'attribute. The leaf icons inherit color + size + opacity + '
                'shadows without anyone setting all four in a single spot.',
            accent: const Color(0xFF6A1B9A),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFCE93D8), width: 1.0),
            ),
            child: cascadingChain,
          ),
          const SizedBox(height: 22.0),

          // --- Section 12: override matrix ---
          _SectionHeader(
            number: 12,
            title: 'Theme vs explicit override',
            blurb:
                'Arguments on the Icon widget itself always win against the '
                'inherited IconTheme. Useful for "highlight one element of a '
                'row".',
            accent: const Color(0xFFEF6C00),
          ),
          overrideMatrix,
          const SizedBox(height: 22.0),

          // --- Section 13: provenance log ---
          _SectionHeader(
            number: 13,
            title: 'Provenance log',
            blurb:
                'A flat list of every IconThemeData we constructed in this '
                'demo, with the property that proves it was actually built.',
            accent: const Color(0xFF37474F),
          ),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFFCFD8DC),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provenanceTiles,
            ),
          ),
          const SizedBox(height: 22.0),

          // --- Section 14: closing ---
          _SectionHeader(
            number: 14,
            title: 'Epilogue',
            blurb:
                'IconTheme is one of the most under-used InheritedWidgets in '
                'Flutter. Treat it like TextStyle\'s twin: install it at the '
                'boundary of every visually-coherent region and let your Icon '
                'widgets stay parameter-free.',
            accent: const Color(0xFF3F51B5),
          ),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF3F51B5), Color(0xFF5C6BC0)],
              ),
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF3F51B5).withValues(alpha: 0.35),
                  blurRadius: 14.0,
                  offset: const Offset(0.0, 6.0),
                ),
              ],
            ),
            child: const IconTheme(
              data: IconThemeData(color: Colors.white, size: 26.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.check_circle_outline),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      'Atlas complete — 14 sections, every IconThemeData '
                      'parameter exercised, with visual proof of inheritance.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28.0),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPERS — small composable widgets used across the sections.
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.blurb,
    required this.accent,
  });

  final int number;
  final String title;
  final String blurb;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              blurb,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF455A64),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.only(left: 40.0),
            height: 2.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.7),
                  accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final Color accent;
  final String title;
  final String subtitle;
  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.12),
            accent.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconTheme(
                data: IconThemeData(color: accent, size: 30.0),
                child: const Icon(Icons.auto_stories),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: accent.withValues(alpha: 0.75),
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          ...body,
        ],
      ),
    );
  }
}

class _AxisTile extends StatelessWidget {
  const _AxisTile({
    required this.label,
    required this.tint,
    required this.data,
    required this.icon,
  });

  final String label;
  final Color tint;
  final IconThemeData data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tint.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme(
            data: data,
            child: Icon(icon),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: tint,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _BrightnessSurface extends StatelessWidget {
  const _BrightnessSurface({
    required this.label,
    required this.background,
    required this.foreground,
    required this.accent,
    required this.data,
    required this.icons,
  });

  final String label;
  final Color background;
  final Color foreground;
  final Color accent;
  final IconThemeData data;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: background.withValues(alpha: 0.35),
            blurRadius: 10.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          IconTheme(
            data: data,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(
                icons.length,
                (int i) => Icon(icons[i]),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'IconTheme(color: ${_describeColor(data.color)}, size: ${_formatDouble(data.size)})',
            style: TextStyle(
              color: foreground.withValues(alpha: 0.75),
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF455A64),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    );
  }
}

class _MiniSurface extends StatelessWidget {
  const _MiniSurface({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFCFD8DC), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF607D8B),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    );
  }
}

class _NamedThemeChip extends StatelessWidget {
  const _NamedThemeChip({
    required this.label,
    required this.data,
    required this.icon,
  });

  final String label;
  final IconThemeData data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Color tint = data.color ?? const Color(0xFF455A64);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: tint.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme(
            data: data,
            child: Icon(icon),
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: tint,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _badge(Widget child, String label) {
  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      child,
      Positioned(
        right: -8.0,
        top: -6.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFFD81B60),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _factLine(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFF455A64),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

String _describeColor(Color? color) {
  if (color == null) {
    return 'null';
  }
  // Use the toARGB32 path via .value (still stable in 3.x).
  final int v = color.toARGB32();
  return '#${v.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

String _formatDouble(double? v) {
  if (v == null) {
    return 'null';
  }
  return v.toStringAsFixed(2);
}
