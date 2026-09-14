// Deep visual demo: Expansible - the building-block primitive under ExpansionTile.
// Authored manually. STATELESS ONLY. Top-level ValueNotifiers + ExpansibleControllers
// drive expansion state without any StatefulWidget in this file.
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Top-level state. Read by the stateless widget tree below.
// ═══════════════════════════════════════════════════════════════════════════

final ExpansibleController _basicController = ExpansibleController();
final ExpansibleController _headerPlainController = ExpansibleController();
final ExpansibleController _headerGradientController = ExpansibleController();
final ExpansibleController _headerIconController = ExpansibleController();
final ExpansibleController _bodyListController = ExpansibleController();
final ExpansibleController _bodyGridController = ExpansibleController();
final ExpansibleController _bodyRichController = ExpansibleController();
final ExpansibleController _layoutStackController = ExpansibleController();
final ExpansibleController _layoutSideController = ExpansibleController();
final ExpansibleController _durationController = ExpansibleController();
final ValueNotifier<Duration> _selectedDuration = ValueNotifier<Duration>(const Duration(milliseconds: 300));
final ValueNotifier<Curve> _selectedCurve = ValueNotifier<Curve>(Curves.easeInOut);
final List<ExpansibleController> _groupControllers =
    List<ExpansibleController>.generate(4, (_) => ExpansibleController());

void _toggle(ExpansibleController c) => c.isExpanded ? c.collapse() : c.expand();

// ═══════════════════════════════════════════════════════════════════════════
// Entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _DemoApp();

class _DemoApp extends StatelessWidget {
  const _DemoApp();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.35),
        ),
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('Expansible - Deep Visual Demo'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.rocket_launch_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Basic'),
              Tab(icon: Icon(Icons.view_headline), text: 'Headers'),
              Tab(icon: Icon(Icons.view_agenda_outlined), text: 'Bodies'),
              Tab(icon: Icon(Icons.dashboard_customize_outlined), text: 'Layout'),
              Tab(icon: Icon(Icons.speed_outlined), text: 'Timing'),
              Tab(icon: Icon(Icons.group_work_outlined), text: 'Group'),
              Tab(icon: Icon(Icons.account_tree_outlined), text: 'Mechanism'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(children: <Widget>[
          _HeroTab(), _BasicTab(), _HeadersTab(), _BodiesTab(), _LayoutTab(),
          _TimingTab(), _GroupTab(), _MechanismTab(), _CompareApiTab(),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.child});
  final String title; final String subtitle; final Widget child;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: 20), child,
      ]),
    );
  }
}

class _Explainer extends StatelessWidget {
  const _Explainer({required this.icon, required this.title, required this.body});
  final IconData icon; final String title; final String body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: scheme.onSecondaryContainer),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onSecondaryContainer)),
          const SizedBox(height: 4),
          Text(body, style: TextStyle(color: scheme.onSecondaryContainer, height: 1.35)),
        ])),
      ]),
    );
  }
}

class _TapHeader extends StatelessWidget {
  const _TapHeader({required this.controller, required this.animation, required this.title, required this.subtitle, required this.leading});
  final ExpansibleController controller; final Animation<double> animation;
  final String title; final String subtitle; final IconData leading;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _toggle(controller),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: <Widget>[
          Icon(leading, color: scheme.primary),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 2),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          ])),
          RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
            child: Icon(Icons.expand_more, color: scheme.primary),
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 1: Hero
// ═══════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Meet Expansible',
      subtitle: 'The building-block primitive that powers ExpansionTile, ExpansionPanel, and any custom collapsible surface you design.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[scheme.primary, scheme.tertiary]),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: scheme.onPrimary.withAlpha(32), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.unfold_more, color: scheme.onPrimary, size: 32),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text('Expansible', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: scheme.onPrimary, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Stateful primitive. Stateless by your design.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimary.withAlpha(220))),
              ])),
            ]),
            const SizedBox(height: 16),
            Text(
              'ExpansionTile is opinionated: Material list-tile look, dropdown chevron, fixed paddings. Expansible is the same engine without any of that. You provide headerBuilder, bodyBuilder, and an ExpansibleController to drive the animation.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onPrimary.withAlpha(230), height: 1.45),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        Row(children: const <Widget>[
          Expanded(child: _HeroBullet(icon: Icons.tune, title: 'Total control', body: 'You build header and body. Expansible only owns the clip-and-size animation.')),
          SizedBox(width: 12),
          Expanded(child: _HeroBullet(icon: Icons.settings_remote, title: 'Controller-driven', body: 'ExpansibleController.expand / collapse toggles state externally.')),
          SizedBox(width: 12),
          Expanded(child: _HeroBullet(icon: Icons.layers, title: 'Composable', body: 'expansibleBuilder lets you arrange header and body freely.')),
        ]),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.info_outline, title: 'Mental model',
          body: 'Expansible is to ExpansionTile what RawGestureDetector is to GestureDetector. It is the unstyled core. Everything visible on screen is your callback. The only thing Expansible owns is the height-factor animation driven by an AnimationController bound to the controller you pass in.',
        ),
      ]),
    );
  }
}

class _HeroBullet extends StatelessWidget {
  const _HeroBullet({required this.icon, required this.title, required this.body});
  final IconData icon; final String title; final String body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(14), border: Border.all(color: scheme.outlineVariant)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: scheme.primary),
        const SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(body, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.35)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 2: Basic
// ═══════════════════════════════════════════════════════════════════════════

class _BasicTab extends StatelessWidget {
  const _BasicTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: '2. Basic usage',
      subtitle: 'A single Expansible with one ExpansibleController. External buttons drive controller.expand(), controller.collapse(), and a toggle. The body is a colorful gradient card.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        AnimatedBuilder(
          animation: _basicController,
          builder: (BuildContext ctx, Widget? _) => Row(children: <Widget>[
            FilledButton.icon(
              onPressed: _basicController.isExpanded ? null : _basicController.expand,
              icon: const Icon(Icons.unfold_more), label: const Text('Expand'),
            ),
            const SizedBox(width: 10),
            FilledButton.tonalIcon(
              onPressed: _basicController.isExpanded ? _basicController.collapse : null,
              icon: const Icon(Icons.unfold_less), label: const Text('Collapse'),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: () => _toggle(_basicController),
              icon: const Icon(Icons.swap_vert), label: const Text('Toggle'),
            ),
            const SizedBox(width: 14),
            _StatePill(isExpanded: _basicController.isExpanded),
          ]),
        ),
        const SizedBox(height: 18),
        Material(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Expansible(
            controller: _basicController,
            headerBuilder: (BuildContext ctx, Animation<double> a) => _TapHeader(
              controller: _basicController, animation: a,
              title: 'Release notes - v2.8.1',
              subtitle: 'Tap the header or use the buttons above.',
              leading: Icons.campaign_outlined,
            ),
            bodyBuilder: (BuildContext ctx, Animation<double> a) => _GradientBody(animation: a),
          ),
        ),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.lightbulb_outline, title: 'What is happening',
          body: 'Expansible owns an AnimationController. When you call controller.expand() / collapse() the internal animation runs forward or reverse. The animation is passed to headerBuilder and bodyBuilder so any caller widget can listen. The body is wrapped in ClipRect + Align(heightFactor: t).',
        ),
      ]),
    );
  }
}

class _StatePill extends StatelessWidget {
  const _StatePill({required this.isExpanded});
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color bg = isExpanded ? scheme.primaryContainer : scheme.tertiaryContainer;
    final Color fg = isExpanded ? scheme.onPrimaryContainer : scheme.onTertiaryContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(isExpanded ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: fg),
        const SizedBox(width: 6),
        Text('isExpanded = $isExpanded', style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _GradientBody extends StatelessWidget {
  const _GradientBody({required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[scheme.primaryContainer, scheme.tertiaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text('What shipped today', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimaryContainer)),
            const SizedBox(height: 10),
            for (final String line in const <String>[
              'Expansible is now the canonical primitive.',
              'ExpansionTile rebuilds on top of it with no behavior change.',
              'You can replace the chevron, paddings, and even the layout.',
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Icon(Icons.check, size: 18, color: scheme.onPrimaryContainer),
                  const SizedBox(width: 8),
                  Expanded(child: Text(line, style: TextStyle(color: scheme.onPrimaryContainer))),
                ]),
              ),
          ]),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 3: Custom header builders
// ═══════════════════════════════════════════════════════════════════════════

class _HeadersTab extends StatelessWidget {
  const _HeadersTab();
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '3. Custom headerBuilder',
      subtitle: 'Three Expansibles share the same body but demonstrate dramatically different headers. Everything above the fold is headerBuilder output.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        _HeaderVariant(label: 'Variant A - plain text header',
          note: 'Bare Text wrapped in a tap target. Closest thing to ExpansionTile default.',
          controller: _headerPlainController,
          headerBuilder: (BuildContext ctx, Animation<double> a) => _PlainHeader(controller: _headerPlainController, animation: a)),
        const SizedBox(height: 18),
        _HeaderVariant(label: 'Variant B - gradient pill',
          note: 'Full-bleed gradient with a chevron rotating on animation.value.',
          controller: _headerGradientController,
          headerBuilder: (BuildContext ctx, Animation<double> a) => _GradientPillHeader(controller: _headerGradientController, animation: a)),
        const SizedBox(height: 18),
        _HeaderVariant(label: 'Variant C - icon + badge',
          note: 'Decorated leading circle and a badge that scales with the animation.',
          controller: _headerIconController,
          headerBuilder: (BuildContext ctx, Animation<double> a) => _IconBadgeHeader(controller: _headerIconController, animation: a)),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.palette_outlined, title: 'Rule of thumb',
          body: 'headerBuilder receives the animation. Anything that should visually react to expansion (chevron rotation, color tween, badge scale) reads animation.value via RotationTransition, ScaleTransition, or AnimatedBuilder.',
        ),
      ]),
    );
  }
}

class _HeaderVariant extends StatelessWidget {
  const _HeaderVariant({required this.label, required this.note, required this.controller, required this.headerBuilder});
  final String label; final String note;
  final ExpansibleController controller; final ExpansibleComponentBuilder headerBuilder;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
            const SizedBox(height: 4),
            Text(note, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          ]),
        ),
        Expansible(
          controller: controller,
          headerBuilder: headerBuilder,
          bodyBuilder: (BuildContext ctx, Animation<double> a) => _SharedHeaderBody(animation: a),
        ),
      ]),
    );
  }
}

class _PlainHeader extends StatelessWidget {
  const _PlainHeader({required this.controller, required this.animation});
  final ExpansibleController controller; final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggle(controller),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(children: <Widget>[
          const Expanded(child: Text('Plain text header', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
          RotationTransition(turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation), child: const Icon(Icons.expand_more)),
        ]),
      ),
    );
  }
}

class _GradientPillHeader extends StatelessWidget {
  const _GradientPillHeader({required this.controller, required this.animation});
  final ExpansibleController controller; final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _toggle(controller),
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[scheme.primary, scheme.secondary]),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(children: <Widget>[
          Icon(Icons.auto_awesome, color: scheme.onPrimary),
          const SizedBox(width: 10),
          Expanded(child: Text('Gradient pill header', style: TextStyle(color: scheme.onPrimary, fontSize: 16, fontWeight: FontWeight.w600))),
          RotationTransition(turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation), child: Icon(Icons.expand_more, color: scheme.onPrimary)),
        ]),
      ),
    );
  }
}

class _IconBadgeHeader extends StatelessWidget {
  const _IconBadgeHeader({required this.controller, required this.animation});
  final ExpansibleController controller; final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _toggle(controller),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: <Widget>[
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: scheme.tertiaryContainer, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.inbox_outlined, color: scheme.onTertiaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('Icon + badge header', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text('ScaleTransition lives inside the header.', style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
          ])),
          ScaleTransition(
            scale: Tween<double>(begin: 0.6, end: 1.0).animate(animation),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(999)),
              child: Text('12 new', style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SharedHeaderBody extends StatelessWidget {
  const _SharedHeaderBody({required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
          child: Text(
            'The body is identical across all three variants. Only the headerBuilder changed. Expansible does not care what the header looks like - it just wants a Widget.',
            style: TextStyle(color: scheme.onSurface, height: 1.4),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 4: Custom body builders
// ═══════════════════════════════════════════════════════════════════════════

class _BodiesTab extends StatelessWidget {
  const _BodiesTab();
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '4. Custom bodyBuilder',
      subtitle: 'bodyBuilder is just a Widget factory. The body is clipped and Aligned by Expansible, but its content is entirely yours.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        _BodyVariant(label: 'Variant A - list of items', controller: _bodyListController, titleText: 'Recent activity',
          bodyBuilder: (BuildContext ctx, Animation<double> a) => _ListBody(animation: a)),
        const SizedBox(height: 18),
        _BodyVariant(label: 'Variant B - grid of chips', controller: _bodyGridController, titleText: 'Apply filters',
          bodyBuilder: (BuildContext ctx, Animation<double> a) => _ChipGridBody(animation: a)),
        const SizedBox(height: 18),
        _BodyVariant(label: 'Variant C - rich text block', controller: _bodyRichController, titleText: 'Release notes',
          bodyBuilder: (BuildContext ctx, Animation<double> a) => _RichTextBody(animation: a)),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.article_outlined, title: 'Body anatomy',
          body: 'Expansible wraps bodyBuilder output in Offstage + TickerMode + ClipRect + Align(heightFactor: t). Your body can be any widget tree - Wrap, Grid, bounded ListView, CustomPaint - and Expansible handles the vertical reveal.',
        ),
      ]),
    );
  }
}

class _BodyVariant extends StatelessWidget {
  const _BodyVariant({required this.label, required this.controller, required this.titleText, required this.bodyBuilder});
  final String label; final ExpansibleController controller;
  final String titleText; final ExpansibleComponentBuilder bodyBuilder;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        ),
        Expansible(
          controller: controller,
          headerBuilder: (BuildContext ctx, Animation<double> a) => _TapHeader(
            controller: controller, animation: a, title: titleText,
            subtitle: 'Tap to reveal.', leading: Icons.folder_open,
          ),
          bodyBuilder: bodyBuilder,
        ),
      ]),
    );
  }
}

class _ListBody extends StatelessWidget {
  const _ListBody({required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(IconData, String, String)> rows = <(IconData, String, String)>[
      (Icons.commit, 'Merged PR #4021', '2h ago'),
      (Icons.bug_report_outlined, 'Fixed layout glitch', '4h ago'),
      (Icons.rocket_launch, 'Deployed v2.8.1', 'yesterday'),
      (Icons.people_outline, 'Invited 3 collaborators', '2d ago'),
      (Icons.description_outlined, 'Updated release notes', '3d ago'),
    ];
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(children: <Widget>[
          for (final (IconData icon, String title, String whenText) in rows)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: scheme.outlineVariant)),
              child: Row(children: <Widget>[
                Icon(icon, color: scheme.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(title)),
                Text(whenText, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
              ]),
            ),
        ]),
      ),
    );
  }
}

class _ChipGridBody extends StatelessWidget {
  const _ChipGridBody({required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<String> labels = <String>[
      'Flutter', 'Dart', 'Material', 'Animations', 'Rendering',
      'Widgets', 'State', 'Gestures', 'Theming', 'Accessibility',
    ];
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          for (int i = 0; i < labels.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: i.isEven ? scheme.primaryContainer : scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(labels[i], style: TextStyle(
                color: i.isEven ? scheme.onPrimaryContainer : scheme.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              )),
            ),
        ]),
      ),
    );
  }
}

class _RichTextBody extends StatelessWidget {
  const _RichTextBody({required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text('# Release 2.8.1', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'This release graduates Expansible from experimental to stable. It also deprecates the ad-hoc duration / curve arguments in favor of a single animationStyle.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: 12),
            Text('## Highlights', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
            const SizedBox(height: 6),
            for (final String bullet in const <String>[
              '- Expansible.expansibleBuilder now receives the live animation.',
              '- ExpansibleController exposes a controller.of lookup.',
              '- Offstage body always keeps its page-storage key.',
            ])
              Text(bullet, style: const TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.4)),
            const SizedBox(height: 10),
            Text(
              '> Upgrade notes: pass animationStyle: AnimationStyle.noAnimation to match the old duration:Duration.zero behavior.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: scheme.onSurfaceVariant),
            ),
          ]),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 5: expansibleBuilder layout variations
// ═══════════════════════════════════════════════════════════════════════════

class _LayoutTab extends StatelessWidget {
  const _LayoutTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: '5. expansibleBuilder - arrange header + body',
      subtitle: 'Override expansibleBuilder to place header and body however you like. The default stacks them in a Column; here are two alternatives.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text('Variant 1 - stacked with an animated separator bar',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
          clipBehavior: Clip.antiAlias,
          child: Expansible(
            controller: _layoutStackController,
            headerBuilder: (BuildContext ctx, Animation<double> a) => _TapHeader(
              controller: _layoutStackController, animation: a,
              title: 'Project configuration', subtitle: 'Header | accent bar | body.',
              leading: Icons.tune,
            ),
            bodyBuilder: (BuildContext ctx, Animation<double> a) => FadeTransition(
              opacity: a,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'The body is below an animated accent bar whose opacity tracks the expansion animation. The custom expansibleBuilder injects that bar between the header and body.',
                  style: TextStyle(color: scheme.onSurface, height: 1.4),
                ),
              ),
            ),
            expansibleBuilder: (BuildContext ctx, Widget header, Widget body, Animation<double> a) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                header,
                FadeTransition(
                  opacity: a,
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[scheme.primary, scheme.tertiary]),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                body,
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text('Variant 2 - side-by-side header and body',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        const SizedBox(height: 8),
        Text(
          'expansibleBuilder can lay out any way. Here header and body share a Row. The body still animates height; when fully collapsed only the header column is visible.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
          clipBehavior: Clip.antiAlias,
          child: Expansible(
            controller: _layoutSideController,
            headerBuilder: (BuildContext ctx, Animation<double> a) => InkWell(
              onTap: () => _toggle(_layoutSideController),
              child: Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(Icons.layers, color: scheme.onPrimaryContainer),
                  const SizedBox(height: 10),
                  Text('Side header', style: Theme.of(ctx).textTheme.titleMedium?.copyWith(color: scheme.onPrimaryContainer)),
                  const SizedBox(height: 4),
                  Text('Tap me', style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 12)),
                  const SizedBox(height: 12),
                  RotationTransition(
                    turns: Tween<double>(begin: 0.0, end: 0.25).animate(a),
                    child: Icon(Icons.chevron_right, color: scheme.onPrimaryContainer),
                  ),
                ]),
              ),
            ),
            bodyBuilder: (BuildContext ctx, Animation<double> a) => FadeTransition(
              opacity: a,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: scheme.surface,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  for (final (String head, String body) in const <(String, String)>[
                    ('Scene 1', 'Header is a fixed-width sidebar.'),
                    ('Scene 2', 'Body expands horizontally within the Row slot.'),
                    ('Scene 3', 'Height is still animated as children grow.'),
                  ]) ...<Widget>[
                    Text(head, style: Theme.of(ctx).textTheme.titleSmall?.copyWith(color: scheme.primary)),
                    const SizedBox(height: 2),
                    Text(body, style: TextStyle(color: scheme.onSurface)),
                    const SizedBox(height: 10),
                  ],
                ]),
              ),
            ),
            expansibleBuilder: (BuildContext ctx, Widget header, Widget body, Animation<double> a) => IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[header, Expanded(child: body)]),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.auto_fix_high, title: 'expansibleBuilder callback',
          body: 'Signature: Widget Function(BuildContext, Widget header, Widget body, Animation<double>). The default returns Column([header, body]). Return any widget that includes both - Stack, Row, LayoutBuilder, RepaintBoundary.',
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 6: Duration + curve chooser
// ═══════════════════════════════════════════════════════════════════════════

class _TimingTab extends StatelessWidget {
  const _TimingTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(String, Duration)> durations = <(String, Duration)>[
      ('120 ms (snappy)', Duration(milliseconds: 120)),
      ('300 ms (default)', Duration(milliseconds: 300)),
      ('900 ms (lazy)', Duration(milliseconds: 900)),
    ];
    const List<(String, Curve)> curves = <(String, Curve)>[
      ('linear', Curves.linear), ('easeIn', Curves.easeIn), ('easeOut', Curves.easeOut),
      ('easeInOut', Curves.easeInOut), ('bounceOut', Curves.bounceOut), ('elasticOut', Curves.elasticOut),
    ];
    return _Section(
      title: '6. Duration + curve chooser',
      subtitle: 'Pick a duration and a curve. Tap Expand below - Expansible rebuilds with the chosen animationStyle. Picking values while collapsed makes the difference most visible.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text('Duration', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        const SizedBox(height: 6),
        ValueListenableBuilder<Duration>(
          valueListenable: _selectedDuration,
          builder: (BuildContext ctx, Duration value, Widget? _) => Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
            for (final (String label, Duration d) in durations)
              _Pill(label: label, selected: value == d, onTap: () => _selectedDuration.value = d),
          ]),
        ),
        const SizedBox(height: 18),
        Text('Curve', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        const SizedBox(height: 6),
        ValueListenableBuilder<Curve>(
          valueListenable: _selectedCurve,
          builder: (BuildContext ctx, Curve value, Widget? _) => Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
            for (final (String label, Curve c) in curves)
              _Pill(label: label, selected: value == c, onTap: () => _selectedCurve.value = c),
          ]),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _durationController,
          builder: (BuildContext ctx, Widget? _) => Row(children: <Widget>[
            FilledButton.icon(
              onPressed: _durationController.isExpanded ? null : _durationController.expand,
              icon: const Icon(Icons.play_arrow), label: const Text('Expand'),
            ),
            const SizedBox(width: 10),
            FilledButton.tonalIcon(
              onPressed: _durationController.isExpanded ? _durationController.collapse : null,
              icon: const Icon(Icons.stop), label: const Text('Collapse'),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<Duration>(
          valueListenable: _selectedDuration,
          builder: (BuildContext ctx, Duration duration, Widget? _) => ValueListenableBuilder<Curve>(
            valueListenable: _selectedCurve,
            builder: (BuildContext ctx, Curve curve, Widget? _) => Container(
              decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
              clipBehavior: Clip.antiAlias,
              child: Expansible(
                key: ValueKey<String>('timing-${duration.inMilliseconds}-${curve.hashCode}'),
                controller: _durationController,
                animationStyle: AnimationStyle(duration: duration, curve: curve),
                headerBuilder: (BuildContext ctx, Animation<double> a) => _TapHeader(
                  controller: _durationController, animation: a,
                  title: 'Animated with chosen style',
                  subtitle: 'duration=${duration.inMilliseconds}ms, curve=${curve.runtimeType}',
                  leading: Icons.timer_outlined,
                ),
                bodyBuilder: (BuildContext ctx, Animation<double> a) => _TimingBody(animation: a, duration: duration, curve: curve),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const _Explainer(icon: Icons.speed, title: 'animationStyle vs duration/curve',
          body: 'The deprecated duration, curve, and reverseCurve parameters still work, but animationStyle is current. AnimationStyle.noAnimation short-circuits the animation - handy for snapshot tests.',
        ),
      ]),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.selected, required this.onTap});
  final String label; final bool selected; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: selected ? scheme.onPrimary : scheme.onSurfaceVariant, size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: selected ? scheme.onPrimary : scheme.onSurface, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class _TimingBody extends StatelessWidget {
  const _TimingBody({required this.animation, required this.duration, required this.curve});
  final Animation<double> animation; final Duration duration; final Curve curve;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text('Live animation readout', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext ctx, Widget? _) {
            final double t = animation.value;
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              _KV(label: 'animation.value', value: t.toStringAsFixed(3)),
              _KV(label: 'curve(t)', value: curve.transform(t.clamp(0.0, 1.0)).toStringAsFixed(3)),
              _KV(label: 'duration', value: '${duration.inMilliseconds} ms'),
              const SizedBox(height: 8),
              Container(
                height: 10,
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(6)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: t.clamp(0.0, 1.0),
                  child: Container(decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(6))),
                ),
              ),
            ]);
          },
        ),
      ]),
    );
  }
}

class _KV extends StatelessWidget {
  const _KV({required this.label, required this.value});
  final String label; final String value;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: <Widget>[
        SizedBox(width: 140, child: Text(label, style: TextStyle(color: scheme.onSurfaceVariant))),
        Text(value, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 7: Multiple controllers + group operations
// ═══════════════════════════════════════════════════════════════════════════

class _GroupTab extends StatelessWidget {
  const _GroupTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(IconData, String, String)> items = <(IconData, String, String)>[
      (Icons.code, 'Code review', 'Every controller is independent. Expanding one does not touch any other.'),
      (Icons.bug_report_outlined, 'Issues', 'Expand-all and collapse-all iterate the List<ExpansibleController>.'),
      (Icons.rocket_launch_outlined, 'Deployment', 'Each Expansible has its own controller, so you can persist, lift, or stream state.'),
      (Icons.settings_outlined, 'Preferences', 'This is essentially how ExpansionPanelList works: a list of Expansibles + List<bool>.'),
    ];
    return _Section(
      title: '7. Multiple controllers',
      subtitle: 'Four Expansibles each with their own ExpansibleController. Group operations iterate the list and call expand or collapse on every controller.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        _GroupBar(controllers: _groupControllers),
        const SizedBox(height: 16),
        for (int i = 0; i < items.length; i++) ...<Widget>[
          Container(
            decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(14), border: Border.all(color: scheme.outlineVariant)),
            clipBehavior: Clip.antiAlias,
            child: Expansible(
              controller: _groupControllers[i],
              headerBuilder: (BuildContext ctx, Animation<double> a) => _GroupHeader(
                controller: _groupControllers[i], animation: a,
                index: i + 1, icon: items[i].$1, title: items[i].$2,
              ),
              bodyBuilder: (BuildContext ctx, Animation<double> a) => FadeTransition(
                opacity: a,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(items[i].$3, style: TextStyle(color: scheme.onSurface, height: 1.4)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 10),
        const _Explainer(icon: Icons.groups_outlined, title: 'Group operations',
          body: 'Since ExpansibleController is a ChangeNotifier, you can build an aggregator that listens to all controllers and derives a group-level isAllExpanded bool. Or, like this demo, iterate and call expand() on each.',
        ),
      ]),
    );
  }
}

class _GroupBar extends StatelessWidget {
  const _GroupBar({required this.controllers});
  final List<ExpansibleController> controllers;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(controllers),
      builder: (BuildContext ctx, Widget? _) {
        final int expanded = controllers.where((ExpansibleController c) => c.isExpanded).length;
        final bool allExpanded = expanded == controllers.length;
        final bool allCollapsed = expanded == 0;
        return Row(children: <Widget>[
          FilledButton.icon(
            onPressed: allExpanded ? null : () { for (final ExpansibleController c in controllers) { c.expand(); } },
            icon: const Icon(Icons.unfold_more), label: const Text('Expand all'),
          ),
          const SizedBox(width: 10),
          FilledButton.tonalIcon(
            onPressed: allCollapsed ? null : () { for (final ExpansibleController c in controllers) { c.collapse(); } },
            icon: const Icon(Icons.unfold_less), label: const Text('Collapse all'),
          ),
          const SizedBox(width: 10),
          OutlinedButton.icon(
            onPressed: () { for (final ExpansibleController c in controllers) { _toggle(c); } },
            icon: const Icon(Icons.swap_vert), label: const Text('Toggle all'),
          ),
          const SizedBox(width: 14),
          _StatusDots(controllers: controllers),
        ]);
      },
    );
  }
}

class _StatusDots extends StatelessWidget {
  const _StatusDots({required this.controllers});
  final List<ExpansibleController> controllers;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(children: <Widget>[
      for (int i = 0; i < controllers.length; i++) ...<Widget>[
        Container(
          width: 12, height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controllers[i].isExpanded ? scheme.primary : scheme.surfaceContainerHighest,
            border: Border.all(color: scheme.outlineVariant),
          ),
        ),
        if (i < controllers.length - 1) const SizedBox(width: 4),
      ],
    ]);
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.controller, required this.animation, required this.index, required this.icon, required this.title});
  final ExpansibleController controller; final Animation<double> animation;
  final int index; final IconData icon; final String title;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _toggle(controller),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(children: <Widget>[
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: scheme.primaryContainer, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('$index', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: scheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
          RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
            child: Icon(Icons.expand_more, color: scheme.primary),
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 8: Mechanism diagram (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════════

class _MechanismTab extends StatelessWidget {
  const _MechanismTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: '8. Internal mechanism',
      subtitle: 'A tap on the header calls controller.expand or collapse. That toggles an internal AnimationController. When the animation ticks, headerBuilder and bodyBuilder are re-invoked with the live Animation<double>.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          height: 360,
          decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(20), border: Border.all(color: scheme.outlineVariant)),
          padding: const EdgeInsets.all(14),
          child: CustomPaint(
            painter: _MechPainter(
              primary: scheme.primary, secondary: scheme.secondary, tertiary: scheme.tertiary,
              onSurface: scheme.onSurface, outline: scheme.outlineVariant, surface: scheme.surface,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 18),
        Row(children: const <Widget>[
          Expanded(child: _Step(index: '1', title: 'User input', body: 'Tap on headerBuilder output invokes controller.expand() or collapse().')),
          SizedBox(width: 10),
          Expanded(child: _Step(index: '2', title: 'Controller notifies', body: 'ExpansibleController flips _isExpanded and notifyListeners() fires.')),
        ]),
        const SizedBox(height: 10),
        Row(children: const <Widget>[
          Expanded(child: _Step(index: '3', title: 'Animation runs', body: '_ExpansibleState calls forward() or reverse() on the AnimationController.')),
          SizedBox(width: 10),
          Expanded(child: _Step(index: '4', title: 'Rebuilds', body: 'AnimatedBuilder wraps everything; each tick re-invokes headerBuilder and bodyBuilder.')),
        ]),
      ]),
    );
  }
}

class _MechPainter extends CustomPainter {
  _MechPainter({required this.primary, required this.secondary, required this.tertiary, required this.onSurface, required this.outline, required this.surface});
  final Color primary; final Color secondary; final Color tertiary;
  final Color onSurface; final Color outline; final Color surface;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = outline;
    final Paint fill = Paint()..style = PaintingStyle.fill..color = surface;
    final Paint arrow = Paint()..color = secondary..style = PaintingStyle.stroke..strokeWidth = 2;
    final double w = size.width; final double h = size.height;
    final Rect header = Rect.fromLTWH(w * 0.10, h * 0.08, w * 0.32, h * 0.18);
    final Rect ctrl = Rect.fromLTWH(w * 0.58, h * 0.08, w * 0.32, h * 0.18);
    final Rect anim = Rect.fromLTWH(w * 0.58, h * 0.48, w * 0.32, h * 0.18);
    final Rect body = Rect.fromLTWH(w * 0.10, h * 0.72, w * 0.80, h * 0.20);

    void drawBox(Rect r, String title, String sub, Color stripeColor) {
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(14));
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);
      canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(r.left, r.top, 6, r.height),
          topLeft: const Radius.circular(14), bottomLeft: const Radius.circular(14)),
        Paint()..color = stripeColor,
      );
      _text(canvas, title, Offset(r.left + 14, r.top + 10), color: onSurface, weight: FontWeight.w700, size: 14);
      _text(canvas, sub, Offset(r.left + 14, r.top + 32), color: onSurface.withAlpha(200), size: 12);
    }

    drawBox(header, 'headerBuilder', 'Tap target + optional chevron', primary);
    drawBox(ctrl, 'ExpansibleController', 'expand() / collapse()', tertiary);
    drawBox(anim, 'AnimationController', 'forward / reverse', secondary);
    drawBox(body, 'bodyBuilder', 'Wrapped in Align(heightFactor: t)', primary);

    _arrow(canvas, arrow, Offset(header.right, header.center.dy), Offset(ctrl.left, ctrl.center.dy), 'tap');
    _arrow(canvas, arrow, Offset(ctrl.center.dx, ctrl.bottom), Offset(anim.center.dx, anim.top), 'listener');
    _arrow(canvas, arrow, Offset(anim.left, anim.center.dy), Offset(body.right, body.top), 'Animation<double>');
    _arrow(canvas, arrow, Offset(anim.left - 10, anim.top), Offset(header.right, header.bottom), 'rebuild');

    _text(canvas, 'Expansible internal data flow', Offset(w / 2 - 110, h * 0.38), color: onSurface, size: 15, weight: FontWeight.w700);

    final Rect boundary = Rect.fromLTWH(w * 0.04, h * 0.02, w * 0.92, h * 0.64);
    _dashRect(canvas, boundary, Paint()..style = PaintingStyle.stroke..strokeWidth = 1.2..color = primary);
    _text(canvas, '  _ExpansibleState  ', Offset(boundary.left + 12, boundary.top - 8),
      color: primary, size: 11, weight: FontWeight.w700, bg: surface);
  }

  void _text(Canvas canvas, String s, Offset at, {required Color color, double size = 12, FontWeight weight = FontWeight.w400, Color? bg}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: s, style: TextStyle(color: color, fontSize: size, fontWeight: weight, backgroundColor: bg)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  void _arrow(Canvas canvas, Paint paint, Offset start, Offset end, String label) {
    canvas.drawLine(start, end, paint);
    final double angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
    const double headLen = 10;
    final Offset p1 = Offset(end.dx - headLen * math.cos(angle - math.pi / 7), end.dy - headLen * math.sin(angle - math.pi / 7));
    final Offset p2 = Offset(end.dx - headLen * math.cos(angle + math.pi / 7), end.dy - headLen * math.sin(angle + math.pi / 7));
    final Path path = Path()..moveTo(end.dx, end.dy)..lineTo(p1.dx, p1.dy)..lineTo(p2.dx, p2.dy)..close();
    canvas.drawPath(path, Paint()..style = PaintingStyle.fill..color = paint.color);
    _text(canvas, label, Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2 - 14),
      color: paint.color, size: 11, weight: FontWeight.w600);
  }

  void _dashRect(Canvas canvas, Rect rect, Paint paint) {
    const double dash = 6; const double gap = 4;
    for (double x = rect.left; x < rect.right; x += dash + gap) {
      canvas.drawLine(Offset(x, rect.top), Offset(math.min(x + dash, rect.right), rect.top), paint);
      canvas.drawLine(Offset(x, rect.bottom), Offset(math.min(x + dash, rect.right), rect.bottom), paint);
    }
    for (double y = rect.top; y < rect.bottom; y += dash + gap) {
      canvas.drawLine(Offset(rect.left, y), Offset(rect.left, math.min(y + dash, rect.bottom)), paint);
      canvas.drawLine(Offset(rect.right, y), Offset(rect.right, math.min(y + dash, rect.bottom)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MechPainter old) =>
    old.primary != primary || old.secondary != secondary || old.tertiary != tertiary ||
    old.onSurface != onSurface || old.outline != outline || old.surface != surface;
}

class _Step extends StatelessWidget {
  const _Step({required this.index, required this.title, required this.body});
  final String index; final String title; final String body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(14), border: Border.all(color: scheme.outlineVariant)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(index, style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
        ]),
        const SizedBox(height: 8),
        Text(body, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.4)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 9: Comparison + API cheat sheet
// ═══════════════════════════════════════════════════════════════════════════

class _CompareApiTab extends StatelessWidget {
  const _CompareApiTab();
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '9. Comparison and API cheat sheet',
      subtitle: 'How Expansible relates to higher-level widgets, and every parameter you can pass to it.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _Compare(), SizedBox(height: 22), _ApiSheet(),
      ]),
    );
  }
}

class _Compare extends StatelessWidget {
  const _Compare();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      <String>['Feature', 'Expansible', 'ExpansionTile', 'ExpansionPanelList', 'AnimatedCrossFade'],
      <String>['Material styling', 'None - you draw it', 'ListTile + chevron', 'Card list look', 'None'],
      <String>['Expansion owner', 'ExpansibleController', 'Internal or initiallyExpanded', 'Callbacks', 'crossFadeState'],
      <String>['Header customization', 'Total (headerBuilder)', 'Partial (title/leading/trailing)', 'Partial (headerBuilder)', 'N/A'],
      <String>['Layout customization', 'Total (expansibleBuilder)', 'Fixed Column', 'Fixed panel', 'layoutBuilder'],
      <String>['Animation type', 'Height Align + your fade', 'Same (uses Expansible)', 'Height + divider', 'Cross-fade of two widgets'],
      <String>['State shape', 'bool on controller', 'Internal', 'List<bool>', 'enum CrossFadeState'],
      <String>['Best when', 'Custom collapsible surface', 'Material list item', 'Accordion list', 'Swap two alternatives'],
    ];
    return Container(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          color: scheme.primaryContainer,
          child: Row(children: <Widget>[
            Icon(Icons.compare_arrows, color: scheme.onPrimaryContainer),
            const SizedBox(width: 8),
            Text('Expansible vs ExpansionTile vs ExpansionPanelList vs AnimatedCrossFade',
              style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
          ]),
        ),
        for (int i = 0; i < rows.length; i++)
          _CompareRow(cells: rows[i], isHeader: i == 0, isLast: i == rows.length - 1),
      ]),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.cells, this.isHeader = false, this.isLast = false});
  final List<String> cells; final bool isHeader; final bool isLast;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextStyle? label = Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);
    final TextStyle? cell = Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface, height: 1.35);
    final TextStyle? expansible = cell?.copyWith(color: scheme.primary, fontWeight: FontWeight.w600);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isHeader ? scheme.surfaceContainerHighest : null,
        border: Border(bottom: BorderSide(color: isLast ? Colors.transparent : scheme.outlineVariant)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(flex: 3, child: Text(cells[0], style: label)),
        Expanded(flex: 4, child: Text(cells[1], style: expansible)),
        Expanded(flex: 4, child: Text(cells[2], style: cell)),
        Expanded(flex: 4, child: Text(cells[3], style: cell)),
        Expanded(flex: 4, child: Text(cells[4], style: cell)),
      ]),
    );
  }
}

class _ApiSheet extends StatelessWidget {
  const _ApiSheet();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(String, String, String, bool)> ctor = <(String, String, String, bool)>[
      ('controller', 'ExpansibleController', 'Required. External source of truth. Drives expand/collapse and notifies listeners.', false),
      ('headerBuilder', 'Widget Function(BuildContext, Animation<double>)', 'Required. Builds the always-visible part. Usually a tap target calling controller.expand/collapse.', false),
      ('bodyBuilder', 'Widget Function(BuildContext, Animation<double>)', 'Required. Builds the collapsible part. Wrapped in ClipRect + Align(heightFactor: t).', false),
      ('expansibleBuilder', 'Widget Function(BuildContext, Widget header, Widget body, Animation<double>)?', 'Optional. Default stacks header and body in a Column. Override for custom layouts.', false),
      ('animationStyle', 'AnimationStyle?', 'Preferred way to override duration, curve, and reverseCurve in one shot.', false),
      ('duration', 'Duration', 'Default 200 ms. DEPRECATED - prefer animationStyle.duration.', true),
      ('curve', 'Curve', 'Default Curves.ease. DEPRECATED - prefer animationStyle.curve.', true),
      ('reverseCurve', 'Curve?', 'Defaults to curve. DEPRECATED - prefer animationStyle.reverseCurve.', true),
      ('maintainState', 'bool', 'Default true. If false the body is removed from the tree when collapsed.', false),
    ];
    const List<(String, String, String, bool)> ctrl = <(String, String, String, bool)>[
      ('isExpanded', 'bool (getter)', 'True between expand() and collapse(). Does not wait for the animation to finish.', false),
      ('expand()', 'void', 'Sets state to expanded and fires listeners. Not safe to call during build.', false),
      ('collapse()', 'void', 'Sets state to collapsed and fires listeners. Not safe to call during build.', false),
      ('addListener / removeListener', 'inherited from ChangeNotifier', 'React to expand/collapse without rebuilding. Pair with AnimatedBuilder.', false),
      ('ExpansibleController.of(context)', 'ExpansibleController', 'Walks up to the enclosing Expansible. Throws if none found.', false),
      ('ExpansibleController.maybeOf(context)', 'ExpansibleController?', 'Same as .of but returns null instead of throwing.', false),
    ];
    return Container(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: scheme.outlineVariant)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          color: scheme.primaryContainer,
          child: Row(children: <Widget>[
            Icon(Icons.menu_book, color: scheme.onPrimaryContainer),
            const SizedBox(width: 8),
            Text('API cheat sheet', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
          ]),
        ),
        _ApiHeader(text: 'Expansible constructor', scheme: scheme),
        for (int i = 0; i < ctor.length; i++)
          _ApiRow(name: ctor[i].$1, type: ctor[i].$2, notes: ctor[i].$3, deprecated: ctor[i].$4),
        _ApiHeader(text: 'ExpansibleController methods', scheme: scheme),
        for (int i = 0; i < ctrl.length; i++)
          _ApiRow(name: ctrl[i].$1, type: ctrl[i].$2, notes: ctrl[i].$3, deprecated: ctrl[i].$4, isLast: i == ctrl.length - 1),
      ]),
    );
  }
}

class _ApiHeader extends StatelessWidget {
  const _ApiHeader({required this.text, required this.scheme});
  final String text; final ColorScheme scheme;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    color: scheme.surfaceContainerHighest,
    child: Text(text, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
  );
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.name, required this.type, required this.notes, this.deprecated = false, this.isLast = false});
  final String name; final String type; final String notes;
  final bool deprecated; final bool isLast;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isLast ? Colors.transparent : scheme.outlineVariant))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(children: <Widget>[
            Flexible(child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700))),
            if (deprecated) ...<Widget>[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: scheme.errorContainer, borderRadius: BorderRadius.circular(6)),
                child: Text('deprecated', style: TextStyle(color: scheme.onErrorContainer, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ],
          ]),
          const SizedBox(height: 4),
          Text(type, style: TextStyle(color: scheme.onSurfaceVariant, fontFamily: 'monospace', fontSize: 12)),
        ])),
        const SizedBox(width: 16),
        Expanded(flex: 5, child: Text(notes, style: TextStyle(color: scheme.onSurface, height: 1.4))),
      ]),
    );
  }
}
