// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - OverScrollHeaderStretchConfiguration (rendering)
// =============================================================================
// OverScrollHeaderStretchConfiguration controls how a SliverAppBar with
// `stretch: true` reacts when the user over-scrolls past the top of the
// scrollable. It plugs into the sliver protocol via
// RenderSliverPersistentHeader.stretchConfiguration. The two knobs are:
//   - stretchTriggerOffset: how far the user must overscroll before
//     onStretchTrigger fires (default 100.0).
//   - onStretchTrigger: an AsyncCallback that runs once when the threshold
//     is crossed. Useful for pull-to-refresh style hooks.
//
// `stretch: true` requires scroll physics that allow overscroll (such as
// BouncingScrollPhysics on iOS, or an explicitly assigned
// AlwaysScrollableScrollPhysics combined with bouncing physics on Android).
// =============================================================================

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== OverScrollHeaderStretchConfiguration Deep Demo ===');

  // ---------------------------------------------------------------------------
  // Shared notifier for the trigger counter section.
  // ---------------------------------------------------------------------------
  final ValueNotifier<int> triggerCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> refreshCounter = ValueNotifier<int>(0);
  final ValueNotifier<bool> refreshing = ValueNotifier<bool>(false);

  Future<void> bumpTrigger() async {
    triggerCounter.value = triggerCounter.value + 1;
    print('  onStretchTrigger fired -> count=${triggerCounter.value}');
  }

  Future<void> simulateNetworkRefresh() async {
    if (refreshing.value) return;
    refreshing.value = true;
    print('  pull-to-refresh started');
    await Future<void>.delayed(const Duration(milliseconds: 600));
    refreshCounter.value = refreshCounter.value + 1;
    refreshing.value = false;
    print('  pull-to-refresh done -> count=${refreshCounter.value}');
  }

  // ---------------------------------------------------------------------------
  // Helper: build a card-shaped section wrapper.
  // ---------------------------------------------------------------------------
  Widget buildSection({
    required String title,
    required String subtitle,
    required Color accent,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              color: accent.withOpacity(0.12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, height: 1.3),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: a hand-painted gradient + decorative shapes for flexibleSpace.
  // ---------------------------------------------------------------------------
  Widget paintedFlexibleSpace({
    required List<Color> colors,
    required String label,
    IconData icon = Icons.landscape,
  }) {
    return FlexibleSpaceBar(
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          shadows: <Shadow>[
            Shadow(blurRadius: 2, color: Colors.black54, offset: Offset(1, 1)),
          ],
        ),
      ),
      centerTitle: true,
      background: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
          ),
          CustomPaint(painter: _BubblesPainter(accent: colors.last)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: Colors.white70, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Intro card
  // ---------------------------------------------------------------------------
  Widget introCard = buildSection(
    title: '1. Intro: What is overscroll stretch?',
    subtitle:
        'A SliverAppBar with stretch:true grows beyond its expanded height when '
        'the user pulls past the top. Use OverScrollHeaderStretchConfiguration '
        'to choose how much pull is required and what should happen when '
        'the threshold is crossed.',
    accent: Colors.indigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('Where it shines:'),
        SizedBox(height: 4),
        Text('  - Pull-to-refresh style hero headers'),
        Text('  - Delightful elastic feedback on iOS-feel scrollables'),
        Text('  - Hero images that scale slightly under the finger'),
        SizedBox(height: 8),
        Text(
          'Pre-requisites: scroll physics must allow overscroll. '
          'BouncingScrollPhysics() is the canonical choice.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: Baseline - stretch: false
  // ---------------------------------------------------------------------------
  Widget baselineSection = buildSection(
    title: '2. Baseline: stretch: false',
    subtitle:
        'Without stretch:true the SliverAppBar refuses to grow past its '
        'expandedHeight, no matter how hard the user pulls. This is the '
        'control case to compare against.',
    accent: Colors.grey,
    child: SizedBox(
      height: 240,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 120,
              stretch: false,
              backgroundColor: Colors.blueGrey,
              flexibleSpace: paintedFlexibleSpace(
                colors: const <Color>[Color(0xFF455A64), Color(0xFF263238)],
                label: 'Stretchless',
                icon: Icons.lock_outline,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.label_outline),
                    title: Text('Baseline row #$index'),
                    subtitle: const Text('No stretch behavior'),
                  );
                },
                childCount: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: stretch: true with default OverScrollHeaderStretchConfiguration
  // ---------------------------------------------------------------------------
  Widget defaultStretchSection = buildSection(
    title: '3. stretch: true (default OverScrollHeaderStretchConfiguration)',
    subtitle:
        'Adding stretch:true alone gives you elastic growth without any '
        'callback. The default OverScrollHeaderStretchConfiguration uses a '
        'stretchTriggerOffset of 100.0 and a null onStretchTrigger.',
    accent: Colors.deepPurple,
    child: SizedBox(
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 140,
              stretch: true,
              backgroundColor: Colors.deepPurple,
              stretchTriggerOffset: 100.0,
              flexibleSpace: paintedFlexibleSpace(
                colors: const <Color>[Color(0xFF7E57C2), Color(0xFF311B92)],
                label: 'Default stretch',
                icon: Icons.expand_more,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.bookmark_border),
                    title: Text('Default-stretch row #$index'),
                    subtitle: const Text('Pull above to see the elastic grow'),
                  );
                },
                childCount: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: Custom configuration with onStretchTrigger callback + counter
  // ---------------------------------------------------------------------------
  Widget triggerSection = buildSection(
    title: '4. Custom config with onStretchTrigger',
    subtitle:
        'OverScrollHeaderStretchConfiguration(stretchTriggerOffset: 100, '
        'onStretchTrigger: ...) lets you fire a one-shot AsyncCallback when '
        'the user has dragged the header past the trigger offset. Below the '
        'trigger increments a ValueNotifier<int> counter.',
    accent: Colors.teal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 130,
                  stretch: true,
                  backgroundColor: Colors.teal,
                  stretchTriggerOffset: 100.0,
                  onStretchTrigger: bumpTrigger,
                  flexibleSpace: paintedFlexibleSpace(
                    colors: const <Color>[Color(0xFF26A69A), Color(0xFF004D40)],
                    label: 'Trigger header',
                    icon: Icons.notifications_active,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.trending_up),
                        title: Text('Trigger row #$index'),
                        subtitle:
                            const Text('Pull hard above to fire the trigger'),
                      );
                    },
                    childCount: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: triggerCounter,
          builder: (BuildContext context, int count, Widget? _) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.bolt, color: Colors.teal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'onStretchTrigger fired count: $count',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return TextButton(
                        onPressed: () {
                          triggerCounter.value = 0;
                          setState(() {});
                        },
                        child: const Text('Reset'),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: Variations of stretchTriggerOffset (50, 150, 250)
  // ---------------------------------------------------------------------------
  Widget miniStretch(double offset, Color a, Color b, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 100,
                      stretch: true,
                      backgroundColor: a,
                      stretchTriggerOffset: offset,
                      onStretchTrigger: () async {
                        print('  trigger@$offset fired');
                      },
                      flexibleSpace: paintedFlexibleSpace(
                        colors: <Color>[a, b],
                        label: 'off=$offset',
                        icon: Icons.straighten,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext c, int i) {
                          return ListTile(
                            dense: true,
                            title: Text('row $i'),
                          );
                        },
                        childCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget offsetVariationsSection = buildSection(
    title: '5. Varying stretchTriggerOffset',
    subtitle:
        'Smaller offsets are easy to trigger (light pulls fire it). Larger '
        'offsets feel more deliberate but risk being missed by users with '
        'short scroll throws.',
    accent: Colors.orange,
    child: SizedBox(
      height: 260,
      child: Row(
        children: <Widget>[
          miniStretch(50, const Color(0xFFFFA726), const Color(0xFFE65100),
              'offset 50'),
          miniStretch(150, const Color(0xFFFB8C00), const Color(0xFFBF360C),
              'offset 150'),
          miniStretch(250, const Color(0xFFFF7043), const Color(0xFFD84315),
              'offset 250'),
        ],
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: Hero gradient flexibleSpace
  // ---------------------------------------------------------------------------
  Widget heroGradientSection = buildSection(
    title: '6. Hero gradient flexibleSpace',
    subtitle:
        'When stretch fires, the gradient grows with the header. Layered '
        'CustomPaint shapes stretch organically without pixelation.',
    accent: Colors.pink,
    child: SizedBox(
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 160,
              stretch: true,
              backgroundColor: Colors.pink,
              stretchTriggerOffset: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Hero'),
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xFFFF80AB),
                            Color(0xFFAD1457),
                            Color(0xFF4A148C),
                          ],
                        ),
                      ),
                    ),
                    CustomPaint(painter: _RingsPainter(accent: Colors.white)),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext c, int i) {
                  return ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: Text('Hero row #$i'),
                  );
                },
                childCount: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: Parallax-style colored block + Stack overlay
  // ---------------------------------------------------------------------------
  Widget parallaxSection = buildSection(
    title: '7. Parallax block with Stack overlay text',
    subtitle:
        'Using a Stack inside flexibleSpace.background lets you pile a '
        'colored "image" panel, a darkening scrim, and overlay text that all '
        'stretch in unison.',
    accent: Colors.green,
    child: SizedBox(
      height: 270,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 170,
              stretch: true,
              backgroundColor: Colors.green,
              stretchTriggerOffset: 90.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(color: const Color(0xFF1B5E20)),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.55),
                          ],
                        ),
                      ),
                    ),
                    CustomPaint(
                      painter: _MountainsPainter(),
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Mountain getaway',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Pull down to taste the parallax',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext c, int i) {
                  return ListTile(
                    leading: const Icon(Icons.terrain),
                    title: Text('Parallax row #$i'),
                  );
                },
                childCount: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: Combine stretch + floating + pinned
  // ---------------------------------------------------------------------------
  Widget combinedFlagsSection = buildSection(
    title: '8. stretch + floating + pinned',
    subtitle:
        'Stretch pairs cleanly with floating (re-appears as soon as you '
        'scroll up) and pinned (toolbar always visible). All three flags can '
        'coexist on the same SliverAppBar.',
    accent: Colors.blue,
    child: SizedBox(
      height: 280,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              stretch: true,
              floating: true,
              pinned: true,
              backgroundColor: Colors.blue,
              stretchTriggerOffset: 110.0,
              flexibleSpace: paintedFlexibleSpace(
                colors: const <Color>[Color(0xFF42A5F5), Color(0xFF0D47A1)],
                label: 'stretch + floating + pinned',
                icon: Icons.layers,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext c, int i) {
                  return ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: Text('Combined row #$i'),
                    subtitle: const Text('Toolbar pinned, header stretches'),
                  );
                },
                childCount: 18,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: Pull-to-refresh recipe via onStretchTrigger -> Future
  // ---------------------------------------------------------------------------
  Widget refreshRecipeSection = buildSection(
    title: '9. Recipe: pull-to-refresh via onStretchTrigger',
    subtitle:
        'Because onStretchTrigger is an AsyncCallback returning Future<void>, '
        'you can use it to kick off a network call. Show the in-flight state '
        'with a separate ValueListenable.',
    accent: Colors.deepOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 240,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 130,
                  stretch: true,
                  backgroundColor: Colors.deepOrange,
                  stretchTriggerOffset: 100.0,
                  onStretchTrigger: simulateNetworkRefresh,
                  flexibleSpace: paintedFlexibleSpace(
                    colors: const <Color>[
                      Color(0xFFFF8A65),
                      Color(0xFFBF360C),
                    ],
                    label: 'Pull to refresh',
                    icon: Icons.refresh,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext c, int i) {
                      return ListTile(
                        leading: const Icon(Icons.cloud_download_outlined),
                        title: Text('Feed item #$i'),
                        subtitle: const Text('Pull above to refresh'),
                      );
                    },
                    childCount: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: refreshing,
          builder: (BuildContext context, bool busy, Widget? _) {
            return ValueListenableBuilder<int>(
              valueListenable: refreshCounter,
              builder: (BuildContext context, int count, Widget? child) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepOrange.shade200),
                  ),
                  child: Row(
                    children: <Widget>[
                      busy
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_circle_outline,
                              color: Colors.deepOrange),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          busy
                              ? 'Refreshing...'
                              : 'Idle. Refreshes completed: $count',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10: Hero icon that scales with constraints (LayoutBuilder).
  // ---------------------------------------------------------------------------
  Widget scalingIconSection = buildSection(
    title: '10. Recipe: icon that scales as the header stretches',
    subtitle:
        'A LayoutBuilder inside flexibleSpace.background can read the live '
        'constraints and scale a hero icon as the header overscrolls. The '
        'header height grows past expandedHeight, so use that as the floor.',
    accent: Colors.cyan,
    child: SizedBox(
      height: 280,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 160,
              stretch: true,
              backgroundColor: Colors.cyan.shade700,
              stretchTriggerOffset: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xFF80DEEA),
                            Color(0xFF006064),
                          ],
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        const double base = 160.0;
                        final double extra =
                            (constraints.maxHeight - base).clamp(0.0, 160.0);
                        final double scale = 1.0 + (extra / 160.0) * 0.8;
                        return Center(
                          child: Transform.scale(
                            scale: scale,
                            child: const Icon(
                              Icons.flutter_dash,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext c, int i) {
                  return ListTile(
                    leading: const Icon(Icons.flutter_dash),
                    title: Text('Scaling row #$i'),
                  );
                },
                childCount: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: When stretch enhances vs distracts
  // ---------------------------------------------------------------------------
  Widget decisionSection = buildSection(
    title: '11. Decision card: when to stretch',
    subtitle: 'Quick rules of thumb for design and product reviews.',
    accent: Colors.brown,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('Use stretch:true when:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text('  - The header carries a hero asset that benefits from elastic'),
        Text('    feedback (photos, illustrations, brand panels).'),
        Text('  - You want a tactile pull-to-refresh moment.'),
        Text('  - Users are on iOS or you have explicitly enabled bouncing.'),
        SizedBox(height: 10),
        Text('Avoid stretch:true when:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text('  - The header is purely chrome with text and icons.'),
        Text('  - You use ClampingScrollPhysics (no overscroll to feed it).'),
        Text('  - Performance-critical lists where extra paints hurt.'),
        Text('  - The trigger callback would surprise users (no visual hint).'),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12: Reference table
  // ---------------------------------------------------------------------------
  Widget referenceRow(String name, String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.indigo,
              ),
            ),
          ),
          Expanded(
            child: Text(description, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget referenceSection = buildSection(
    title: '12. Reference table',
    subtitle: 'OverScrollHeaderStretchConfiguration parameters at a glance.',
    accent: Colors.blueGrey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        referenceRow(
          'stretchTriggerOffset',
          'double',
          'How far the user must overscroll past the expanded height before '
              'onStretchTrigger fires. Defaults to 100.0 logical pixels.',
        ),
        referenceRow(
          'onStretchTrigger',
          'AsyncCallback?',
          'A Future<void> Function() that runs once when the threshold is '
              'crossed. May be null. Useful for pull-to-refresh hooks.',
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            'Sliver protocol: RenderSliverPersistentHeader exposes a '
            'stretchConfiguration field. SliverAppBar synthesises an instance '
            'when stretch:true is set, forwarding stretchTriggerOffset and '
            'onStretchTrigger from its constructor.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose the page.
  // ---------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'OverScrollHeaderStretchConfiguration Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('OverScrollHeaderStretchConfiguration'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              introCard,
              baselineSection,
              defaultStretchSection,
              triggerSection,
              offsetVariationsSection,
              heroGradientSection,
              parallaxSection,
              combinedFlagsSection,
              refreshRecipeSection,
              scalingIconSection,
              decisionSection,
              referenceSection,
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'End of demo. Pull each mini scroll view above to see the '
                  'OverScrollHeaderStretchConfiguration in action.',
                  textAlign: TextAlign.center,
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

// =============================================================================
// CustomPainter: scattered translucent bubbles for hero gradients.
// =============================================================================
class _BubblesPainter extends CustomPainter {
  _BubblesPainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.10)
      ..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final List<Offset> centers = <Offset>[
      Offset(size.width * 0.15, size.height * 0.30),
      Offset(size.width * 0.80, size.height * 0.20),
      Offset(size.width * 0.45, size.height * 0.55),
      Offset(size.width * 0.92, size.height * 0.75),
      Offset(size.width * 0.05, size.height * 0.80),
      Offset(size.width * 0.65, size.height * 0.85),
    ];
    final List<double> radii = <double>[24, 36, 18, 28, 22, 30];
    for (int i = 0; i < centers.length; i++) {
      canvas.drawCircle(centers[i], radii[i], paint);
      canvas.drawCircle(centers[i], radii[i], stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblesPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

// =============================================================================
// CustomPainter: concentric rings for hero gradient panels.
// =============================================================================
class _RingsPainter extends CustomPainter {
  _RingsPainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint stroke = Paint()
      ..color = accent.withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    for (int i = 1; i <= 6; i++) {
      canvas.drawCircle(center, i * 18.0, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

// =============================================================================
// CustomPainter: a flat mountain silhouette for the parallax hero.
// =============================================================================
class _MountainsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint back = Paint()
      ..color = const Color(0xFF2E7D32).withOpacity(0.85)
      ..style = PaintingStyle.fill;
    final Paint front = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.fill;

    final Path backPath = Path()
      ..moveTo(0, size.height * 0.75)
      ..lineTo(size.width * 0.20, size.height * 0.45)
      ..lineTo(size.width * 0.40, size.height * 0.65)
      ..lineTo(size.width * 0.60, size.height * 0.40)
      ..lineTo(size.width * 0.85, size.height * 0.55)
      ..lineTo(size.width, size.height * 0.50)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, back);

    final Path frontPath = Path()
      ..moveTo(0, size.height * 0.90)
      ..lineTo(size.width * 0.15, size.height * 0.70)
      ..lineTo(size.width * 0.35, size.height * 0.85)
      ..lineTo(size.width * 0.55, size.height * 0.60)
      ..lineTo(size.width * 0.75, size.height * 0.80)
      ..lineTo(size.width, size.height * 0.72)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontPath, front);
  }

  @override
  bool shouldRepaint(covariant _MountainsPainter oldDelegate) => false;
}
