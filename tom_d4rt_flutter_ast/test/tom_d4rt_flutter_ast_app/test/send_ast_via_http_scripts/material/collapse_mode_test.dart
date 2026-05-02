// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// CollapseMode Deep Demo
//
// CollapseMode is the enum used by FlexibleSpaceBar.collapseMode that selects
// how a SliverAppBar's flexible-space background reacts as the SliverAppBar
// collapses while the user scrolls. The three values are:
//
//   * CollapseMode.parallax  -> background scrolls slower than foreground
//                               (a soft, cinematic parallax effect)
//   * CollapseMode.pin       -> background stays pinned to the bottom of the
//                               flexible space and "sticks" as it shrinks
//   * CollapseMode.none      -> background scrolls 1:1 with the content,
//                               i.e. it slides up out of view together with
//                               the rest of the flexible space
//
// Because the harness renders inside a sub-tree (not a real scrollable app),
// each demo embeds a fixed-size CustomScrollView inside a SizedBox so the
// reader can scroll each example independently to *feel* the behaviour of
// each collapse mode.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== CollapseMode Deep Demo (Harness-Safe) ===');
  for (final v in CollapseMode.values) {
    print('  CollapseMode.${v.name} (index=${v.index})');
  }
  print('Sections in this demo:');
  print('  1) Hero card and pictogram explainer');
  print('  2) Parallax showcase (scrollable embed)');
  print('  3) Pin showcase (scrollable embed)');
  print('  4) None showcase (scrollable embed)');
  print('  5) Side-by-side mini comparison');
  print('  6) Recipe: city header with parallax');
  print('  7) Recipe: music album page with pin');
  print('  8) Recipe: settings page with none + zoomBackground');
  print('  9) Reference card: enum value table');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CollapseMode Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF3F51B5),
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildPageHeader(),
              const SizedBox(height: 18),
              _buildSection1HeroExplainer(),
              const SizedBox(height: 22),
              _buildSection2Parallax(),
              const SizedBox(height: 22),
              _buildSection3Pin(),
              const SizedBox(height: 22),
              _buildSection4None(),
              const SizedBox(height: 22),
              _buildSection5SideBySide(),
              const SizedBox(height: 22),
              _buildSection6CityHeaderRecipe(),
              const SizedBox(height: 22),
              _buildSection7MusicAlbumRecipe(),
              const SizedBox(height: 22),
              _buildSection8SettingsRecipe(),
              const SizedBox(height: 22),
              _buildSection9ReferenceTable(),
              const SizedBox(height: 32),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// PAGE HEADER
// =============================================================================

Widget _buildPageHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1A237E).withOpacity(0.30),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'CollapseMode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'How FlexibleSpaceBar.collapseMode reshapes a SliverAppBar background',
          style: TextStyle(
            color: Color(0xFFE8EAF6),
            fontSize: 15,
            height: 1.35,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Scroll each embedded panel below to experience parallax, pin, and '
          'none directly. Every background is hand-painted using gradients, '
          'shapes and icons — no network images.',
          style: TextStyle(
            color: Color(0xFFC5CAE9),
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION CARD HELPER
// =============================================================================

Widget _sectionCard({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE0E2EA), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.10),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border(
              bottom: BorderSide(color: accent.withOpacity(0.25), width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: accent.withOpacity(0.92),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF54607A),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(16), child: body),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 — HERO EXPLAINER (static pictograms)
// =============================================================================

Widget _buildSection1HeroExplainer() {
  return _sectionCard(
    number: '1',
    title: 'What CollapseMode means',
    subtitle:
        'Static pictograms — three pairs of "expanded vs collapsed" cards '
        'that hint at how each mode translates the background.',
    accent: const Color(0xFF1565C0),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'CollapseMode controls only the BACKGROUND of FlexibleSpaceBar. The '
          'title and other foreground elements always interpolate the same '
          'way. The mode selects how aggressively the background follows the '
          'collapse animation.',
          style: TextStyle(fontSize: 13.5, height: 1.45, color: Color(0xFF2A3046)),
        ),
        const SizedBox(height: 14),
        _explainerRow(
          modeName: 'parallax',
          tagline: 'Background drifts slower than the scroll — a soft "depth" '
              'illusion. This is the default.',
          color: const Color(0xFF1565C0),
          expandedOffset: 0,
          collapsedOffset: -28,
        ),
        const SizedBox(height: 12),
        _explainerRow(
          modeName: 'pin',
          tagline: 'Background sticks to the bottom of the flexible space '
              'and seems to "stay put" while the bar shrinks.',
          color: const Color(0xFF6A1B9A),
          expandedOffset: 0,
          collapsedOffset: 0,
        ),
        const SizedBox(height: 12),
        _explainerRow(
          modeName: 'none',
          tagline: 'Background scrolls one-to-one with content. Visually it '
              'simply slides upward off the screen.',
          color: const Color(0xFFB71C1C),
          expandedOffset: 0,
          collapsedOffset: -56,
        ),
      ],
    ),
  );
}

Widget _explainerRow({
  required String modeName,
  required String tagline,
  required Color color,
  required double expandedOffset,
  required double collapsedOffset,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      _pictogram(label: 'expanded', color: color, translateY: expandedOffset),
      const SizedBox(width: 10),
      Icon(Icons.arrow_forward, color: color.withOpacity(0.55), size: 18),
      const SizedBox(width: 10),
      _pictogram(label: 'collapsed', color: color, translateY: collapsedOffset),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CollapseMode.$modeName',
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 3),
            Text(
              tagline,
              style: const TextStyle(
                fontSize: 12,
                height: 1.35,
                color: Color(0xFF2A3046),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pictogram({
  required String label,
  required Color color,
  required double translateY,
}) {
  return Container(
    width: 70,
    height: 56,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: const Color(0xFFEEF1F8),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.30)),
    ),
    child: Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0, translateY),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color, color.withOpacity(0.55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.white.withOpacity(0.85),
            padding: const EdgeInsets.symmetric(vertical: 2),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — PARALLAX SHOWCASE
// =============================================================================

Widget _buildSection2Parallax() {
  return _sectionCard(
    number: '2',
    title: 'CollapseMode.parallax (the default)',
    subtitle:
        'Scroll the embedded panel below. Notice how the gradient sky drifts '
        'slower than the foreground tiles — a depth illusion.',
    accent: const Color(0xFF1976D2),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: const Text(
                      'Parallax sky',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    background: _buildSkyBackground(
                      const <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                        Color(0xFFBBDEFB),
                      ],
                      drawSun: true,
                    ),
                  ),
                ),
                SliverList.list(children: _decorativeTiles(
                  baseColor: const Color(0xFF1976D2),
                  count: 12,
                  prefix: 'Cloud',
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Implementation: FlexibleSpaceBar(collapseMode: CollapseMode.parallax, '
          'background: <gradient sky>). The default is parallax — you usually '
          'do not need to specify the parameter unless you want pin or none.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _buildSkyBackground(List<Color> colors, {bool drawSun = false}) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      if (drawSun)
        Positioned(
          right: 28,
          top: 28,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: <Color>[Color(0xFFFFF59D), Color(0xFFFFEE58), Color(0xFFFBC02D)],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFFFEE58).withOpacity(0.55),
                  blurRadius: 22,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        ),
      // A faint cloud bank
      Positioned(
        left: -10,
        bottom: 30,
        child: _buildCloud(120, 28, Colors.white.withOpacity(0.55)),
      ),
      Positioned(
        left: 90,
        bottom: 60,
        child: _buildCloud(80, 18, Colors.white.withOpacity(0.40)),
      ),
      Positioned(
        right: 30,
        bottom: 40,
        child: _buildCloud(100, 22, Colors.white.withOpacity(0.45)),
      ),
    ],
  );
}

Widget _buildCloud(double w, double h, Color color) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(h),
    ),
  );
}

List<Widget> _decorativeTiles({
  required Color baseColor,
  required int count,
  required String prefix,
}) {
  return <Widget>[
    for (int i = 0; i < count; i++)
      Container(
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.06 + (i % 4) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: baseColor.withOpacity(0.18)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: baseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$prefix #${i + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1A1F2E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Filler row to make the embedded ScrollView '
                    'actually scrollable.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: const Color(0xFF54607A).withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: baseColor.withOpacity(0.55)),
          ],
        ),
      ),
  ];
}

// =============================================================================
// SECTION 3 — PIN SHOWCASE
// =============================================================================

Widget _buildSection3Pin() {
  return _sectionCard(
    number: '3',
    title: 'CollapseMode.pin',
    subtitle:
        'The background is anchored to the bottom of the flexible space and '
        'visually "stays put" while the bar shrinks.',
    accent: const Color(0xFF6A1B9A),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    title: const Text(
                      'Pinned aurora',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    background: _buildAuroraBackground(),
                  ),
                ),
                SliverList.list(children: _decorativeTiles(
                  baseColor: const Color(0xFF6A1B9A),
                  count: 12,
                  prefix: 'Track',
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Pin is great when the artwork is the "anchor" of the screen and '
          'should not appear to move at all. Album covers, hero portraits, '
          'and product close-ups all benefit from this mode.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _buildAuroraBackground() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFF311B92), Color(0xFF6A1B9A), Color(0xFFAD1457)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      // Aurora ribbons — soft horizontal gradients with rotation
      Positioned(
        left: -40,
        top: 30,
        right: -40,
        child: Transform.rotate(
          angle: -0.20,
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.transparent,
                  const Color(0xFF80DEEA).withOpacity(0.55),
                  const Color(0xFFCE93D8).withOpacity(0.55),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: -40,
        top: 90,
        right: -40,
        child: Transform.rotate(
          angle: 0.10,
          child: Container(
            height: 28,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.transparent,
                  const Color(0xFFA5D6A7).withOpacity(0.45),
                  const Color(0xFF81D4FA).withOpacity(0.45),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
      // Stars
      ...List<Widget>.generate(18, (int i) {
        final double x = (i * 23 % 320).toDouble();
        final double y = (i * 17 % 130).toDouble();
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 2 + (i % 3).toDouble(),
            height: 2 + (i % 3).toDouble(),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    ],
  );
}

// =============================================================================
// SECTION 4 — NONE SHOWCASE
// =============================================================================

Widget _buildSection4None() {
  return _sectionCard(
    number: '4',
    title: 'CollapseMode.none',
    subtitle:
        'Background scrolls one-to-one with content. The visual just slides '
        'upward and out — no parallax, no pin.',
    accent: const Color(0xFFB71C1C),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  backgroundColor: const Color(0xFFB71C1C),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    title: const Text(
                      'Sliding sunset',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    background: _buildSunsetBackground(),
                  ),
                ),
                SliverList.list(children: _decorativeTiles(
                  baseColor: const Color(0xFFB71C1C),
                  count: 12,
                  prefix: 'Note',
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'CollapseMode.none is the right pick when you want the background '
          'art to "fade away" with the rest of the content rather than '
          'persist or drift. Useful for transient hero artwork.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _buildSunsetBackground() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFFFF59D),
              Color(0xFFFFB74D),
              Color(0xFFE53935),
              Color(0xFF6A1B9A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      // Sun disc
      Positioned(
        left: 0,
        right: 0,
        bottom: 50,
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFD54F), Color(0xFFFF6F00)],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFFF8A65).withOpacity(0.55),
                  blurRadius: 28,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      // Horizon line
      Positioned(
        left: 0,
        right: 0,
        bottom: 50,
        child: Container(
          height: 2,
          color: const Color(0xFF3E2723).withOpacity(0.55),
        ),
      ),
      // Silhouette mountains
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _mountain(45, const Color(0xFF1B1F2A)),
            _mountain(28, const Color(0xFF1B1F2A)),
            _mountain(38, const Color(0xFF1B1F2A)),
            _mountain(22, const Color(0xFF1B1F2A)),
            _mountain(50, const Color(0xFF1B1F2A)),
            _mountain(34, const Color(0xFF1B1F2A)),
          ],
        ),
      ),
    ],
  );
}

Widget _mountain(double height, Color color) {
  return Expanded(
    child: ClipPath(
      clipper: const _TriangleClipper(),
      child: Container(height: height, color: color),
    ),
  );
}

class _TriangleClipper extends CustomClipper<Path> {
  const _TriangleClipper();
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// =============================================================================
// SECTION 5 — SIDE-BY-SIDE MINI COMPARISON
// =============================================================================

Widget _buildSection5SideBySide() {
  return _sectionCard(
    number: '5',
    title: 'Side-by-side mini comparison',
    subtitle:
        'Three small (200 tall) embedded scrollers — one per mode — with '
        'identical expandedHeight=120. Scroll each separately to compare.',
    accent: const Color(0xFF00897B),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _miniComparison(
                label: 'parallax',
                color: const Color(0xFF1976D2),
                mode: CollapseMode.parallax,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniComparison(
                label: 'pin',
                color: const Color(0xFF6A1B9A),
                mode: CollapseMode.pin,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniComparison(
                label: 'none',
                color: const Color(0xFFB71C1C),
                mode: CollapseMode.none,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Tip: scroll the leftmost panel first to see parallax. Then scroll '
          'the middle one — pin keeps the artwork glued. Then the rightmost '
          'one — none simply slides off.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _miniComparison({
  required String label,
  required Color color,
  required CollapseMode mode,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: color,
                foregroundColor: Colors.white,
                titleSpacing: 8,
                toolbarHeight: 36,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: mode,
                  titlePadding: const EdgeInsets.only(left: 10, bottom: 8),
                  title: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: _buildMiniBackground(color),
                ),
              ),
              SliverList.list(children: <Widget>[
                for (int i = 0; i < 8; i++)
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: color.withOpacity(0.18)),
                    ),
                    child: Text(
                      'Item ${i + 1}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
              ]),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildMiniBackground(Color base) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              base,
              base.withOpacity(0.55),
              base.withOpacity(0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      Positioned(
        right: -8,
        top: -8,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: 16,
        bottom: 22,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — CITY HEADER RECIPE (parallax)
// =============================================================================

Widget _buildSection6CityHeaderRecipe() {
  return _sectionCard(
    number: '6',
    title: 'Recipe: city header (parallax)',
    subtitle:
        'A stylised city skyline as the SliverAppBar background. Built from '
        'layered Containers; no network images. Parallax brings the depth.',
    accent: const Color(0xFF455A64),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  backgroundColor: const Color(0xFF263238),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: const Text(
                      'New Beacon City',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    background: _buildCitySkyline(),
                  ),
                ),
                SliverList.list(children: <Widget>[
                  _cityInfoRow(
                    icon: Icons.location_on,
                    title: 'Downtown district',
                    subtitle: '12 venues, 4 transit hubs',
                    color: const Color(0xFF455A64),
                  ),
                  _cityInfoRow(
                    icon: Icons.local_cafe,
                    title: 'Coffee corners',
                    subtitle: 'Hand-picked, micro-roasters',
                    color: const Color(0xFF6D4C41),
                  ),
                  _cityInfoRow(
                    icon: Icons.theater_comedy,
                    title: 'Live shows tonight',
                    subtitle: '7 events, 3 sold out',
                    color: const Color(0xFFAD1457),
                  ),
                  _cityInfoRow(
                    icon: Icons.train,
                    title: 'Transit',
                    subtitle: 'Subway runs every 4 minutes',
                    color: const Color(0xFF1565C0),
                  ),
                  _cityInfoRow(
                    icon: Icons.park,
                    title: 'Green spaces',
                    subtitle: '5 parks within walking distance',
                    color: const Color(0xFF2E7D32),
                  ),
                  _cityInfoRow(
                    icon: Icons.museum,
                    title: 'Galleries',
                    subtitle: 'Free admission Wednesdays',
                    color: const Color(0xFF6A1B9A),
                  ),
                  _cityInfoRow(
                    icon: Icons.restaurant,
                    title: 'Food halls',
                    subtitle: 'Open until 02:00',
                    color: const Color(0xFFF57F17),
                  ),
                  _cityInfoRow(
                    icon: Icons.directions_bike,
                    title: 'Bike share',
                    subtitle: '420 stations across town',
                    color: const Color(0xFF00838F),
                  ),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Tip: parallax pairs especially well with skylines — the slow drift '
          'enhances the sense of looking out of a high window. Combine with '
          'pinned: true so the bar always remains visible.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _buildCitySkyline() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      // Sky
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF263238),
              Color(0xFF455A64),
              Color(0xFFFFB74D),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      // Distant moon
      Positioned(
        right: 36,
        top: 22,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFECEFF1).withOpacity(0.85),
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFFECEFF1).withOpacity(0.45),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
      // Distant skyline (lighter)
      Positioned(
        left: 0,
        right: 0,
        bottom: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _building(40, 22, const Color(0xFF37474F)),
            _building(60, 30, const Color(0xFF37474F)),
            _building(45, 18, const Color(0xFF37474F)),
            _building(80, 28, const Color(0xFF37474F)),
            _building(35, 22, const Color(0xFF37474F)),
            _building(70, 26, const Color(0xFF37474F)),
            _building(50, 22, const Color(0xFF37474F)),
          ],
        ),
      ),
      // Foreground skyline (darker, taller)
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _building(72, 28, const Color(0xFF1B1F2A), withWindows: true),
            _building(110, 34, const Color(0xFF1B1F2A), withWindows: true),
            _building(60, 22, const Color(0xFF1B1F2A), withWindows: true),
            _building(140, 38, const Color(0xFF1B1F2A), withWindows: true),
            _building(90, 28, const Color(0xFF1B1F2A), withWindows: true),
            _building(120, 32, const Color(0xFF1B1F2A), withWindows: true),
            _building(80, 26, const Color(0xFF1B1F2A), withWindows: true),
          ],
        ),
      ),
    ],
  );
}

Widget _building(double height, double width, Color color, {bool withWindows = false}) {
  final List<Widget> windows = <Widget>[];
  if (withWindows) {
    final int rows = (height / 14).floor().clamp(1, 8);
    final int cols = (width / 7).floor().clamp(1, 4);
    for (int r = 0; r < rows; r++) {
      final List<Widget> rowChildren = <Widget>[];
      for (int c = 0; c < cols; c++) {
        final bool lit = ((r * 3 + c * 5 + width.toInt()) % 4) != 0;
        rowChildren.add(Container(
          width: 3,
          height: 4,
          margin: const EdgeInsets.all(1),
          color: lit
              ? const Color(0xFFFFE082).withOpacity(0.85)
              : Colors.transparent,
        ));
      }
      windows.add(Row(mainAxisSize: MainAxisSize.min, children: rowChildren));
    }
  }
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
    ),
    padding: const EdgeInsets.all(3),
    alignment: Alignment.topCenter,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: windows,
    ),
  );
}

Widget _cityInfoRow({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE0E2EA)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF54607A),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7 — MUSIC ALBUM RECIPE (pin)
// =============================================================================

Widget _buildSection7MusicAlbumRecipe() {
  return _sectionCard(
    number: '7',
    title: 'Recipe: music album (pin + centerTitle)',
    subtitle:
        'Album cover stays put as the page scrolls. centerTitle: true gives '
        'the page a streaming-app feel.',
    accent: const Color(0xFF8E24AA),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  backgroundColor: const Color(0xFF4A148C),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: const Text(
                      'Neon Mirage',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    background: _buildAlbumCover(),
                  ),
                ),
                SliverList.list(children: <Widget>[
                  for (int i = 0; i < 10; i++)
                    _trackRow(
                      number: i + 1,
                      title: _albumTrack(i).$1,
                      duration: _albumTrack(i).$2,
                    ),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Pin keeps the cover art rock-solid while the track list scrolls — '
          'a hallmark of Spotify, Apple Music and YouTube Music album pages.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

(String, String) _albumTrack(int i) {
  const List<(String, String)> tracks = <(String, String)>[
    ('Pulse Index', '3:42'),
    ('Mirror Lake', '4:11'),
    ('Soft Static', '2:58'),
    ('Hover', '3:06'),
    ('Velvet Hour', '5:24'),
    ('Citrus Lift', '3:39'),
    ('Threadbare', '4:48'),
    ('Glass Bird', '3:17'),
    ('Reverie', '4:02'),
    ('Last Light', '6:13'),
  ];
  return tracks[i % tracks.length];
}

Widget _buildAlbumCover() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      // Layered radial gradient
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Color(0xFFE1BEE7),
              Color(0xFF8E24AA),
              Color(0xFF311B92),
            ],
            stops: <double>[0.0, 0.55, 1.0],
            radius: 0.9,
          ),
        ),
      ),
      // Concentric circle pattern
      ...List<Widget>.generate(5, (int i) {
        final double size = 60.0 + i * 36.0;
        return Center(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.18 - i * 0.025),
                width: 1.2,
              ),
            ),
          ),
        );
      }),
      // Center neon dot
      Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFEB3B),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFFFFEB3B).withOpacity(0.6),
                blurRadius: 18,
                spreadRadius: 4,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _trackRow({
  required int number,
  required String title,
  required String duration,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE0E2EA)),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 28,
          child: Text(
            '$number',
            style: const TextStyle(
              color: Color(0xFF8E24AA),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Text(
          duration,
          style: const TextStyle(
            color: Color(0xFF54607A),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 — SETTINGS PAGE RECIPE (none + zoomBackground)
// =============================================================================

Widget _buildSection8SettingsRecipe() {
  return _sectionCard(
    number: '8',
    title: 'Recipe: settings page (none + zoomBackground)',
    subtitle:
        'CollapseMode.none combined with stretchModes: [StretchMode.zoomBackground] '
        'so an overscroll pull "blooms" the artwork.',
    accent: const Color(0xFF2E7D32),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 360,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  stretch: true,
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    stretchModes: const <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    title: const Text(
                      'Settings',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    background: _buildSettingsBackground(),
                  ),
                ),
                SliverList.list(children: <Widget>[
                  _settingsGroup('Account', <Widget>[
                    _settingsTile(Icons.person, 'Profile', 'Tom Bear'),
                    _settingsTile(Icons.email, 'Email',
                        'tom@example.dev'),
                    _settingsTile(Icons.lock, 'Password',
                        'Last changed 12 days ago'),
                  ]),
                  _settingsGroup('Preferences', <Widget>[
                    _settingsTile(Icons.brightness_6, 'Theme', 'System'),
                    _settingsTile(Icons.language, 'Language', 'English (UK)'),
                    _settingsTile(Icons.notifications, 'Notifications',
                        'On — sounds disabled'),
                  ]),
                  _settingsGroup('About', <Widget>[
                    _settingsTile(Icons.info, 'Version', '1.4.2'),
                    _settingsTile(Icons.gavel, 'Licenses', 'Open-source'),
                  ]),
                  const SizedBox(height: 16),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'On platforms with bouncing physics, pulling down past the top will '
          'now zoom and blur the leaf-pattern background — a delightful "give" '
          'effect that complements CollapseMode.none.',
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF54607A)),
        ),
      ],
    ),
  );
}

Widget _buildSettingsBackground() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
              Color(0xFF66BB6A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      // Repeating diagonal "leaf" pattern from Icons
      ...List<Widget>.generate(24, (int i) {
        final double x = (i % 6) * 60.0 - 10;
        final double y = (i ~/ 6) * 60.0 - 10;
        return Positioned(
          left: x,
          top: y,
          child: Transform.rotate(
            angle: (i % 5) * 0.3,
            child: Icon(
              Icons.eco,
              size: 36,
              color: Colors.white.withOpacity(0.10 + (i % 3) * 0.04),
            ),
          ),
        );
      }),
    ],
  );
}

Widget _settingsGroup(String label, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E2EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        ...children,
      ],
    ),
  );
}

Widget _settingsTile(IconData icon, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 20, color: const Color(0xFF2E7D32)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF54607A),
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Color(0xFF9AA3B7)),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 — REFERENCE TABLE
// =============================================================================

Widget _buildSection9ReferenceTable() {
  final List<Map<String, String>> rows = <Map<String, String>>[
    <String, String>{
      'name': 'parallax',
      'index': '0',
      'when': 'Default. Cinematic depth. Use for landscape headers, hero '
          'photography, weather screens, dashboards.',
    },
    <String, String>{
      'name': 'pin',
      'index': '1',
      'when': 'Use when artwork is the anchor: album covers, product close-'
          'ups, profile portraits, single-character heroes.',
    },
    <String, String>{
      'name': 'none',
      'index': '2',
      'when': 'Use for transient or generic backgrounds you are happy to '
          'see slide off — settings pages, dense content lists.',
    },
  ];

  return _sectionCard(
    number: '9',
    title: 'Reference: enum value table',
    subtitle:
        'Quick lookup for code review and design reviews. Note that values are '
        'sorted by their declared index order.',
    accent: const Color(0xFFE65100),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFFCC80)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              const Row(
                children: <Widget>[
                  SizedBox(
                    width: 90,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Index',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'When to use',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFFFCC80)),
              const SizedBox(height: 8),
              ...rows.map((Map<String, String> row) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 90,
                          child: Text(
                            row['name']!,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5,
                              color: Color(0xFF1A1F2E),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            row['index']!,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.5,
                              color: Color(0xFF54607A),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            row['when']!,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              color: Color(0xFF2A3046),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF90CAF9)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.lightbulb, color: Color(0xFF1565C0), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Reminder: CollapseMode only affects the BACKGROUND of '
                  'FlexibleSpaceBar. Title behaviour is governed by '
                  'centerTitle, titlePadding, and the bar\'s pinned/floating '
                  'flags — which are independent of CollapseMode.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF1A1F2E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// FOOTER
// =============================================================================

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E).withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF1A237E).withOpacity(0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'End of CollapseMode Deep Demo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'You scrolled through 9 sections covering the conceptual model, '
          'three single-mode showcases, a side-by-side comparison, three '
          'realistic recipes, and an enum reference card.',
          style: TextStyle(
            fontSize: 12,
            height: 1.45,
            color: Color(0xFF2A3046),
          ),
        ),
      ],
    ),
  );
}
