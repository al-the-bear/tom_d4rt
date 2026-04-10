// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TransitionRoute
// Demonstrates TransitionRoute — the abstract mixin class that adds
// entrance and exit animations to routes. Covers the animation
// lifecycle, controller creation, secondary animations, duration
// configuration, and the route class hierarchy that builds on it.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TransitionRoute Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.animation,
      'title': 'Animated Route Base',
      'body': 'TransitionRoute extends OverlayRoute to add forward '
          'and reverse animations when routes are pushed and popped. '
          'It owns an AnimationController that drives the entrance '
          'and exit transitions.',
      'accent': Color(0xFF6A1B9A),
    },
    {
      'icon': Icons.play_arrow,
      'title': 'Primary Animation',
      'body': 'The "animation" property tracks this route\'s own '
          'transition: 0.0 when fully dismissed (off-screen) to '
          '1.0 when fully presented. Subclasses use it to build '
          'slide, fade, or scale transitions.',
      'accent': Color(0xFF00695C),
    },
    {
      'icon': Icons.fast_forward,
      'title': 'Secondary Animation',
      'body': 'The "secondaryAnimation" tracks transitions of routes '
          'above this one. When another route pushes on top, this '
          'value drives the covering/uncovering effect on the '
          'route below.',
      'accent': Color(0xFF6A1B9A),
    },
    {
      'icon': Icons.view_carousel,
      'title': 'Route Hierarchy Foundation',
      'body': 'TransitionRoute is the base for ModalRoute → PageRoute '
          '→ MaterialPageRoute / CupertinoPageRoute. Every page '
          'transition in a Flutter app ultimately flows through '
          'the controller this class creates.',
      'accent': Color(0xFF00695C),
    },
  ];

  print('  Cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Animation Lifecycle
  // ============================================================
  print('=== Section 2: Animation Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'phase': 'install()',
      'description': 'Called by NavigatorState when the route is first '
          'inserted. Creates the AnimationController via '
          'createAnimationController() and the transition Animation '
          'via createAnimation().',
      'animation': '—',
      'color': Color(0xFF6A1B9A),
    },
    {
      'phase': 'didPush()',
      'description': 'Starts the forward animation. The controller '
          'runs from 0.0 → 1.0 over transitionDuration. The route '
          'becomes the current route.',
      'animation': '0.0 → 1.0',
      'color': Color(0xFF00695C),
    },
    {
      'phase': 'didReplace()',
      'description': 'When replacing another route, the animation '
          'jumps to 1.0 instantly — no forward transition.',
      'animation': '→ 1.0 (instant)',
      'color': Color(0xFF6A1B9A),
    },
    {
      'phase': 'didPop()',
      'description': 'Starts the reverse animation. The controller '
          'runs from 1.0 → 0.0 over reverseTransitionDuration. '
          'The route begins exiting.',
      'animation': '1.0 → 0.0',
      'color': Color(0xFF00695C),
    },
    {
      'phase': 'completed',
      'description': 'Animation reaches 1.0 (forward) — route is fully '
          'visible. The transition overlay can be optimized away.',
      'animation': '= 1.0',
      'color': Color(0xFF6A1B9A),
    },
    {
      'phase': 'dismissed',
      'description': 'Animation reaches 0.0 (reverse) — route is fully '
          'off-screen. The route is finalized and removed from '
          'the overlay stack.',
      'animation': '= 0.0',
      'color': Color(0xFF00695C),
    },
    {
      'phase': 'dispose()',
      'description': 'Animation controller is disposed. All listeners '
          'are removed. The route is garbage collected.',
      'animation': '—',
      'color': Color(0xFF6A1B9A),
    },
  ];

  print('  Phases: ${lifecycle.length}');

  // ============================================================
  // SECTION 3: Controller & Animation Creation
  // ============================================================
  print('=== Section 3: Controller Creation ===');

  final creationCode = '''// TransitionRoute internal flow:

@override
AnimationController createAnimationController() {
  return AnimationController(
    duration: transitionDuration,
    reverseDuration: reverseTransitionDuration,
    debugLabel: debugLabel,
    vsync: navigator!.overlay!,
  );
}

@override
Animation<double> createAnimation() {
  return CurvedAnimation(
    parent: controller!,
    curve: Curves.linearToEaseOut,
    reverseCurve: Curves.easeInToLinear,
  );
}''';

  final overrideCode = '''// Custom subclass with slide transition:
class SlideRoute<T> extends TransitionRoute<T> {
  @override
  Duration get transitionDuration =>
      Duration(milliseconds: 400);

  @override
  Duration get reverseTransitionDuration =>
      Duration(milliseconds: 350);

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: controller!,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }
}''';

  print('  Code blocks ready');

  // ============================================================
  // SECTION 4: Duration Configuration
  // ============================================================
  print('=== Section 4: Durations ===');

  final durations = <Map<String, dynamic>>[
    {
      'route': 'MaterialPageRoute',
      'forward': '300 ms',
      'reverse': '300 ms',
      'effect': 'Slide + fade',
      'color': Color(0xFF6A1B9A),
    },
    {
      'route': 'CupertinoPageRoute',
      'forward': '400 ms',
      'reverse': '400 ms',
      'effect': 'Horizontal slide',
      'color': Color(0xFF00695C),
    },
    {
      'route': 'DialogRoute',
      'forward': '150 ms',
      'reverse': '75 ms',
      'effect': 'Fade + scale',
      'color': Color(0xFF6A1B9A),
    },
    {
      'route': 'ModalBottomSheet',
      'forward': '250 ms',
      'reverse': '200 ms',
      'effect': 'Slide up',
      'color': Color(0xFF00695C),
    },
    {
      'route': 'PopupRoute',
      'forward': '200 ms',
      'reverse': '200 ms',
      'effect': 'Fade',
      'color': Color(0xFF6A1B9A),
    },
  ];

  print('  Durations: ${durations.length}');

  // ============================================================
  // SECTION 5: Secondary Animation
  // ============================================================
  print('=== Section 5: Secondary Animation ===');

  final secondaryExplanation = <Map<String, dynamic>>[
    {
      'scenario': 'Route B pushes over Route A',
      'routeA': 'secondaryAnimation 0→1 as B covers A',
      'routeB': 'animation 0→1 (normal entrance)',
      'color': Color(0xFF6A1B9A),
    },
    {
      'scenario': 'Route B pops back to Route A',
      'routeA': 'secondaryAnimation 1→0 as A uncovers',
      'routeB': 'animation 1→0 (normal exit)',
      'color': Color(0xFF00695C),
    },
    {
      'scenario': 'Route C pushes over B (A still below)',
      'routeA': 'secondaryAnimation stays at 1',
      'routeB': 'secondaryAnimation 0→1',
      'color': Color(0xFF6A1B9A),
    },
  ];

  final secondaryUsageCode = '''// Use secondary animation to offset the
// covered route slightly to the left:
@override
Widget buildTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-0.3, 0.0),
    ).animate(secondaryAnimation),
    child: FadeTransition(
      opacity: ReverseAnimation(
        secondaryAnimation,
      ),
      child: child,
    ),
  );
}''';

  print('  Secondary scenarios: ${secondaryExplanation.length}');

  // ============================================================
  // SECTION 6: Route Class Hierarchy
  // ============================================================
  print('=== Section 6: Route Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'class': 'Route<T>',
      'depth': 0,
      'adds': 'Base class — navigation result, settings',
      'color': Colors.grey[600]!,
    },
    {
      'class': 'OverlayRoute<T>',
      'depth': 1,
      'adds': 'Overlay entries — renders in Navigator overlay stack',
      'color': Colors.grey[500]!,
    },
    {
      'class': 'TransitionRoute<T>',
      'depth': 2,
      'adds': 'Forward/reverse animation, secondary animation',
      'color': Color(0xFF6A1B9A),
    },
    {
      'class': 'ModalRoute<T>',
      'depth': 3,
      'adds': 'Barrier (scrim), dismissible, scope, offstage',
      'color': Color(0xFF00695C),
    },
    {
      'class': 'PageRoute<T>',
      'depth': 4,
      'adds': 'Full-screen, replaces entire viewport',
      'color': Color(0xFF6A1B9A),
    },
    {
      'class': 'MaterialPageRoute',
      'depth': 5,
      'adds': 'Material slide+fade transition, platform adaptive',
      'color': Color(0xFF00695C),
    },
    {
      'class': 'CupertinoPageRoute',
      'depth': 5,
      'adds': 'iOS horizontal slide with parallax effect',
      'color': Color(0xFF00695C),
    },
    {
      'class': 'PopupRoute<T>',
      'depth': 3,
      'adds': 'Popup overlay — dialogs, menus, bottom sheets',
      'color': Color(0xFF6A1B9A),
    },
  ];

  print('  Hierarchy entries: ${hierarchy.length}');

  // ============================================================
  // SECTION 7: Transition Patterns
  // ============================================================
  print('=== Section 7: Transition Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Slide Transition',
      'code': 'SlideTransition(\n'
          '  position: Tween<Offset>(\n'
          '    begin: Offset(1.0, 0.0),\n'
          '    end: Offset.zero,\n'
          '  ).animate(animation),\n'
          '  child: child,\n'
          ')',
      'description': 'Slides the new route in from the right. Most '
          'common page transition pattern.',
      'color': Color(0xFF6A1B9A),
    },
    {
      'title': 'Fade Transition',
      'code': 'FadeTransition(\n'
          '  opacity: animation,\n'
          '  child: child,\n'
          ')',
      'description': 'Cross-fades between old and new route. Subtle, '
          'works well for tab-like navigation.',
      'color': Color(0xFF00695C),
    },
    {
      'title': 'Scale Transition',
      'code': 'ScaleTransition(\n'
          '  scale: Tween<double>(\n'
          '    begin: 0.8,\n'
          '    end: 1.0,\n'
          '  ).animate(CurvedAnimation(\n'
          '    parent: animation,\n'
          '    curve: Curves.easeOutBack,\n'
          '  )),\n'
          '  child: child,\n'
          ')',
      'description': 'Scales in from slightly smaller. Used for dialogs '
          'and hero-style reveals.',
      'color': Color(0xFF6A1B9A),
    },
    {
      'title': 'Combined Slide + Fade',
      'code': 'SlideTransition(\n'
          '  position: offsetTween\n'
          '      .animate(animation),\n'
          '  child: FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: child,\n'
          '  ),\n'
          ')',
      'description': 'Layered transitions — Material default combines '
          'slide from bottom with fade.',
      'color': Color(0xFF00695C),
    },
  ];

  print('  Patterns: ${patterns.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Don\'t Override controller Directly',
      'detail': 'Override createAnimationController() and '
          'createAnimation() instead. The framework calls these '
          'at the right time during install().',
      'icon': Icons.warning_amber,
      'color': Color(0xFF6A1B9A),
    },
    {
      'title': 'Set reverseTransitionDuration',
      'detail': 'Exit animations can be faster than entrance to '
          'feel snappy. 75% of forward duration is a good '
          'starting point.',
      'icon': Icons.speed,
      'color': Color(0xFF00695C),
    },
    {
      'title': 'Use secondaryAnimation for Polish',
      'detail': 'Animate the covered route (parallax offset, slight '
          'fade) using secondaryAnimation. This gives depth to '
          'the navigation stack.',
      'icon': Icons.layers,
      'color': Color(0xFF6A1B9A),
    },
    {
      'title': 'Match Platform Conventions',
      'detail': 'Use slide-from-right for iOS, bottom-up fade for '
          'Android. PageTransitionsTheme adapts automatically '
          'when using MaterialPageRoute.',
      'icon': Icons.phone_android,
      'color': Color(0xFF00695C),
    },
    {
      'title': 'Prefer PageRouteBuilder for Custom Transitions',
      'detail': 'Rather than subclassing TransitionRoute directly, '
          'use PageRouteBuilder with transitionsBuilder for '
          'one-off custom transitions.',
      'icon': Icons.build,
      'color': Color(0xFF6A1B9A),
    },
  ];

  print('  Practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A1B9A), Color(0xFF00695C)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.animation, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('TransitionRoute',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The abstract mixin that gives routes forward and reverse '
                'animations — the foundation beneath MaterialPageRoute, '
                'CupertinoPageRoute, and every animated route in Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.lightbulb_outline, Color(0xFF6A1B9A)),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Animation Lifecycle ----
        _sectionHeader('2. Animation Lifecycle', Icons.timeline, Color(0xFF00695C)),
        SizedBox(height: 10),
        ...List.generate(lifecycle.length, (i) {
          final ph = lifecycle[i];
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: (ph['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(color: ph['color'] as Color, width: 4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: ph['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(ph['phase'] as String,
                          style: TextStyle(color: Colors.white, fontFamily: 'monospace',
                              fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(ph['description'] as String,
                          style: TextStyle(fontSize: 12)),
                    ),
                    if ((ph['animation'] as String) != '—')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(ph['animation'] as String,
                            style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
              if (i < lifecycle.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
                ),
            ],
          );
        }),

        SizedBox(height: 20),

        // ---- Section 3: Controller Creation ----
        _sectionHeader('3. Controller Creation', Icons.code, Color(0xFF6A1B9A)),
        SizedBox(height: 10),
        Text('How TransitionRoute builds its animation stack:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(creationCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFCE93D8))),
        ),
        SizedBox(height: 12),
        Text('Subclass overriding durations and curve:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(overrideCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Duration Configuration ----
        _sectionHeader('4. Duration Configuration', Icons.timer, Color(0xFF00695C)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Color(0xFF00695C),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Route Type',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Forward',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Reverse',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Effect',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(durations.length, (i) {
                final d = durations[i];
                return Container(
                  color: i.isEven ? Colors.white : Color(0xFFF3E5F5),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(d['route'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 2, child: Text(d['forward'] as String,
                          style: TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text(d['reverse'] as String,
                          style: TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text(d['effect'] as String,
                          style: TextStyle(fontSize: 10))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Secondary Animation ----
        _sectionHeader('5. Secondary Animation', Icons.layers, Color(0xFF6A1B9A)),
        SizedBox(height: 10),
        ...secondaryExplanation.map((se) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (se['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: se['color'] as Color, width: 3)),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(se['scenario'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: se['color'] as Color)),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7F6),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text('Route A', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 6),
                        Expanded(child: Text(se['routeA'] as String,
                            style: TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text('Route B', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 6),
                        Expanded(child: Text(se['routeB'] as String,
                            style: TextStyle(fontSize: 11, fontFamily: 'monospace'))),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(secondaryUsageCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFB39DDB))),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Route Hierarchy ----
        _sectionHeader('6. Route Hierarchy', Icons.account_tree, Color(0xFF00695C)),
        SizedBox(height: 10),
        ...hierarchy.map((h) => Padding(
              padding: EdgeInsets.only(left: (h['depth'] as int) * 18.0, bottom: 4),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: (h['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(
                    color: h['color'] as Color,
                    width: h['class'] == 'TransitionRoute<T>' ? 4 : 2,
                  )),
                ),
                child: Row(
                  children: [
                    Text(h['class'] as String,
                        style: TextStyle(
                          fontWeight: h['class'] == 'TransitionRoute<T>' ? FontWeight.bold : FontWeight.w600,
                          fontFamily: 'monospace',
                          fontSize: h['class'] == 'TransitionRoute<T>' ? 13 : 11,
                          color: h['color'] as Color,
                        )),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(h['adds'] as String,
                          style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Transition Patterns ----
        _sectionHeader('7. Transition Patterns', Icons.auto_awesome, Color(0xFF6A1B9A)),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                    SizedBox(height: 4),
                    Text(p['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFCE93D8))),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Color(0xFF00695C)),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Color(0xFF6A1B9A), size: 22),
                  SizedBox(width: 4),
                  Icon(Icons.animation, color: Color(0xFF00695C), size: 28),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Color(0xFF6A1B9A), size: 22),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'TransitionRoute: forward and reverse animations, '
                'secondary animation for covered routes — the animation '
                'engine that makes every page transition smooth.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
