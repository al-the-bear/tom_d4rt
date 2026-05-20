// D4rt test script: Deep Demo - NestedScrollView, SliverAppBar, SliverPersistentHeader
// Visually rich demonstration of NestedScrollView headers, pinned/floating/snap
// SliverAppBar behavior, FlexibleSpaceBar variants, expandedHeight tunings,
// body TabBarView, multiple tabs each scrollable, nested ListView/GridView,
// large SliverList, custom SliverPersistentHeaderDelegate using SizedBox+Container,
// gradient FlexibleSpaceBar backgrounds, bottom shadow demo, parallax-ish stacked headers.
import 'package:flutter/material.dart';

// ===========================================================================
// PALETTE COLOR CONSTANTS
// ===========================================================================

const Color kInk = Color(0xFF0F1226);
const Color kInkSoft = Color(0xFF3D4267);
const Color kInkMuted = Color(0xFF6B7194);
const Color kAccent = Color(0xFF5C4EE5);
const Color kAccentSoft = Color(0xFFE0DCFB);
const Color kAccentDeep = Color(0xFF2C1F8F);
const Color kSecondary = Color(0xFF00B5A1);
const Color kSecondarySoft = Color(0xFFC7F0EA);
const Color kSecondaryDeep = Color(0xFF005B53);
const Color kSuccess = Color(0xFF1B873F);
const Color kSuccessSoft = Color(0xFFD7F5DC);
const Color kWarn = Color(0xFFB36100);
const Color kWarnSoft = Color(0xFFFFE6C2);
const Color kDanger = Color(0xFFB3261E);
const Color kDangerSoft = Color(0xFFFADBD8);
const Color kInfo = Color(0xFF1565C0);
const Color kInfoSoft = Color(0xFFD7E8F8);
const Color kSurface = Color(0xFFF6F4FB);
const Color kSurfaceDark = Color(0xFF1A1D38);
const Color kOutline = Color(0xFFD9D5E8);
const Color kOutlineSoft = Color(0xFFEDEAF4);

// A persistent header delegate built around a SizedBox/Container — no
// real measurement work, just a structural placeholder so the layout
// reads as a richly decorated band inside the NestedScrollView.
class BandDelegate extends SliverPersistentHeaderDelegate {
  const BandDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight < minHeight ? minHeight : maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant BandDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

// Quick action icon button used in the snap toolbar band.
Widget buildQuickAction(IconData icon, String label, Color color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 32.0,
        height: 32.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.45),
            width: 1.0,
          ),
        ),
        child: Icon(icon, color: color, size: 18.0),
      ),
      const SizedBox(height: 3.0),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION SHELL HELPER
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: border, width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: border.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 12.0),
            decoration: BoxDecoration(
              color: titleColor.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19.0),
                topRight: Radius.circular(19.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: titleColor.withValues(alpha: 0.22),
                  width: 1.0,
                ),
              ),
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
                        color: titleColor,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: titleColor.withValues(alpha: 0.5),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: kInkSoft.withValues(alpha: 0.95),
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 16.0),
            child: child,
          ),
        ],
      ),
    );
  }

  // Small chip used widely across sections.
  Widget chip(String text, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: color.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13.0, color: color),
            const SizedBox(width: 5.0),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // Pretty tile used inside scrollable bodies.
  Widget contentTile({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    Color? trailingTone,
  }) {
    final Color tone = trailingTone ?? color;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kOutlineSoft, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  color.withValues(alpha: 0.95),
                  color.withValues(alpha: 0.65),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 8.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: kInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: kInkMuted,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '#${index.toString().padLeft(3, '0')}',
              style: TextStyle(
                color: tone,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable grid card.
  Widget gridCard({
    required int index,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.45),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            '#${index.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: kInkSoft.withValues(alpha: 0.8),
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Persistent band decoration helper.
  Widget bandSurface({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.95),
            color.withValues(alpha: 0.65),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.16),
            width: 1.0,
          ),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 34.0,
            height: 34.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.45),
                width: 1.0,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 18.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A1142),
          Color(0xFF3A2A93),
          Color(0xFF5C4EE5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 22.0,
          offset: const Offset(0, 12),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.32),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                Icons.swap_vert_circle,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'NestedScrollView — Deep Visual Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'SliverAppBar, SliverPersistentHeader, FlexibleSpaceBar, '
                    'TabBarView and inner scroll bodies — all stitched together '
                    'inside the NestedScrollView outer/inner contract.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('NestedScrollView', Colors.white, icon: Icons.layers),
            chip('SliverAppBar', Colors.white, icon: Icons.title),
            chip('FlexibleSpaceBar', Colors.white, icon: Icons.image),
            chip('SliverPersistentHeader', Colors.white, icon: Icons.push_pin),
            chip('pinned', Colors.white, icon: Icons.lock),
            chip('floating', Colors.white, icon: Icons.bubble_chart),
            chip('snap', Colors.white, icon: Icons.bolt),
            chip('expandedHeight', Colors.white, icon: Icons.height),
            chip('TabBarView', Colors.white, icon: Icons.tab),
            chip('SliverList', Colors.white, icon: Icons.list),
            chip('SliverGrid', Colors.white, icon: Icons.grid_view),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 - CANONICAL NestedScrollView WITH PINNED SliverAppBar
  // ===========================================================================

  final List<Widget> section1Tiles = List<Widget>.generate(
    14,
    (int i) {
      return contentTile(
        index: i + 1,
        title: 'Activity entry ${i + 1}',
        subtitle: 'A pinned SliverAppBar keeps the title visible while this '
            'inner body scrolls underneath it.',
        icon: Icons.event_note,
        color: kAccent,
      );
    },
  );

  final Widget section1Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
          sliver: const SliverAppBar(
            pinned: true,
            title: Text(
              'Pinned activity log',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            backgroundColor: kAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.search),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.filter_list),
              ),
            ],
          ),
        ),
      ];
    },
    body: Builder(
      builder: (BuildContext inner) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(inner),
            ),
            SliverList(
              delegate: SliverChildListDelegate(section1Tiles),
            ),
          ],
        );
      },
    ),
  );

  final Widget section1 = sectionShell(
    title: '01 · Canonical NestedScrollView with pinned SliverAppBar',
    subtitle: 'The classic outer/inner pattern: a pinned SliverAppBar in the '
        'headerSliverBuilder, with a SliverOverlapAbsorber routing overscroll '
        'into the body sliver list.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccent,
    child: SizedBox(
      height: 360.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section1Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 2 - FLOATING + SNAP SliverAppBar
  // ===========================================================================

  final List<Widget> section2Tiles = List<Widget>.generate(
    16,
    (int i) {
      return contentTile(
        index: i + 1,
        title: 'Feed post ${i + 1}',
        subtitle: 'Scroll up to make the floating + snap SliverAppBar appear '
            'in a single animated jump.',
        icon: Icons.dynamic_feed,
        color: kSecondary,
      );
    },
  );

  final Widget section2Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: kSecondary,
          foregroundColor: Colors.white,
          elevation: 4.0,
          title: const Text(
            'Floating + snap feed',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.refresh),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.tune),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: kSecondaryDeep.withValues(alpha: 0.85),
              ),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.wifi_tethering, color: Colors.white, size: 16.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Live · floating returns instantly on upward fling',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: section2Tiles,
    ),
  );

  final Widget section2 = sectionShell(
    title: '02 · floating: true + snap: true SliverAppBar',
    subtitle: 'Combining floating with snap makes the bar pop back into view '
        'in a single animated jump as soon as the user scrolls up — perfect '
        'for social-style feeds.',
    surface: Colors.white,
    border: kSecondarySoft,
    titleColor: kSecondary,
    child: SizedBox(
      height: 360.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section2Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 3 - LARGE expandedHeight + FlexibleSpaceBar gradient background
  // ===========================================================================

  final List<Widget> section3Tiles = List<Widget>.generate(
    18,
    (int i) {
      return contentTile(
        index: i + 1,
        title: 'Catalog item ${i + 1}',
        subtitle: 'The header collapses from 240px down to a slim AppBar as '
            'the inner body scrolls.',
        icon: Icons.style,
        color: kAccentDeep,
      );
    },
  );

  final Widget section3Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 240.0,
          backgroundColor: kAccentDeep,
          foregroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
              start: 18.0,
              bottom: 16.0,
              end: 18.0,
            ),
            title: const Text(
              'Studio Catalogue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    kAccentDeep,
                    kAccent,
                    Color(0xFF8B7DF9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -30.0,
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20.0,
                    bottom: -60.0,
                    child: Container(
                      width: 160.0,
                      height: 160.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 60.0, 18.0, 56.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 22.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'CURATED FOR YOU',
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.85),
                                fontSize: 11.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            chip(
                              '240 px expanded',
                              Colors.white,
                              icon: Icons.height,
                            ),
                            const SizedBox(width: 8.0),
                            chip(
                              'pinned',
                              Colors.white,
                              icon: Icons.lock,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      children: section3Tiles,
    ),
  );

  final Widget section3 = sectionShell(
    title: '03 · Large expandedHeight with gradient FlexibleSpaceBar background',
    subtitle: 'expandedHeight: 240.0 reveals a layered gradient hero with '
        'decorative circles and stacked typography — a richer "marketing" '
        'style header that collapses into a simple AppBar.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccentDeep,
    child: SizedBox(
      height: 440.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section3Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 - TabBarView BODY (classic profile layout)
  // ===========================================================================

  Widget tabBodyList(int count, IconData icon, Color color, String prefix) {
    final List<Widget> items = List<Widget>.generate(count, (int i) {
      return contentTile(
        index: i + 1,
        title: '$prefix entry ${i + 1}',
        subtitle: 'Tab body content rendered inside the inner scroll context.',
        icon: icon,
        color: color,
      );
    });
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: items,
    );
  }

  final Widget section4Demo = DefaultTabController(
    length: 3,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            backgroundColor: kInfo,
            foregroundColor: Colors.white,
            forceElevated: innerScrolled,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Profile · Tabs',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1565C0),
                      Color(0xFF42A5F5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 56.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 72.0,
                        height: 72.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.65),
                            width: 2.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 38.0,
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Avery Lin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Workspace administrator',
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.85),
                                fontSize: 12.0,
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
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: <Widget>[
                Tab(text: 'Posts', icon: Icon(Icons.article)),
                Tab(text: 'Media', icon: Icon(Icons.photo_library)),
                Tab(text: 'About', icon: Icon(Icons.info_outline)),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        children: <Widget>[
          tabBodyList(10, Icons.article, kInfo, 'Post'),
          tabBodyList(10, Icons.photo_library, kSecondary, 'Album'),
          tabBodyList(8, Icons.info_outline, kAccent, 'Fact'),
        ],
      ),
    ),
  );

  final Widget section4 = sectionShell(
    title: '04 · NestedScrollView body = TabBarView',
    subtitle: 'A DefaultTabController wraps the NestedScrollView. The pinned '
        'SliverAppBar carries a TabBar in its bottom slot; the body becomes a '
        'TabBarView whose pages each scroll under the shared header.',
    surface: Colors.white,
    border: kInfoSoft,
    titleColor: kInfo,
    child: SizedBox(
      height: 520.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section4Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 5 - CUSTOM SliverPersistentHeaderDelegate BAND
  // ===========================================================================

  final Widget section5Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        const SliverAppBar(
          pinned: true,
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
          title: Text(
            'Custom persistent band',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: BandDelegate(
            minHeight: 56.0,
            maxHeight: 56.0,
            child: bandSurface(
              color: kAccentDeep,
              icon: Icons.filter_alt,
              title: 'Filters',
              subtitle: 'A SliverPersistentHeader pinned just below the AppBar',
            ),
          ),
        ),
        SliverPersistentHeader(
          delegate: BandDelegate(
            minHeight: 50.0,
            maxHeight: 50.0,
            child: bandSurface(
              color: kSecondary,
              icon: Icons.sort,
              title: 'Sort options',
              subtitle: 'A second band that scrolls away with content',
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(20, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Catalog row ${i + 1}',
          subtitle: 'Pinned persistent header stays visible while this row '
              'scrolls underneath.',
          icon: Icons.table_rows,
          color: kAccent,
        );
      }),
    ),
  );

  final Widget section5 = sectionShell(
    title: '05 · Custom SliverPersistentHeaderDelegate bands',
    subtitle: 'A bespoke SliverPersistentHeaderDelegate (built from SizedBox + '
        'Container) renders two decorative bands — one pinned, one scrolling — '
        'beneath the SliverAppBar.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccent,
    child: SizedBox(
      height: 440.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section5Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 - NESTED GRIDVIEW UNDER SliverAppBar
  // ===========================================================================

  final List<Color> palette6 = <Color>[
    kAccent,
    kSecondary,
    kInfo,
    kSuccess,
    kWarn,
    kDanger,
  ];
  final List<IconData> icons6 = <IconData>[
    Icons.image,
    Icons.audiotrack,
    Icons.movie,
    Icons.book,
    Icons.gavel,
    Icons.science,
  ];

  final List<Widget> section6Cards = List<Widget>.generate(20, (int i) {
    final Color color = palette6[i % palette6.length];
    final IconData icon = icons6[i % icons6.length];
    return gridCard(
      index: i + 1,
      icon: icon,
      color: color,
      label: 'TILE',
    );
  });

  final Widget section6Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 160.0,
          backgroundColor: kSuccess,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Grid gallery',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0E5C2D),
                    Color(0xFF1B873F),
                    Color(0xFF4CAF50),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ];
    },
    body: GridView.count(
      padding: const EdgeInsets.all(10.0),
      crossAxisCount: 3,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: section6Cards,
    ),
  );

  final Widget section6 = sectionShell(
    title: '06 · Nested GridView under SliverAppBar',
    subtitle: 'The body of a NestedScrollView can be any scrollable, including '
        'a GridView. Here a 3-column grid scrolls under a pinned header with '
        'gradient FlexibleSpaceBar background.',
    surface: Colors.white,
    border: kSuccessSoft,
    titleColor: kSuccess,
    child: SizedBox(
      height: 440.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section6Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 7 - PARALLAX-ISH STACKED HEADERS (structural, no scroll logic)
  // ===========================================================================

  final Widget section7Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 280.0,
          backgroundColor: kSurfaceDark,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            title: const Text(
              'Parallax hero',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0F1226),
                        Color(0xFF2A1F8F),
                        Color(0xFF5C4EE5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  right: -40.0,
                  child: Container(
                    width: 260.0,
                    height: 260.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50.0,
                  left: -20.0,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.32),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: const Text(
                      'CollapseMode.parallax',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: BandDelegate(
            minHeight: 48.0,
            maxHeight: 48.0,
            child: bandSurface(
              color: kAccent,
              icon: Icons.menu_open,
              title: 'Categories',
              subtitle: 'Stays pinned below the parallax hero',
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(15, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Highlight ${i + 1}',
          subtitle: 'List item underneath the stacked header layers.',
          icon: Icons.star,
          color: kAccentDeep,
        );
      }),
    ),
  );

  final Widget section7 = sectionShell(
    title: '07 · Parallax-ish stacked headers',
    subtitle: 'CollapseMode.parallax and StretchMode.zoomBackground/fadeTitle '
        'are configured on a SliverAppBar.flexibleSpace, and a second pinned '
        'SliverPersistentHeader sits below it.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kInk,
    child: SizedBox(
      height: 520.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section7Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 8 - BOTTOM SHADOW / forceElevated DEMO
  // ===========================================================================

  final Widget section8Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          forceElevated: true,
          elevation: 8.0,
          shadowColor: kDanger.withValues(alpha: 0.6),
          backgroundColor: kDanger,
          foregroundColor: Colors.white,
          title: const Text(
            'Bottom shadow on AppBar',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(15, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Alert ${i + 1}',
          subtitle: 'SliverAppBar carries forceElevated, elevation 8 and a '
              'tinted shadow color to enhance separation.',
          icon: Icons.notification_important,
          color: kDanger,
        );
      }),
    ),
  );

  final Widget section8 = sectionShell(
    title: '08 · forceElevated + custom shadowColor',
    subtitle: 'A SliverAppBar with elevation: 8.0 and a tinted shadowColor '
        'demonstrates a strong drop shadow below the header.',
    surface: Colors.white,
    border: kDangerSoft,
    titleColor: kDanger,
    child: SizedBox(
      height: 380.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section8Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 9 - LARGE SliverList CHUNK with sliver mixins
  // ===========================================================================

  final List<Widget> section9Tiles = List<Widget>.generate(60, (int i) {
    return contentTile(
      index: i + 1,
      title: 'Bulk record ${i + 1}',
      subtitle: 'Large SliverList of 60 entries to exercise viewport recycling.',
      icon: Icons.storage,
      color: kInfo,
    );
  });

  final Widget section9Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: kInfo,
          foregroundColor: Colors.white,
          expandedHeight: 130.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Large list of 60 items',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1565C0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ];
    },
    body: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(section9Tiles),
          ),
        ),
      ],
    ),
  );

  final Widget section9 = sectionShell(
    title: '09 · Large SliverList — 60 elements',
    subtitle: 'A NestedScrollView whose body is a CustomScrollView containing '
        'a 60-element SliverList. Verifies viewport recycling under a pinned '
        'collapsed header.',
    surface: Colors.white,
    border: kInfoSoft,
    titleColor: kInfo,
    child: SizedBox(
      height: 480.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section9Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 10 - COLLAPSING TOOLBAR WITH MULTIPLE ACTIONS + bottom search
  // ===========================================================================

  final Widget section10Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          backgroundColor: kWarn,
          foregroundColor: Colors.white,
          title: const Text(
            'Inbox',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(Icons.mark_email_unread),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(Icons.archive),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(Icons.delete_outline),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.more_vert),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF7A3F00),
                    Color(0xFFB36100),
                    Color(0xFFE0A04D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 8.0,
              ),
              color: kWarn.withValues(alpha: 0.95),
              child: Container(
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search, color: kInkMuted, size: 18.0),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Search mail',
                        style: TextStyle(
                          color: kInkMuted,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.mic, color: kInkMuted, size: 18.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(18, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Message ${i + 1}',
          subtitle: 'Inbox entry. The toolbar above carries a bottom search '
              'panel and multiple action icons.',
          icon: Icons.email_outlined,
          color: kWarn,
        );
      }),
    ),
  );

  final Widget section10 = sectionShell(
    title: '10 · Collapsing toolbar with actions + bottom search',
    subtitle: 'Multiple actions, a gradient FlexibleSpaceBar background, and a '
        'PreferredSize-driven search field in the bottom slot — a complete '
        'collapsing toolbar pattern.',
    surface: Colors.white,
    border: kWarnSoft,
    titleColor: kWarn,
    child: SizedBox(
      height: 480.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section10Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 11 - RESTORATION-ID PATTERN (UI ONLY)
  // ===========================================================================

  final Widget section11Demo = NestedScrollView(
    restorationId: 'demo_nested_scroll_view',
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        const SliverAppBar(
          pinned: true,
          backgroundColor: kSecondaryDeep,
          foregroundColor: Colors.white,
          title: Text(
            'Restoration-aware NSV',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: BandDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              color: kSecondarySoft,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kSecondary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'restorationId: demo_nested_scroll_view',
                          style: TextStyle(
                            color: kSecondaryDeep,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Scroll position survives state restoration',
                          style: TextStyle(
                            color: kInkSoft,
                            fontSize: 11.0,
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
      ];
    },
    body: ListView(
      restorationId: 'demo_nested_scroll_view_body',
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(18, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Saved item ${i + 1}',
          subtitle: 'Position restored across process death thanks to '
              'restorationId.',
          icon: Icons.bookmark_outline,
          color: kSecondary,
        );
      }),
    ),
  );

  final Widget section11 = sectionShell(
    title: '11 · restorationId on NestedScrollView and inner ListView',
    subtitle: 'Both the NestedScrollView and the inner ListView carry a '
        'restorationId. UI demonstrates the pattern only — visual integrity '
        'remains unchanged.',
    surface: Colors.white,
    border: kSecondarySoft,
    titleColor: kSecondaryDeep,
    child: SizedBox(
      height: 440.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section11Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 12 - FOUR TABS, EACH SCROLLABLE
  // ===========================================================================

  Widget tabGrid(int count, IconData icon, Color color) {
    final List<Widget> cards = List<Widget>.generate(count, (int i) {
      return gridCard(
        index: i + 1,
        icon: icon,
        color: color,
        label: 'CARD',
      );
    });
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 1.2,
      children: cards,
    );
  }

  Widget tabFacts(int count, IconData icon, Color color, String label) {
    final List<Widget> rows = List<Widget>.generate(count, (int i) {
      return contentTile(
        index: i + 1,
        title: '$label fact ${i + 1}',
        subtitle: 'Long-form fact item rendered inside the inner scroll body.',
        icon: icon,
        color: color,
      );
    });
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: rows,
    );
  }

  final Widget section12Demo = DefaultTabController(
    length: 4,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 220.0,
            backgroundColor: kAccentDeep,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Four-tab workspace',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF2C1F8F),
                      Color(0xFF5C4EE5),
                      Color(0xFF00B5A1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 60.0, 18.0, 64.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Icon(
                              Icons.dashboard,
                              color: Colors.white,
                              size: 22.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            'WORKSPACE OVERVIEW',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12.0,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: <Widget>[
                          chip('4 tabs', Colors.white,
                              icon: Icons.tab_unselected),
                          chip('mixed scrolls', Colors.white,
                              icon: Icons.swap_vert),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: <Widget>[
                Tab(text: 'Overview', icon: Icon(Icons.bar_chart)),
                Tab(text: 'Boards', icon: Icon(Icons.view_kanban)),
                Tab(text: 'Files', icon: Icon(Icons.folder)),
                Tab(text: 'Insights', icon: Icon(Icons.insights)),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        children: <Widget>[
          tabFacts(10, Icons.bar_chart, kAccent, 'Overview'),
          tabGrid(12, Icons.view_kanban, kSecondary),
          tabFacts(12, Icons.folder, kInfo, 'Files'),
          tabGrid(10, Icons.insights, kWarn),
        ],
      ),
    ),
  );

  final Widget section12 = sectionShell(
    title: '12 · Four-tab workspace with mixed scrollables',
    subtitle: 'Each tab body uses a different scrollable: two ListViews and '
        'two GridViews. The shared header collapses across every tab swap.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccentDeep,
    child: SizedBox(
      height: 560.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section12Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 13 - SNAP + FLOATING + BOTTOM ACTIONS BAND
  // ===========================================================================

  final Widget section13Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
          title: const Text(
            'Snap toolbar',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64.0),
            child: Container(
              height: 64.0,
              color: kAccentDeep,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildQuickAction(
                      Icons.add_box_outlined, 'New', Colors.white),
                  buildQuickAction(Icons.share, 'Share', Colors.white),
                  buildQuickAction(Icons.download, 'Download', Colors.white),
                  buildQuickAction(Icons.star_border, 'Star', Colors.white),
                  buildQuickAction(Icons.more_horiz, 'More', Colors.white),
                ],
              ),
            ),
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(20, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Document ${i + 1}',
          subtitle: 'Snap floating bar with a wide actions band underneath.',
          icon: Icons.description,
          color: kAccent,
        );
      }),
    ),
  );

  final Widget section13 = sectionShell(
    title: '13 · Snap floating bar with quick-actions band',
    subtitle: 'A floating + snap SliverAppBar combines with a 64-pixel custom '
        'bottom band of icon buttons that double the toolbar height.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccent,
    child: SizedBox(
      height: 460.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section13Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 14 - STRETCHABLE FLEXIBLE SPACE WITH MULTIPLE STRETCH MODES
  // ===========================================================================

  final Widget section14Demo = NestedScrollView(
    headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
      return <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 260.0,
          stretch: true,
          backgroundColor: kSecondaryDeep,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            title: const Text(
              'Stretch · Zoom · Blur · Fade',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF003D38),
                        Color(0xFF005B53),
                        Color(0xFF00B5A1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.spa,
                      size: 120.0,
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 60.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 56.0,
                        height: 56.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.45),
                            width: 1.4,
                          ),
                        ),
                        child: const Icon(
                          Icons.spa,
                          color: Colors.white,
                          size: 28.0,
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Wellness library',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.92),
                                fontSize: 12.0,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Calm spaces, mindful flows',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
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
          ),
        ),
      ];
    },
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List<Widget>.generate(14, (int i) {
        return contentTile(
          index: i + 1,
          title: 'Practice ${i + 1}',
          subtitle: 'Overscroll on the top of this list causes the header to '
              'stretch, blur, and fade thanks to stretchModes.',
          icon: Icons.self_improvement,
          color: kSecondaryDeep,
        );
      }),
    ),
  );

  final Widget section14 = sectionShell(
    title: '14 · stretch + multi-StretchMode FlexibleSpaceBar',
    subtitle: 'stretch: true plus stretchModes [zoomBackground, blurBackground, '
        'fadeTitle] showcases the full stretch animation vocabulary on the '
        'collapsing header.',
    surface: Colors.white,
    border: kSecondarySoft,
    titleColor: kSecondaryDeep,
    child: SizedBox(
      height: 500.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: section14Demo,
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 15 - TUNED expandedHeight VARIANTS
  // ===========================================================================

  Widget tunedExpanded({
    required double expanded,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return SizedBox(
      width: 260.0,
      height: 320.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            border: Border.all(color: kOutline, width: 1.0),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext ctx, bool innerScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: expanded,
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            color,
                            color.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 40.0,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              children: List<Widget>.generate(8, (int i) {
                return contentTile(
                  index: i + 1,
                  title: 'Item ${i + 1}',
                  subtitle: 'expanded=$expanded',
                  icon: icon,
                  color: color,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  final Widget section15 = sectionShell(
    title: '15 · expandedHeight tuning gallery',
    subtitle: 'Three NestedScrollView mini-demos with progressively larger '
        'expandedHeight values (96, 160, 240) — side-by-side in a horizontal '
        'scroller for direct comparison.',
    surface: Colors.white,
    border: kAccentSoft,
    titleColor: kAccent,
    child: SizedBox(
      height: 340.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        children: <Widget>[
          tunedExpanded(
            expanded: 96.0,
            label: 'expanded: 96',
            color: kAccent,
            icon: Icons.compress,
          ),
          const SizedBox(width: 12.0),
          tunedExpanded(
            expanded: 160.0,
            label: 'expanded: 160',
            color: kSecondary,
            icon: Icons.unfold_less,
          ),
          const SizedBox(width: 12.0),
          tunedExpanded(
            expanded: 240.0,
            label: 'expanded: 240',
            color: kInfo,
            icon: Icons.open_in_full,
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // FOOTER
  // ===========================================================================

  final Widget footer = Container(
    margin: const EdgeInsets.fromLTRB(6.0, 10.0, 6.0, 18.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kSurfaceDark,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSurfaceDark.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 24.0,
          ),
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'NestedScrollView demo complete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Fifteen distinct sections cover SliverAppBar modes, '
                'FlexibleSpaceBar variants, persistent headers, tabbed bodies '
                'and nested scroll bodies.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // OUTER SCAFFOLD
  // ===========================================================================

  return Scaffold(
    backgroundColor: kSurface,
    appBar: AppBar(
      title: const Text(
        'NestedScrollView Deep Demo',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
      backgroundColor: kAccentDeep,
      foregroundColor: Colors.white,
      elevation: 6.0,
      shadowColor: kAccent.withValues(alpha: 0.5),
    ),
    body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      children: <Widget>[
        heroBanner,
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        footer,
      ],
    ),
  );
}
