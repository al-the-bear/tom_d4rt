// D4rt deep demo: CustomScrollView and the sliver family
// Visual gallery of CustomScrollView configurations, sliver children,
// scroll directions, physics, and edge cases. Interpreted by D4rt.
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ============================================================================
// Color palette - shared throughout the demo for visual coherence
// ============================================================================
const Color kInk = Color(0xFF1B1F3A);
const Color kInkSoft = Color(0xFF3A4063);
const Color kPaper = Color(0xFFF6F7FB);
const Color kHair = Color(0xFFE2E5F1);
const Color kAccent = Color(0xFF5B7CFA);
const Color kAccentDeep = Color(0xFF2D4DD8);
const Color kPink = Color(0xFFE85A9B);
const Color kAmber = Color(0xFFFFB547);
const Color kMint = Color(0xFF35C9A0);
const Color kCoral = Color(0xFFFF7A6B);
const Color kViolet = Color(0xFF8C5BF2);
const Color kCyan = Color(0xFF36C5E0);

// ----------------------------------------------------------------------------
// Section header - large title, eyebrow tag, narrative blurb.
// ----------------------------------------------------------------------------
Widget buildSectionHeader({
  required String tag,
  required String title,
  required String blurb,
  required Color accent,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: accent.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, size: 14.0, color: accent),
                  const SizedBox(width: 6.0),
                  Text(
                    tag,
                    style: TextStyle(
                      color: accent,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                height: 1.0,
                color: kHair,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          title,
          style: const TextStyle(
            color: kInk,
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          blurb,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 14.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Demo frame - bordered shadowed container that hosts a CustomScrollView.
// ----------------------------------------------------------------------------
Widget buildDemoFrame({
  required String caption,
  required Color accent,
  required double height,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: kHair, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.06),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: accent.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    caption,
                    style: TextStyle(
                      color: accent.withValues(alpha: 0.95),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.swap_vert_rounded,
                  size: 16.0,
                  color: accent.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
              ),
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Inline label chip used for property annotations on each demo frame.
// ----------------------------------------------------------------------------
Widget buildPropChip(String label, Color accent) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0, top: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.30),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: accent.withValues(alpha: 0.95),
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget buildPropChipRow(List<String> labels, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Wrap(
      children: List<Widget>.generate(
        labels.length,
        (int index) => buildPropChip(labels[index], accent),
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// A single decorative list tile used as SliverList child.
// ----------------------------------------------------------------------------
Widget buildListTile(int index, Color accent) {
  final List<IconData> icons = <IconData>[
    Icons.dashboard_rounded,
    Icons.trending_up_rounded,
    Icons.layers_rounded,
    Icons.public_rounded,
    Icons.auto_awesome_rounded,
    Icons.flash_on_rounded,
    Icons.science_rounded,
    Icons.water_drop_rounded,
    Icons.spa_rounded,
    Icons.diamond_rounded,
  ];
  final IconData icon = icons[index % icons.length];
  final double t = (index % 10) / 10.0;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.18),
        width: 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.06),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                accent.withValues(alpha: 0.85),
                accent.withValues(alpha: 0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: Colors.white, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sliver row #${index.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                'Composed by SliverList delegate (lazy).',
                style: TextStyle(
                  color: kInkSoft.withValues(alpha: 0.85),
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.10 + t * 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '${(t * 100.0).round()}%',
            style: TextStyle(
              color: accent,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// A decorative grid tile used as SliverGrid child.
// ----------------------------------------------------------------------------
Widget buildGridTile(int index, Color accent) {
  final List<Color> palette = <Color>[
    kAccent,
    kPink,
    kAmber,
    kMint,
    kCoral,
    kViolet,
    kCyan,
    kAccentDeep,
  ];
  final Color base = palette[index % palette.length];
  return Container(
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          base.withValues(alpha: 0.85),
          base.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: base.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          right: 8.0,
          top: 8.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              '#${index.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.grid_view_rounded,
                color: Colors.white.withValues(alpha: 0.95),
                size: 26.0,
              ),
              const SizedBox(height: 6.0),
              Text(
                'cell',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 8.0,
          bottom: 8.0,
          child: Container(
            width: 18.0,
            height: 2.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(1.0),
            ),
          ),
        ),
        // Use the accent param so the tile reads it for outline contrast.
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: accent.withValues(alpha: 0.0),
                  width: 0.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Fixed-extent tile used inside SliverFixedExtentList.
// ----------------------------------------------------------------------------
Widget buildFixedExtentTile(int index) {
  final List<Color> palette = <Color>[
    kAccent,
    kMint,
    kCoral,
    kViolet,
    kAmber,
    kPink,
  ];
  final Color base = palette[index % palette.length];
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: base.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: base.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Fixed-extent slot $index',
                style: const TextStyle(
                  color: kInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'extent = 64 px - layout skips intrinsic measurement',
                style: TextStyle(
                  color: kInkSoft.withValues(alpha: 0.85),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.straighten_rounded, color: base, size: 22.0),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Horizontal scroll card.
// ----------------------------------------------------------------------------
Widget buildHorizontalCard(int index) {
  final List<Color> palette = <Color>[
    kAccent,
    kPink,
    kAmber,
    kMint,
    kCoral,
    kViolet,
    kCyan,
  ];
  final Color base = palette[index % palette.length];
  return Container(
    width: 160.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          base.withValues(alpha: 0.95),
          base.withValues(alpha: 0.60),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: base.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.swipe_rounded,
                color: Colors.white,
                size: 18.0,
              ),
            ),
            Text(
              '#${index.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Card $index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'horizontal sliver',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Banner used inside SliverPersistentHeader pinned region.
// ----------------------------------------------------------------------------
Widget buildPinnedBanner(String title, IconData icon, Color base) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          base.withValues(alpha: 0.95),
          base.withValues(alpha: 0.65),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: base.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        const SizedBox(width: 14.0),
        Icon(icon, color: Colors.white, size: 20.0),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 14.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'PINNED',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Custom SliverPersistentHeaderDelegate for the persistent-header demo.
// ----------------------------------------------------------------------------
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PinnedHeaderDelegate({
    required this.title,
    required this.icon,
    required this.color,
    required this.height,
  });

  final String title;
  final IconData icon;
  final Color color;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: height,
      child: buildPinnedBanner(title, icon, color),
    );
  }

  @override
  bool shouldRebuild(_PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.icon != icon ||
        oldDelegate.color != color ||
        oldDelegate.height != height;
  }
}

// ============================================================================
// SECTION 1 - Basic CustomScrollView with SliverToBoxAdapter
// ============================================================================
Widget buildSection1Basic() {
  final List<Widget> bands = List<Widget>.generate(6, (int index) {
    final List<Color> palette = <Color>[
      kAccent,
      kMint,
      kCoral,
      kViolet,
      kAmber,
      kPink,
    ];
    final Color c = palette[index % palette.length];
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              c.withValues(alpha: 0.16),
              c.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: c.withValues(alpha: 0.35),
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SliverToBoxAdapter #${index + 1}',
                    style: const TextStyle(
                      color: kInk,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Wraps an arbitrary box widget in the sliver protocol.',
                    style: TextStyle(
                      color: kInkSoft.withValues(alpha: 0.85),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });

  return buildDemoFrame(
    caption: 'Plain CustomScrollView + SliverToBoxAdapter children',
    accent: kAccent,
    height: 280.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: bands,
      ),
    ),
  );
}

// ============================================================================
// SECTION 2 - SliverAppBar (pinned, with FlexibleSpaceBar + stretch)
// ============================================================================
Widget buildSection2PinnedAppBar() {
  final List<Widget> followingSlivers = <Widget>[
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => buildListTile(index, kAccentDeep),
        childCount: 12,
      ),
    ),
  ];

  return buildDemoFrame(
    caption: 'SliverAppBar pinned + FlexibleSpaceBar with stretch',
    accent: kAccentDeep,
    height: 360.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 160.0,
            backgroundColor: kAccentDeep,
            foregroundColor: Colors.white,
            elevation: 0.0,
            title: const Text(
              'Atlas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.search_rounded, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.more_horiz_rounded, color: Colors.white),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      kAccentDeep,
                      kViolet.withValues(alpha: 0.85),
                      kPink.withValues(alpha: 0.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 24.0,
                      bottom: 56.0,
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40.0,
                      top: 30.0,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 90.0,
                      bottom: 80.0,
                      child: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: const Padding(
                padding: EdgeInsets.only(bottom: 14.0),
                child: Text(
                  'Pinned + Stretch Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          ...followingSlivers,
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 3 - SliverGrid gallery (count + maxCrossAxisExtent)
// ============================================================================
Widget buildSection3GridGallery() {
  final List<Widget> tilesA = List<Widget>.generate(
    8,
    (int index) => buildGridTile(index, kPink),
  );
  final List<Widget> tilesB = List<Widget>.generate(
    6,
    (int index) => buildGridTile(index + 8, kViolet),
  );

  return buildDemoFrame(
    caption: 'SliverGrid.count (3 cols) + SliverGrid extent (160px)',
    accent: kPink,
    height: 460.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'SliverGrid.count - fixed 3 column layout',
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0,
              children: tilesA,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 4.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'SliverGrid extent - responsive max width per tile',
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate(tilesB),
              gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160.0,
                childAspectRatio: 1.1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 4 - Mixed slivers (adapter + list + grid + fixed extent + padding)
// ============================================================================
Widget buildSection4MixedSlivers() {
  final List<Widget> gridTiles = List<Widget>.generate(
    6,
    (int index) => buildGridTile(index, kMint),
  );

  return buildDemoFrame(
    caption: 'Mixed sliver families in one viewport',
    accent: kMint,
    height: 540.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    kMint.withValues(alpha: 0.85),
                    kCyan.withValues(alpha: 0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kMint.withValues(alpha: 0.25),
                    blurRadius: 12.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(
                      Icons.dashboard_customize_rounded,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Composition Hero',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Adapter sliver at the top.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    buildListTile(index, kMint),
                childCount: 4,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
              child: Text(
                'Grid pocket',
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              children: gridTiles,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 12.0),
            sliver: SliverFixedExtentList(
              itemExtent: 64.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    buildFixedExtentTile(index),
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 5 - Horizontal scrollDirection
// ============================================================================
Widget buildSection5Horizontal() {
  final List<Widget> cards = List<Widget>.generate(
    12,
    (int index) => buildHorizontalCard(index),
  );

  return buildDemoFrame(
    caption: 'scrollDirection: Axis.horizontal',
    accent: kCoral,
    height: 200.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(cards),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 6 - Reverse + clipBehavior
// ============================================================================
Widget buildSection6Reverse() {
  final List<Widget> tiles = List<Widget>.generate(
    8,
    (int index) => buildFixedExtentTile(index),
  );

  return buildDemoFrame(
    caption: 'reverse: true + SliverFixedExtentList',
    accent: kViolet,
    height: 320.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        reverse: true,
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: 64.0,
            delegate: SliverChildListDelegate(tiles),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 7 - SliverPersistentHeader (custom pinned banner)
// ============================================================================
Widget buildSection7PersistentHeader() {
  return buildDemoFrame(
    caption: 'SliverPersistentHeader (custom delegate, pinned)',
    accent: kCyan,
    height: 380.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(
              title: 'Alpha section',
              icon: Icons.bookmark_rounded,
              color: kCyan,
              height: 44.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index, kCyan),
              childCount: 4,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(
              title: 'Beta section',
              icon: Icons.bookmarks_rounded,
              color: kViolet,
              height: 44.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index + 100, kViolet),
              childCount: 4,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(
              title: 'Gamma section',
              icon: Icons.bookmark_add_rounded,
              color: kPink,
              height: 44.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index + 200, kPink),
              childCount: 4,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 8 - SliverFillRemaining (hasScrollBody false)
// ============================================================================
Widget buildSection8FillRemaining() {
  return buildDemoFrame(
    caption: 'SliverFillRemaining hasScrollBody: false',
    accent: kAmber,
    height: 360.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: kAmber.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: kAmber.withValues(alpha: 0.45),
                  width: 1.0,
                ),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.info_outline_rounded, color: kAmber),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Top sliver + a fill-remaining footer below.',
                      style: TextStyle(
                        color: kInk,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    kAmber.withValues(alpha: 0.30),
                    kCoral.withValues(alpha: 0.20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: kAmber.withValues(alpha: 0.45),
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: kAmber.withValues(alpha: 0.30),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.aspect_ratio_rounded,
                        color: kAmber,
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Fills remaining viewport space',
                      style: TextStyle(
                        color: kInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'expands so non-scrollable content fits the column.',
                      style: TextStyle(
                        color: kInkSoft.withValues(alpha: 0.85),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 9 - SliverFillViewport
// ============================================================================
Widget buildSection9FillViewport() {
  final List<Widget> pages = List<Widget>.generate(4, (int index) {
    final List<Color> palette = <Color>[
      kAccent,
      kMint,
      kCoral,
      kViolet,
    ];
    final Color base = palette[index % palette.length];
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            base.withValues(alpha: 0.95),
            base.withValues(alpha: 0.60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: base.withValues(alpha: 0.30),
            blurRadius: 12.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fullscreen_rounded,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(height: 14.0),
            Text(
              'Page ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'viewportFraction = 0.85',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  });

  return buildDemoFrame(
    caption: 'SliverFillViewport (viewportFraction: 0.85)',
    accent: kAccent,
    height: 280.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        slivers: <Widget>[
          SliverFillViewport(
            viewportFraction: 0.85,
            delegate: SliverChildListDelegate(pages),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 10 - Floating + snap SliverAppBar
// ============================================================================
Widget buildSection10FloatingSnap() {
  return buildDemoFrame(
    caption: 'SliverAppBar floating + snap (try scrolling up then down)',
    accent: kPink,
    height: 340.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: false,
            backgroundColor: kPink,
            foregroundColor: Colors.white,
            elevation: 4.0,
            expandedHeight: 100.0,
            title: const Text(
              'Floating + Snap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      kPink,
                      kCoral.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index, kPink),
              childCount: 10,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 11 - SliverPadding showcase
// ============================================================================
Widget buildSection11SliverPadding() {
  return buildDemoFrame(
    caption: 'SliverPadding wrapping nested slivers',
    accent: kAccentDeep,
    height: 360.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kAccentDeep.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: kAccentDeep.withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'SliverPadding applies padding in sliver coordinate space.',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 4.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    buildListTile(index, kAccentDeep),
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 12 - Controller + physics + keyboardDismissBehavior
// ============================================================================
Widget buildSection12Controller(ScrollController controller) {
  return buildDemoFrame(
    caption: 'External controller, physics, keyboardDismissBehavior',
    accent: kMint,
    height: 340.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        dragStartBehavior: DragStartBehavior.start,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    kMint.withValues(alpha: 0.85),
                    kCyan.withValues(alpha: 0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.tune_rounded, color: Colors.white),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'controller + physics + DragStartBehavior.start + '
                      'keyboardDismissBehavior.onDrag',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index, kMint),
              childCount: 10,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 13 - anchor + center
// ============================================================================
Widget buildSection13AnchorCenter() {
  const Key centerKey = ValueKey<String>('center-sliver');

  final List<Widget> upper = List<Widget>.generate(
    5,
    (int index) => SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kViolet.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: kViolet.withValues(alpha: 0.30),
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: kViolet,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '-${5 - index}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'Before-center sliver',
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  final List<Widget> lower = List<Widget>.generate(
    5,
    (int index) => SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kAccent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: kAccent.withValues(alpha: 0.30),
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: kAccent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '+${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'After-center sliver',
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  final Widget centerSliver = SliverToBoxAdapter(
    key: centerKey,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[kPink, kViolet],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kPink.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.center_focus_strong_rounded, color: Colors.white),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'CENTER sliver - anchor: 0.5',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  return buildDemoFrame(
    caption: 'center + anchor:0.5 - bi-directional sliver layout',
    accent: kPink,
    height: 360.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        center: centerKey,
        anchor: 0.5,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          ...upper,
          centerSliver,
          ...lower,
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 14 - Edge case: cacheExtent + shrinkWrap
// ============================================================================
Widget buildSection14CacheExtent() {
  return buildDemoFrame(
    caption: 'cacheExtent: 200, shrinkWrap-style behaviour via container',
    accent: kAccent,
    height: 280.0,
    child: Container(
      color: kPaper,
      child: CustomScrollView(
        cacheExtent: 200.0,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  buildListTile(index, kAccent),
              childCount: 20,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// Spec card - quick reference for parameter explanations
// ============================================================================
Widget buildSpecCard({
  required String title,
  required String description,
  required IconData icon,
  required Color accent,
}) {
  return Container(
    width: 220.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kHair, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.05),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: accent, size: 20.0),
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: const TextStyle(
            color: kInk,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            color: kInkSoft.withValues(alpha: 0.9),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildSpecGrid() {
  final List<Widget> specs = <Widget>[
    buildSpecCard(
      title: 'slivers',
      description:
          'Required list of sliver widgets composing the scroll viewport.',
      icon: Icons.view_agenda_rounded,
      accent: kAccent,
    ),
    buildSpecCard(
      title: 'scrollDirection',
      description:
          'Axis.vertical (default) or Axis.horizontal for sideways scroll.',
      icon: Icons.swap_horiz_rounded,
      accent: kPink,
    ),
    buildSpecCard(
      title: 'reverse',
      description:
          'Inverts content order; useful for chat or upward-growing logs.',
      icon: Icons.swap_vert_rounded,
      accent: kCoral,
    ),
    buildSpecCard(
      title: 'controller',
      description:
          'External ScrollController for programmatic scroll position.',
      icon: Icons.tune_rounded,
      accent: kMint,
    ),
    buildSpecCard(
      title: 'physics',
      description:
          'BouncingScrollPhysics, ClampingScrollPhysics, PageScrollPhysics...',
      icon: Icons.science_rounded,
      accent: kViolet,
    ),
    buildSpecCard(
      title: 'anchor',
      description:
          'Relative position [0..1] of zero scroll offset inside viewport.',
      icon: Icons.center_focus_weak_rounded,
      accent: kAmber,
    ),
    buildSpecCard(
      title: 'center',
      description:
          'Key marking the sliver whose start aligns to anchor offset.',
      icon: Icons.gps_fixed_rounded,
      accent: kCyan,
    ),
    buildSpecCard(
      title: 'cacheExtent',
      description:
          'Pixels of off-screen content to keep alive for smooth scrolling.',
      icon: Icons.memory_rounded,
      accent: kAccentDeep,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: specs,
    ),
  );
}

// ============================================================================
// Family map - visualises which slivers compose into a CustomScrollView
// ============================================================================
Widget buildFamilyMap() {
  final List<Map<String, dynamic>> entries = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.crop_landscape_rounded,
      'name': 'SliverAppBar',
      'note': 'pinned / floating / snap / stretch',
      'color': kAccent,
    },
    <String, dynamic>{
      'icon': Icons.view_list_rounded,
      'name': 'SliverList',
      'note': 'variable-extent children via delegate',
      'color': kMint,
    },
    <String, dynamic>{
      'icon': Icons.grid_view_rounded,
      'name': 'SliverGrid',
      'note': 'fixed grid or maxCrossAxisExtent',
      'color': kPink,
    },
    <String, dynamic>{
      'icon': Icons.straighten_rounded,
      'name': 'SliverFixedExtentList',
      'note': 'identical extents, fast layout',
      'color': kAmber,
    },
    <String, dynamic>{
      'icon': Icons.bookmark_rounded,
      'name': 'SliverPersistentHeader',
      'note': 'custom pinnable/floating delegate',
      'color': kCyan,
    },
    <String, dynamic>{
      'icon': Icons.format_indent_increase_rounded,
      'name': 'SliverPadding',
      'note': 'pads inner sliver geometry',
      'color': kViolet,
    },
    <String, dynamic>{
      'icon': Icons.crop_3_2_rounded,
      'name': 'SliverToBoxAdapter',
      'note': 'box -> sliver wrapper',
      'color': kCoral,
    },
    <String, dynamic>{
      'icon': Icons.aspect_ratio_rounded,
      'name': 'SliverFillRemaining',
      'note': 'consumes leftover viewport',
      'color': kAccentDeep,
    },
    <String, dynamic>{
      'icon': Icons.fullscreen_rounded,
      'name': 'SliverFillViewport',
      'note': 'page-style fill, viewportFraction',
      'color': kAccent,
    },
  ];

  final List<Widget> chips = List<Widget>.generate(
    entries.length,
    (int index) {
      final Map<String, dynamic> e = entries[index];
      final Color c = e['color'] as Color;
      return Container(
        width: 240.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: c.withValues(alpha: 0.30),
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(e['icon'] as IconData, color: c, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    e['name'] as String,
                    style: TextStyle(
                      color: c,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    e['note'] as String,
                    style: TextStyle(
                      color: kInkSoft.withValues(alpha: 0.85),
                      fontSize: 10.5,
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

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: chips,
    ),
  );
}

// ============================================================================
// Bottom recap card
// ============================================================================
Widget buildRecapCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 40.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInk, kInkSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInk.withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kAccent.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.summarize_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'CustomScrollView recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          'CustomScrollView is the lowest-level composable scroll widget in '
          'Flutter. It accepts a flat list of sliver widgets and lets you '
          'assemble headers, lists, grids, fills and padding into a single '
          'viewport. Higher level views like ListView and GridView are '
          'shorthand for common CustomScrollView configurations.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Decision flow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                '- Single uniform child list  ->  use ListView\n'
                '- Single grid                  ->  use GridView\n'
                '- Heterogeneous slivers        ->  CustomScrollView\n'
                '- Pinned/floating headers      ->  add SliverAppBar\n'
                '- Custom pinned banner         ->  SliverPersistentHeader\n'
                '- Fill leftover space          ->  SliverFillRemaining',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.90),
                  fontSize: 12.0,
                  height: 1.55,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Decorative stat strip used as a divider between sections
// ============================================================================
Widget buildStatStrip() {
  final math.Random rng = math.Random(7);
  final List<Widget> bars = List<Widget>.generate(20, (int index) {
    final double h = 14.0 + rng.nextDouble() * 30.0;
    final List<Color> palette = <Color>[
      kAccent,
      kPink,
      kMint,
      kCoral,
      kViolet,
      kAmber,
      kCyan,
    ];
    final Color c = palette[index % palette.length];
    return Container(
      width: 10.0,
      height: h,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            c.withValues(alpha: 0.85),
            c.withValues(alpha: 0.45),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  });

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: bars,
    ),
  );
}

// ============================================================================
// Hero header (top of demo)
// ============================================================================
Widget buildHero() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kAccentDeep, kViolet, kPink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentDeep.withValues(alpha: 0.35),
          blurRadius: 22.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(
                Icons.view_carousel_rounded,
                color: Colors.white,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'CustomScrollView',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Composable sliver viewport - the foundation of '
                    'Flutter scroll widgets',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          children: <Widget>[
            buildPropChip('slivers: List<Widget>', Colors.white),
            buildPropChip('scrollDirection', Colors.white),
            buildPropChip('reverse', Colors.white),
            buildPropChip('controller', Colors.white),
            buildPropChip('physics', Colors.white),
            buildPropChip('anchor', Colors.white),
            buildPropChip('center', Colors.white),
            buildPropChip('cacheExtent', Colors.white),
            buildPropChip('keyboardDismissBehavior', Colors.white),
            buildPropChip('dragStartBehavior', Colors.white),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Top-level build - assembles the gallery into a single scrolling Scaffold.
// ============================================================================
dynamic build(BuildContext context) {
  final ScrollController demoController = ScrollController();

  final List<Widget> body = <Widget>[
    buildHero(),
    buildStatStrip(),

    buildSectionHeader(
      tag: 'SECTION 01',
      title: 'Basic sliver composition',
      blurb:
          'A CustomScrollView is built from a list of sliver widgets. The '
          'simplest sliver is SliverToBoxAdapter, which wraps any regular '
          'box widget in the sliver protocol.',
      accent: kAccent,
      icon: Icons.start_rounded,
    ),
    buildPropChipRow(
      const <String>['SliverToBoxAdapter', 'BouncingScrollPhysics'],
      kAccent,
    ),
    buildSection1Basic(),

    buildSectionHeader(
      tag: 'SECTION 02',
      title: 'Pinned SliverAppBar with stretch',
      blurb:
          'SliverAppBar is the canonical sliver header. Configured pinned + '
          'stretch + FlexibleSpaceBar, it stays visible while the rest of '
          'the slivers scroll beneath it.',
      accent: kAccentDeep,
      icon: Icons.layers_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverAppBar',
        'pinned',
        'stretch',
        'FlexibleSpaceBar',
        'StretchMode.zoomBackground',
      ],
      kAccentDeep,
    ),
    buildSection2PinnedAppBar(),

    buildSectionHeader(
      tag: 'SECTION 03',
      title: 'Sliver grids - count and extent variants',
      blurb:
          'SliverGrid composes a grid layout using a SliverGridDelegate. '
          'The .count constructor fixes the cross-axis count; the '
          'maxCrossAxisExtent variant responds to width.',
      accent: kPink,
      icon: Icons.grid_view_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverGrid.count',
        'SliverGridDelegateWithMaxCrossAxisExtent',
        'SliverPadding',
      ],
      kPink,
    ),
    buildSection3GridGallery(),

    buildSectionHeader(
      tag: 'SECTION 04',
      title: 'Heterogeneous mix of slivers',
      blurb:
          'The real power of CustomScrollView is mixing sliver families: '
          'an adapter hero, then a list, then a grid pocket, then a '
          'fixed-extent footer - all in one viewport.',
      accent: kMint,
      icon: Icons.dashboard_customize_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverToBoxAdapter',
        'SliverList',
        'SliverGrid.count',
        'SliverFixedExtentList',
      ],
      kMint,
    ),
    buildSection4MixedSlivers(),

    buildSectionHeader(
      tag: 'SECTION 05',
      title: 'Horizontal scroll direction',
      blurb:
          'CustomScrollView is not limited to vertical scrolling. Set '
          'scrollDirection: Axis.horizontal to use the same sliver '
          'protocol on the X axis.',
      accent: kCoral,
      icon: Icons.swipe_rounded,
    ),
    buildPropChipRow(
      const <String>['scrollDirection: Axis.horizontal', 'SliverList'],
      kCoral,
    ),
    buildSection5Horizontal(),

    buildSectionHeader(
      tag: 'SECTION 06',
      title: 'Reverse scrolling',
      blurb:
          'The reverse property flips the natural order. Useful for '
          'building chat transcripts that grow upward or stack-style '
          'logs.',
      accent: kViolet,
      icon: Icons.swap_vert_rounded,
    ),
    buildPropChipRow(
      const <String>['reverse: true', 'SliverFixedExtentList'],
      kViolet,
    ),
    buildSection6Reverse(),

    buildSectionHeader(
      tag: 'SECTION 07',
      title: 'SliverPersistentHeader (custom delegate)',
      blurb:
          'Behind every pinned banner is a SliverPersistentHeaderDelegate. '
          'You can build your own to create sticky section dividers.',
      accent: kCyan,
      icon: Icons.bookmark_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverPersistentHeader',
        'pinned',
        'custom delegate',
      ],
      kCyan,
    ),
    buildSection7PersistentHeader(),

    buildSectionHeader(
      tag: 'SECTION 08',
      title: 'SliverFillRemaining',
      blurb:
          'SliverFillRemaining stretches a single child to take up the '
          'leftover viewport space. With hasScrollBody: false it lets '
          'non-scrollable content sit beneath scrolling slivers.',
      accent: kAmber,
      icon: Icons.aspect_ratio_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverFillRemaining',
        'hasScrollBody: false',
        'NeverScrollableScrollPhysics',
      ],
      kAmber,
    ),
    buildSection8FillRemaining(),

    buildSectionHeader(
      tag: 'SECTION 09',
      title: 'SliverFillViewport - page-style scroll',
      blurb:
          'SliverFillViewport gives each child a fraction of the '
          'viewport. Paired with PageScrollPhysics it behaves like a '
          'page view.',
      accent: kAccent,
      icon: Icons.fullscreen_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'SliverFillViewport',
        'viewportFraction',
        'PageScrollPhysics',
      ],
      kAccent,
    ),
    buildSection9FillViewport(),

    buildSectionHeader(
      tag: 'SECTION 10',
      title: 'Floating + snap SliverAppBar',
      blurb:
          'Configuring SliverAppBar with floating: true + snap: true '
          'gives the app bar a snap-to behaviour: it slides in on '
          'upward drag and snaps to fully visible.',
      accent: kPink,
      icon: Icons.flight_rounded,
    ),
    buildPropChipRow(
      const <String>['floating', 'snap', 'expandedHeight'],
      kPink,
    ),
    buildSection10FloatingSnap(),

    buildSectionHeader(
      tag: 'SECTION 11',
      title: 'SliverPadding wrapping inner slivers',
      blurb:
          'SliverPadding inserts padding using sliver geometry, not box '
          'layout. Wrap any inner sliver to give it spacing in the '
          'scroll viewport.',
      accent: kAccentDeep,
      icon: Icons.format_indent_increase_rounded,
    ),
    buildPropChipRow(
      const <String>['SliverPadding', 'EdgeInsets'],
      kAccentDeep,
    ),
    buildSection11SliverPadding(),

    buildSectionHeader(
      tag: 'SECTION 12',
      title: 'Controller, physics, drag, keyboard',
      blurb:
          'CustomScrollView accepts a ScrollController and a rich set '
          'of behavioural properties to integrate with input devices '
          'and the system keyboard.',
      accent: kMint,
      icon: Icons.tune_rounded,
    ),
    buildPropChipRow(
      const <String>[
        'controller',
        'BouncingScrollPhysics',
        'keyboardDismissBehavior',
        'dragStartBehavior',
      ],
      kMint,
    ),
    buildSection12Controller(demoController),

    buildSectionHeader(
      tag: 'SECTION 13',
      title: 'anchor + center - bidirectional layout',
      blurb:
          'A CustomScrollView can have its zero offset placed anywhere '
          'in the viewport via anchor, and the slivers around the '
          'center key are laid out symmetrically.',
      accent: kPink,
      icon: Icons.center_focus_strong_rounded,
    ),
    buildPropChipRow(
      const <String>['anchor: 0.5', 'center: ValueKey'],
      kPink,
    ),
    buildSection13AnchorCenter(),

    buildSectionHeader(
      tag: 'SECTION 14',
      title: 'cacheExtent edge case',
      blurb:
          'cacheExtent controls how many pixels of off-screen content '
          'are kept alive. Tune it to balance memory against scroll '
          'smoothness.',
      accent: kAccent,
      icon: Icons.memory_rounded,
    ),
    buildPropChipRow(
      const <String>['cacheExtent: 200.0'],
      kAccent,
    ),
    buildSection14CacheExtent(),

    buildSectionHeader(
      tag: 'SECTION 15',
      title: 'Constructor parameters at a glance',
      blurb:
          'A quick reference for the most commonly used CustomScrollView '
          'parameters and what role each one plays.',
      accent: kViolet,
      icon: Icons.summarize_rounded,
    ),
    buildSpecGrid(),

    buildSectionHeader(
      tag: 'SECTION 16',
      title: 'The sliver family at a glance',
      blurb:
          'A condensed map of the sliver widgets that plug into a '
          'CustomScrollView. Each one provides a specific layout idiom '
          'within the shared sliver protocol.',
      accent: kCyan,
      icon: Icons.account_tree_rounded,
    ),
    buildFamilyMap(),

    buildStatStrip(),
    buildRecapCard(),
  ];

  return Scaffold(
    backgroundColor: kPaper,
    appBar: AppBar(
      backgroundColor: kInk,
      foregroundColor: Colors.white,
      elevation: 0.0,
      title: const Row(
        children: <Widget>[
          Icon(Icons.view_carousel_rounded, color: Colors.white),
          SizedBox(width: 10.0),
          Text(
            'CustomScrollView - Deep Demo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      centerTitle: false,
    ),
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: body,
      ),
    ),
  );
}
