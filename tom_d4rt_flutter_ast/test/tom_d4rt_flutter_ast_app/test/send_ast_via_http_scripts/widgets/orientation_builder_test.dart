import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// OrientationBuilder Deep Visual Demo
// Entry point required by the d4rt sandbox harness.
// STATELESS only — top-level ValueNotifier<T> + ValueListenableBuilder used
// wherever interactive state is needed.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Top-level state notifiers (stateless-safe, harness-compatible)
// ---------------------------------------------------------------------------
final ValueNotifier<Orientation> _simulatedOrientation =
    ValueNotifier<Orientation>(Orientation.portrait);

final ValueNotifier<int> _activeNavIndex = ValueNotifier<int>(0);
final ValueNotifier<int> _activeTabIndex = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Colour palette used throughout the demo
// ---------------------------------------------------------------------------
const List<Color> _cardColors = <Color>[
  Color(0xFF6750A4),
  Color(0xFF7965AF),
  Color(0xFF3D7DE0),
  Color(0xFF2E9E6C),
  Color(0xFFB5531F),
  Color(0xFFC62828),
  Color(0xFF00796B),
  Color(0xFF6A1B9A),
  Color(0xFF1565C0),
  Color(0xFF558B2F),
  Color(0xFFE65100),
  Color(0xFF4527A0),
];

const List<String> _cardLabels = <String>[
  'Alpha',
  'Beta',
  'Gamma',
  'Delta',
  'Epsilon',
  'Zeta',
  'Eta',
  'Theta',
  'Iota',
  'Kappa',
  'Lambda',
  'Mu',
];

// ---------------------------------------------------------------------------
// Tab labels
// ---------------------------------------------------------------------------
const List<String> _tabLabels = <String>[
  'Hero',
  'Toggle',
  'Grid',
  'Nav',
  'AppBar',
  'Form',
  'vs Layout',
  'MediaQ',
  'Diagram',
  'Use-Cases',
];

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'OrientationBuilder Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
    ),
    home: const _DemoRoot(),
  );
}

// ---------------------------------------------------------------------------
// Root shell
// ---------------------------------------------------------------------------
class _DemoRoot extends StatelessWidget {
  const _DemoRoot();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLabels.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          title: const Text(
            'OrientationBuilder',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: (int i) => _activeTabIndex.value = i,
            tabs: _tabLabels
                .map((String t) => Tab(text: t))
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _ToggleTab(),
            _AdaptiveGridTab(),
            _AdaptiveNavTab(),
            _AdaptiveAppBarTab(),
            _AdaptiveFormTab(),
            _LayoutBuilderComparisonTab(),
            _MediaQueryOrientationTab(),
            _DiagramTab(),
            _UseCasesTab(),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner
// ===========================================================================
class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Gradient banner
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.screen_rotation,
                    size: 56, color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  'OrientationBuilder',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Rebuilds its subtree whenever the device orientation '
                  'switches between portrait and landscape.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // What it is
          _SectionCard(
            icon: Icons.info_outline,
            title: 'What is OrientationBuilder?',
            child: const Text(
              'OrientationBuilder is a Flutter widget that exposes the '
              'current device orientation (portrait or landscape) to its '
              'builder callback, rebuilding automatically whenever the '
              'orientation changes.\n\n'
              'Internally it wraps a LayoutBuilder and compares '
              'constraints.maxWidth against constraints.maxHeight:\n'
              '  • maxWidth ≥ maxHeight  →  Orientation.landscape\n'
              '  • maxWidth  < maxHeight  →  Orientation.portrait\n\n'
              'This makes it purely layout-driven and completely '
              'independent of the device sensor or platform APIs.',
              style: TextStyle(height: 1.6),
            ),
          ),
          const SizedBox(height: 16),

          // Constructor signature
          _SectionCard(
            icon: Icons.code,
            title: 'Constructor Signature',
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(14),
              child: const Text(
                'OrientationBuilder({\n'
                '  Key? key,\n'
                '  required Widget Function(\n'
                '    BuildContext context,\n'
                '    Orientation orientation,\n'
                '  ) builder,\n'
                '})',
                style: TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Difference from MediaQuery
          _SectionCard(
            icon: Icons.compare_arrows,
            title: 'OrientationBuilder vs MediaQuery.of(context).orientation',
            child: Column(
              children: <Widget>[
                _CompareRow(
                  label: 'Trigger',
                  left: 'Layout constraint change\n(LayoutBuilder under the hood)',
                  right: 'Platform sensor / window size\nreported by the OS',
                ),
                const Divider(),
                _CompareRow(
                  label: 'Scope',
                  left: 'Local to the widget subtree;\nindependent of window size',
                  right: 'Global — reflects the whole\napplication window',
                ),
                const Divider(),
                _CompareRow(
                  label: 'Sandboxed',
                  left: 'Works in Flutter web previews,\ntests, and d4rt sandbox',
                  right: 'May return portrait in a\nlandscape-windowed browser tab',
                ),
                const Divider(),
                _CompareRow(
                  label: 'Best for',
                  left: 'Adaptive child widgets that\nneed their own layout context',
                  right: 'Global orientation decisions\n(route, theme, locking)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Key insight callout
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(Icons.lightbulb,
                    color: Theme.of(context).colorScheme.tertiary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Key insight: because OrientationBuilder is built on '
                    'LayoutBuilder, you can wrap a specific panel in it and '
                    'get a different "orientation" result than the full window '
                    '— great for split-screen adaptive layouts.',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onTertiaryContainer,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lifecycle note
          _SectionCard(
            icon: Icons.timeline,
            title: 'Lifecycle',
            child: const Text(
              '1. OrientationBuilder registers with its parent LayoutBuilder.\n'
              '2. On every layout pass, LayoutBuilder delivers BoxConstraints.\n'
              '3. OrientationBuilder derives Orientation from those constraints.\n'
              '4. If orientation changed since last build, it calls builder().\n'
              '5. The resulting widget tree replaces the previous one.',
              style: TextStyle(height: 1.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Simulated Toggle
// ===========================================================================
class _ToggleTab extends StatelessWidget {
  const _ToggleTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Simulated Orientation Toggle',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Because this demo runs in a sandbox (no real device rotation), '
            'we drive orientation via a ValueNotifier<Orientation> and wrap '
            'the demo area in a MediaQuery override so OrientationBuilder '
            'sees the simulated size.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // SegmentedButton toggle
          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait'),
                    icon: Icon(Icons.stay_current_portrait),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape'),
                    icon: Icon(Icons.stay_current_landscape),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) {
                  _simulatedOrientation.value = s.first;
                },
              );
            },
          ),
          const SizedBox(height: 20),

          // Demo viewport driven by MediaQuery override
          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              // Simulated screen sizes
              final Size fakeSize = ori == Orientation.portrait
                  ? const Size(360, 640)
                  : const Size(640, 360);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: ori == Orientation.portrait
                          ? const Color(0xFF1565C0)
                          : const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          ori == Orientation.portrait
                              ? Icons.stay_current_portrait
                              : Icons.stay_current_landscape,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Current: ${ori == Orientation.portrait ? "PORTRAIT" : "LANDSCAPE"}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${fakeSize.width.toInt()} × ${fakeSize.height.toInt()})',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Simulated viewport
                  Center(
                    child: Container(
                      width: fakeSize.width.clamp(0, 500),
                      height: fakeSize.height.clamp(0, 400),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(ctx).colorScheme.primary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: MediaQuery(
                          data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                          child: OrientationBuilder(
                            builder: (BuildContext innerCtx,
                                Orientation innerOri) {
                              return _OrientationViewport(
                                orientation: innerOri,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // How it works explanation
                  _SectionCard(
                    icon: Icons.settings,
                    title: 'How the simulation works',
                    child: const Text(
                      '1. ValueNotifier<Orientation> holds the chosen orientation.\n'
                      '2. SegmentedButton writes to the notifier on tap.\n'
                      '3. ValueListenableBuilder rebuilds when the notifier fires.\n'
                      '4. MediaQuery(...copyWith(size: fakeSize)...) injects a\n'
                      '   synthetic screen size into the subtree.\n'
                      '5. OrientationBuilder\'s inner LayoutBuilder sees that size\n'
                      '   and derives the matching Orientation value.\n'
                      '6. The builder callback receives the correct Orientation\n'
                      '   and renders the appropriate layout.',
                      style: TextStyle(height: 1.6),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Simple viewport content driven by OrientationBuilder
class _OrientationViewport extends StatelessWidget {
  const _OrientationViewport({required this.orientation});
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = orientation == Orientation.landscape;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Container(
      color: isLandscape
          ? cs.primaryContainer
          : cs.secondaryContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isLandscape
                  ? Icons.stay_current_landscape
                  : Icons.stay_current_portrait,
              size: 40,
              color: isLandscape
                  ? cs.onPrimaryContainer
                  : cs.onSecondaryContainer,
            ),
            const SizedBox(height: 10),
            Text(
              isLandscape ? 'LANDSCAPE' : 'PORTRAIT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isLandscape
                    ? cs.onPrimaryContainer
                    : cs.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isLandscape
                  ? 'maxWidth ≥ maxHeight'
                  : 'maxWidth < maxHeight',
              style: TextStyle(
                fontSize: 12,
                color: (isLandscape
                        ? cs.onPrimaryContainer
                        : cs.onSecondaryContainer)
                    .withAlpha(178),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Adaptive Grid
// ===========================================================================
class _AdaptiveGridTab extends StatelessWidget {
  const _AdaptiveGridTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Adaptive Grid Layout',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Portrait → 2 columns.  Landscape → 4 columns.\n'
            'OrientationBuilder drives the crossAxisCount.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          // Toggle for this tab
          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait (2 cols)'),
                    icon: Icon(Icons.view_column),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape (4 cols)'),
                    icon: Icon(Icons.view_module),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) {
                  _simulatedOrientation.value = s.first;
                },
              );
            },
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              final Size fakeSize = ori == Orientation.portrait
                  ? const Size(360, 800)
                  : const Size(800, 360);
              return MediaQuery(
                data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                child: OrientationBuilder(
                  builder: (BuildContext innerCtx, Orientation innerOri) {
                    final int cols =
                        innerOri == Orientation.landscape ? 4 : 2;
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(innerCtx).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Columns: $cols  |  Orientation: '
                            '${innerOri == Orientation.portrait ? "Portrait" : "Landscape"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(innerCtx)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: cols,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: _cardColors.length,
                          itemBuilder: (BuildContext c, int i) {
                            return _GridCard(
                              color: _cardColors[i],
                              label: _cardLabels[i],
                              index: i,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          _SectionCard(
            icon: Icons.code,
            title: 'Code pattern',
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(14),
              child: const Text(
                'OrientationBuilder(\n'
                '  builder: (context, orientation) {\n'
                '    final cols = orientation ==\n'
                '      Orientation.landscape ? 4 : 2;\n'
                '    return GridView.builder(\n'
                '      gridDelegate:\n'
                '        SliverGridDelegateWith\n'
                '          FixedCrossAxisCount(\n'
                '            crossAxisCount: cols,\n'
                '          ),\n'
                '      ...\n'
                '    );\n'
                '  },\n'
                ')',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({
    required this.color,
    required this.label,
    required this.index,
  });
  final Color color;
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 4 — Adaptive Navigation
// ===========================================================================
class _AdaptiveNavTab extends StatelessWidget {
  const _AdaptiveNavTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Adaptive Navigation',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Portrait → BottomNavigationBar.\n'
            'Landscape → NavigationRail (left-side vertical nav).',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait'),
                    icon: Icon(Icons.stay_current_portrait),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape'),
                    icon: Icon(Icons.stay_current_landscape),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) =>
                    _simulatedOrientation.value = s.first,
              );
            },
          ),
          const SizedBox(height: 20),

          // Simulated nav demo
          Container(
            height: 340,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: ValueListenableBuilder<Orientation>(
                valueListenable: _simulatedOrientation,
                builder: (BuildContext ctx, Orientation ori, _) {
                  final Size fakeSize = ori == Orientation.portrait
                      ? const Size(320, 600)
                      : const Size(600, 320);
                  return MediaQuery(
                    data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                    child: OrientationBuilder(
                      builder: (BuildContext innerCtx, Orientation innerOri) {
                        return ValueListenableBuilder<int>(
                          valueListenable: _activeNavIndex,
                          builder: (BuildContext c2, int navIdx, _) {
                            return _NavShell(
                              orientation: innerOri,
                              selectedIndex: navIdx,
                              onDestinationSelected: (int i) =>
                                  _activeNavIndex.value = i,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          _SectionCard(
            icon: Icons.insights,
            title: 'Why NavigationRail in landscape?',
            child: const Text(
              'On wide screens the bottom bar wastes vertical real-estate and '
              'the tap targets become tiny strips. A NavigationRail on the '
              'left reclaims that height for content and mirrors what users '
              'expect from desktop or tablet experiences. '
              'OrientationBuilder is the ideal hook because it reacts to the '
              'exact layout available to this subtree, not the system window.',
              style: TextStyle(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavShell extends StatelessWidget {
  const _NavShell({
    required this.orientation,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Orientation orientation;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const List<NavigationDestination> _destinations =
      <NavigationDestination>[
    NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home'),
    NavigationDestination(
        icon: Icon(Icons.search_outlined),
        selectedIcon: Icon(Icons.search),
        label: 'Search'),
    NavigationDestination(
        icon: Icon(Icons.favorite_border),
        selectedIcon: Icon(Icons.favorite),
        label: 'Saved'),
    NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile'),
  ];

  static const List<String> _pageLabels = <String>[
    'Home Content',
    'Search Results',
    'Saved Items',
    'Profile Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = orientation == Orientation.landscape;
    final Widget content = Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                const <IconData>[
                  Icons.home,
                  Icons.search,
                  Icons.favorite,
                  Icons.person
                ][selectedIndex],
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                _pageLabels[selectedIndex],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                isLandscape
                    ? 'NavigationRail (landscape)'
                    : 'BottomNavigationBar (portrait)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isLandscape) {
      return Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: _destinations
                .map((NavigationDestination d) => NavigationRailDestination(
                      icon: d.icon,
                      selectedIcon: d.selectedIcon,
                      label: Text(d.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          content,
        ],
      );
    }

    return Column(
      children: <Widget>[
        content,
        NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: _destinations,
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 5 — Adaptive AppBar
// ===========================================================================
class _AdaptiveAppBarTab extends StatelessWidget {
  const _AdaptiveAppBarTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Adaptive AppBar',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Portrait → compact AppBar with title + menu icon.\n'
            'Landscape → expanded AppBar with inline action buttons.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait'),
                    icon: Icon(Icons.stay_current_portrait),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape'),
                    icon: Icon(Icons.stay_current_landscape),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) =>
                    _simulatedOrientation.value = s.first,
              );
            },
          ),
          const SizedBox(height: 20),

          Container(
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: ValueListenableBuilder<Orientation>(
                valueListenable: _simulatedOrientation,
                builder: (BuildContext ctx, Orientation ori, _) {
                  final Size fakeSize = ori == Orientation.portrait
                      ? const Size(320, 600)
                      : const Size(600, 320);
                  return MediaQuery(
                    data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                    child: OrientationBuilder(
                      builder: (BuildContext innerCtx, Orientation innerOri) {
                        return _AdaptiveAppBarPreview(
                            orientation: innerOri);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),
          _SectionCard(
            icon: Icons.design_services,
            title: 'Design rationale',
            child: const Text(
              'In portrait mode, horizontal space is limited — a hamburger '
              'menu icon hides secondary actions to keep the bar lean.\n\n'
              'In landscape mode, users gain horizontal width at the cost of '
              'vertical height. Inline action buttons use that extra width '
              'and avoid the extra tap needed to open a menu, making the '
              'interface feel faster and more desktop-like.',
              style: TextStyle(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdaptiveAppBarPreview extends StatelessWidget {
  const _AdaptiveAppBarPreview({required this.orientation});
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = orientation == Orientation.landscape;
    final ColorScheme cs = Theme.of(context).colorScheme;

    final List<Widget> landscapeActions = <Widget>[
      TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.share),
        label: const Text('Share'),
      ),
      TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_border),
        label: const Text('Save'),
      ),
      TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined),
        label: const Text('Edit'),
      ),
    ];

    final List<Widget> portraitActions = <Widget>[
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
        tooltip: 'Menu',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.primaryContainer,
        leading: const Icon(Icons.menu),
        title: Text(
          isLandscape ? 'My App — Landscape' : 'My App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cs.onPrimaryContainer,
          ),
        ),
        actions:
            isLandscape ? landscapeActions : portraitActions,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isLandscape
                  ? Icons.stay_current_landscape
                  : Icons.stay_current_portrait,
              size: 36,
              color: cs.primary,
            ),
            const SizedBox(height: 12),
            Text(
              isLandscape
                  ? 'Inline actions visible'
                  : 'Actions hidden in menu',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — Adaptive Form Layout
// ===========================================================================
class _AdaptiveFormTab extends StatelessWidget {
  const _AdaptiveFormTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Adaptive Form Layout',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Portrait → fields stacked vertically.\n'
            'Landscape → fields arranged in two columns.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait — stacked'),
                    icon: Icon(Icons.view_agenda),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape — 2-col'),
                    icon: Icon(Icons.view_week),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) =>
                    _simulatedOrientation.value = s.first,
              );
            },
          ),
          const SizedBox(height: 20),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              final Size fakeSize = ori == Orientation.portrait
                  ? const Size(360, 720)
                  : const Size(720, 360);
              return MediaQuery(
                data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                child: OrientationBuilder(
                  builder: (BuildContext innerCtx, Orientation innerOri) {
                    return _AdaptiveForm(orientation: innerOri);
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          _SectionCard(
            icon: Icons.tips_and_updates,
            title: 'Form UX insight',
            child: const Text(
              'Landscape keyboards on phones cover roughly half the screen. '
              'A two-column layout compresses the form vertically so more '
              'fields remain visible above the keyboard, reducing the need '
              'to scroll while typing — a significant UX win on small phones.',
              style: TextStyle(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdaptiveForm extends StatelessWidget {
  const _AdaptiveForm({required this.orientation});
  final Orientation orientation;

  static const List<_FieldData> _fields = <_FieldData>[
    _FieldData(label: 'First Name', icon: Icons.person_outline),
    _FieldData(label: 'Last Name', icon: Icons.person_outline),
    _FieldData(label: 'Email', icon: Icons.email_outlined),
    _FieldData(label: 'Phone', icon: Icons.phone_outlined),
    _FieldData(label: 'City', icon: Icons.location_city_outlined),
    _FieldData(label: 'Country', icon: Icons.flag_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = orientation == Orientation.landscape;

    final List<Widget> fieldWidgets = _fields
        .map((_FieldData f) => _FormField(data: f))
        .toList();

    if (isLandscape) {
      // Two-column layout
      final List<Widget> rows = <Widget>[];
      for (int i = 0; i < fieldWidgets.length; i += 2) {
        rows.add(
          Row(
            children: <Widget>[
              Expanded(child: fieldWidgets[i]),
              const SizedBox(width: 12),
              Expanded(
                child: i + 1 < fieldWidgets.length
                    ? fieldWidgets[i + 1]
                    : const SizedBox(),
              ),
            ],
          ),
        );
        if (i + 2 < fieldWidgets.length) {
          rows.add(const SizedBox(height: 12));
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Landscape: two-column form',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ...rows,
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      );
    }

    // Portrait: stacked layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Portrait: stacked form',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        ...fieldWidgets.map((Widget w) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: w,
            )),
        FilledButton(
          onPressed: () {},
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _FieldData {
  const _FieldData({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class _FormField extends StatelessWidget {
  const _FormField({required this.data});
  final _FieldData data;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: data.label,
        prefixIcon: Icon(data.icon),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Comparison with LayoutBuilder
// ===========================================================================
class _LayoutBuilderComparisonTab extends StatelessWidget {
  const _LayoutBuilderComparisonTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'OrientationBuilder vs LayoutBuilder',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'OrientationBuilder is a thin convenience wrapper around '
            'LayoutBuilder. The two panels below show equivalent code.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // Side-by-side code panels
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
              final bool wide = constraints.maxWidth > 500;
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: _OrientationBuilderPanel(context: ctx)),
                    const SizedBox(width: 12),
                    Expanded(child: _LayoutBuilderPanel(context: ctx)),
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  _OrientationBuilderPanel(context: ctx),
                  const SizedBox(height: 12),
                  _LayoutBuilderPanel(context: ctx),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          // Equivalence table
          _SectionCard(
            icon: Icons.table_chart_outlined,
            title: 'Equivalence table',
            child: Table(
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  children: <Widget>[
                    _TableCell(text: 'Aspect', isHeader: true),
                    _TableCell(text: 'OrientationBuilder', isHeader: true),
                    _TableCell(text: 'LayoutBuilder', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Callback param'),
                  _TableCell(text: 'Orientation enum'),
                  _TableCell(text: 'BoxConstraints'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Decision'),
                  _TableCell(text: 'Portrait / Landscape'),
                  _TableCell(text: 'Full constraint set'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Flexibility'),
                  _TableCell(text: 'Binary only'),
                  _TableCell(text: 'Any breakpoint'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Verbosity'),
                  _TableCell(text: 'Less (abstracts logic)'),
                  _TableCell(text: 'More (explicit math)'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Use case'),
                  _TableCell(text: 'Orientation switches'),
                  _TableCell(text: 'Custom breakpoints'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Source of truth callout
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Flutter SDK source (simplified):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'class OrientationBuilder extends StatelessWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    return LayoutBuilder(\n'
                    '      builder: (ctx, constraints) {\n'
                    '        final orientation =\n'
                    '          constraints.maxWidth > constraints.maxHeight\n'
                    '            ? Orientation.landscape\n'
                    '            : Orientation.portrait;\n'
                    '        return builder(ctx, orientation);\n'
                    '      },\n'
                    '    );\n'
                    '  }\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.greenAccent,
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
}

class _OrientationBuilderPanel extends StatelessWidget {
  const _OrientationBuilderPanel({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext outerContext) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(outerContext).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'OrientationBuilder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(outerContext).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'OrientationBuilder(\n'
            '  builder: (ctx, ori) {\n'
            '    return ori ==\n'
            '      Orientation.portrait\n'
            '      ? PortraitWidget()\n'
            '      : LandscapeWidget();\n'
            '  },\n'
            ')',
            style:
                TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          const SizedBox(height: 10),
          // Live demo
          OrientationBuilder(
            builder: (BuildContext ctx, Orientation ori) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Live: ${ori == Orientation.portrait ? "Portrait" : "Landscape"}',
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LayoutBuilderPanel extends StatelessWidget {
  const _LayoutBuilderPanel({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext outerContext) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(outerContext).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'LayoutBuilder (equivalent)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(outerContext).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'LayoutBuilder(\n'
            '  builder: (ctx, bc) {\n'
            '    final isL = bc.maxWidth\n'
            '      >= bc.maxHeight;\n'
            '    return isL\n'
            '      ? LandscapeWidget()\n'
            '      : PortraitWidget();\n'
            '  },\n'
            ')',
            style:
                TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          const SizedBox(height: 10),
          // Live demo
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints bc) {
              final bool isL = bc.maxWidth >= bc.maxHeight;
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Live: ${isL ? "Landscape" : "Portrait"}',
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — MediaQuery.orientation comparison
// ===========================================================================
class _MediaQueryOrientationTab extends StatelessWidget {
  const _MediaQueryOrientationTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'OrientationBuilder vs MediaQuery.orientation',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Both should agree when wrapping the full screen. '
            'This tab demonstrates that alignment and explains when they diverge.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              return SegmentedButton<Orientation>(
                segments: const <ButtonSegment<Orientation>>[
                  ButtonSegment<Orientation>(
                    value: Orientation.portrait,
                    label: Text('Portrait'),
                    icon: Icon(Icons.stay_current_portrait),
                  ),
                  ButtonSegment<Orientation>(
                    value: Orientation.landscape,
                    label: Text('Landscape'),
                    icon: Icon(Icons.stay_current_landscape),
                  ),
                ],
                selected: <Orientation>{ori},
                onSelectionChanged: (Set<Orientation> s) =>
                    _simulatedOrientation.value = s.first,
              );
            },
          ),
          const SizedBox(height: 20),

          ValueListenableBuilder<Orientation>(
            valueListenable: _simulatedOrientation,
            builder: (BuildContext ctx, Orientation ori, _) {
              final Size fakeSize = ori == Orientation.portrait
                  ? const Size(360, 720)
                  : const Size(720, 360);
              return MediaQuery(
                data: MediaQuery.of(ctx).copyWith(size: fakeSize),
                child: Builder(
                  builder: (BuildContext innerCtx) {
                    final Orientation mqOri =
                        MediaQuery.of(innerCtx).orientation;
                    return OrientationBuilder(
                      builder: (BuildContext obCtx, Orientation obOri) {
                        final bool agree = mqOri == obOri;
                        return Column(
                          children: <Widget>[
                            _OrientationReadout(
                              label: 'MediaQuery.of(context).orientation',
                              orientation: mqOri,
                              source: 'MediaQuery',
                            ),
                            const SizedBox(height: 12),
                            _OrientationReadout(
                              label: 'OrientationBuilder builder param',
                              orientation: obOri,
                              source: 'OrientationBuilder',
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: agree
                                    ? const Color(0xFF1B5E20)
                                    : const Color(0xFFB71C1C),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    agree
                                        ? Icons.check_circle
                                        : Icons.warning,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    agree
                                        ? 'They agree: both ${ obOri == Orientation.portrait ? "Portrait" : "Landscape"}'
                                        : 'They DISAGREE — split layout detected',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          _SectionCard(
            icon: Icons.help_outline,
            title: 'When do they diverge?',
            child: const Text(
              '• Split-screen: Each panel occupies part of the screen. '
              'MediaQuery reports the full-screen orientation (landscape), '
              'but OrientationBuilder for a narrow left panel may report portrait.\n\n'
              '• Desktop / Web: The window may be landscape while the app\'s '
              'content column is portrait-shaped.\n\n'
              '• Embedded previews: A widget shown inside a narrow inspector '
              'pane may get portrait constraints while the overall window is landscape.\n\n'
              'In all these cases, OrientationBuilder gives the layout-accurate '
              'answer for that specific widget tree, while MediaQuery gives the '
              'global platform answer.',
              style: TextStyle(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrientationReadout extends StatelessWidget {
  const _OrientationReadout({
    required this.label,
    required this.orientation,
    required this.source,
  });
  final String label;
  final Orientation orientation;
  final String source;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = orientation == Orientation.landscape;
    final Color bg = isLandscape
        ? const Color(0xFF1565C0)
        : const Color(0xFF4527A0);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            isLandscape
                ? Icons.stay_current_landscape
                : Icons.stay_current_portrait,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  source,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11),
                ),
                Text(
                  isLandscape ? 'LANDSCAPE' : 'PORTRAIT',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.white60, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 9 — Diagram (CustomPainter)
// ===========================================================================
class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Portrait ↔ Landscape Diagram',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'CustomPainter renders device outlines with dimension labels '
            'and arrows showing how width and height swap.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 300,
            child: CustomPaint(
              painter: _DeviceDiagramPainter(
                primaryColor: Theme.of(context).colorScheme.primary,
                onSurface: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // How detection works
          _SectionCard(
            icon: Icons.analytics_outlined,
            title: 'How OrientationBuilder detects orientation',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Inside LayoutBuilder, the widget receives BoxConstraints '
                  'from its parent. The single comparison:',
                  style: TextStyle(height: 1.6),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    'final orientation =\n'
                    '  constraints.maxWidth >= constraints.maxHeight\n'
                    '    ? Orientation.landscape\n'
                    '    : Orientation.portrait;',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '• Portrait: height > width → tall and narrow device.\n'
                  '• Landscape: width ≥ height → wide and short device.\n'
                  '• The threshold is exactly width == height (square device → landscape).',
                  style: TextStyle(height: 1.7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Dimension table
          _SectionCard(
            icon: Icons.straighten,
            title: 'Typical dimension examples',
            child: Table(
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(6),
              ),
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  children: const <Widget>[
                    _TableCell(text: 'Scenario', isHeader: true),
                    _TableCell(text: 'Width', isHeader: true),
                    _TableCell(text: 'Height', isHeader: true),
                    _TableCell(text: 'Result', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Phone portrait'),
                  _TableCell(text: '360'),
                  _TableCell(text: '780'),
                  _TableCell(text: 'portrait'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Phone landscape'),
                  _TableCell(text: '780'),
                  _TableCell(text: '360'),
                  _TableCell(text: 'landscape'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Tablet portrait'),
                  _TableCell(text: '768'),
                  _TableCell(text: '1024'),
                  _TableCell(text: 'portrait'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Tablet landscape'),
                  _TableCell(text: '1024'),
                  _TableCell(text: '768'),
                  _TableCell(text: 'landscape'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Square (rare)'),
                  _TableCell(text: '400'),
                  _TableCell(text: '400'),
                  _TableCell(text: 'landscape'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceDiagramPainter extends CustomPainter {
  const _DeviceDiagramPainter({
    required this.primaryColor,
    required this.onSurface,
  });
  final Color primaryColor;
  final Color onSurface;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint framePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Paint fillPaint = Paint()
      ..color = primaryColor.withAlpha(30)
      ..style = PaintingStyle.fill;

    final Paint arrowPaint = Paint()
      ..color = const Color(0xFFE65100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final double cx = size.width / 2;
    final double midY = size.height / 2;

    // --- Portrait device (left half) ---
    const double pW = 70;
    const double pH = 130;
    final double pLeft = cx / 2 - pW / 2;
    final double pTop = midY - pH / 2;

    final RRect portraitRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(pLeft, pTop, pW, pH),
      const Radius.circular(10),
    );
    canvas.drawRRect(portraitRRect, fillPaint);
    canvas.drawRRect(portraitRRect, framePaint);

    // Home button circle
    canvas.drawCircle(
      Offset(pLeft + pW / 2, pTop + pH - 10),
      5,
      framePaint,
    );

    // Speaker
    final RRect speaker1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(pLeft + pW / 2 - 12, pTop + 6, 24, 4),
      const Radius.circular(2),
    );
    canvas.drawRRect(speaker1, framePaint);

    // Width arrow for portrait
    _drawArrow(canvas, arrowPaint,
        Offset(pLeft, pTop - 14), Offset(pLeft + pW, pTop - 14));
    _drawLabel(canvas, tp, onSurface, '${pW.toInt()}px  W',
        Offset(pLeft + pW / 2, pTop - 22));

    // Height arrow for portrait
    _drawArrow(canvas, arrowPaint,
        Offset(pLeft + pW + 12, pTop), Offset(pLeft + pW + 12, pTop + pH));
    _drawLabel(canvas, tp, onSurface, '${pH.toInt()}px\nH',
        Offset(pLeft + pW + 30, midY));

    // Portrait label
    _drawLabel(canvas, tp, primaryColor, 'PORTRAIT\nW < H',
        Offset(pLeft + pW / 2, pTop + pH + 20));

    // --- Landscape device (right half) ---
    const double lW = 130;
    const double lH = 70;
    final double lLeft = cx + cx / 2 - lW / 2;
    final double lTop = midY - lH / 2;

    final RRect landscapeRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(lLeft, lTop, lW, lH),
      const Radius.circular(10),
    );
    canvas.drawRRect(landscapeRRect, fillPaint);
    canvas.drawRRect(landscapeRRect, framePaint);

    // Home button (right side in landscape)
    canvas.drawCircle(
      Offset(lLeft + lW - 10, lTop + lH / 2),
      5,
      framePaint,
    );

    // Speaker (top in landscape)
    final RRect speaker2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(lLeft + 8, lTop + 6, 4, 18),
      const Radius.circular(2),
    );
    canvas.drawRRect(speaker2, framePaint);

    // Width arrow for landscape
    _drawArrow(canvas, arrowPaint,
        Offset(lLeft, lTop - 14), Offset(lLeft + lW, lTop - 14));
    _drawLabel(canvas, tp, onSurface, '${lW.toInt()}px  W',
        Offset(lLeft + lW / 2, lTop - 22));

    // Height arrow for landscape
    _drawArrow(canvas, arrowPaint,
        Offset(lLeft + lW + 12, lTop), Offset(lLeft + lW + 12, lTop + lH));
    _drawLabel(canvas, tp, onSurface, '${lH.toInt()}px H',
        Offset(lLeft + lW + 36, midY));

    // Landscape label
    _drawLabel(canvas, tp, const Color(0xFF2E7D32), 'LANDSCAPE\nW ≥ H',
        Offset(lLeft + lW / 2, lTop + lH + 20));

    // Central arrow between devices
    _drawArrow(
      canvas,
      Paint()
        ..color = const Color(0xFF6750A4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
      Offset(pLeft + pW + 20, midY),
      Offset(lLeft - 20, midY),
    );
    _drawLabel(canvas, tp, const Color(0xFF6750A4), 'rotate',
        Offset(cx, midY - 14));
  }

  void _drawArrow(
      Canvas canvas, Paint paint, Offset from, Offset to) {
    canvas.drawLine(from, to, paint);
    final Offset dir = (to - from) / (to - from).distance;
    const double arrowSize = 7;
    final Offset perp = Offset(-dir.dy, dir.dx);
    canvas.drawLine(
      to,
      to - dir * arrowSize + perp * arrowSize / 2,
      paint,
    );
    canvas.drawLine(
      to,
      to - dir * arrowSize - perp * arrowSize / 2,
      paint,
    );
    // Also draw arrow at from end
    final Offset revDir = -dir;
    canvas.drawLine(
      from,
      from - revDir * arrowSize + perp * arrowSize / 2,
      paint,
    );
    canvas.drawLine(
      from,
      from - revDir * arrowSize - perp * arrowSize / 2,
      paint,
    );
  }

  void _drawLabel(Canvas canvas, TextPainter tp, Color color,
      String text, Offset center) {
    tp.text = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
    tp.layout();
    tp.paint(
      canvas,
      center - Offset(tp.width / 2, tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _DeviceDiagramPainter oldDelegate) =>
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.onSurface != onSurface;
}

// ===========================================================================
// TAB 10 — Use Cases + API Cheat Sheet
// ===========================================================================
class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  static const List<_UseCaseData> _useCases = <_UseCaseData>[
    _UseCaseData(
      icon: Icons.photo_library,
      title: 'Photo Gallery',
      portrait: '2-column grid with tall thumbnails',
      landscape: '4-column grid with wider aspect ratio',
      tip: 'Match grid density to available width for best thumb visibility.',
    ),
    _UseCaseData(
      icon: Icons.navigation,
      title: 'Navigation',
      portrait: 'BottomNavigationBar or NavigationBar',
      landscape: 'NavigationRail or drawer on the side',
      tip: 'Side nav reclaims vertical space for content in landscape.',
    ),
    _UseCaseData(
      icon: Icons.play_circle_outline,
      title: 'Video Player',
      portrait: 'Compact player, description below',
      landscape: 'Full-screen immersive player, controls overlay',
      tip: 'Enter full-screen automatically in landscape for video.',
    ),
    _UseCaseData(
      icon: Icons.map_outlined,
      title: 'Map View',
      portrait: 'Map top, info panel below',
      landscape: 'Map left, info panel right (side-by-side)',
      tip: 'Side panel prevents hiding map content in landscape.',
    ),
    _UseCaseData(
      icon: Icons.sports_esports,
      title: 'Game UI',
      portrait: 'Vertical layout for menus and inventory',
      landscape: 'Full-width game canvas, minimal overlays',
      tip: 'Lock orientation in portrait or landscape per game design.',
    ),
    _UseCaseData(
      icon: Icons.menu_book_outlined,
      title: 'E-Reader',
      portrait: 'Single-page view, larger font, bottom controls',
      landscape: 'Two-page spread (like a real book)',
      tip: 'Two-column text layout in landscape mirrors print reading.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Use Cases + API Cheat Sheet',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Six real-world scenarios where OrientationBuilder is the '
            'right tool, plus the full property reference.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // Use-case cards grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: _useCases.length,
            itemBuilder: (BuildContext ctx, int i) {
              return _UseCaseCard(data: _useCases[i], index: i);
            },
          ),

          const SizedBox(height: 28),

          // API cheat sheet
          Text(
            'API Cheat Sheet',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _SectionCard(
            icon: Icons.api,
            title: 'Constructor & Properties',
            child: Table(
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(6),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  children: const <Widget>[
                    _TableCell(text: 'Property', isHeader: true),
                    _TableCell(text: 'Type', isHeader: true),
                    _TableCell(text: 'Description', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'key'),
                  _TableCell(text: 'Key?'),
                  _TableCell(text: 'Widget identity key (optional)'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'builder'),
                  _TableCell(text: 'OrientationWidgetBuilder'),
                  _TableCell(
                      text: 'Required. Called with (context, orientation)'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _SectionCard(
            icon: Icons.list_alt,
            title: 'Orientation enum values',
            child: Table(
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(6),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  children: const <Widget>[
                    _TableCell(text: 'Value', isHeader: true),
                    _TableCell(text: 'Condition', isHeader: true),
                  ],
                ),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Orientation.portrait'),
                  _TableCell(text: 'maxWidth < maxHeight'),
                ]),
                const TableRow(children: <Widget>[
                  _TableCell(text: 'Orientation.landscape'),
                  _TableCell(text: 'maxWidth >= maxHeight'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _SectionCard(
            icon: Icons.checklist,
            title: 'Quick decision guide',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _BulletItem(
                  text: 'Use OrientationBuilder when you only need '
                      'portrait/landscape — cleaner API.',
                ),
                _BulletItem(
                  text: 'Use LayoutBuilder when you need custom breakpoints '
                      '(e.g., compact < 400px, medium 400–800px, expanded > 800px).',
                ),
                _BulletItem(
                  text: 'Use MediaQuery.of(context).orientation only for '
                      'global decisions (lock rotation, record analytics).',
                ),
                _BulletItem(
                  text: 'In tests and sandboxes, inject a MediaQuery size '
                      'override to simulate rotation without a real device.',
                ),
                _BulletItem(
                  text: 'OrientationBuilder is const-constructible — prefer '
                      'it when the subtree is otherwise constant.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Related widgets
          _SectionCard(
            icon: Icons.widgets_outlined,
            title: 'Related widgets',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const <String>[
                'LayoutBuilder',
                'MediaQuery',
                'AspectRatio',
                'FittedBox',
                'Flex',
                'Wrap',
                'AdaptiveColumn',
                'ConstrainedBox',
                'CustomMultiChildLayout',
              ].map((String w) => Chip(label: Text(w))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.data, required this.index});
  final _UseCaseData data;
  final int index;

  static const List<Color> _palette = <Color>[
    Color(0xFF6750A4),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFB5531F),
    Color(0xFF6A1B9A),
    Color(0xFF00796B),
  ];

  @override
  Widget build(BuildContext context) {
    final Color bg = _palette[index % _palette.length];
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(data.icon, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Portrait',
            style: TextStyle(
                color: Colors.white54, fontSize: 10),
          ),
          Text(
            data.portrait,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          const SizedBox(height: 6),
          const Text(
            'Landscape',
            style: TextStyle(
                color: Colors.white54, fontSize: 10),
          ),
          Text(
            data.landscape,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          const Spacer(),
          Text(
            data.tip,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseData {
  const _UseCaseData({
    required this.icon,
    required this.title,
    required this.portrait,
    required this.landscape,
    required this.tip,
  });
  final IconData icon;
  final String title;
  final String portrait;
  final String landscape;
  final String tip;
}

// ===========================================================================
// Shared helpers
// ===========================================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });
  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style:
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.label,
    required this.left,
    required this.right,
  });
  final String label;
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(left, style: const TextStyle(fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(right,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.text, this.isHeader = false});
  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(text, style: const TextStyle(height: 1.5)),
          ),
        ],
      ),
    );
  }
}
