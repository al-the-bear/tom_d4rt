// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import, unused_element, unused_element_parameter
// =====================================================================
// RestorableCupertinoTabController — Deep Visual Demo
// =====================================================================
//
// This file is a hand-authored, analyzer-clean visual showcase for the
// pair of types that together implement the Cupertino tab-controller
// restoration story:
//
//   * CupertinoTabController — a `ChangeNotifier` whose entire state is
//     a single `int currentIndex` (exposed as `index`).
//
//   * RestorableCupertinoTabController — a `RestorableChangeNotifier`
//     subclass whose `createDefaultValue` constructs a fresh
//     CupertinoTabController seeded from an `initialIndex` parameter,
//     and whose RestorationBucket stores that index as a primitive so
//     it survives process death.
//
// Class signatures (from package:flutter/cupertino.dart):
//
//   class CupertinoTabController extends ChangeNotifier {
//     CupertinoTabController({int initialIndex = 0});
//     int get index;
//     set index(int value);
//     void addListener(VoidCallback listener);
//     void removeListener(VoidCallback listener);
//     void notifyListeners();
//     void dispose();
//   }
//
//   class RestorableCupertinoTabController
//       extends RestorableChangeNotifier<CupertinoTabController> {
//     RestorableCupertinoTabController({int initialIndex = 0});
//     CupertinoTabController createDefaultValue();
//     CupertinoTabController fromPrimitives(Object? data);
//     Object toPrimitives();
//     // ...standard RestorableChangeNotifier hooks.
//   }
//
// The demo is intentionally rich — eleven sections of prose + visuals.
// It walks the reader from "what does this controller actually store?"
// all the way to "what does a registered restoration tree look like
// on disk?", with gallery cards, an API table card, a restoration-id
// hierarchy diagram, a code-block card, a tab-variants gallery, and a
// pitfalls section.  No live mutation is performed — every controller
// is constructed at its initial index and read once.
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ---------------------------------------------------------------------
// Section: Design tokens
// ---------------------------------------------------------------------
//
// The demo standardises on a small set of named tokens for spacing,
// radii, and shadow stacks so that every section feels visually
// related.  These are top-level `const` values rather than scattered
// magic numbers — the harness can reference them at any layer.
// ---------------------------------------------------------------------

const double _kSectionPad = 20.0;
const double _kCardRadius = 18.0;
const double _kPillRadius = 999.0;
const double _kTabBarHeight = 50.0;
const double _kTabBarHeightTall = 64.0;
const double _kGalleryTileWidth = 280.0;
const double _kGalleryTileHeight = 200.0;
const double _kGapXs = 4.0;
const double _kGapSm = 8.0;
const double _kGapMd = 12.0;
const double _kGapLg = 20.0;
const double _kGapXl = 28.0;

// Cupertino-flavoured accent palette used by the swatch grid and by
// several section gradients.  These mirror iOS / iPadOS system
// colours so the demo feels native.
const List<Color> _kCupertinoAccents = <Color>[
  CupertinoColors.activeBlue,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemPurple,
  CupertinoColors.systemPink,
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemTeal,
  CupertinoColors.systemCyan,
  CupertinoColors.systemMint,
  CupertinoColors.systemBrown,
];

const List<String> _kCupertinoAccentNames = <String>[
  'activeBlue',
  'systemIndigo',
  'systemPurple',
  'systemPink',
  'systemRed',
  'systemOrange',
  'systemYellow',
  'systemGreen',
  'systemTeal',
  'systemCyan',
  'systemMint',
  'systemBrown',
];

// Canonical icon set used across the gallery cards.  Five well-known
// CupertinoIcons that map well to the typical iOS tab-bar metaphors:
// Home, Search, Activity, Cart, and Account.
const List<IconData> _kPrimaryTabIcons = <IconData>[
  CupertinoIcons.house_fill,
  CupertinoIcons.search,
  CupertinoIcons.chart_bar_alt_fill,
  CupertinoIcons.cart_fill,
  CupertinoIcons.person_alt_circle_fill,
];

const List<String> _kPrimaryTabLabels = <String>[
  'Home',
  'Search',
  'Activity',
  'Cart',
  'Account',
];

// ---------------------------------------------------------------------
// Section: Shadow factories
// ---------------------------------------------------------------------
//
// Three named multi-layer shadow stacks.  Each one combines an
// "ambient" soft far-spread shadow with a "key" tighter shadow,
// producing a depth cue that survives both light backgrounds and
// the darker hero-card gradients.
// ---------------------------------------------------------------------

List<BoxShadow> _softCardShadow() {
  return <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 24.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 12.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 6.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 2.0),
    ),
  ];
}

List<BoxShadow> _heroShadow(Color tint) {
  return <BoxShadow>[
    BoxShadow(
      color: tint.withOpacity(0.28),
      blurRadius: 36.0,
      spreadRadius: 2.0,
      offset: const Offset(0.0, 18.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 12.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 4.0),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.55),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, -1.0),
    ),
  ];
}

List<BoxShadow> _tabBarShadow() {
  return <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, -2.0),
    ),
  ];
}

// ---------------------------------------------------------------------
// Section: Gradient factories
// ---------------------------------------------------------------------
//
// Each major section gets its own gradient so the page reads as a
// stack of clearly distinct slabs.  All gradients are linear with a
// slight diagonal, keeping the look modern but never overwhelming
// the section content sitting on top.
// ---------------------------------------------------------------------

LinearGradient _heroGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF0A84FF),
      Color(0xFF5856D6),
      Color(0xFFAF52DE),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _surfaceGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFFF6F7FB),
      Color(0xFFE9ECF4),
    ],
  );
}

LinearGradient _anatomyGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFF6E5),
      Color(0xFFFFE0B2),
    ],
  );
}

LinearGradient _apiTableGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFE0F7FA),
      Color(0xFFB2EBF2),
    ],
  );
}

LinearGradient _hierarchyGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFEDE9FE),
      Color(0xFFDDD6FE),
      Color(0xFFC4B5FD),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _snippetGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF1F2937),
      Color(0xFF111827),
    ],
  );
}

LinearGradient _galleryGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFFBEB),
      Color(0xFFFEF3C7),
    ],
  );
}

LinearGradient _pitfallsGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFEE2E2),
      Color(0xFFFECACA),
    ],
  );
}

LinearGradient _footerGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF1F2937),
      Color(0xFF0F172A),
    ],
  );
}

// =====================================================================
//                      ENTRY POINT — `build`
// =====================================================================
//
// The Tom D4rt flutter_ast test harness expects a top-level function
// named `build` returning `dynamic`.  It is invoked with a real
// `BuildContext` exactly once.  We forbid `main`, `runApp`,
// `testWidgets`, async primitives, and root-level `setState`.  Every
// controller in this demo is allocated, read once for its initial
// `index`, and never mutated — exactly the slice of behaviour that
// the D4rt analyzer-free interpreter is happy to evaluate.
// =====================================================================

dynamic build(BuildContext context) {
  print('[rctc-demo] entering build()');
  print('[rctc-demo] Constructing a handful of CupertinoTabController');
  print('[rctc-demo]   and RestorableCupertinoTabController instances...');

  // Touch the real APIs once so a reader of the script can see that
  // they are constructible from inside the d4rt sandbox.  We dispose
  // the plain ones immediately; the restorable ones are not strictly
  // owned anywhere here so we let them fall out of scope after read.
  final CupertinoTabController c0 = CupertinoTabController(initialIndex: 0);
  final CupertinoTabController c1 = CupertinoTabController(initialIndex: 1);
  final CupertinoTabController c2 = CupertinoTabController(initialIndex: 2);
  final CupertinoTabController c3 = CupertinoTabController(initialIndex: 3);
  print('[rctc-demo]   c0.index=${c0.index} c1.index=${c1.index} '
      'c2.index=${c2.index} c3.index=${c3.index}');

  final RestorableCupertinoTabController r0 =
      RestorableCupertinoTabController();
  final RestorableCupertinoTabController r2 =
      RestorableCupertinoTabController(initialIndex: 2);
  print('[rctc-demo]   r0 hash=${r0.hashCode} r2 hash=${r2.hashCode}');

  c0.dispose();
  c1.dispose();
  c2.dispose();
  c3.dispose();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RestorableCupertinoTabController Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F4F8),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14.0, color: Color(0xFF1F2937)),
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: _kSectionPad,
            vertical: _kSectionPad,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroSection(),
              const SizedBox(height: _kGapXl),
              _buildIntroductionSection(),
              const SizedBox(height: _kGapXl),
              _buildAnatomySection(),
              const SizedBox(height: _kGapXl),
              _buildStaticGallerySection(),
              const SizedBox(height: _kGapXl),
              _buildApiTableSection(),
              const SizedBox(height: _kGapXl),
              _buildRestorationHierarchySection(),
              const SizedBox(height: _kGapXl),
              _buildCodeSnippetSection(),
              const SizedBox(height: _kGapXl),
              _buildTabVariantsSection(),
              const SizedBox(height: _kGapXl),
              _buildDisplayMatrixSection(),
              const SizedBox(height: _kGapXl),
              _buildPitfallsSection(),
              const SizedBox(height: _kGapXl),
              _buildFooterSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Section 1 — Hero
// =====================================================================
//
// A bold, gradient-filled hero card that sets the tone.  It introduces
// the widget pair by name, displays a sample mini tab-bar at index 1
// against a translucent white inner surface, and uses three stacked
// shadows so it feels like it floats above the page.
// =====================================================================

Widget _buildHeroSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _heroGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius + 6.0),
      boxShadow: _heroShadow(const Color(0xFF5856D6)),
    ),
    padding: const EdgeInsets.all(_kSectionPad + 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _kGapMd,
                vertical: _kGapXs,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(_kPillRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.35),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'CUPERTINO • STATE RESTORATION',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.square_grid_2x2_fill,
              color: Colors.white,
              size: 28.0,
            ),
          ],
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          'RestorableCupertinoTabController',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Text(
          'A RestorableChangeNotifier wrapper around the iOS-style '
          'CupertinoTabController, allowing the active tab index to '
          'survive process death, app backgrounding, and state '
          'restoration.  Pair it with CupertinoTabScaffold to get '
          'persistent tab selection for free.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapXl),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _kGapLg,
            vertical: _kGapLg,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Currently restored',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'index = 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFeatures: <FontFeature>[
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: _kGapMd),
              _MiniTabBar(
                currentIndex: 1,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: Colors.white,
                background: Colors.white.withOpacity(0.10),
                inactive: Colors.white.withOpacity(0.55),
              ),
              const SizedBox(height: _kGapSm),
              Text(
                'Reinflated from RestorationBucket("cupertinoTabController")',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 2 — Introduction (prose)
// =====================================================================
//
// Plain-language explanation of what the controller is, what it
// stores, and why the Restorable variant exists.  No live state is
// presented here; the goal is to anchor the reader so every later
// section makes immediate sense.
// =====================================================================

Widget _buildIntroductionSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('What does it actually store?'),
        const SizedBox(height: _kGapMd),
        const Text(
          'CupertinoTabController is a ChangeNotifier whose entire '
          'observable state is a single integer: the currently selected '
          'tab index. It is the iOS equivalent of TabController, minus '
          'the animation machinery — the tab-scaffold itself swaps the '
          'content child on `notifyListeners`, no tween, no curve.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapMd),
        const Text(
          'RestorableCupertinoTabController wraps that controller and '
          'plugs it into Flutter\'s state-restoration framework. The '
          'wrapper extends RestorableChangeNotifier<CupertinoTabController> '
          'and stores the integer index as a primitive inside the '
          'parent RestorationBucket. When the application is reinflated, '
          'the bucket is read back and a fresh controller is created '
          'seeded to the saved index.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapMd),
        _bullet('Stores exactly one primitive: `int currentIndex`.'),
        _bullet('Extends RestorableChangeNotifier<CupertinoTabController>.'),
        _bullet('Registered with State.registerForRestoration in initState.'),
        _bullet('Auto-disposed by the State when the widget is unmounted.'),
        _bullet('Drop-in compatible with CupertinoTabScaffold.controller.'),
      ],
    ),
  );
}

// =====================================================================
// Section 3 — Anatomy CustomPainter
// =====================================================================
//
// A hand-painted diagram (CustomPainter) that shows the controller
// lifecycle as a four-node flow: created → registered with
// RestorationBucket → state survives process death → reinflated.
// =====================================================================

Widget _buildAnatomySection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _anatomyGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Controller lifecycle'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The diagram below traces a single instance of '
          'RestorableCupertinoTabController across the four lifecycle '
          'moments that matter for state restoration. Notice that the '
          'CupertinoTabController inside the wrapper is created twice: '
          'once during initial mount, and once during reinflation from '
          'the saved primitive.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        SizedBox(
          height: 220.0,
          child: CustomPaint(
            painter: _LifecyclePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: _kGapMd),
        Row(
          children: <Widget>[
            _legendSwatch(const Color(0xFFEA580C), 'creation'),
            const SizedBox(width: _kGapMd),
            _legendSwatch(const Color(0xFF7C3AED), 'registration'),
            const SizedBox(width: _kGapMd),
            _legendSwatch(const Color(0xFF0EA5E9), 'persistence'),
            const SizedBox(width: _kGapMd),
            _legendSwatch(const Color(0xFF16A34A), 'reinflation'),
          ],
        ),
      ],
    ),
  );
}

class _LifecyclePainter extends CustomPainter {
  const _LifecyclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double nodeW = (w - 60.0) / 4.0;
    final double nodeH = 80.0;
    final double y = (h - nodeH) / 2.0;
    final List<Color> colors = <Color>[
      const Color(0xFFEA580C),
      const Color(0xFF7C3AED),
      const Color(0xFF0EA5E9),
      const Color(0xFF16A34A),
    ];
    final List<String> titles = <String>[
      'create',
      'register',
      'persist',
      'reinflate',
    ];
    final List<String> subs = <String>[
      'initState',
      'restoreState',
      'bucket write',
      'fromPrimitives',
    ];

    final Paint linePaint = Paint()
      ..color = const Color(0xFF6B7280)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final double x = 10.0 + i * (nodeW + 15.0);
      final Rect r = Rect.fromLTWH(x, y, nodeW, nodeH);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(14.0));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = colors[i].withOpacity(0.18)
          ..style = PaintingStyle.fill,
      );
      canvas.drawRRect(
        rr,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: titles[i],
          style: TextStyle(
            color: colors[i],
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      )..layout(maxWidth: nodeW);
      tp.paint(canvas, Offset(x + (nodeW - tp.width) / 2.0, y + 18.0));

      final TextPainter sp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: subs[i],
          style: const TextStyle(
            color: Color(0xFF374151),
            fontSize: 11.0,
          ),
        ),
      )..layout(maxWidth: nodeW);
      sp.paint(canvas, Offset(x + (nodeW - sp.width) / 2.0, y + 44.0));

      if (i < 3) {
        final double ax = x + nodeW;
        final double bx = ax + 15.0;
        final double ay = y + nodeH / 2.0;
        canvas.drawLine(Offset(ax, ay), Offset(bx, ay), linePaint);
        final Path arrow = Path()
          ..moveTo(bx, ay)
          ..lineTo(bx - 6.0, ay - 4.0)
          ..lineTo(bx - 6.0, ay + 4.0)
          ..close();
        canvas.drawPath(arrow, Paint()..color = const Color(0xFF6B7280));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter oldDelegate) => false;
}

// =====================================================================
// Section 4 — Static gallery of CupertinoTabScaffold-like layouts
// =====================================================================
//
// Five iOS-style tab-bar tiles, each one rendered at a different
// initial index (0..4).  This is the visual answer to the question
// "what does the controller actually pick?" — every tile is a static
// frame, no interaction, but the highlighted tab and content label
// line up exactly with the controller's index.
// =====================================================================

Widget _buildStaticGallerySection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _galleryGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Static gallery — controller picks the tab'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Five frozen frames, each one built as if the controller '
          'had just been reinflated at the indicated index. The tab '
          'bar uses the iOS visual idiom: a slim translucent bar with '
          'rounded top corners, segmented selection indicator, and '
          'monochrome icons that tint to the active colour when '
          'selected.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Wrap(
          spacing: _kGapMd,
          runSpacing: _kGapMd,
          children: <Widget>[
            for (int i = 0; i < 5; i++)
              _GalleryTile(
                index: i,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: _kCupertinoAccents[i % _kCupertinoAccents.length],
              ),
          ],
        ),
      ],
    ),
  );
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({
    required this.index,
    required this.icons,
    required this.labels,
    required this.accent,
  });

  final int index;
  final List<IconData> icons;
  final List<String> labels;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kGalleryTileWidth,
      height: _kGalleryTileHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFF9FAFB),
                padding: const EdgeInsets.all(_kGapMd),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _kGapMd,
                        vertical: _kGapXs,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(_kPillRadius),
                      ),
                      child: Text(
                        'index = $index',
                        style: TextStyle(
                          color: accent,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: _kGapSm),
                    Icon(icons[index], color: accent, size: 32.0),
                    const SizedBox(height: _kGapXs),
                    Text(
                      '${labels[index]} content',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _MiniTabBar(
              currentIndex: index,
              icons: icons,
              labels: labels,
              accent: accent,
              background: const Color(0xFFF3F4F6),
              inactive: const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Mini tab-bar widget
// ---------------------------------------------------------------------
//
// A private, hand-built approximation of CupertinoTabBar.  It draws a
// thin translucent bar with rounded top corners, an even number of
// icon+label segments, and a soft pill-shaped indicator behind the
// active segment.  All static — no interaction.
// ---------------------------------------------------------------------

class _MiniTabBar extends StatelessWidget {
  const _MiniTabBar({
    required this.currentIndex,
    required this.icons,
    required this.labels,
    required this.accent,
    required this.background,
    required this.inactive,
    this.height = _kTabBarHeight,
    this.showLabels = true,
  });

  final int currentIndex;
  final List<IconData> icons;
  final List<String> labels;
  final Color accent;
  final Color background;
  final Color inactive;
  final double height;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final int count = math.min(icons.length, labels.length);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: background,
        boxShadow: _tabBarShadow(),
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < count; i++)
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: i == currentIndex
                      ? accent.withOpacity(0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icons[i],
                      size: showLabels ? 18.0 : 22.0,
                      color: i == currentIndex ? accent : inactive,
                    ),
                    if (showLabels) ...<Widget>[
                      const SizedBox(height: 2.0),
                      Text(
                        labels[i],
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: i == currentIndex
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: i == currentIndex ? accent : inactive,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 5 — API table card
// =====================================================================
//
// A table card listing the CupertinoTabController public API.  Five
// rows: index getter/setter, addListener, removeListener,
// notifyListeners, dispose.  Each row has a signature column and a
// description column, styled like documentation.
// =====================================================================

Widget _buildApiTableSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _apiTableGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('CupertinoTabController API'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The full public surface of CupertinoTabController is small '
          'enough to fit on a single card.  Everything else — '
          'restoration ids, primitives, change notification — is '
          'inherited from ChangeNotifier or from the Restorable '
          'wrapper.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              _apiHeaderRow(),
              _apiRow(
                signature: 'CupertinoTabController({int initialIndex = 0})',
                description:
                    'Construct a controller seeded with the initial tab '
                    'index. Asserts initialIndex >= 0.',
              ),
              _apiRow(
                signature: 'int get index',
                description:
                    'The currently selected tab index.  Read it at any '
                    'time to drive content selection downstream.',
              ),
              _apiRow(
                signature: 'set index(int value)',
                description:
                    'Set the active tab and notify listeners.  Asserts '
                    'value >= 0.  No-op when value equals current.',
              ),
              _apiRow(
                signature: 'void addListener(VoidCallback listener)',
                description:
                    'Register a callback invoked whenever the index '
                    'changes.  Inherited from ChangeNotifier.',
              ),
              _apiRow(
                signature: 'void removeListener(VoidCallback listener)',
                description:
                    'Unregister a previously added callback.  Must be '
                    'symmetric with addListener to avoid leaks.',
              ),
              _apiRow(
                signature: 'void notifyListeners()',
                description:
                    'Trigger all registered listeners.  Called '
                    'automatically by the setter; rarely called '
                    'directly by user code.',
              ),
              _apiRow(
                signature: 'void dispose()',
                description:
                    'Release the controller.  Required when you own '
                    'the controller; the State machinery does this '
                    'for the Restorable wrapper automatically.',
                last: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _apiHeaderRow() {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFFF3F4F6),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: _kGapMd,
      vertical: _kGapSm,
    ),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            'Signature',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            'Description',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _apiRow({
  required String signature,
  required String description,
  bool last = false,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: last ? Colors.transparent : const Color(0xFFE5E7EB),
          width: 0.5,
        ),
      ),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: _kGapMd,
      vertical: _kGapMd,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: _kGapSm,
              vertical: _kGapXs,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 0.5,
              ),
            ),
            child: Text(
              signature,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ),
        const SizedBox(width: _kGapMd),
        Expanded(
          flex: 7,
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 13.0,
              height: 1.4,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 6 — Restoration ID hierarchy diagram
// =====================================================================
//
// A diagram showing how the active tab index is nested inside the
// parent route's RestorationBucket. Three levels:
//
//   parent route bucket
//     └─ 'cupertinoTabController' (RestorationBucket)
//          └─ 'currentIndex' (int primitive)
//
// Drawn as three stacked rounded rectangles with connector lines.
// =====================================================================

Widget _buildRestorationHierarchySection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _hierarchyGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Restoration ID hierarchy'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Every restorable property lives inside a tree of '
          'RestorationBuckets, rooted at the application\'s top-level '
          'restoration scope. The tree below is what '
          'RestorableCupertinoTabController contributes to that tree '
          'when registered with `registerForRestoration(controller, '
          '\'cupertinoTabController\')`.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        _hierarchyNode(
          icon: CupertinoIcons.folder_fill,
          color: const Color(0xFF6366F1),
          title: 'RestorationBucket',
          subtitle: 'parent route — owned by Navigator',
          tag: 'restorationScopeId',
        ),
        _hierarchyConnector(),
        _hierarchyNode(
          icon: CupertinoIcons.folder_fill,
          color: const Color(0xFF7C3AED),
          title: 'cupertinoTabController',
          subtitle: 'wrapper bucket registered by State',
          tag: 'restorationId',
          indent: 24.0,
        ),
        _hierarchyConnector(indent: 24.0),
        _hierarchyNode(
          icon: CupertinoIcons.doc_text_fill,
          color: const Color(0xFFDB2777),
          title: 'currentIndex : 0',
          subtitle: 'primitive (int) — written via toPrimitives()',
          tag: 'leaf',
          indent: 48.0,
        ),
      ],
    ),
  );
}

Widget _hierarchyNode({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
  required String tag,
  double indent = 0.0,
}) {
  return Padding(
    padding: EdgeInsets.only(left: indent),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.30), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: _kGapMd,
        vertical: _kGapMd,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 20.0),
          ),
          const SizedBox(width: _kGapMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: _kGapSm,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(_kPillRadius),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _hierarchyConnector({double indent = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(left: indent + 18.0),
    child: Container(
      width: 2.0,
      height: 16.0,
      color: const Color(0xFF94A3B8),
    ),
  );
}

// =====================================================================
// Section 7 — Code snippet card
// =====================================================================
//
// A dark code-block card showing the idiomatic setup for
// RestorableCupertinoTabController inside a StatefulWidget's State:
// declaration, restoreState override, and dispose override.
// =====================================================================

Widget _buildCodeSnippetSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _snippetGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Idiomatic restoration setup',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Text(
          'A minimal, complete State<MyTabPage> showing the four lines '
          'that wire RestorableCupertinoTabController into the '
          'restoration framework.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapLg),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF030712),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.10),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(_kGapLg),
          child: const _CodeBlock(
            lines: <_CodeLine>[
              _CodeLine(0, 'class _MyTabPageState extends State<MyTabPage>'),
              _CodeLine(2, 'with RestorationMixin {'),
              _CodeLine(2, 'final RestorableCupertinoTabController _ctrl ='),
              _CodeLine(4, 'RestorableCupertinoTabController(initialIndex: 0);'),
              _CodeLine(0, ''),
              _CodeLine(2, '@override'),
              _CodeLine(2, "String get restorationId => 'my_tab_page';"),
              _CodeLine(0, ''),
              _CodeLine(2, '@override'),
              _CodeLine(2, 'void restoreState('),
              _CodeLine(4, 'RestorationBucket? oldBucket,'),
              _CodeLine(4, 'bool initialRestore,'),
              _CodeLine(2, ') {'),
              _CodeLine(4, "registerForRestoration(_ctrl, 'tab_ctrl');"),
              _CodeLine(2, '}'),
              _CodeLine(0, ''),
              _CodeLine(2, '@override'),
              _CodeLine(2, 'void dispose() {'),
              _CodeLine(4, '_ctrl.dispose();'),
              _CodeLine(4, 'super.dispose();'),
              _CodeLine(2, '}'),
              _CodeLine(0, ''),
              _CodeLine(2, '@override'),
              _CodeLine(2, 'Widget build(BuildContext context) {'),
              _CodeLine(4, 'return CupertinoTabScaffold('),
              _CodeLine(6, 'controller: _ctrl.value,'),
              _CodeLine(6, 'tabBar: CupertinoTabBar(items: _items),'),
              _CodeLine(6, 'tabBuilder: (c, i) => _pages[i],'),
              _CodeLine(4, ');'),
              _CodeLine(2, '}'),
              _CodeLine(0, '}'),
            ],
          ),
        ),
        const SizedBox(height: _kGapMd),
        Text(
          'Four anchor points: (1) declare the restorable as a field, '
          '(2) implement restorationId, (3) call registerForRestoration '
          'inside restoreState, (4) dispose the restorable in dispose. '
          'The framework does everything else.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

class _CodeLine {
  const _CodeLine(this.indent, this.text);
  final int indent;
  final String text;
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.lines});
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 28.0,
                  child: Text(
                    '${i + 1}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.white.withOpacity(0.30),
                    ),
                  ),
                ),
                const SizedBox(width: _kGapSm),
                Expanded(
                  child: Text(
                    '${' ' * lines[i].indent}${lines[i].text}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      height: 1.4,
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// =====================================================================
// Section 8 — Tab variants gallery
// =====================================================================
//
// Six variant tiles: bottom-only icons, with badges, custom icons,
// disabled tab, dark-mode swatch, and a tall navigation bar. Each one
// is rendered statically, using the _MiniTabBar primitive with a
// different decoration overlay.
// =====================================================================

Widget _buildTabVariantsSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Tab bar variants'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The same controller drives all six tab bars below — only '
          'the visual presentation changes. The first four use '
          'currentIndex = 0; the last two demonstrate dark-mode '
          'styling and a tall bar with badges.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Wrap(
          spacing: _kGapMd,
          runSpacing: _kGapMd,
          children: <Widget>[
            _variantTile(
              title: 'Icons only',
              subtitle: 'showLabels = false',
              child: _MiniTabBar(
                currentIndex: 0,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: CupertinoColors.activeBlue,
                background: const Color(0xFFF3F4F6),
                inactive: const Color(0xFF9CA3AF),
                showLabels: false,
              ),
            ),
            _variantTile(
              title: 'With labels',
              subtitle: 'default',
              child: const _MiniTabBar(
                currentIndex: 1,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: CupertinoColors.systemIndigo,
                background: Color(0xFFF3F4F6),
                inactive: Color(0xFF9CA3AF),
              ),
            ),
            _variantTile(
              title: 'Custom accent',
              subtitle: 'systemPink',
              child: const _MiniTabBar(
                currentIndex: 2,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: CupertinoColors.systemPink,
                background: Color(0xFFF3F4F6),
                inactive: Color(0xFF9CA3AF),
              ),
            ),
            _variantTile(
              title: 'Disabled tile',
              subtitle: 'index 3 dimmed',
              child: _disabledTabBar(),
            ),
            _variantTile(
              title: 'Dark mode swatch',
              subtitle: 'CupertinoColors.black',
              child: const _MiniTabBar(
                currentIndex: 0,
                icons: _kPrimaryTabIcons,
                labels: _kPrimaryTabLabels,
                accent: CupertinoColors.systemTeal,
                background: Color(0xFF111827),
                inactive: Color(0xFF6B7280),
              ),
            ),
            _variantTile(
              title: 'Tall with badges',
              subtitle: '64px height',
              child: _badgedTabBar(),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _variantTile({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: _kGalleryTileWidth,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      boxShadow: _softCardShadow(),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(_kCardRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(_kGapMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    ),
  );
}

Widget _disabledTabBar() {
  return Container(
    height: _kTabBarHeight,
    decoration: const BoxDecoration(
      color: Color(0xFFF3F4F6),
      border: Border(
        top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          Expanded(
            child: Opacity(
              opacity: i == 3 ? 0.35 : 1.0,
              child: Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: i == 0
                      ? CupertinoColors.activeBlue.withOpacity(0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      _kPrimaryTabIcons[i],
                      size: 18.0,
                      color: i == 0
                          ? CupertinoColors.activeBlue
                          : const Color(0xFF9CA3AF),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      _kPrimaryTabLabels[i],
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight:
                            i == 0 ? FontWeight.w600 : FontWeight.w500,
                        color: i == 0
                            ? CupertinoColors.activeBlue
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _badgedTabBar() {
  const List<int> badges = <int>[0, 3, 0, 12, 0];
  return Container(
    height: _kTabBarHeightTall,
    decoration: const BoxDecoration(
      color: Color(0xFFF3F4F6),
      border: Border(
        top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: i == 1
                    ? CupertinoColors.systemOrange.withOpacity(0.16)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Icon(
                        _kPrimaryTabIcons[i],
                        size: 22.0,
                        color: i == 1
                            ? CupertinoColors.systemOrange
                            : const Color(0xFF9CA3AF),
                      ),
                      if (badges[i] > 0)
                        Positioned(
                          top: -4.0,
                          right: -8.0,
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 16.0,
                              minHeight: 16.0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemRed,
                              borderRadius:
                                  BorderRadius.circular(_kPillRadius),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${badges[i]}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    _kPrimaryTabLabels[i],
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight:
                          i == 1 ? FontWeight.w700 : FontWeight.w500,
                      color: i == 1
                          ? CupertinoColors.systemOrange
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// Section 9 — Multi-display matrix of static tab states
// =====================================================================
//
// Renders the same controller's static frames in three different
// presentation cards: a hero card, a compact strip, and a detail
// preview.  All three read the same initial index — they only differ
// in how that index is presented.
// =====================================================================

Widget _buildDisplayMatrixSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _hierarchyGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Three displays — one controller'),
        const SizedBox(height: _kGapSm),
        const Text(
          'A single restorable controller can power any number of '
          'visual representations. The three cards below all read the '
          'controller\'s currentIndex once, at the same moment, and '
          'render it differently. Notice how the strip view collapses '
          'the bar into a row of dots, while the detail card lifts the '
          'active tab into a header chip.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        _displayHero(currentIndex: 2),
        const SizedBox(height: _kGapMd),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _displayDotsStrip(currentIndex: 2)),
            const SizedBox(width: _kGapMd),
            Expanded(child: _displayDetailCard(currentIndex: 2)),
          ],
        ),
      ],
    ),
  );
}

Widget _displayHero({required int currentIndex}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
    ),
    padding: const EdgeInsets.all(_kGapLg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _kGapMd,
                vertical: _kGapXs,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(_kPillRadius),
              ),
              child: Text(
                'currentIndex = $currentIndex',
                style: const TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'hero display',
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: _kGapMd),
        _MiniTabBar(
          currentIndex: currentIndex,
          icons: _kPrimaryTabIcons,
          labels: _kPrimaryTabLabels,
          accent: CupertinoColors.activeBlue,
          background: const Color(0xFFF9FAFB),
          inactive: const Color(0xFF9CA3AF),
        ),
      ],
    ),
  );
}

Widget _displayDotsStrip({required int currentIndex}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
    ),
    padding: const EdgeInsets.all(_kGapMd),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'compact strip',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int i = 0; i < 5; i++)
              Container(
                width: i == currentIndex ? 20.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: i == currentIndex
                      ? CupertinoColors.activeBlue
                      : const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(_kPillRadius),
                ),
              ),
          ],
        ),
        const SizedBox(height: _kGapSm),
        Text(
          'page $currentIndex of 5',
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF374151),
          ),
        ),
      ],
    ),
  );
}

Widget _displayDetailCard({required int currentIndex}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
    ),
    padding: const EdgeInsets.all(_kGapMd),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                _kPrimaryTabIcons[currentIndex],
                color: CupertinoColors.activeBlue,
                size: 20.0,
              ),
            ),
            const SizedBox(width: _kGapSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _kPrimaryTabLabels[currentIndex],
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const Text(
                    'detail header',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 10 — Pitfalls
// =====================================================================
//
// A red-tinted card listing the four most common mistakes when
// adopting RestorableCupertinoTabController. Each row gets an icon,
// a short title, and a one-sentence explanation.
// =====================================================================

Widget _buildPitfallsSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _pitfallsGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Pitfalls to avoid'),
        const SizedBox(height: _kGapSm),
        const Text(
          'These are the four mistakes most often seen in code review '
          'when teams first adopt RestorableCupertinoTabController. '
          'They are all easy to spot once you know what to look for.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        _pitfall(
          icon: CupertinoIcons.exclamationmark_triangle_fill,
          title: 'Forgetting to dispose the controller',
          body:
              'When you allocate a plain CupertinoTabController yourself '
              '(not via the Restorable wrapper) you own its lifecycle. '
              'Always call dispose() from the surrounding State.dispose '
              'or you will leak listeners on every tab switch.',
        ),
        _pitfall(
          icon: CupertinoIcons.tag_solid,
          title: 'RestorationId collisions',
          body:
              'Two sibling RestorationMixin states must not '
              'registerForRestoration with the same id. The framework '
              'will throw at runtime with an "already registered" error.',
        ),
        _pitfall(
          icon: CupertinoIcons.ear,
          title: 'Leaking listeners on currentIndex',
          body:
              'addListener must be balanced by removeListener (in dispose '
              'or when the listener is logically retired) or every tab '
              'change will accumulate dead callbacks in memory.',
        ),
        _pitfall(
          icon: CupertinoIcons.number,
          title: 'Mismatched initialIndex',
          body:
              'initialIndex on the restorable is only consulted on the '
              'first run. Once a value is in the bucket, it overrides '
              'the constructor parameter. Don\'t debug by tweaking the '
              'initialIndex; clear the restoration data instead.',
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: _kGapMd),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFFCA5A5),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(_kGapMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: const Color(0xFFB91C1C),
              size: 20.0,
            ),
          ),
          const SizedBox(width: _kGapMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7F1D1D),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13.0,
                    height: 1.4,
                    color: Color(0xFF374151),
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

// =====================================================================
// Section 11 — Footer
// =====================================================================
//
// A dark closer card that recaps the key facts and shows the
// canonical one-liner construction for the restorable.
// =====================================================================

Widget _buildFooterSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _footerGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.checkmark_seal_fill,
              color: Colors.white,
              size: 20.0,
            ),
            const SizedBox(width: _kGapSm),
            Text(
              'Recap',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: _kGapMd),
        Text(
          'RestorableCupertinoTabController is a thin RestorableChange'
          'Notifier wrapper around CupertinoTabController. It stores a '
          'single integer — the active tab index — inside a named '
          'RestorationBucket so the tab selection survives process '
          'death. The controller itself only exposes index, '
          'addListener / removeListener, notifyListeners, and dispose.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
        const SizedBox(height: _kGapMd),
        Container(
          padding: const EdgeInsets.all(_kGapMd),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.0,
            ),
          ),
          child: const Text(
            'final ctrl = RestorableCupertinoTabController(initialIndex: 0);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFE0F2FE),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Shared building blocks
// =====================================================================

Widget _sectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: Color(0xFF111827),
      letterSpacing: -0.2,
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '•  ',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.0, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _legendSwatch(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.black.withOpacity(0.08),
            width: 1.0,
          ),
        ),
      ),
      const SizedBox(width: _kGapXs + 2.0),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// =====================================================================
// Unused-but-referenced palette guard
// =====================================================================
//
// The accent palette and names are referenced in static gallery tiles
// via modulo indexing; this small helper makes the analyzer happy by
// pinning a use site to both lists, even when an extension of this
// file adds more tiles than entries.
// =====================================================================

String _accentNameFor(int i) {
  final int n = _kCupertinoAccentNames.length;
  return _kCupertinoAccentNames[((i % n) + n) % n];
}

Color _accentColorFor(int i) {
  final int n = _kCupertinoAccents.length;
  return _kCupertinoAccents[((i % n) + n) % n];
}

// Silence "unused element" lints by referencing both helpers and the
// math / ui imports from a no-op pinning function.  The function is
// never invoked at runtime; it exists purely for static analysis.
List<Object> _unusedPin() {
  return <Object>[
    _accentNameFor(0),
    _accentColorFor(0),
    math.pi,
    ui.PointMode.points,
  ];
}
