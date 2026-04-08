// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DecorationTween
// Demonstrates DecorationTween, a Tween<Decoration> that
// interpolates between two Decoration values. Covers lerp
// mechanics for BoxDecoration (color, gradient, border, borderRadius,
// boxShadow, shape), ShapeDecoration, combined tween usage with
// AnimatedBuilder, DecorationImage interpolation, and real-world
// animation patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecorationTween Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DecorationTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.animation,
      'title': 'Tween for Decorations',
      'body': 'DecorationTween is a Tween<Decoration> that knows '
          'how to interpolate between two Decoration instances. '
          'When you specify a begin and end Decoration, it computes '
          'smooth intermediate values at every animation frame by '
          'calling Decoration.lerp().',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.color_lens,
      'title': 'Property-Level Interpolation',
      'body': 'Each sub-property of the Decoration is interpolated '
          'independently: color blends, border radius morphs, '
          'box shadows fade and shift, gradients cross-fade. '
          'The result is a visually smooth transition even between '
          'very different decoration styles.',
      'accent': Colors.cyan[800]!,
    },
    {
      'icon': Icons.category,
      'title': 'Works with BoxDecoration & ShapeDecoration',
      'body': 'The primary Decoration subclasses are BoxDecoration '
          'and ShapeDecoration. DecorationTween handles both. '
          'BoxDecoration.lerp() blends colors, borders, shadows, '
          'and gradients. ShapeDecoration.lerp() interpolates '
          'between different ShapeBorder geometries.',
      'accent': Colors.blueGrey[600]!,
    },
    {
      'icon': Icons.build_circle,
      'title': 'Usage in Animation',
      'body': 'Typically used with AnimatedBuilder + AnimationController:\n'
          '  final tween = DecorationTween(\n'
          '    begin: BoxDecoration(...),\n'
          '    end: BoxDecoration(...),\n'
          '  );\n'
          '  final decoration = tween.animate(controller);\n'
          'Or implicitly with AnimatedContainer\'s decoration property.',
      'accent': Colors.blueGrey[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  final apiMembers = <Map<String, dynamic>>[
    {
      'member': 'DecorationTween({begin, end})',
      'type': 'Constructor',
      'desc': 'Creates a tween between two Decoration values. Both '
          'begin and end should be the same Decoration subclass for '
          'best results (e.g., both BoxDecoration).',
      'icon': Icons.construction,
    },
    {
      'member': '.lerp(double t)',
      'type': 'Decoration',
      'desc': 'Returns the Decoration at progress t (0.0 = begin, '
          '1.0 = end). Calls Decoration.lerp(begin, end, t) which '
          'dispatches to the appropriate subclass lerp.',
      'icon': Icons.linear_scale,
    },
    {
      'member': '.begin',
      'type': 'Decoration?',
      'desc': 'The decoration at the start of the animation. '
          'When t = 0, the result equals begin.',
      'icon': Icons.first_page,
    },
    {
      'member': '.end',
      'type': 'Decoration?',
      'desc': 'The decoration at the end of the animation. '
          'When t = 1, the result equals end.',
      'icon': Icons.last_page,
    },
    {
      'member': '.animate(Animation<double>)',
      'type': 'Animation<Decoration>',
      'desc': 'Chains the tween with an Animation (usually from '
          'AnimationController) producing an Animation<Decoration> '
          'that can drive DecoratedBox or AnimatedBuilder.',
      'icon': Icons.play_arrow,
    },
    {
      'member': '.chain(Animatable<double>)',
      'type': 'Animatable<Decoration>',
      'desc': 'Composes with a CurveTween or other Animatable to '
          'apply easing. Example: tween.chain(CurveTween('
          'curve: Curves.easeInOut)).',
      'icon': Icons.link,
    },
  ];

  print('  Listed ${apiMembers.length} API members');

  // ============================================================
  // SECTION 3: BoxDecoration Lerp Properties
  // ============================================================
  print('=== Section 3: BoxDecoration Lerp ===');

  final lerpProperties = <Map<String, dynamic>>[
    {
      'property': 'color',
      'method': 'Color.lerp(a, b, t)',
      'icon': Icons.palette,
      'color': Colors.cyan[600]!,
      'detail': 'Blends between two colors in the RGB color space. '
          'At t=0.5 you get the midpoint. Opacity is also '
          'interpolated, so you can fade from opaque to transparent.',
    },
    {
      'property': 'gradient',
      'method': 'Gradient.lerp(a, b, t)',
      'icon': Icons.gradient,
      'color': Colors.purple[500]!,
      'detail': 'Interpolates gradient stops, colors, and geometry. '
          'Works between LinearGradient, RadialGradient, and '
          'SweepGradient. If types differ, it cross-fades.',
    },
    {
      'property': 'border',
      'method': 'BoxBorder.lerp(a, b, t)',
      'icon': Icons.border_all,
      'color': Colors.blue[600]!,
      'detail': 'Interpolates border width, color, and style for '
          'each side independently. Can transition from thin grey '
          'to thick colored borders smoothly.',
    },
    {
      'property': 'borderRadius',
      'method': 'BorderRadius.lerp(a, b, t)',
      'icon': Icons.rounded_corner,
      'color': Colors.teal[600]!,
      'detail': 'Each corner radius is interpolated independently. '
          'Can morph from square (radius 0) to circle '
          '(radius = half-side) smoothly.',
    },
    {
      'property': 'boxShadow',
      'method': 'BoxShadow.lerpList(a, b, t)',
      'icon': Icons.blur_on,
      'color': Colors.blueGrey[600]!,
      'detail': 'Interpolates shadow color, offset, blur radius, '
          'and spread radius. If the lists have different lengths, '
          'extra shadows fade in or out.',
    },
    {
      'property': 'shape',
      'method': 'Direct switch',
      'icon': Icons.crop_square,
      'color': Colors.deepOrange[500]!,
      'detail': 'BoxShape is either rectangle or circle. If begin '
          'and end have different shapes, the switch happens at '
          't=0.5 — there\'s no smooth morph between shapes. Use '
          'borderRadius instead for round corners.',
    },
  ];

  print('  Prepared ${lerpProperties.length} lerp property details');

  // ============================================================
  // SECTION 4: Visual Interpolation Showcase
  // ============================================================
  print('=== Section 4: Visual Interpolation ===');

  // Show 5 interpolation steps (t=0, 0.25, 0.5, 0.75, 1.0)
  final beginDeco = BoxDecoration(
    color: Colors.cyan[100]!,
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: Colors.cyan[300]!, width: 1),
    boxShadow: [
      BoxShadow(color: Colors.cyan.withOpacity(0.2), blurRadius: 2),
    ],
  );
  final endDeco = BoxDecoration(
    color: Colors.deepPurple[400]!,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.deepPurple[700]!, width: 3),
    boxShadow: [
      BoxShadow(
          color: Colors.deepPurple.withOpacity(0.4),
          blurRadius: 12,
          offset: Offset(0, 6)),
    ],
  );

  final tween = DecorationTween(begin: beginDeco, end: endDeco);
  final interpolationSteps = [0.0, 0.25, 0.5, 0.75, 1.0];
  final interpolatedDecos = <Map<String, dynamic>>[];
  for (final t in interpolationSteps) {
    interpolatedDecos.add({
      't': t,
      'label': 't = ${t.toStringAsFixed(2)}',
      'decoration': tween.lerp(t),
    });
  }

  print('  Computed ${interpolatedDecos.length} interpolation steps');

  // Second showcase: gradient transition
  final gradBegin = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.cyan[200]!, Colors.cyan[500]!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  );
  final gradEnd = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.deepPurple[300]!, Colors.pink[400]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  final gradTween = DecorationTween(begin: gradBegin, end: gradEnd);
  final gradSteps = <Map<String, dynamic>>[];
  for (final t in interpolationSteps) {
    gradSteps.add({
      't': t,
      'label': 't = ${t.toStringAsFixed(2)}',
      'decoration': gradTween.lerp(t),
    });
  }

  print('  Computed ${gradSteps.length} gradient interpolation steps');

  // ============================================================
  // SECTION 5: ShapeDecoration Lerp
  // ============================================================
  print('=== Section 5: ShapeDecoration ===');

  final shapeBegin = ShapeDecoration(
    color: Colors.cyan[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.cyan[400]!, width: 1),
    ),
  );
  final shapeEnd = ShapeDecoration(
    color: Colors.blueGrey[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
      side: BorderSide(color: Colors.blueGrey[300]!, width: 3),
    ),
  );

  final shapeTween = DecorationTween(begin: shapeBegin, end: shapeEnd);
  final shapeSteps = <Map<String, dynamic>>[];
  for (final t in interpolationSteps) {
    shapeSteps.add({
      't': t,
      'label': 't = ${t.toStringAsFixed(2)}',
      'decoration': shapeTween.lerp(t),
    });
  }

  print('  Computed ${shapeSteps.length} shape interpolation steps');

  final shapeDetails = <Map<String, dynamic>>[
    {
      'title': 'ShapeDecoration.lerp()',
      'icon': Icons.pentagon,
      'color': Colors.blueGrey[600]!,
      'body': 'Interpolates ShapeBorder, color, gradient, and shadows. '
          'If both shapes are OutlinedBorder (like RoundedRectangle'
          'Border, StadiumBorder, CircleBorder), the geometry '
          'morphs smoothly. Cross-type morphing uses ShapeBorder'
          '.lerp() which may produce intermediate shapes.',
    },
    {
      'title': 'Border + Shape Interpolation',
      'icon': Icons.border_style,
      'color': Colors.cyan[600]!,
      'body': 'OutlinedBorder\'s side (BorderSide) is interpolated: '
          'width, color, strokeAlign — all smoothly. This means a '
          'thin light border can grow into a thick dark one.',
    },
    {
      'title': 'Stadium ↔ RoundedRectangle',
      'icon': Icons.crop_16_9,
      'color': Colors.teal[500]!,
      'body': 'StadiumBorder and RoundedRectangleBorder can lerp '
          'smoothly because both are OutlinedBorder subclasses that '
          'share an interpolation path via borderRadius morphing.',
    },
  ];

  print('  Prepared ${shapeDetails.length} shape detail cards');

  // ============================================================
  // SECTION 6: Comparison Table
  // ============================================================
  print('=== Section 6: DecorationTween vs Others ===');

  final comparison = <Map<String, String>>[
    {
      'aspect': 'Type',
      'decoTween': 'Tween<Decoration>',
      'colorTween': 'Tween<Color?>',
      'borderTween': 'Tween<BorderRadius?>',
    },
    {
      'aspect': 'Interpolates',
      'decoTween': 'Entire Decoration (color, '
          'border, shadow, gradient, etc.)',
      'colorTween': 'Color only (r, g, b, a)',
      'borderTween': 'BorderRadius only '
          '(four corner radii)',
    },
    {
      'aspect': 'Use With',
      'decoTween': 'DecoratedBox, Container '
          'AnimatedBuilder',
      'colorTween': 'Any color property',
      'borderTween': 'ClipRRect, CardTheme, etc.',
    },
    {
      'aspect': 'Implicit Alt.',
      'decoTween': 'AnimatedContainer.decoration',
      'colorTween': 'AnimatedContainer.color',
      'borderTween': 'AnimatedContainer via deco',
    },
    {
      'aspect': 'Lerp Method',
      'decoTween': 'Decoration.lerp() dispatch',
      'colorTween': 'Color.lerp()',
      'borderTween': 'BorderRadius.lerp()',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Card Hover / Press Effect',
      'icon': Icons.touch_app,
      'color': Colors.cyan[600]!,
      'body': 'On hover or press, animate from a flat BoxDecoration '
          'to one with elevated shadow and colored border. Use '
          'DecorationTween with AnimationController to drive the '
          'transition on mouse enter/leave events.',
    },
    {
      'title': 'Theme-Aware Transitions',
      'icon': Icons.brightness_6,
      'color': Colors.blueGrey[600]!,
      'body': 'When switching themes (light → dark), use '
          'AnimatedContainer with decoration to morphe background, '
          'borders, and shadows together. The implicit animation '
          'uses DecorationTween internally.',
    },
    {
      'title': 'Selection Indicator',
      'icon': Icons.check_box,
      'color': Colors.green[600]!,
      'body': 'A selectable list item transitions from plain to '
          'highlighted decoration: background fill + accent border '
          '+ subtle shadow. Single DecorationTween handles all '
          'properties atomically.',
    },
    {
      'title': 'Step Progress',
      'icon': Icons.linear_scale,
      'color': Colors.deepPurple[500]!,
      'body': 'Animate stages: inactive (grey, flat) → active '
          '(colored, elevated) → complete (green, bordered). Chain '
          'DecorationTweens with TweenSequence for multi-step '
          'decoration changes.',
    },
    {
      'title': 'Image Reveal',
      'icon': Icons.image,
      'color': Colors.orange[600]!,
      'body': 'Transition from a solid color to a DecorationImage '
          'background. While begin/end are both BoxDecoration, the '
          'image property cross-fades. Combine with gradient overlay '
          'for a polished loading-to-content reveal.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 8: AnimatedContainer vs Explicit
  // ============================================================
  print('=== Section 8: Implicit vs Explicit Usage ===');

  final implicitVsExplicit = <Map<String, dynamic>>[
    {
      'title': 'Implicit: AnimatedContainer',
      'icon': Icons.auto_awesome,
      'color': Colors.cyan[600]!,
      'code': 'AnimatedContainer(\n'
          '  duration: Duration(milliseconds: 300),\n'
          '  decoration: isActive\n'
          '    ? activeDecoration\n'
          '    : inactiveDecoration,\n'
          '  child: content,\n'
          ')',
      'pros': 'Simple, no controller needed, auto-disposes.',
      'cons': 'Less control over timing, can\'t scrub or reverse '
          'programmatically.',
    },
    {
      'title': 'Explicit: Controller + DecorationTween',
      'icon': Icons.tune,
      'color': Colors.blueGrey[600]!,
      'code': 'final controller = AnimationController(...);\n'
          'final decoAnim = DecorationTween(\n'
          '  begin: inactiveDeco,\n'
          '  end: activeDeco,\n'
          ').animate(CurvedAnimation(\n'
          '  parent: controller,\n'
          '  curve: Curves.easeOut,\n'
          '));\n\n'
          'AnimatedBuilder(\n'
          '  animation: decoAnim,\n'
          '  builder: (ctx, child) => DecoratedBox(\n'
          '    decoration: decoAnim.value,\n'
          '    child: child,\n'
          '  ),\n'
          '  child: content,\n'
          ')',
      'pros': 'Full control: forward, reverse, repeat, scrub, chain.',
      'cons': 'More boilerplate, must dispose controller.',
    },
  ];

  print('  Prepared ${implicitVsExplicit.length} usage patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Same Decoration Type Required',
      'body': 'DecorationTween works best when begin and end are the '
          'same type (both BoxDecoration or both ShapeDecoration). '
          'Mixing types falls back to cross-fade which looks like '
          'an abrupt opacity swap rather than smooth morphing.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Gradient + Color Conflict',
      'body': 'BoxDecoration.color and .gradient shouldn\'t both be '
          'set. If begin uses color and end uses gradient (or vice '
          'versa), the lerp may produce unexpected results. Convert '
          'solid colors to single-color gradients first.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'BoxShadow List Length',
      'body': 'When begin has 1 shadow and end has 3, BoxShadow.'
          'lerpList adds transparent "phantom" shadows to pad the '
          'shorter list. This usually looks fine — extra shadows '
          'fade in from nothing.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Shape Jump at t=0.5',
      'body': 'If begin has BoxShape.rectangle and end has '
          'BoxShape.circle, the shape snaps at t=0.5. For smooth '
          'rectangle-to-circle morphs, keep BoxShape.rectangle '
          'and animate borderRadius instead.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Performance with Shadows',
      'body': 'Animating large box shadows (high blur, large spread) '
          'is relatively expensive. Each frame re-rasterizes the '
          'shadow. For 60fps animations, keep shadow counts low '
          'and blur radii reasonable.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Chain with CurveTween',
      'body': 'Apply easing for natural motion:\n'
          '  tween.chain(CurveTween(curve: Curves.easeInOutCubic))\n'
          'Without a curve, the interpolation is linear, which looks '
          'mechanical for UI animations.',
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
      title: Text('DecorationTween'),
      backgroundColor: Colors.cyan[700],
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
                colors: [Colors.cyan[700]!, Colors.blueGrey[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.animation, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DecorationTween',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tween<Decoration> that smoothly interpolates '
                  'between two Decoration values — morphing color, '
                  'gradient, border, border-radius, shadow, and '
                  'shape in one coordinated animation.',
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
          _heading('1', 'What is DecorationTween?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
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
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: API Surface ──
          _heading('2', 'API Surface'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.cyan[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Member', bold: true, white: true, flex: 3),
                  _cell('Returns', bold: true, white: true, flex: 2),
                  _cell('Description', bold: true, white: true, flex: 5),
                ]),
              ),
              ...apiMembers.asMap().entries.map((entry) {
                final idx = entry.key;
                final m = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(m['icon'] as IconData,
                                size: 13, color: Colors.cyan[500]),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(m['member'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace')),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(m['type'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.cyan[700])),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(m['desc'] as String,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[700])),
                      ),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 3: BoxDecoration Lerp Properties ──
          _heading('3', 'BoxDecoration Lerp — Property by Property'),
          SizedBox(height: 12),
          ...lerpProperties.map((lp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (lp['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(lp['icon'] as IconData,
                            color: lp['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('.${lp['property']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Spacer(),
                              Text(lp['method'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'monospace',
                                      color: Colors.grey[500])),
                            ]),
                            SizedBox(height: 6),
                            Text(lp['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Visual Interpolation ──
          _heading('4', 'Visual Interpolation — Box Decoration'),
          SizedBox(height: 8),
          Text(
            'Color + BorderRadius + Border + Shadow lerped together:',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          Row(
            children: interpolatedDecos.map((step) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Column(children: [
                    Container(
                      height: 56,
                      decoration: step['decoration'] as Decoration,
                    ),
                    SizedBox(height: 4),
                    Text(step['label'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontFamily: 'monospace'),
                        textAlign: TextAlign.center),
                  ]),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          Text(
            'Gradient lerp (LinearGradient direction + colors):',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          Row(
            children: gradSteps.map((step) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Column(children: [
                    Container(
                      height: 56,
                      decoration: step['decoration'] as Decoration,
                    ),
                    SizedBox(height: 4),
                    Text(step['label'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontFamily: 'monospace'),
                        textAlign: TextAlign.center),
                  ]),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 24),

          // ── Section 5: ShapeDecoration ──
          _heading('5', 'ShapeDecoration Interpolation'),
          SizedBox(height: 12),
          Row(
            children: shapeSteps.map((step) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Column(children: [
                    Container(
                      height: 56,
                      decoration: step['decoration'] as Decoration,
                    ),
                    SizedBox(height: 4),
                    Text(step['label'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontFamily: 'monospace'),
                        textAlign: TextAlign.center),
                  ]),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 14),
          ...shapeDetails.map((sd) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: sd['color'] as Color, width: 4),
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
                        Icon(sd['icon'] as IconData,
                            color: sd['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Text(sd['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ]),
                      SizedBox(height: 6),
                      Text(sd['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparison Table ──
          _heading('6', 'DecorationTween vs Other Tweens'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.cyan[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Aspect', bold: true, white: true, flex: 2),
                  _cell('DecorationTween', bold: true, white: true, flex: 3),
                  _cell('ColorTween', bold: true, white: true, flex: 3),
                  _cell('BorderRadiusTween', bold: true, white: true, flex: 3),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cell(row['aspect']!, bold: true, flex: 2),
                      _cell(row['decoTween']!, flex: 3),
                      _cell(row['colorTween']!, flex: 3),
                      _cell(row['borderTween']!, flex: 3),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Real-World Patterns ──
          _heading('7', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
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
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Implicit vs Explicit ──
          _heading('8', 'Implicit vs Explicit Animation'),
          SizedBox(height: 12),
          ...implicitVsExplicit.map((ie) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ie['color'] as Color, width: 4),
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
                        Icon(ie['icon'] as IconData,
                            color: ie['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(ie['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ie['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Row(children: [
                        Icon(Icons.add_circle_outline,
                            size: 14, color: Colors.green[600]),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(ie['pros'] as String,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.green[700])),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Row(children: [
                        Icon(Icons.remove_circle_outline,
                            size: 14, color: Colors.red[400]),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(ie['cons'] as String,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.red[600])),
                        ),
                      ]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _heading('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of DecorationTween Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.cyan[700],
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
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _cell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}
