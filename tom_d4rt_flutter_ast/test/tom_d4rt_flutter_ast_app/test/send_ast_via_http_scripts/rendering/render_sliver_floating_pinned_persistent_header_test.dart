// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ===========================================================================
// DEEP DEMO: RenderSliverFloatingPinnedPersistentHeader
//
// RenderSliverFloatingPinnedPersistentHeader is the Flutter render object that
// backs `SliverPersistentHeader(floating: true, pinned: true)` and the
// canonical `SliverAppBar(floating: true, pinned: true)` widget. It is the
// intersection of two related but distinct behaviours:
//
//   * pinned   — the header keeps at least its `minExtent` glued to the
//                viewport leading edge, so it stays visible at all scroll
//                offsets.
//   * floating — when the user reverses scroll direction (scrolls back
//                towards the leading edge), the header eagerly grows back
//                towards `maxExtent` even before the underlying content has
//                been scrolled back into the same neighbourhood.
//
// This file is a hand-authored, visual demo of every interesting facet of
// that render object: live wired sliver app bars, multiple custom
// `SliverPersistentHeaderDelegate` subclasses, edge-case combinations,
// composition with non-pinned floating headers, and a recipe gallery.
//
// All sliver demos are nested CustomScrollViews inside bounded SizedBoxes,
// because the OUTER page is itself a SingleChildScrollView (per the harness
// contract). Each section is visually distinct (its own palette and content)
// so users can scroll the page and observe each scenario in isolation.
// ===========================================================================

// ---------------------------------------------------------------------------
// Top-level entry point — required shape:
//   MaterialApp → Scaffold → SafeArea → SingleChildScrollView → Column
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=== RenderSliverFloatingPinnedPersistentHeader Deep Demo ===');
  print('  building 10 sections with live nested CustomScrollViews');
  return MaterialApp(
    title: 'Floating+Pinned Persistent Header Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00897B)),
      useMaterial3: true,
    ),
    home: const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PageMasthead(),
              SizedBox(height: 16),
              _Section1Intro(),
              SizedBox(height: 24),
              _Section2LiveSliverAppBar(),
              SizedBox(height: 24),
              _Section3CustomDelegate(),
              SizedBox(height: 24),
              _Section4StackedHeaders(),
              SizedBox(height: 24),
              _Section5AnimatedHost(),
              SizedBox(height: 24),
              _Section6FadeOutTitle(),
              SizedBox(height: 24),
              _Section7ScalingIcon(),
              SizedBox(height: 24),
              _Section8EdgeCases(),
              SizedBox(height: 24),
              _Section9RecipeGallery(),
              SizedBox(height: 24),
              _Section10ReferenceTable(),
              SizedBox(height: 32),
              _PageFooter(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// PAGE MASTHEAD
// ===========================================================================

class _PageMasthead extends StatelessWidget {
  const _PageMasthead();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF004D40), Color(0xFF00796B), Color(0xFF26A69A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x33004D40), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.layers_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'RenderSliverFloatingPinnedPersistentHeader',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'The render object behind floating + pinned SliverAppBars',
                      style: TextStyle(
                        color: Color(0xFFE0F2F1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Scroll inside any of the bounded boxes below. Each one is a separate '
            'CustomScrollView whose first sliver is a floating+pinned header. '
            'Watch the header stay locked to the top, then re-expand the moment '
            'you reverse scroll direction.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _PageFooter extends StatelessWidget {
  const _PageFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'End of demo.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF263238),
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Each section above wired a real CustomScrollView with at least one '
            'floating+pinned SliverPersistentHeader. The render object itself, '
            'RenderSliverFloatingPinnedPersistentHeader, was instantiated by the '
            'framework whenever you saw a SliverPersistentHeader with both '
            'floating and pinned set to true.',
            style: TextStyle(fontSize: 12, color: Color(0xFF455A64), height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1 — Intro & matrix diagram (no live sliver, just exposition)
// Palette: teal
// ===========================================================================

class _Section1Intro extends StatelessWidget {
  const _Section1Intro();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionShell(
      number: 1,
      accent: const Color(0xFF00796B),
      surface: const Color(0xFFE0F2F1),
      title: 'What is RenderSliverFloatingPinnedPersistentHeader?',
      subtitle: 'The intersection of pinned and floating sliver headers.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'A SliverPersistentHeader can be configured with two booleans, '
            'pinned and floating. Each combination produces a different '
            'render object subclass:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const _MatrixDiagram(),
          const SizedBox(height: 14),
          Text(
            'When both flags are true, the framework creates a '
            'RenderSliverFloatingPinnedPersistentHeader. It keeps minExtent '
            'always visible (pinned) while also re-growing to maxExtent '
            'eagerly when the user reverses scroll direction (floating). '
            'This is the behaviour you get from a SliverAppBar with both '
            'pinned: true and floating: true — the bar never disappears, '
            'and the moment you flick upward the full FlexibleSpaceBar '
            'pops back without waiting for the original scroll position.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFB2DFDB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF00796B), width: 1),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline, color: Color(0xFF004D40), size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Use case: a search field that stays visible at all times '
                    '(pinned), but expands to a full app bar with hero imagery '
                    'as soon as you scroll back up (floating).',
                    style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF004D40)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixDiagram extends StatelessWidget {
  const _MatrixDiagram();

  @override
  Widget build(BuildContext context) {
    // NOTE: The original demo used `Table(columnWidths: …, children: …)`
    // here, but the d4rt Table proxy reports `Size(width, Infinity)`
    // instead of shrink-wrapping vertically — every descendant
    // RenderFlex/RenderPadding/RenderParagraph then cascades the same
    // infinite-size error. Render the same content as a `DecoratedBox` +
    // `Column` of `Row`s with `SizedBox(width: 110)` for the fixed column
    // and `Expanded` for the two flex columns. Same widths, same look,
    // but only uses primitives that lay out reliably under d4rt.
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF00796B)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header row: three column headings on the teal accent.
          _MatrixRow(
            background: Color(0xFF00796B),
            height: 40,
            children: <Widget>[
              _MatrixCell('', isHeader: true),
              _MatrixCell('pinned: false', isHeader: true),
              _MatrixCell('pinned: true', isHeader: true),
            ],
          ),
          _MatrixRow(
            children: <Widget>[
              _MatrixCell('floating: false', isHeader: true, dark: true),
              _MatrixCell.body(
                'RenderSliverScrollingPersistentHeader',
                'Scrolls off normally; never reappears until you scroll past it.',
                Color(0xFFE0F2F1),
              ),
              _MatrixCell.body(
                'RenderSliverPinnedPersistentHeader',
                'Always glued to the top at minExtent.',
                Color(0xFFB2DFDB),
              ),
            ],
          ),
          _MatrixRow(
            children: <Widget>[
              _MatrixCell('floating: true', isHeader: true, dark: true),
              _MatrixCell.body(
                'RenderSliverFloatingPersistentHeader',
                'Reappears on reverse scroll, but disappears completely when '
                    'scrolled forward.',
                Color(0xFFE0F2F1),
              ),
              _MatrixCell.body(
                'RenderSliverFloatingPinnedPersistentHeader',
                'Stays at minExtent always, re-expands to maxExtent eagerly on '
                    'reverse scroll.  THIS DEMO.',
                Color(0xFF80CBC4),
                emphasis: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// One logical row of the matrix diagram: 110px fixed-width column then
// two flex-1 columns, with a fixed `height` outer bound. We give the
// row an explicit `SizedBox(height:)` rather than `IntrinsicHeight`
// because d4rt's `IntrinsicHeight` + `Row(stretch)` proxy chain raises
// `'height.isFinite': is not true` from `RenderConstrainedBox`. The row
// height is sized generously (90 for header, 110 for body) so that the
// longest body text wraps inside the cell without overflowing.
class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.children,
    this.background,
    this.height = 110,
  });
  final List<Widget> children;
  final Color? background;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: const Border(bottom: BorderSide(color: Color(0xFF00796B))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(width: 110, child: children[0]),
            Expanded(child: children[1]),
            Expanded(child: children[2]),
          ],
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell(
    this.text, {
    this.isHeader = false,
    this.dark = false,
  })  : title = null,
        body = null,
        background = null,
        emphasis = false;

  const _MatrixCell.body(
    this.title,
    this.body,
    this.background, {
    this.emphasis = false,
  })  : text = '',
        isHeader = false,
        dark = false;

  final String text;
  final bool isHeader;
  final bool dark;
  final String? title;
  final String? body;
  final Color? background;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Container(
        color: background,
        padding: const EdgeInsets.all(8),
        // `mainAxisSize: MainAxisSize.min` forces this inner Column to
        // shrink-wrap to its [Text, SizedBox, Text] content. Without it,
        // the Column inherits `MainAxisSize.max` from the unbounded-height
        // `Row` ancestor and reports infinite height — cascading the
        // "object was given an infinite size" error up through the parent
        // matrix-row, the section column, and the page-level scroll view.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title!,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: emphasis ? FontWeight.w900 : FontWeight.w700,
                color: const Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              body ?? '',
              style: const TextStyle(fontSize: 11, height: 1.35, color: Color(0xFF263238)),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: dark ? const Color(0xFF004D40) : Colors.white,
          fontFamily: isHeader ? 'monospace' : null,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 — Live SliverAppBar(floating: true, pinned: true)
// Palette: amber
// ===========================================================================

class _Section2LiveSliverAppBar extends StatelessWidget {
  const _Section2LiveSliverAppBar();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 2,
      accent: const Color(0xFFFF8F00),
      surface: const Color(0xFFFFF8E1),
      title: 'Live SliverAppBar(floating: true, pinned: true)',
      subtitle: 'expandedHeight 220, FlexibleSpaceBar gradient + title.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Scroll the box below. The bar will collapse to its toolbar '
            'height (still visible — pinned), and the moment you scroll '
            'upward again the FlexibleSpaceBar will expand back fully '
            'without you having to scroll all the way up — that is the '
            'floating behaviour at work.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF6D4C00)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 220,
                    backgroundColor: const Color(0xFFFF8F00),
                    foregroundColor: Colors.white,
                    title: const Text(
                      'Honey Mountain',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'Honey Mountain Range',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      background: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFFFB300),
                              Color(0xFFFF8F00),
                              Color(0xFFE65100),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext c, int i) => _amberTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _amberTile(int i) {
    final List<String> peaks = <String>[
      'Honey Ridge',
      'Saffron Spire',
      'Beehive Plateau',
      'Goldenrod Pass',
      'Amber Col',
      'Buttercup Saddle',
      'Marigold Tor',
      'Pollen Peak',
    ];
    final String name = peaks[i % peaks.length];
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFFFF3E0) : const Color(0xFFFFE0B2),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFFFCC80), width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: const Color(0xFFFF8F00),
            radius: 16,
            child: Text(
              '${i + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6D4C00),
                  ),
                ),
                Text(
                  'elev. ${1200 + (i * 47) % 900} m · trail ${i + 3}km',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF8D6E00)),
                ),
              ],
            ),
          ),
          const Icon(Icons.terrain, color: Color(0xFFFF8F00), size: 18),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — Custom delegate: expanded card → compact pill
// Palette: indigo
// ===========================================================================

class _Section3CustomDelegate extends StatelessWidget {
  const _Section3CustomDelegate();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 3,
      accent: const Color(0xFF3949AB),
      surface: const Color(0xFFE8EAF6),
      title: 'Custom SliverPersistentHeaderDelegate (interpolating)',
      subtitle: 'Authored as _ExpandToPillDelegate — paints differently at '
          'each shrinkOffset.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'A SliverPersistentHeaderDelegate gets a shrinkOffset parameter '
            'in build(). When pinned+floating, it interpolates from 0 (fully '
            'expanded, maxExtent tall) to (maxExtent − minExtent) (fully '
            'collapsed). The delegate below morphs from an expanded info '
            'card into a compact title pill across that range.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF1A237E)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: const _ExpandToPillDelegate(),
                  ),
                  SliverList.builder(
                    itemCount: 28,
                    itemBuilder: (BuildContext c, int i) => _indigoTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indigoTile(int i) {
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFE8EAF6) : const Color(0xFFC5CAE9),
        border: const Border(bottom: BorderSide(color: Color(0xFF9FA8DA), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: <Widget>[
          Icon(
            <IconData>[
              Icons.science_outlined,
              Icons.book_outlined,
              Icons.calculate_outlined,
              Icons.architecture_outlined,
            ][i % 4],
            color: const Color(0xFF3949AB),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lecture ${i + 1}: ${_topic(i)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
                Text(
                  '45 min · prof. ${_prof(i)}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF3949AB)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _topic(int i) {
    const List<String> topics = <String>[
      'Functional analysis',
      'Topology basics',
      'Set-theoretic foundations',
      'Group homomorphisms',
      'Tensor algebra',
      'Spectral sequences',
      'Algebraic geometry',
      'Differential forms',
    ];
    return topics[i % topics.length];
  }

  String _prof(int i) {
    const List<String> names = <String>[
      'Aaltonen',
      'Bernoulli',
      'Cauchy',
      'Dedekind',
      'Euler',
    ];
    return names[i % names.length];
  }
}

class _ExpandToPillDelegate extends SliverPersistentHeaderDelegate {
  const _ExpandToPillDelegate();

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 180;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double range = maxExtent - minExtent;
    final double t = (shrinkOffset / range).clamp(0.0, 1.0);
    final double radius = 6 + 18 * t;
    final double horizontalInset = 12 + 24 * t;
    final double verticalInset = 8 + 8 * t;
    return Container(
      color: const Color(0xFFE8EAF6),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalInset, vertical: verticalInset),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.lerp(const Color(0xFF3949AB), const Color(0xFF1A237E), t) ?? const Color(0xFF3949AB),
                Color.lerp(const Color(0xFF7986CB), const Color(0xFF3949AB), t) ?? const Color(0xFF7986CB),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF1A237E).withValues(alpha: 0.18 + 0.18 * (1 - t)),
                blurRadius: 8 + 8 * (1 - t),
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 20 + 12 * (1 - t),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        t < 0.5 ? 'Department of Mathematics' : 'Mathematics',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14 + 4 * (1 - t),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (t < 0.6)
                        Opacity(
                          opacity: 1 - (t / 0.6),
                          child: const Text(
                            'Spring term · 14 modules',
                            style: TextStyle(
                              color: Color(0xFFE8EAF6),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (t < 0.4)
                  Opacity(
                    opacity: 1 - (t / 0.4),
                    child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 4 — Two stacked floating+pinned headers
// Palette: rose
// ===========================================================================

class _Section4StackedHeaders extends StatelessWidget {
  const _Section4StackedHeaders();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 4,
      accent: const Color(0xFFC2185B),
      surface: const Color(0xFFFCE4EC),
      title: 'Two stacked floating+pinned headers',
      subtitle: 'Category pill + sort bar — both pinned, both floating.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Stacking multiple SliverPersistentHeaders with pinned+floating '
            'is fully supported. Each one pins independently at minExtent. '
            'On reverse scroll, both expand together — the framework treats '
            'each header as a separate sliver, so the order is preserved.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF880E4F)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: const _CategoryHeaderDelegate(),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: const _SortBarDelegate(),
                  ),
                  SliverList.builder(
                    itemCount: 26,
                    itemBuilder: (BuildContext c, int i) => _roseTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roseTile(int i) {
    final List<String> products = <String>[
      'Velvet Camellia',
      'Wild Peony',
      'Crimson Dahlia',
      'Pink Magnolia',
      'Coral Begonia',
      'Blush Hydrangea',
      'Ruby Foxglove',
    ];
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFFCE4EC) : const Color(0xFFF8BBD0),
        border: const Border(bottom: BorderSide(color: Color(0xFFF48FB1), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFC2185B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_florist, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  products[i % products.length],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF880E4F),
                  ),
                ),
                Text(
                  '€${(12 + (i * 7) % 30).toStringAsFixed(2)} · in stock',
                  style: const TextStyle(fontSize: 11, color: Color(0xFFAD1457)),
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: Color(0xFFC2185B)),
        ],
      ),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _CategoryHeaderDelegate();

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 90;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      color: const Color(0xFFC2185B),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8 + 6 * (1 - t)),
      child: Row(
        children: <Widget>[
          const Icon(Icons.category_outlined, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (final String c in const <String>[
                    'Roses',
                    'Tulips',
                    'Orchids',
                    'Camellias',
                    'Peonies',
                    'Magnolias',
                    'Begonias',
                  ])
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        c,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                        ),
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

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _SortBarDelegate extends SliverPersistentHeaderDelegate {
  const _SortBarDelegate();

  @override
  double get minExtent => 36;

  @override
  double get maxExtent => 36;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFAD1457),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: const Row(
        children: <Widget>[
          Icon(Icons.sort, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'Sort: popular',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Icon(Icons.swap_vert, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 5 — Animated content driven by an AnimationController
// Palette: sage / green
// ===========================================================================

class _Section5AnimatedHost extends StatefulWidget {
  const _Section5AnimatedHost();

  @override
  State<_Section5AnimatedHost> createState() => _Section5AnimatedHostState();
}

class _Section5AnimatedHostState extends State<_Section5AnimatedHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 5,
      accent: const Color(0xFF558B2F),
      surface: const Color(0xFFF1F8E9),
      title: 'Animated header content (AnimationController)',
      subtitle: 'A pulsing sun in the header, independent of scroll.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'The header child can run its own animation completely '
            'orthogonally to scroll. Here a pulsing sun is driven by an '
            'AnimationController that lives in this section\'s State.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF33691E)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _PulseSunDelegate(animation: _controller),
                  ),
                  SliverList.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext c, int i) => _sageTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sageTile(int i) {
    final List<String> herbs = <String>[
      'Sage',
      'Thyme',
      'Rosemary',
      'Tarragon',
      'Mint',
      'Basil',
      'Oregano',
      'Marjoram',
    ];
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFF1F8E9) : const Color(0xFFDCEDC8),
        border: const Border(bottom: BorderSide(color: Color(0xFFAED581), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          const Icon(Icons.eco, color: Color(0xFF558B2F)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${herbs[i % herbs.length]} variety #${i + 1}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF33691E),
              ),
            ),
          ),
          Text(
            'lot ${100 + i}',
            style: const TextStyle(fontSize: 11, color: Color(0xFF558B2F)),
          ),
        ],
      ),
    );
  }
}

class _PulseSunDelegate extends SliverPersistentHeaderDelegate {
  _PulseSunDelegate({required this.animation});

  final Animation<double> animation;

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 140;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext _, Widget? child) {
        final double pulse = 0.85 + 0.15 * animation.value;
        return Container(
          color: const Color(0xFF558B2F),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Transform.scale(
                scale: pulse,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF59D),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFFFF59D).withValues(alpha: 0.6 * animation.value),
                        blurRadius: 16,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.wb_sunny, color: Color(0xFFF57F17), size: 22),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Garden Diary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sun-drenched herbs of summer',
                      style: TextStyle(
                        color: Color(0xFFDCEDC8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant _PulseSunDelegate oldDelegate) =>
      oldDelegate.animation != animation;
}

// ===========================================================================
// SECTION 6 — Fade-out title across shrinkOffset
// Palette: violet
// ===========================================================================

class _Section6FadeOutTitle extends StatelessWidget {
  const _Section6FadeOutTitle();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 6,
      accent: const Color(0xFF6A1B9A),
      surface: const Color(0xFFF3E5F5),
      title: 'Fading title across shrinkOffset',
      subtitle: 'Title opacity = 1 − (shrinkOffset / range). Manual fade.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'The shrinkOffset parameter passed into '
            'SliverPersistentHeaderDelegate.build is the canonical input '
            'for any visual change tied to scroll. Here the title is '
            'wrapped in an Opacity with value 1 − (shrinkOffset / range).',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF4A148C)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: const _FadingTitleDelegate(),
                  ),
                  SliverList.builder(
                    itemCount: 22,
                    itemBuilder: (BuildContext c, int i) => _violetTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _violetTile(int i) {
    final List<String> chapters = <String>[
      'Twilight Reverie',
      'Lavender Fields',
      'Amethyst Cliffs',
      'Plum Orchards',
      'Mauve Mornings',
    ];
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFF3E5F5) : const Color(0xFFE1BEE7),
        border: const Border(bottom: BorderSide(color: Color(0xFFCE93D8), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: <Widget>[
          Text(
            '${i + 1}',
            style: const TextStyle(
              color: Color(0xFF6A1B9A),
              fontSize: 18,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              chapters[i % chapters.length],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A148C),
              ),
            ),
          ),
          const Icon(Icons.bookmark_border, color: Color(0xFF6A1B9A)),
        ],
      ),
    );
  }
}

class _FadingTitleDelegate extends SliverPersistentHeaderDelegate {
  const _FadingTitleDelegate();

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 160;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double range = maxExtent - minExtent;
    final double t = (shrinkOffset / range).clamp(0.0, 1.0);
    final double titleOpacity = 1.0 - t;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF4A148C), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Opacity(
                opacity: titleOpacity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Anthology of Twilight',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Six chapters · violet edition',
                      style: TextStyle(
                        color: Color(0xFFE1BEE7),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.menu_book_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Opacity(
                    opacity: t,
                    child: const Text(
                      'Anthology',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
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

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 7 — Scaling icon (1.4× → 0.9×)
// Palette: lime
// ===========================================================================

class _Section7ScalingIcon extends StatelessWidget {
  const _Section7ScalingIcon();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 7,
      accent: const Color(0xFF827717),
      surface: const Color(0xFFF9FBE7),
      title: 'Scaling leading icon (1.4× → 0.9×)',
      subtitle: 'Icon scales linearly with shrinkOffset across the range.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'A small but visually striking effect: scale a leading icon '
            'between 1.4 and 0.9 across the shrink range. Implemented with '
            'Transform.scale inside the delegate build.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF33691E)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: const _ScalingIconDelegate(),
                  ),
                  SliverList.builder(
                    itemCount: 24,
                    itemBuilder: (BuildContext c, int i) => _limeTile(i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _limeTile(int i) {
    final List<String> citrus = <String>[
      'Bergamot',
      'Yuzu',
      'Kumquat',
      'Pomelo',
      'Calamansi',
      'Sudachi',
      'Citron',
      'Buddha\'s Hand',
    ];
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFF9FBE7) : const Color(0xFFF0F4C3),
        border: const Border(bottom: BorderSide(color: Color(0xFFE6EE9C), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFFAFB42B),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              citrus[i % citrus.length],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF33691E),
              ),
            ),
          ),
          Text(
            '${(2.5 + (i * 0.31) % 4).toStringAsFixed(1)} °Brix',
            style: const TextStyle(fontSize: 11, color: Color(0xFF827717)),
          ),
        ],
      ),
    );
  }
}

class _ScalingIconDelegate extends SliverPersistentHeaderDelegate {
  const _ScalingIconDelegate();

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 140;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double range = maxExtent - minExtent;
    final double t = (shrinkOffset / range).clamp(0.0, 1.0);
    final double scale = 1.4 - 0.5 * t;
    return Container(
      color: const Color(0xFFAFB42B),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 56,
            height: 56,
            child: Center(
              child: Transform.scale(
                scale: scale,
                child: const Icon(
                  Icons.eco_rounded,
                  color: Color(0xFFF9FBE7),
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Citrus Lab',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'rare cultivars · daily harvest',
                  style: TextStyle(
                    color: Color(0xFFF9FBE7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 8 — Edge cases
// Palette: coral
// ===========================================================================

class _Section8EdgeCases extends StatefulWidget {
  const _Section8EdgeCases();

  @override
  State<_Section8EdgeCases> createState() => _Section8EdgeCasesState();
}

class _Section8EdgeCasesState extends State<_Section8EdgeCases> {
  int _scenario = 0;

  static const List<String> _labels = <String>[
    'minExtent == maxExtent (just pinned, no float room)',
    'Very tall maxExtent (160) with small minExtent (40)',
    'Floating+pinned next to a non-pinned floating header',
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 8,
      accent: const Color(0xFFE64A19),
      surface: const Color(0xFFFBE9E7),
      title: 'Edge cases',
      subtitle: 'Toggle through three corner-case configurations.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Below is the same kind of CustomScrollView reused with three '
            'different floating+pinned configurations. Tap a chip to switch.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFFBF360C)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: <Widget>[
              for (int i = 0; i < _labels.length; i++)
                ChoiceChip(
                  label: Text(
                    'Case ${i + 1}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  selected: _scenario == i,
                  selectedColor: const Color(0xFFE64A19),
                  labelStyle: TextStyle(
                    color: _scenario == i ? Colors.white : const Color(0xFFBF360C),
                    fontWeight: FontWeight.w700,
                  ),
                  onSelected: (bool _) => setState(() => _scenario = i),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCCBC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _labels[_scenario],
              style: const TextStyle(fontSize: 12, color: Color(0xFFBF360C)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildScenario(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenario() {
    switch (_scenario) {
      case 0:
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: const _CompactNoFloatRoomDelegate(),
            ),
            SliverList.builder(
              itemCount: 22,
              itemBuilder: (BuildContext c, int i) => _coralTile(i, 'Equal extents'),
            ),
          ],
        );
      case 1:
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: const _TallMaxExtentDelegate(),
            ),
            SliverList.builder(
              itemCount: 22,
              itemBuilder: (BuildContext c, int i) => _coralTile(i, 'Tall maxExtent'),
            ),
          ],
        );
      case 2:
      default:
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: const _ContrastFloatingPinnedDelegate(),
            ),
            SliverPersistentHeader(
              pinned: false,
              floating: true,
              delegate: const _ContrastFloatingOnlyDelegate(),
            ),
            SliverList.builder(
              itemCount: 22,
              itemBuilder: (BuildContext c, int i) => _coralTile(i, 'Contrast'),
            ),
          ],
        );
    }
  }

  Widget _coralTile(int i, String tag) {
    return Container(
      decoration: BoxDecoration(
        color: i.isEven ? const Color(0xFFFBE9E7) : const Color(0xFFFFCCBC),
        border: const Border(bottom: BorderSide(color: Color(0xFFFFAB91), width: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          const Icon(Icons.bug_report_outlined, color: Color(0xFFE64A19)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$tag · entry ${i + 1}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFBF360C),
                  ),
                ),
                Text(
                  'note: scenario specific behaviour',
                  style: const TextStyle(fontSize: 11, color: Color(0xFFD84315)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactNoFloatRoomDelegate extends SliverPersistentHeaderDelegate {
  const _CompactNoFloatRoomDelegate();

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56; // No floating room — same as plain pinned.

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFE64A19),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const Row(
        children: <Widget>[
          Icon(Icons.lock_outline, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'No float headroom — behaves like pure pinned',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _TallMaxExtentDelegate extends SliverPersistentHeaderDelegate {
  const _TallMaxExtentDelegate();

  @override
  double get minExtent => 40;

  @override
  double get maxExtent => 220;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFBF360C), Color(0xFFE64A19), Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 1 - t,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.public, color: Colors.white, size: 56),
                  SizedBox(height: 6),
                  Text(
                    'Very tall header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'maxExtent 220, minExtent 40',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 8,
              child: Opacity(
                opacity: t,
                child: const Text(
                  'collapsed: very tall header',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _ContrastFloatingPinnedDelegate extends SliverPersistentHeaderDelegate {
  const _ContrastFloatingPinnedDelegate();

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 110;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFE64A19),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: const Row(
        children: <Widget>[
          Icon(Icons.push_pin, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'pinned + floating',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'always visible · re-expands on reverse scroll',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _ContrastFloatingOnlyDelegate extends SliverPersistentHeaderDelegate {
  const _ContrastFloatingOnlyDelegate();

  @override
  double get minExtent => 36;

  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFFF8A65),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: const Row(
        children: <Widget>[
          Icon(Icons.flight_takeoff, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'floating only — disappears completely when scrolled forward',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 9 — Recipe gallery: three concrete UI use cases
// Palette: slate + blue
// ===========================================================================

class _Section9RecipeGallery extends StatelessWidget {
  const _Section9RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 9,
      accent: const Color(0xFF455A64),
      surface: const Color(0xFFECEFF1),
      title: 'Recipe gallery — practical use cases',
      subtitle: 'Three real-world UI patterns built on floating+pinned.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          Text(
            'Concrete patterns where floating+pinned is the right choice. '
            'Each card below is its own bounded CustomScrollView with a '
            'narrative explaining why this configuration matters.',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFF263238)),
          ),
          SizedBox(height: 10),
          _RecipeCard(
            title: 'A: Reappearing search bar',
            blurb: 'Search is critical so we keep at least the input visible '
                '(pinned). When scrolling up, the full search bar with hints '
                'and filters re-expands eagerly (floating).',
            accent: Color(0xFF1565C0),
            light: Color(0xFFE3F2FD),
            child: _RecipeSearchBar(),
          ),
          SizedBox(height: 12),
          _RecipeCard(
            title: 'B: Sticky tab bar with hero',
            blurb: 'A SliverAppBar(floating: true, pinned: true) holds tabs '
                'always-visible at the bottom of its toolbar height; the '
                'hero gradient + title appear on reverse scroll.',
            accent: Color(0xFF00838F),
            light: Color(0xFFE0F7FA),
            child: _RecipeTabBar(),
          ),
          SizedBox(height: 12),
          _RecipeCard(
            title: 'C: Sticky filter chip',
            blurb: 'A small chip-row that never disappears keeps the user '
                'oriented; a richer header with breadcrumbs re-expands when '
                'they scroll back, helping rebuild context.',
            accent: Color(0xFF6D4C41),
            light: Color(0xFFEFEBE9),
            child: _RecipeFilterChips(),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.blurb,
    required this.accent,
    required this.light,
    required this.child,
  });

  final String title;
  final String blurb;
  final Color accent;
  final Color light;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            blurb,
            style: const TextStyle(fontSize: 12, height: 1.45, color: Color(0xFF263238)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeSearchBar extends StatelessWidget {
  const _RecipeSearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: const _SearchBarDelegate(),
        ),
        SliverList.builder(
          itemCount: 18,
          itemBuilder: (BuildContext c, int i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              border: Border(bottom: BorderSide(color: Color(0xFFBBDEFB), width: 0.4)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.article_outlined, color: Color(0xFF1565C0)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Result ${i + 1}: relevant document',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  const _SearchBarDelegate();

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 130;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      color: const Color(0xFF1565C0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.search, color: Color(0xFF1565C0)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search articles…',
                    style: TextStyle(color: Color(0xFF90A4AE), fontSize: 14),
                  ),
                ),
                Icon(Icons.tune, color: Color(0xFF1565C0)),
              ],
            ),
          ),
          if (t < 0.95)
            Opacity(
              opacity: 1 - t,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 6,
                  children: <Widget>[
                    for (final String hint in const <String>[
                      'recent',
                      'starred',
                      'today',
                      'mine',
                    ])
                      Chip(
                        label: Text(
                          hint,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        backgroundColor: const Color(0xFF1976D2),
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _RecipeTabBar extends StatelessWidget {
  const _RecipeTabBar();

  @override
  Widget build(BuildContext context) {
    // Wrap in `DefaultTabController` so the `TabBar` in the `SliverAppBar.bottom`
    // can find a controller. Without it, `TabBar.build` raises
    // "No TabController for TabBar" and the bottom slot fails to lay out,
    // cascading through every descendant Padding/Flex/Paragraph as
    // "given an infinite size".
    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 140,
          backgroundColor: Color(0xFF00838F),
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Marine Atlas',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF006064), Color(0xFF00ACC1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFFB2EBF2),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'Coral'),
              Tab(text: 'Pelagic'),
              Tab(text: 'Benthic'),
              Tab(text: 'Estuarine'),
            ],
          ),
        ),
        SliverList.builder(
          itemCount: 16,
          itemBuilder: (BuildContext c, int i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFE0F7FA),
              border: Border(bottom: BorderSide(color: Color(0xFFB2EBF2), width: 0.4)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.water, color: Color(0xFF00838F)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Species record ${i + 1}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006064),
                    ),
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
}

class _RecipeFilterChips extends StatelessWidget {
  const _RecipeFilterChips();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: const _BreadcrumbHeaderDelegate(),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: const _FilterChipRowDelegate(),
          ),
          SliverList.builder(
            itemCount: 16,
            itemBuilder: (BuildContext c, int i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFEFEBE9),
                border: Border(bottom: BorderSide(color: Color(0xFFD7CCC8), width: 0.4)),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.coffee_outlined, color: Color(0xFF6D4C41)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Roast batch ${i + 1}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4E342E),
                      ),
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
}

class _BreadcrumbHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _BreadcrumbHeaderDelegate();

  @override
  double get minExtent => 38;

  @override
  double get maxExtent => 90;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      color: const Color(0xFF6D4C41),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6 + 6 * (1 - t)),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          const Icon(Icons.home_outlined, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          const Text('Catalog', style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: Color(0xFFD7CCC8), size: 16),
          const SizedBox(width: 6),
          const Text('Coffee', style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: Color(0xFFD7CCC8), size: 16),
          const SizedBox(width: 6),
          const Text(
            'Single Origin',
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          if (t < 0.6)
            Opacity(
              opacity: 1 - (t / 0.6),
              child: const Text(
                '46 results',
                style: TextStyle(color: Color(0xFFD7CCC8), fontSize: 11),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _FilterChipRowDelegate extends SliverPersistentHeaderDelegate {
  const _FilterChipRowDelegate();

  @override
  double get minExtent => 44;

  @override
  double get maxExtent => 44;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFEFEBE9),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final String f in const <String>[
            'Single origin',
            'Light roast',
            'Decaf',
            'Espresso',
            'Filter',
            'Organic',
          ])
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Chip(
                label: Text(
                  f,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF4E342E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: const Color(0xFFD7CCC8),
                side: const BorderSide(color: Color(0xFFA1887F)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ===========================================================================
// SECTION 10 — Reference table summarizing all four combinations
// Palette: orange / brown
// ===========================================================================

class _Section10ReferenceTable extends StatelessWidget {
  const _Section10ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: 10,
      accent: const Color(0xFFEF6C00),
      surface: const Color(0xFFFFF3E0),
      title: 'Reference table — render objects per (floating × pinned)',
      subtitle: 'Definitive map from delegate flags to render-object class.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'When you write SliverPersistentHeader(floating: f, pinned: p), '
            'Flutter selects exactly one of these four render-object subclasses:',
            style: TextStyle(fontSize: 12.5, height: 1.45, color: Color(0xFFE65100)),
          ),
          const SizedBox(height: 10),
          // NOTE: Original demo used `Table(columnWidths: …, children: …)`
          // here, but the d4rt Table proxy reports `Size(width, Infinity)`
          // instead of shrink-wrapping vertically, which raises a 10-frame
          // cascade of "object given an infinite size" errors. Render the
          // same content as a `Column` of `Row`s with `SizedBox`-fixed and
          // `Expanded`-flex columns — same widths, same look, but uses only
          // primitives that lay out reliably under d4rt.
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEF6C00)),
            ),
            child: const Column(
              children: <Widget>[
                _RefRow(
                  background: Color(0xFFEF6C00),
                  height: 36,
                  cells: <_RefCellSpec>[
                    _RefCellSpec(text: 'floating', isHeader: true),
                    _RefCellSpec(text: 'pinned', isHeader: true),
                    _RefCellSpec(text: 'render object', isHeader: true),
                    _RefCellSpec(text: 'behaviour', isHeader: true),
                  ],
                ),
                _RefRow(
                  cells: <_RefCellSpec>[
                    _RefCellSpec(text: 'false'),
                    _RefCellSpec(text: 'false'),
                    _RefCellSpec(text: 'RenderSliverScrollingPersistentHeader'),
                    _RefCellSpec(
                      text: 'Scrolls off normally; reappears only when scrolled back into view.',
                    ),
                  ],
                ),
                _RefRow(
                  background: Color(0xFFFFF3E0),
                  cells: <_RefCellSpec>[
                    _RefCellSpec(text: 'true'),
                    _RefCellSpec(text: 'false'),
                    _RefCellSpec(text: 'RenderSliverFloatingPersistentHeader'),
                    _RefCellSpec(
                      text: 'Reappears the moment you reverse scroll, even if scrolled far past.',
                    ),
                  ],
                ),
                _RefRow(
                  cells: <_RefCellSpec>[
                    _RefCellSpec(text: 'false'),
                    _RefCellSpec(text: 'true'),
                    _RefCellSpec(text: 'RenderSliverPinnedPersistentHeader'),
                    _RefCellSpec(
                      text: 'Always glued to the leading edge at minExtent, never expands floating.',
                    ),
                  ],
                ),
                _RefRow(
                  background: Color(0xFFFFE0B2),
                  cells: <_RefCellSpec>[
                    _RefCellSpec(text: 'true'),
                    _RefCellSpec(text: 'true'),
                    _RefCellSpec(text: 'RenderSliverFloatingPinnedPersistentHeader'),
                    _RefCellSpec(
                      text: 'Both behaviours combined — visible at minExtent always, expands eagerly on reverse scroll.',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEF6C00)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, color: Color(0xFFE65100)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You almost never instantiate these render objects directly. '
                    'You use SliverPersistentHeader or SliverAppBar, and the '
                    'right render object gets created based on the flags.',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE65100), height: 1.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Cell content spec for `_RefRow`. `isHeader` flips the styling between
// header (white bold on accent) and body (mono on cream).
class _RefCellSpec {
  const _RefCellSpec({required this.text, this.isHeader = false});
  final String text;
  final bool isHeader;
}

// Single row of the `(floating × pinned) → render object` reference table.
// Lays out four cells with the same column widths as the original `Table`
// (80px, 80px, flex-1, flex-1) using `SizedBox` + `Expanded` inside a `Row`
// inside an explicit `SizedBox(height:)`.
//
// We use a fixed outer height instead of `IntrinsicHeight` because d4rt's
// `IntrinsicHeight` + `Row(stretch)` proxy chain raises
// `'height.isFinite': is not true` from `RenderConstrainedBox`. The row
// height is sized generously so the longest behaviour string wraps inside
// the cell.
class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.cells,
    this.background,
    this.height = 70,
  });
  final List<_RefCellSpec> cells;
  final Color? background;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFEF6C00)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(width: 80, child: _RefCell(spec: cells[0])),
            SizedBox(width: 80, child: _RefCell(spec: cells[1])),
            Expanded(child: _RefCell(spec: cells[2])),
            Expanded(child: _RefCell(spec: cells[3])),
          ],
        ),
      ),
    );
  }
}

class _RefCell extends StatelessWidget {
  const _RefCell({required this.spec});
  final _RefCellSpec spec;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        spec.text,
        style: spec.isHeader
            ? const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              )
            : const TextStyle(
                color: Color(0xFF4E342E),
                fontSize: 11,
                fontFamily: 'monospace',
                height: 1.4,
              ),
      ),
    );
  }
}

// ===========================================================================
// Shared section shell (used by all 10 sections)
// ===========================================================================

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.number,
    required this.accent,
    required this.surface,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int number;
  final Color accent;
  final Color surface;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: accent.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
