// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BorderRadiusTween
// Demonstrates BorderRadiusTween, a Tween subclass for smoothly
// interpolating between two BorderRadius values. Covers lerp
// visualization, asymmetric animations, combining with other tweens,
// common animation patterns, and real-world usage.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderRadiusTween Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BorderRadiusTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.animation,
      'title': 'Tweens in Flutter',
      'body': 'A Tween defines a mapping from an input range (0.0 to 1.0) '
          'to an output range of typed values. For example, Tween<double> '
          'maps 0.0→1.0 to begin→end doubles. Tweens are the building '
          'blocks of Flutter\'s animation system, used with '
          'AnimationController to drive smooth transitions.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.rounded_corner,
      'title': 'Why a Specific BorderRadius Tween?',
      'body': 'BorderRadius has four corners, each with its own x/y '
          'radius. Simple linear interpolation of a single number won\'t '
          'work — you need to interpolate all four Radius values '
          'independently. BorderRadiusTween handles this via '
          'BorderRadius.lerp(), ensuring smooth corner transitions.',
      'accent': Colors.teal[800]!,
    },
    {
      'icon': Icons.crop_square,
      'title': 'Circle ↔ Rectangle Morphing',
      'body': 'The most common use: animating from a rectangle (zero '
          'radius) to a circle (radius = half the side length), or any '
          'state in between. Think avatar reveal animations, card '
          'expansion, FAB morphing, or shape-shifting containers.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Asymmetric Corner Control',
      'body': 'BorderRadiusTween can animate asymmetric radii — for '
          'example, starting with only topLeft rounded and ending with '
          'all corners rounded. Each corner interpolates independently, '
          'creating fluid visual transitions.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  final apiMembers = <Map<String, dynamic>>[
    {
      'name': 'BorderRadiusTween({begin, end})',
      'type': 'Constructor',
      'desc': 'Creates a tween with optional begin and end BorderRadius '
          'values. Both default to null. Typically set begin and end '
          'before using with an Animation.',
      'icon': Icons.build,
    },
    {
      'name': 'begin',
      'type': 'BorderRadius?',
      'desc': 'The border radius at t=0.0 (animation start). Null means '
          'the tween starts from BorderRadius.zero.',
      'icon': Icons.first_page,
    },
    {
      'name': 'end',
      'type': 'BorderRadius?',
      'desc': 'The border radius at t=1.0 (animation end). Null means '
          'the tween ends at BorderRadius.zero.',
      'icon': Icons.last_page,
    },
    {
      'name': 'lerp(double t)',
      'type': 'BorderRadius?',
      'desc': 'Returns the interpolated BorderRadius at progress t '
          '(0.0 to 1.0). Delegates to BorderRadius.lerp(begin, end, t). '
          'Called internally by the animation framework.',
      'icon': Icons.linear_scale,
    },
    {
      'name': 'transform(double t)',
      'type': 'BorderRadius?',
      'desc': 'Inherited from Tween. Returns lerp(t) after applying the '
          'curve transform. Same as lerp for linear animations.',
      'icon': Icons.transform,
    },
    {
      'name': 'animate(Animation<double>)',
      'type': 'Animation<BorderRadius?>',
      'desc': 'Inherited from Animatable. Chains this tween with a '
          'parent animation (like an AnimationController) to produce '
          'an Animation<BorderRadius?> that changes over time.',
      'icon': Icons.play_arrow,
    },
    {
      'name': 'chain(Animatable<double>)',
      'type': 'Animatable<BorderRadius?>',
      'desc': 'Inherited from Animatable. Composes with another animatable '
          '(e.g., CurveTween) so the tween uses a curved input (ease-in, '
          'bounce, etc.).',
      'icon': Icons.link,
    },
  ];

  final apiWidgets = apiMembers.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.teal[600]!, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData, color: Colors.teal[600], size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.teal[400],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  m['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Lerp Visualization — t=0 through t=1
  // ============================================================
  print('=== Section 3: Lerp Visualization ===');

  final tween = BorderRadiusTween(
    begin: BorderRadius.zero,
    end: BorderRadius.circular(40),
  );

  final lerpSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

  final lerpWidgets = lerpSteps.map<Widget>((t) {
    final radius = tween.lerp(t) ?? BorderRadius.zero;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.15 + t * 0.35),
            borderRadius: radius,
            border: Border.all(color: Colors.teal[700]!, width: 2),
          ),
          child: Center(
            child: Text(
              't=${t.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${radius.topLeft.x.toStringAsFixed(0)}px',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: Colors.teal[600],
          ),
        ),
      ],
    );
  }).toList();

  // Second visualization: rectangle → pill shape
  final pillTween = BorderRadiusTween(
    begin: BorderRadius.circular(4),
    end: BorderRadius.circular(28),
  );

  final pillSteps = lerpSteps.map<Widget>((t) {
    final radius = pillTween.lerp(t) ?? BorderRadius.zero;
    return Column(
      children: [
        Container(
          width: 90,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.cyan.withOpacity(0.15 + t * 0.3),
            borderRadius: radius,
            border: Border.all(color: Colors.cyan[700]!, width: 2),
          ),
          child: Center(
            child: Text(
              't=${t.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[900],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${radius.topLeft.x.toStringAsFixed(0)}px',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: Colors.cyan[600],
          ),
        ),
      ],
    );
  }).toList();

  // ============================================================
  // SECTION 4: Animated Container Gallery
  // ============================================================
  print('=== Section 4: Animation Gallery ===');

  final animExamples = <Map<String, dynamic>>[
    {
      'label': 'Square → Circle',
      'begin': BorderRadius.zero,
      'end': BorderRadius.circular(50),
      'color': Colors.teal[600]!,
      'size': 80.0,
    },
    {
      'label': 'Slight → Full Round',
      'begin': BorderRadius.circular(4),
      'end': BorderRadius.circular(40),
      'color': Colors.cyan[600]!,
      'size': 80.0,
    },
    {
      'label': 'Circle → Square',
      'begin': BorderRadius.circular(50),
      'end': BorderRadius.zero,
      'color': Colors.teal[800]!,
      'size': 80.0,
    },
    {
      'label': 'Asymmetric Morph',
      'begin': const BorderRadius.only(
        topLeft: Radius.circular(40),
      ),
      'end': const BorderRadius.only(
        bottomRight: Radius.circular(40),
      ),
      'color': Colors.deepPurple[400]!,
      'size': 80.0,
    },
  ];

  final galleryWidgets = animExamples.map<Widget>((ex) {
    final exTween = BorderRadiusTween(
      begin: ex['begin'] as BorderRadius,
      end: ex['end'] as BorderRadius,
    );
    // Show begin (t=0), middle (t=0.5), end (t=1)
    final stages = [0.0, 0.5, 1.0];
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (ex['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (ex['color'] as Color).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ex['label'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: ex['color'] as Color,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: stages.map<Widget>((t) {
              final r = exTween.lerp(t) ?? BorderRadius.zero;
              return Column(
                children: [
                  Container(
                    width: ex['size'] as double,
                    height: ex['size'] as double,
                    decoration: BoxDecoration(
                      color: (ex['color'] as Color).withOpacity(0.2 + t * 0.3),
                      borderRadius: r,
                      border: Border.all(
                        color: ex['color'] as Color,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        't=${t.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: ex['color'] as Color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t == 0 ? 'begin' : (t == 1 ? 'end' : 'mid'),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Asymmetric Border Radius Animations
  // ============================================================
  print('=== Section 5: Asymmetric Animations ===');

  final asymmetricExamples = <Map<String, dynamic>>[
    {
      'title': 'Top-Only → All Corners',
      'begin': const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      'end': BorderRadius.circular(30),
      'desc': 'Common in bottom sheets or modal transitions where '
          'the top is rounded and the bottom animates into rounded.',
      'color': Colors.teal[700]!,
    },
    {
      'title': 'Diagonal Pattern',
      'begin': const BorderRadius.only(
        topLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      'end': const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(40),
      ),
      'desc': 'Diagonal corner animation — useful for decorative '
          'morphing effects, loading indicators, or playful UIs.',
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Single Corner Expand',
      'begin': const BorderRadius.only(
        topLeft: Radius.circular(50),
      ),
      'end': BorderRadius.circular(50),
      'desc': 'Start with one dramatically rounded corner and expand '
          'rounding to all corners. Great for reveal animations.',
      'color': Colors.deepPurple[500]!,
    },
  ];

  final asymWidgets = asymmetricExamples.map<Widget>((ex) {
    final asTween = BorderRadiusTween(
      begin: ex['begin'] as BorderRadius,
      end: ex['end'] as BorderRadius,
    );
    final steps = [0.0, 0.33, 0.67, 1.0];
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (ex['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (ex['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ex['title'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: ex['color'] as Color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ex['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.3),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: steps.map<Widget>((t) {
              final r = asTween.lerp(t) ?? BorderRadius.zero;
              return Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (ex['color'] as Color).withOpacity(0.2 + t * 0.25),
                      borderRadius: r,
                      border: Border.all(
                          color: ex['color'] as Color, width: 1.5),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    't=${t.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'monospace',
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Combining with Other Tweens
  // ============================================================
  print('=== Section 6: Combining Tweens ===');

  // Show how BorderRadiusTween pairs with ColorTween and other tweens
  final comboTweens = <Map<String, dynamic>>[
    {
      'name': 'BorderRadiusTween + ColorTween',
      'desc': 'Smoothly morph both shape and color simultaneously. '
          'The container goes from a grey rectangle to a teal circle.',
      'icon': Icons.palette,
      'color': Colors.teal[700]!,
      'radiusBegin': BorderRadius.circular(4),
      'radiusEnd': BorderRadius.circular(40),
      'colorBegin': Colors.grey[300]!,
      'colorEnd': Colors.teal[400]!,
    },
    {
      'name': 'BorderRadiusTween + SizeTween',
      'desc': 'Change corners while growing or shrinking. Useful for '
          'FAB-to-dialog transitions where a small circle expands '
          'into a large rounded rectangle.',
      'icon': Icons.crop_free,
      'color': Colors.cyan[700]!,
      'radiusBegin': BorderRadius.circular(30),
      'radiusEnd': BorderRadius.circular(12),
      'colorBegin': Colors.cyan[400]!,
      'colorEnd': Colors.cyan[200]!,
    },
    {
      'name': 'BorderRadiusTween + DecorationTween',
      'desc': 'Animate the entire BoxDecoration including shadows, '
          'gradients, and border radius together for rich visual '
          'transitions.',
      'icon': Icons.gradient,
      'color': Colors.deepPurple[600]!,
      'radiusBegin': BorderRadius.circular(0),
      'radiusEnd': BorderRadius.circular(24),
      'colorBegin': Colors.deepPurple[100]!,
      'colorEnd': Colors.deepPurple[400]!,
    },
  ];

  final comboWidgets = comboTweens.map<Widget>((combo) {
    final rTween = BorderRadiusTween(
      begin: combo['radiusBegin'] as BorderRadius,
      end: combo['radiusEnd'] as BorderRadius,
    );
    final cTween = ColorTween(
      begin: combo['colorBegin'] as Color,
      end: combo['colorEnd'] as Color,
    );
    final steps = [0.0, 0.5, 1.0];
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (combo['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (combo['color'] as Color).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(combo['icon'] as IconData,
                  color: combo['color'] as Color, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  combo['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: combo['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            combo['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.3),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: steps.map<Widget>((t) {
              final r = rTween.lerp(t) ?? BorderRadius.zero;
              final c = cTween.lerp(t) ?? Colors.grey;
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: r,
                      border: Border.all(
                        color: (combo['color'] as Color).withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        't=${t.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t == 0 ? 'begin' : (t == 1 ? 'end' : 'mid'),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Common Animation Patterns
  // ============================================================
  print('=== Section 7: Common Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Circle ↔ Rectangle Morph',
      'desc': 'The classic shape morph. Start as a circle (radius = '
          'half width), animate to rectangle (radius = 0). Used in '
          'hero transitions, avatar reveals, and FAB animations.',
      'code': 'BorderRadiusTween(\n'
          '  begin: BorderRadius.circular(50),\n'
          '  end: BorderRadius.zero,\n'
          ')',
      'icon': Icons.crop_square,
      'color': Colors.teal[700]!,
    },
    {
      'title': 'Card Corner Softening',
      'desc': 'Animate from sharp corners to soft rounded corners when '
          'a card is selected or expanded. Gives a tactile feel.',
      'code': 'BorderRadiusTween(\n'
          '  begin: BorderRadius.circular(4),\n'
          '  end: BorderRadius.circular(20),\n'
          ')',
      'icon': Icons.rounded_corner,
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Bottom Sheet Appearance',
      'desc': 'Bottom sheets typically have rounded top corners that '
          'might become sharper as the sheet expands to full screen.',
      'code': 'BorderRadiusTween(\n'
          '  begin: BorderRadius.vertical(\n'
          '    top: Radius.circular(28),\n'
          '  ),\n'
          '  end: BorderRadius.zero,\n'
          ')',
      'icon': Icons.vertical_align_top,
      'color': Colors.indigo[600]!,
    },
    {
      'title': 'Pill / Stadium Shape',
      'desc': 'Animate a rectangular button into a pill (stadium) shape '
          'by increasing the radius to half the height.',
      'code': 'BorderRadiusTween(\n'
          '  begin: BorderRadius.circular(8),\n'
          '  end: BorderRadius.circular(24),\n'
          ')',
      'icon': Icons.smart_button,
      'color': Colors.purple[600]!,
    },
  ];

  final patternWidgets = patterns.map<Widget>((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (p['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (p['color'] as Color).withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData,
                  color: p['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: p['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            p['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              p['code'] as String,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.greenAccent,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Patterns & Pitfalls
  // ============================================================
  print('=== Section 8: Patterns & Pitfalls ===');

  final tips = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Use with AnimatedContainer for implicit animations',
      'detail': 'AnimatedContainer animates border radius changes '
          'automatically. You don\'t need BorderRadiusTween explicitly — '
          'just change the borderRadius property and AnimatedContainer '
          'handles the interpolation internally.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Chain with CurveTween for easing',
      'detail': 'tween.chain(CurveTween(curve: Curves.easeInOut)) applies '
          'easing to the interpolation, making the animation feel more '
          'natural. Always prefer curved animations over linear.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'TweenAnimationBuilder for stateless use',
      'detail': 'TweenAnimationBuilder<BorderRadius?> lets you define '
          'a BorderRadiusTween animation without managing an '
          'AnimationController. Great for one-shot or simple animations.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Radius larger than half the widget dimension',
      'detail': 'Setting radius to 100 on a 60px container won\'t look '
          'more circular — it will just be clamped. For a true circle, '
          'use radius = min(width, height) / 2.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Null begin or end',
      'detail': 'If you forget to set begin or end, BorderRadius.lerp '
          'treats null as BorderRadius.zero. This may not be what you '
          'want if the starting state should be rounded.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'type': 'pitfall',
      'title': 'Performance with complex shapes',
      'detail': 'Very rapid border radius animations on large widgets '
          'with shadows can be expensive. Use RepaintBoundary if '
          'performance suffers, and keep shadows simple during animation.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final tipWidgets = tips.map<Widget>((tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: tip['color'] as Color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tip['icon'] as IconData,
              color: tip['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (tip['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (tip['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tip['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tip['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'API members', 'value': '${apiMembers.length}', 'icon': Icons.code},
    {'label': 'Lerp steps', 'value': '${lerpSteps.length}', 'icon': Icons.linear_scale},
    {'label': 'Gallery demos', 'value': '${animExamples.length}', 'icon': Icons.grid_view},
    {'label': 'Asymmetric demos', 'value': '${asymmetricExamples.length}', 'icon': Icons.crop_rotate},
    {'label': 'Combo tweens', 'value': '${comboTweens.length}', 'icon': Icons.link},
    {'label': 'Tips & pitfalls', 'value': '${tips.length}', 'icon': Icons.lightbulb},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.withOpacity(0.15),
              Colors.teal.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData,
                color: Colors.teal[700], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget brtSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[800]!, Colors.teal[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('BorderRadiusTween Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('BorderRadiusTween'),
      backgroundColor: Colors.teal[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[800]!, Colors.teal[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.rounded_corner,
                    color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'BorderRadiusTween',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'A Tween subclass that interpolates between two '
                  'BorderRadius values using BorderRadius.lerp(). '
                  'Essential for smoothly animating corner rounding — '
                  'circle↔rectangle morphs, card expansions, and more.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1
          brtSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          brtSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          // Section 3
          brtSectionHeader('3', 'Lerp Visualization', Icons.linear_scale),
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Square → Circle (0 → 40px radius)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                      fontSize: 13,
                    )),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: lerpWidgets,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.cyan.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rectangle → Pill (4px → 28px radius)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[700],
                      fontSize: 13,
                    )),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pillSteps,
                ),
              ],
            ),
          ),

          // Section 4
          brtSectionHeader('4', 'Animation Gallery', Icons.grid_view),
          ...galleryWidgets,

          // Section 5
          brtSectionHeader('5', 'Asymmetric Animations', Icons.crop_rotate),
          ...asymWidgets,

          // Section 6
          brtSectionHeader('6', 'Combining Tweens', Icons.link),
          ...comboWidgets,

          // Section 7
          brtSectionHeader('7', 'Common Patterns', Icons.pattern),
          ...patternWidgets,

          // Section 8
          brtSectionHeader('8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...tipWidgets,

          // Section 9
          brtSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
