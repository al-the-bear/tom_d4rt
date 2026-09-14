// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: MaterialType enum from package:flutter/material.dart
//
// MaterialType controls the *shape* and *clipping* model of a Material widget.
// It is one of the most fundamental drawing primitives in the Material library:
// every elevated card, every circular avatar with a ripple, every transparent
// inkwell ultimately resolves to a Material with one of these five types.
//
// Values (verified against bridges/material_widgets_bridges.b.dart):
//   - MaterialType.canvas        : default flat surface, full background paint
//   - MaterialType.card          : rounded rectangle surface (cards, dialogs)
//   - MaterialType.circle        : circular surface (avatars, FABs)
//   - MaterialType.button        : rounded surface tuned for buttons
//   - MaterialType.transparency  : no background paint, ink still draws
//
// This demo renders an instructive, hand-authored visual reference for each
// value: definitions, anatomy, side-by-side comparison, recipes, pitfalls,
// and elevation-interaction notes.
//
// Harness contract: build() is invoked exactly once. No setState, no Timers,
// no AnimationControllers. Everything is a static description of the enum.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MaterialType Deep Demo: starting ===');
  print('Enum location: package:flutter/src/material/material.dart');
  print('Enum size: ${MaterialType.values.length} values');

  // Print each value with its index, so the harness log doubles as a quick
  // textual reference of the enum's runtime ordering.
  for (final t in MaterialType.values) {
    print('  - MaterialType.${t.name} (index=${t.index})');
  }

  // ============================================================
  // PALETTES (one per section, varied)
  // ============================================================
  // Section 1 (header):       indigo / deep purple
  // Section 2 (anatomy):      teal / cyan
  // Section 3 (per-value):    canvas=blueGrey, card=blue, circle=pink,
  //                           button=amber, transparency=green
  // Section 4 (comparison):   neutral grey + accent of each value
  // Section 5 (recipes):      raised=blue, avatar=pink, overlay=green
  // Section 6 (elevation):    deepOrange / amber
  // Section 7 (pitfalls):     red / orange warning
  // Section 8 (decision):     purple
  // Section 9 (footer):       slate / charcoal

  // ============================================================
  // SECTION 1: HERO HEADER
  // ============================================================
  print('--- Building Section 1: Hero Header ---');

  final header = Container(
    margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF1A237E), // indigo 900
          Color(0xFF311B92), // deep purple 900
          Color(0xFF4A148C), // purple 900
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.35),
          blurRadius: 60.0,
          spreadRadius: -8.0,
          offset: const Offset(0.0, 24.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.layers_rounded,
                color: Colors.white,
                size: 48.0,
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'MaterialType',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'The five shapes of a Flutter Material surface',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: const Text(
            'enum MaterialType { canvas, card, circle, button, transparency }',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.cyanAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _buildBadge('5 values', Colors.white),
            _buildBadge('Material widget', Colors.amberAccent),
            _buildBadge('shape + clip', Colors.cyanAccent),
            _buildBadge('elevation aware', Colors.lightGreenAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY of a Material widget
  // ============================================================
  print('--- Building Section 2: Anatomy of Material ---');

  final anatomy = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_rounded,
                color: Colors.teal.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Anatomy of a Material widget',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'MaterialType is one knob among many — but it dictates which paint '
          'pipeline runs. The other fields decorate that surface.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.teal.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        // Live mock Material widget with labelled fields
        Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Material(
                type: MaterialType.card,
                elevation: 6.0,
                color: Colors.white,
                shadowColor: Colors.teal.shade400,
                borderRadius: BorderRadius.circular(14.0),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 260.0,
                  height: 140.0,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Material',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'type: card\nelevation: 6\ncolor: white',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Field table
        _buildAnatomyField('type',
            'MaterialType — selects shape & clipping model', Colors.indigo),
        _buildAnatomyField(
            'elevation', 'double — depth in dp (0 = flat)', Colors.deepOrange),
        _buildAnatomyField(
            'color', 'Color — surface fill (ignored when transparency)',
            Colors.pink),
        _buildAnatomyField(
            'shape', 'ShapeBorder — overrides per-type default shape',
            Colors.purple),
        _buildAnatomyField(
            'borderRadius',
            'BorderRadiusGeometry — only valid for canvas/card/button',
            Colors.green),
        _buildAnatomyField('clipBehavior',
            'Clip — none / hardEdge / antiAlias / antiAliasWithSaveLayer',
            Colors.brown),
        _buildAnatomyField(
            'shadowColor', 'Color? — color of the dropped shadow', Colors.blue),
        _buildAnatomyField('child', 'Widget? — what lives on the surface',
            Colors.teal),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PER-VALUE CARDS (5 cards)
  // ============================================================
  print('--- Building Section 3: Per-value cards ---');

  final canvasCard = _buildValueCard(
    type: MaterialType.canvas,
    icon: Icons.crop_square_rounded,
    accent: Colors.blueGrey,
    paletteLight: Colors.blueGrey.shade50,
    paletteDeep: Colors.blueGrey.shade700,
    headline: 'The default flat sheet',
    definition:
        'MaterialType.canvas paints a full rectangular background using '
        'the given color. It is the *default* — when you place a Material '
        'in your tree without specifying a type, this is what you get. '
        'Its shape is rectangular by default, but a borderRadius (or full '
        'shape) may be supplied to round its corners.',
    sample: Material(
      type: MaterialType.canvas,
      color: Colors.blueGrey.shade100,
      elevation: 2.0,
      child: Container(
        width: 220.0,
        height: 110.0,
        alignment: Alignment.center,
        child: Text(
          'canvas\n(rectangular sheet)',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    whenToUse: const [
      'The base "page" or "surface" of a screen',
      'Backgrounds for sheets, panes, drawers',
      'Anywhere you want a flat, full-bleed colour',
    ],
    pitfalls: const [
      'Default has NO rounding — supply borderRadius for rounded corners',
      'Color is required to actually paint anything',
    ],
  );

  final cardCard = _buildValueCard(
    type: MaterialType.card,
    icon: Icons.credit_card_rounded,
    accent: Colors.blue,
    paletteLight: Colors.blue.shade50,
    paletteDeep: Colors.blue.shade800,
    headline: 'Rounded rectangle surface',
    definition:
        'MaterialType.card produces a rounded-rectangle surface — the '
        'shape Material Design refers to as a "card". It has a small '
        'default radius and is the canonical building block of dialogs, '
        'list items, and the Card widget itself.',
    sample: Material(
      type: MaterialType.card,
      color: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.blue.shade300,
      child: Container(
        width: 220.0,
        height: 110.0,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Standup',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800)),
            const SizedBox(height: 4.0),
            Text('09:30 — 09:45',
                style: TextStyle(
                    fontSize: 11.0, color: Colors.blue.shade600)),
            const Spacer(),
            Text('type: card',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.grey.shade600)),
          ],
        ),
      ),
    ),
    whenToUse: const [
      'List item containers (e.g. ListTile backgrounds)',
      'Modal dialogs, alerts, snackbars',
      'Information cards in feeds and dashboards',
    ],
    pitfalls: const [
      'The default radius is small (~2dp). Use Card or override shape '
          'for the larger Material 3 radius',
      'borderRadius and shape conflict — set only one',
    ],
  );

  final circleCard = _buildValueCard(
    type: MaterialType.circle,
    icon: Icons.circle_outlined,
    accent: Colors.pink,
    paletteLight: Colors.pink.shade50,
    paletteDeep: Colors.pink.shade800,
    headline: 'Perfectly round surface',
    definition:
        'MaterialType.circle creates a circular Material. The widget '
        'must be sized to a square — Flutter inscribes the circle inside '
        'the box. This is the underpinning of CircleAvatar and the '
        'default FloatingActionButton.',
    sample: Center(
      child: Material(
        type: MaterialType.circle,
        color: Colors.pink.shade300,
        elevation: 6.0,
        shadowColor: Colors.pink.shade200,
        child: SizedBox(
          width: 96.0,
          height: 96.0,
          child: Center(
            child: Text(
              'AK',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade50,
              ),
            ),
          ),
        ),
      ),
    ),
    whenToUse: const [
      'Avatars, profile pictures',
      'Floating action buttons & icon badges',
      'Round status indicators with ripple feedback',
    ],
    pitfalls: const [
      'Do NOT set borderRadius — it is illegal for circle (assert)',
      'Always wrap in a square (SizedBox.square) or it stretches into '
          'an oval-clipping rectangle',
    ],
  );

  final buttonCard = _buildValueCard(
    type: MaterialType.button,
    icon: Icons.smart_button_rounded,
    accent: Colors.amber,
    paletteLight: Colors.amber.shade50,
    paletteDeep: Colors.amber.shade900,
    headline: 'A surface tuned for buttons',
    definition:
        'MaterialType.button is identical to a card in the geometric '
        'sense, but its default radius matches MaterialButton (kThemeChange '
        'durations etc). Most modern code uses ElevatedButton/TextButton/'
        'FilledButton instead — those wrap a Material(type: button) '
        'internally.',
    sample: Material(
      type: MaterialType.button,
      color: Colors.amber.shade400,
      elevation: 3.0,
      shadowColor: Colors.amber.shade700,
      child: Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        alignment: Alignment.center,
        child: Text(
          'CONFIRM',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
    whenToUse: const [
      'Custom button shells where the new button widgets feel too rigid',
      'Implementing a bespoke design system primitive',
      'Theming legacy MaterialButton-based code',
    ],
    pitfalls: const [
      'Prefer ElevatedButton / FilledButton / TextButton for new code',
      'You still need an InkWell / GestureDetector inside to handle taps',
    ],
  );

  final transparencyCard = _buildValueCard(
    type: MaterialType.transparency,
    icon: Icons.blur_on_rounded,
    accent: Colors.green,
    paletteLight: Colors.green.shade50,
    paletteDeep: Colors.green.shade800,
    headline: 'Ink without a sheet',
    definition:
        'MaterialType.transparency draws *no* background fill — but '
        'an InkWell still works above it. Use it when you need ripple '
        'feedback to land on whatever is painted *behind* the Material '
        '(an image, a gradient, another widget).',
    sample: Container(
      // Show the underlying gradient — transparency reveals it.
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 220.0,
      height: 110.0,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Text(
            'transparency\n(see-through ink layer)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              shadows: const [
                Shadow(
                    color: Colors.black45, offset: Offset(0.0, 1.0),
                    blurRadius: 2.0),
              ],
            ),
          ),
        ),
      ),
    ),
    whenToUse: const [
      'Ripple effect over imagery (NetworkImage, AssetImage)',
      'Tap targets layered above complex CustomPaint output',
      'Decorative containers where the parent already paints the bg',
    ],
    pitfalls: const [
      'color and shadowColor are IGNORED — set them and nothing happens',
      'elevation is also irrelevant — there is no surface to lift',
      'borderRadius/shape are ignored — the ink area is rectangular',
    ],
  );

  // ============================================================
  // SECTION 4: SIDE-BY-SIDE COMPARISON
  // ============================================================
  print('--- Building Section 4: Side-by-side comparison ---');

  final comparison = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade300],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade500, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows_rounded,
                color: Colors.grey.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'All five, side by side',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Same elevation (4), same color (sky blue), same child. Only the '
          'type differs — note the shape and shadow contour.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 18.0,
          alignment: WrapAlignment.center,
          children: [
            _buildComparisonTile(MaterialType.canvas, Colors.blueGrey),
            _buildComparisonTile(MaterialType.card, Colors.blue),
            _buildComparisonTile(MaterialType.circle, Colors.pink),
            _buildComparisonTile(MaterialType.button, Colors.amber),
            _buildComparisonTile(MaterialType.transparency, Colors.green),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Same widget, five flavours\n'
            'Material(type: MaterialType.canvas,       elevation: 4, color: c, child: x);\n'
            'Material(type: MaterialType.card,         elevation: 4, color: c, child: x);\n'
            'Material(type: MaterialType.circle,       elevation: 4, color: c, child: x);\n'
            'Material(type: MaterialType.button,       elevation: 4, color: c, child: x);\n'
            'Material(type: MaterialType.transparency, elevation: 4, color: c, child: x);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: RECIPES
  // ============================================================
  print('--- Building Section 5: Recipes ---');

  // Recipe 1: Raised feature card
  final recipeRaisedCard = _buildRecipe(
    title: 'Raised feature card',
    subtitle: 'MaterialType.card + elevation 8 + shaped shadow',
    accent: Colors.blue,
    mock: Material(
      type: MaterialType.card,
      elevation: 8.0,
      color: Colors.white,
      shadowColor: Colors.blue.shade300,
      borderRadius: BorderRadius.circular(16.0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 260.0,
        height: 130.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bolt, color: Colors.blue.shade700, size: 32.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Performance',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900)),
                  const SizedBox(height: 4.0),
                  Text(
                    'Sub-millisecond ink response on every tap.',
                    style: TextStyle(
                        fontSize: 11.0, color: Colors.blue.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    code: 'Material(\n'
        '  type: MaterialType.card,\n'
        '  elevation: 8.0,\n'
        '  shadowColor: Colors.blue.shade300,\n'
        '  borderRadius: BorderRadius.circular(16.0),\n'
        '  clipBehavior: Clip.antiAlias,\n'
        '  child: ...,\n'
        ')',
  );

  // Recipe 2: Circular avatar with ripple
  final recipeAvatar = _buildRecipe(
    title: 'Circular avatar with ripple',
    subtitle: 'MaterialType.circle + InkWell child',
    accent: Colors.pink,
    mock: Material(
      type: MaterialType.circle,
      color: Colors.pink.shade200,
      elevation: 4.0,
      shadowColor: Colors.pink.shade400,
      child: SizedBox(
        width: 96.0,
        height: 96.0,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: null, // demo only
          child: Center(
            child: Icon(Icons.person, color: Colors.pink.shade50, size: 56.0),
          ),
        ),
      ),
    ),
    code: 'Material(\n'
        '  type: MaterialType.circle,\n'
        '  color: Colors.pink.shade200,\n'
        '  elevation: 4.0,\n'
        '  child: SizedBox.square(\n'
        '    dimension: 96,\n'
        '    child: InkWell(\n'
        '      customBorder: const CircleBorder(),\n'
        '      onTap: () {},\n'
        '      child: ...,\n'
        '    ),\n'
        '  ),\n'
        ')',
  );

  // Recipe 3: Transparent overlay over imagery
  final recipeTransparent = _buildRecipe(
    title: 'Transparent ripple over imagery',
    subtitle: 'MaterialType.transparency + InkWell over a gradient',
    accent: Colors.green,
    mock: Container(
      width: 260.0,
      height: 130.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.teal.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: null,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.touch_app, color: Colors.white, size: 32.0),
                SizedBox(height: 4.0),
                Text(
                  'Tap to reveal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    code: 'Container(\n'
        '  decoration: BoxDecoration(gradient: ...),\n'
        '  child: Material(\n'
        '    type: MaterialType.transparency,\n'
        '    child: InkWell(\n'
        '      onTap: () {},\n'
        '      child: ...,\n'
        '    ),\n'
        '  ),\n'
        ')',
  );

  // ============================================================
  // SECTION 6: ELEVATION INTERACTION
  // ============================================================
  print('--- Building Section 6: Elevation interaction ---');

  final elevationSection = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_clear_rounded,
                color: Colors.deepOrange.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'How MaterialType combines with elevation',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Elevation is the *Z* axis — it determines shadow blur and the '
          'tonal-overlay tint in M3. The shape from MaterialType determines '
          'the *outline* that the shadow follows.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepOrange.shade800,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18.0),
        // Grid of (type x elevation)
        for (final t in const [
          MaterialType.canvas,
          MaterialType.card,
          MaterialType.circle,
          MaterialType.button,
        ])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 110.0,
                  child: Text(
                    t.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade900,
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 14.0,
                    runSpacing: 10.0,
                    children: [
                      for (final e in const [0.0, 2.0, 6.0, 12.0])
                        _buildElevationSample(t, e),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border:
                Border.all(color: Colors.deepOrange.shade200, width: 1.0),
          ),
          child: Text(
            'Note: transparency cannot show elevation — there is no surface '
            'to project a shadow from. Setting elevation > 0 on '
            'MaterialType.transparency is silently a no-op.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepOrange.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: PITFALLS & ASSERTS
  // ============================================================
  print('--- Building Section 7: Pitfalls ---');

  final pitfalls = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls and asserts you will hit',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildPitfall(
          'circle + borderRadius',
          'A Material with type: circle MUST NOT have borderRadius set. '
              'Flutter asserts in debug. Use shape only if you really need '
              'a non-default circle outline.',
          Colors.pink,
        ),
        _buildPitfall(
          'transparency + color',
          'Setting color/shadowColor/elevation on transparency is silently '
              'ignored. If you want a tinted ink target, paint the tint with '
              'a Container behind the Material.',
          Colors.green,
        ),
        _buildPitfall(
          'transparency + clipBehavior',
          'clipBehavior on transparency is also ignored — the ink is '
              'rectangular regardless. Wrap with ClipRRect/ClipOval if you '
              'need clipped ripples.',
          Colors.teal,
        ),
        _buildPitfall(
          'card + shape AND borderRadius',
          'Setting both shape and borderRadius asserts. Pick one — shape is '
              'the more general mechanism.',
          Colors.blue,
        ),
        _buildPitfall(
          'circle without square child',
          'A circle Material in a non-square box renders as a stadium / oval '
              'cropped to its bounds — almost always a layout bug. Wrap with '
              'SizedBox.square or AspectRatio.',
          Colors.purple,
        ),
        _buildPitfall(
          'canvas with no color',
          'MaterialType.canvas with color: null assumes the ambient '
              'ThemeData.canvasColor. If your theme is dark and you expected '
              'white, you will see a dark sheet.',
          Colors.brown,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: DECISION TREE
  // ============================================================
  print('--- Building Section 8: Decision tree ---');

  final decision = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined,
                color: Colors.purple.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Choosing the right MaterialType',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildDecisionRow(
          'Need ripple over an existing painted background?',
          'transparency',
          Colors.green,
        ),
        _buildDecisionRow(
          'Round avatar / FAB / circular badge?',
          'circle',
          Colors.pink,
        ),
        _buildDecisionRow(
          'Custom button shell (and you cannot use ElevatedButton)?',
          'button',
          Colors.amber,
        ),
        _buildDecisionRow(
          'List item, dialog, info card with rounded corners?',
          'card',
          Colors.blue,
        ),
        _buildDecisionRow(
          'Page surface, drawer, sheet — flat full-bleed background?',
          'canvas',
          Colors.blueGrey,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: FOOTER
  // ============================================================
  print('--- Building Section 9: Footer ---');

  const filePath =
      'tom_d4rt_flutter_ast/test/.../material/material_type_test.dart';

  final footer = Container(
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade700, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.article_outlined,
                color: Colors.cyanAccent.shade100, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'About this demo',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent.shade100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'Hand-authored visual reference for the MaterialType enum. Every '
          'value is exhibited with a real Material widget so the rendered '
          'output (shape, shadow, ripple area) matches the printed prose.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade300,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            // ASCII box. Hand-drawn.
            '+----------------------------------------------------------+\n'
            '|  MaterialType :: deep visual demo                        |\n'
            '+----------------------------------------------------------+\n'
            '|  values  : canvas | card | circle | button | transparency|\n'
            '|  count   : 5                                             |\n'
            '|  source  : package:flutter/src/material/material.dart    |\n'
            '|  bridge  : material_widgets_bridges.b.dart  (line ~1550) |\n'
            '|  file    : $filePath  |\n'
            '+----------------------------------------------------------+',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.cyanAccent.shade100,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _buildBadge('static', Colors.lightGreenAccent),
            _buildBadge('no setState', Colors.amberAccent),
            _buildBadge('build() once', Colors.cyanAccent),
            _buildBadge('material only', Colors.pinkAccent.shade100),
          ],
        ),
      ],
    ),
  );

  print('=== MaterialType Deep Demo: build complete, returning tree ===');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        anatomy,
        const SizedBox(height: 28.0),
        _sectionTitle('3. The five values, in detail', Colors.indigo),
        const SizedBox(height: 12.0),
        canvasCard,
        const SizedBox(height: 16.0),
        cardCard,
        const SizedBox(height: 16.0),
        circleCard,
        const SizedBox(height: 16.0),
        buttonCard,
        const SizedBox(height: 16.0),
        transparencyCard,
        const SizedBox(height: 28.0),
        _sectionTitle('4. Side-by-side comparison', Colors.grey),
        comparison,
        const SizedBox(height: 28.0),
        _sectionTitle('5. Recipes', Colors.deepPurple),
        const SizedBox(height: 12.0),
        recipeRaisedCard,
        const SizedBox(height: 14.0),
        recipeAvatar,
        const SizedBox(height: 14.0),
        recipeTransparent,
        const SizedBox(height: 28.0),
        _sectionTitle('6. Elevation interaction', Colors.deepOrange),
        elevationSection,
        const SizedBox(height: 28.0),
        _sectionTitle('7. Pitfalls', Colors.red),
        pitfalls,
        const SizedBox(height: 28.0),
        _sectionTitle('8. Decision tree', Colors.purple),
        decision,
        const SizedBox(height: 28.0),
        footer,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// HELPERS
// ----------------------------------------------------------------

Widget _sectionTitle(String text, MaterialColor accent) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #47, P5(a)):
  // Original used `Border(left: BorderSide(width:5))` (non-uniform
  // colors/widths — only the left side is set) combined with
  // `borderRadius: 10`. Flutter asserts "A borderRadius can only be
  // given on borders with uniform colors." Refactored to a
  // `ClipRRect` wrapping a `Row` containing a 5 px-wide accent
  // Container as the left edge — preserves the visual (rounded
  // accent.shade50 pill with a chunky accent.shade700 left bar) and
  // satisfies the assertion.
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      color: accent.shade50,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 5.0, color: accent.shade700),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  color: accent.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildAnatomyField(String name, String description, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110.0,
          padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueCard({
  required MaterialType type,
  required IconData icon,
  required MaterialColor accent,
  required Color paletteLight,
  required Color paletteDeep,
  required String headline,
  required String definition,
  required Widget sample,
  required List<String> whenToUse,
  required List<String> pitfalls,
}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, paletteLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: accent.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent.shade400, accent.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.5),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MaterialType.${type.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: paletteDeep,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    headline,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      color: accent.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accent.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'index ${type.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: paletteDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Definition
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent.shade100),
          ),
          child: Text(
            definition,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        // Live sample
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.3),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Live sample',
                style: TextStyle(
                  fontSize: 11.0,
                  letterSpacing: 1.2,
                  color: accent.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12.0),
              Center(child: sample),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // When to use
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: accent.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: accent.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline,
                            color: accent.shade700, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text('When to use',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: paletteDeep,
                            )),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    for (final w in whenToUse)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ',
                                style: TextStyle(color: accent.shade700)),
                            Expanded(
                              child: Text(
                                w,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade800,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.red.shade700, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text('Pitfalls',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            )),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    for (final p in pitfalls)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('! ',
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                p,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade800,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildComparisonTile(MaterialType type, MaterialColor accent) {
  // For circle, use square sized child; for transparency, paint a bg behind.
  Widget materialSample;
  final size = const Size(90.0, 64.0);

  if (type == MaterialType.circle) {
    materialSample = Material(
      type: MaterialType.circle,
      color: accent.shade300,
      elevation: 4.0,
      shadowColor: accent.shade600,
      child: SizedBox(
        width: 64.0,
        height: 64.0,
        child: Center(
          child: Text(
            type.name,
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.bold,
              color: accent.shade900,
            ),
          ),
        ),
      ),
    );
  } else if (type == MaterialType.transparency) {
    materialSample = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accent.shade200, accent.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: size.width,
      height: size.height,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Text(
            type.name,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  } else {
    // canvas / card / button — same color, same elevation, different shape
    materialSample = Material(
      type: type,
      color: accent.shade300,
      elevation: 4.0,
      shadowColor: accent.shade600,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: Text(
            type.name,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: accent.shade900,
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        materialSample,
        const SizedBox(height: 6.0),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.shade50,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'index ${type.index}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: accent.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipe({
  required String title,
  required String subtitle,
  required MaterialColor accent,
  required Widget mock,
  required String code,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, accent.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: accent.shade700,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: accent.shade900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: accent.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Center(child: mock),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: accent.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildElevationSample(MaterialType type, double elevation) {
  // Build a small fixed-size demo. transparency excluded above.
  Widget surface;
  if (type == MaterialType.circle) {
    surface = Material(
      type: MaterialType.circle,
      color: Colors.deepOrange.shade300,
      elevation: elevation,
      shadowColor: Colors.deepOrange.shade700,
      child: const SizedBox(width: 44.0, height: 44.0),
    );
  } else {
    surface = Material(
      type: type,
      color: Colors.deepOrange.shade300,
      elevation: elevation,
      shadowColor: Colors.deepOrange.shade700,
      borderRadius: type == MaterialType.canvas
          ? BorderRadius.circular(2.0)
          : null,
      child: const SizedBox(width: 64.0, height: 44.0),
    );
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        child: surface,
      ),
      Text(
        'e=${elevation.toStringAsFixed(0)}',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: Colors.deepOrange.shade900,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget _buildPitfall(String headline, String body, MaterialColor accent) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #47, P5(a)):
  // Original used a four-sided `Border()` with a thicker accent.shade400
  // left side and red.shade100 on the other three sides — non-uniform —
  // combined with `borderRadius: 10`. Flutter asserts "A borderRadius
  // can only be given on borders with uniform colors." Refactored to a
  // uniform `Border.all(red.shade100, width: 1)` for the rounded outer
  // frame plus a `ClipRRect`-wrapped Row containing a 4 px-wide
  // accent.shade400 Container as the visual left bar. Preserves the
  // chunky accent left-bar look and the surrounding hairline frame.
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade100, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(9.0),
      child: IntrinsicHeight(
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 4.0, color: accent.shade400),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bug_report_rounded,
                          color: accent.shade700, size: 16.0),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          headline,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: accent.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.4,
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
  );
}

Widget _buildDecisionRow(String question, String answer, MaterialColor accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            question,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade900,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Icon(Icons.arrow_right_alt, color: accent.shade700, size: 22.0),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.shade400, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.25),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            answer,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accent.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}
