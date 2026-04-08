// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, unnecessary_cast
// D4rt test script: Deep Demo — BoxConstraintsTween
// Demonstrates BoxConstraintsTween, which interpolates between two
// BoxConstraints values, enabling smooth animation of layout bounds.
// Covers min/max width/height, tight vs loose, constraint propagation,
// common patterns, and related tweens.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxConstraintsTween Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BoxConstraintsTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.aspect_ratio,
      'title': 'BoxConstraints Recap',
      'body': 'BoxConstraints define the min and max width and height '
          'that a widget may occupy. They flow down the widget tree: '
          'parent passes constraints to child, child picks a size '
          'within those bounds. Every RenderBox receives constraints '
          'during layout. Understanding constraints is foundational '
          'to understanding Flutter layout.',
      'accent': Colors.purple[700]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Why Animate Constraints?',
      'body': 'BoxConstraintsTween lets you smoothly transition from '
          'one set of min/max extents to another. This is useful '
          'for expandable panels, morphing containers, responsive '
          'layout transitions, and animated resize effects where '
          'the size should change gradually, not abruptly.',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.straighten,
      'title': 'Four Values Interpolated',
      'body': 'BoxConstraintsTween interpolates four doubles in '
          'parallel: minWidth, maxWidth, minHeight, maxHeight. '
          'At t=0.0 you get the begin constraints; at t=1.0 '
          'the end constraints; at t=0.5 each value is halfway '
          'between begin and end. The result is always a valid '
          'BoxConstraints (min ≤ max).',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.compare,
      'title': 'Tight vs Loose Constraints',
      'body': 'Tight constraints force an exact size (min == max). '
          'Loose constraints allow a range (min < max, with min '
          'often 0). BoxConstraintsTween can animate between tight '
          'and loose, or between two different tight values — the '
          'lerp handles all combinations naturally.',
      'accent': Colors.deepPurple[600]!,
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
      'name': 'BoxConstraintsTween({begin, end})',
      'type': 'Constructor',
      'desc': 'Creates a tween between two BoxConstraints values. '
          'Both are optional and nullable. If begin is null, '
          'interpolation starts from unconstrained.',
      'icon': Icons.build,
    },
    {
      'name': 'begin',
      'type': 'BoxConstraints?',
      'desc': 'The constraints at t=0.0. Defines the starting '
          'bounds for minWidth, maxWidth, minHeight, maxHeight.',
      'icon': Icons.first_page,
    },
    {
      'name': 'end',
      'type': 'BoxConstraints?',
      'desc': 'The constraints at t=1.0. Defines the ending bounds.',
      'icon': Icons.last_page,
    },
    {
      'name': 'lerp(double t)',
      'type': 'BoxConstraints?',
      'desc': 'Returns the interpolated BoxConstraints at progress t. '
          'Delegates to BoxConstraints.lerp(begin, end, t) which '
          'interpolates each of the four values independently.',
      'icon': Icons.trending_flat,
    },
    {
      'name': 'transform(double t)',
      'type': 'BoxConstraints?',
      'desc': 'Inherited from Tween. Called by the animation '
          'framework each frame. Equivalent to lerp(t).',
      'icon': Icons.transform,
    },
    {
      'name': 'animate(Animation<double>)',
      'type': 'Animation<BoxConstraints?>',
      'desc': 'Creates a driven animation from an AnimationController '
          'or CurvedAnimation whose value is the tweened constraints.',
      'icon': Icons.play_circle,
    },
  ];

  print('  Prepared ${apiMembers.length} API members');

  final apiWidgets = apiMembers.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData, color: Colors.purple[700], size: 22),
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
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.purple[800],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  m['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Visual Interpolation
  // ============================================================
  print('=== Section 3: Visual Interpolation ===');

  final constraintBegin = BoxConstraints(
    minWidth: 40,
    maxWidth: 80,
    minHeight: 30,
    maxHeight: 50,
  );

  final constraintEnd = BoxConstraints(
    minWidth: 120,
    maxWidth: 240,
    minHeight: 80,
    maxHeight: 160,
  );

  final cTween = BoxConstraintsTween(
    begin: constraintBegin,
    end: constraintEnd,
  );

  final steps = [0.0, 0.25, 0.5, 0.75, 1.0];

  final stepWidgets = steps.map<Widget>((t) {
    final c = cTween.lerp(t) as BoxConstraints;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color.lerp(
                  Colors.purple[200], Colors.deepPurple[600], t)!,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                't=${t.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Width: ${c.minWidth.toStringAsFixed(0)} – '
                  '${c.maxWidth.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[800],
                  ),
                ),
                Text(
                  'Height: ${c.minHeight.toStringAsFixed(0)} – '
                  '${c.maxHeight.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple[700],
                  ),
                ),
                Text(
                  c.isTight ? '(tight)' : '(loose)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  print('  Generated ${steps.length} interpolation steps');

  // ============================================================
  // SECTION 4: Constraint Categories
  // ============================================================
  print('=== Section 4: Constraint Categories ===');

  final categories = <Map<String, dynamic>>[
    {
      'name': 'Tight',
      'formula': 'minWidth == maxWidth && minHeight == maxHeight',
      'desc': 'Forces exactly one size. The child has no choice. '
          'Created by BoxConstraints.tight(Size) or '
          'BoxConstraints.tightFor(width, height).',
      'example': 'BoxConstraints.tight(Size(100, 100))',
      'color': Colors.purple[700]!,
    },
    {
      'name': 'Loose',
      'formula': 'minWidth == 0 && minHeight == 0',
      'desc': 'Allows any size from zero up to the max. The child '
          'can be as small as it wants. Created by '
          'BoxConstraints.loose(Size).',
      'example': 'BoxConstraints.loose(Size(200, 200))',
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'Bounded',
      'formula': 'maxWidth < infinity && maxHeight < infinity',
      'desc': 'Has finite upper bounds. Most real constraints are '
          'bounded — the screen or parent container provides '
          'a maximum.',
      'example': 'BoxConstraints(maxWidth: 300, maxHeight: 400)',
      'color': Colors.purple[500]!,
    },
    {
      'name': 'Unbounded',
      'formula': 'maxWidth == infinity or maxHeight == infinity',
      'desc': 'Has no upper bound in one or both axes. Occurs '
          'inside scrollable widgets where the scroll direction '
          'is unbounded.',
      'example': 'BoxConstraints(maxHeight: double.infinity)',
      'color': Colors.deepPurple[500]!,
    },
    {
      'name': 'Expanding',
      'formula': 'tight at infinity',
      'desc': 'Forces the child to be as large as possible. '
          'Created by BoxConstraints.expand(). Common in '
          'positioned overlays and full-screen widgets.',
      'example': 'BoxConstraints.expand()',
      'color': Colors.purple[800]!,
    },
  ];

  print('  Prepared ${categories.length} constraint categories');

  final categoryWidgets = categories.map<Widget>((cat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (cat['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (cat['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                cat['name'] as String,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: cat['color'] as Color,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (cat['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cat['formula'] as String,
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: 'monospace',
                    color: cat['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            cat['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (cat['color'] as Color).withOpacity(0.04),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              cat['example'] as String,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: (cat['color'] as Color).withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Animation Scenarios
  // ============================================================
  print('=== Section 5: Animation Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Expandable Panel',
      'icon': Icons.expand,
      'desc': 'Animate constraints from a collapsed height (tight '
          '48px) to an expanded height (tight 300px). The panel '
          'content reveals as the maxHeight grows.',
      'begin': 'tight(width: ∞, height: 48)',
      'end': 'tight(width: ∞, height: 300)',
      'color': Colors.purple[600]!,
    },
    {
      'title': 'Responsive Resize',
      'icon': Icons.devices,
      'desc': 'Animate from phone-sized constraints to tablet-sized '
          'constraints. Content reflows as the max width changes.',
      'begin': 'maxWidth: 360',
      'end': 'maxWidth: 720',
      'color': Colors.deepPurple[600]!,
    },
    {
      'title': 'Thumbnail to Full',
      'icon': Icons.photo_size_select_large,
      'desc': 'Animate from thumbnail-sized tight constraints to '
          'full-size tight constraints — a zoom effect without '
          'scaling (the content re-renders at the new size).',
      'begin': 'tight(80 × 80)',
      'end': 'tight(320 × 240)',
      'color': Colors.purple[700]!,
    },
    {
      'title': 'Tight to Loose',
      'icon': Icons.open_with,
      'desc': 'Animate from a tight constraint (fixed size) to a '
          'loose constraint (flexible). The child transitions '
          'from forced size to choosing its own intrinsic size.',
      'begin': 'tight(200 × 150)',
      'end': 'loose(max: 400 × 300)',
      'color': Colors.deepPurple[700]!,
    },
  ];

  print('  Prepared ${scenarios.length} animation scenarios');

  final scenarioWidgets = scenarios.map<Widget>((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (s['color'] as Color).withOpacity(0.08),
            (s['color'] as Color).withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (s['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(s['icon'] as IconData,
                  color: s['color'] as Color, size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  s['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: s['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            s['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (s['color'] as Color).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s['begin'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: s['color'] as Color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.arrow_forward,
                    size: 16,
                    color: (s['color'] as Color).withOpacity(0.5)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (s['color'] as Color).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s['end'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: s['color'] as Color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Constraint Propagation Visual
  // ============================================================
  print('=== Section 6: Constraint Propagation ===');

  final propagation = <Map<String, dynamic>>[
    {
      'level': 'Screen',
      'constraint': 'tight(360 × 640)',
      'icon': Icons.phone_android,
      'note': 'The screen imposes tight constraints matching '
          'the device size.',
    },
    {
      'level': 'Scaffold body',
      'constraint': 'tight(360 × 580)',
      'icon': Icons.web,
      'note': 'AppBar consumes 60px, so the remaining height '
          'is passed as tight constraints.',
    },
    {
      'level': 'Padding(16)',
      'constraint': 'tight(328 × 548)',
      'icon': Icons.space_bar,
      'note': 'Padding subtracts 32px from width and height, '
          'passing tighter constraints inward.',
    },
    {
      'level': 'ConstrainedBox (animated)',
      'constraint': 'animating between two values',
      'icon': Icons.animation,
      'note': 'BoxConstraintsTween drives ConstrainedBox, which '
          'applies the interpolated constraints to its child.',
    },
    {
      'level': 'Child widget',
      'constraint': 'picks size within bounds',
      'icon': Icons.check_box,
      'note': 'The child sizes itself within the animated '
          'constraints. As they change, the child adapts.',
    },
  ];

  print('  Prepared ${propagation.length} propagation levels');

  final propWidgets = propagation.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final p = entry.value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color.lerp(Colors.purple[200],
                    Colors.deepPurple[700], i / 4.0)!,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(p['icon'] as IconData,
                    size: 16, color: Colors.white),
              ),
            ),
            if (i < propagation.length - 1)
              Container(
                width: 2,
                height: 40,
                color: Colors.purple[200],
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      p['level'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      p['constraint'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: Colors.purple[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  p['note'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }).toList();

  // ============================================================
  // SECTION 7: Related Tweens & Widgets
  // ============================================================
  print('=== Section 7: Related Tweens & Widgets ===');

  final related = <Map<String, dynamic>>[
    {
      'name': 'SizeTween',
      'what': 'Interpolates Size (width, height)',
      'diff': 'Size has no min/max — it is a single value. '
          'BoxConstraintsTween handles the full min/max range.',
      'color': Colors.purple[600]!,
    },
    {
      'name': 'RectTween',
      'what': 'Interpolates Rect (position + size)',
      'diff': 'Rect includes position (left, top). Constraints '
          'are position-agnostic — only about size limits.',
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'AnimatedContainer',
      'what': 'Implicitly animates BoxDecoration, constraints, etc.',
      'diff': 'AnimatedContainer handles constraints animation '
          'internally. BoxConstraintsTween is for explicit '
          'animation with AnimationController.',
      'color': Colors.purple[500]!,
    },
    {
      'name': 'ConstrainedBox',
      'what': 'Applies additional constraints to child',
      'diff': 'ConstrainedBox is the static widget. Pair it with '
          'BoxConstraintsTween for manual animation, or use '
          'AnimatedContainer for implicit animation.',
      'color': Colors.deepPurple[500]!,
    },
  ];

  print('  Prepared ${related.length} related items');

  final relatedWidgets = related.map<Widget>((r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (r['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (r['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r['name'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: r['color'] as Color,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            r['what'] as String,
            style: TextStyle(
              fontSize: 11,
              color: (r['color'] as Color).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            r['diff'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Tips & Gotchas
  // ============================================================
  print('=== Section 8: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Maintain min ≤ max Invariant',
      'body': 'During interpolation, if begin has min > end\'s max '
          'at some t value, the result can violate min ≤ max. '
          'Always design begin and end so that the interpolation '
          'path stays valid at every t.',
      'warning': true,
    },
    {
      'tip': 'Use with ConstrainedBox',
      'body': 'Wrap a child in ConstrainedBox and drive its '
          'constraints property with a BoxConstraintsTween. '
          'The child will re-layout each frame as the constraints '
          'change, producing a smooth resize.',
      'warning': false,
    },
    {
      'tip': 'Unbounded Axes',
      'body': 'Avoid tweening to or from infinite constraints. '
          'Lerping between 100 and infinity produces huge values '
          'mid-animation that can cause layout overflow. Always '
          'use finite values in both begin and end.',
      'warning': true,
    },
    {
      'tip': 'Performance: Layout Cost',
      'body': 'Animating constraints triggers relayout every frame. '
          'Keep the subtree under the animated ConstrainedBox '
          'lightweight. Complex children (long lists, deep trees) '
          'will cause jank during constraint animation.',
      'warning': true,
    },
    {
      'tip': 'Prefer AnimatedContainer for Simple Cases',
      'body': 'If you just need a container to smoothly resize, '
          'AnimatedContainer is simpler — it internally handles '
          'the tween. BoxConstraintsTween is for when you need '
          'explicit control over the animation curve and timing.',
      'warning': false,
    },
  ];

  print('  Prepared ${tips.length} tips');

  final tipWidgets = tips.map<Widget>((t) {
    final isWarning = t['warning'] as bool;
    final color = isWarning ? Colors.orange[700]! : Colors.purple[700]!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isWarning ? Icons.warning_amber : Icons.lightbulb_outline,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t['tip'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    if (isWarning)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'GOTCHA',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  t['body'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('Assembling final layout...');

  Widget sectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[700]!, Colors.deepPurple[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  print('BoxConstraintsTween Deep Demo complete — returning widget');

  return Scaffold(
    appBar: AppBar(
      title: const Text('BoxConstraintsTween Deep Demo'),
      backgroundColor: Colors.purple[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[800]!, Colors.deepPurple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Icon(Icons.aspect_ratio,
                    color: Colors.white, size: 44),
                const SizedBox(height: 10),
                const Text(
                  'BoxConstraintsTween',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Smoothly interpolates between two BoxConstraints — '
                  'animating minWidth, maxWidth, minHeight, and '
                  'maxHeight for fluid layout transitions.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.purple[100],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Section 1: Concept
          sectionHeader('Concept', Icons.school),
          ...conceptWidgets,

          // Section 2: API Surface
          sectionHeader('API Surface', Icons.api),
          ...apiWidgets,

          // Section 3: Visual Interpolation
          sectionHeader('Interpolation Steps', Icons.gradient),
          ...stepWidgets,

          // Section 4: Constraint Categories
          sectionHeader('Constraint Categories', Icons.category),
          ...categoryWidgets,

          // Section 5: Animation Scenarios
          sectionHeader('Animation Scenarios', Icons.movie),
          ...scenarioWidgets,

          // Section 6: Constraint Propagation
          sectionHeader('Constraint Propagation', Icons.account_tree),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple[200]!),
            ),
            child: Column(
              children: propWidgets,
            ),
          ),

          // Section 7: Related Tweens
          sectionHeader('Related Tweens & Widgets', Icons.compare),
          ...relatedWidgets,

          // Section 8: Tips & Gotchas
          sectionHeader('Tips & Gotchas', Icons.tips_and_updates),
          ...tipWidgets,

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
