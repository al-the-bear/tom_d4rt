// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — HeroFlightDirection
// Demonstrates HeroFlightDirection — the enum that controls the
// direction of Hero flight animations. Covers push vs pop flight,
// hero animation lifecycle, flight manifest, hero overlay, reverse
// heroes, custom flight shuttle builders, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HeroFlightDirection Deep Demo executing');

  // ============================================================
  // SECTION 1: What is HeroFlightDirection?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.flight_takeoff,
      'title': 'Directional Hero Animations',
      'body': 'HeroFlightDirection is an enum with two values: '
          'push and pop. It tells the Hero animation system which '
          'direction the flight is going — forward (push) to a new '
          'route, or backward (pop) returning to the previous route. '
          'This information is critical for building custom flight '
          'shuttle widgets that animate differently in each direction.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Push vs Pop',
      'body': 'When Navigator.push() is called, the hero flies from '
          'the "from" route to the "to" route with direction=push. '
          'When Navigator.pop() triggers, the same hero flies back '
          'with direction=pop. The framework passes this direction '
          'to your flightShuttleBuilder so you can customize the '
          'animation for each direction independently.',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Hero Overlay',
      'body': 'During a hero flight, the framework removes the hero '
          'widget from both routes and places a "shuttle" widget on '
          'a special OverlayEntry above the route transitions. This '
          'shuttle animates from the source hero\'s position/size to '
          'the destination hero\'s position/size. The direction enum '
          'tells which route is source and which is destination.',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.architecture,
      'title': 'Part of HeroFlightManifest',
      'body': 'Internally, the framework creates a _HeroFlight that '
          'carries a manifest with: hero tag, fromHero, toHero, '
          'createRectTween, shuttleBuilder, and the direction. '
          'All these work together to produce the flight animation '
          'you see on screen.',
      'accent': Colors.blue[600]!,
    },
  ];

  print('  Prepared ${conceptItems.length} concept items');

  // ============================================================
  // SECTION 2: The Enum Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'value': 'HeroFlightDirection.push',
      'icon': Icons.arrow_forward,
      'color': Colors.indigo[700]!,
      'bgColor': Colors.indigo[50]!,
      'meaning': 'Navigation is going FORWARD',
      'trigger': 'Navigator.push(), Navigator.pushNamed(), '
          'Navigator.pushReplacement()',
      'fromRoute': 'Current route (visible)',
      'toRoute': 'New route (being pushed)',
      'heroFlight': 'Hero flies from its position on the current '
          'route to its position on the new route',
      'animation': 'Typically: grow, expand, rise',
    },
    {
      'value': 'HeroFlightDirection.pop',
      'icon': Icons.arrow_back,
      'color': Colors.blue[700]!,
      'bgColor': Colors.blue[50]!,
      'meaning': 'Navigation is going BACKWARD',
      'trigger': 'Navigator.pop(), back button, system back gesture',
      'fromRoute': 'Current route (being popped)',
      'toRoute': 'Previous route (being revealed)',
      'heroFlight': 'Hero flies from its position on the current '
          'route back to its position on the previous route',
      'animation': 'Typically: shrink, contract, settle',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: Hero Animation Lifecycle
  // ============================================================
  print('=== Section 3: Animation Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Route Transition Starts',
      'icon': Icons.play_arrow,
      'color': Colors.indigo[800]!,
      'description': 'Navigator.push() or Navigator.pop() is called. '
          'The framework begins the route transition animation '
          'controller (typically 300ms).',
    },
    {
      'step': 2,
      'title': 'Hero Matching',
      'icon': Icons.link,
      'color': Colors.indigo[700]!,
      'description': 'The framework scans both routes for Hero widgets '
          'with matching tags. For each match, it prepares a hero '
          'flight. Non-matching heroes are ignored.',
    },
    {
      'step': 3,
      'title': 'Flight Direction Set',
      'icon': Icons.compare_arrows,
      'color': Colors.blue[700]!,
      'description': 'The direction is set: push for forward nav, '
          'pop for backward. This is the moment HeroFlightDirection '
          'becomes relevant — it\'s stored in the flight manifest.',
    },
    {
      'step': 4,
      'title': 'Shuttle Creation',
      'icon': Icons.flight,
      'color': Colors.blue[600]!,
      'description': 'For each matched pair, the framework creates a '
          'shuttle widget via flightShuttleBuilder (or uses the '
          'default). The shuttle receives the direction, animation, '
          'and hero sizes. Heroes are hidden on both routes.',
    },
    {
      'step': 5,
      'title': 'Overlay Flight',
      'icon': Icons.layers,
      'color': Colors.indigo[600]!,
      'description': 'The shuttle widget is placed on the Navigator\'s '
          'overlay. It animates from fromHeroLocation to '
          'toHeroLocation using a RectTween. The direction '
          'determines which hero is "from" and which is "to".',
    },
    {
      'step': 6,
      'title': 'Flight Completes',
      'icon': Icons.check_circle,
      'color': Colors.indigo[500]!,
      'description': 'When the route transition animation completes, '
          'the shuttle is removed from the overlay. The destination '
          'hero becomes visible again in its route. State is '
          'preserved on the hero widget.',
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 4: FlightShuttleBuilder Signature
  // ============================================================
  print('=== Section 4: FlightShuttleBuilder ===');

  final builderParams = <Map<String, dynamic>>[
    {
      'name': 'flightContext',
      'type': 'BuildContext',
      'icon': Icons.web,
      'color': Colors.indigo[700]!,
      'description': 'The BuildContext of the shuttle widget in '
          'the overlay. Not the context of either route — it\'s '
          'a new context on the overlay layer.',
    },
    {
      'name': 'animation',
      'type': 'Animation<double>',
      'icon': Icons.animation,
      'color': Colors.blue[700]!,
      'description': 'The route transition animation (0.0 → 1.0). '
          'Use this to animate properties like opacity, scale, '
          'or rotation during the flight. At 0.0 the hero is at '
          'its starting position, at 1.0 it\'s at the destination.',
    },
    {
      'name': 'flightDirection',
      'type': 'HeroFlightDirection',
      'icon': Icons.compare_arrows,
      'color': Colors.indigo[600]!,
      'description': 'The direction of the flight — push or pop. '
          'Use this to vary the shuttle widget based on direction. '
          'For example: fade in during push, scale down during pop.',
    },
    {
      'name': 'fromHeroContext',
      'type': 'BuildContext',
      'icon': Icons.arrow_back,
      'color': Colors.blue[600]!,
      'description': 'The BuildContext of the source hero widget '
          '(where the flight starts). Useful for reading inherited '
          'widgets or getting the fromHero\'s child widget.',
    },
    {
      'name': 'toHeroContext',
      'type': 'BuildContext',
      'icon': Icons.arrow_forward,
      'color': Colors.indigo[500]!,
      'description': 'The BuildContext of the destination hero '
          'widget (where the flight ends). Same uses as '
          'fromHeroContext but for the target.',
    },
  ];

  print('  Prepared ${builderParams.length} builder params');

  // ============================================================
  // SECTION 5: Direction-Dependent Shuttle Examples
  // ============================================================
  print('=== Section 5: Shuttle Examples ===');

  final shuttleExamples = <Map<String, dynamic>>[
    {
      'name': 'Opacity Fade',
      'icon': Icons.opacity,
      'color': Colors.indigo[700]!,
      'description': 'Fade in the toHero\'s child during push, '
          'fade out during pop. Gives a smooth visual transition.',
      'code': 'flightShuttleBuilder: (ctx, anim, dir, from, to) {\n'
          '  final child = dir == HeroFlightDirection.push\n'
          '    ? to.widget  // Show destination on push\n'
          '    : from.widget;  // Show source on pop\n'
          '  return FadeTransition(\n'
          '    opacity: anim,\n'
          '    child: child,\n'
          '  );\n'
          '}',
    },
    {
      'name': 'Scale Transform',
      'icon': Icons.zoom_in,
      'color': Colors.blue[700]!,
      'description': 'Scale up during push (growing into detail), '
          'scale down during pop (shrinking back to thumbnail).',
      'code': 'flightShuttleBuilder: (ctx, anim, dir, from, to) {\n'
          '  final scale = dir == HeroFlightDirection.push\n'
          '    ? Tween(begin: 0.8, end: 1.0).animate(anim)\n'
          '    : Tween(begin: 1.0, end: 0.8).animate(anim);\n'
          '  return ScaleTransition(\n'
          '    scale: scale,\n'
          '    child: to.widget,\n'
          '  );\n'
          '}',
    },
    {
      'name': 'Rotation + Fade',
      'icon': Icons.rotate_right,
      'color': Colors.indigo[600]!,
      'description': 'Spin slightly during push and counter-spin '
          'during pop. Adds a playful touch to the transition.',
      'code': 'flightShuttleBuilder: (ctx, anim, dir, from, to) {\n'
          '  final angle = dir == HeroFlightDirection.push\n'
          '    ? Tween(begin: -0.05, end: 0.0).animate(anim)\n'
          '    : Tween(begin: 0.0, end: 0.05).animate(anim);\n'
          '  return RotationTransition(\n'
          '    turns: angle,\n'
          '    child: to.widget,\n'
          '  );\n'
          '}',
    },
    {
      'name': 'Material Card Elevation',
      'icon': Icons.layers,
      'color': Colors.blue[600]!,
      'description': 'During push, elevate the shuttle to appear as '
          'if it lifts off. During pop, drop back down.',
      'code': 'flightShuttleBuilder: (ctx, anim, dir, from, to) {\n'
          '  final elev = dir == HeroFlightDirection.push\n'
          '    ? Tween(begin: 1.0, end: 8.0).animate(anim)\n'
          '    : Tween(begin: 8.0, end: 1.0).animate(anim);\n'
          '  return AnimatedBuilder(\n'
          '    animation: elev,\n'
          '    builder: (_, child) => Material(\n'
          '      elevation: elev.value, child: child),\n'
          '    child: to.widget,\n'
          '  );\n'
          '}',
    },
  ];

  print('  Prepared ${shuttleExamples.length} shuttle examples');

  // ============================================================
  // SECTION 6: Hero Configuration Properties
  // ============================================================
  print('=== Section 6: Hero Properties ===');

  final heroProps = <Map<String, dynamic>>[
    {
      'name': 'tag',
      'type': 'Object',
      'required': true,
      'icon': Icons.label,
      'color': Colors.indigo[700]!,
      'description': 'Identifier used to match heroes across routes. '
          'Must be unique within each route. Typically a String or '
          'an enum value.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'required': true,
      'icon': Icons.widgets,
      'color': Colors.blue[700]!,
      'description': 'The widget that participates in the hero flight. '
          'This is the visible content — an Image, Container, Text, '
          'or any widget tree.',
    },
    {
      'name': 'flightShuttleBuilder',
      'type': 'HeroFlightShuttleBuilder?',
      'required': false,
      'icon': Icons.flight,
      'color': Colors.indigo[600]!,
      'description': 'Custom builder for the in-flight widget. '
          'Receives HeroFlightDirection as one of its parameters. '
          'If null, the destination hero\'s child is used as the '
          'shuttle widget.',
    },
    {
      'name': 'placeholderBuilder',
      'type': 'HeroPlaceholderBuilder?',
      'required': false,
      'icon': Icons.crop_free,
      'color': Colors.blue[600]!,
      'description': 'Builder for the placeholder shown where the hero '
          'was after it starts flying. By default, an empty SizedBox '
          'with the hero\'s size is used to maintain layout.',
    },
    {
      'name': 'createRectTween',
      'type': 'CreateRectTween?',
      'required': false,
      'icon': Icons.gesture,
      'color': Colors.indigo[500]!,
      'description': 'Factory for the RectTween used to animate from '
          'source rect to destination rect. Default uses a '
          'MaterialRectArcTween (curved arc). Override for a '
          'straight-line or custom path.',
    },
    {
      'name': 'transitionOnUserGestures',
      'type': 'bool',
      'required': false,
      'icon': Icons.touch_app,
      'color': Colors.blue[500]!,
      'description': 'Whether the hero should fly during user-driven '
          'route transitions (e.g., iOS back swipe). Defaults to '
          'false. Set to true for seamless hero flights during '
          'interactive pop gestures.',
    },
  ];

  print('  Prepared ${heroProps.length} hero properties');

  // ============================================================
  // SECTION 7: Reverse Heroes & Direction Swapping
  // ============================================================
  print('=== Section 7: Reverse Heroes ===');

  final reverseCards = <Map<String, dynamic>>[
    {
      'title': 'What Changes on Pop?',
      'icon': Icons.swap_vert,
      'color': Colors.indigo[700]!,
      'bgColor': Colors.indigo[50]!,
      'body': 'During a push, fromHero is on the source route and '
          'toHero is on the destination route. During a pop, these '
          'swap — fromHero is on the popping route and toHero is '
          'on the route being revealed. The framework handles this '
          'automatically; your flightShuttleBuilder just needs to '
          'check the direction enum.',
    },
    {
      'title': 'Same Tag, Different Widget',
      'icon': Icons.difference,
      'color': Colors.blue[700]!,
      'bgColor': Colors.blue[50]!,
      'body': 'Heroes on different routes typically show different '
          'sizes or content (e.g., thumbnail → full image). The '
          'shuttle builder receives both contexts, so you can pick '
          'which child to show mid-flight based on direction. '
          'During push: prefer toHero\'s child. During pop: you '
          'might prefer fromHero\'s child.',
    },
    {
      'title': 'Interactive Pop Gesture',
      'icon': Icons.swipe,
      'color': Colors.indigo[600]!,
      'bgColor': Colors.indigo[50]!,
      'body': 'When using iOS-style back swipe, the pop animation '
          'is driven by the user\'s finger. The direction is pop, '
          'but the animation value goes from 0 to 1 as the user '
          'swipes further. If the user cancels, the animation '
          'reverses but the direction stays pop.',
    },
    {
      'title': 'pushReplacement Direction',
      'icon': Icons.find_replace,
      'color': Colors.blue[600]!,
      'bgColor': Colors.blue[50]!,
      'body': 'Even though pushReplacement replaces the current '
          'route, the hero flight direction is still push — '
          'navigation is going "forward" to a new route. The '
          'replacement aspect only affects the route stack, not '
          'the visual transition direction.',
    },
  ];

  print('  Prepared ${reverseCards.length} reverse cards');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Photo Gallery → Detail',
      'icon': Icons.photo_library,
      'color': Colors.indigo[700]!,
      'description': 'Grid of thumbnails → full-screen photo viewer. '
          'Push: thumbnail grows to fill screen with fade crossover. '
          'Pop: full photo shrinks back to grid position. Use '
          'direction to swap between thumbnail and full-res image '
          'during the flight.',
      'directions': {
        'push': 'Thumbnail expands, loads high-res',
        'pop': 'Full image shrinks to thumbnail position',
      },
    },
    {
      'name': 'Product Card → Product Page',
      'icon': Icons.shopping_bag,
      'color': Colors.blue[700]!,
      'description': 'Shopping app: product card hero flies to a '
          'detail page with larger image and description. Push '
          'flight can add a slight upward arc (MaterialRectArcTween). '
          'Pop flight can scale down with reduced elevation.',
      'directions': {
        'push': 'Card lifts off, elevation increases',
        'pop': 'Detail settles back into card slot',
      },
    },
    {
      'name': 'FAB → New Item Page',
      'icon': Icons.add_circle,
      'color': Colors.indigo[600]!,
      'description': 'FloatingActionButton hero flies to become the '
          'header of a creation form. On push, the FAB circle '
          'expands and morphs into a rectangular form header. On '
          'pop, the rectangle contracts back to a circle.',
      'directions': {
        'push': 'Circle → rectangle morph with expand',
        'pop': 'Rectangle → circle morph with contract',
      },
    },
    {
      'name': 'Avatar → Profile Page',
      'icon': Icons.person,
      'color': Colors.blue[600]!,
      'description': 'Small circular avatar in an app bar or list '
          'tile flies to a large profile image. Direction controls '
          'when to switch from low-res to high-res avatar: swap on '
          'push at animation value 0.5, swap on pop at 0.5.',
      'directions': {
        'push': 'Small avatar → large profile photo',
        'pop': 'Large photo → small avatar',
      },
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Default Shuttle Uses toHero Child',
      'body': 'If you don\'t provide a flightShuttleBuilder, the '
          'framework uses the toHero\'s child as the shuttle. This '
          'means on push you see the destination widget flying in, '
          'and on pop you see the source route\'s widget shrinking. '
          'Often this is fine — only customize if you need '
          'direction-dependent visuals.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Avoid Heavy Widgets in Shuttle',
      'body': 'The shuttle renders on every frame (60fps) during '
          'the transition. Avoid putting complex widget trees, '
          'network images without caching, or expensive paints '
          'in the shuttle. Pre-cache images and keep it light.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use createRectTween for Custom Paths',
      'body': 'The default MaterialRectArcTween creates a curved '
          'flight path. For a straight line, return a RectTween. '
          'The rect tween is independent of direction — it always '
          'goes from source to destination. Direction only affects '
          'which widget is source and which is destination.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Tags Must Match Exactly',
      'body': 'Hero tags are compared by operator==. If the tag on '
          'the push route doesn\'t match the tag on the pop route, '
          'no flight occurs. Common mistake: using different string '
          'literals instead of a shared constant.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'transitionOnUserGestures',
      'body': 'By default, heroes don\'t fly during interactive '
          'pop gestures (iOS swipe back). Set '
          'transitionOnUserGestures: true on BOTH heroes to enable '
          'this. The direction will be pop during the gesture.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'placeholderBuilder for Layout',
      'body': 'When the hero leaves its route during flight, a gap '
          'appears. Use placeholderBuilder to show a sized box or '
          'shimmer placeholder that prevents layout jumps. The '
          'placeholder receives the hero child\'s size.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('HeroFlightDirection'),
      backgroundColor: Colors.indigo[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[700]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.flight_takeoff,
                      color: Colors.white, size: 36),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward,
                      color: Colors.white70, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_back,
                      color: Colors.white70, size: 20),
                  SizedBox(width: 12),
                  Icon(Icons.flight_land,
                      color: Colors.white, size: 36),
                ]),
                SizedBox(height: 14),
                Text(
                  'HeroFlightDirection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An enum with two values — push and pop — that '
                  'tells Hero flight animations which direction the '
                  'navigation is going, enabling direction-dependent '
                  'shuttle widgets and transition effects.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _heroHead('1', 'What is HeroFlightDirection?'),
          SizedBox(height: 12),
          ...conceptItems.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: item['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(item['icon'] as IconData,
                            color: item['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(item['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(item['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Enum Values ──
          _heroHead('2', 'The Two Enum Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ev['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color:
                            (ev['color'] as Color).withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ev['color'] as Color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(ev['icon'] as IconData,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(ev['value'] as String,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: ev['color'] as Color)),
                              Text(ev['meaning'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 12),
                      ...[
                        ['Triggered by', ev['trigger'] as String],
                        ['From Route', ev['fromRoute'] as String],
                        ['To Route', ev['toRoute'] as String],
                        ['Hero Flight', ev['heroFlight'] as String],
                        ['Style', ev['animation'] as String],
                      ].map((pair) => Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(pair[0],
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700])),
                                ),
                                Expanded(
                                  child: Text(pair[1],
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700],
                                          height: 1.3)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Lifecycle ──
          _heroHead('3', 'Hero Animation Lifecycle'),
          SizedBox(height: 12),
          ...lifecycleSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${step['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                      if ((step['step'] as int) < 6)
                        Container(
                            width: 2,
                            height: 24,
                            color: Colors.grey[300]),
                    ]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(step['icon'] as IconData,
                                  color: step['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Text(step['title'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ]),
                            SizedBox(height: 4),
                            Text(step['description'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: FlightShuttleBuilder ──
          _heroHead('4', 'FlightShuttleBuilder Parameters'),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Widget Function(BuildContext, Animation<double>, '
              'HeroFlightDirection, BuildContext, BuildContext)',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.indigo[700]),
            ),
          ),
          ...builderParams.map((bp) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: bp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(bp['icon'] as IconData,
                            color: bp['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Text(bp['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: bp['color'] as Color)),
                        SizedBox(width: 8),
                        _heroChip(
                            bp['type'] as String, Colors.grey[600]!),
                      ]),
                      SizedBox(height: 4),
                      Text(bp['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Shuttle Examples ──
          _heroHead('5', 'Direction-Dependent Shuttles'),
          SizedBox(height: 12),
          ...shuttleExamples.map((se) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: se['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(se['icon'] as IconData,
                            color: se['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(se['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(se['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(se['code'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Hero Properties ──
          _heroHead('6', 'Hero Widget Properties'),
          SizedBox(height: 12),
          ...heroProps.map((hp) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: hp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(hp['icon'] as IconData,
                            color: hp['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Text(hp['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: hp['color'] as Color)),
                        SizedBox(width: 8),
                        _heroChip(
                            hp['type'] as String, Colors.grey[600]!),
                        if (hp['required'] == true) ...[
                          SizedBox(width: 6),
                          _heroChip('required', Colors.red[400]!),
                        ],
                      ]),
                      SizedBox(height: 4),
                      Text(hp['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Reverse Heroes ──
          _heroHead('7', 'Reverse Heroes & Direction Swapping'),
          SizedBox(height: 12),
          ...reverseCards.map((rc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: rc['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            (rc['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(rc['icon'] as IconData,
                            color: rc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: rc['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(rc['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _heroHead('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      ...((p['directions'] as Map<String, String>)
                          .entries
                          .map((e) => Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Row(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: e.key == 'push'
                                          ? Colors.indigo[100]
                                          : Colors.blue[100],
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                    child: Text(e.key.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight:
                                                FontWeight.bold,
                                            color: e.key == 'push'
                                                ? Colors.indigo[700]
                                                : Colors.blue[700])),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(e.value,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[700])),
                                  ),
                                ]),
                              ))),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _heroHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of HeroFlightDirection Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _heroHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small type/tag chip
// ──────────────────────────────────────────────────────────
Widget _heroChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
