// D4rt test script: Deep Demo — HeroController
// A deeply visual, stateless demo exploring HeroController — the
// NavigatorObserver subclass that coordinates hero flight animations
// between routes. Covers the observer lifecycle, createRectTween
// strategies, hero flight simulation, observer event logs, user
// gestures, HeroControllerScope wiring, custom subclasses, pitfalls,
// and a full API cheat sheet.
import 'package:flutter/material.dart';

// ============================================================
// Top-level ValueNotifiers — stateless widgets below subscribe to
// these to drive interactive sections of the demo.
// ============================================================

final ValueNotifier<double> _tweenT = ValueNotifier<double>(0.35);
final ValueNotifier<bool> _atDetail = ValueNotifier<bool>(false);
final ValueNotifier<List<String>> _observerLog = ValueNotifier<List<String>>(
  <String>[
    '10:00:01  HeroController installed (observer[0])',
    '10:00:01  Navigator.initialRoute pushed   →  didPush(/, null)',
  ],
);
final ValueNotifier<String> _activeTweenKind = ValueNotifier<String>('arc');
final ValueNotifier<bool> _gestureActive = ValueNotifier<bool>(false);

// ============================================================
// Entry point
// ============================================================

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF3949AB),
    brightness: Brightness.light,
  );
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    textTheme: Typography.englishLike2021.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HeroController Deep Demo',
    theme: theme,
    home: const _HeroControllerDemoHome(),
  );
}

// ============================================================
// HOME — DefaultTabController with nine tabs, one per section.
// ============================================================

class _HeroControllerDemoHome extends StatelessWidget {
  const _HeroControllerDemoHome();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('HeroController — Deep Visual Demo'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: scheme.onPrimaryContainer,
            unselectedLabelColor: scheme.onPrimaryContainer.withValues(
              alpha: 0.65,
            ),
            indicatorColor: scheme.onPrimaryContainer,
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.flag), text: 'Intro'),
              Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
              Tab(icon: Icon(Icons.gesture), text: 'RectTween'),
              Tab(icon: Icon(Icons.swap_horiz), text: 'Flight'),
              Tab(icon: Icon(Icons.list_alt), text: 'Log'),
              Tab(icon: Icon(Icons.swipe), text: 'Gestures'),
              Tab(icon: Icon(Icons.hub), text: 'Scope'),
              Tab(icon: Icon(Icons.extension), text: 'Subclass'),
              Tab(icon: Icon(Icons.warning_amber), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _TabIntro(),
            _TabLifecycle(),
            _TabRectTween(),
            _TabFlight(),
            _TabLog(),
            _TabGestures(),
            _TabScope(),
            _TabSubclass(),
            _TabPitfalls(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 1 — HERO BANNER / INTRO
// ============================================================

class _TabIntro extends StatelessWidget {
  const _TabIntro();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _HeroBanner(scheme: scheme),
        const SizedBox(height: 20),
        _InfoCard(
          icon: Icons.info_outline,
          title: 'What is HeroController?',
          body:
              'HeroController is a Flutter NavigatorObserver subclass that '
              'drives hero flight animations between matching Hero widgets '
              'in the outgoing and incoming routes. Install it as one of '
              'the observers on a Navigator and it takes care of the rest.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.auto_graph,
          title: 'Constructor signature',
          body:
              'HeroController({ CreateRectTween? createRectTween }).\n'
              'The optional createRectTween callback lets you customise the '
              'trajectory a hero takes in flight. By default it is null, '
              'which yields a straight linear tween. MaterialApp installs a '
              'HeroController with MaterialRectArcTween so heroes curve.',
          accent: scheme.tertiary,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.visibility,
          title: 'NavigatorObserver inheritance',
          body:
              'Because HeroController extends NavigatorObserver it can hook '
              'didPush / didPop / didReplace / didRemove and the two '
              'didStart/StopUserGesture methods to keep the hero overlay '
              'synchronised with the route stack and any in-progress '
              'interactive transitions such as the iOS back-swipe.',
          accent: scheme.secondary,
        ),
        const SizedBox(height: 20),
        _SectionTitle(
          icon: Icons.widgets,
          label: 'Quick feature tour',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _FeatureGrid(scheme: scheme),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.primaryContainer,
            scheme.tertiary,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HeroController',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: scheme.onPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'NavigatorObserver · flies heroes between routes',
                  style: TextStyle(
                    fontSize: 15,
                    color: scheme.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _HeroChip(
                      label: 'observer',
                      icon: Icons.visibility,
                      bg: scheme.onPrimary.withValues(alpha: 0.18),
                      fg: scheme.onPrimary,
                    ),
                    _HeroChip(
                      label: 'createRectTween',
                      icon: Icons.gesture,
                      bg: scheme.onPrimary.withValues(alpha: 0.18),
                      fg: scheme.onPrimary,
                    ),
                    _HeroChip(
                      label: 'flight manifest',
                      icon: Icons.flight_takeoff,
                      bg: scheme.onPrimary.withValues(alpha: 0.18),
                      fg: scheme.onPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  border: Border.all(
                    color: scheme.onPrimary.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.connecting_airports,
                  size: 64,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
  });

  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final features = <Map<String, Object>>[
      <String, Object>{
        'icon': Icons.visibility,
        'title': 'Observes',
        'sub': 'didPush / didPop / didReplace / didRemove',
        'color': scheme.primary,
      },
      <String, Object>{
        'icon': Icons.flight,
        'title': 'Orchestrates flight',
        'sub': 'launches hero flights on route transitions',
        'color': scheme.secondary,
      },
      <String, Object>{
        'icon': Icons.gesture,
        'title': 'Custom trajectories',
        'sub': 'createRectTween gives you arc or linear or bezier',
        'color': scheme.tertiary,
      },
      <String, Object>{
        'icon': Icons.swipe,
        'title': 'Gesture aware',
        'sub': 'pauses flight during iOS swipe-back',
        'color': scheme.error,
      },
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: features
          .map(
            (f) => _FeatureTile(
              icon: f['icon'] as IconData,
              title: f['title'] as String,
              sub: f['sub'] as String,
              color: f['color'] as Color,
            ),
          )
          .toList(),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.sub,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurface.withValues(
                      alpha: 0.7,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 2 — NAVIGATOR OBSERVER LIFECYCLE DIAGRAM
// ============================================================

class _TabLifecycle extends StatelessWidget {
  const _TabLifecycle();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.timeline,
          label: 'NavigatorObserver lifecycle',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.route,
          title: 'Route stack events',
          body:
              'When a Navigator mutates its stack, it notifies every attached '
              'observer. HeroController intercepts the four transition events '
              'below and kicks off a hero flight if the outgoing and incoming '
              'routes each host a Hero with the same tag.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 12),
        Container(
          height: 340,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: CustomPaint(
            painter: _LifecyclePainter(scheme: scheme),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 16),
        _LifecycleLegend(scheme: scheme),
        const SizedBox(height: 20),
        _SectionTitle(
          icon: Icons.list,
          label: 'Method-by-method',
          color: scheme.secondary,
        ),
        const SizedBox(height: 8),
        _MethodTile(
          method: 'didPush(Route route, Route? previousRoute)',
          effect:
              'Triggered when a route is pushed on top of the stack. '
              'HeroController schedules a forward hero flight from the '
              'previousRoute to the new route after the route transition '
              'animation starts.',
          color: scheme.primary,
        ),
        _MethodTile(
          method: 'didPop(Route route, Route? previousRoute)',
          effect:
              'Triggered when a route is popped. HeroController schedules '
              'a reverse hero flight from the popping route back to the '
              'previousRoute.',
          color: scheme.secondary,
        ),
        _MethodTile(
          method: 'didReplace({Route? newRoute, Route? oldRoute})',
          effect:
              'Triggered when a route is replaced (e.g. pushReplacement). '
              'A hero flight is launched if oldRoute and newRoute both '
              'carry matching hero tags.',
          color: scheme.tertiary,
        ),
        _MethodTile(
          method: 'didRemove(Route route, Route? previousRoute)',
          effect:
              'Triggered when a route is removed from the stack without a '
              'transition. HeroController uses this primarily to clean up '
              'in-flight heroes whose routes disappear unexpectedly.',
          color: scheme.error,
        ),
        _MethodTile(
          method: 'didStartUserGesture(...)',
          effect:
              'Called when the user begins an interactive transition such '
              'as the iOS back-swipe. HeroController pauses any automatic '
              'flight management while the user is in control.',
          color: scheme.primary,
        ),
        _MethodTile(
          method: 'didStopUserGesture()',
          effect:
              'Called when the user-driven transition ends. HeroController '
              'resumes its ordinary observer behaviour.',
          color: scheme.secondary,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LifecyclePainter extends CustomPainter {
  _LifecyclePainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint boxPaint = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.fill;
    final Paint boxBorder = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint controllerPaint = Paint()
      ..color = scheme.tertiaryContainer
      ..style = PaintingStyle.fill;
    final Paint controllerBorder = Paint()
      ..color = scheme.tertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    final Paint arrowPaint = Paint()
      ..color = scheme.onSurface
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Navigator box (left).
    final Rect navRect = Rect.fromLTWH(20, 40, w * 0.35, h - 80);
    final RRect navRRect = RRect.fromRectAndRadius(
      navRect,
      const Radius.circular(14),
    );
    canvas.drawRRect(navRRect, boxPaint);
    canvas.drawRRect(navRRect, boxBorder);
    _drawText(
      canvas,
      'Navigator',
      navRect.topLeft + const Offset(12, 8),
      scheme.onPrimaryContainer,
      14,
      FontWeight.w700,
    );

    // Controller box (right).
    final Rect hcRect = Rect.fromLTWH(w * 0.58, 60, w * 0.36, h - 140);
    final RRect hcRRect = RRect.fromRectAndRadius(
      hcRect,
      const Radius.circular(14),
    );
    canvas.drawRRect(hcRRect, controllerPaint);
    canvas.drawRRect(hcRRect, controllerBorder);
    _drawText(
      canvas,
      'HeroController',
      hcRect.topLeft + const Offset(12, 8),
      scheme.onTertiaryContainer,
      14,
      FontWeight.w700,
    );

    // Four event arrows.
    final events = <_LifecycleEvent>[
      _LifecycleEvent('didPush', scheme.primary, 0.12),
      _LifecycleEvent('didPop', scheme.secondary, 0.36),
      _LifecycleEvent('didReplace', scheme.tertiary, 0.60),
      _LifecycleEvent('didRemove', scheme.error, 0.84),
    ];

    for (final ev in events) {
      final double y = navRect.top + 36 + (navRect.height - 60) * ev.position;
      final Offset start = Offset(navRect.right, y);
      final Offset end = Offset(hcRect.left, y);
      arrowPaint.color = ev.color;
      canvas.drawLine(start, end, arrowPaint);
      // Arrowhead.
      final Path head = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(end.dx - 8, end.dy - 5)
        ..lineTo(end.dx - 8, end.dy + 5)
        ..close();
      canvas.drawPath(head, Paint()..color = ev.color);
      _drawText(
        canvas,
        ev.name,
        Offset((start.dx + end.dx) / 2 - 28, y - 16),
        ev.color,
        11,
        FontWeight.w600,
      );
    }

    // Hero overlay cluster at bottom of HeroController box.
    _drawText(
      canvas,
      'flight overlay',
      hcRect.bottomLeft + const Offset(12, -30),
      scheme.onTertiaryContainer.withValues(alpha: 0.8),
      11,
      FontWeight.w500,
    );
    final Rect overlayRect = Rect.fromLTWH(
      hcRect.left + 12,
      hcRect.bottom - 18,
      hcRect.width - 24,
      8,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(overlayRect, const Radius.circular(4)),
      Paint()..color = scheme.tertiary.withValues(alpha: 0.5),
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset at,
    Color color,
    double size,
    FontWeight weight,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter old) => false;
}

class _LifecycleEvent {
  const _LifecycleEvent(this.name, this.color, this.position);
  final String name;
  final Color color;
  final double position;
}

class _LifecycleLegend extends StatelessWidget {
  const _LifecycleLegend({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final legend = <Map<String, Object>>[
      <String, Object>{'name': 'didPush', 'color': scheme.primary},
      <String, Object>{'name': 'didPop', 'color': scheme.secondary},
      <String, Object>{'name': 'didReplace', 'color': scheme.tertiary},
      <String, Object>{'name': 'didRemove', 'color': scheme.error},
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: legend
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (e['color'] as Color).withValues(alpha: 0.1),
                border: Border.all(
                  color: (e['color'] as Color).withValues(alpha: 0.6),
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: e['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    e['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: e['color'] as Color,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.method,
    required this.effect,
    required this.color,
  });

  final String method;
  final String effect;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            method,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(effect, style: const TextStyle(fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 3 — createRectTween PLAYGROUND
// ============================================================

class _TabRectTween extends StatelessWidget {
  const _TabRectTween();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.gesture,
          label: 'createRectTween playground',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.compare,
          title: 'Linear vs arc vs custom',
          body:
              'A CreateRectTween is a function (Rect? begin, Rect? end) that '
              'returns a Tween<Rect?>. Three builtin choices drive the hero '
              'flight: linear RectTween (straight line), MaterialRectArcTween '
              '(Material curve) and your own — for example a cubic bezier '
              'that creates a more dramatic flight.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.tune, size: 18, color: scheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Flight progress t',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Slide to drive the intermediate Rect produced by each tween.',
                style: TextStyle(fontSize: 12),
              ),
              ValueListenableBuilder<double>(
                valueListenable: _tweenT,
                builder: (context, t, _) {
                  return Column(
                    children: <Widget>[
                      Slider(
                        value: t,
                        onChanged: (v) => _tweenT.value = v,
                        label: t.toStringAsFixed(2),
                        divisions: 50,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          't = ${t.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 6),
              ValueListenableBuilder<String>(
                valueListenable: _activeTweenKind,
                builder: (context, kind, _) {
                  return Wrap(
                    spacing: 8,
                    children: <Widget>[
                      _TweenKindChip(
                        label: 'linear',
                        kind: 'linear',
                        active: kind == 'linear',
                        color: scheme.primary,
                      ),
                      _TweenKindChip(
                        label: 'arc',
                        kind: 'arc',
                        active: kind == 'arc',
                        color: scheme.secondary,
                      ),
                      _TweenKindChip(
                        label: 'bezier',
                        kind: 'bezier',
                        active: kind == 'bezier',
                        color: scheme.tertiary,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _TweenCard(
          title: 'linear RectTween',
          description:
              'The default tween when createRectTween is null. Interpolates '
              'each corner of the begin rect toward the end rect in a '
              'straight line. Minimal compute, no curvature.',
          kind: 'linear',
          color: scheme.primary,
        ),
        const SizedBox(height: 12),
        _TweenCard(
          title: 'MaterialRectArcTween',
          description:
              'The Material Design default installed by MaterialApp. Rectangle '
              'corners follow circular arcs so the hero feels natural and '
              'polished. Works best when the flight covers a meaningful '
              'distance on both axes.',
          kind: 'arc',
          color: scheme.secondary,
        ),
        const SizedBox(height: 12),
        _TweenCard(
          title: 'Custom cubic bezier',
          description:
              'You can return any Tween<Rect?> — here we interpolate with '
              'a cubic bezier that overshoots before settling. Useful for '
              'playful transitions, reveal animations, and onboarding.',
          kind: 'bezier',
          color: scheme.tertiary,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _TweenKindChip extends StatelessWidget {
  const _TweenKindChip({
    required this.label,
    required this.kind,
    required this.active,
    required this.color,
  });

  final String label;
  final String kind;
  final bool active;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _activeTweenKind.value = kind,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? color : color.withValues(alpha: 0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _TweenCard extends StatelessWidget {
  const _TweenCard({
    required this.title,
    required this.description,
    required this.kind,
    required this.color,
  });

  final String title;
  final String description;
  final String kind;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 12, height: 1.4)),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ValueListenableBuilder<double>(
                valueListenable: _tweenT,
                builder: (context, t, _) {
                  return CustomPaint(
                    painter: _TweenPathPainter(kind: kind, t: t, color: color),
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TweenPathPainter extends CustomPainter {
  _TweenPathPainter({
    required this.kind,
    required this.t,
    required this.color,
  });

  final String kind;
  final double t;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Rect begin = Rect.fromLTWH(16, h - 50, 40, 28);
    final Rect end = Rect.fromLTWH(w - 72, 14, 56, 40);

    final Paint beginPaint = Paint()..color = color.withValues(alpha: 0.2);
    final Paint endPaint = Paint()..color = color.withValues(alpha: 0.5);
    canvas.drawRRect(
      RRect.fromRectAndRadius(begin, const Radius.circular(6)),
      beginPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(end, const Radius.circular(6)),
      endPaint,
    );

    // Compute intermediate rect and trajectory.
    final Path trajectory = Path();
    Offset sample(double u) {
      final Rect r = _rectFor(kind, begin, end, u);
      return r.center;
    }

    trajectory.moveTo(sample(0).dx, sample(0).dy);
    for (double u = 0.02; u <= 1.0; u += 0.02) {
      final Offset p = sample(u);
      trajectory.lineTo(p.dx, p.dy);
    }
    final Paint pathPaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawPath(trajectory, pathPaint);

    final Rect current = _rectFor(kind, begin, end, t);
    final Paint cardPaint = Paint()..color = color;
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(current, const Radius.circular(6)),
      cardPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(current, const Radius.circular(6)),
      borderPaint,
    );

    // Endpoints markers.
    final Paint marker = Paint()..color = color;
    canvas.drawCircle(begin.center, 4, marker);
    canvas.drawCircle(end.center, 4, marker);

    // Labels.
    _drawText(canvas, 'begin', begin.topLeft + const Offset(-2, -14), color);
    _drawText(canvas, 'end', end.topRight + const Offset(-28, -14), color);
  }

  Rect _rectFor(String kind, Rect a, Rect b, double u) {
    switch (kind) {
      case 'linear':
        return Rect.lerp(a, b, u)!;
      case 'arc':
        return _arcLerp(a, b, u);
      case 'bezier':
        return _bezierLerp(a, b, u);
    }
    return Rect.lerp(a, b, u)!;
  }

  Rect _arcLerp(Rect a, Rect b, double u) {
    // Circular-arc interpolation of the centre, with linear size.
    final Offset ca = a.center;
    final Offset cb = b.center;
    final Offset mid = Offset((ca.dx + cb.dx) / 2, (ca.dy + cb.dy) / 2);
    final Offset axis = Offset(cb.dx - ca.dx, cb.dy - ca.dy);
    final Offset normal = Offset(-axis.dy, axis.dx) * 0.5;
    final Offset control = Offset(mid.dx + normal.dx, mid.dy + normal.dy);
    final double oneMinusU = 1 - u;
    final double cx =
        oneMinusU * oneMinusU * ca.dx +
        2 * oneMinusU * u * control.dx +
        u * u * cb.dx;
    final double cy =
        oneMinusU * oneMinusU * ca.dy +
        2 * oneMinusU * u * control.dy +
        u * u * cb.dy;
    final double w = a.width + (b.width - a.width) * u;
    final double h = a.height + (b.height - a.height) * u;
    return Rect.fromCenter(center: Offset(cx, cy), width: w, height: h);
  }

  Rect _bezierLerp(Rect a, Rect b, double u) {
    final Offset ca = a.center;
    final Offset cb = b.center;
    final Offset c1 = Offset(ca.dx + (cb.dx - ca.dx) * 0.15, ca.dy - 60);
    final Offset c2 = Offset(ca.dx + (cb.dx - ca.dx) * 0.85, cb.dy + 60);
    final double oneMinusU = 1 - u;
    final double cx =
        oneMinusU * oneMinusU * oneMinusU * ca.dx +
        3 * oneMinusU * oneMinusU * u * c1.dx +
        3 * oneMinusU * u * u * c2.dx +
        u * u * u * cb.dx;
    final double cy =
        oneMinusU * oneMinusU * oneMinusU * ca.dy +
        3 * oneMinusU * oneMinusU * u * c1.dy +
        3 * oneMinusU * u * u * c2.dy +
        u * u * u * cb.dy;
    final double w = a.width + (b.width - a.width) * u;
    final double h = a.height + (b.height - a.height) * u;
    return Rect.fromCenter(center: Offset(cx, cy), width: w, height: h);
  }

  void _drawText(Canvas canvas, String text, Offset at, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _TweenPathPainter old) =>
      old.t != t || old.kind != kind;
}

// ============================================================
// SECTION 4 — HERO FLIGHT SIMULATION
// ============================================================

class _TabFlight extends StatelessWidget {
  const _TabFlight();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.swap_horiz,
          label: 'Hero flight simulation',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.info_outline,
          title: 'What HeroController does on push',
          body:
              'When a Hero exists on both the outgoing and incoming routes '
              'and shares a tag, HeroController removes both from their '
              'routes at the start of the transition, puts a "flight shuttle" '
              'overlay widget on the overlay, and animates it from the '
              'outgoing hero\'s rect to the incoming hero\'s rect.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.toggle_on, size: 18, color: scheme.primary),
                const SizedBox(width: 6),
                const Text(
                  'atDetail',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _atDetail,
              builder: (context, atDetail, _) {
                return Switch(
                  value: atDetail,
                  onChanged: (v) {
                    _atDetail.value = v;
                    _appendLog(
                      v
                          ? '${_now()}  didPush(DetailRoute)  →  hero flight: card → detail'
                          : '${_now()}  didPop(DetailRoute)   →  hero flight: detail → card',
                    );
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 360,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(12),
          child: _FlightStage(scheme: scheme),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          icon: Icons.timer_outlined,
          title: 'TweenAnimationBuilder<Rect?>',
          body:
              'We simulate a real hero flight by driving a '
              'TweenAnimationBuilder<Rect?> between the two hero rects '
              'whenever atDetail flips. HeroController inside a real app '
              'does the same thing using its internal _HeroFlight manifest.',
          accent: scheme.secondary,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.swap_vertical_circle_outlined,
          title: 'Direction: push vs pop',
          body:
              'Push direction: rect flies from the small card to the detail '
              'hero. Pop direction: rect flies back. A custom '
              'flightShuttleBuilder receives the direction so it can render '
              'differently during each half of the round trip.',
          accent: scheme.tertiary,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _FlightStage extends StatelessWidget {
  const _FlightStage({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _atDetail,
      builder: (context, atDetail, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            final double h = constraints.maxHeight;
            final Rect smallRect = Rect.fromLTWH(
              12,
              h - 100,
              100,
              80,
            );
            final Rect bigRect = Rect.fromLTWH(
              w * 0.35,
              20,
              w * 0.55,
              160,
            );
            final Rect target = atDetail ? bigRect : smallRect;
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // List page (bottom-left) — the source Hero.
                Positioned(
                  left: 12,
                  top: 16,
                  child: _PageCard(
                    title: 'ListRoute',
                    color: scheme.primary,
                    width: 160,
                    height: 120,
                  ),
                ),
                // Detail page (top-right) — the destination Hero.
                Positioned(
                  right: 12,
                  top: 16,
                  child: _PageCard(
                    title: 'DetailRoute',
                    color: scheme.tertiary,
                    width: 160,
                    height: 120,
                  ),
                ),
                // Flight shuttle card.
                TweenAnimationBuilder<Rect?>(
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.easeInOutCubic,
                  tween: RectTween(begin: target, end: target),
                  builder: (context, rect, _) {
                    final Rect r = rect ?? target;
                    return Positioned(
                      left: r.left,
                      top: r.top,
                      width: r.width,
                      height: r.height,
                      child: Material(
                        color: scheme.secondary,
                        elevation: 6,
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.flight,
                                    size: 16,
                                    color: scheme.onSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'shuttle',
                                    style: TextStyle(
                                      color: scheme.onSecondary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'tag: hero-42',
                                style: TextStyle(
                                  color: scheme.onSecondary.withValues(
                                    alpha: 0.8,
                                  ),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PageCard extends StatelessWidget {
  const _PageCard({
    required this.title,
    required this.color,
    required this.width,
    required this.height,
  });

  final String title;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.article_outlined, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'hero: hero-42',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 5 — OBSERVER EVENTS LOG
// ============================================================

String _now() {
  final DateTime t = DateTime.now();
  String pad(int v) => v.toString().padLeft(2, '0');
  return '${pad(t.hour)}:${pad(t.minute)}:${pad(t.second)}';
}

void _appendLog(String entry) {
  final List<String> next = List<String>.from(_observerLog.value)..add(entry);
  if (next.length > 60) {
    next.removeRange(0, next.length - 60);
  }
  _observerLog.value = next;
}

class _TabLog extends StatelessWidget {
  const _TabLog();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.list_alt,
          label: 'Observer events log',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.event_note,
          title: 'Simulated event stream',
          body:
              'Tap the buttons below to emit simulated Navigator events into '
              'the HeroController log. In a real app you would see this same '
              'sequence whenever the user pushes, pops or replaces a route.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _LogButton(
              label: 'Push Detail',
              icon: Icons.add_road,
              color: scheme.primary,
              onTap: () => _appendLog(
                '${_now()}  didPush(DetailRoute, ListRoute)',
              ),
            ),
            _LogButton(
              label: 'Pop',
              icon: Icons.arrow_back,
              color: scheme.secondary,
              onTap: () => _appendLog(
                '${_now()}  didPop(DetailRoute, ListRoute)',
              ),
            ),
            _LogButton(
              label: 'Replace',
              icon: Icons.swap_horiz,
              color: scheme.tertiary,
              onTap: () => _appendLog(
                '${_now()}  didReplace(old=SettingsRoute, new=ProfileRoute)',
              ),
            ),
            _LogButton(
              label: 'Remove',
              icon: Icons.remove_circle_outline,
              color: scheme.error,
              onTap: () => _appendLog(
                '${_now()}  didRemove(OrphanRoute, ListRoute)',
              ),
            ),
            _LogButton(
              label: 'Clear',
              icon: Icons.layers_clear,
              color: scheme.outline,
              onTap: () => _observerLog.value = <String>[
                '${_now()}  log cleared',
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(12),
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _observerLog,
            builder: (context, log, _) {
              return ListView.builder(
                reverse: false,
                itemCount: log.length,
                itemBuilder: (context, i) {
                  final String entry = log[i];
                  final Color c = entry.contains('didPush')
                      ? const Color(0xFF93C5FD)
                      : entry.contains('didPop')
                          ? const Color(0xFFFCA5A5)
                          : entry.contains('didReplace')
                              ? const Color(0xFFC4B5FD)
                              : entry.contains('didRemove')
                                  ? const Color(0xFFFBBF24)
                                  : const Color(0xFF94A3B8);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      entry,
                      style: TextStyle(
                        color: c,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _SectionTitle(
          icon: Icons.color_lens_outlined,
          label: 'Colour legend',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: const <Widget>[
            _LogLegendEntry(
              name: 'didPush',
              color: Color(0xFF93C5FD),
            ),
            _LogLegendEntry(
              name: 'didPop',
              color: Color(0xFFFCA5A5),
            ),
            _LogLegendEntry(
              name: 'didReplace',
              color: Color(0xFFC4B5FD),
            ),
            _LogLegendEntry(
              name: 'didRemove',
              color: Color(0xFFFBBF24),
            ),
            _LogLegendEntry(
              name: 'other',
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LogButton extends StatelessWidget {
  const _LogButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogLegendEntry extends StatelessWidget {
  const _LogLegendEntry({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 6 — USER GESTURES
// ============================================================

class _TabGestures extends StatelessWidget {
  const _TabGestures();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.swipe,
          label: 'User gestures (iOS swipe-back)',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.touch_app,
          title: 'didStartUserGesture / didStopUserGesture',
          body:
              'On iOS the system lets the user drag from the left edge to '
              'interactively pop a route. HeroController listens for these '
              'two events so it can pause hero animations while the user '
              'drives the transition, then resume them when the gesture '
              'commits or cancels.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 14),
        ValueListenableBuilder<bool>(
          valueListenable: _gestureActive,
          builder: (context, active, _) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: (active ? scheme.error : scheme.primary).withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: (active ? scheme.error : scheme.primary).withValues(
                    alpha: 0.4,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    active ? Icons.pan_tool_alt : Icons.check_circle_outline,
                    color: active ? scheme.error : scheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      active
                          ? 'Gesture active — hero animations paused, user '
                                'drives the pop.'
                          : 'No gesture in progress — HeroController observes '
                                'didPush/didPop/didReplace/didRemove normally.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: active ? scheme.error : scheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: _LogButton(
                label: 'start gesture',
                icon: Icons.play_arrow,
                color: scheme.primary,
                onTap: () {
                  _gestureActive.value = true;
                  _appendLog(
                    '${_now()}  didStartUserGesture(Route, previous)',
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _LogButton(
                label: 'stop gesture',
                icon: Icons.stop,
                color: scheme.secondary,
                onTap: () {
                  _gestureActive.value = false;
                  _appendLog('${_now()}  didStopUserGesture()');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          icon: Icons.bookmark_outline,
          label: 'Gesture rules',
          color: scheme.secondary,
        ),
        const SizedBox(height: 8),
        _GestureTile(
          icon: Icons.gesture,
          title: 'Flight pauses during the gesture',
          body:
              'While didStartUserGesture/didStopUserGesture bracket a user '
              'driven pop, HeroController does not push new flights. The '
              'visible heroes animate directly with the drag.',
          color: scheme.primary,
        ),
        _GestureTile(
          icon: Icons.rotate_left,
          title: 'Cancel vs commit',
          body:
              'When the gesture ends, the Navigator emits either a didPop '
              '(committed) or a didStopUserGesture followed by no further '
              'event (cancelled). HeroController handles both.',
          color: scheme.secondary,
        ),
        _GestureTile(
          icon: Icons.warning_amber,
          title: 'Do not block the gesture',
          body:
              'If you subclass HeroController to add side effects, do not '
              'perform synchronous work in didStartUserGesture — the gesture '
              'system needs a responsive observer.',
          color: scheme.error,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GestureTile extends StatelessWidget {
  const _GestureTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 7 — HEROCONTROLLERSCOPE WIRING
// ============================================================

class _TabScope extends StatelessWidget {
  const _TabScope();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.hub,
          label: 'Wire with HeroControllerScope',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.account_tree_outlined,
          title: 'Where does HeroController live?',
          body:
              'MaterialApp installs a HeroController implicitly via '
              'HeroControllerScope, so every Navigator descended from it '
              'gets hero flights for free. When you create a nested Navigator '
              '(for example a side panel), you can wrap it in a '
              'HeroControllerScope to give it its own HeroController.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 14),
        _CodeBlock(
          title: 'implicit wiring via MaterialApp',
          color: scheme.primary,
          code:
              'MaterialApp(\n'
              '  home: HomeScreen(),\n'
              ');\n'
              '// Internally:\n'
              'HeroControllerScope(\n'
              '  controller: HeroController(\n'
              '    createRectTween: _linearRectTween,\n'
              '  ),\n'
              '  child: Navigator(...),\n'
              ');',
        ),
        const SizedBox(height: 14),
        _CodeBlock(
          title: 'explicit nested navigator',
          color: scheme.secondary,
          code:
              'HeroControllerScope(\n'
              '  controller: HeroController(\n'
              '    createRectTween: (begin, end) =>\n'
              '        MaterialRectArcTween(begin: begin, end: end),\n'
              '  ),\n'
              '  child: Navigator(\n'
              '    key: _nestedKey,\n'
              '    onGenerateRoute: _onGenerateRoute,\n'
              '  ),\n'
              ');',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.tertiary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.tertiary.withValues(alpha: 0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.schema, color: scheme.tertiary),
                  const SizedBox(width: 8),
                  Text(
                    'Resolution',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.tertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Navigator walks up the widget tree looking for the nearest '
                'HeroControllerScope. The first one found owns hero flights '
                'for that Navigator. If no scope exists and the Navigator '
                'was not given an observer list, hero animations simply do '
                'not happen.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          icon: Icons.flag_outlined,
          label: 'Common scope patterns',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _ScopePatternTile(
          title: 'One app, one controller',
          body:
              'Default MaterialApp wiring. A single HeroController observes '
              'the root Navigator and hero flights happen across all routes.',
          color: scheme.primary,
        ),
        _ScopePatternTile(
          title: 'Nested navigator with its own scope',
          body:
              'A side panel or bottom-sheet-hosted Navigator wrapped in its '
              'own HeroControllerScope gets isolated hero flights that do '
              'not leak to the outer Navigator.',
          color: scheme.secondary,
        ),
        _ScopePatternTile(
          title: 'Shell route (NavigatorV2)',
          body:
              'In declarative routing (go_router, beamer) the shell places a '
              'HeroControllerScope around the inner Navigator so child '
              'routes animate heroes independently of the shell.',
          color: scheme.tertiary,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ScopePatternTile extends StatelessWidget {
  const _ScopePatternTile({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
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
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 8 — CUSTOM HEROCONTROLLER SUBCLASS
// ============================================================

class _TabSubclass extends StatelessWidget {
  const _TabSubclass();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.extension,
          label: 'Custom HeroController subclass',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.code,
          title: 'When to subclass',
          body:
              'Two reasons to subclass: (1) you want a different flight '
              'trajectory across the whole app, or (2) you want to log / '
              'instrument hero events — for example to record flight '
              'durations or report missing heroes.',
          accent: scheme.primary,
        ),
        const SizedBox(height: 14),
        _CodeBlock(
          title: 'Override createRectTween',
          color: scheme.primary,
          code:
              'class SlowArcHeroController extends HeroController {\n'
              '  SlowArcHeroController()\n'
              '      : super(\n'
              '          createRectTween: (begin, end) =>\n'
              '              MaterialRectArcTween(\n'
              '                begin: begin,\n'
              '                end: end,\n'
              '              ),\n'
              '        );\n'
              '}',
        ),
        const SizedBox(height: 14),
        _CodeBlock(
          title: 'Add side-effects via observer hooks',
          color: scheme.secondary,
          code:
              'class LoggingHeroController extends HeroController {\n'
              '  LoggingHeroController({super.createRectTween});\n'
              '\n'
              '  @override\n'
              '  void didPush(Route route, Route? previousRoute) {\n'
              '    super.didPush(route, previousRoute);\n'
              '    telemetry.count(\n'
              '      \'hero.push\',\n'
              '      tags: <String>[route.settings.name ?? \'\'],\n'
              '    );\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void didPop(Route route, Route? previousRoute) {\n'
              '    super.didPop(route, previousRoute);\n'
              '    telemetry.count(\'hero.pop\');\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 14),
        _CodeBlock(
          title: 'Custom Rect tween',
          color: scheme.tertiary,
          code:
              'Tween<Rect?> _overshootTween(Rect? begin, Rect? end) {\n'
              '  return _OvershootRectTween(begin: begin, end: end);\n'
              '}\n'
              '\n'
              'class _OvershootRectTween extends Tween<Rect?> {\n'
              '  _OvershootRectTween({super.begin, super.end});\n'
              '\n'
              '  @override\n'
              '  Rect? lerp(double t) {\n'
              '    final Rect? a = begin;\n'
              '    final Rect? b = end;\n'
              '    if (a == null || b == null) return Rect.lerp(a, b, t);\n'
              '    final double overshoot = Curves.elasticOut.transform(t);\n'
              '    return Rect.lerp(a, b, overshoot);\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.secondary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.secondary.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.lightbulb_outline, color: scheme.secondary),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Always call super when overriding observer methods. '
                  'HeroController relies on the default behaviour to launch '
                  'and cancel the internal _HeroFlight objects — forget the '
                  'super call and hero flights silently stop working.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ============================================================
// SECTION 9 — PITFALLS
// ============================================================

class _TabPitfalls extends StatelessWidget {
  const _TabPitfalls();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionTitle(
          icon: Icons.warning_amber,
          label: 'Pitfalls',
          color: scheme.error,
        ),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.error_outline,
          title: 'Common mistakes with HeroController',
          body:
              'Three recurring traps: sharing one HeroController across '
              'multiple Navigators, Hero tag collisions, and missed '
              'animation assertions. Each is covered below.',
          accent: scheme.error,
        ),
        const SizedBox(height: 14),
        _PitfallTile(
          number: 1,
          title: 'Sharing a HeroController across Navigators',
          body:
              'A HeroController is bound to a single Navigator at a time. If '
              'you attach the same controller to two Navigators (for example '
              'two HeroControllerScopes both wrapping the same controller '
              'instance) assertions will fire. Always create a fresh '
              'HeroController for each Navigator.',
          color: scheme.error,
        ),
        _PitfallTile(
          number: 2,
          title: 'Hero tag collisions',
          body:
              'HeroController finds candidate heroes by tag. If two visible '
              'Hero widgets on the same route share a tag, the framework '
              'asserts with "There are multiple heroes that share the same '
              'tag". Use unique tags — typically an id from your model.',
          color: scheme.error,
        ),
        _PitfallTile(
          number: 3,
          title: 'Animation assertions',
          body:
              'If you rebuild the Hero tree aggressively during flight, the '
              'internal animation controllers can end up in bad states. '
              'Keep the flight window stable: wrap the Hero in a '
              'RepaintBoundary, avoid rebuilding parent scaffolds during '
              'the transition, and prefer a dedicated flightShuttleBuilder.',
          color: scheme.error,
        ),
        const SizedBox(height: 20),
        _SectionTitle(
          icon: Icons.book_outlined,
          label: 'API cheat sheet',
          color: scheme.primary,
        ),
        const SizedBox(height: 8),
        _ApiCheatSheet(scheme: scheme),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number,
    required this.title,
    required this.body,
    required this.color,
  });

  final int number;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 18,
            backgroundColor: color,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
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
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final rows = <_ApiRow>[
      const _ApiRow(
        'HeroController({CreateRectTween? createRectTween})',
        'Constructor. createRectTween customises the hero trajectory.',
      ),
      const _ApiRow(
        'navigator',
        'NavigatorState? — the Navigator currently being observed. Null '
            'until attached by a HeroControllerScope.',
      ),
      const _ApiRow(
        'didPush(Route, Route?)',
        'Observer hook: route pushed. Schedules a forward hero flight.',
      ),
      const _ApiRow(
        'didPop(Route, Route?)',
        'Observer hook: route popped. Schedules a reverse hero flight.',
      ),
      const _ApiRow(
        'didReplace({Route?, Route?})',
        'Observer hook: route replaced. Triggers a replace-flavoured flight.',
      ),
      const _ApiRow(
        'didRemove(Route, Route?)',
        'Observer hook: route removed without transition. Cleans up flights '
            'whose routes vanish.',
      ),
      const _ApiRow(
        'didStartUserGesture(Route, Route?)',
        'Observer hook: interactive transition begins (iOS swipe-back). '
            'HeroController pauses until didStopUserGesture fires.',
      ),
      const _ApiRow(
        'didStopUserGesture()',
        'Observer hook: interactive transition ends. HeroController resumes '
            'ordinary behaviour.',
      ),
      const _ApiRow(
        'dispose()',
        'Releases any active flights. Called automatically when the '
            'HeroControllerScope unmounts.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    'member',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    'effect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: i.isEven
                    ? scheme.surface
                    : scheme.surfaceContainerHighest,
                border: i == rows.length - 1
                    ? null
                    : Border(
                        bottom: BorderSide(color: scheme.outlineVariant),
                      ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i].member,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      rows[i].effect,
                      style: const TextStyle(fontSize: 12, height: 1.4),
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

class _ApiRow {
  const _ApiRow(this.member, this.effect);
  final String member;
  final String effect;
}

// ============================================================
// SHARED UI PRIMITIVES
// ============================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: accent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({
    required this.title,
    required this.code,
    required this.color,
  });

  final String title;
  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code, size: 14, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFE2E8F0),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
