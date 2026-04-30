// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RelativeRectTween
// Demonstrates RelativeRectTween — a Tween<RelativeRect> that
// interpolates between two RelativeRect values for animating
// Positioned widgets inside a Stack. Covers lerp visualization,
// PositionedTransition usage, factory methods, and practical
// animation patterns with side-by-side frame comparisons.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RelativeRectTween Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RelativeRectTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.transform,
      'title': 'Tween for Positioned Elements',
      'body': 'RelativeRectTween interpolates between two RelativeRect '
          'values. A RelativeRect describes a rectangle as insets from '
          'each edge of a parent container (like a Stack). The tween '
          'smoothly animates the child from one position to another.',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.crop_square,
      'title': 'RelativeRect Anatomy',
      'body': 'RelativeRect has four values: left, top, right, bottom — '
          'each is the distance from the corresponding edge of the '
          'parent. RelativeRect.fill means all zeros (child fills '
          'parent). Negative values extend beyond the parent.',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Smooth Position Animation',
      'body': 'The tween\'s lerp() method calls RelativeRect.lerp(begin, '
          'end, t) — linearly interpolating each of the four inset '
          'values. At t=0.0 you get begin, at t=1.0 you get end, '
          'and at t=0.5 the exact midpoint.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Used with PositionedTransition',
      'body': 'PositionedTransition is the primary consumer of '
          'RelativeRectTween. It wraps a Positioned widget and '
          'drives its rect from an Animation<RelativeRect> '
          'produced by controller.drive(tween).',
      'accent': Colors.orange[700]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: RelativeRect Structure
  // ============================================================
  print('=== Section 2: RelativeRect Structure ===');

  // Create example RelativeRects
  final rectStart = RelativeRect.fromLTRB(10, 10, 200, 200);
  final rectEnd = RelativeRect.fromLTRB(100, 50, 50, 100);
  final rectFill = RelativeRect.fill;

  print('  start: left=${rectStart.left}, top=${rectStart.top}, right=${rectStart.right}, bottom=${rectStart.bottom}');
  print('  end: left=${rectEnd.left}, top=${rectEnd.top}, right=${rectEnd.right}, bottom=${rectEnd.bottom}');
  print('  fill: $rectFill');

  final rectProperties = <Map<String, dynamic>>[
    {
      'name': 'left',
      'description': 'Distance from the left edge of the parent. '
          'Positive: inset from left. Negative: extends beyond left.',
      'startVal': '${rectStart.left}',
      'endVal': '${rectEnd.left}',
      'color': Colors.deepPurple[700]!,
    },
    {
      'name': 'top',
      'description': 'Distance from the top edge of the parent. '
          'Positive: inset from top. Negative: extends beyond top.',
      'startVal': '${rectStart.top}',
      'endVal': '${rectEnd.top}',
      'color': Colors.orange[800]!,
    },
    {
      'name': 'right',
      'description': 'Distance from the right edge of the parent. '
          'Positive: inset from right. Negative: extends beyond right.',
      'startVal': '${rectStart.right}',
      'endVal': '${rectEnd.right}',
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'bottom',
      'description': 'Distance from the bottom edge of the parent. '
          'Positive: inset from bottom. Negative: extends beyond bottom.',
      'startVal': '${rectStart.bottom}',
      'endVal': '${rectEnd.bottom}',
      'color': Colors.orange[700]!,
    },
  ];

  // ============================================================
  // SECTION 3: Lerp Visualization
  // ============================================================
  print('=== Section 3: Lerp Visualization ===');

  // Create tween and compute positions at various t values
  final tween = RelativeRectTween(begin: rectStart, end: rectEnd);
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpResults = <Map<String, dynamic>>[];

  for (final t in tValues) {
    final rect = tween.lerp(t);
    lerpResults.add({
      't': t,
      'left': rect.left.toStringAsFixed(1),
      'top': rect.top.toStringAsFixed(1),
      'right': rect.right.toStringAsFixed(1),
      'bottom': rect.bottom.toStringAsFixed(1),
      'color': Color.lerp(Colors.deepPurple[400], Colors.orange[400], t)!,
    });
    print('  t=$t: L=${rect.left.toStringAsFixed(1)}, T=${rect.top.toStringAsFixed(1)}, '
        'R=${rect.right.toStringAsFixed(1)}, B=${rect.bottom.toStringAsFixed(1)}');
  }

  // ============================================================
  // SECTION 4: Animation Frame Comparison
  // ============================================================
  print('=== Section 4: Animation Frames ===');

  // 5 frames showing the tween at different t values
  // Using a stack-based visualization
  final frameLabels = ['t=0.0 (begin)', 't=0.25', 't=0.5', 't=0.75', 't=1.0 (end)'];
  print('  Frames: ${frameLabels.length}');

  // ============================================================
  // SECTION 5: Factory Methods
  // ============================================================
  print('=== Section 5: Factory Methods ===');

  final factoryMethods = <Map<String, dynamic>>[
    {
      'name': 'RelativeRect.fromLTRB(l, t, r, b)',
      'description': 'Direct construction from four inset values. '
          'Most explicit and commonly used factory.',
      'example': 'RelativeRect.fromLTRB(10, 20, 30, 40)',
      'icon': Icons.border_all,
      'color': Colors.deepPurple[700]!,
    },
    {
      'name': 'RelativeRect.fromSize(rect, size)',
      'description': 'Creates from a child Rect and the parent Size. '
          'Calculates insets automatically from the child\'s position.',
      'example': 'RelativeRect.fromSize(\n  Rect.fromLTWH(10, 20, 80, 60),\n  Size(200, 150),\n)',
      'icon': Icons.aspect_ratio,
      'color': Colors.orange[800]!,
    },
    {
      'name': 'RelativeRect.fromRect(rect, container)',
      'description': 'Creates from a child Rect and a container Rect. '
          'The container Rect can be offset from origin.',
      'example': 'RelativeRect.fromRect(\n  Rect.fromLTWH(20, 30, 60, 40),\n  Rect.fromLTWH(0, 0, 200, 150),\n)',
      'icon': Icons.crop_free,
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'RelativeRect.fill',
      'description': 'Static constant where all four insets are zero. '
          'The child fills the entire parent. Same as fromLTRB(0,0,0,0).',
      'example': 'RelativeRect.fill',
      'icon': Icons.fullscreen,
      'color': Colors.orange[700]!,
    },
  ];

  print('  Factory methods: ${factoryMethods.length}');

  // ============================================================
  // SECTION 6: Tween Comparison
  // ============================================================
  print('=== Section 6: Tween Comparison ===');

  final tweenComparison = <Map<String, dynamic>>[
    {
      'tween': 'RelativeRectTween',
      'type': 'RelativeRect',
      'widget': 'PositionedTransition',
      'used': 'Stack-based position animation',
    },
    {
      'tween': 'RectTween',
      'type': 'Rect',
      'widget': 'Custom painting',
      'used': 'Canvas-level rectangle animation',
    },
    {
      'tween': 'Tween<Offset>',
      'type': 'Offset',
      'widget': 'SlideTransition',
      'used': 'Fractional translation animation',
    },
    {
      'tween': 'AlignmentTween',
      'type': 'Alignment',
      'widget': 'AlignTransition',
      'used': 'Alignment-based position animation',
    },
    {
      'tween': 'Tween<double>',
      'type': 'double',
      'widget': 'Various',
      'used': 'Single-axis position animation',
    },
  ];

  print('  Comparison rows: ${tweenComparison.length}');

  // ============================================================
  // SECTION 7: Practical Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Slide-in from edge',
      'detail': 'Animate from off-screen (left: -200) to final position. '
          'The begin RelativeRect has a negative left value, and end '
          'has the desired positive inset.',
      'code': 'RelativeRectTween(\n  begin: RelativeRect.fromLTRB(-200, 20, 500, 20),\n  end: RelativeRect.fromLTRB(20, 20, 20, 20),\n)',
      'icon': Icons.arrow_forward,
      'color': Colors.deepPurple[700]!,
    },
    {
      'title': 'Expand to fill',
      'detail': 'Animate a small positioned element to fill the Stack. '
          'Begin with large insets, end with RelativeRect.fill.',
      'code': 'RelativeRectTween(\n  begin: RelativeRect.fromLTRB(80, 80, 80, 80),\n  end: RelativeRect.fill,\n)',
      'icon': Icons.fullscreen,
      'color': Colors.orange[800]!,
    },
    {
      'title': 'Swap positions',
      'detail': 'Two items swap positions in a Stack by using mirrored '
          'tweens — one from left-to-right, the other right-to-left.',
      'code': '// Item A\nRelativeRectTween(\n  begin: RelativeRect.fromLTRB(0, 0, 150, 0),\n  end: RelativeRect.fromLTRB(150, 0, 0, 0),\n)\n// Item B: reversed begin/end',
      'icon': Icons.swap_horiz,
      'color': Colors.deepPurple[600]!,
    },
    {
      'title': 'Corner bounce',
      'detail': 'Chain multiple tweens with TweenSequence to move an '
          'element through all four corners of the Stack.',
      'code': 'TweenSequence<RelativeRect>([\n  TweenSequenceItem(\n    tween: RelativeRectTween(\n      begin: topLeft, end: topRight),\n    weight: 25),\n  // ... bottomRight, bottomLeft, topLeft\n])',
      'icon': Icons.open_with,
      'color': Colors.orange[700]!,
    },
  ];

  print('  Patterns: ${patterns.length}');

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
              colors: [Colors.deepPurple[800]!, Colors.orange[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.transform, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RelativeRectTween',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Interpolates between two RelativeRect values to animate '
                'Positioned widgets smoothly inside a Stack.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.deepPurple[700]!),
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

        // ---- Section 2: RelativeRect Structure ----
        _sectionHeader('2. RelativeRect Anatomy', Icons.crop_square, Colors.orange[800]!),
        SizedBox(height: 10),
        Text(
          'A RelativeRect defines four inset distances from the parent edges:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        ...rectProperties.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: p['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(p['name'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(p['description'] as String, style: TextStyle(fontSize: 12)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('begin: ${p['startVal']}',
                            style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.deepPurple[600])),
                        Text('end: ${p['endVal']}',
                            style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.orange[700])),
                      ],
                    ),
                  ],
                ),
              ),
            )),

        // Visual: Stack showing begin and end positions
        SizedBox(height: 10),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Stack(
            children: [
              // Center label
              Center(
                child: Text('Stack (parent)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ),
              // Begin position
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[300]!.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple[700]!, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text('begin\nt=0.0', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              // End position
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange[300]!.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[700]!, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text('end\nt=1.0', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              // Midpoint
              Positioned(
                left: 55,
                top: 40,
                child: Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple[200]!.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple[400]!, width: 1, style: BorderStyle.solid),
                  ),
                  alignment: Alignment.center,
                  child: Text('t=0.5', style: TextStyle(color: Colors.purple[800], fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 3: Lerp Table ----
        _sectionHeader('3. Lerp Values at Each t', Icons.timeline, Colors.deepPurple[700]!),
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
                color: Colors.deepPurple[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('t', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('left', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('top', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('right', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('bottom', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(lerpResults.length, (i) {
                final r = lerpResults[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.deepPurple[50],
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: r['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('${r['t']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: Text(r['left'] as String, style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text(r['top'] as String, style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text(r['right'] as String, style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                      Expanded(flex: 2, child: Text(r['bottom'] as String, style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Animation Frames ----
        _sectionHeader('4. Animation Frame Snapshots', Icons.movie, Colors.orange[800]!),
        SizedBox(height: 10),
        Text(
          'Five sequential frames showing the tween position at each step:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Row(
          children: List.generate(5, (i) {
            final r = lerpResults[i];
            final t = tValues[i];
            // Scale positions to mini-stack (60x80 pixels)
            final scaledLeft = 2.0 + (t * 30);
            final scaledTop = 2.0 + (t * 20);
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey[400]!),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: scaledLeft,
                            top: scaledTop,
                            child: Container(
                              width: 24,
                              height: 20,
                              decoration: BoxDecoration(
                                color: r['color'] as Color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(frameLabels[i],
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: r['color'] as Color),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Factory Methods ----
        _sectionHeader('5. RelativeRect Factory Methods', Icons.build, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        ...factoryMethods.map((f) => Padding(
              padding: EdgeInsets.only(bottom: 10),
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
                    Row(
                      children: [
                        Icon(f['icon'] as IconData, color: f['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(f['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: f['color'] as Color)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(f['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(f['example'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Tween Comparison ----
        _sectionHeader('6. Position Tween Comparison', Icons.compare_arrows, Colors.orange[800]!),
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
                color: Colors.orange[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Tween', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Used For', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(tweenComparison.length, (i) {
                final t = tweenComparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.orange[50],
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(t['tween'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(t['type'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(t['used'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Practical Patterns ----
        _sectionHeader('7. Practical Animation Patterns', Icons.engineering, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(p['icon'] as IconData, color: p['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(p['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(p['detail'] as String, style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- PositionedTransition Usage ----
        _sectionHeader('8. PositionedTransition Usage', Icons.code, Colors.orange[800]!),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'class _MyAnimState extends State<MyAnim>\n'
            '    with SingleTickerProviderStateMixin {\n'
            '  late final AnimationController _ctrl;\n'
            '  late final Animation<RelativeRect> _anim;\n\n'
            '  @override\n'
            '  void initState() {\n'
            '    super.initState();\n'
            '    _ctrl = AnimationController(\n'
            '      duration: Duration(milliseconds: 600),\n'
            '      vsync: this,\n'
            '    );\n'
            '    _anim = _ctrl.drive(\n'
            '      RelativeRectTween(\n'
            '        begin: RelativeRect.fromLTRB(0, 0, 200, 200),\n'
            '        end: RelativeRect.fromLTRB(100, 50, 50, 100),\n'
            '      ).chain(CurveTween(curve: Curves.easeInOut)),\n'
            '    );\n'
            '  }\n\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return Stack(\n'
            '      children: [\n'
            '        PositionedTransition(\n'
            '          rect: _anim,\n'
            '          child: Card(child: Text(\'Hello\')),\n'
            '        ),\n'
            '      ],\n'
            '    );\n'
            '  }\n'
            '}',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200]),
          ),
        ),

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
              Icon(Icons.transform, color: Colors.deepPurple[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RelativeRectTween: smoothly animate a child\'s position '
                'within a Stack by interpolating all four edge insets.',
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
