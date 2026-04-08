// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — EdgeInsetsTween
// Demonstrates EdgeInsetsTween, a specialized Tween<EdgeInsets>
// that smoothly interpolates between two EdgeInsets values.
// Covers padding/margin animation, lerp mechanics, the broader
// Tween family, curve effects, directional variants, and
// practical patterns for animating whitespace in UIs.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EdgeInsetsTween Deep Demo executing');

  // ============================================================
  // SECTION 1: What is EdgeInsetsTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.padding,
      'title': 'Animating Whitespace',
      'body': 'EdgeInsetsTween smoothly interpolates between two '
          'EdgeInsets values. Just as ColorTween blends between '
          'colors, EdgeInsetsTween blends padding/margin values '
          'so content can expand, contract, or shift smoothly.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Subclass of Tween<EdgeInsets?>',
      'body': 'EdgeInsetsTween extends Tween<EdgeInsets?> and '
          'overrides the lerp method to use EdgeInsets.lerp(). '
          'At t=0.0 it returns begin, at t=1.0 it returns end, '
          'and in between it linearly interpolates each of the '
          'four sides independently.',
      'accent': Colors.cyan[600]!,
    },
    {
      'icon': Icons.border_all,
      'title': 'Four Independent Sides',
      'body': 'EdgeInsets has left, top, right, bottom. The tween '
          'interpolates each independently: if begin has 8px left '
          'and end has 32px left, at t=0.5 it is 20px left. Each '
          'side can go in different directions simultaneously.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.build,
      'title': 'How to Use It',
      'body': 'Create the tween with begin and end EdgeInsets '
          'values, then use it with an AnimationController: '
          'tween.animate(controller) gives an Animation<EdgeInsets?> '
          'that you can apply to Padding, Container.margin, or '
          'any widget that takes EdgeInsets.',
      'accent': Colors.cyan[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Constructor and Lerp
  // ============================================================
  print('=== Section 2: Constructor & Lerp ===');

  final lerpSteps = <Map<String, dynamic>>[
    {
      't': 0.0,
      'left': 8.0,
      'top': 8.0,
      'right': 8.0,
      'bottom': 8.0,
      'label': 'begin',
      'color': Colors.teal[300]!,
      'barFraction': 0.1,
    },
    {
      't': 0.25,
      'left': 14.0,
      'top': 18.0,
      'right': 14.0,
      'bottom': 23.0,
      'label': 't = 0.25',
      'color': Colors.teal[400]!,
      'barFraction': 0.3,
    },
    {
      't': 0.5,
      'left': 20.0,
      'top': 28.0,
      'right': 20.0,
      'bottom': 38.0,
      'label': 't = 0.50',
      'color': Colors.teal[500]!,
      'barFraction': 0.5,
    },
    {
      't': 0.75,
      'left': 26.0,
      'top': 38.0,
      'right': 26.0,
      'bottom': 53.0,
      'label': 't = 0.75',
      'color': Colors.teal[600]!,
      'barFraction': 0.7,
    },
    {
      't': 1.0,
      'left': 32.0,
      'top': 48.0,
      'right': 32.0,
      'bottom': 68.0,
      'label': 'end',
      'color': Colors.teal[700]!,
      'barFraction': 1.0,
    },
  ];

  // begin = EdgeInsets.all(8), end = EdgeInsets.fromLTRB(32, 48, 32, 68)
  print('  Lerp from all(8) to LTRB(32, 48, 32, 68)');
  print('  Prepared ${lerpSteps.length} interpolation steps');

  // ============================================================
  // SECTION 3: Visualizing the Four Sides
  // ============================================================
  print('=== Section 3: Four Sides Visualization ===');

  final sides = <Map<String, dynamic>>[
    {
      'name': 'left',
      'icon': Icons.arrow_back,
      'begin': 8.0,
      'end': 32.0,
      'color': Colors.teal[500]!,
      'description': 'Space from left edge of parent to content. '
          'Increases from 8px to 32px, pushing content rightward.',
    },
    {
      'name': 'top',
      'icon': Icons.arrow_upward,
      'begin': 8.0,
      'end': 48.0,
      'color': Colors.cyan[500]!,
      'description': 'Space from top of parent to content. Grows '
          'from 8px to 48px — the largest change in this example. '
          'Pushes content downward.',
    },
    {
      'name': 'right',
      'icon': Icons.arrow_forward,
      'begin': 8.0,
      'end': 32.0,
      'color': Colors.teal[600]!,
      'description': 'Space from content to right edge of parent. '
          'Same change as left (8→32), keeping content centered '
          'horizontally as both sides grow equally.',
    },
    {
      'name': 'bottom',
      'icon': Icons.arrow_downward,
      'begin': 8.0,
      'end': 68.0,
      'color': Colors.cyan[700]!,
      'description': 'Space from content to bottom of parent. '
          'Grows dramatically from 8px to 68px. Asymmetric growth '
          'with top (48px end) means content shifts upward overall.',
    },
  ];

  print('  Prepared ${sides.length} side descriptions');

  // ============================================================
  // SECTION 4: Common Tween Patterns
  // ============================================================
  print('=== Section 4: Common Tween Patterns ===');

  final tweenPatterns = <Map<String, dynamic>>[
    {
      'name': 'Symmetric Expand',
      'icon': Icons.zoom_out_map,
      'color': Colors.teal[500]!,
      'begin': 'EdgeInsets.all(4)',
      'end': 'EdgeInsets.all(24)',
      'usage': 'Expand padding equally on all sides. Good for '
          'highlight animations, focus indicators, or breathing '
          'effects on cards.',
    },
    {
      'name': 'Top-Only Reveal',
      'icon': Icons.vertical_align_top,
      'color': Colors.cyan[500]!,
      'begin': 'EdgeInsets.only(top: 0)',
      'end': 'EdgeInsets.only(top: 64)',
      'usage': 'Push content down to reveal a toolbar, banner, '
          'or notification area. Only the top value changes.',
    },
    {
      'name': 'Horizontal Squeeze',
      'icon': Icons.compress,
      'color': Colors.teal[600]!,
      'begin': 'EdgeInsets.symmetric(horizontal: 40)',
      'end': 'EdgeInsets.symmetric(horizontal: 8)',
      'usage': 'Reduce horizontal padding so content becomes '
          'wider. Useful for full-width mode toggles or '
          'responsive layout transitions.',
    },
    {
      'name': 'Bottom Sheet Peek',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.cyan[600]!,
      'begin': 'EdgeInsets.only(bottom: 300)',
      'end': 'EdgeInsets.only(bottom: 16)',
      'usage': 'Animate a bottom sheet into view by reducing the '
          'bottom padding from offscreen to visible. Content '
          'slides up smoothly.',
    },
    {
      'name': 'Asymmetric Shift',
      'icon': Icons.swap_horiz,
      'color': Colors.teal[700]!,
      'begin': 'EdgeInsets.only(left: 8)',
      'end': 'EdgeInsets.only(left: 48, right: 8)',
      'usage': 'Content slides left-to-right as left padding '
          'increases. Classic navigation drawer push animation.',
    },
    {
      'name': 'All Collapse',
      'icon': Icons.close_fullscreen,
      'color': Colors.cyan[700]!,
      'begin': 'EdgeInsets.all(32)',
      'end': 'EdgeInsets.zero',
      'usage': 'Remove all padding, useful for transitioning '
          'from card layout to full-bleed layout.',
    },
  ];

  print('  Prepared ${tweenPatterns.length} tween patterns');

  // ============================================================
  // SECTION 5: The Geometry Tweens Family
  // ============================================================
  print('=== Section 5: Geometry Tweens Family ===');

  final tweenFamily = <Map<String, dynamic>>[
    {
      'name': 'EdgeInsetsTween',
      'target': 'EdgeInsets?',
      'icon': Icons.padding,
      'color': Colors.teal[600]!,
      'description': 'Animate padding and margins. The subject '
          'of this demo. Lerps each side independently.',
      'highlight': true,
    },
    {
      'name': 'EdgeInsetsGeometryTween',
      'target': 'EdgeInsetsGeometry?',
      'icon': Icons.format_indent_increase,
      'color': Colors.teal[500]!,
      'description': 'Parent class that also handles '
          'EdgeInsetsDirectional (start/end instead of left/right). '
          'Use this when you need RTL-aware animated padding.',
      'highlight': false,
    },
    {
      'name': 'AlignmentTween',
      'target': 'Alignment?',
      'icon': Icons.align_horizontal_center,
      'color': Colors.cyan[500]!,
      'description': 'Animate alignment positions (x, y from -1 to 1). '
          'Used with AnimatedAlign or AnimatedContainer.',
      'highlight': false,
    },
    {
      'name': 'BorderRadiusTween',
      'target': 'BorderRadius?',
      'icon': Icons.rounded_corner,
      'color': Colors.cyan[600]!,
      'description': 'Animate corner radii. Lerps each corner\'s '
          'x and y radii independently.',
      'highlight': false,
    },
    {
      'name': 'RectTween',
      'target': 'Rect?',
      'icon': Icons.crop,
      'color': Colors.teal[700]!,
      'description': 'Animate rectangular regions. Used in Hero '
          'transitions and custom clipper animations.',
      'highlight': false,
    },
    {
      'name': 'SizeTween',
      'target': 'Size?',
      'icon': Icons.width_full,
      'color': Colors.cyan[700]!,
      'description': 'Animate width and height. Each dimension '
          'interpolates independently.',
      'highlight': false,
    },
  ];

  print('  Prepared ${tweenFamily.length} family members');

  // ============================================================
  // SECTION 6: Curves and Their Effect
  // ============================================================
  print('=== Section 6: Curve Effects ===');

  final curves = <Map<String, dynamic>>[
    {
      'name': 'linear',
      'icon': Icons.trending_flat,
      'color': Colors.grey[600]!,
      'description': 'Constant speed. Each side changes at the '
          'same rate throughout.',
    },
    {
      'name': 'easeInOut',
      'icon': Icons.auto_graph,
      'color': Colors.teal[500]!,
      'description': 'Slow start, fast middle, slow end. The '
          'most natural-feeling curve for padding changes.',
    },
    {
      'name': 'easeOut',
      'icon': Icons.trending_down,
      'color': Colors.cyan[600]!,
      'description': 'Fast start, slow end. Content jumps quickly '
          'then settles. Good for reveal animations.',
    },
    {
      'name': 'bounceOut',
      'icon': Icons.sports_basketball,
      'color': Colors.teal[600]!,
      'description': 'Overshoots and bounces. Playful effect — '
          'content expands past target then settles back.',
    },
    {
      'name': 'elasticOut',
      'icon': Icons.waves,
      'color': Colors.cyan[700]!,
      'description': 'Spring-like oscillation. Content wiggles '
          'around its target before settling. Very expressive.',
    },
  ];

  print('  Prepared ${curves.length} curve examples');

  // ============================================================
  // SECTION 7: EdgeInsets vs EdgeInsetsDirectional
  // ============================================================
  print('=== Section 7: Directional Variants ===');

  final directionalItems = <Map<String, dynamic>>[
    {
      'variant': 'EdgeInsets',
      'tween': 'EdgeInsetsTween',
      'sides': 'left, top, right, bottom',
      'icon': Icons.format_textdirection_l_to_r,
      'color': Colors.teal[600]!,
      'description': 'Physical/absolute sides. Left always means '
          'left, regardless of text direction. Use for layout '
          'that should not flip in RTL locales.',
    },
    {
      'variant': 'EdgeInsetsDirectional',
      'tween': 'EdgeInsetsGeometryTween',
      'sides': 'start, top, end, bottom',
      'icon': Icons.swap_horiz,
      'color': Colors.cyan[600]!,
      'description': 'Logical sides. "start" is left in LTR, right '
          'in RTL. Use for text-related padding or any layout '
          'that should mirror in RTL locales.',
    },
  ];

  print('  Prepared ${directionalItems.length} directional variants');

  // ============================================================
  // SECTION 8: Implicit vs Explicit Animation
  // ============================================================
  print('=== Section 8: Implicit vs Explicit ===');

  final animMethods = <Map<String, dynamic>>[
    {
      'method': 'AnimatedPadding (Implicit)',
      'icon': Icons.auto_awesome,
      'color': Colors.teal[500]!,
      'code': 'AnimatedPadding(\n'
          '  padding: _expanded\n'
          '    ? EdgeInsets.all(32)\n'
          '    : EdgeInsets.all(8),\n'
          '  duration: Duration(ms: 300),\n'
          '  child: content,\n'
          ')',
      'pros': 'Simple — just change the padding value and the '
          'widget handles the animation. No controller needed.',
      'cons': 'Less control — can\'t pause, reverse mid-animation, '
          'or combine with other animations in a stagger.',
    },
    {
      'method': 'EdgeInsetsTween + Controller (Explicit)',
      'icon': Icons.tune,
      'color': Colors.cyan[600]!,
      'code': 'final tween = EdgeInsetsTween(\n'
          '  begin: EdgeInsets.all(8),\n'
          '  end: EdgeInsets.all(32),\n'
          ');\n'
          'final anim = tween.animate(\n'
          '  CurvedAnimation(\n'
          '    parent: controller,\n'
          '    curve: Curves.easeInOut,\n'
          '  ),\n'
          ');',
      'pros': 'Full control — pause, reverse, repeat, stagger '
          'with other tweens on the same controller.',
      'cons': 'More boilerplate — need AnimationController, '
          'TickerProvider, dispose, AnimatedBuilder.',
    },
    {
      'method': 'AnimatedContainer (Implicit)',
      'icon': Icons.view_in_ar,
      'color': Colors.teal[600]!,
      'code': 'AnimatedContainer(\n'
          '  padding: _expanded\n'
          '    ? EdgeInsets.all(32)\n'
          '    : EdgeInsets.all(8),\n'
          '  margin: _wide\n'
          '    ? EdgeInsets.symmetric(h: 4)\n'
          '    : EdgeInsets.symmetric(h: 24),\n'
          '  duration: Duration(ms: 300),\n'
          '  child: content,\n'
          ')',
      'pros': 'Animates padding AND margin AND other properties '
          'all at once. Very convenient for multi-property changes.',
      'cons': 'Same limitations as other implicit animations — '
          'no fine-grained control over the animation.',
    },
  ];

  print('  Prepared ${animMethods.length} animation methods');

  // ============================================================
  // SECTION 9: Tips & Best Practices
  // ============================================================
  print('=== Section 9: Tips & Best Practices ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'EdgeInsets.lerp Under the Hood',
      'body': 'EdgeInsetsTween.lerp() delegates to EdgeInsets.lerp() '
          'which computes: left + (other.left - left) * t for each '
          'side. This is a simple linear interpolation — the tween '
          'itself adds no magic, just a convenient wrapper.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Prefer AnimatedPadding for Simple Cases',
      'body': 'If you just want padding to change when state changes '
          'and don\'t need pause/reverse/stagger, AnimatedPadding is '
          'the simplest path. It uses EdgeInsetsTween internally.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Nullable Begin and End',
      'body': 'EdgeInsetsTween extends Tween<EdgeInsets?>, so begin '
          'and end are nullable. If either is null at lerp time, '
          'EdgeInsets.lerp treats null as EdgeInsets.zero. This '
          'means animating from null fades in from zero padding.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Large Padding Changes Cause Layout Jumps',
      'body': 'Animating from EdgeInsets.all(0) to all(100) causes '
          'huge layout shifts. If the content is in a list, this '
          'forces expensive re-layout on every frame. Consider '
          'using Transform.translate instead for visual-only shifts.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with Other Tweens',
      'body': 'Use the same AnimationController for EdgeInsetsTween, '
          'ColorTween, double tweens, etc. to create coordinated '
          'animations. The controller drives all of them in sync.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Negative EdgeInsets',
      'body': 'EdgeInsets can technically hold negative values, and '
          'lerp will interpolate through them. But negative padding '
          'causes content to overflow its parent. Avoid begin/end '
          'combinations that cross through negative values.',
      'severity': 'warning',
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
      title: Text('EdgeInsetsTween'),
      backgroundColor: Colors.teal[700],
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
                colors: [Colors.teal[700]!, Colors.cyan[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.padding, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'EdgeInsetsTween',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Smoothly animate padding and margins by '
                  'interpolating EdgeInsets across all four sides.',
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
          _sectionTitle('1', 'What is EdgeInsetsTween?'),
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

          // ── Section 2: Lerp Steps ──
          _sectionTitle('2', 'Constructor & Lerp Visualization'),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal[200]!),
            ),
            child: Text(
              'EdgeInsetsTween(\n'
              '  begin: EdgeInsets.all(8),\n'
              '  end: EdgeInsets.fromLTRB(32, 48, 32, 68),\n'
              ')',
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.teal[800],
                  height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          ...lerpSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (step['color'] as Color).withOpacity(0.4)),
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
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: step['color'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(step['label'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'L=${(step['left'] as double).toStringAsFixed(0)}  '
                            'T=${(step['top'] as double).toStringAsFixed(0)}  '
                            'R=${(step['right'] as double).toStringAsFixed(0)}  '
                            'B=${(step['bottom'] as double).toStringAsFixed(0)}',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700]),
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      // Visual padding representation
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: (step['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          (step['left'] as double) * 0.8,
                          (step['top'] as double) * 0.3,
                          (step['right'] as double) * 0.8,
                          (step['bottom'] as double) * 0.3,
                        ),
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: step['color'] as Color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text('content',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Four Sides ──
          _sectionTitle('3', 'The Four Independent Sides'),
          SizedBox(height: 12),
          ...sides.map((side) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: side['color'] as Color, width: 4),
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
                        Icon(side['icon'] as IconData,
                            color: side['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text('.${side['name']}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                color: side['color'] as Color)),
                        Spacer(),
                        Text(
                          '${(side['begin'] as double).toStringAsFixed(0)} → '
                          '${(side['end'] as double).toStringAsFixed(0)} px',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: Colors.grey[600]),
                        ),
                      ]),
                      SizedBox(height: 8),
                      // Progress bar showing range
                      Stack(
                        children: [
                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor:
                                ((side['end'] as double) / 80.0).clamp(0.0, 1.0),
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  (side['color'] as Color).withOpacity(0.4),
                                  side['color'] as Color,
                                ]),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(side['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Common Patterns ──
          _sectionTitle('4', 'Common EdgeInsetsTween Patterns'),
          SizedBox(height: 12),
          ...tweenPatterns.map((tp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: tp['color'] as Color, width: 4),
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
                        Icon(tp['icon'] as IconData,
                            color: tp['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(tp['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (tp['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('begin: ${tp['begin']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[600])),
                            Text('end:   ${tp['end']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(tp['usage'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Tween Family ──
          _sectionTitle('5', 'The Geometry Tweens Family'),
          SizedBox(height: 12),
          ...tweenFamily.map((tf) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (tf['highlight'] as bool)
                        ? (tf['color'] as Color).withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (tf['highlight'] as bool)
                          ? (tf['color'] as Color).withOpacity(0.5)
                          : Colors.grey[200]!,
                      width: (tf['highlight'] as bool) ? 2 : 1,
                    ),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (tf['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(tf['icon'] as IconData,
                            color: tf['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(tf['name'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: 'monospace')),
                              SizedBox(width: 6),
                              Text('→ ${tf['target']}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[500])),
                              if (tf['highlight'] as bool) ...[
                                SizedBox(width: 6),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: tf['color'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('this demo',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ]),
                            SizedBox(height: 4),
                            Text(tf['description'] as String,
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

          // ── Section 6: Curves ──
          _sectionTitle('6', 'Curve Effects on EdgeInsetsTween'),
          SizedBox(height: 8),
          Text(
            'Wrapping the tween animation with CurvedAnimation '
            'changes the rate of change between begin and end.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...curves.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (c['color'] as Color).withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: (c['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(c['icon'] as IconData,
                            color: c['color'] as Color, size: 20),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Curves.${c['name']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'monospace')),
                            SizedBox(height: 3),
                            Text(c['description'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Directional Variants ──
          _sectionTitle('7', 'EdgeInsets vs EdgeInsetsDirectional'),
          SizedBox(height: 12),
          ...directionalItems.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (d['color'] as Color).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (d['color'] as Color).withOpacity(0.4)),
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
                        Icon(d['icon'] as IconData,
                            color: d['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(d['variant'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Row(children: [
                        _edgeBadge('Tween', d['tween'] as String,
                            d['color'] as Color),
                        SizedBox(width: 8),
                        _edgeBadge(
                            'Sides', d['sides'] as String, Colors.grey[600]!),
                      ]),
                      SizedBox(height: 8),
                      Text(d['description'] as String,
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
          _sectionTitle('8', 'Implicit vs Explicit Animation'),
          SizedBox(height: 12),
          ...animMethods.map((am) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: am['color'] as Color, width: 4),
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
                        Icon(am['icon'] as IconData,
                            color: am['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(am['method'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (am['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(am['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pros',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.green[700])),
                                  SizedBox(height: 2),
                                  Text(am['pros'] as String,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700],
                                          height: 1.3)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cons',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.orange[700])),
                                  SizedBox(height: 2),
                                  Text(am['cons'] as String,
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
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _sectionTitle('9', 'Tips & Best Practices'),
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
              'End of EdgeInsetsTween Deep Demo',
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
Widget _sectionTitle(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.teal[700],
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
// Helper: Small badge for directional section
// ──────────────────────────────────────────────────────────
Widget _edgeBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Text(
      '$label: $value',
      style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
    ),
  );
}
