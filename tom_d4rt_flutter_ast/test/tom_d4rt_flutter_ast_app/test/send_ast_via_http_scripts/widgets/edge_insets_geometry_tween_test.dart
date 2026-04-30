// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — EdgeInsetsGeometryTween
// Demonstrates EdgeInsetsGeometryTween — a tween that interpolates
// between two EdgeInsetsGeometry values. Covers the hierarchy of
// EdgeInsetsGeometry, lerp snapshots at different t-values, animated
// padding, mixed-type interpolation, comparison with EdgeInsetsTween,
// real-world usage patterns and tips.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EdgeInsetsGeometryTween Deep Demo executing');

  // ============================================================
  // SECTION 1: What is EdgeInsetsGeometryTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.padding,
      'title': 'Animating Padding & Margins',
      'body': 'EdgeInsetsGeometryTween interpolates between two '
          'EdgeInsetsGeometry values over an animation timeline. '
          'This means you can smoothly animate padding, margin, '
          'or any spacing that uses EdgeInsetsGeometry — going from '
          'one set of insets to another with a smooth transition.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.category,
      'title': 'Works with Both Subclasses',
      'body': 'EdgeInsetsGeometry is the abstract base — EdgeInsets '
          'uses left/right and EdgeInsetsDirectional uses start/end. '
          'EdgeInsetsGeometryTween handles BOTH and can even lerp '
          'between mixed types (EdgeInsets → EdgeInsetsDirectional) '
          'using EdgeInsetsGeometry.lerp().',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.timeline,
      'title': 'Extends Tween<EdgeInsetsGeometry>',
      'body': 'It extends Tween<EdgeInsetsGeometry?> and overrides '
          'lerp() to call EdgeInsetsGeometry.lerp(begin, end, t). '
          'At t=0.0 you get begin, at t=1.0 you get end, and at '
          'any t in between you get a proportional blend of all '
          'four (or six) edge values.',
      'accent': Colors.green[600]!,
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Used by Implicit Animations',
      'body': 'AnimatedContainer and AnimatedPadding use this tween '
          'internally to animate their padding/margin properties. '
          'You can also use it directly with TweenAnimationBuilder '
          'or AnimationController for custom animations.',
      'accent': Colors.teal[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: EdgeInsetsGeometry Hierarchy
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'name': 'EdgeInsetsGeometry (abstract)',
      'depth': 0,
      'color': Colors.grey[600]!,
      'icon': Icons.account_tree,
      'isSubject': false,
      'description': 'The abstract base. Defines along(), '
          'resolve(), add(), subtract(), clamp() and the static '
          'lerp() method. Cannot be instantiated directly.',
    },
    {
      'name': 'EdgeInsets',
      'depth': 1,
      'color': Colors.green[700]!,
      'icon': Icons.border_all,
      'isSubject': false,
      'description': 'Physical direction insets: left, top, right, '
          'bottom. Suitable for layouts that don\'t need to flip '
          'for RTL languages. EdgeInsets.all(8), EdgeInsets.only(), '
          'EdgeInsets.symmetric().',
    },
    {
      'name': 'EdgeInsetsDirectional',
      'depth': 1,
      'color': Colors.teal[600]!,
      'icon': Icons.format_textdirection_l_to_r,
      'isSubject': false,
      'description': 'Logical direction insets: start, top, end, '
          'bottom. "Start" maps to left in LTR and right in RTL. '
          'Preferred for internationalized apps. '
          'EdgeInsetsDirectional.only(), .fromSTEB().',
    },
    {
      'name': 'EdgeInsetsGeometryTween',
      'depth': 0,
      'color': Colors.green[800]!,
      'icon': Icons.animation,
      'isSubject': true,
      'description': 'Tween<EdgeInsetsGeometry?> that interpolates '
          'between any two EdgeInsetsGeometry values using '
          'EdgeInsetsGeometry.lerp(). THIS IS THE DEMO SUBJECT.',
    },
    {
      'name': 'EdgeInsetsTween',
      'depth': 0,
      'color': Colors.teal[700]!,
      'icon': Icons.animation,
      'isSubject': false,
      'description': 'Tween<EdgeInsets?> — a narrower tween that '
          'only works with EdgeInsets (physical). Cannot lerp '
          'between EdgeInsets and EdgeInsetsDirectional.',
    },
  ];

  print('  Prepared ${hierarchy.length} hierarchy items');

  // ============================================================
  // SECTION 3: Lerp Snapshots at Different t Values
  // ============================================================
  print('=== Section 3: Lerp Snapshots ===');

  final beginInsets = EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4);
  final endInsets = EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 60);

  final tValues = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpSnapshots = <Map<String, dynamic>>[];

  for (final t in tValues) {
    final lerped = EdgeInsetsGeometry.lerp(beginInsets, endInsets, t)!;
    final resolved = lerped.resolve(TextDirection.ltr);
    lerpSnapshots.add({
      't': t,
      'left': resolved.left,
      'top': resolved.top,
      'right': resolved.right,
      'bottom': resolved.bottom,
    });
    print('  t=$t → L:${resolved.left} T:${resolved.top} '
        'R:${resolved.right} B:${resolved.bottom}');
  }

  // ============================================================
  // SECTION 4: Visual Padding Demo at Snapshots
  // ============================================================
  print('=== Section 4: Visual Padding ===');

  final paddingExamples = <Map<String, dynamic>>[
    {
      'label': 'Uniform Small → Large Asymmetric',
      'begin': EdgeInsets.all(4.0),
      'end': EdgeInsets.only(left: 48, top: 8, right: 48, bottom: 32),
      'color': Colors.green[400]!,
      'description': 'Starts with uniform 4px padding on all sides, '
          'animates to asymmetric padding — wide horizontal, '
          'taller bottom. Common when expanding a card to detail.',
    },
    {
      'label': 'Zero → Substantial',
      'begin': EdgeInsets.zero,
      'end': EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      'color': Colors.teal[400]!,
      'description': 'Starts with zero padding, animates to symmetric '
          'padding. Used when content "breathes in" from a tight '
          'layout to comfortable spacing.',
    },
    {
      'label': 'Left-Only → Right-Only',
      'begin': EdgeInsets.only(left: 40),
      'end': EdgeInsets.only(right: 40),
      'color': Colors.green[300]!,
      'description': 'Shifts padding from left to right. At t=0.5, '
          'both sides have 20px. Useful for sliding emphasis from '
          'one side to the other.',
    },
    {
      'label': 'Top-Heavy → Bottom-Heavy',
      'begin': EdgeInsets.only(top: 48, bottom: 4),
      'end': EdgeInsets.only(top: 4, bottom: 48),
      'color': Colors.teal[300]!,
      'description': 'Inverts vertical distribution. Great for '
          'repositioning content from top-aligned to bottom-aligned '
          'within a container.',
    },
  ];

  print('  Prepared ${paddingExamples.length} padding examples');

  // ============================================================
  // SECTION 5: Directional vs Physical
  // ============================================================
  print('=== Section 5: Directional vs Physical ===');

  final dirComparison = <Map<String, dynamic>>[
    {
      'aspect': 'Class',
      'physical': 'EdgeInsets',
      'directional': 'EdgeInsetsDirectional',
    },
    {
      'aspect': 'Horizontal axes',
      'physical': 'left / right',
      'directional': 'start / end',
    },
    {
      'aspect': 'RTL behavior',
      'physical': 'Same (left stays left)',
      'directional': 'Flips (start→right)',
    },
    {
      'aspect': 'Tween class',
      'physical': 'EdgeInsetsTween',
      'directional': 'EdgeInsetsGeometryTween',
    },
    {
      'aspect': 'Best for',
      'physical': 'Non-text UI, fixed layouts',
      'directional': 'Text-adjacent, i18n apps',
    },
    {
      'aspect': 'Mixed lerp',
      'physical': 'No (same type only)',
      'directional': 'Yes (via Geometry tween)',
    },
  ];

  print('  Prepared ${dirComparison.length} comparison rows');

  // ============================================================
  // SECTION 6: Tween API
  // ============================================================
  print('=== Section 6: Tween API ===');

  final apiMembers = <Map<String, dynamic>>[
    {
      'name': 'EdgeInsetsGeometryTween({begin, end})',
      'kind': 'constructor',
      'icon': Icons.build,
      'color': Colors.green[700]!,
      'description': 'Creates a tween with optional begin and end '
          'EdgeInsetsGeometry values. Either or both can be null. '
          'If begin is null, lerp starts from zero insets.',
    },
    {
      'name': 'lerp(double t)',
      'kind': 'method',
      'icon': Icons.animation,
      'color': Colors.teal[600]!,
      'description': 'Returns the interpolated EdgeInsetsGeometry at '
          'position t. Calls EdgeInsetsGeometry.lerp(begin, end, t) '
          'internally. Returns null only if both begin and end are null.',
    },
    {
      'name': 'begin',
      'kind': 'property',
      'icon': Icons.first_page,
      'color': Colors.green[600]!,
      'description': 'The EdgeInsetsGeometry at t=0.0. Can be '
          'EdgeInsets, EdgeInsetsDirectional, or null (treated as '
          'zero). Inherited from Tween.',
    },
    {
      'name': 'end',
      'kind': 'property',
      'icon': Icons.last_page,
      'color': Colors.teal[700]!,
      'description': 'The EdgeInsetsGeometry at t=1.0. Can be '
          'EdgeInsets, EdgeInsetsDirectional, or null. When begin '
          'and end are different subtypes, lerp blends them smoothly.',
    },
    {
      'name': 'evaluate(Animation<double>)',
      'kind': 'method',
      'icon': Icons.play_arrow,
      'color': Colors.green[800]!,
      'description': 'Inherited from Animatable. Calls lerp() with '
          'the animation\'s current value. Used when chaining '
          'with AnimationController via .drive(tween).',
    },
    {
      'name': 'animate(AnimationController)',
      'kind': 'method',
      'icon': Icons.play_circle,
      'color': Colors.teal[800]!,
      'description': 'Inherited from Animatable. Creates an Animation '
          'driven by the given controller. The animation\'s value '
          'is the lerped EdgeInsetsGeometry at each frame.',
    },
  ];

  print('  Prepared ${apiMembers.length} API members');

  // ============================================================
  // SECTION 7: Mixed-Type Interpolation Demo
  // ============================================================
  print('=== Section 7: Mixed-Type Lerp ===');

  final mixedExamples = <Map<String, dynamic>>[
    {
      'name': 'EdgeInsets → EdgeInsetsDirectional',
      'icon': Icons.swap_horiz,
      'color': Colors.green[700]!,
      'begin': 'EdgeInsets.only(left: 32)',
      'end': 'EdgeInsetsDirectional.only(end: 32)',
      'ltrResult': 'At t=0.5: left=16, right=16 (LTR)',
      'rtlResult': 'At t=0.5: left=16, right=16 → but resolves differently in RTL',
      'description': 'When lerping between physical and directional '
          'insets, EdgeInsetsGeometry.lerp converts both to a '
          'MixedEdgeInsets internally, then interpolates each '
          'component independently. The result depends on '
          'TextDirection when resolved.',
    },
    {
      'name': 'Both Left → Both End',
      'icon': Icons.swap_horiz,
      'color': Colors.teal[600]!,
      'begin': 'EdgeInsets.symmetric(h:20, v:10)',
      'end': 'EdgeInsetsDirectional.fromSTEB(0,10,40,10)',
      'ltrResult': 'horizontal shifts from balanced to right-heavy',
      'rtlResult': 'In RTL: shifts to left-heavy instead',
      'description': 'Demonstrates how the same tween produces '
          'different visual results depending on text direction. '
          'The tween itself is direction-agnostic — resolve() '
          'applies the directionality.',
    },
  ];

  print('  Prepared ${mixedExamples.length} mixed examples');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Expanding Card Detail',
      'icon': Icons.open_in_full,
      'color': Colors.green[700]!,
      'description': 'A product card in a grid has tight 8px padding. '
          'When tapped, it expands to a full-screen detail view '
          'with generous 24px padding. AnimatedPadding uses an '
          'EdgeInsetsGeometryTween internally to animate from '
          'compact to spacious.',
      'begin': 'all: 8',
      'end': 'all: 24',
    },
    {
      'name': 'Collapsing App Bar',
      'icon': Icons.view_agenda,
      'color': Colors.teal[600]!,
      'description': 'A SliverAppBar\'s title padding changes as '
          'the bar collapses. Expanded: large left padding (72px) '
          'for a large title. Collapsed: smaller padding (16px) '
          'as the title shrinks to a normal size.',
      'begin': 'left: 72, bottom: 16',
      'end': 'left: 16, bottom: 0',
    },
    {
      'name': 'Responsive Layout Shift',
      'icon': Icons.devices,
      'color': Colors.green[600]!,
      'description': 'On a phone, content has symmetric(h:16). On '
          'a tablet, it has symmetric(h:64). When the layout '
          'changes (e.g., breakpoint animation), the padding '
          'tweens smoothly rather than jumping.',
      'begin': 'h: 16, v: 8',
      'end': 'h: 64, v: 8',
    },
    {
      'name': 'Keyboard Avoidance',
      'icon': Icons.keyboard,
      'color': Colors.teal[700]!,
      'description': 'When the keyboard appears, bottom padding '
          'needs to increase to keep content visible. Animate '
          'from bottom:0 to bottom:keyboardHeight. '
          'EdgeInsetsGeometryTween handles the smooth transition.',
      'begin': 'bottom: 0',
      'end': 'bottom: 300',
    },
    {
      'name': 'RTL Language Switch',
      'icon': Icons.translate,
      'color': Colors.green[800]!,
      'description': 'App switches locale from LTR to RTL. '
          'EdgeInsetsDirectional values for start/end stay the same '
          'but resolve differently. Combined with '
          'EdgeInsetsGeometryTween, the padding can animate '
          'smoothly as the layout flips.',
      'begin': 'start: 24, end: 8',
      'end': 'start: 8, end: 24',
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
      'title': 'Use EdgeInsetsGeometryTween for Flexibility',
      'body': 'If you only need EdgeInsets (no directional), '
          'EdgeInsetsTween also works. But EdgeInsetsGeometryTween '
          'is more flexible — it handles both subtypes and mixed '
          'lerping. There\'s no performance penalty for using the '
          'geometry variant.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Null Begin/End Treated as Zero',
      'body': 'If begin or end is null, EdgeInsetsGeometry.lerp() '
          'treats it as EdgeInsets.zero. This means at t=0 with '
          'null begin, the padding is zero — which might cause '
          'layout jumps if you don\'t expect it.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'AnimatedPadding Uses This Internally',
      'body': 'You don\'t need to manually create '
          'EdgeInsetsGeometryTween for simple cases. AnimatedPadding '
          'and AnimatedContainer create and manage the tween for '
          'you. Use the tween directly only when you need explicit '
          'control over the animation.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Resolve Before Using',
      'body': 'The lerp result is an EdgeInsetsGeometry, not '
          'EdgeInsets. You need to call .resolve(TextDirection.ltr) '
          'to get concrete left/right values. Most widgets do this '
          'automatically, but if you\'re reading values manually '
          'you must resolve first.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine with CurvedAnimation',
      'body': 'The lerp is linear by default. Chain with '
          'CurveTween(curve: Curves.easeInOut) to get non-linear '
          'interpolation: tween.chain(CurveTween(curve: ...)).  '
          'This makes padding changes feel more natural.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Both TextDirections',
      'body': 'If using EdgeInsetsDirectional, always test the '
          'animation in both LTR and RTL to ensure the visual '
          'result is correct. The tween values are the same, but '
          'the resolved positions differ.',
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
      title: Text('EdgeInsetsGeometryTween'),
      backgroundColor: Colors.green[700],
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
                colors: [Colors.green[700]!, Colors.teal[600]!],
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
                  'EdgeInsetsGeometryTween',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Smoothly interpolate between any two '
                  'EdgeInsetsGeometry values — animate padding, '
                  'margins, and spacing transitions with support '
                  'for both physical and directional insets.',
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
          _padHead('1', 'What is EdgeInsetsGeometryTween?'),
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

          // ── Section 2: Hierarchy ──
          _padHead('2', 'Class Hierarchy'),
          SizedBox(height: 12),
          ...hierarchy.map((h) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (h['depth'] as int) * 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: h['isSubject'] == true
                          ? Colors.green[50]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                            color: h['color'] as Color, width: 4),
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
                          Icon(h['icon'] as IconData,
                              color: h['color'] as Color, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(h['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                    color: h['color'] as Color)),
                          ),
                          if (h['isSubject'] == true)
                            _padViz('THIS DEMO', Colors.green[800]!),
                        ]),
                        SizedBox(height: 4),
                        Text(h['description'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.3)),
                      ],
                    ),
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Lerp Snapshots ──
          _padHead('3', 'Lerp Snapshots (4,4,4,4 → 40,20,40,60)'),
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
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Text('t',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 1,
                      child: Text('Left',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 1,
                      child: Text('Top',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 1,
                      child: Text('Right',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 1,
                      child: Text('Bottom',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                ]),
              ),
              ...lerpSnapshots.asMap().entries.map((entry) {
                final idx = entry.key;
                final snap = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Text('${snap['t']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.green[800]))),
                    Expanded(
                        flex: 1,
                        child: Text(
                            (snap['left'] as double).toStringAsFixed(1),
                            style: TextStyle(fontSize: 12))),
                    Expanded(
                        flex: 1,
                        child: Text(
                            (snap['top'] as double).toStringAsFixed(1),
                            style: TextStyle(fontSize: 12))),
                    Expanded(
                        flex: 1,
                        child: Text(
                            (snap['right'] as double).toStringAsFixed(1),
                            style: TextStyle(fontSize: 12))),
                    Expanded(
                        flex: 1,
                        child: Text(
                            (snap['bottom'] as double).toStringAsFixed(1),
                            style: TextStyle(fontSize: 12))),
                  ]),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 4: Visual Padding Demo ──
          _padHead('4', 'Padding Animation Scenarios'),
          SizedBox(height: 12),
          ...paddingExamples.map((pe) {
            final begin = pe['begin'] as EdgeInsets;
            final end = pe['end'] as EdgeInsets;
            return Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                        color: pe['color'] as Color, width: 4),
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
                    Text(pe['label'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    SizedBox(height: 8),
                    Text(pe['description'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            height: 1.3)),
                    SizedBox(height: 10),
                    // Visual: show begin, mid, end side by side
                    Row(
                      children: [0.0, 0.5, 1.0].map((t) {
                        final lerped = EdgeInsetsGeometry.lerp(
                            begin, end, t)!;
                        final resolved =
                            lerped.resolve(TextDirection.ltr);
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4),
                            child: Column(children: [
                              Text('t=${t.toStringAsFixed(1)}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700])),
                              SizedBox(height: 4),
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: (pe['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                  border: Border.all(
                                      color: (pe['color'] as Color)
                                          .withOpacity(0.4)),
                                ),
                                child: Padding(
                                  padding: resolved,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: pe['color'] as Color,
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text('Content',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight:
                                                  FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                  'L:${resolved.left.toInt()} '
                                  'R:${resolved.right.toInt()}',
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey[600])),
                            ]),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 5: Directional vs Physical ──
          _padHead('5', 'Directional vs Physical'),
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
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Physical (EdgeInsets)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Directional',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...dirComparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 3,
                          child: Text(row['physical'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['directional'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Tween API ──
          _padHead('6', 'EdgeInsetsGeometryTween API'),
          SizedBox(height: 12),
          ...apiMembers.map((api) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: api['color'] as Color, width: 4),
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
                        Icon(api['icon'] as IconData,
                            color: api['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(api['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: api['color'] as Color)),
                        ),
                        _padViz(
                            api['kind'] as String, Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(api['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Mixed-Type Lerp ──
          _padHead('7', 'Mixed-Type Interpolation'),
          SizedBox(height: 12),
          ...mixedExamples.map((me) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: me['color'] as Color, width: 4),
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
                        Icon(me['icon'] as IconData,
                            color: me['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(me['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('begin: ${me['begin']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.green[700])),
                            Text('end:   ${me['end']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.teal[700])),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(me['ltrResult'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.green[800],
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 2),
                      Text(me['rtlResult'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.teal[700],
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 6),
                      Text(me['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World ──
          _padHead('8', 'Real-World Patterns'),
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
                      SizedBox(height: 6),
                      Row(children: [
                        _padViz('begin: ${p['begin']}',
                            Colors.green[600]!),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward,
                            size: 12, color: Colors.grey[400]),
                        SizedBox(width: 6),
                        _padViz(
                            'end: ${p['end']}', Colors.teal[600]!),
                      ]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _padHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of EdgeInsetsGeometryTween Deep Demo',
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
Widget _padHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green[700],
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
// Helper: Small label/tag badge
// ──────────────────────────────────────────────────────────
Widget _padViz(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
