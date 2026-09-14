// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// HeroControllerScope deep demo
// =============================================================================
// HeroControllerScope is the inherited widget that exposes a HeroController to
// any descendant Navigator. The root MaterialApp creates one for you behind
// the scenes; that is why pushing a route on the root Navigator animates Hero
// widgets out of the box. The moment you embed a *secondary* Navigator inside
// your widget tree (for tabs, master-detail panes, dialogs, persistent shells,
// etc.) that nested Navigator gets no HeroController unless you provide one.
//
// You provide one by wrapping the embedded Navigator in
//   HeroControllerScope(controller: HeroController(), child: Navigator(...))
// or, if you specifically want to *suppress* hero animations for a subtree,
//   HeroControllerScope.none(child: Navigator(...))
// which advertises a "no controller" hint so descendants do not climb the
// element tree looking for one.
//
// This file is a hand-authored visual harness that demonstrates every major
// behaviour of HeroControllerScope side by side. Tap the buttons in each card
// to push routes on the *embedded* Navigator and observe whether the hero
// transitions actually animate.
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HeroControllerScope deep demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: const _HeroScopeHarnessShell(),
  );
}

// -----------------------------------------------------------------------------
// Top-level shell
// -----------------------------------------------------------------------------
class _HeroScopeHarnessShell extends StatelessWidget {
  const _HeroScopeHarnessShell();

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeroControllerScope deep demo'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Platform: $platform',
            icon: const Icon(Icons.devices_other_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Detected platform: $platform'),
                  duration: const Duration(milliseconds: 1400),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _IntroAnatomyCard(),
              SizedBox(height: 14),
              _RootMaterialAppScopeCard(),
              SizedBox(height: 14),
              _BrokenNoScopeCard(),
              SizedBox(height: 14),
              _WorkingScopeCard(),
              SizedBox(height: 14),
              _ScopeNoneCard(),
              SizedBox(height: 14),
              _PerTabControllerCard(),
              SizedBox(height: 14),
              _FlightShuttleCard(),
              SizedBox(height: 14),
              _ListToDetailCard(),
              SizedBox(height: 14),
              _TabbedGalleryCard(),
              SizedBox(height: 14),
              _RecipeGalleryCard(),
              SizedBox(height: 14),
              _ControllerLifecycleCard(),
              SizedBox(height: 14),
              _ConstructorComparisonCard(),
              SizedBox(height: 14),
              _PitfallsCard(),
              SizedBox(height: 14),
              _ReferenceTableCard(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Reusable card chrome
// -----------------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderColor = accent ?? scheme.primary;
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor.withOpacity(0.35), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: borderColor.withOpacity(0.08),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.icon = Icons.circle, this.iconSize = 8});
  final String text;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 8),
            child: Icon(icon, size: iconSize),
          ),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. Intro / anatomy diagram
// -----------------------------------------------------------------------------
class _IntroAnatomyCard extends StatelessWidget {
  const _IntroAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '1. What HeroControllerScope is',
      subtitle:
          'Inherited widget that announces a HeroController to descendant Navigators.',
      accent: Colors.indigo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Bullet(
            'A HeroController listens to a Navigator and orchestrates Hero '
            'flights between the routes it pushes/pops.',
          ),
          const _Bullet(
            'A HeroControllerScope is just InheritedWidget plumbing: it lets '
            'a descendant Navigator FIND the controller by walking up the '
            'element tree.',
          ),
          const _Bullet(
            'MaterialApp / CupertinoApp wrap the root Navigator in a '
            'HeroControllerScope automatically, which is why "vanilla" Hero '
            'demos work without ever touching this widget.',
          ),
          const _Bullet(
            'Embedded / nested Navigators do NOT inherit that root '
            'controller. You must wrap them yourself, or no flight occurs.',
          ),
          const _Bullet(
            'HeroControllerScope.none(...) actively *blocks* the search, '
            'preventing nested heroes from binding to an ancestor controller. '
            'Useful for non-visual nested Navigators (state machines, '
            'declarative routers).',
          ),
          const SizedBox(height: 12),
          const _AnatomyDiagram(),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const [
              _Pill('MaterialApp -> implicit scope'),
              _Pill('Embedded Navigator -> needs explicit scope'),
              _Pill('.none -> opt-out'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _DiagramRow(
              level: 0,
              label: 'MaterialApp',
              detail: 'creates root HeroController + scope'),
          _DiagramRow(
              level: 1,
              label: 'Navigator (root)',
              detail: 'inherits scope automatically'),
          _DiagramRow(
              level: 2, label: 'Hero("avatar")', detail: 'works out of the box'),
          _DiagramRow(level: 1, label: 'YourScreen', detail: ''),
          _DiagramRow(
              level: 2, label: 'HeroControllerScope', detail: 'YOU add this'),
          _DiagramRow(
              level: 3,
              label: 'Navigator (embedded)',
              detail: 'now sees the controller'),
          _DiagramRow(
              level: 4,
              label: 'Hero("thumb")',
              detail: 'animates between embedded routes'),
        ],
      ),
    );
  }
}

class _DiagramRow extends StatelessWidget {
  const _DiagramRow(
      {required this.level, required this.label, required this.detail});
  final int level;
  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: 2, bottom: 2),
      child: Row(
        children: [
          const Icon(Icons.subdirectory_arrow_right, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
                fontFamily: 'monospace', fontWeight: FontWeight.w600),
          ),
          if (detail.isNotEmpty) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '— $detail',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Root MaterialApp implicit scope demo
// -----------------------------------------------------------------------------
class _RootMaterialAppScopeCard extends StatelessWidget {
  const _RootMaterialAppScopeCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '2. The root MaterialApp scope is invisible but real',
      subtitle:
          'Pushing on the *root* Navigator already gets a HeroController for free.',
      accent: Colors.teal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'The button below pushes a normal MaterialPageRoute onto the root '
            'Navigator. Notice the avatar circle flying smoothly to the next '
            'screen — that is the implicit HeroControllerScope at work.',
          ),
          const SizedBox(height: 12),
          Center(
            child: Hero(
              tag: 'root-avatar-implicit',
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.teal.shade200,
                  child:
                      const Icon(Icons.person, size: 32, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            icon: const Icon(Icons.open_in_new),
            label: const Text('Push detail on root Navigator'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const _RootImplicitDetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RootImplicitDetailScreen extends StatelessWidget {
  const _RootImplicitDetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root scope detail')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'root-avatar-implicit',
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 96,
                  backgroundColor: Colors.teal.shade400,
                  child:
                      const Icon(Icons.person, size: 80, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No HeroControllerScope was added by hand. MaterialApp\n'
              'wrapped the root Navigator with one for you.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Pop'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Embedded Navigator WITHOUT HeroControllerScope (broken hero)
// -----------------------------------------------------------------------------
class _BrokenNoScopeCard extends StatelessWidget {
  const _BrokenNoScopeCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '3. Embedded Navigator WITHOUT a HeroControllerScope',
      subtitle: 'Hero widgets simply teleport — no flight is choreographed.',
      accent: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'This card hosts its own Navigator inside a 320-pixel-tall window. '
            'There is no HeroControllerScope above it, so when you push the '
            'detail route the heroes are present in both routes but no '
            'animation runs — they appear to cut.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.red.withOpacity(0.05),
                child: Navigator(
                  onGenerateRoute: (settings) => MaterialPageRoute<void>(
                    settings: settings,
                    builder: (_) => const _BrokenListPage(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrokenListPage extends StatelessWidget {
  const _BrokenListPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.withOpacity(0.04),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'No HeroControllerScope above this Navigator. Tap the tile.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Hero(
                tag: 'broken-thumb',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.red.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.warning, color: Colors.white),
                  ),
                ),
              ),
              title: const Text('Broken hero'),
              subtitle: const Text('Will teleport, not animate'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _BrokenDetailPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BrokenDetailPage extends StatelessWidget {
  const _BrokenDetailPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.withOpacity(0.08),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'broken-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.warning,
                      color: Colors.white, size: 64),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Hero teleported, not flew.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. Embedded Navigator WRAPPED in HeroControllerScope (working hero)
// -----------------------------------------------------------------------------
class _WorkingScopeCard extends StatefulWidget {
  const _WorkingScopeCard();

  @override
  State<_WorkingScopeCard> createState() => _WorkingScopeCardState();
}

class _WorkingScopeCardState extends State<_WorkingScopeCard> {
  // Owned controller — disposed in dispose().
  final HeroController _controller = HeroController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '4. Embedded Navigator WRAPPED in HeroControllerScope',
      subtitle: 'Now the same hero tag actually animates inside the card.',
      accent: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Identical Navigator + Hero pair as section 3, but this one is '
            'wrapped in HeroControllerScope(controller: HeroController()). '
            'Tap the tile and watch the rounded square actually FLY across '
            'the embedded surface.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.green.withOpacity(0.05),
                child: HeroControllerScope(
                  controller: _controller,
                  child: Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute<void>(
                      settings: settings,
                      builder: (_) => const _WorkingListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkingListPage extends StatelessWidget {
  const _WorkingListPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.withOpacity(0.04),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'A HeroControllerScope is now wrapping this Navigator. Tap below.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Hero(
                tag: 'working-thumb',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              ),
              title: const Text('Working hero'),
              subtitle: const Text('Will animate'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _WorkingDetailPage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Hero(
                tag: 'working-thumb-2',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.flight, color: Colors.white),
                  ),
                ),
              ),
              title: const Text('Second hero'),
              subtitle: const Text('Different tag, same controller'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _WorkingDetailPage2(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkingDetailPage extends StatelessWidget {
  const _WorkingDetailPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.withOpacity(0.08),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'working-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.green.shade500,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      const Icon(Icons.check, color: Colors.white, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Hero flew correctly.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkingDetailPage2 extends StatelessWidget {
  const _WorkingDetailPage2();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.withOpacity(0.12),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'working-thumb-2',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child:
                      const Icon(Icons.flight, color: Colors.white, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Multiple hero tags share one controller.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5. HeroControllerScope.none — actively suppressing transitions
// -----------------------------------------------------------------------------
class _ScopeNoneCard extends StatelessWidget {
  const _ScopeNoneCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '5. HeroControllerScope.none — opt-out',
      subtitle:
          'Use when a nested Navigator should DELIBERATELY ignore any ancestor controller.',
      accent: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'The .none constructor advertises "there is no controller here". '
            'Descendant Heroes do not climb past this scope, so even if some '
            'outer scope exists, route changes inside it run without flights. '
            'Handy for non-visual or declarative nested Navigators.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.orange.withOpacity(0.05),
                child: HeroControllerScope.none(
                  child: Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute<void>(
                      settings: settings,
                      builder: (_) => const _NoneListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoneListPage extends StatelessWidget {
  const _NoneListPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange.withOpacity(0.05),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'HeroControllerScope.none — heroes are present but inert.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Colors.orange.withOpacity(0.1),
            leading: Hero(
              tag: 'none-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.orange,
                  child: const Icon(Icons.block, color: Colors.white),
                ),
              ),
            ),
            title: const Text('Suppressed hero'),
            subtitle: const Text('No controller, no animation.'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const _NoneDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NoneDetailPage extends StatelessWidget {
  const _NoneDetailPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'none-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 130,
                  height: 130,
                  color: Colors.deepOrange,
                  child:
                      const Icon(Icons.block, color: Colors.white, size: 72),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Hero present, but no flight.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6. Per-tab Navigator with its own HeroController
// -----------------------------------------------------------------------------
class _PerTabControllerCard extends StatefulWidget {
  const _PerTabControllerCard();

  @override
  State<_PerTabControllerCard> createState() => _PerTabControllerCardState();
}

class _PerTabControllerCardState extends State<_PerTabControllerCard>
    with TickerProviderStateMixin {
  late final TabController _tabs;
  final HeroController _ctrlA = HeroController();
  final HeroController _ctrlB = HeroController();

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _ctrlA.dispose();
    _ctrlB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '6. Per-tab Navigator with its own HeroController',
      subtitle:
          'Each tab owns a Navigator + scope so flights stay scoped to that tab.',
      accent: Colors.purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Many apps use a persistent bottom-nav with one Navigator per tab. '
            'You give EACH of those Navigators its own HeroControllerScope so '
            'switching tabs never confuses the controller, and so each tab '
            'can independently animate a hero without waking the others.',
          ),
          const SizedBox(height: 10),
          TabBar(
            controller: _tabs,
            tabs: const [
              Tab(text: 'Tab A'),
              Tab(text: 'Tab B'),
            ],
          ),
          SizedBox(
            height: 320,
            child: TabBarView(
              controller: _tabs,
              children: [
                HeroControllerScope(
                  controller: _ctrlA,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => const _TabHomePage(
                        title: 'Tab A',
                        tag: 'pertab-a',
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                HeroControllerScope(
                  controller: _ctrlB,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => const _TabHomePage(
                        title: 'Tab B',
                        tag: 'pertab-b',
                        color: Colors.deepPurple,
                      ),
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

class _TabHomePage extends StatelessWidget {
  const _TabHomePage(
      {required this.title, required this.tag, required this.color});
  final String title;
  final String tag;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Hero(
              tag: tag,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.shade400,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 48),
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => _TabDetailPage(tag: tag, color: color),
                  ),
                );
              },
              child: const Text('Open detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabDetailPage extends StatelessWidget {
  const _TabDetailPage({required this.tag, required this.color});
  final String tag;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: tag,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: color.shade700,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child:
                      const Icon(Icons.star, color: Colors.white, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Detail for $tag'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 7. Custom flightShuttleBuilder
// -----------------------------------------------------------------------------
class _FlightShuttleCard extends StatefulWidget {
  const _FlightShuttleCard();

  @override
  State<_FlightShuttleCard> createState() => _FlightShuttleCardState();
}

class _FlightShuttleCardState extends State<_FlightShuttleCard> {
  final HeroController _ctrl = HeroController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '7. Custom flightShuttleBuilder during flight',
      subtitle:
          'Override what the user sees mid-flight — independent of source/dest widgets.',
      accent: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'During the flight Flutter normally shows the destination Hero '
            'shape interpolated. With flightShuttleBuilder you can replace '
            'that mid-air widget — for example fading + spinning a different '
            'icon. Tap to see a star spin into a heart.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.blue.withOpacity(0.05),
                child: HeroControllerScope(
                  controller: _ctrl,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => const _ShuttleListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _heartShuttle(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return RotationTransition(
    turns: Tween<double>(begin: 0, end: 1).animate(animation),
    child: FadeTransition(
      opacity: animation,
      child: const Material(
        color: Colors.transparent,
        child: Icon(Icons.favorite, color: Colors.pink, size: 80),
      ),
    ),
  );
}

class _ShuttleListPage extends StatelessWidget {
  const _ShuttleListPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.withOpacity(0.04),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'shuttle',
              flightShuttleBuilder: _heartShuttle,
              child: const Material(
                color: Colors.transparent,
                child: Icon(Icons.star, color: Colors.amber, size: 64),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _ShuttleDetailPage(),
                  ),
                );
              },
              child: const Text('Take flight'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShuttleDetailPage extends StatelessWidget {
  const _ShuttleDetailPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.withOpacity(0.08),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'shuttle',
              flightShuttleBuilder: _heartShuttle,
              child: const Material(
                color: Colors.transparent,
                child: Icon(Icons.star, color: Colors.amber, size: 160),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
                'Custom shuttle replaced the star with a heart mid-flight.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8. List-to-detail card with multiple hero tags
// -----------------------------------------------------------------------------
class _ListToDetailCard extends StatefulWidget {
  const _ListToDetailCard();

  @override
  State<_ListToDetailCard> createState() => _ListToDetailCardState();
}

class _ListToDetailCardState extends State<_ListToDetailCard> {
  final HeroController _ctrl = HeroController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '8. Classic list-to-detail with many hero tags',
      subtitle:
          'A fully embedded master/detail pattern animating thumbnails + titles together.',
      accent: Colors.brown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Each list tile contains TWO hero widgets: the thumbnail and the '
            'title text. Both animate together when you push the detail. '
            'This works because the embedded Navigator is wrapped in '
            'HeroControllerScope.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.brown.withOpacity(0.05),
                child: HeroControllerScope(
                  controller: _ctrl,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => const _ListDetailListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListDetailListPage extends StatelessWidget {
  const _ListDetailListPage();

  static const _items = <_LDItem>[
    _LDItem('apple', 'Red apple', Icons.apple, Colors.red),
    _LDItem('coffee', 'Cup of coffee', Icons.coffee, Colors.brown),
    _LDItem('forest', 'Forest path', Icons.forest, Colors.green),
    _LDItem('beach', 'Sandy beach', Icons.beach_access, Colors.amber),
    _LDItem('rocket', 'Rocket flight', Icons.rocket_launch, Colors.deepPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.brown.withOpacity(0.04),
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 6),
        itemBuilder: (context, i) {
          final item = _items[i];
          return Card(
            child: ListTile(
              leading: Hero(
                tag: 'ld-thumb-${item.id}',
                child: Material(
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundColor: item.color,
                    child: Icon(item.icon, color: Colors.white),
                  ),
                ),
              ),
              title: Hero(
                tag: 'ld-title-${item.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              subtitle: const Text('Tap to open detail'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => _ListDetailDetailPage(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _LDItem {
  const _LDItem(this.id, this.title, this.icon, this.color);
  final String id;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class _ListDetailDetailPage extends StatelessWidget {
  const _ListDetailDetailPage({required this.item});
  final _LDItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'ld-thumb-${item.id}',
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: item.color,
                  child: Icon(item.icon, color: Colors.white, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: 'ld-title-${item.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Two heroes flew at once: the thumbnail circle and the title '
              'string. The HeroControllerScope above the embedded Navigator '
              'is what made both happen at the same time.',
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back to list'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 9. Tabbed gallery — persistent shell, per-tab heroes
// -----------------------------------------------------------------------------
class _TabbedGalleryCard extends StatefulWidget {
  const _TabbedGalleryCard();

  @override
  State<_TabbedGalleryCard> createState() => _TabbedGalleryCardState();
}

class _TabbedGalleryCardState extends State<_TabbedGalleryCard>
    with TickerProviderStateMixin {
  late final TabController _tabs;
  final HeroController _galleryCtrl = HeroController();

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _galleryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '9. Tabbed gallery with a single per-shell controller',
      subtitle:
          'Three tabs feeding into one Navigator that owns one HeroController.',
      accent: Colors.cyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Here the embedded Navigator is OUTSIDE the tab view. The tabs '
            'select which gallery is shown inside the same nested Navigator. '
            'One HeroControllerScope wraps the whole shell, so heroes flying '
            'into detail still animate even though the source widget lives '
            'inside a TabBarView.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 420,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.cyan.withOpacity(0.05),
                child: HeroControllerScope(
                  controller: _galleryCtrl,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => _GalleryShell(tabs: _tabs),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryShell extends StatelessWidget {
  const _GalleryShell({required this.tabs});
  final TabController tabs;

  static const _g1 = <_GalleryItem>[
    _GalleryItem('g-cat', 'Cat', Icons.pets, Colors.orange),
    _GalleryItem('g-dog', 'Dog', Icons.cruelty_free, Colors.brown),
  ];
  static const _g2 = <_GalleryItem>[
    _GalleryItem('g-pizza', 'Pizza', Icons.local_pizza, Colors.red),
    _GalleryItem('g-cake', 'Cake', Icons.cake, Colors.pink),
  ];
  static const _g3 = <_GalleryItem>[
    _GalleryItem('g-bike', 'Bike', Icons.pedal_bike, Colors.green),
    _GalleryItem('g-car', 'Car', Icons.directions_car, Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.cyan.withOpacity(0.04),
      child: Column(
        children: [
          TabBar(controller: tabs, tabs: const [
            Tab(text: 'Pets'),
            Tab(text: 'Food'),
            Tab(text: 'Vehicles'),
          ]),
          Expanded(
            child: TabBarView(
              controller: tabs,
              children: const [
                _GalleryGrid(items: _g1),
                _GalleryGrid(items: _g2),
                _GalleryGrid(items: _g3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryItem {
  const _GalleryItem(this.id, this.title, this.icon, this.color);
  final String id;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid({required this.items});
  final List<_GalleryItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        for (final item in items)
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _GalleryDetailPage(item: item),
                ),
              );
            },
            child: Card(
              color: item.color.withOpacity(0.15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: item.id,
                      child: Material(
                        color: Colors.transparent,
                        child: Icon(item.icon, color: item.color, size: 64),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(item.title),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _GalleryDetailPage extends StatelessWidget {
  const _GalleryDetailPage({required this.item});
  final _GalleryItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: item.id,
              child: Material(
                color: Colors.transparent,
                child: Icon(item.icon, color: item.color, size: 200),
              ),
            ),
            const SizedBox(height: 12),
            Text(item.title,
                style: Theme.of(context).textTheme.headlineMedium),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 10. Recipe gallery — many heroes pushed in sequence
// -----------------------------------------------------------------------------
class _RecipeGalleryCard extends StatefulWidget {
  const _RecipeGalleryCard();

  @override
  State<_RecipeGalleryCard> createState() => _RecipeGalleryCardState();
}

class _RecipeGalleryCardState extends State<_RecipeGalleryCard> {
  final HeroController _ctrl = HeroController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '10. Recipe gallery — staggered hero animations',
      subtitle:
          'Hero, Hero, Hero. Each tile uses different geometry, all animate together.',
      accent: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'A grid of recipe cards. Tapping a card pushes a detail page that '
            'shares THREE heroes: the cover image placeholder, the title, '
            'and the badge. They fly together because all three live under '
            'one HeroControllerScope.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 460,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.pink.withOpacity(0.05),
                child: HeroControllerScope(
                  controller: _ctrl,
                  child: Navigator(
                    onGenerateRoute: (s) => MaterialPageRoute<void>(
                      settings: s,
                      builder: (_) => const _RecipeListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeListPage extends StatelessWidget {
  const _RecipeListPage();

  static const _recipes = <_Recipe>[
    _Recipe('r1', 'Pancakes', 'Quick', Colors.amber),
    _Recipe('r2', 'Lasagna', 'Slow', Colors.red),
    _Recipe('r3', 'Sushi', 'Fresh', Colors.teal),
    _Recipe('r4', 'Curry', 'Spicy', Colors.deepOrange),
    _Recipe('r5', 'Salad', 'Light', Colors.green),
    _Recipe('r6', 'Burger', 'Hearty', Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pink.withOpacity(0.03),
      child: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
        children: [
          for (final r in _recipes)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => _RecipeDetailPage(recipe: r),
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Hero(
                        tag: 'recipe-cover-${r.id}',
                        child: Container(color: r.color.withOpacity(0.4)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Hero(
                          tag: 'recipe-badge-${r.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: r.color,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                r.badge,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Hero(
                          tag: 'recipe-title-${r.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              r.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
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

class _Recipe {
  const _Recipe(this.id, this.title, this.badge, this.color);
  final String id;
  final String title;
  final String badge;
  final MaterialColor color;
}

class _RecipeDetailPage extends StatelessWidget {
  const _RecipeDetailPage({required this.recipe});
  final _Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pink.withOpacity(0.04),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Hero(
                  tag: 'recipe-cover-${recipe.id}',
                  child: Container(color: recipe.color.withOpacity(0.6)),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Hero(
                  tag: 'recipe-badge-${recipe.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: recipe.color,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        recipe.badge,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Hero(
                  tag: 'recipe-title-${recipe.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      recipe.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Three heroes flew together: cover, title, badge. All three '
              'are choreographed by the single HeroController owned by the '
              'wrapping HeroControllerScope.',
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 11. HeroController lifecycle — owning vs leaking
// -----------------------------------------------------------------------------
class _ControllerLifecycleCard extends StatefulWidget {
  const _ControllerLifecycleCard();

  @override
  State<_ControllerLifecycleCard> createState() =>
      _ControllerLifecycleCardState();
}

class _ControllerLifecycleCardState extends State<_ControllerLifecycleCard> {
  HeroController? _ctrl;
  bool _alive = false;
  int _spawnCount = 0;

  void _spawn() {
    setState(() {
      _ctrl?.dispose();
      _ctrl = HeroController();
      _alive = true;
      _spawnCount++;
    });
  }

  void _kill() {
    setState(() {
      _ctrl?.dispose();
      _ctrl = null;
      _alive = false;
    });
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '11. HeroController lifecycle — you own it, you dispose it',
      subtitle:
          'A controller is a Listenable. Always pair it with the State that owns it.',
      accent: Colors.deepOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'HeroController extends NavigatorObserver. The Navigator it is '
            'attached to drives it through push/pop callbacks. If you create '
            'one in initState, dispose it in dispose. Creating a controller '
            'in build() is a common bug: every rebuild leaks one.',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              FilledButton.icon(
                icon: const Icon(Icons.power_settings_new),
                onPressed: _spawn,
                label: const Text('Spawn controller'),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                onPressed: _alive ? _kill : null,
                label: const Text('Dispose controller'),
              ),
              _Pill('Spawn count: $_spawnCount'),
              _Pill(_alive ? 'Alive' : 'Disposed',
                  color: _alive ? Colors.green : Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.deepOrange.withOpacity(0.05),
                child: _alive && _ctrl != null
                    ? HeroControllerScope(
                        controller: _ctrl!,
                        child: Navigator(
                          onGenerateRoute: (s) => MaterialPageRoute<void>(
                            settings: s,
                            builder: (_) => const _LifecycleListPage(),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No controller — spawn one to enable.')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleListPage extends StatelessWidget {
  const _LifecycleListPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepOrange.withOpacity(0.05),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'life-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 64,
                  height: 64,
                  color: Colors.deepOrange,
                  child: const Icon(Icons.bolt, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _LifecycleDetailPage(),
                  ),
                );
              },
              child: const Text('Push detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LifecycleDetailPage extends StatelessWidget {
  const _LifecycleDetailPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepOrange.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'life-thumb',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 160,
                  height: 160,
                  color: Colors.deepOrange.shade400,
                  child: const Icon(Icons.bolt, color: Colors.white, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Same controller across the flight.'),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 12. Constructor comparison
// -----------------------------------------------------------------------------
class _ConstructorComparisonCard extends StatelessWidget {
  const _ConstructorComparisonCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '12. Default constructor vs .none()',
      subtitle:
          'One announces a controller, the other announces "deliberately none".',
      accent: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _ComparisonRow(
            constructor: 'HeroControllerScope(controller: HeroController())',
            meaning:
                'Descendants find this HeroController. Heroes inside the wrapped Navigator animate.',
            color: Colors.green,
          ),
          SizedBox(height: 8),
          _ComparisonRow(
            constructor: 'HeroControllerScope.none(child: ...)',
            meaning:
                'Descendants stop searching. No controller, no flight — ideal for non-visual nested Navigators.',
            color: Colors.orange,
          ),
          SizedBox(height: 8),
          _ComparisonRow(
            constructor: '(no scope at all)',
            meaning:
                'Descendants keep walking up. If they reach the root MaterialApp scope they will use *that* controller — usually wrong for embedded Navigators.',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.constructor,
    required this.meaning,
    required this.color,
  });
  final String constructor;
  final String meaning;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            constructor,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(meaning),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 13. Pitfalls and common mistakes
// -----------------------------------------------------------------------------
class _PitfallsCard extends StatelessWidget {
  const _PitfallsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '13. Pitfalls & common mistakes',
      subtitle: 'What goes wrong, why, and how to fix it.',
      accent: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _Bullet(
            'Embedding a Navigator and forgetting the scope: Heroes appear, '
            'but transitions do not animate — they cut between routes.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
          _Bullet(
            'Building a HeroController inside build(): every rebuild leaks '
            'one. Always create the controller in initState and dispose() it.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
          _Bullet(
            'Sharing one HeroController across multiple Navigators: results '
            'in undefined behaviour. Each Navigator deserves its own.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
          _Bullet(
            'Using HeroControllerScope.none and then wondering why heroes '
            'do not animate. That is precisely what .none means.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
          _Bullet(
            'Wrapping the *root* MaterialApp Navigator with another '
            'HeroControllerScope: redundant; MaterialApp already does it. '
            'Doing it again can create double observers.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
          _Bullet(
            'Mounting the same Hero tag in two simultaneously visible '
            'subtrees under the same controller: ambiguous source/destination, '
            'leads to assertion errors during the flight. Use unique tags or '
            'separate scopes.',
            icon: Icons.error_outline,
            iconSize: 16,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 14. Reference table
// -----------------------------------------------------------------------------
class _ReferenceTableCard extends StatelessWidget {
  const _ReferenceTableCard();

  static const _rows = <List<String>>[
    [
      'controller',
      'Required by default ctor. The HeroController to expose.'
    ],
    [
      'child',
      'Required. Subtree (typically a Navigator) that should see the controller.'
    ],
    [
      'HeroControllerScope.none()',
      'Constructor that announces "deliberately no controller" to descendants.'
    ],
    [
      'HeroControllerScope.of(context)',
      'Static lookup used by Navigator to find the nearest controller.'
    ],
    [
      'lifecycle',
      'You create and dispose the HeroController. The scope itself owns no state.'
    ],
    [
      'placement',
      'Always above the Navigator that should animate heroes.'
    ],
    [
      'platform',
      'Same behaviour on every platform (Theme.of(context).platform unaffected).'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '14. Reference — properties at a glance',
      subtitle: 'Quick API map for HeroControllerScope.',
      accent: Colors.indigo,
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        border: TableBorder.symmetric(
          inside: BorderSide(color: Theme.of(context).dividerColor),
        ),
        children: [
          for (final row in _rows)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(row[1]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
