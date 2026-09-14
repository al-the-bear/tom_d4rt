// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - FloatingHeaderSnapConfiguration (rendering)
// =============================================================================
// FloatingHeaderSnapConfiguration is the small data class that controls the
// "snap" animation curve and duration for floating sliver headers in Flutter.
// It is consumed by RenderSliverFloatingPersistentHeader. End users typically
// don't construct it directly: SliverAppBar(floating: true, snap: true) wires
// it up automatically with the default curve (Curves.ease) and 300ms duration.
// Advanced users that build their own SliverPersistentHeaderDelegate can
// override `snapConfiguration` to return a customised instance, but they must
// also provide a `vsync` ticker provider so the floating render object can
// drive the snap animation.
//
// This demo embeds many bounded CustomScrollView widgets so the user can
// scroll inside each section and feel the difference between pinned, floating,
// floating+snap, and custom snap timings.
// =============================================================================
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Note on custom delegates:
// FloatingHeaderSnapConfiguration is declared in
// `package:flutter/rendering.dart`. Importing rendering.dart alongside
// material.dart is not done in this demo (per harness constraints), so the
// "custom snap config" sections below use SliverAppBar(snap: true) and
// describe the underlying FloatingHeaderSnapConfiguration in code snippets
// rather than instantiating a live custom-delegate sliver. This is consistent
// with the typical app-developer workflow: SliverAppBar wires up the snap
// configuration internally, so most users never construct
// FloatingHeaderSnapConfiguration by hand.
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Helper that builds a SliverAppBar-based mini scroll view with a label of
// the snap behavior in use. Used by sections 5, 7 and 8.
// -----------------------------------------------------------------------------
Widget _miniSnapDemo({
  required String label,
  required String hint,
  required Color background,
  required Color foreground,
  required Color tilesColor,
  required int itemCount,
}) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: true,
        snap: true,
        backgroundColor: background,
        foregroundColor: foreground,
        title: Text(label),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            color: background.withOpacity(0.85),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text(
              hint,
              style: TextStyle(color: foreground, fontSize: 11),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _ListTile(index: index, color: tilesColor),
          childCount: itemCount,
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Reusable list tile for inner scroll views.
// -----------------------------------------------------------------------------
class _ListTile extends StatelessWidget {
  const _ListTile({required this.index, required this.color});

  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 14,
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Snap demo content row ${index + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: color),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Reusable section card.
// -----------------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.description,
    required this.color,
    required this.child,
  });

  final String title;
  final String description;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: color.withOpacity(0.06),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(description, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SliverAppBar demo helper.
// -----------------------------------------------------------------------------
Widget _buildSliverAppBarDemo({
  required bool pinned,
  required bool floating,
  required bool snap,
  required String title,
  required Color background,
  required Color tilesColor,
  int itemCount = 30,
}) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: pinned,
        floating: floating,
        snap: snap,
        backgroundColor: background,
        foregroundColor: Colors.white,
        expandedHeight: 120,
        title: Text(title),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [background, background.withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _ListTile(index: index, color: tilesColor),
          childCount: itemCount,
        ),
      ),
    ],
  );
}

// =============================================================================
// HARNESS ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  print('=== FloatingHeaderSnapConfiguration Deep Demo ===');
  print('Demonstrating floating header snap behavior in slivers.');

  // ---------------------------------------------------------------------------
  // Distinct palettes per section
  // ---------------------------------------------------------------------------
  const Color introColor = Color(0xFF1565C0);
  const Color pinnedColor = Color(0xFF6A1B9A);
  const Color floatNoSnapColor = Color(0xFF2E7D32);
  const Color floatSnapColor = Color(0xFFEF6C00);
  const Color customColor = Color(0xFF00838F);
  const Color compareColor = Color(0xFFC2185B);
  const Color durationColor = Color(0xFF5D4037);
  const Color curveColor = Color(0xFF455A64);
  const Color programmaticColor = Color(0xFF7B1FA2);
  const Color recipeFeedColor = Color(0xFFAD1457);
  const Color recipeSearchColor = Color(0xFF00695C);
  const Color decisionColor = Color(0xFF3949AB);
  const Color referenceColor = Color(0xFFB71C1C);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FloatingHeaderSnapConfiguration Deep Demo',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('FloatingHeaderSnapConfiguration'),
        backgroundColor: introColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===============================================================
              // SECTION 1: INTRO CARD
              // ===============================================================
              _SectionCard(
                title: '1. What is FloatingHeaderSnapConfiguration?',
                description:
                    'A small immutable data class consumed by '
                    'RenderSliverFloatingPersistentHeader. It tells the render '
                    'object two things: which Curve to use when snapping, and '
                    'how long the snap animation should last. Defaults are '
                    'Curves.ease and 300ms.',
                color: introColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Constructor (from rendering/sliver_persistent_header.dart):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'FloatingHeaderSnapConfiguration({\n'
                      '  Curve curve = Curves.ease,\n'
                      '  Duration duration = const Duration(milliseconds: 300),\n'
                      '})',
                      style: TextStyle(
                          fontFamily: 'monospace', fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Most users encounter this class indirectly through '
                      'SliverAppBar(floating: true, snap: true). Setting '
                      'snap: true causes the framework to attach a default '
                      'FloatingHeaderSnapConfiguration to the underlying '
                      'render object. Custom delegates can override the '
                      'snapConfiguration getter to provide their own curve '
                      'and duration.',
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 2: PINNED (CONTROL CASE)
              // ===============================================================
              _SectionCard(
                title: '2. Pinned SliverAppBar (control)',
                description:
                    'pinned: true, floating: false. The app bar stays at the '
                    'top of the viewport at all times. There is no snap '
                    'behavior because the bar never floats out of view.',
                color: pinnedColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: _buildSliverAppBarDemo(
                        pinned: true,
                        floating: false,
                        snap: false,
                        title: 'Pinned (no snap)',
                        background: pinnedColor,
                        tilesColor: pinnedColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Try scrolling the inner list: the app bar stays put.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 3: FLOATING WITHOUT SNAP
              // ===============================================================
              _SectionCard(
                title: '3. Floating without snap',
                description:
                    'floating: true, snap: false. The app bar reveals as soon '
                    'as the user scrolls up by even a single pixel, but the '
                    'reveal tracks the scroll gesture 1:1. Releasing the '
                    'gesture leaves the bar partially shown if the user only '
                    'scrolled a little.',
                color: floatNoSnapColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: _buildSliverAppBarDemo(
                        pinned: false,
                        floating: true,
                        snap: false,
                        title: 'Floating (no snap)',
                        background: floatNoSnapColor,
                        tilesColor: floatNoSnapColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Scroll down to hide, then scroll up a tiny bit and '
                      'release: the bar will be partially visible.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 4: FLOATING + SNAP
              // ===============================================================
              _SectionCard(
                title: '4. Floating + snap',
                description:
                    'floating: true, snap: true. As soon as the gesture ends, '
                    'a FloatingHeaderSnapConfiguration animation runs to '
                    'either fully expand or fully collapse the header — no '
                    'partial states. This is the canonical "feed" behavior.',
                color: floatSnapColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: _buildSliverAppBarDemo(
                        pinned: false,
                        floating: true,
                        snap: true,
                        title: 'Floating + snap',
                        background: floatSnapColor,
                        tilesColor: floatSnapColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Scroll down to hide, then drag up a single pixel and '
                      'release: the bar fully snaps into view in 300ms with '
                      'Curves.ease.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 5: CUSTOM SNAP CONFIGURATION
              // ===============================================================
              _SectionCard(
                title: '5. Custom SliverPersistentHeaderDelegate snap',
                description:
                    'A custom SliverPersistentHeaderDelegate returns its own '
                    'FloatingHeaderSnapConfiguration. This requires providing '
                    'a `vsync` TickerProvider so the floating render object '
                    'can drive the animation. The snippet below shows the '
                    'shape; live demos in this harness use SliverAppBar to '
                    'avoid pulling in `package:flutter/rendering.dart`.',
                color: customColor,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: customColor.withOpacity(0.1),
                  child: const Text(
                    '''class MySnappingDelegate extends SliverPersistentHeaderDelegate {
  MySnappingDelegate(this.tickerProvider);
  final TickerProvider tickerProvider;

  @override double get minExtent => 56;
  @override double get maxExtent => 56;
  @override TickerProvider get vsync => tickerProvider;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.easeOutBack,
        duration: const Duration(milliseconds: 600),
      );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(child: Center(child: Text('Custom header')));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

// And then in your CustomScrollView slivers:
SliverPersistentHeader(
  floating: true,
  delegate: MySnappingDelegate(this /* TickerProvider */),
);''',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 6: SIDE-BY-SIDE COMPARISON
              // ===============================================================
              _SectionCard(
                title: '6. Side-by-side: pinned vs floating vs floating+snap',
                description:
                    'Three mini scroll views, one per mode. Scroll each '
                    'independently and feel the difference at the gesture-end '
                    'boundary.',
                color: compareColor,
                child: SizedBox(
                  height: 360,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Pinned',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _buildSliverAppBarDemo(
                                pinned: true,
                                floating: false,
                                snap: false,
                                title: 'P',
                                background: pinnedColor,
                                tilesColor: pinnedColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Floating',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _buildSliverAppBarDemo(
                                pinned: false,
                                floating: true,
                                snap: false,
                                title: 'F',
                                background: floatNoSnapColor,
                                tilesColor: floatNoSnapColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Float+Snap',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _buildSliverAppBarDemo(
                                pinned: false,
                                floating: true,
                                snap: true,
                                title: 'S',
                                background: floatSnapColor,
                                tilesColor: floatSnapColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 7: SNAP DURATION COMPARISON
              // ===============================================================
              _SectionCard(
                title: '7. Snap duration: 100ms vs 1500ms (discussion)',
                description:
                    'SliverAppBar always uses 300ms/Curves.ease for the '
                    'snap. To override, pass a custom delegate as in '
                    'section 5. The two SliverAppBar instances below both '
                    'snap with default timing; what changes is the '
                    'explanatory label, so you can imagine how 100ms vs '
                    '1500ms would feel.',
                color: durationColor,
                child: SizedBox(
                  height: 360,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Imagine 100ms',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _miniSnapDemo(
                                label: 'Fast',
                                hint: 'feels instant',
                                background: durationColor,
                                foreground: Colors.white,
                                tilesColor: durationColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Imagine 1500ms',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _miniSnapDemo(
                                label: 'Slow',
                                hint: 'too slow',
                                background: durationColor,
                                foreground: Colors.white,
                                tilesColor: durationColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 8: SNAP CURVE COMPARISON
              // ===============================================================
              _SectionCard(
                title: '8. Snap curve: linear vs easeOutBack (discussion)',
                description:
                    'SliverAppBar uses Curves.ease internally. The two demos '
                    'below both snap with the default curve; the labels ask '
                    'you to imagine the difference. To actually change the '
                    'curve, drop down to a custom SliverPersistentHeaderDelegate '
                    'and return your own FloatingHeaderSnapConfiguration.',
                color: curveColor,
                child: SizedBox(
                  height: 360,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Imagine linear',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _miniSnapDemo(
                                label: 'Linear',
                                hint: 'mechanical',
                                background: curveColor,
                                foreground: Colors.white,
                                tilesColor: curveColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Imagine easeOutBack',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: _miniSnapDemo(
                                label: 'EOBack',
                                hint: 'playful',
                                background: curveColor,
                                foreground: Colors.white,
                                tilesColor: curveColor,
                                itemCount: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 9: PROGRAMMATIC DISCUSSION
              // ===============================================================
              _SectionCard(
                title: '9. Programmatic snap discussion',
                description:
                    'You can drive the floating header snap from code by '
                    'walking up to the Scrollable position. This is '
                    'discussion-only — the snippet below is not executed by '
                    'this demo because forcing it requires a real gesture '
                    'context.',
                color: programmaticColor,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: programmaticColor.withOpacity(0.1),
                  child: const Text(
                    '''// Inside a widget below a CustomScrollView with a
// floating, snapping SliverAppBar:
final position = Scrollable.of(context).position;
// position is bound to the inner viewport. The framework
// itself calls maybeStartSnapAnimation() on the floating
// render object when the gesture ends. Manual triggers
// are usually unnecessary; instead, animateTo() the
// scroll offset you want and let the snap kick in.
position.animateTo(
  0.0,
  duration: const Duration(milliseconds: 300),
  curve: Curves.ease,
);''',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 10: RECIPE - FEED HEADER
              // ===============================================================
              _SectionCard(
                title: '10. Recipe: feed-style hide-on-down, snap-on-up',
                description:
                    'A common UX pattern: the header hides while the user is '
                    'reading (scrolling down), and snaps back the moment they '
                    'reverse direction. This is exactly what '
                    'SliverAppBar(floating: true, snap: true) provides.',
                color: recipeFeedColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 360,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            floating: true,
                            snap: true,
                            backgroundColor: recipeFeedColor,
                            foregroundColor: Colors.white,
                            title: const Text('My Feed'),
                            actions: [
                              IconButton(
                                icon: const Icon(Icons.notifications),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Post ${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'This is the body of post '
                                        '${index + 1}. Scrolling down hides '
                                        'the app bar; scrolling up brings it '
                                        'back instantly.',
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color:
                                              recipeFeedColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              childCount: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pro tip: keep the snap duration short (≤ 300ms) so the '
                      'header reveal feels responsive to the user gesture.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 11: RECIPE - SEARCH BAR
              // ===============================================================
              _SectionCard(
                title: '11. Recipe: floating search bar',
                description:
                    'A search header that hides while the user reads results, '
                    'and snaps fully back as soon as they want to refine '
                    'their query.',
                color: recipeSearchColor,
                child: SizedBox(
                  height: 360,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        backgroundColor: recipeSearchColor,
                        foregroundColor: Colors.white,
                        toolbarHeight: 64,
                        title: Container(
                          height: 40,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: recipeSearchColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Search results',
                                  style: TextStyle(color: recipeSearchColor),
                                ),
                              ),
                              Icon(Icons.tune, color: recipeSearchColor),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  recipeSearchColor.withOpacity(0.2),
                              child: Text('${index + 1}'),
                            ),
                            title: Text('Result ${index + 1}'),
                            subtitle: const Text(
                                'Matching item description goes here.'),
                            trailing:
                                Icon(Icons.star_border, color: recipeSearchColor),
                          ),
                          childCount: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===============================================================
              // SECTION 12: WHEN FLOATING+SNAP HELPS UX
              // ===============================================================
              _SectionCard(
                title: '12. When does floating+snap help UX?',
                description:
                    'Decision card: pick the right behavior for the right '
                    'screen.',
                color: decisionColor,
                child: Column(
                  children: [
                    _decisionRow(
                      label: 'Long content lists (feeds, search results)',
                      verdict: 'Use floating + snap',
                      color: Colors.green,
                      icon: Icons.thumb_up,
                    ),
                    _decisionRow(
                      label: 'Settings or forms (short, structured)',
                      verdict: 'Use pinned',
                      color: Colors.amber,
                      icon: Icons.lock,
                    ),
                    _decisionRow(
                      label: 'Hero-style content with parallax',
                      verdict: 'Use pinned + flexibleSpace',
                      color: Colors.amber,
                      icon: Icons.image,
                    ),
                    _decisionRow(
                      label: 'Tabbed app (TabBar in app bar)',
                      verdict:
                          'Floating + snap is fine; TabBar can pin separately',
                      color: Colors.green,
                      icon: Icons.tab,
                    ),
                    _decisionRow(
                      label: 'Persistent action bar (e.g., compose button)',
                      verdict: 'Use pinned',
                      color: Colors.red,
                      icon: Icons.warning,
                    ),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 13: REFERENCE TABLE
              // ===============================================================
              _SectionCard(
                title: '13. Reference: properties of FloatingHeaderSnapConfiguration',
                description:
                    'The class is intentionally tiny: two final fields, no '
                    'methods. All variation comes from passing different '
                    'Curve and Duration values.',
                color: referenceColor,
                child: Table(
                  border: TableBorder.all(color: referenceColor.withOpacity(0.3)),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                          color: referenceColor.withOpacity(0.15)),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Property',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Type',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('Default & meaning',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    TableRow(children: const [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('curve'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Curve'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                            'Curves.ease — applied to the snap-in/out animation.'),
                      ),
                    ]),
                    TableRow(children: const [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('duration'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Duration'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                            '300ms — wall-clock length of the snap animation.'),
                      ),
                    ]),
                  ],
                ),
              ),

              // ===============================================================
              // SECTION 14: CLOSING NOTES
              // ===============================================================
              _SectionCard(
                title: '14. Closing notes',
                description:
                    'A few practical reminders that come up when wiring up '
                    'snap behavior in real apps.',
                color: introColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('• snap only works when floating is true.'),
                    SizedBox(height: 4),
                    Text(
                        '• Custom delegates that return a non-null '
                        'snapConfiguration MUST also return a non-null vsync.'),
                    SizedBox(height: 4),
                    Text(
                        '• Keep the snap duration ≤ 300ms for responsive feel.'),
                    SizedBox(height: 4),
                    Text(
                        '• Avoid bouncy curves for very long bars; the '
                        'overshoot can hide content the user is trying to read.'),
                    SizedBox(height: 4),
                    Text(
                        '• SliverAppBar(snap: true) implies floating: true; '
                        'asserting them together is required by the framework.'),
                    SizedBox(height: 4),
                    Text(
                        '• On a SliverPersistentHeader you set floating: true '
                        'on the widget, then return a FloatingHeaderSnapConfiguration '
                        'from the delegate.'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'End of FloatingHeaderSnapConfiguration deep demo.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Decision row helper for section 12.
// -----------------------------------------------------------------------------
Widget _decisionRow({
  required String label,
  required String verdict,
  required Color color,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(label),
        ),
        Expanded(
          flex: 2,
          child: Text(
            verdict,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
