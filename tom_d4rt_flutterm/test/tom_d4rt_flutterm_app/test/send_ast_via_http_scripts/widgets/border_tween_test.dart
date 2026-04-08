// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BorderTween
// Demonstrates BorderTween, an interpolation between two Border
// values for smooth animation of container borders. Covers all
// four sides, lerp behavior, use with AnimationController,
// combined with other tweens, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderTween Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BorderTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.border_all,
      'title': 'Tweens in Flutter',
      'body': 'A Tween<T> defines the mapping from a 0.0–1.0 '
          'animation value to a concrete value of type T. For '
          'example Tween<double>(begin: 0, end: 100) maps the '
          'animation progress to a number between 0 and 100. '
          'Flutter provides specialized tweens for complex types '
          'like Color, Offset, Rect, Decoration — and Border.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.border_style,
      'title': 'What is Border?',
      'body': 'A Border describes the four sides of a rectangle, '
          'each as a BorderSide with color, width, and style. '
          'Borders are commonly used in BoxDecoration for '
          'Container widgets. Unlike BorderRadius (which tweens '
          'corner radii), Border tweens the sides themselves — '
          'their color, width, and stroke style.',
      'accent': Colors.cyan[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'BorderTween Purpose',
      'body': 'BorderTween smoothly interpolates between two '
          'Border values. At t=0.0 you get the begin Border; '
          'at t=1.0 you get the end Border; at any t in between '
          'you get a proportionally blended Border. Each side\'s '
          'color and width are lerp\'d independently, producing '
          'natural-looking transitions.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Lerp Under the Hood',
      'body': 'BorderTween.lerp(t) delegates to Border.lerp(a, b, t), '
          'which calls BorderSide.lerp() on each of the four sides. '
          'BorderSide.lerp blends the color (Color.lerp) and '
          'width (double lerp). If a side goes from width 0 to '
          'width 4, at t=0.5 it will have width 2.',
      'accent': Colors.cyan[600]!,
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
      'name': 'BorderTween({begin, end})',
      'type': 'Constructor',
      'desc': 'Creates a tween that interpolates between two Border? '
          'values. Both begin and end are optional and nullable. '
          'If begin is null, the animation starts from no border.',
      'icon': Icons.build,
    },
    {
      'name': 'begin',
      'type': 'Border?',
      'desc': 'The border value at the start of the animation (t=0). '
          'Can be null, in which case the lerp starts from a '
          'transparent zero-width border.',
      'icon': Icons.first_page,
    },
    {
      'name': 'end',
      'type': 'Border?',
      'desc': 'The border value at the end of the animation (t=1). '
          'Can be null, producing a fade-out of the begin border.',
      'icon': Icons.last_page,
    },
    {
      'name': 'lerp(double t)',
      'type': 'Border?',
      'desc': 'Returns the interpolated Border at the given progress. '
          'Delegates to Border.lerp(begin, end, t). The t parameter '
          'can exceed 0–1 range if used with curves like '
          'ElasticOut (overshooting).',
      'icon': Icons.trending_flat,
    },
    {
      'name': 'transform(double t)',
      'type': 'Border?',
      'desc': 'Inherited from Tween. Equivalent to lerp(t). This is '
          'what the Animation framework calls on each tick to '
          'get the current interpolated value.',
      'icon': Icons.transform,
    },
    {
      'name': 'animate(Animation<double>)',
      'type': 'Animation<Border?>',
      'desc': 'Returns an Animation whose value is the tweened Border '
          'at each point. Pass an AnimationController or '
          'CurvedAnimation to drive the tween.',
      'icon': Icons.play_circle,
    },
  ];

  print('  Prepared ${apiMembers.length} API members');

  final apiWidgets = apiMembers.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.cyan[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.cyan[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData, color: Colors.cyan[700], size: 22),
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
                          color: Colors.cyan[900],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.cyan[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.cyan[800],
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
  // SECTION 3: Visual Interpolation Steps
  // ============================================================
  print('=== Section 3: Visual Interpolation Steps ===');

  // Show how a border looks at different t values
  final borderBegin = Border(
    top: BorderSide(color: Colors.cyan[300]!, width: 1),
    right: BorderSide(color: Colors.cyan[300]!, width: 1),
    bottom: BorderSide(color: Colors.cyan[300]!, width: 1),
    left: BorderSide(color: Colors.cyan[300]!, width: 1),
  );

  final borderEnd = Border(
    top: BorderSide(color: Colors.teal[800]!, width: 6),
    right: BorderSide(color: Colors.cyan[800]!, width: 4),
    bottom: BorderSide(color: Colors.teal[800]!, width: 6),
    left: BorderSide(color: Colors.cyan[800]!, width: 4),
  );

  final tween = BorderTween(begin: borderBegin, end: borderEnd);
  final steps = [0.0, 0.25, 0.5, 0.75, 1.0];

  final stepWidgets = steps.map<Widget>((t) {
    final interpolated = tween.lerp(t);
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            border: interpolated,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              't=${t.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[800],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${t * 100}%',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }).toList();

  print('  Generated ${steps.length} interpolation visualizations');

  // ============================================================
  // SECTION 4: Per-Side Breakdown
  // ============================================================
  print('=== Section 4: Per-Side Breakdown ===');

  final sides = <Map<String, dynamic>>[
    {
      'side': 'Top',
      'begin': 'cyan[300] @ 1px',
      'end': 'teal[800] @ 6px',
      'icon': Icons.border_top,
      'color': Colors.teal[600]!,
    },
    {
      'side': 'Right',
      'begin': 'cyan[300] @ 1px',
      'end': 'cyan[800] @ 4px',
      'icon': Icons.border_right,
      'color': Colors.cyan[700]!,
    },
    {
      'side': 'Bottom',
      'begin': 'cyan[300] @ 1px',
      'end': 'teal[800] @ 6px',
      'icon': Icons.border_bottom,
      'color': Colors.teal[600]!,
    },
    {
      'side': 'Left',
      'begin': 'cyan[300] @ 1px',
      'end': 'cyan[800] @ 4px',
      'icon': Icons.border_left,
      'color': Colors.cyan[700]!,
    },
  ];

  final sideWidgets = sides.map<Widget>((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (s['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(s['icon'] as IconData,
              color: s['color'] as Color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${s['side']} Side',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: s['color'] as Color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Begin: ${s['begin']}  →  End: ${s['end']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward,
              size: 16, color: (s['color'] as Color).withOpacity(0.5)),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Asymmetric Border Scenarios
  // ============================================================
  print('=== Section 5: Asymmetric Border Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Bottom-Only Highlight',
      'desc': 'Animate only the bottom border from thin grey to '
          'thick accent color — common for underline-style tabs '
          'and input fields.',
      'begin': Border(
        bottom: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      'end': Border(
        bottom: BorderSide(color: Colors.cyan[700]!, width: 3),
      ),
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Left Accent Bar',
      'desc': 'Animate a left accent border from invisible to a '
          'prominent stripe — used in selected list items '
          'and quote blocks.',
      'begin': Border(
        left: BorderSide(color: Colors.transparent, width: 0),
      ),
      'end': Border(
        left: BorderSide(color: Colors.teal[600]!, width: 4),
      ),
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Full Border Glow',
      'desc': 'Animate all four sides from thin subtle to thick '
          'prominent — used for selection indicators, focus '
          'rings, and validation states.',
      'begin': Border.all(color: Colors.grey[200]!, width: 1),
      'end': Border.all(color: Colors.cyan[600]!, width: 3),
      'color': Colors.cyan[600]!,
    },
    {
      'title': 'Horizontal Emphasis',
      'desc': 'Animate top and bottom borders while leaving left '
          'and right unchanged — used for headers, dividers, '
          'and horizontal group separators.',
      'begin': Border(
        top: BorderSide(color: Colors.grey[200]!, width: 1),
        bottom: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      'end': Border(
        top: BorderSide(color: Colors.teal[700]!, width: 3),
        bottom: BorderSide(color: Colors.teal[700]!, width: 3),
      ),
      'color': Colors.teal[700]!,
    },
  ];

  print('  Prepared ${scenarios.length} asymmetric scenarios');

  final scenarioWidgets = scenarios.map<Widget>((s) {
    final scenarioTween =
        BorderTween(begin: s['begin'] as Border, end: s['end'] as Border);
    final mid = scenarioTween.lerp(0.5);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (s['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s['title'] as String,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: s['color'] as Color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            s['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBorderPreview('Begin', s['begin'] as Border),
              Icon(Icons.arrow_forward,
                  size: 16, color: Colors.grey[400]),
              _buildBorderPreview('t=0.5', mid),
              Icon(Icons.arrow_forward,
                  size: 16, color: Colors.grey[400]),
              _buildBorderPreview('End', s['end'] as Border),
            ],
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Related Tweens Comparison
  // ============================================================
  print('=== Section 6: Related Tweens Comparison ===');

  final relatedTweens = <Map<String, dynamic>>[
    {
      'name': 'BorderTween',
      'target': 'Border (4 sides)',
      'use': 'Animate border color/width per side',
      'icon': Icons.border_all,
      'color': Colors.cyan[700]!,
    },
    {
      'name': 'BorderRadiusTween',
      'target': 'BorderRadius (4 corners)',
      'use': 'Animate corner rounding',
      'icon': Icons.rounded_corner,
      'color': Colors.teal[600]!,
    },
    {
      'name': 'DecorationTween',
      'target': 'Decoration (full box)',
      'use': 'Animate entire BoxDecoration including border, '
          'radius, color, shadow, gradient at once',
      'icon': Icons.style,
      'color': Colors.indigo[600]!,
    },
    {
      'name': 'ColorTween',
      'target': 'Color',
      'use': 'Animate a single color (useful for background '
          'behind a border)',
      'icon': Icons.palette,
      'color': Colors.purple[600]!,
    },
    {
      'name': 'Tween<double>',
      'target': 'double',
      'use': 'Animate a single border width if only one side '
          'changes width',
      'icon': Icons.straighten,
      'color': Colors.orange[600]!,
    },
  ];

  print('  Prepared ${relatedTweens.length} related tweens');

  final relatedWidgets = relatedTweens.map<Widget>((rt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (rt['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (rt['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(rt['icon'] as IconData,
              color: rt['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rt['name'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: rt['color'] as Color,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'Animates: ${rt['target']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: (rt['color'] as Color).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rt['use'] as String,
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
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Selected Card',
      'icon': Icons.check_box_outline_blank,
      'scenario': 'A card grid where tapping a card animates its '
          'border from subtle grey to a bold accent color, '
          'giving clear selection feedback without layout shift.',
      'color': Colors.cyan[600]!,
    },
    {
      'title': 'Validation Feedback',
      'icon': Icons.error_outline,
      'scenario': 'An input field whose border animates from the '
          'default grey to red when validation fails, or to '
          'green when input is valid. BorderTween makes the '
          'transition smooth rather than jarring.',
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Tab Indicator',
      'icon': Icons.tab,
      'scenario': 'A custom tab bar where the bottom border of the '
          'active tab animates from thin to thick as the user '
          'switches between tabs.',
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Focus Ring Animation',
      'icon': Icons.center_focus_strong,
      'scenario': 'An accessibility-focused widget that animates a '
          'border ring when it receives keyboard focus, growing '
          'from zero width to a visible highlight.',
      'color': Colors.teal[700]!,
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  final patternWidgets = patterns.map<Widget>((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (p['color'] as Color).withOpacity(0.08),
            (p['color'] as Color).withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (p['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(p['icon'] as IconData,
              color: p['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: p['color'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  p['scenario'] as String,
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
  // SECTION 8: Tips & Gotchas
  // ============================================================
  print('=== Section 8: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Null Begin/End',
      'icon': Icons.lightbulb_outline,
      'body': 'If begin is null, the tween starts from no border. '
          'If end is null, it animates to no border. This is '
          'useful for fade-in/out effects where the border '
          'appears or disappears.',
      'warning': false,
    },
    {
      'tip': 'Non-Uniform Sides',
      'icon': Icons.lightbulb_outline,
      'body': 'Border.lerp works with non-uniform borders (different '
          'sides having different colors/widths). Each side is '
          'interpolated independently. The visual result is smooth '
          'even when sides differ dramatically.',
      'warning': false,
    },
    {
      'tip': 'Avoid BorderDirectional',
      'icon': Icons.warning,
      'body': 'BorderTween expects Border, not BorderDirectional. '
          'If you need start/end instead of left/right for RTL '
          'support, you must convert or use a custom tween. '
          'Mixing Border and BorderDirectional in lerp will throw.',
      'warning': true,
    },
    {
      'tip': 'Performance with Large Lists',
      'icon': Icons.warning,
      'body': 'Avoid animating borders on many list items '
          'simultaneously. Each border tween triggers a repaint. '
          'For lists, prefer animating only the selected/changed '
          'item and use RepaintBoundary to isolate repaints.',
      'warning': true,
    },
    {
      'tip': 'Combine with BoxDecoration',
      'icon': Icons.lightbulb_outline,
      'body': 'In practice, you often animate the border as part '
          'of AnimatedContainer or TweenAnimationBuilder with '
          'BoxDecoration. The border changes alongside background '
          'color and borderRadius for cohesive transitions.',
      'warning': false,
    },
  ];

  print('  Prepared ${tips.length} tips');

  final tipWidgets = tips.map<Widget>((t) {
    final isWarning = t['warning'] as bool;
    final color = isWarning ? Colors.orange[700]! : Colors.cyan[700]!;
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
                    Text(
                      t['tip'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    if (isWarning) ...[
                      const SizedBox(width: 8),
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
          colors: [Colors.cyan[700]!, Colors.teal[500]!],
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

  print('BorderTween Deep Demo complete — returning widget');

  return Scaffold(
    appBar: AppBar(
      title: const Text('BorderTween Deep Demo'),
      backgroundColor: Colors.cyan[700],
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
                colors: [Colors.cyan[800]!, Colors.teal[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Icon(Icons.border_all, color: Colors.white, size: 44),
                const SizedBox(height: 10),
                const Text(
                  'BorderTween',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Smoothly interpolates between two Border values, '
                  'animating color and width of all four sides '
                  'independently for natural transitions.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.cyan[100],
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyan[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyan[200]!),
            ),
            child: Column(
              children: [
                Text(
                  'Border at each interpolation step (t=0 to t=1):',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.cyan[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stepWidgets,
                ),
              ],
            ),
          ),

          // Section 4: Per-Side Breakdown
          sectionHeader('Per-Side Breakdown', Icons.view_sidebar),
          ...sideWidgets,

          // Section 5: Asymmetric Scenarios
          sectionHeader('Asymmetric Border Scenarios', Icons.tune),
          ...scenarioWidgets,

          // Section 6: Related Tweens
          sectionHeader('Related Tweens', Icons.compare),
          ...relatedWidgets,

          // Section 7: Real-World Patterns
          sectionHeader('Real-World Patterns', Icons.apps),
          ...patternWidgets,

          // Section 8: Tips & Gotchas
          sectionHeader('Tips & Gotchas', Icons.tips_and_updates),
          ...tipWidgets,

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}

/// Helper: builds a small border preview box for the asymmetric scenarios
Widget _buildBorderPreview(String label, Border? border) {
  return Column(
    children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: border,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 9, color: Colors.grey[600]),
      ),
    ],
  );
}
