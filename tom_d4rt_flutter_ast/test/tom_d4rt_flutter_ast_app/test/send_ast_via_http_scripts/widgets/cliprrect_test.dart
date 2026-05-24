// D4rt test script: Deep visual demo for ClipRRect from widgets.
// Theme: "the rounded corner cookbook".
//
// Covers borderRadius (circular, all, only, vertical, horizontal,
// directional, lerp), clipBehavior, a CustomClipper<RRect>, sibling
// clip widgets, RRect, and a performance + cheat-sheet finale.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('ClipRRect deep demo: the rounded corner cookbook executing');

  // ============================================================
  // SECTION 1: Hero header — what ClipRRect is and why it matters
  // ============================================================
  debugPrint('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF4527A0), Color(0xFF7E57C2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.rounded_corner, color: Colors.white, size: 36.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ClipRRect — the rounded corner cookbook',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'ClipRRect clips its child to a rounded rectangle. It is the right '
          'tool when the child is "raster-y" — an Image, a gradient, a video, '
          'or any decoration whose paint must end at a curved boundary. '
          'A Container with BoxDecoration(borderRadius:) instead paints the '
          'corners as part of the decoration; if a child overflows, those '
          'pixels are NOT clipped unless you also wrap them in a ClipRRect.',
          style: TextStyle(color: Colors.white, fontSize: 13.0, height: 1.4),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Rule of thumb: decoration-only corners → BoxDecoration. '
          'Real geometric clipping → ClipRRect.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Uniform circular corners across the radius spectrum
  // ============================================================
  debugPrint('=== Section 2: BorderRadius.circular spectrum ===');

  const List<double> circularRadii = <double>[0.0, 4.0, 12.0, 20.0, 40.0, 80.0];
  const List<IconData> circularIcons = <IconData>[
    Icons.square,
    Icons.crop_square,
    Icons.crop_din,
    Icons.crop_3_2,
    Icons.adjust,
    Icons.circle,
  ];
  const List<List<Color>> circularGradients = <List<Color>>[
    <Color>[Color(0xFFE53935), Color(0xFFFFB300)],
    <Color>[Color(0xFFFB8C00), Color(0xFFFDD835)],
    <Color>[Color(0xFF43A047), Color(0xFF26A69A)],
    <Color>[Color(0xFF1E88E5), Color(0xFF5E35B1)],
    <Color>[Color(0xFF8E24AA), Color(0xFFD81B60)],
    <Color>[Color(0xFF6D4C41), Color(0xFF3E2723)],
  ];

  final List<Widget> circularTiles = <Widget>[];
  for (int i = 0; i < circularRadii.length; i++) {
    final double r = circularRadii[i];
    circularTiles.add(
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(r),
              child: Container(
                width: 110.0,
                height: 80.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: circularGradients[i],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    circularIcons[i],
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'r = ${r.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  final circularSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'BorderRadius.circular(r) spans from a sharp square (r=0) to a full '
        'capsule (r ≥ shorter side / 2). Notice how r=80 on an 80-tall tile '
        'rounds the short axis completely — radii are CLAMPED to half the '
        'shorter side, they do not overshoot.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Wrap(alignment: WrapAlignment.center, children: circularTiles),
    ],
  );

  // ============================================================
  // SECTION 3: BorderRadius.only — individual corners → ribbons/tabs
  // ============================================================
  debugPrint('=== Section 3: BorderRadius.only ===');

  Widget buildOnlyCard(
    String title,
    String hint,
    BorderRadius radius,
    List<Color> grad,
  ) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: radius,
            child: Container(
              width: 150.0,
              height: 70.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: grad,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 150.0,
            child: Text(
              hint,
              style: const TextStyle(fontSize: 10.0, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  final onlyCards = <Widget>[
    buildOnlyCard(
      'TL + BR',
      'topLeft + bottomRight → diagonal ribbon',
      const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        bottomRight: Radius.circular(24.0),
      ),
      const <Color>[Color(0xFFEF5350), Color(0xFF8E24AA)],
    ),
    buildOnlyCard(
      'TR + BL',
      'topRight + bottomLeft → counter-diagonal',
      const BorderRadius.only(
        topRight: Radius.circular(24.0),
        bottomLeft: Radius.circular(24.0),
      ),
      const <Color>[Color(0xFF26A69A), Color(0xFF1E88E5)],
    ),
    buildOnlyCard(
      'all-top',
      'classic tab head: rounded above flat',
      const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      const <Color>[Color(0xFFFFB300), Color(0xFFFF7043)],
    ),
    buildOnlyCard(
      'all-bottom',
      'sheet pull-tab / drawer foot',
      const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      const <Color>[Color(0xFF42A5F5), Color(0xFF7E57C2)],
    ),
  ];

  final onlySection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'BorderRadius.only takes any subset of corners. The four most useful '
        'recipes — opposing corners for ribbons, both-top for tab headers, '
        'both-bottom for bottom sheets — give an entire visual vocabulary '
        'without resorting to CustomClipper.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Wrap(alignment: WrapAlignment.center, children: onlyCards),
    ],
  );

  // ============================================================
  // SECTION 4: BorderRadius.vertical / horizontal — pill, leaf, stadium
  // ============================================================
  debugPrint('=== Section 4: vertical / horizontal radii ===');

  final pill = ClipRRect(
    borderRadius: const BorderRadius.horizontal(
      left: Radius.circular(40.0),
      right: Radius.circular(40.0),
    ),
    child: Container(
      width: 200.0,
      height: 56.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFEC407A), Color(0xFFAB47BC)],
        ),
      ),
      child: const Center(
        child: Text(
          'pill (horizontal 40)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final leaf = ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(40.0),
      bottomRight: Radius.circular(40.0),
    ),
    child: Container(
      width: 200.0,
      height: 56.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF66BB6A), Color(0xFF26C6DA)],
        ),
      ),
      child: const Center(
        child: Text(
          'leaf (TL + BR)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final stadium = ClipRRect(
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(28.0),
      bottom: Radius.circular(28.0),
    ),
    child: Container(
      width: 200.0,
      height: 56.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFFFA726), Color(0xFFEF5350)],
        ),
      ),
      child: const Center(
        child: Text(
          'stadium (vertical 28)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final shapesSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'BorderRadius.vertical rounds the top OR bottom pair; '
        'BorderRadius.horizontal rounds the left OR right pair. '
        'Mix them to get pills, leaves, and stadium shapes without '
        'computing four corner radii by hand.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Center(child: pill),
      const SizedBox(height: 10.0),
      Center(child: leaf),
      const SizedBox(height: 10.0),
      Center(child: stadium),
    ],
  );

  // ============================================================
  // SECTION 5: BorderRadiusDirectional — LTR vs RTL
  // ============================================================
  debugPrint('=== Section 5: BorderRadiusDirectional ===');

  Widget buildDirectionalSample(TextDirection dir) {
    return Directionality(
      textDirection: dir,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(28.0),
                bottomEnd: Radius.circular(28.0),
              ).resolve(dir),
              child: Container(
                width: 180.0,
                height: 70.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF5C6BC0), Color(0xFF26C6DA)],
                  ),
                ),
                child: Center(
                  child: Text(
                    dir == TextDirection.ltr ? 'LTR' : 'RTL',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              dir == TextDirection.ltr
                  ? 'start = topLeft, end = bottomRight'
                  : 'start = topRight, end = bottomLeft',
              style: const TextStyle(fontSize: 10.0, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  final directionalSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'BorderRadiusDirectional uses topStart / topEnd / bottomStart / '
        'bottomEnd. Under TextDirection.ltr these resolve to left/right; '
        'under TextDirection.rtl they flip. Pass a resolved BorderRadius '
        'to ClipRRect or hand the directional value to a widget that '
        'resolves it (Container, BoxDecoration on a Material 3 surface).',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildDirectionalSample(TextDirection.ltr),
          buildDirectionalSample(TextDirection.rtl),
        ],
      ),
    ],
  );

  // ============================================================
  // SECTION 6: Clipping gradient & shimmer cards — gallery edition
  // ============================================================
  debugPrint('=== Section 6: gallery of clipped gradients ===');

  final List<Map<String, dynamic>> gallery = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'sunset',
      'radius': 8.0,
      'icon': Icons.wb_twilight,
      'colors': const <Color>[Color(0xFFFF6F00), Color(0xFFD81B60)],
    },
    <String, dynamic>{
      'name': 'twilight',
      'radius': 16.0,
      'icon': Icons.dark_mode,
      'colors': const <Color>[Color(0xFF1A237E), Color(0xFF4A148C)],
    },
    <String, dynamic>{
      'name': 'ocean',
      'radius': 24.0,
      'icon': Icons.water,
      'colors': const <Color>[Color(0xFF006064), Color(0xFF1E88E5)],
    },
    <String, dynamic>{
      'name': 'neon',
      'radius': 32.0,
      'icon': Icons.flash_on,
      'colors': const <Color>[Color(0xFF00E5FF), Color(0xFFAA00FF)],
    },
    <String, dynamic>{
      'name': 'candy',
      'radius': 40.0,
      'icon': Icons.icecream,
      'colors': const <Color>[Color(0xFFFF80AB), Color(0xFFB388FF)],
    },
    <String, dynamic>{
      'name': 'monochrome',
      'radius': 48.0,
      'icon': Icons.contrast,
      'colors': const <Color>[Color(0xFF263238), Color(0xFFB0BEC5)],
    },
  ];

  final List<Widget> galleryCards = <Widget>[];
  for (final Map<String, dynamic> entry in gallery) {
    final double radius = entry['radius'] as double;
    final String name = entry['name'] as String;
    final IconData icon = entry['icon'] as IconData;
    final List<Color> colors = entry['colors'] as List<Color>;
    galleryCards.add(
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: 150.0,
            height: 96.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 8.0,
                  top: 8.0,
                  child: Icon(
                    icon,
                    color: Colors.white.withValues(alpha: 0.85),
                    size: 22.0,
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'r=${radius.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final gallerySection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'A gallery of gradient cards, each wrapped in ClipRRect at a '
        'different radius. The Stack inside paints text and an icon '
        'INSIDE the clipped region — overflow at the rounded edges is '
        'cut by the clip, not by the gradient.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Wrap(alignment: WrapAlignment.center, children: galleryCards),
    ],
  );

  // ============================================================
  // SECTION 7: clipBehavior comparison — all four Clip enum values
  // ============================================================
  debugPrint('=== Section 7: clipBehavior comparison ===');

  Widget buildClipBehaviorCard(Clip behavior, String caption, Color tint) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            clipBehavior: behavior,
            child: Container(
              width: 150.0,
              height: 90.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[tint, tint.withValues(alpha: 0.4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  behavior.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 150.0,
            child: Text(
              caption,
              style: const TextStyle(fontSize: 10.0, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  final clipBehaviorSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'The Clip enum trades quality for speed. none disables clipping '
        'entirely (use only if you know the child fits). hardEdge is '
        'cheap and aliased. antiAlias smooths the curve via the GPU '
        'and is the safe default. antiAliasWithSaveLayer additionally '
        'allocates an offscreen layer — visually pristine, painfully '
        'expensive on large surfaces.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildClipBehaviorCard(
            Clip.none,
            'no clip — child may overflow rounded edges',
            const Color(0xFF90A4AE),
          ),
          buildClipBehaviorCard(
            Clip.hardEdge,
            'fastest, jagged corners on diagonals',
            const Color(0xFF66BB6A),
          ),
          buildClipBehaviorCard(
            Clip.antiAlias,
            'smooth GPU-AA — recommended default',
            const Color(0xFF42A5F5),
          ),
          buildClipBehaviorCard(
            Clip.antiAliasWithSaveLayer,
            'smoothest but allocates an offscreen layer',
            const Color(0xFFAB47BC),
          ),
        ],
      ),
    ],
  );

  // ============================================================
  // SECTION 8: Custom clipper — a _WaveClipper returning RRect
  // ============================================================
  debugPrint('=== Section 8: CustomClipper<RRect> ===');

  final waveCardA = ClipRRect(
    clipper: const _WaveClipper(phase: 0.0),
    child: Container(
      width: 220.0,
      height: 110.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF00897B), Color(0xFF00ACC1)],
        ),
      ),
      child: const Center(
        child: Text(
          'phase = 0',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final waveCardB = ClipRRect(
    clipper: const _WaveClipper(phase: 1.0),
    child: Container(
      width: 220.0,
      height: 110.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFEF6C00), Color(0xFFD81B60)],
        ),
      ),
      child: const Center(
        child: Text(
          'phase = 1',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final clipperSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'When you need radii that depend on size or external state, '
        'subclass CustomClipper<RRect>. getClip(Size size) returns the '
        'RRect to use. shouldReclip(oldClipper) should return true only '
        'when inputs have changed, otherwise the framework can cache '
        'the previous clip.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      // Wrap instead of Row so the two 220 px cards reflow on narrow viewports.
      Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[waveCardA, waveCardB],
      ),
      const SizedBox(height: 8.0),
      const Text(
        '_WaveClipper builds RRect.fromRectAndCorners with intentionally '
        'asymmetric radii (one corner sharp, one nearly half-side) that '
        'flip when phase changes — the second card shows the mirror.',
        style: TextStyle(fontSize: 11.0, color: Colors.black54),
      ),
    ],
  );

  // ============================================================
  // SECTION 9: Nested clips — the matryoshka frame
  // ============================================================
  debugPrint('=== Section 9: nested matryoshka clips ===');

  final matryoshka = ClipRRect(
    borderRadius: BorderRadius.circular(36.0),
    child: Container(
      color: const Color(0xFF1A237E),
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.0),
        child: Container(
          color: const Color(0xFF7B1FA2),
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              width: 200.0,
              height: 100.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFFD54F), Color(0xFFFF7043)],
                ),
              ),
              child: const Center(
                child: Text(
                  'inner core',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF311B92),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  final nestedSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'Three ClipRRects stacked from outside in, each with a smaller '
        'radius and a colored padding gap, produce a multi-tone border '
        'effect cheaper than painting custom borders. Each clip adds '
        'cost — keep the count small and prefer Decoration borders when '
        'the inner child does not actually need clipping.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Center(child: matryoshka),
    ],
  );

  // ============================================================
  // SECTION 10: ClipRRect vs ClipOval vs ClipPath
  // ============================================================
  debugPrint('=== Section 10: family of clips ===');

  Widget syntheticImage() {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF42A5F5), Color(0xFFAB47BC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.image, color: Colors.white, size: 48.0),
      ),
    );
  }

  final familySection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'The clipping family: ClipRRect clips to a rounded rectangle, '
        'ClipOval clips to the inscribed ellipse, ClipPath delegates to '
        'an arbitrary Path. Pick the most specific widget you can — it '
        'is the cheapest and the most likely to participate in raster '
        'cache optimizations.',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      // Wrap instead of Row so the three 120 px image columns reflow on
      // narrow viewports without triggering a RenderFlex overflow.
      Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 16.0,
        runSpacing: 16.0,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: syntheticImage(),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'ClipRRect',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
              ),
              const Text(
                'rounded rect',
                style: TextStyle(fontSize: 10.0, color: Colors.black54),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(child: syntheticImage()),
              const SizedBox(height: 4.0),
              const Text(
                'ClipOval',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
              ),
              const Text(
                'avatar / inscribed ellipse',
                style: TextStyle(fontSize: 10.0, color: Colors.black54),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipPath(
                clipper: const _PentagonClipper(),
                child: syntheticImage(),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'ClipPath',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
              ),
              const Text(
                'arbitrary geometry',
                style: TextStyle(fontSize: 10.0, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ============================================================
  // SECTION 11: Performance caveats — speed vs quality per Clip
  // ============================================================
  debugPrint('=== Section 11: performance caveats ===');

  Widget speedQualityRow(Clip clip, int speed, int quality, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 180.0,
            child: Text(
              'Clip.${clip.name}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                const Icon(Icons.bolt, size: 14.0, color: Color(0xFFFB8C00)),
                const SizedBox(width: 2.0),
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.circle,
                    size: 10.0,
                    color: i < speed
                        ? const Color(0xFFFB8C00)
                        : const Color(0xFFE0E0E0),
                  ),
                const SizedBox(width: 12.0),
                const Icon(Icons.brush, size: 14.0, color: Color(0xFF1E88E5)),
                const SizedBox(width: 2.0),
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.circle,
                    size: 10.0,
                    color: i < quality
                        ? const Color(0xFF1E88E5)
                        : const Color(0xFFE0E0E0),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              note,
              style: const TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  final performancePanel = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFB300), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.speed, color: Color(0xFFEF6C00)),
            SizedBox(width: 8.0),
            Text(
              'Performance caveats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF6D4C41),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'antiAliasWithSaveLayer allocates an offscreen render target '
          'every frame the clipped subtree paints. On low-end devices '
          'with large surfaces, that is one of the most common '
          'jank causes — reach for it only when antiAlias visibly fails '
          '(e.g. overlapping translucent children at a rounded corner).',
          style: TextStyle(fontSize: 12.0, height: 1.4),
        ),
        const SizedBox(height: 10.0),
        speedQualityRow(Clip.none, 5, 1, 'no clip; cheapest, no rounding'),
        speedQualityRow(Clip.hardEdge, 4, 2, 'fast, aliased curves'),
        speedQualityRow(Clip.antiAlias, 3, 4, 'safe default'),
        speedQualityRow(
          Clip.antiAliasWithSaveLayer,
          1,
          5,
          'pristine, offscreen layer cost',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Cheat sheet — property → effect
  // ============================================================
  debugPrint('=== Section 12: cheat sheet ===');

  Widget cheatRow(String prop, String effect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220.0,
            child: Text(
              prop,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A237E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              effect,
              style: const TextStyle(fontSize: 12.0, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  final cheatSheet = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF3949AB), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.menu_book, color: Color(0xFF1A237E)),
            SizedBox(width: 8.0),
            Text(
              'Cheat sheet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        cheatRow('borderRadius:', 'shape of the rounded rect clip'),
        cheatRow('BorderRadius.circular(r)', 'all four corners equal radius r'),
        cheatRow('BorderRadius.all(Radius)', 'same, but pre-built Radius'),
        cheatRow(
          'BorderRadius.only(...)',
          'pick any subset of corners; missing ones default to 0',
        ),
        cheatRow(
          'BorderRadius.vertical(top:, bottom:)',
          'symmetric per-row corner radii — pills, sheet headers',
        ),
        cheatRow(
          'BorderRadius.horizontal(left:, right:)',
          'symmetric per-column corner radii — capsule buttons',
        ),
        cheatRow(
          'BorderRadiusDirectional.only(topStart:, bottomEnd:, ...)',
          'logical corners; flips automatically with TextDirection',
        ),
        cheatRow(
          'BorderRadius.lerp(a, b, t)',
          'interpolate between two radii; returns null only if both null',
        ),
        cheatRow(
          'clipBehavior:',
          'how the edges are rasterized: none / hardEdge / antiAlias / '
          'antiAliasWithSaveLayer',
        ),
        cheatRow(
          'clipper:',
          'CustomClipper<RRect>; overrides borderRadius and produces an RRect',
        ),
        cheatRow(
          'RRect.fromRectAndCorners',
          'low-level constructor a CustomClipper typically uses',
        ),
      ],
    ),
  );

  // ============================================================
  // Lerp demo — visualize BorderRadius.lerp across t = 0..1
  // ============================================================
  debugPrint('=== Lerp demo (bonus) ===');

  final BorderRadius lerpA = BorderRadius.circular(4.0);
  const BorderRadius lerpB = BorderRadius.only(
    topLeft: Radius.circular(40.0),
    bottomRight: Radius.circular(40.0),
  );
  final List<Widget> lerpTiles = <Widget>[];
  for (int i = 0; i <= 4; i++) {
    final double t = i / 4.0;
    final BorderRadius? lerped = BorderRadius.lerp(lerpA, lerpB, t);
    lerpTiles.add(
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: lerped ?? BorderRadius.zero,
              child: Container(
                width: 90.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF1E88E5), Color(0xFFAB47BC)],
                  ),
                ),
                child: Center(
                  child: Text(
                    't=${t.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
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

  final lerpSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const Text(
        'BorderRadius.lerp(a, b, t) interpolates each corner independently. '
        'Use it inside AnimatedBuilder / Tween<BorderRadius> to animate a '
        'card from a tight square (t=0) into a diagonal ribbon (t=1).',
        style: TextStyle(fontSize: 13.0, height: 1.4),
      ),
      const SizedBox(height: 12.0),
      Wrap(alignment: WrapAlignment.center, children: lerpTiles),
    ],
  );

  debugPrint('ClipRRect deep demo: composition done');

  // ============================================================
  // Final composition
  // ============================================================
  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 2 — uniform circular corners',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            circularSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 3 — BorderRadius.only (ribbons & tabs)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            onlySection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 4 — vertical / horizontal radii (pill, leaf, stadium)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            shapesSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 5 — BorderRadiusDirectional (LTR vs RTL)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            directionalSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 6 — clipping gradient cards',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            gallerySection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 7 — clipBehavior comparison',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            clipBehaviorSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 8 — CustomClipper<RRect>',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            clipperSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 9 — nested matryoshka clips',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            nestedSection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 10 — ClipRRect vs ClipOval vs ClipPath',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            familySection,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 11 — performance caveats',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            performancePanel,
            const SizedBox(height: 28.0),
            const Text(
              'SECTION 12 — cheat sheet',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            cheatSheet,
            const SizedBox(height: 28.0),
            const Text(
              'BONUS — BorderRadius.lerp progression',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
            const SizedBox(height: 8.0),
            lerpSection,
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// CustomClipper<RRect>: a quirky asymmetric wave-corner clip.
// Demonstrates RRect.fromRectAndCorners and shouldReclip semantics.
// ============================================================
class _WaveClipper extends CustomClipper<RRect> {
  const _WaveClipper({required this.phase});

  final double phase;

  @override
  RRect getClip(Size size) {
    final Rect rect = Offset.zero & size;
    final double big = size.shortestSide * 0.45;
    const double small = 4.0;
    if (phase < 0.5) {
      return RRect.fromRectAndCorners(
        rect,
        topLeft: Radius.circular(big),
        topRight: const Radius.circular(small),
        bottomLeft: const Radius.circular(small),
        bottomRight: Radius.circular(big),
      );
    }
    return RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(small),
      topRight: Radius.circular(big),
      bottomLeft: Radius.circular(big),
      bottomRight: const Radius.circular(small),
    );
  }

  @override
  bool shouldReclip(covariant _WaveClipper oldClipper) {
    return oldClipper.phase != phase;
  }
}

// ============================================================
// CustomClipper<Path>: pentagon path for the ClipPath comparison.
// ============================================================
class _PentagonClipper extends CustomClipper<Path> {
  const _PentagonClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.5, 0.0);
    path.lineTo(w, h * 0.38);
    path.lineTo(w * 0.82, h);
    path.lineTo(w * 0.18, h);
    path.lineTo(0.0, h * 0.38);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
