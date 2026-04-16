import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers used by the stateless demo surfaces below.
// They let us simulate transitions and toggles without introducing any
// StatefulWidget anywhere in this file.
// ---------------------------------------------------------------------------

final ValueNotifier<bool> _flightToggle = ValueNotifier<bool>(false);
final ValueNotifier<bool> _noneToggle = ValueNotifier<bool>(false);
final ValueNotifier<int> _nestedFocus = ValueNotifier<int>(0);
final ValueNotifier<double> _tweenProgress = ValueNotifier<double>(0.0);
final ValueNotifier<int> _pitfallHighlight = ValueNotifier<int>(0);
final ValueNotifier<bool> _apiExpanded = ValueNotifier<bool>(true);
final ValueNotifier<int> _diagramVariant = ValueNotifier<int>(0);
final ValueNotifier<bool> _showArcTween = ValueNotifier<bool>(true);
final ValueNotifier<bool> _showLinearTween = ValueNotifier<bool>(true);
final ValueNotifier<int> _navigatorTwoPage = ValueNotifier<int>(0);
final ValueNotifier<int> _apiTab = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Entry point. The d4rt harness calls this function and mounts the returned
// widget tree in a MaterialApp-aware environment.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF3F51B5),
    brightness: Brightness.light,
  );
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HeroControllerScope Deep Demo',
    theme: theme,
    home: const _HeroControllerScopeHome(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with DefaultTabController for the nine demo sections.
// ---------------------------------------------------------------------------

class _HeroControllerScopeHome extends StatelessWidget {
  const _HeroControllerScopeHome();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HeroControllerScope — Deep Visual Demo'),
          elevation: 3,
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'Overview'),
              Tab(text: 'Relationship'),
              Tab(text: 'Simulated Flight'),
              Tab(text: '.none'),
              Tab(text: 'Nested'),
              Tab(text: 'of / maybeOf'),
              Tab(text: 'Custom Controller'),
              Tab(text: 'Navigator 2.0'),
              Tab(text: 'Pitfalls + API'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _OverviewSection(),
            _RelationshipSection(),
            _SimulatedFlightSection(),
            _HeroNoneSection(),
            _NestedScopesSection(),
            _OfVsMaybeOfSection(),
            _CustomControllerSection(),
            _NavigatorTwoSection(),
            _PitfallsAndApiSection(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable presentation primitives.
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: scheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.85),
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

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color, this.icon});

  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code, this.caption});

  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (caption != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              caption!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: scheme.outline,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1F27),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFE6EDF3),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8, color: scheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero banner / overview of the inherited-widget pattern and why
// MaterialApp auto-provides a HeroControllerScope.
// ---------------------------------------------------------------------------

class _OverviewSection extends StatelessWidget {
  const _OverviewSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'HeroControllerScope',
          subtitle:
              'The inherited widget that wires a HeroController into every '
              'Navigator underneath it.',
          icon: Icons.flight_takeoff,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Why it exists',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Hero animations require a HeroController to coordinate '
                  'the "flight" between source and destination routes. The '
                  'controller must be accessible by the Navigator at push/pop '
                  'time, which is why Flutter uses an InheritedWidget — '
                  'HeroControllerScope — to thread the controller down the '
                  'element tree without prop-drilling.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _Pill(text: 'InheritedWidget', color: scheme.primary, icon: Icons.share),
                    _Pill(text: 'of / maybeOf', color: scheme.tertiary, icon: Icons.search),
                    _Pill(text: 'HeroController', color: scheme.secondary, icon: Icons.settings_remote),
                    _Pill(text: 'Navigator-bound', color: scheme.primary, icon: Icons.route),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: scheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.auto_awesome, color: scheme.onSecondaryContainer),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'MaterialApp already does this for you',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: scheme.onSecondaryContainer),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'MaterialApp, CupertinoApp, and WidgetsApp all insert a '
                  'HeroControllerScope above their root Navigator. Most apps '
                  'never need to touch HeroControllerScope directly. You only '
                  'reach for it when you build a custom Navigator subtree '
                  'outside MaterialApp\'s default one.',
                  style: TextStyle(
                    height: 1.5,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Two constructors',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                _ConstructorBadge(
                  title: 'HeroControllerScope(controller:, child:)',
                  description:
                      'Exposes a real HeroController so descendant Navigators '
                      'can play hero flights when they push or pop routes.',
                  icon: Icons.handyman,
                  color: scheme.primary,
                ),
                const SizedBox(height: 12),
                _ConstructorBadge(
                  title: 'HeroControllerScope.none(child:)',
                  description:
                      'Explicitly opts out of hero animations for the given '
                      'subtree. Useful for non-visual Navigators, hidden '
                      'animation subtrees, or tests that want to disable '
                      'hero transitions.',
                  icon: Icons.block,
                  color: scheme.error,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mental model',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: 'A Navigator pushes a route; the route animates in.'),
                const _BulletLine(
                    text: 'As the animation runs, the Navigator asks its HeroController '
                        'whether any Hero widgets with matching tags exist in the new and '
                        'previous routes.'),
                const _BulletLine(
                    text: 'If matches are found, the controller starts a hero flight — a '
                        'temporary overlay that animates a rectangle from the source Hero '
                        'to the destination Hero.'),
                const _BulletLine(
                    text: 'HeroControllerScope is how the Navigator finds that controller.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _ConstructorBadge extends StatelessWidget {
  const _ConstructorBadge({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — Relationship diagram using a CustomPainter.
// Draws MaterialApp → HeroControllerScope → Navigator → Routes → Heroes.
// ---------------------------------------------------------------------------

class _RelationshipSection extends StatelessWidget {
  const _RelationshipSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Relationship Diagram',
          subtitle:
              'How MaterialApp, HeroControllerScope, Navigator, Routes, and '
              'Hero widgets connect in the element tree.',
          icon: Icons.account_tree,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: _diagramVariant,
          builder: (BuildContext context, int variant, Widget? _) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text('Diagram variant:',
                            style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(width: 12),
                        SegmentedButton<int>(
                          segments: const <ButtonSegment<int>>[
                            ButtonSegment<int>(value: 0, label: Text('MaterialApp')),
                            ButtonSegment<int>(value: 1, label: Text('Custom')),
                          ],
                          selected: <int>{variant},
                          onSelectionChanged: (Set<int> s) =>
                              _diagramVariant.value = s.first,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 430,
                      child: CustomPaint(
                        painter: _RelationshipPainter(
                          scheme: scheme,
                          variant: variant,
                        ),
                        size: Size.infinite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Reading the diagram',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: 'The root MaterialApp creates a HeroControllerScope internally.'),
                const _BulletLine(
                    text: 'Its Navigator receives the HeroController via InheritedWidget lookup.'),
                const _BulletLine(
                    text: 'Pushed routes with Hero descendants participate in flights.'),
                const _BulletLine(
                    text: 'Custom subtrees (variant 2) need an explicit HeroControllerScope.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _RelationshipPainter extends CustomPainter {
  _RelationshipPainter({required this.scheme, required this.variant});

  final ColorScheme scheme;
  final int variant;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = scheme.primaryContainer;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = scheme.primary;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = scheme.tertiary;

    final List<String> labels = variant == 0
        ? <String>[
            'MaterialApp',
            'HeroControllerScope (auto)',
            'Navigator',
            'Route A / Route B',
            'Hero widgets',
          ]
        : <String>[
            'Your Widget',
            'HeroControllerScope (explicit)',
            'Custom Navigator',
            'Pages / Routes',
            'Hero widgets',
          ];
    final List<Color> fills = <Color>[
      scheme.primaryContainer,
      scheme.secondaryContainer,
      scheme.tertiaryContainer,
      scheme.surfaceContainerHighest,
      scheme.errorContainer,
    ];

    final double boxWidth = size.width * 0.6;
    final double boxHeight = 58;
    final double centerX = size.width / 2;
    final double gap = (size.height - boxHeight * labels.length) / (labels.length + 1);

    final List<Rect> rects = <Rect>[];
    for (int i = 0; i < labels.length; i++) {
      final double top = gap + i * (boxHeight + gap);
      final Rect r = Rect.fromCenter(
        center: Offset(centerX, top + boxHeight / 2),
        width: boxWidth,
        height: boxHeight,
      );
      rects.add(r);
      boxPaint.color = fills[i];
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(12));
      canvas.drawRRect(rr, boxPaint);
      canvas.drawRRect(rr, borderPaint);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: scheme.onPrimaryContainer,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxWidth - 20);
      tp.paint(
        canvas,
        Offset(centerX - tp.width / 2, r.center.dy - tp.height / 2),
      );
    }

    // Arrows between successive boxes.
    for (int i = 0; i < rects.length - 1; i++) {
      final Offset from = Offset(centerX, rects[i].bottom);
      final Offset to = Offset(centerX, rects[i + 1].top);
      canvas.drawLine(from, to, arrowPaint);
      _drawArrowHead(canvas, to, arrowPaint);
    }

    // Side annotation on the HeroControllerScope row.
    final Rect scopeRect = rects[1];
    final Offset annotationFrom = Offset(scopeRect.right + 8, scopeRect.center.dy);
    final Offset annotationTo = Offset(size.width - 10, scopeRect.center.dy);
    canvas.drawLine(annotationFrom, annotationTo, arrowPaint);
    final TextPainter annotation = TextPainter(
      text: TextSpan(
        text: variant == 0 ? 'provided automatically' : 'you add it yourself',
        style: TextStyle(
          color: scheme.tertiary,
          fontSize: 12,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    annotation.paint(
      canvas,
      Offset(
        size.width - annotation.width - 4,
        scopeRect.center.dy - annotation.height - 4,
      ),
    );
  }

  void _drawArrowHead(Canvas canvas, Offset tip, Paint paint) {
    final Path p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 6, tip.dy - 10)
      ..lineTo(tip.dx + 6, tip.dy - 10)
      ..close();
    final Paint fill = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    canvas.drawPath(p, fill);
  }

  @override
  bool shouldRepaint(covariant _RelationshipPainter old) =>
      old.variant != variant || old.scheme != scheme;
}

// ---------------------------------------------------------------------------
// SECTION 3 — Simulated hero flight between two "pages" using a ValueNotifier
// toggle and TweenAnimationBuilder<Rect?>.
// ---------------------------------------------------------------------------

class _SimulatedFlightSection extends StatelessWidget {
  const _SimulatedFlightSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Simulated Hero Flight',
          subtitle:
              'Toggle the flip to play a hero flight between two pages. '
              'The overlay tween is rendered in-place for visualisation.',
          icon: Icons.rocket_launch,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Flip direction:',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 12),
                    ValueListenableBuilder<bool>(
                      valueListenable: _flightToggle,
                      builder: (BuildContext context, bool toggled, Widget? _) {
                        return FilledButton.icon(
                          icon: Icon(toggled
                              ? Icons.flight_land
                              : Icons.flight_takeoff),
                          label: Text(toggled ? 'Return to A' : 'Fly to B'),
                          onPressed: () =>
                              _flightToggle.value = !_flightToggle.value,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _Pill(
                        text: 'TweenAnimationBuilder<Rect?>',
                        color: scheme.primary,
                        icon: Icons.animation),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 420,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _flightToggle,
                    builder: (BuildContext context, bool toggled, Widget? _) {
                      final Rect sourceRect = const Rect.fromLTWH(40, 90, 120, 120);
                      final Rect destinationRect = const Rect.fromLTWH(260, 240, 160, 160);
                      final Rect target = toggled ? destinationRect : sourceRect;
                      return Stack(
                        children: <Widget>[
                          _PageCard(
                            title: 'Page A',
                            color: scheme.primaryContainer,
                            alignment: Alignment.topLeft,
                            focused: !toggled,
                          ),
                          _PageCard(
                            title: 'Page B',
                            color: scheme.tertiaryContainer,
                            alignment: Alignment.bottomRight,
                            focused: toggled,
                          ),
                          TweenAnimationBuilder<Rect?>(
                            tween: RectTween(begin: target, end: target),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutCubic,
                            builder: (BuildContext context, Rect? rect,
                                Widget? _) {
                              final Rect r = rect ?? target;
                              return Positioned(
                                left: r.left,
                                top: r.top,
                                width: r.width,
                                height: r.height,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: scheme.primary.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                        color: scheme.primary, width: 3),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.star,
                                        size: 54, color: scheme.primary),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 12,
                            bottom: 12,
                            child: _Pill(
                                text: toggled
                                    ? 'flight A → B in progress'
                                    : 'heroes idle at A',
                                color: scheme.secondary,
                                icon: Icons.timeline),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('How the real thing works',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: '1. Navigator.push triggers a route transition.'),
                const _BulletLine(
                    text: '2. HeroController (from HeroControllerScope.of) collects source and destination heroes by tag.'),
                const _BulletLine(
                    text: '3. A flight overlay is inserted above the Navigator.'),
                const _BulletLine(
                    text: '4. A RectTween drives the overlay rectangle from source bounds to destination bounds.'),
                const _BulletLine(
                    text: '5. When the route transition finishes, the overlay is removed.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _PageCard extends StatelessWidget {
  const _PageCard({
    required this.title,
    required this.color,
    required this.alignment,
    required this.focused,
  });

  final String title;
  final Color color;
  final AlignmentGeometry alignment;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        width: 260,
        height: 190,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: focused ? 0.22 : 0.08),
              blurRadius: focused ? 14 : 6,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: focused ? Colors.black.withValues(alpha: 0.3) : Colors.transparent,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(focused ? Icons.visibility : Icons.visibility_off,
                    size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'A simulated route surface. In a real app this would be the '
              'body of a MaterialPageRoute.',
              style: TextStyle(height: 1.3),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: _Pill(
                text: focused ? 'focused' : 'background',
                color: focused ? Colors.green.shade700 : Colors.grey.shade700,
                icon: focused ? Icons.check_circle : Icons.radio_button_unchecked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — HeroControllerScope.none demonstration.
// ---------------------------------------------------------------------------

class _HeroNoneSection extends StatelessWidget {
  const _HeroNoneSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'HeroControllerScope.none',
          subtitle: 'Opt out of hero animations for a subtree.',
          icon: Icons.block,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.info, color: scheme.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Hero animations opted out',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: scheme.primary),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _noneToggle,
                      builder: (BuildContext context, bool opted, Widget? _) {
                        return Switch(
                          value: opted,
                          onChanged: (bool v) => _noneToggle.value = v,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Wrapping a Navigator (or custom Navigator-like subtree) in '
                  'HeroControllerScope.none tells descendants that no hero '
                  'controller is available — descendant Hero widgets still '
                  'participate in layout but do not fly.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 16),
                const _CodeBlock(
                  caption: 'Opt-out pattern',
                  code:
                      'HeroControllerScope.none(\n'
                      '  child: Navigator(\n'
                      '    onGenerateRoute: (settings) => MaterialPageRoute(\n'
                      '      builder: (context) => const MyNoAnimationPage(),\n'
                      '    ),\n'
                      '  ),\n'
                      ');',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: _noneToggle,
          builder: (BuildContext context, bool opted, Widget? _) {
            return Card(
              color: opted
                  ? scheme.errorContainer
                  : scheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          opted ? Icons.flight_class : Icons.flight,
                          color: opted
                              ? scheme.onErrorContainer
                              : scheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          opted
                              ? 'Subtree: no hero animations'
                              : 'Subtree: hero animations active',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: opted
                                ? scheme.onErrorContainer
                                : scheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _MiniNavigatorPreview(optOut: opted, scheme: scheme),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Use cases',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const _BulletLine(
                    text: 'A secondary Navigator that should never fight the root Navigator over hero tags.'),
                const _BulletLine(
                    text: 'Nested Navigator inside a dialog or bottom sheet where a hero would look wrong.'),
                const _BulletLine(
                    text: 'A custom animation subtree that manages its own transitions and does not want Flutter\'s hero overlay to interfere.'),
                const _BulletLine(
                    text: 'Widget tests that want to disable flights for determinism.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _MiniNavigatorPreview extends StatelessWidget {
  const _MiniNavigatorPreview({required this.optOut, required this.scheme});

  final bool optOut;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outline),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mini Navigator',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                const Text('Two sample routes side-by-side.'),
                const SizedBox(height: 10),
                _Pill(
                    text: optOut ? 'opted-out' : 'hero-enabled',
                    color: optOut ? scheme.error : scheme.primary,
                    icon: optOut ? Icons.block : Icons.check_circle),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _MiniRouteBox(label: 'Route 1', color: scheme.primary, optOut: optOut),
          const SizedBox(width: 8),
          const Icon(Icons.compare_arrows),
          const SizedBox(width: 8),
          _MiniRouteBox(
              label: 'Route 2', color: scheme.tertiary, optOut: optOut),
        ],
      ),
    );
  }
}

class _MiniRouteBox extends StatelessWidget {
  const _MiniRouteBox({
    required this.label,
    required this.color,
    required this.optOut,
  });

  final String label;
  final Color color;
  final bool optOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.2),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
              optOut ? Icons.cancel_schedule_send : Icons.flight,
              color: color),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — Nested HeroControllerScope showing outer + inner with
// different HeroControllers driving different Navigators.
// ---------------------------------------------------------------------------

class _NestedScopesSection extends StatelessWidget {
  const _NestedScopesSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Nested HeroControllerScopes',
          subtitle:
              'Different Navigators can use different HeroControllers when '
              'each Navigator is wrapped in its own scope.',
          icon: Icons.layers,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Composition',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                SizedBox(
                  height: 320,
                  child: CustomPaint(
                    painter: _NestedDiagramPainter(scheme: scheme),
                    size: Size.infinite,
                  ),
                ),
                const SizedBox(height: 12),
                const _CodeBlock(
                  caption: 'Shape of the tree',
                  code:
                      'HeroControllerScope(\n'
                      '  controller: outerController,\n'
                      '  child: Stack(\n'
                      '    children: [\n'
                      '      Navigator(key: rootKey, ...),\n'
                      '      Positioned(\n'
                      '        right: 20, bottom: 20,\n'
                      '        child: HeroControllerScope(\n'
                      '          controller: innerController,\n'
                      '          child: SizedBox(\n'
                      '            width: 320, height: 220,\n'
                      '            child: Navigator(key: overlayKey, ...),\n'
                      '          ),\n'
                      '        ),\n'
                      '      ),\n'
                      '    ],\n'
                      '  ),\n'
                      ');',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Focus:',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                      valueListenable: _nestedFocus,
                      builder: (BuildContext context, int i, Widget? _) {
                        return SegmentedButton<int>(
                          segments: const <ButtonSegment<int>>[
                            ButtonSegment<int>(
                                value: 0, label: Text('Outer'), icon: Icon(Icons.public)),
                            ButtonSegment<int>(
                                value: 1, label: Text('Inner'), icon: Icon(Icons.center_focus_strong)),
                          ],
                          selected: <int>{i},
                          onSelectionChanged: (Set<int> s) =>
                              _nestedFocus.value = s.first,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<int>(
                  valueListenable: _nestedFocus,
                  builder: (BuildContext context, int focus, Widget? _) {
                    return _NestedFocusExplanation(focus: focus, scheme: scheme);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _NestedFocusExplanation extends StatelessWidget {
  const _NestedFocusExplanation({required this.focus, required this.scheme});

  final int focus;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    if (focus == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _BulletLine(text: 'Outer HeroControllerScope wraps the whole screen.'),
          _BulletLine(
              text: 'Its HeroController drives hero flights on the main Navigator.'),
          _BulletLine(
              text: 'Tags on the main navigator pair freely with each other.'),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _BulletLine(text: 'Inner HeroControllerScope sits inside a floating pane.'),
        _BulletLine(
            text: 'Its HeroController drives hero flights on the floating Navigator only.'),
        _BulletLine(
            text: 'Heroes inside the pane never fight with outer heroes for their tag.'),
        _BulletLine(
            text: 'Independent lifecycles: the inner scope can be removed without disrupting outer flights.'),
      ],
    );
  }
}

class _NestedDiagramPainter extends CustomPainter {
  _NestedDiagramPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outerFill = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.fill;
    final Paint outerStroke = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint innerFill = Paint()
      ..color = scheme.tertiaryContainer
      ..style = PaintingStyle.fill;
    final Paint innerStroke = Paint()
      ..color = scheme.tertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrow = Paint()
      ..color = scheme.secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Rect outer = Rect.fromLTWH(16, 16, size.width - 32, size.height - 32);
    final RRect outerRR = RRect.fromRectAndRadius(outer, const Radius.circular(16));
    canvas.drawRRect(outerRR, outerFill);
    canvas.drawRRect(outerRR, outerStroke);

    final Rect inner = Rect.fromLTWH(
      outer.right - 210,
      outer.bottom - 150,
      190,
      130,
    );
    final RRect innerRR = RRect.fromRectAndRadius(inner, const Radius.circular(14));
    canvas.drawRRect(innerRR, innerFill);
    canvas.drawRRect(innerRR, innerStroke);

    _labelRect(canvas, outer,
        top: 'Outer HeroControllerScope',
        subtitle: 'controller: outerController',
        color: scheme.onPrimaryContainer);
    _labelRect(canvas, inner,
        top: 'Inner scope',
        subtitle: 'controller: innerController',
        color: scheme.onTertiaryContainer,
        small: true);

    // Navigator labels
    final Rect navOuter = Rect.fromLTWH(
      outer.left + 30,
      outer.top + 70,
      220,
      80,
    );
    final Paint navOuterPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final RRect navOuterRR = RRect.fromRectAndRadius(navOuter, const Radius.circular(10));
    canvas.drawRRect(navOuterRR, navOuterPaint);
    canvas.drawRRect(navOuterRR, outerStroke);
    _labelRect(canvas, navOuter,
        top: 'Main Navigator',
        subtitle: 'root routes, hero overlay here',
        color: scheme.primary,
        small: true);

    // Inner navigator
    final Rect navInner = Rect.fromLTWH(
      inner.left + 12,
      inner.top + 50,
      inner.width - 24,
      50,
    );
    final Paint navInnerPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final RRect navInnerRR = RRect.fromRectAndRadius(navInner, const Radius.circular(10));
    canvas.drawRRect(navInnerRR, navInnerPaint);
    canvas.drawRRect(navInnerRR, innerStroke);
    _labelRect(canvas, navInner,
        top: 'Floating Navigator',
        subtitle: 'independent flights',
        color: scheme.tertiary,
        small: true);

    // Arrows
    canvas.drawLine(
      Offset(navOuter.right, navOuter.center.dy),
      Offset(inner.left - 4, navOuter.center.dy),
      arrow,
    );
    _drawArrowHead(canvas, Offset(inner.left - 4, navOuter.center.dy), arrow);
  }

  void _labelRect(
    Canvas canvas,
    Rect rect, {
    required String top,
    required String subtitle,
    required Color color,
    bool small = false,
  }) {
    final TextPainter tp1 = TextPainter(
      text: TextSpan(
        text: top,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: small ? 12 : 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp1.paint(canvas, Offset(rect.left + 10, rect.top + 8));

    final TextPainter tp2 = TextPainter(
      text: TextSpan(
        text: subtitle,
        style: TextStyle(
          color: color.withValues(alpha: 0.8),
          fontSize: small ? 10 : 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp2.paint(canvas, Offset(rect.left + 10, rect.top + (small ? 22 : 26)));
  }

  void _drawArrowHead(Canvas canvas, Offset tip, Paint paint) {
    final Path p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 8, tip.dy - 5)
      ..lineTo(tip.dx - 8, tip.dy + 5)
      ..close();
    final Paint fill = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    canvas.drawPath(p, fill);
  }

  @override
  bool shouldRepaint(covariant _NestedDiagramPainter old) =>
      old.scheme != scheme;
}

// ---------------------------------------------------------------------------
// SECTION 6 — of vs maybeOf comparison tiles.
// ---------------------------------------------------------------------------

class _OfVsMaybeOfSection extends StatelessWidget {
  const _OfVsMaybeOfSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'of  vs  maybeOf',
          subtitle:
              'Two static accessors on HeroControllerScope — one asserts, '
              'the other returns null when there is no enclosing scope.',
          icon: Icons.compare,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _AccessorTile(
                name: 'HeroControllerScope.of(context)',
                description:
                    'Returns the nearest HeroController and asserts that a '
                    'scope exists. Use this when your code only makes sense '
                    'inside a HeroControllerScope (for example in a custom '
                    'NavigatorObserver hook).',
                badge: 'asserts on miss',
                badgeColor: scheme.error,
                icon: Icons.gps_fixed,
                lineColor: scheme.primary,
                example: 'final HeroController c =\n'
                    '  HeroControllerScope.of(context);',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _AccessorTile(
                name: 'HeroControllerScope.maybeOf(context)',
                description:
                    'Returns null when no HeroControllerScope is found. Use '
                    'this when your widget should gracefully degrade — for '
                    'example a card that only enables hero-aware transitions '
                    'when a controller is actually present.',
                badge: 'returns null on miss',
                badgeColor: scheme.tertiary,
                icon: Icons.help_outline,
                lineColor: scheme.tertiary,
                example: 'final HeroController? maybeC =\n'
                    '  HeroControllerScope.maybeOf(context);\n'
                    'if (maybeC != null) {\n'
                    '  // hero-aware branch\n'
                    '}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Assertion behavior',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: 'HeroControllerScope.of throws a FlutterError when there is no enclosing scope.'),
                const _BulletLine(
                    text: 'That message includes a pointer to MaterialApp/WidgetsApp/CupertinoApp as the usual fix.'),
                const _BulletLine(
                    text: 'HeroControllerScope.maybeOf simply returns null, making it the right choice for leaf widgets that want optional behavior.'),
                const _BulletLine(
                    text: 'Like every InheritedWidget, both accessors register a dependency so the caller rebuilds when the scope changes.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _AccessorTile extends StatelessWidget {
  const _AccessorTile({
    required this.name,
    required this.description,
    required this.badge,
    required this.badgeColor,
    required this.icon,
    required this.lineColor,
    required this.example,
  });

  final String name;
  final String description;
  final String badge;
  final Color badgeColor;
  final IconData icon;
  final Color lineColor;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: lineColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: lineColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(name,
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 12),
            _Pill(text: badge, color: badgeColor, icon: Icons.flag),
            const SizedBox(height: 12),
            _CodeBlock(code: example),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 — Custom HeroController with createRectTween.
// ---------------------------------------------------------------------------

class _CustomControllerSection extends StatelessWidget {
  const _CustomControllerSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Custom HeroController',
          subtitle:
              'You can build a HeroController with createRectTween to curve '
              'or arc the flight path instead of interpolating linearly.',
          icon: Icons.tune,
        ),
        const SizedBox(height: 20),
        const _CodeBlock(
          caption: 'Custom arc-tween controller',
          code: 'final HeroController arcController = HeroController(\n'
              '  createRectTween: (Rect? begin, Rect? end) =>\n'
              '      MaterialRectArcTween(begin: begin, end: end),\n'
              ');\n\n'
              '// Install it on a custom Navigator:\n'
              'HeroControllerScope(\n'
              '  controller: arcController,\n'
              '  child: Navigator(/* ... */),\n'
              ');',
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Tween paths:',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 12),
                    ValueListenableBuilder<bool>(
                      valueListenable: _showArcTween,
                      builder: (BuildContext context, bool on, Widget? _) {
                        return FilterChip(
                          selected: on,
                          label: const Text('MaterialRectArcTween'),
                          onSelected: (bool v) => _showArcTween.value = v,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<bool>(
                      valueListenable: _showLinearTween,
                      builder: (BuildContext context, bool on, Widget? _) {
                        return FilterChip(
                          selected: on,
                          label: const Text('Linear RectTween'),
                          onSelected: (bool v) => _showLinearTween.value = v,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<bool>(
                  valueListenable: _showArcTween,
                  builder: (BuildContext context, bool arc, Widget? _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showLinearTween,
                      builder: (BuildContext context, bool linear, Widget? _) {
                        return ValueListenableBuilder<double>(
                          valueListenable: _tweenProgress,
                          builder: (BuildContext context, double progress, Widget? _) {
                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 280,
                                  child: CustomPaint(
                                    painter: _TweenPathPainter(
                                      scheme: scheme,
                                      progress: progress,
                                      showArc: arc,
                                      showLinear: linear,
                                    ),
                                    size: Size.infinite,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('t =',
                                        style: Theme.of(context).textTheme.labelLarge),
                                    Expanded(
                                      child: Slider(
                                        value: progress,
                                        min: 0,
                                        max: 1,
                                        onChanged: (double v) =>
                                            _tweenProgress.value = v,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Text(progress.toStringAsFixed(2),
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Default vs custom',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: 'Default HeroController uses a linear RectTween between source and destination bounds.'),
                const _BulletLine(
                    text: 'MaterialRectArcTween arcs the center of the rect along a quarter-circle, producing the Material "swoop".'),
                const _BulletLine(
                    text: 'Custom createRectTween callbacks can produce any path — straight lines, arcs, staircases, spirals.'),
                const _BulletLine(
                    text: 'The HeroController you build lives as long as your HeroControllerScope — dispose it if you own it outside of a stateless tree.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _TweenPathPainter extends CustomPainter {
  _TweenPathPainter({
    required this.scheme,
    required this.progress,
    required this.showArc,
    required this.showLinear,
  });

  final ColorScheme scheme;
  final double progress;
  final bool showArc;
  final bool showLinear;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset begin = Offset(size.width * 0.15, size.height * 0.75);
    final Offset end = Offset(size.width * 0.85, size.height * 0.2);

    // Background
    final Paint bg = Paint()..color = scheme.surface;
    canvas.drawRect(Offset.zero & size, bg);

    // Gridlines
    final Paint grid = Paint()
      ..color = scheme.outlineVariant
      ..strokeWidth = 1;
    for (int i = 0; i < 10; i++) {
      final double x = size.width * i / 10;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      final double y = size.height * i / 10;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Begin/end markers
    _drawAnchor(canvas, begin, scheme.primary, 'begin');
    _drawAnchor(canvas, end, scheme.tertiary, 'end');

    if (showLinear) {
      final Paint linearPaint = Paint()
        ..color = scheme.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawLine(begin, end, linearPaint);
      final Offset cur = Offset.lerp(begin, end, progress)!;
      _drawCursor(canvas, cur, scheme.primary, 'linear');
    }

    if (showArc) {
      // Approximate MaterialRectArcTween's arc center motion with a quarter arc.
      final Path path = Path();
      final int steps = 60;
      for (int i = 0; i <= steps; i++) {
        final double t = i / steps;
        final Offset p = _arcLerp(begin, end, t);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      final Paint arcPaint = Paint()
        ..color = scheme.tertiary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawPath(path, arcPaint);
      final Offset cur = _arcLerp(begin, end, progress);
      _drawCursor(canvas, cur, scheme.tertiary, 'arc');
    }
  }

  Offset _arcLerp(Offset a, Offset b, double t) {
    // Simple quadratic curve with control point offset perpendicular to AB.
    final Offset mid = Offset.lerp(a, b, 0.5)!;
    final Offset delta = b - a;
    final Offset perp = Offset(-delta.dy, delta.dx);
    final double perpMag = perp.distance == 0 ? 1 : perp.distance;
    final Offset control = mid + perp * (0.35 / perpMag) * perp.distance;
    final double u = 1 - t;
    return Offset(
      u * u * a.dx + 2 * u * t * control.dx + t * t * b.dx,
      u * u * a.dy + 2 * u * t * control.dy + t * t * b.dy,
    );
  }

  void _drawAnchor(Canvas canvas, Offset p, Color c, String label) {
    final Paint fill = Paint()..color = c.withValues(alpha: 0.25);
    final Paint border = Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(p, 16, fill);
    canvas.drawCircle(p, 16, border);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, p + Offset(-tp.width / 2, 18));
  }

  void _drawCursor(Canvas canvas, Offset p, Color c, String label) {
    final Paint fill = Paint()..color = c;
    canvas.drawCircle(p, 7, fill);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
            color: c, fontWeight: FontWeight.w600, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, p + const Offset(10, -6));
  }

  @override
  bool shouldRepaint(covariant _TweenPathPainter old) =>
      old.progress != progress ||
      old.showArc != showArc ||
      old.showLinear != showLinear ||
      old.scheme != scheme;
}

// ---------------------------------------------------------------------------
// SECTION 8 — Navigator 2.0 usage with Router / Pages.
// ---------------------------------------------------------------------------

class _NavigatorTwoSection extends StatelessWidget {
  const _NavigatorTwoSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Navigator 2.0 + HeroControllerScope',
          subtitle:
              'When you roll a custom Router with Pages, you own the Navigator '
              'and therefore own the HeroControllerScope that feeds it.',
          icon: Icons.alt_route,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Typical pattern',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const _CodeBlock(
                  caption: 'Router + Pages with hero support',
                  code: 'Router(\n'
                      '  routerDelegate: MyRouterDelegate(\n'
                      '    builder: (context, navigatorKey, pages) {\n'
                      '      return HeroControllerScope(\n'
                      '        controller: myHeroController,\n'
                      '        child: Navigator(\n'
                      '          key: navigatorKey,\n'
                      '          pages: pages,\n'
                      '          onDidRemovePage: (page) => popPage(page),\n'
                      '        ),\n'
                      '      );\n'
                      '    },\n'
                      '  ),\n'
                      ');',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: CustomPaint(
                    painter: _NavigatorTwoDiagram(scheme: scheme),
                    size: Size.infinite,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Sample pages:',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                      valueListenable: _navigatorTwoPage,
                      builder: (BuildContext context, int p, Widget? _) {
                        return SegmentedButton<int>(
                          segments: const <ButtonSegment<int>>[
                            ButtonSegment<int>(value: 0, label: Text('Home')),
                            ButtonSegment<int>(value: 1, label: Text('Detail')),
                            ButtonSegment<int>(value: 2, label: Text('Editor')),
                          ],
                          selected: <int>{p},
                          onSelectionChanged: (Set<int> s) =>
                              _navigatorTwoPage.value = s.first,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<int>(
                  valueListenable: _navigatorTwoPage,
                  builder: (BuildContext context, int p, Widget? _) {
                    final List<_PageDescriptor> descriptors = <_PageDescriptor>[
                      _PageDescriptor(
                        title: 'HomePage',
                        summary:
                            'A list of items; each row owns a Hero with a unique tag.',
                        chip: 'Hero: item.id',
                        color: scheme.primary,
                      ),
                      _PageDescriptor(
                        title: 'DetailPage',
                        summary:
                            'Tapped item expands into a detail page; its Hero tag matches.',
                        chip: 'Hero: item.id',
                        color: scheme.tertiary,
                      ),
                      _PageDescriptor(
                        title: 'EditorPage',
                        summary:
                            'A full editor. Often pushed without hero animation — use .none.',
                        chip: 'No Hero',
                        color: scheme.secondary,
                      ),
                    ];
                    final _PageDescriptor d = descriptors[p];
                    return _PageCardPreview(descriptor: d);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('When do you actually need this?',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const _BulletLine(
                    text: 'You use Router without MaterialApp.router (rare; MaterialApp.router also inserts a HeroControllerScope).'),
                const _BulletLine(
                    text: 'You embed a secondary Router inside another screen — the inner Navigator needs its own HeroController.'),
                const _BulletLine(
                    text: 'You build a shell Navigator (e.g. a bottom-nav shell) with per-tab child Navigators — each tab benefits from its own scope.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _PageDescriptor {
  const _PageDescriptor({
    required this.title,
    required this.summary,
    required this.chip,
    required this.color,
  });

  final String title;
  final String summary;
  final String chip;
  final Color color;
}

class _PageCardPreview extends StatelessWidget {
  const _PageCardPreview({required this.descriptor});

  final _PageDescriptor descriptor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: descriptor.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: descriptor.color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.web, color: descriptor.color),
              const SizedBox(width: 10),
              Text(descriptor.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: descriptor.color)),
              const Spacer(),
              _Pill(
                  text: descriptor.chip,
                  color: descriptor.color,
                  icon: Icons.label),
            ],
          ),
          const SizedBox(height: 12),
          Text(descriptor.summary, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}

class _NavigatorTwoDiagram extends CustomPainter {
  _NavigatorTwoDiagram({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxStroke = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint boxFill = Paint()..color = scheme.primaryContainer;
    final Paint linkPaint = Paint()
      ..color = scheme.tertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final List<String> titles = <String>['Router', 'RouterDelegate', 'HeroControllerScope', 'Navigator', 'Pages'];
    final List<Rect> boxes = <Rect>[];
    final double w = size.width / 5 - 14;
    final double h = 80;
    final double top = size.height / 2 - h / 2;
    for (int i = 0; i < 5; i++) {
      final Rect r = Rect.fromLTWH(6 + i * (w + 12), top, w, h);
      boxes.add(r);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10));
      canvas.drawRRect(rr, boxFill);
      canvas.drawRRect(rr, boxStroke);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: titles[i],
          style: TextStyle(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: w - 10);
      tp.paint(canvas, Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2));
    }
    for (int i = 0; i < boxes.length - 1; i++) {
      final Offset from = Offset(boxes[i].right, boxes[i].center.dy);
      final Offset to = Offset(boxes[i + 1].left, boxes[i + 1].center.dy);
      canvas.drawLine(from, to, linkPaint);
      final Path arrow = Path()
        ..moveTo(to.dx, to.dy)
        ..lineTo(to.dx - 8, to.dy - 5)
        ..lineTo(to.dx - 8, to.dy + 5)
        ..close();
      canvas.drawPath(arrow, Paint()..color = scheme.tertiary);
    }
  }

  @override
  bool shouldRepaint(covariant _NavigatorTwoDiagram old) => old.scheme != scheme;
}

// ---------------------------------------------------------------------------
// SECTION 9 — Pitfalls and API cheat sheet combined.
// ---------------------------------------------------------------------------

class _PitfallsAndApiSection extends StatelessWidget {
  const _PitfallsAndApiSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const _SectionHeader(
          title: 'Pitfalls & API Cheat Sheet',
          subtitle:
              'Three common mistakes to avoid and a compact API reference.',
          icon: Icons.warning_amber,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: _pitfallHighlight,
          builder: (BuildContext context, int hi, Widget? _) {
            return Column(
              children: <Widget>[
                _PitfallTile(
                  index: 0,
                  highlighted: hi == 0,
                  icon: Icons.no_transfer,
                  title: 'Forgetting scope for secondary Navigators',
                  body:
                      'Custom Navigators built outside MaterialApp do not get '
                      'a HeroControllerScope automatically. If you forget one, '
                      'Hero widgets inside your secondary Navigator will '
                      'silently stop animating — no error, just a missing '
                      'flight.',
                  color: scheme.error,
                  onTap: () => _pitfallHighlight.value = 0,
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  index: 1,
                  highlighted: hi == 1,
                  icon: Icons.swap_horiz,
                  title: 'Overlapping Hero tags',
                  body:
                      'Two Hero widgets with the same tag on the same route '
                      'trigger an assertion because the HeroController cannot '
                      'decide which one is the source. Use per-item unique '
                      'tags, typically derived from a stable model id.',
                  color: scheme.error,
                  onTap: () => _pitfallHighlight.value = 1,
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  index: 2,
                  highlighted: hi == 2,
                  icon: Icons.dynamic_feed,
                  title: 'Contradictory heroes across nested scopes',
                  body:
                      'When an outer and an inner HeroControllerScope each '
                      'see matching Hero tags during the same frame, the '
                      'flight can ping-pong or flash. Prefer distinct tags '
                      'between outer and inner subtrees — or use '
                      'HeroControllerScope.none on the inner Navigator to '
                      'suppress its contribution.',
                  color: scheme.error,
                  onTap: () => _pitfallHighlight.value = 2,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        _ApiCheatSheet(scheme: scheme),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.index,
    required this.highlighted,
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.onTap,
  });

  final int index;
  final bool highlighted;
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: highlighted ? color.withValues(alpha: 0.14) : color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: highlighted ? color : color.withValues(alpha: 0.3),
            width: highlighted ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Pitfall #${index + 1}',
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                      const SizedBox(width: 8),
                      if (highlighted)
                        _Pill(text: 'selected', color: color, icon: Icons.check),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(body, style: const TextStyle(height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.menu_book, color: scheme.primary),
                const SizedBox(width: 10),
                Text('API cheat sheet',
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                ValueListenableBuilder<bool>(
                  valueListenable: _apiExpanded,
                  builder: (BuildContext context, bool expanded, Widget? _) {
                    return IconButton(
                      icon: Icon(
                          expanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () => _apiExpanded.value = !expanded,
                    );
                  },
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _apiExpanded,
              builder: (BuildContext context, bool expanded, Widget? _) {
                if (!expanded) return const SizedBox.shrink();
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 12),
                    ValueListenableBuilder<int>(
                      valueListenable: _apiTab,
                      builder: (BuildContext context, int idx, Widget? _) {
                        return SegmentedButton<int>(
                          segments: const <ButtonSegment<int>>[
                            ButtonSegment<int>(value: 0, label: Text('Default')),
                            ButtonSegment<int>(value: 1, label: Text('.none')),
                            ButtonSegment<int>(value: 2, label: Text('.of')),
                            ButtonSegment<int>(value: 3, label: Text('.maybeOf')),
                          ],
                          selected: <int>{idx},
                          onSelectionChanged: (Set<int> s) =>
                              _apiTab.value = s.first,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<int>(
                      valueListenable: _apiTab,
                      builder: (BuildContext context, int idx, Widget? _) {
                        switch (idx) {
                          case 0:
                            return const _CodeBlock(
                              caption: 'Constructor',
                              code: 'const HeroControllerScope({\n'
                                  '  Key? key,\n'
                                  '  required HeroController controller,\n'
                                  '  required Widget child,\n'
                                  '});',
                            );
                          case 1:
                            return const _CodeBlock(
                              caption: 'Opt-out constructor',
                              code: 'const HeroControllerScope.none({\n'
                                  '  Key? key,\n'
                                  '  required Widget child,\n'
                                  '});',
                            );
                          case 2:
                            return const _CodeBlock(
                              caption: 'Static accessor (asserts)',
                              code: 'static HeroController of(BuildContext context) {\n'
                                  '  // asserts a HeroControllerScope is present.\n'
                                  '}',
                            );
                          case 3:
                          default:
                            return const _CodeBlock(
                              caption: 'Static accessor (null-safe)',
                              code: 'static HeroController? maybeOf(\n'
                                  '  BuildContext context,\n'
                                  ') {\n'
                                  '  // returns null when no scope is in context.\n'
                                  '}',
                            );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Quick recap',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          const _BulletLine(
                              text: 'InheritedWidget: descendants look up the nearest HeroController.'),
                          const _BulletLine(
                              text: 'MaterialApp/CupertinoApp/WidgetsApp insert one around their root Navigator.'),
                          const _BulletLine(
                              text: 'Use the plain constructor for custom Navigators that should play hero flights.'),
                          const _BulletLine(
                              text: 'Use .none to opt out of hero flights for a subtree.'),
                          const _BulletLine(
                              text: 'of asserts on miss; maybeOf returns null.'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
