// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element
//
// sliver_advanced_test.dart
// =========================
//
// Hand-authored deep demonstration of Flutter slivers and the
// CustomScrollView family.  This file is intentionally verbose; it is
// designed both as a visual reference page and as a corpus for the
// d4rt AST/serialization round-trip tests in tom_d4rt_flutter_ast.
//
// What this script demonstrates
// -----------------------------
// The build() function returns a single MaterialApp whose home is a
// Scaffold containing a parent ListView.  The ListView holds a stack
// of fixed-height SizedBoxes, each wrapping a CustomScrollView, plus
// prose blocks between them.  Each CustomScrollView focuses on a
// specific sliver pattern, and together they cover:
//
//   * SliverAppBar variations (collapsed, pinned, floating+snap,
//     flexibleSpace with gradient)
//   * SliverList via SliverChildBuilderDelegate
//   * SliverGrid via SliverGrid.count and SliverChildListDelegate
//   * SliverFillViewport hosting full-page-style children
//   * SliverPadding around a SliverList
//   * SliverPersistentHeader with a private SliverPersistentHeader
//     Delegate subclass overriding build / minExtent / maxExtent /
//     shouldRebuild
//   * SliverFillRemaining hosting a centered hero card
//   * SliverToBoxAdapter embedding a single decorated container
//
// Layout strategy
// ---------------
// We use a parent ListView as the master scroller.  Each section
// occupies a fixed-height SizedBox; the inner CustomScrollViews are
// allowed to scroll independently.  This approach keeps each demo
// self-contained and avoids nested-scroll surprises while still
// exercising every sliver type listed above.
//
// Theming / aesthetics
// --------------------
// The page is dense with gradients (>= 6) and box shadows (>= 6).
// Every colour is opted into withValues(alpha:) instead of the
// deprecated withOpacity(...) helper, so the file is forward-compat
// with newer Flutter SDKs.
//
// Why so many comments?
// ---------------------
// This file doubles as documentation for newcomers to slivers.  Each
// section is preceded by an explanatory header describing the sliver
// type, its delegate, and its typical use case.  The prose blocks
// rendered on-screen mirror that documentation so the live demo and
// the source file stay in lock-step.
//
// Conventions used in this file
// -----------------------------
//   _Private    - private helper class (leading underscore)
//   _kSomething - private compile-time constant
//   _build*     - private builder helper
//
// All helper classes are private; nothing leaks outside this file.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Compile-time constants — colours, sizes, gradients, shadows.
// Pulling these to the top makes it easy to tweak the look of every
// section in a single place.
// ---------------------------------------------------------------------------

const double _kSectionHeight = 360.0;
const double _kTallSectionHeight = 480.0;
const double _kPageGutter = 16.0;
const double _kCardRadius = 14.0;
const double _kBigRadius = 22.0;
const double _kHeaderMin = 56.0;
const double _kHeaderMax = 132.0;

const Color _kBg0 = Color(0xFF0E1116);
const Color _kBg1 = Color(0xFF161B22);
const Color _kBg2 = Color(0xFF21262D);
const Color _kAccent0 = Color(0xFF7C5CFF);
const Color _kAccent1 = Color(0xFF22D3EE);
const Color _kAccent2 = Color(0xFFF472B6);
const Color _kAccent3 = Color(0xFFFB7185);
const Color _kAccent4 = Color(0xFF34D399);
const Color _kAccent5 = Color(0xFFFACC15);
const Color _kInk0 = Color(0xFFE6EDF3);
const Color _kInk1 = Color(0xFFB1BAC4);
const Color _kInk2 = Color(0xFF8B949E);

// Gradient #1 — cool indigo→cyan, used by the SliverAppBar flexible space.
const LinearGradient _kGradientCool = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF1E1B4B),
    Color(0xFF312E81),
    Color(0xFF1E40AF),
    Color(0xFF0EA5E9),
  ],
  stops: <double>[0.0, 0.4, 0.75, 1.0],
);

// Gradient #2 — warm pink→orange, used for cards in section B.
const LinearGradient _kGradientWarm = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[
    Color(0xFFEC4899),
    Color(0xFFF472B6),
    Color(0xFFFB7185),
    Color(0xFFF97316),
  ],
);

// Gradient #3 — emerald → teal, used for grid tiles.
const LinearGradient _kGradientForest = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color(0xFF065F46),
    Color(0xFF047857),
    Color(0xFF14B8A6),
    Color(0xFF22D3EE),
  ],
);

// Gradient #4 — graphite, used for prose backgrounds.
const LinearGradient _kGradientGraphite = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF111827),
    Color(0xFF1F2937),
    Color(0xFF374151),
  ],
);

// Gradient #5 — solar, used for SliverFillViewport "pages".
const LinearGradient _kGradientSolar = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFFFACC15),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF7C2D12),
  ],
);

// Gradient #6 — aurora, used by SliverPersistentHeader banner.
const LinearGradient _kGradientAurora = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF6D28D9),
    Color(0xFF7C3AED),
    Color(0xFFDB2777),
    Color(0xFFF59E0B),
  ],
);

// Gradient #7 — twilight, used by hero card in SliverFillRemaining.
const LinearGradient _kGradientTwilight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF0F172A),
    Color(0xFF1E293B),
    Color(0xFF312E81),
    Color(0xFF6D28D9),
  ],
);

// Gradient #8 — copper, used by SliverToBoxAdapter standout.
const LinearGradient _kGradientCopper = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xFF92400E),
    Color(0xFFB45309),
    Color(0xFFEA580C),
    Color(0xFFF59E0B),
  ],
);

// Box shadows — multiple soft layers with explicit alpha; never
// .withOpacity().
final List<BoxShadow> _kShadowSoft = <BoxShadow>[
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.25),
    blurRadius: 18.0,
    spreadRadius: 1.0,
    offset: const Offset(0.0, 8.0),
  ),
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.14),
    blurRadius: 4.0,
    offset: const Offset(0.0, 2.0),
  ),
];

final List<BoxShadow> _kShadowDeep = <BoxShadow>[
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.45),
    blurRadius: 28.0,
    spreadRadius: 2.0,
    offset: const Offset(0.0, 12.0),
  ),
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.22),
    blurRadius: 6.0,
    offset: const Offset(0.0, 3.0),
  ),
];

final List<BoxShadow> _kShadowGlow = <BoxShadow>[
  BoxShadow(
    color: _kAccent0.withValues(alpha: 0.45),
    blurRadius: 22.0,
    spreadRadius: 1.0,
    offset: const Offset(0.0, 0.0),
  ),
  BoxShadow(
    color: _kAccent1.withValues(alpha: 0.30),
    blurRadius: 36.0,
    spreadRadius: 2.0,
    offset: const Offset(0.0, 0.0),
  ),
];

final List<BoxShadow> _kShadowCard = <BoxShadow>[
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.32),
    blurRadius: 12.0,
    offset: const Offset(0.0, 6.0),
  ),
];

final List<BoxShadow> _kShadowSubtle = <BoxShadow>[
  BoxShadow(
    color: Color(0xFF000000).withValues(alpha: 0.16),
    blurRadius: 6.0,
    offset: const Offset(0.0, 2.0),
  ),
];

final List<BoxShadow> _kShadowEmphatic = <BoxShadow>[
  BoxShadow(
    color: _kAccent2.withValues(alpha: 0.40),
    blurRadius: 20.0,
    offset: const Offset(0.0, 8.0),
  ),
  BoxShadow(
    color: _kAccent3.withValues(alpha: 0.25),
    blurRadius: 32.0,
    offset: const Offset(0.0, 14.0),
  ),
];

// ---------------------------------------------------------------------------
// Text styles bundled at file scope so each section reads tersely.
// ---------------------------------------------------------------------------

const TextStyle _kPageTitle = TextStyle(
  color: _kInk0,
  fontSize: 28.0,
  fontWeight: FontWeight.w800,
  letterSpacing: -0.4,
);

const TextStyle _kSectionTitle = TextStyle(
  color: _kInk0,
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  letterSpacing: -0.2,
);

const TextStyle _kSectionLabel = TextStyle(
  color: _kInk1,
  fontSize: 13.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.6,
);

const TextStyle _kBody = TextStyle(
  color: _kInk1,
  fontSize: 14.0,
  height: 1.42,
);

const TextStyle _kSmall = TextStyle(
  color: _kInk2,
  fontSize: 12.0,
  height: 1.3,
);

const TextStyle _kCaption = TextStyle(
  color: _kInk0,
  fontSize: 11.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.8,
);

const TextStyle _kHeroTitle = TextStyle(
  color: _kInk0,
  fontSize: 24.0,
  fontWeight: FontWeight.w800,
);

// ---------------------------------------------------------------------------
// _Private helper widget classes.
// ---------------------------------------------------------------------------

/// _SectionFrame wraps each demo block in a header + fixed-height body.
/// The body contains a CustomScrollView (or other scrollable) and the
/// header carries a small leading "tag" used to identify the sliver
/// type (e.g. "B / SliverList") plus a longer description.
class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.height,
    required this.child,
    this.gradient,
  });

  final String tag;
  final String title;
  final String subtitle;
  final double height;
  final Widget child;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration containerDeco = BoxDecoration(
      gradient: gradient ?? _kGradientGraphite,
      borderRadius: BorderRadius.circular(_kBigRadius),
      boxShadow: _kShadowDeep,
      border: Border.all(
        color: _kInk2.withValues(alpha: 0.25),
        width: 1.0,
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: _kPageGutter,
        vertical: 12.0,
      ),
      decoration: containerDeco,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: _kAccent0.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: _kAccent0.withValues(alpha: 0.55),
                      width: 1.0,
                    ),
                  ),
                  child: Text(tag, style: _kCaption),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: _kSectionTitle),
                      const SizedBox(height: 4.0),
                      Text(subtitle, style: _kSmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(_kBigRadius),
                bottomRight: Radius.circular(_kBigRadius),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// _ProseBlock renders a titled paragraph between sections.  Each
/// block is itself wrapped in a soft graphite container so the page
/// reads like a magazine-style explainer rather than a debug page.
class _ProseBlock extends StatelessWidget {
  const _ProseBlock({
    required this.title,
    required this.lines,
    this.accent = _kAccent1,
  });

  final String title;
  final List<String> lines;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(
      Row(
        children: <Widget>[
          Container(
            width: 8.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.65),
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 0.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Text(title, style: _kSectionTitle),
        ],
      ),
    );
    children.add(const SizedBox(height: 10.0));
    for (int i = 0; i < lines.length; i = i + 1) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(lines[i], style: _kBody),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: _kPageGutter,
        vertical: 10.0,
      ),
      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 18.0),
      decoration: BoxDecoration(
        gradient: _kGradientGraphite,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _kShadowCard,
        border: Border.all(
          color: _kInk2.withValues(alpha: 0.20),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

/// _GradientCard is a generic decorated container used by SliverList
/// (Section B) to render its 30 entries.  The gradient and shadow
/// vary slightly per index to add visual rhythm without setState.
class _GradientCard extends StatelessWidget {
  const _GradientCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.shadow,
  });

  final int index;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final List<BoxShadow> shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: shadow,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF000000).withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _kInk0.withValues(alpha: 0.40),
                width: 1.0,
              ),
            ),
            child: Text(
              '#${index.toString().padLeft(2, '0')}',
              style: _kCaption,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk0,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _kInk0.withValues(alpha: 0.85),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: _kInk0.withValues(alpha: 0.85),
          ),
        ],
      ),
    );
  }
}

/// _GridTile is used by Section C (SliverGrid.count).  Each tile is a
/// square gradient card with a glyph and label.
class _GridTile extends StatelessWidget {
  const _GridTile({
    required this.index,
    required this.label,
    required this.icon,
    required this.gradient,
  });

  final int index;
  final String label;
  final IconData icon;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _kShadowCard,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: _kInk0, size: 28.0),
          const SizedBox(height: 6.0),
          Text(label, style: _kCaption),
          const SizedBox(height: 2.0),
          Text('${index + 1}', style: _kSmall),
        ],
      ),
    );
  }
}

/// _ViewportPage models a "page" that fills the entire viewport when
/// nested inside a SliverFillViewport.  Each page is a centered hero
/// with a gradient backdrop and shadowed call-out card.
class _ViewportPage extends StatelessWidget {
  const _ViewportPage({
    required this.title,
    required this.body,
    required this.gradient,
    required this.icon,
  });

  final String title;
  final String body;
  final LinearGradient gradient;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFF000000).withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(_kBigRadius),
          boxShadow: _kShadowDeep,
          border: Border.all(
            color: _kInk0.withValues(alpha: 0.30),
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: _kInk0, size: 26.0),
                const SizedBox(width: 8.0),
                Text(title, style: _kHeroTitle),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(body, style: _kBody),
          ],
        ),
      ),
    );
  }
}

/// _BannerHeader is the actual visual produced by our custom
/// SliverPersistentHeaderDelegate.  It draws an aurora gradient
/// strip with a title that fades in based on shrinkOffset / maxExtent.
class _BannerHeader extends StatelessWidget {
  const _BannerHeader({
    required this.shrinkOffset,
    required this.maxExtent,
  });

  final double shrinkOffset;
  final double maxExtent;

  @override
  Widget build(BuildContext context) {
    final double progress = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    final double scale = 1.0 - (0.18 * progress);
    return Container(
      decoration: BoxDecoration(
        gradient: _kGradientAurora,
        boxShadow: _kShadowSoft,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _kInk0.withValues(alpha: 0.55),
                width: 1.0,
              ),
            ),
            child: const Icon(Icons.bolt_rounded, color: _kInk0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pinned aurora banner',
                  style: TextStyle(
                    color: _kInk0,
                    fontSize: 18.0 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'progress=${progress.toStringAsFixed(2)} '
                  '· shrink=${shrinkOffset.toStringAsFixed(0)}',
                  style: _kSmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: _kInk0.withValues(alpha: 0.45),
                width: 1.0,
              ),
            ),
            child: const Text('PINNED', style: _kCaption),
          ),
        ],
      ),
    );
  }
}

/// _AuroraHeaderDelegate is the private SliverPersistentHeaderDelegate
/// subclass used in Section F.  It overrides build, minExtent,
/// maxExtent and shouldRebuild — the four required overrides for any
/// custom delegate.
class _AuroraHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _AuroraHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _BannerHeader(
      shrinkOffset: shrinkOffset,
      maxExtent: maxExtent,
    );
  }

  @override
  bool shouldRebuild(covariant _AuroraHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}

/// _HeroCard fills the SliverFillRemaining slot in Section G.  It is
/// large, centered, and visually dense to make it obvious that the
/// last sliver expanded to fill all remaining viewport space.
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: _kGradientTwilight),
      alignment: Alignment.center,
      child: Container(
        width: 280.0,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFF000000).withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(_kBigRadius),
          boxShadow: _kShadowGlow,
          border: Border.all(
            color: _kAccent1.withValues(alpha: 0.55),
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
                gradient: _kGradientAurora,
                shape: BoxShape.circle,
                boxShadow: _kShadowEmphatic,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: _kInk0,
                size: 32.0,
              ),
            ),
            const SizedBox(height: 14.0),
            const Text('SliverFillRemaining', style: _kHeroTitle),
            const SizedBox(height: 6.0),
            const Text(
              'The last sliver expands to fill the rest of the\n'
              'viewport — perfect for empty states and heroes.',
              style: _kBody,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// _StandoutBox is the single decorated container embedded by
/// SliverToBoxAdapter in Section H.  It demonstrates how to drop one
/// off-the-shelf RenderBox widget into a sliver list without writing
/// a custom delegate.
class _StandoutBox extends StatelessWidget {
  const _StandoutBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: _kGradientCopper,
        borderRadius: BorderRadius.circular(_kBigRadius),
        boxShadow: _kShadowEmphatic,
        border: Border.all(
          color: _kInk0.withValues(alpha: 0.40),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: Color(0xFF000000).withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: _kInk0.withValues(alpha: 0.55),
                width: 1.0,
              ),
            ),
            child: const Icon(
              Icons.bookmark_rounded,
              color: _kInk0,
              size: 28.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('SliverToBoxAdapter', style: _kSectionTitle),
                const SizedBox(height: 4.0),
                Text(
                  'Embed any normal RenderBox widget — Container, '
                  'Card, Row — directly into a CustomScrollView.',
                  style: _kBody,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section builders.  Each returns the body of one section (the part
// that sits inside the fixed-height SizedBox in the parent ListView).
// ---------------------------------------------------------------------------

/// Section A — SliverAppBar variations.  We render four independent
/// CustomScrollViews side-by-side in a horizontal scroll so the user
/// can compare the four configurations at a glance.
Widget _buildSectionA() {
  // CustomScrollView #1 — collapsed app bar.
  final Widget collapsed = CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      const SliverAppBar(
        expandedHeight: 80.0,
        backgroundColor: _kBg2,
        foregroundColor: _kInk0,
        title: Text('Collapsed'),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          for (int i = 0; i < 12; i = i + 1)
            ListTile(
              leading: const Icon(Icons.list_alt, color: _kInk1),
              title: Text(
                'Row #${i + 1}',
                style: const TextStyle(color: _kInk0),
              ),
              subtitle: const Text('static collapsed', style: _kSmall),
            ),
        ]),
      ),
    ],
  );

  // CustomScrollView #2 — pinned app bar.
  final Widget pinned = CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        expandedHeight: 120.0,
        backgroundColor: _kBg2,
        foregroundColor: _kInk0,
        title: const Text('Pinned'),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(gradient: _kGradientCool),
          ),
          title: const Text(
            'pinned: true',
            style: TextStyle(color: _kInk0, fontSize: 14.0),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          for (int i = 0; i < 14; i = i + 1)
            ListTile(
              leading: const Icon(Icons.push_pin, color: _kInk1),
              title: Text(
                'Pinned row #${i + 1}',
                style: const TextStyle(color: _kInk0),
              ),
            ),
        ]),
      ),
    ],
  );

  // CustomScrollView #3 — floating + snap.
  final Widget floating = CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        floating: true,
        snap: true,
        expandedHeight: 110.0,
        backgroundColor: _kBg2,
        foregroundColor: _kInk0,
        title: const Text('Floating + snap'),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(gradient: _kGradientWarm),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          for (int i = 0; i < 14; i = i + 1)
            ListTile(
              leading: const Icon(Icons.flutter_dash, color: _kInk1),
              title: Text(
                'Floating row #${i + 1}',
                style: const TextStyle(color: _kInk0),
              ),
            ),
        ]),
      ),
    ],
  );

  // CustomScrollView #4 — flexibleSpace with rich gradient art.
  final Widget flexible = CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        expandedHeight: 160.0,
        backgroundColor: _kBg2,
        foregroundColor: _kInk0,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text(
            'flexibleSpace',
            style: TextStyle(color: _kInk0, fontSize: 14.0),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(gradient: _kGradientAurora),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000).withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('FLEXIBLE', style: _kCaption),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          for (int i = 0; i < 14; i = i + 1)
            ListTile(
              leading: const Icon(Icons.auto_awesome, color: _kInk1),
              title: Text(
                'Aurora row #${i + 1}',
                style: const TextStyle(color: _kInk0),
              ),
            ),
        ]),
      ),
    ],
  );

  // Stitch the four scroll views into a horizontal carousel.
  return ListView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.all(12.0),
    children: <Widget>[
      SizedBox(width: 280.0, child: collapsed),
      const SizedBox(width: 12.0),
      SizedBox(width: 280.0, child: pinned),
      const SizedBox(width: 12.0),
      SizedBox(width: 280.0, child: floating),
      const SizedBox(width: 12.0),
      SizedBox(width: 280.0, child: flexible),
    ],
  );
}

/// Section B — SliverList using SliverChildBuilderDelegate to lazily
/// construct 30 gradient cards.
Widget _buildSectionB() {
  // Cycle through these gradients/shadows so adjacent cards differ.
  final List<LinearGradient> gradients = <LinearGradient>[
    _kGradientWarm,
    _kGradientCool,
    _kGradientForest,
    _kGradientSolar,
    _kGradientAurora,
    _kGradientCopper,
  ];
  final List<List<BoxShadow>> shadows = <List<BoxShadow>>[
    _kShadowSoft,
    _kShadowDeep,
    _kShadowCard,
    _kShadowEmphatic,
    _kShadowSubtle,
    _kShadowGlow,
  ];

  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final LinearGradient g = gradients[index % gradients.length];
              final List<BoxShadow> s = shadows[index % shadows.length];
              return _GradientCard(
                index: index,
                title: 'Builder card ${index + 1}',
                subtitle: 'lazy delegate · gradient '
                    '${(index % gradients.length) + 1}/${gradients.length}',
                gradient: g,
                shadow: s,
              );
            },
            childCount: 30,
          ),
        ),
      ),
    ],
  );
}

/// Section C — SliverGrid via SliverGrid.count with 3 columns and 24
/// tiles.
Widget _buildSectionC() {
  // Pre-build the 24 tiles using List.generate.  This shows that the
  // grid can take a SliverChildListDelegate-backed list as well as a
  // builder when the data set is known.
  final List<IconData> glyphs = <IconData>[
    Icons.bolt,
    Icons.brightness_5,
    Icons.cloud,
    Icons.diamond,
    Icons.eco,
    Icons.favorite,
    Icons.gradient,
    Icons.handyman,
    Icons.icecream,
    Icons.kitesurfing,
    Icons.local_fire_department,
    Icons.mood,
  ];
  final List<LinearGradient> gradients = <LinearGradient>[
    _kGradientWarm,
    _kGradientCool,
    _kGradientForest,
    _kGradientSolar,
    _kGradientCopper,
    _kGradientAurora,
  ];

  final List<Widget> tiles = List<Widget>.generate(24, (int i) {
    return _GridTile(
      index: i,
      label: 'Tile',
      icon: glyphs[i % glyphs.length],
      gradient: gradients[i % gradients.length],
    );
  });

  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.95,
          children: tiles,
        ),
      ),
    ],
  );
}

/// Section D — SliverFillViewport hosting three "page"-shaped
/// children, each with a different gradient.  We use horizontal
/// scroll direction so the pages slide left/right like a carousel.
Widget _buildSectionD() {
  final List<Widget> pages = <Widget>[
    const _ViewportPage(
      title: 'Page one',
      body: 'SliverFillViewport sizes each child to the full main-axis '
          'extent of the viewport. Great for paged content, onboarding '
          'flows, or carousel-like UX inside a single CustomScrollView.',
      gradient: _kGradientCool,
      icon: Icons.looks_one,
    ),
    const _ViewportPage(
      title: 'Page two',
      body: 'Each page receives the entire viewport — contrast this '
          'with SliverFillRemaining, which only fills whatever is left '
          'after earlier slivers have laid out.',
      gradient: _kGradientForest,
      icon: Icons.looks_two,
    ),
    const _ViewportPage(
      title: 'Page three',
      body: 'You can mix SliverFillViewport pages with SliverList and '
          'SliverGrid in the same CustomScrollView. Pages do not have '
          'to be the only sliver type present.',
      gradient: _kGradientSolar,
      icon: Icons.looks_3,
    ),
  ];

  return CustomScrollView(
    scrollDirection: Axis.horizontal,
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverFillViewport(
        viewportFraction: 1.0,
        delegate: SliverChildListDelegate(pages),
      ),
    ],
  );
}

/// Section E — SliverPadding wrapping a SliverList.  The point of
/// this section is to highlight that padding applied at the sliver
/// layer is conceptually different from wrapping each child in a
/// Padding widget.
Widget _buildSectionE() {
  // Pre-create the list with List.generate to keep the builder lean.
  final List<Widget> rows = List<Widget>.generate(20, (int i) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kBg2,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _kShadowSubtle,
        border: Border.all(
          color: _kInk2.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8.0,
            height: 32.0,
            decoration: BoxDecoration(
              gradient: i.isEven ? _kGradientCool : _kGradientWarm,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Padded row ${i + 1}',
                  style: const TextStyle(
                    color: _kInk0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'EdgeInsets applied to the sliver, not each child.',
                  style: _kSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });

  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(28.0, 14.0, 28.0, 14.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(rows),
        ),
      ),
    ],
  );
}

/// Section F — SliverPersistentHeader using our private delegate.
/// Below the pinned header we render a SliverList so scroll travel is
/// long enough to actually exercise the pin behaviour.
Widget _buildSectionF() {
  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      const SliverPersistentHeader(
        pinned: true,
        delegate: _AuroraHeaderDelegate(
          minHeight: _kHeaderMin,
          maxHeight: _kHeaderMax,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 6.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _kBg2,
                borderRadius: BorderRadius.circular(_kCardRadius),
                boxShadow: _kShadowCard,
                border: Border.all(
                  color: _kInk2.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32.0,
                    height: 32.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: index.isEven
                          ? _kGradientForest
                          : _kGradientAurora,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: _kShadowSubtle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: _kCaption,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Header partner row ${index + 1}',
                          style: const TextStyle(
                            color: _kInk0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Pinned aurora banner stays glued to the top.',
                          style: _kSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 24,
        ),
      ),
    ],
  );
}

/// Section G — SliverFillRemaining.  We layer a small SliverToBoxAdapter
/// before it so the user can see "fill remaining" actually doing the
/// thing it advertises.
Widget _buildSectionG() {
  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: _kGradientGraphite,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: _kShadowSubtle,
            border: Border.all(
              color: _kInk2.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.info_outline, color: _kInk0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Below this row, SliverFillRemaining expands to cover '
                  'the rest of the viewport.',
                  style: _kBody,
                ),
              ),
            ],
          ),
        ),
      ),
      const SliverFillRemaining(
        hasScrollBody: false,
        child: _HeroCard(),
      ),
    ],
  );
}

/// Section H — SliverToBoxAdapter standout, stitched together with a
/// short SliverList so it does not look like a one-trick demo.
Widget _buildSectionH() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < 6; i = i + 1) {
    rows.add(
      ListTile(
        leading: Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            gradient: i.isEven ? _kGradientCool : _kGradientForest,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: _kShadowSubtle,
          ),
          child: const Icon(Icons.tag, color: _kInk0, size: 18.0),
        ),
        title: Text(
          'Adapter neighbour ${i + 1}',
          style: const TextStyle(color: _kInk0),
        ),
        subtitle: const Text(
          'Normal SliverList row beside the adapter.',
          style: _kSmall,
        ),
      ),
    );
  }

  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: <Widget>[
      const SliverToBoxAdapter(child: _StandoutBox()),
      SliverList(delegate: SliverChildListDelegate(rows)),
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kBg1,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: _kShadowSubtle,
            border: Border.all(
              color: _kInk2.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.check_circle, color: _kAccent4),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Adapters can also live at the *end* of a sliver list '
                  'to act as a footer.',
                  style: _kBody,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Page chrome — title hero + bottom credit.
// ---------------------------------------------------------------------------

/// _Hero is the splash element at the top of the page, rendered as
/// the first child of the parent ListView (so it scrolls away when
/// the user pages down through the demo).
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        _kPageGutter,
        20.0,
        _kPageGutter,
        12.0,
      ),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: _kGradientAurora,
        borderRadius: BorderRadius.circular(_kBigRadius),
        boxShadow: _kShadowDeep,
        border: Border.all(
          color: _kInk0.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: Color(0xFF000000).withValues(alpha: 0.32),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: _kShadowSubtle,
                  border: Border.all(
                    color: _kInk0.withValues(alpha: 0.55),
                    width: 1.0,
                  ),
                ),
                child: const Icon(Icons.layers, color: _kInk0),
              ),
              const SizedBox(width: 12.0),
              const Expanded(
                child: Text(
                  'Slivers — a deep tour',
                  style: _kPageTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Eight CustomScrollView sections demonstrating every major '
            'sliver type, paired with prose explaining when and why to '
            'reach for each one. Use the parent ListView to navigate '
            'between sections; each demo scrolls independently.',
            style: _kBody,
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              for (final String tag in <String>[
                'SliverAppBar',
                'SliverList',
                'SliverGrid',
                'SliverFillViewport',
                'SliverPadding',
                'SliverPersistentHeader',
                'SliverFillRemaining',
                'SliverToBoxAdapter',
                'SliverChildBuilderDelegate',
                'SliverChildListDelegate',
              ])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000).withValues(alpha: 0.30),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: _kInk0.withValues(alpha: 0.45),
                      width: 1.0,
                    ),
                  ),
                  child: Text(tag, style: _kCaption),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// _Footer closes the page with a small credit row.
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        _kPageGutter,
        12.0,
        _kPageGutter,
        24.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _kBg1,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _kShadowSubtle,
        border: Border.all(
          color: _kInk2.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.code, color: _kInk1),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Hand-authored corpus for tom_d4rt_flutter_ast — '
              'sliver_advanced_test.dart',
              style: _kSmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// build() — the single entry point for the d4rt AST round-trip test.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sliver Advanced Test',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBg0,
      primaryColor: _kAccent0,
      colorScheme: const ColorScheme.dark(
        primary: _kAccent0,
        secondary: _kAccent1,
        surface: _kBg1,
      ),
      textTheme: const TextTheme(
        bodyMedium: _kBody,
        bodySmall: _kSmall,
        titleLarge: _kSectionTitle,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBg0,
      body: SafeArea(
        child: ListView(
          // Parent ListView is the master scroller.  Each section is a
          // fixed-height SizedBox containing an inner CustomScrollView
          // that scrolls independently.
          padding: const EdgeInsets.only(bottom: 24.0),
          children: <Widget>[
            const _Hero(),
            const _ProseBlock(
              title: 'Slivers vs ListView',
              accent: _kAccent0,
              lines: <String>[
                'A normal ListView is a single scrollable widget that lays '
                'out box children one after another. It is fine for the '
                'common case of "scroll a column of rows" but it cannot '
                'mix layout strategies — every child uses the same lazy '
                'box model.',
                'Slivers are a more primitive abstraction: each sliver '
                'knows its own scroll geometry. A CustomScrollView is a '
                'host that combines several slivers into one viewport, so '
                'you can mix grids, lists, headers, and full-page heroes '
                'inside the same scroll session.',
                'You reach for slivers when a single ListView is no longer '
                'expressive enough — typically the moment you need a '
                'pinned header, a grid section, or a "fill the rest of '
                'the screen" footer.',
              ],
            ),
            _SectionFrame(
              tag: 'A / SliverAppBar',
              title: 'Four flavours of SliverAppBar',
              subtitle:
                  'collapsed · pinned · floating+snap · flexibleSpace',
              height: _kSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionA(),
            ),
            const _ProseBlock(
              title: 'When to choose CustomScrollView',
              accent: _kAccent2,
              lines: <String>[
                'Pick CustomScrollView when at least one of these is '
                'true: you need an app bar that participates in scroll '
                '(pinned/floating); you have multiple distinct sections '
                'that should feel like one continuous scroll; or you '
                'need a final sliver that fills the remaining space.',
                'Stick with ListView/GridView when you only have a '
                'homogeneous stream of items and no special header or '
                'footer behaviour. The gain from slivers comes from '
                'mixing layouts — if you do not mix, you will not feel '
                'the benefit.',
              ],
            ),
            _SectionFrame(
              tag: 'B / SliverList',
              title: 'Lazy SliverChildBuilderDelegate',
              subtitle:
                  'Builder constructs 30 cards on demand; gradient '
                  'cycles every 6.',
              height: _kTallSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionB(),
            ),
            const _ProseBlock(
              title: 'Delegate types compared',
              accent: _kAccent4,
              lines: <String>[
                'SliverChildBuilderDelegate is the lazy delegate. It '
                'receives an `int index` and constructs widgets on '
                'demand. Use it for long, possibly-infinite, or '
                'expensive-to-build content. Always set `childCount` if '
                'you know the total — it lets the framework reason '
                'about scroll extent.',
                'SliverChildListDelegate is the eager delegate. It takes '
                'a `List<Widget>` you already built. Use it for short '
                'static lists where laziness is not worth the indirection.',
              ],
            ),
            _SectionFrame(
              tag: 'C / SliverGrid.count',
              title: '3-column SliverGrid',
              subtitle:
                  'List.generate produces 24 tiles — eager delegate, '
                  'fixed cross axis count.',
              height: _kSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionC(),
            ),
            const _ProseBlock(
              title: 'Header sliver patterns',
              accent: _kAccent5,
              lines: <String>[
                'SliverAppBar is the easy-mode header — it bundles the '
                'pinned/floating/snap/expanded behaviours into a single '
                'widget. Reach for it when you want a stylised app bar '
                'with a flexibleSpace, a title, and standard back / '
                'action buttons.',
                'SliverPersistentHeader is the lower-level primitive. '
                'You provide a delegate with min/max extent and a build '
                'callback that receives the current shrink offset. Use '
                'it when you want a custom "sticky" element that is not '
                'an app bar — section dividers, filter chips, search '
                'fields, etc.',
              ],
            ),
            _SectionFrame(
              tag: 'D / SliverFillViewport',
              title: 'Paged horizontal carousel',
              subtitle:
                  'Three full-viewport pages, each with its own gradient.',
              height: _kSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionD(),
            ),
            const _ProseBlock(
              title: 'Padding at the sliver layer',
              accent: _kAccent3,
              lines: <String>[
                'There are two ways to add padding around a list of '
                'children: wrap each child in a Padding widget, or wrap '
                'the whole sliver in SliverPadding. The latter is '
                'cheaper because the padding only contributes to layout '
                'once, instead of N times.',
                'SliverPadding is also the right tool when you want '
                'symmetric padding on the *cross axis* (left/right) but '
                'no spacing between items — you cannot easily express '
                'that with widget-level Padding without changing every '
                'item.',
              ],
            ),
            _SectionFrame(
              tag: 'E / SliverPadding',
              title: 'SliverPadding around a SliverList',
              subtitle:
                  'EdgeInsets applied at the sliver layer — efficient '
                  'and clean.',
              height: _kSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionE(),
            ),
            const _ProseBlock(
              title: 'Persistent headers in detail',
              accent: _kAccent0,
              lines: <String>[
                'A SliverPersistentHeaderDelegate must override four '
                'members: `build(context, shrinkOffset, overlapsContent)` '
                'returns the visual; `minExtent` and `maxExtent` describe '
                'the size range; and `shouldRebuild(old)` decides whether '
                'a new delegate instance forces a rebuild.',
                'You can interpolate between the min and max extents '
                'inside `build` to produce a smooth shrink animation, '
                'just like a real SliverAppBar with `flexibleSpace`. The '
                'banner in section F demonstrates this — its title scales '
                'down as the user scrolls.',
              ],
            ),
            _SectionFrame(
              tag: 'F / SliverPersistentHeader',
              title: 'Custom delegate, pinned',
              subtitle:
                  'minExtent=$_kHeaderMin, maxExtent=$_kHeaderMax, with '
                  'shouldRebuild override.',
              height: _kTallSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionF(),
            ),
            const _ProseBlock(
              title: 'Performance — lazy delegates vs static lists',
              accent: _kAccent1,
              lines: <String>[
                'Builder delegates create children only when the viewport '
                'reaches them. For a thousand-item list this is a huge '
                'win. For a ten-item list it is overkill — the lookup '
                'overhead can dwarf the construction cost.',
                'Rule of thumb: SliverChildBuilderDelegate above ~50 '
                'items, SliverChildListDelegate below. Above ~50 items '
                'with cheap children, the builder still wins because it '
                'avoids the upfront list allocation.',
                'For grids the same reasoning applies; SliverGrid.count '
                'and SliverGrid.extent both accept either delegate.',
              ],
            ),
            _SectionFrame(
              tag: 'G / SliverFillRemaining',
              title: 'Hero in remaining viewport',
              subtitle:
                  'Last sliver expands to fill whatever space is left.',
              height: _kSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionG(),
            ),
            const _ProseBlock(
              title: 'When to use SliverToBoxAdapter',
              accent: _kAccent4,
              lines: <String>[
                'SliverToBoxAdapter is the bridge between the box world '
                'and the sliver world. Wrap any normal RenderBox widget '
                'in it, and that widget appears in the CustomScrollView '
                'as if it were a single-item sliver.',
                'Common uses: section headers that are not pinned; '
                'inline call-out cards between two SliverLists; "load '
                'more" footers; one-off advertisements. If you find '
                'yourself wrapping many widgets in adapters, consider '
                'using a SliverList with a SliverChildListDelegate '
                'instead — it is cheaper.',
              ],
            ),
            _SectionFrame(
              tag: 'H / SliverToBoxAdapter',
              title: 'Embed a single decorated container',
              subtitle:
                  'Adapter at the top, SliverList in the middle, '
                  'adapter footer at the bottom.',
              height: _kTallSectionHeight,
              gradient: _kGradientGraphite,
              child: _buildSectionH(),
            ),
            const _ProseBlock(
              title: 'Choosing between Sliver layouts',
              accent: _kAccent2,
              lines: <String>[
                'A short cheat sheet: SliverList for vertical streams, '
                'SliverGrid for tiled content, SliverFillViewport for '
                'paged carousels, SliverFillRemaining for empty states '
                'or hero footers, SliverToBoxAdapter for "drop one '
                'widget here", SliverPadding for cheap framing, '
                'SliverPersistentHeader for sticky custom chrome, and '
                'SliverAppBar for everything app-bar-shaped.',
                'These eight patterns cover almost every real-world '
                'scrolling layout you will encounter in a Flutter app. '
                'Compose them inside a CustomScrollView and you can '
                'reproduce nearly any custom scroll experience without '
                'reaching for a third-party package.',
              ],
            ),
            const _Footer(),
          ],
        ),
      ),
    ),
  );
}
