// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — SliverFadeTransition
// Demonstrates SliverFadeTransition — an animated opacity wrapper
// for sliver widgets. Analogous to FadeTransition but works in
// CustomScrollView with slivers. Covers animation setup, opacity
// control, sliver context, performance, and practical patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverFadeTransition Deep Demo executing');

  // ============================================================
  // SECTION 1: What is SliverFadeTransition?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.opacity,
      'title': 'Animated Opacity for Slivers',
      'body': 'SliverFadeTransition is a sliver widget that applies an '
          'animated opacity to its sliver child. It is the sliver version '
          'of FadeTransition — while FadeTransition works with regular '
          'box widgets, SliverFadeTransition works inside '
          'CustomScrollView and NestedScrollView.',
      'accent': Colors.lightGreen[700]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Driven by Animation<double>',
      'body': 'You provide an Animation<double> (typically from an '
          'AnimationController) that controls the opacity. Value 0.0 '
          'is fully transparent, 1.0 is fully opaque. The widget '
          'rebuilds efficiently as the animation ticks.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.view_list,
      'title': 'Works with All Slivers',
      'body': 'Wraps any sliver child: SliverList, SliverGrid, '
          'SliverAppBar, SliverToBoxAdapter, SliverPadding, etc. '
          'The child remains a first-class sliver in the scroll '
          'viewport — no layout penalty, just painting opacity.',
      'accent': Colors.lightGreen[600]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Performance: RenderObject Level',
      'body': 'Unlike wrapping a sliver\'s content in an Opacity widget, '
          'SliverFadeTransition operates at the sliver render object level. '
          'It paints the entire sliver with an opacity layer. The animation '
          'avoids rebuilding the sliver\'s children.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'opacity',
      'type': 'Animation<double>',
      'icon': Icons.opacity,
      'color': Colors.lightGreen[700]!,
      'description': 'The animation that drives the opacity. Values should '
          'be between 0.0 and 1.0. Values outside this range are clamped. '
          'Typically comes from an AnimationController, a CurvedAnimation, '
          'or a Tween<double>.animate() chain.',
    },
    {
      'name': 'sliver',
      'type': 'Widget (sliver)',
      'icon': Icons.view_list,
      'color': Colors.teal[700]!,
      'description': 'The child sliver widget to fade. Must produce a '
          'RenderSliver, not a RenderBox. Pass any sliver widget here: '
          'SliverList, SliverGrid, SliverToBoxAdapter, etc. The child '
          'participates normally in the sliver layout protocol.',
    },
    {
      'name': 'alwaysIncludeSemantics',
      'type': 'bool',
      'icon': Icons.accessibility,
      'color': Colors.lightGreen[600]!,
      'description': 'Whether to include the sliver\'s semantics in the '
          'semantics tree even when fully transparent (opacity 0.0). '
          'Default is false. Set to true if screen readers should still '
          'announce the hidden content.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: FadeTransition vs SliverFadeTransition
  // ============================================================
  print('=== Section 3: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Widget Type',
      'fade': 'Box widget (RenderBox)',
      'sliver': 'Sliver widget (RenderSliver)',
    },
    {
      'aspect': 'Parent',
      'fade': 'Column, Stack, any box parent',
      'sliver': 'CustomScrollView, NestedScrollView',
    },
    {
      'aspect': 'Child',
      'fade': 'Any box widget',
      'sliver': 'Any sliver widget',
    },
    {
      'aspect': 'Opacity Source',
      'fade': 'Animation<double> opacity',
      'sliver': 'Animation<double> opacity',
    },
    {
      'aspect': 'Performance',
      'fade': 'Opacity layer on box paint',
      'sliver': 'Opacity layer on sliver paint',
    },
    {
      'aspect': 'Use Case',
      'fade': 'Fade in/out buttons, cards, images',
      'sliver': 'Fade in/out list sections, grids',
    },
    {
      'aspect': 'Analogy',
      'fade': 'AnimatedOpacity for explicit anim',
      'sliver': 'SliverAnimatedOpacity for implicit',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 4: Sliver Family
  // ============================================================
  print('=== Section 4: Sliver Family ===');

  final sliverFamily = <Map<String, dynamic>>[
    {
      'name': 'SliverFadeTransition',
      'icon': Icons.opacity,
      'color': Colors.lightGreen[700]!,
      'type': 'Explicit animation',
      'description': 'You control the Animation<double>. Paired with '
          'AnimationController for full programmatic control. Best when '
          'you need to sync with other animations or trigger from code.',
    },
    {
      'name': 'SliverAnimatedOpacity',
      'icon': Icons.auto_awesome,
      'color': Colors.teal[700]!,
      'type': 'Implicit animation',
      'description': 'You set a target opacity value and duration. The '
          'widget animates to the new value automatically. Simpler API '
          'when you just need fade-in/fade-out without custom curves.',
    },
    {
      'name': 'SliverOpacity',
      'icon': Icons.visibility,
      'color': Colors.lightGreen[600]!,
      'type': 'No animation',
      'description': 'Applies a static opacity to a sliver. No animation — '
          'instant opacity change. Use when you need conditional visibility '
          'without any transition effect.',
    },
    {
      'name': 'SliverVisibility',
      'icon': Icons.visibility_off,
      'color': Colors.teal[600]!,
      'type': 'Visibility toggle',
      'description': 'Shows/hides a sliver completely. When hidden, the '
          'sliver takes no space in the scroll view. Different from '
          'opacity 0.0 which still occupies space.',
    },
  ];

  print('  Prepared ${sliverFamily.length} sliver family members');

  // ============================================================
  // SECTION 5: Animation Setup Patterns
  // ============================================================
  print('=== Section 5: Animation Patterns ===');

  final animationPatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic AnimationController',
      'color': Colors.lightGreen[700]!,
      'code': 'class _MyState extends State<MyWidget>\n'
          '    with SingleTickerProviderStateMixin {\n'
          '  late final AnimationController _controller;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _controller = AnimationController(\n'
          '      duration: Duration(milliseconds: 500),\n'
          '      vsync: this,\n'
          '    );\n'
          '    _controller.forward(); // Fade in\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return CustomScrollView(\n'
          '      slivers: [\n'
          '        SliverFadeTransition(\n'
          '          opacity: _controller,\n'
          '          sliver: SliverList(...),\n'
          '        ),\n'
          '      ],\n'
          '    );\n'
          '  }\n'
          '}',
    },
    {
      'title': 'With CurvedAnimation',
      'color': Colors.teal[700]!,
      'code': 'late final Animation<double> _opacity;\n'
          '\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  _controller = AnimationController(\n'
          '    duration: Duration(milliseconds: 800),\n'
          '    vsync: this,\n'
          '  );\n'
          '  _opacity = CurvedAnimation(\n'
          '    parent: _controller,\n'
          '    curve: Curves.easeInOut,\n'
          '  );\n'
          '}\n'
          '\n'
          'SliverFadeTransition(\n'
          '  opacity: _opacity,\n'
          '  sliver: SliverGrid(...),\n'
          ')',
    },
    {
      'title': 'With Tween Interval',
      'color': Colors.lightGreen[600]!,
      'code': '// Fade happens between 20% and 60% of the\n'
          '// overall animation duration\n'
          'final _opacity = Tween<double>(\n'
          '  begin: 0.0,\n'
          '  end: 1.0,\n'
          ').animate(CurvedAnimation(\n'
          '  parent: _controller,\n'
          '  curve: Interval(0.2, 0.6, curve: Curves.easeIn),\n'
          '));\n'
          '\n'
          'SliverFadeTransition(\n'
          '  opacity: _opacity,\n'
          '  sliver: SliverToBoxAdapter(...),\n'
          ')',
    },
    {
      'title': 'Staggered Multi-Sliver Fade',
      'color': Colors.teal[600]!,
      'code': '// Three slivers fading in sequence\n'
          'final _op1 = _tween(0.0, 0.3);\n'
          'final _op2 = _tween(0.2, 0.5);\n'
          'final _op3 = _tween(0.4, 0.7);\n'
          '\n'
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverFadeTransition(\n'
          '      opacity: _op1, sliver: _header),\n'
          '    SliverFadeTransition(\n'
          '      opacity: _op2, sliver: _list),\n'
          '    SliverFadeTransition(\n'
          '      opacity: _op3, sliver: _footer),\n'
          '  ],\n'
          ')',
    },
  ];

  print('  Prepared ${animationPatterns.length} animation patterns');

  // ============================================================
  // SECTION 6: Opacity Levels Visual
  // ============================================================
  print('=== Section 6: Opacity Levels ===');

  final opacityLevels = <Map<String, dynamic>>[
    {'value': 0.0, 'label': '0.0 — Invisible'},
    {'value': 0.1, 'label': '0.1 — Barely visible'},
    {'value': 0.25, 'label': '0.25 — Faint'},
    {'value': 0.5, 'label': '0.5 — Half visible'},
    {'value': 0.75, 'label': '0.75 — Mostly visible'},
    {'value': 0.9, 'label': '0.9 — Nearly opaque'},
    {'value': 1.0, 'label': '1.0 — Fully opaque'},
  ];

  print('  Prepared ${opacityLevels.length} opacity levels');

  // ============================================================
  // SECTION 7: Real-World Scenarios
  // ============================================================
  print('=== Section 7: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Loading → Content Fade-In',
      'icon': Icons.download_done,
      'color': Colors.lightGreen[700]!,
      'description': 'Data loads asynchronously. While loading, show a '
          'SliverToBoxAdapter with a skeleton loader. When data arrives, '
          'fade in the real SliverList. The opacity animation runs from '
          '0.0 to 1.0 with an ease-in curve.',
      'sequence': [
        'State: loading → show skeleton',
        'Data arrives → start _controller.forward()',
        'SliverFadeTransition(opacity: _controller)',
        'Content fades in smoothly over 500ms',
      ],
    },
    {
      'name': 'Staggered Section Reveal',
      'icon': Icons.view_stream,
      'color': Colors.teal[700]!,
      'description': 'A scroll view with header, body, and footer sections. '
          'Each section fades in with a staggered delay (header first, then '
          'body 200ms later, then footer 200ms after that). Creates a '
          'cascading reveal effect.',
      'sequence': [
        'Controller starts → header fade begins (0.0-0.3)',
        '200ms later → body fade begins (0.2-0.5)',
        '200ms later → footer fade begins (0.4-0.7)',
        'All sections visible by controller value 0.7',
      ],
    },
    {
      'name': 'Collapsible Grid Section',
      'icon': Icons.grid_view,
      'color': Colors.lightGreen[600]!,
      'description': 'A product grid that can be collapsed/expanded. When '
          'collapsed, the SliverGrid fades out to 0.0 and is replaced by '
          'a summary. When expanded, it fades back in. Combined with '
          'SliverAnimatedList for smooth layout changes.',
      'sequence': [
        'User taps "Collapse" → _controller.reverse()',
        'SliverGrid fades out (1.0 → 0.0)',
        'Layout shrinks smoothly',
        'User taps "Expand" → _controller.forward()',
      ],
    },
    {
      'name': 'Search Results Animation',
      'icon': Icons.search,
      'color': Colors.teal[600]!,
      'description': 'When search results change, the old list fades out, '
          'new results are set, then the list fades back in. Prevents '
          'jarring content jumps during search updates.',
      'sequence': [
        'User types query → _controller.reverse()',
        'Old results fade out (250ms)',
        'Results updated in state',
        'New results fade in → _controller.forward()',
      ],
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 8: Performance Tips
  // ============================================================
  print('=== Section 8: Performance ===');

  final perfTips = <Map<String, dynamic>>[
    {
      'title': 'Use SliverFadeTransition, Not Opacity',
      'icon': Icons.speed,
      'color': Colors.lightGreen[700]!,
      'description': 'Don\'t wrap a sliver\'s children individually in '
          'Opacity widgets. SliverFadeTransition applies opacity at the '
          'sliver painting level — one opacity layer for the entire sliver, '
          'not one per child. Much more efficient for lists and grids.',
    },
    {
      'title': 'Avoid Opacity 0.0 When Possible',
      'icon': Icons.visibility_off,
      'color': Colors.teal[700]!,
      'description': 'A sliver at opacity 0.0 is still laid out and still '
          'participates in scrolling. If you don\'t need the space, use '
          'SliverVisibility or conditionally include the sliver. Opacity '
          '0.0 just skips painting, not layout.',
    },
    {
      'title': 'RepaintBoundary Benefits',
      'icon': Icons.layers,
      'color': Colors.lightGreen[600]!,
      'description': 'SliverFadeTransition creates an opacity layer in the '
          'compositing tree. This acts like a natural repaint boundary. '
          'When opacity changes, only the layer is updated — children don\'t '
          'repaint. This is the key performance advantage.',
    },
    {
      'title': 'AnimationController Disposal',
      'icon': Icons.delete_sweep,
      'color': Colors.teal[600]!,
      'description': 'Always dispose your AnimationController in dispose(). '
          'An undisposed controller with an active listener on '
          'SliverFadeTransition can cause leaks and errors when the widget '
          'is removed from the tree.',
    },
  ];

  print('  Prepared ${perfTips.length} performance tips');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Child Must Be a Sliver',
      'body': 'The sliver parameter must be a sliver widget (produces '
          'RenderSliver). If you need to fade a box widget inside a '
          'scroll view, wrap it in SliverToBoxAdapter first, then '
          'wrap that in SliverFadeTransition.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Initial Opacity Matters',
      'body': 'If your AnimationController starts at 0.0 and you haven\'t '
          'called forward() yet, the sliver is completely invisible from '
          'the first frame. If you want it visible initially, set the '
          'controller\'s value to 1.0 or use lowerBound: 1.0.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pair with SliverAnimatedOpacity',
      'body': 'Need simpler API? SliverAnimatedOpacity is the implicit '
          'animation version. Just set opacity: 0.0 or 1.0 and a duration — '
          'it handles the AnimationController internally. Choose based on '
          'whether you need explicit control.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'No Hit Testing at Opacity 0.0',
      'body': 'When fully transparent, the sliver\'s children cannot '
          'receive touch events. This is by design — invisible content '
          'should not be interactive. If you need invisible but tappable '
          'content, consider using a Stack with a transparent GestureDetector.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'alwaysIncludeSemantics for A11y',
      'body': 'Set alwaysIncludeSemantics: true if screen readers should '
          'announce the sliver\'s content even when faded out. This is '
          'important for fade-in animations where content is about to appear '
          '— the screen reader should be aware of it.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with SliverAnimatedList',
      'body': 'For the best UX, combine SliverFadeTransition (section '
          'level opacity) with SliverAnimatedList (item-level insert/remove '
          'animations). Fade the section in, then animate individual items '
          'for a polished reveal.',
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
      title: Text('SliverFadeTransition'),
      backgroundColor: Colors.lightGreen[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightGreen[700]!, Colors.teal[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.opacity, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'SliverFadeTransition',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Animated opacity wrapper for sliver widgets. The sliver '
                  'equivalent of FadeTransition — drives opacity via an '
                  'Animation<double> within CustomScrollView contexts.',
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
          _sfHead('1', 'What is SliverFadeTransition?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _sfHead('2', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
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
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _sfPill(p['type'] as String, p['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Comparison ──
          _sfHead('3', 'FadeTransition vs SliverFadeTransition'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 70,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('FadeTransition',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('SliverFade...',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['fade'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['sliver'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.lightGreen[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 4: Sliver Family ──
          _sfHead('4', 'Sliver Opacity Family'),
          SizedBox(height: 12),
          ...sliverFamily.map((sf) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sf['color'] as Color, width: 4),
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
                        Icon(sf['icon'] as IconData,
                            color: sf['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(sf['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                        _sfPill(sf['type'] as String, sf['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(sf['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Animation Patterns ──
          _sfHead('5', 'Animation Setup Patterns'),
          SizedBox(height: 12),
          ...animationPatterns.map((ap) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ap['color'] as Color, width: 4),
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
                      Text(ap['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ap['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.lightGreen[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Opacity Levels ──
          _sfHead('6', 'Opacity Levels Visualization'),
          SizedBox(height: 12),
          Container(
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
            child: Column(
              children: opacityLevels.map((ol) {
                final value = ol['value'] as double;
                return Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(children: [
                    SizedBox(
                        width: 30,
                        child: Text('$value',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]))),
                    SizedBox(width: 8),
                    Expanded(
                      child: Stack(
                        children: [
                          // Background pattern
                          Container(
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[200],
                            ),
                          ),
                          // Colored overlay at given opacity
                          Opacity(
                            opacity: value,
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.lightGreen[600]!,
                                    Colors.teal[600]!,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  ol['label'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 7: Scenarios ──
          _sfHead('7', 'Real-World Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((sc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sc['color'] as Color, width: 4),
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
                        Icon(sc['icon'] as IconData,
                            color: sc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(sc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(sc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      ...(sc['sequence'] as List<String>)
                          .asMap()
                          .entries
                          .map((entry) => Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Color.lerp(
                                            Colors.lightGreen[400],
                                            Colors.teal[700],
                                            entry.key /
                                                ((sc['sequence'] as List)
                                                        .length -
                                                    1))!,
                                        borderRadius:
                                            BorderRadius.circular(9),
                                      ),
                                      child: Center(
                                        child: Text(
                                            '${entry.key + 1}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight:
                                                    FontWeight.bold)),
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(entry.value,
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

          // ── Section 8: Performance ──
          _sfHead('8', 'Performance Tips'),
          SizedBox(height: 12),
          ...perfTips.map((pt) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pt['color'] as Color, width: 4),
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
                        Icon(pt['icon'] as IconData,
                            color: pt['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pt['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(pt['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _sfHead('9', 'Tips & Gotchas'),
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
          Center(
            child: Text(
              'End of SliverFadeTransition Deep Demo',
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
Widget _sfHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.lightGreen[700],
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
// Helper: Pill badge
// ──────────────────────────────────────────────────────────
Widget _sfPill(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 150),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
