// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — AnimatedWidgetBaseState
// Demonstrates AnimatedWidgetBaseState, the base State class for all
// implicitly animated widgets. Covers forEachTween(), the tween update
// cycle, the implicit animation family, custom widget creation, and
// the distinction between explicit and implicit animations.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedWidgetBaseState Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is AnimatedWidgetBaseState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.auto_fix_high,
      'title': 'Implicit Animations',
      'body': 'Flutter has two animation systems: explicit (you control '
          'the AnimationController) and implicit (Flutter manages it). '
          'Implicit animations are the "easy mode" — just change a '
          'property and the widget animates to the new value. '
          'AnimatedContainer, AnimatedOpacity, AnimatedPadding all work '
          'this way.',
      'accent': Colors.purple,
    },
    {
      'icon': Icons.foundation,
      'title': 'AnimatedWidgetBaseState',
      'body': 'AnimatedWidgetBaseState is the State base class that '
          'powers every implicit animation widget. It manages an '
          'internal AnimationController, listens for property '
          'changes, creates/updates Tweens, and drives the animation. '
          'Subclasses just define which properties to animate.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.tune,
      'title': 'forEachTween() — The Key Method',
      'body': 'Each AnimatedWidgetBaseState subclass overrides '
          'forEachTween(), which is called whenever the widget rebuilds. '
          'In this method you declare each animated property: its current '
          'tween, the new target value, and a factory to create the tween. '
          'The base class handles everything else.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.play_circle,
      'title': 'Zero Boilerplate Animations',
      'body': 'Unlike explicit animations (AnimationController, '
          'TickerProviderStateMixin, dispose(), etc.), implicit '
          'animations need zero setup. Just use AnimatedContainer '
          'instead of Container, provide a duration, and changing any '
          'property triggers a smooth animation.',
      'accent': Colors.teal,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.08),
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

  final apiItems = <Map<String, String>>[
    {
      'label': 'Base Class',
      'value': 'AnimatedWidgetBaseState<T>',
      'detail': 'T extends ImplicitlyAnimatedWidget',
    },
    {
      'label': 'Extends',
      'value': 'ImplicitlyAnimatedWidgetState<T>',
      'detail': 'Which extends State<T> with animation support',
    },
    {
      'label': 'forEachTween()',
      'value': 'Abstract — must override',
      'detail': 'Called to register each animated property\'s tween',
    },
    {
      'label': 'didUpdateTweens()',
      'value': 'Optional override',
      'detail': 'Called after tweens are updated — use for side effects',
    },
    {
      'label': 'controller',
      'value': 'AnimationController (inherited)',
      'detail': 'The internal controller driving the animation',
    },
    {
      'label': 'animation',
      'value': 'Animation<double> (inherited)',
      'detail': 'Curved animation derived from controller + widget.curve',
    },
    {
      'label': 'widget.duration',
      'value': 'Duration',
      'detail': 'How long each property transition takes',
    },
    {
      'label': 'widget.curve',
      'value': 'Curve (default: Curves.linear)',
      'detail': 'The easing curve applied to the animation',
    },
  ];

  final apiWidgets = apiItems.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.purple, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              item['label']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.purple,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['value']!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  item['detail']!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: The Implicit Animation Family
  // ============================================================
  print('=== Section 3: Implicit Animation Family ===');

  // All widgets whose State extends AnimatedWidgetBaseState
  final implicitFamily = <Map<String, dynamic>>[
    {
      'name': 'AnimatedContainer',
      'animates': 'color, size, padding, margin, decoration, alignment, transform',
      'icon': Icons.crop_square,
      'color': Colors.blue,
    },
    {
      'name': 'AnimatedOpacity',
      'animates': 'opacity (0.0 to 1.0)',
      'icon': Icons.opacity,
      'color': Colors.purple,
    },
    {
      'name': 'AnimatedPadding',
      'animates': 'padding (EdgeInsets)',
      'icon': Icons.padding,
      'color': Colors.green,
    },
    {
      'name': 'AnimatedPositioned',
      'animates': 'left, top, right, bottom, width, height in a Stack',
      'icon': Icons.open_with,
      'color': Colors.orange,
    },
    {
      'name': 'AnimatedAlign',
      'animates': 'alignment (Alignment)',
      'icon': Icons.format_align_center,
      'color': Colors.teal,
    },
    {
      'name': 'AnimatedDefaultTextStyle',
      'animates': 'TextStyle properties (size, color, weight, etc.)',
      'icon': Icons.text_format,
      'color': Colors.red,
    },
    {
      'name': 'AnimatedPhysicalModel',
      'animates': 'elevation, color, borderRadius, shadowColor',
      'icon': Icons.layers,
      'color': Colors.indigo,
    },
    {
      'name': 'AnimatedTheme',
      'animates': 'All ThemeData properties',
      'icon': Icons.palette,
      'color': Colors.amber[800]!,
    },
    {
      'name': 'AnimatedCrossFade',
      'animates': 'Cross-fades between two children',
      'icon': Icons.swap_horiz,
      'color': Colors.cyan,
    },
    {
      'name': 'AnimatedSwitcher',
      'animates': 'Transition between different children',
      'icon': Icons.swap_calls,
      'color': Colors.pink,
    },
    {
      'name': 'AnimatedSize',
      'animates': 'Child size changes (automatically)',
      'icon': Icons.aspect_ratio,
      'color': Colors.brown,
    },
    {
      'name': 'AnimatedScale',
      'animates': 'scale (double)',
      'icon': Icons.zoom_in,
      'color': Colors.deepOrange,
    },
    {
      'name': 'AnimatedRotation',
      'animates': 'turns (number of full rotations)',
      'icon': Icons.rotate_right,
      'color': Colors.lime[800]!,
    },
    {
      'name': 'AnimatedSlide',
      'animates': 'offset (Offset in child-size multiples)',
      'icon': Icons.swipe,
      'color': Colors.blueGrey,
    },
    {
      'name': 'AnimatedFractionallySizedBox',
      'animates': 'widthFactor, heightFactor',
      'icon': Icons.straighten,
      'color': Colors.deepPurple,
    },
  ];

  print('  ${implicitFamily.length} implicit animation widgets catalogued');

  final familyWidgets = implicitFamily.map<Widget>((w) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: (w['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (w['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: (w['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(w['icon'] as IconData,
                color: w['color'] as Color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  w['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: w['color'] as Color,
                  ),
                ),
                Text(
                  'Animates: ${w['animates']}',
                  style: const TextStyle(fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: How forEachTween() Works
  // ============================================================
  print('=== Section 4: forEachTween() Explained ===');

  final tweenSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Widget Rebuilt',
      'detail': 'A parent calls setState() and AnimatedContainer rebuilds '
          'with new property values (e.g., color changes from red to blue)',
      'icon': Icons.refresh,
      'color': Colors.purple[900]!,
    },
    {
      'step': '2',
      'label': 'didUpdateWidget() Called',
      'detail': 'The ImplicitlyAnimatedWidgetState base detects the widget '
          'changed and calls forEachTween() on the state',
      'icon': Icons.update,
      'color': Colors.purple[700]!,
    },
    {
      'step': '3',
      'label': 'forEachTween() Iterates',
      'detail': 'The state visits each animated property. For each one it '
          'provides: (a) the current tween, (b) the new target value, '
          '(c) a factory to create a new tween if needed',
      'icon': Icons.loop,
      'color': Colors.purple[600]!,
    },
    {
      'step': '4',
      'label': 'Tweens Updated',
      'detail': 'If the target value changed, the tween\'s end is updated '
          '(and begin is set to the current evaluated value). If no tween '
          'exists yet, the factory creates one.',
      'icon': Icons.edit,
      'color': Colors.purple[500]!,
    },
    {
      'step': '5',
      'label': 'Controller Starts',
      'detail': 'The AnimationController resets to 0.0 and runs forward() '
          'to duration. The curved animation drives all tweens.',
      'icon': Icons.play_arrow,
      'color': Colors.purple[400]!,
    },
    {
      'step': '6',
      'label': 'build() Called Per Frame',
      'detail': 'Each frame, build() is called. The state evaluates each '
          'tween at the current animation value and paints the '
          'interpolated result.',
      'icon': Icons.brush,
      'color': Colors.green[600]!,
    },
  ];

  print('  ${tweenSteps.length} tween cycle steps');

  final tweenStepWidgets = tweenSteps.map<Widget>((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: step['color'] as Color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step['step'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (step['color'] as Color).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(
                    color: step['color'] as Color,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(step['icon'] as IconData,
                          size: 16, color: step['color'] as Color),
                      const SizedBox(width: 6),
                      Text(
                        step['label'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: step['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step['detail'] as String,
                    style: const TextStyle(fontSize: 12, height: 1.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // forEachTween code example
  final foreachTweenCode =
      '@override\n'
      'void forEachTween(TweenVisitor<dynamic> visitor) {\n'
      '  _color = visitor(\n'
      '    _color,                      // current tween\n'
      '    widget.color,                // target value\n'
      '    (value) => ColorTween(       // factory\n'
      '      begin: value as Color?,\n'
      '    ),\n'
      '  ) as ColorTween?;\n'
      '  _height = visitor(\n'
      '    _height,                     // current tween\n'
      '    widget.height,               // target value\n'
      '    (value) => Tween<double>(    // factory\n'
      '      begin: value as double?,\n'
      '    ),\n'
      '  ) as Tween<double>?;\n'
      '}';

  // ============================================================
  // SECTION 5: Live AnimatedContainer Demo
  // ============================================================
  print('=== Section 5: Live AnimatedContainer Demo ===');

  // Show several AnimatedContainers in different states to demonstrate
  // the range of properties that AnimatedWidgetBaseState can animate.
  final animatedContainerDemos = <Map<String, dynamic>>[
    {
      'label': 'Color Animation',
      'widget': AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text('Purple',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
      'note': 'Change color → smooth color transition',
    },
    {
      'label': 'Size Animation',
      'widget': AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('Wide',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
      'note': 'Change width/height → elastic size animation',
    },
    {
      'label': 'Border Radius Animation',
      'widget': AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Center(
          child: Text('Round',
              style: TextStyle(color: Colors.white, fontSize: 11)),
        ),
      ),
      'note': 'Change borderRadius → smooth corner transition',
    },
    {
      'label': 'Transform Animation',
      'widget': AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        transform: Matrix4.rotationZ(0.1),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purple[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('Tilted',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
      'note': 'Change transform → animated rotation/scale',
    },
    {
      'label': 'Padding Animation',
      'widget': AnimatedPadding(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(16),
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple[700],
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Text('Pad',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ),
      'note': 'AnimatedPadding animates padding changes',
    },
  ];

  print('  ${animatedContainerDemos.length} live animated demos');

  final liveDemoWidgets = animatedContainerDemos.map<Widget>((demo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demo['label'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                demo['widget'] as Widget,
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.04),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                demo['note'] as String,
                style: TextStyle(
                    fontSize: 11, color: Colors.grey[700], height: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Building a Custom Implicit Animation Widget
  // ============================================================
  print('=== Section 6: Custom Implicit Animation Widget ===');

  final customWidgetCode =
      'class AnimatedColorBox extends ImplicitlyAnimatedWidget {\n'
      '  const AnimatedColorBox({\n'
      '    required this.color,\n'
      '    required super.duration,\n'
      '    super.curve = Curves.linear,\n'
      '  });\n'
      '  final Color color;\n'
      '\n'
      '  @override\n'
      '  AnimatedWidgetBaseState<AnimatedColorBox> createState() =>\n'
      '      _AnimatedColorBoxState();\n'
      '}\n'
      '\n'
      'class _AnimatedColorBoxState\n'
      '    extends AnimatedWidgetBaseState<AnimatedColorBox> {\n'
      '  ColorTween? _color;\n'
      '\n'
      '  @override\n'
      '  void forEachTween(TweenVisitor<dynamic> visitor) {\n'
      '    _color = visitor(\n'
      '      _color,\n'
      '      widget.color,\n'
      '      (value) => ColorTween(begin: value as Color?),\n'
      '    ) as ColorTween?;\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  Widget build(BuildContext context) {\n'
      '    return Container(\n'
      '      width: 100, height: 100,\n'
      '      color: _color?.evaluate(animation),\n'
      '    );\n'
      '  }\n'
      '}';

  final customSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Define Widget',
      'detail': 'Extend ImplicitlyAnimatedWidget. Hold the animatable '
          'properties (e.g., color) and accept duration/curve.',
      'color': Colors.purple,
    },
    {
      'step': '2',
      'label': 'Create State',
      'detail': 'Override createState() to return an '
          'AnimatedWidgetBaseState subclass.',
      'color': Colors.indigo,
    },
    {
      'step': '3',
      'label': 'Declare Tweens',
      'detail': 'In the state, declare nullable Tween fields for '
          'each property you want to animate.',
      'color': Colors.blue,
    },
    {
      'step': '4',
      'label': 'Override forEachTween',
      'detail': 'Implement forEachTween() to register each tween with '
          'the visitor. Provide current tween, target, factory.',
      'color': Colors.teal,
    },
    {
      'step': '5',
      'label': 'Build with Evaluation',
      'detail': 'In build(), evaluate each tween at the current '
          'animation value: _color?.evaluate(animation).',
      'color': Colors.green,
    },
  ];

  final customStepWidgets = customSteps.map<Widget>((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (step['color'] as Color).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: step['color'] as Color,
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: step['color'] as Color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step['step'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['label'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: step['color'] as Color,
                  ),
                ),
                Text(
                  step['detail'] as String,
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
  // SECTION 7: Explicit vs Implicit Animations
  // ============================================================
  print('=== Section 7: Explicit vs Implicit ===');

  final comparisonData = <Map<String, String>>[
    {
      'aspect': 'Setup',
      'implicit': 'Zero — just use AnimatedWidget',
      'explicit': 'AnimationController + TickerProvider + dispose()',
    },
    {
      'aspect': 'Trigger',
      'implicit': 'Automatic on property change',
      'explicit': 'Manual: forward(), reverse(), repeat()',
    },
    {
      'aspect': 'Control',
      'implicit': 'Duration + Curve only',
      'explicit': 'Full control: timing, direction, repeat, status',
    },
    {
      'aspect': 'Base Class',
      'implicit': 'AnimatedWidgetBaseState',
      'explicit': 'AnimatedWidget / Custom State',
    },
    {
      'aspect': 'Use When',
      'implicit': 'Simple property transitions',
      'explicit': 'Complex choreography, sequences, physics',
    },
    {
      'aspect': 'Examples',
      'implicit': 'AnimatedContainer, AnimatedOpacity',
      'explicit': 'AnimationController, TweenSequence',
    },
  ];

  final comparisonHeader = Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.purple[800],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text('Aspect',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Expanded(
          child: Text('Implicit',
              style: TextStyle(
                  color: Colors.purple[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Expanded(
          child: Text('Explicit',
              style: TextStyle(
                  color: Colors.orange[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
      ],
    ),
  );

  final comparisonRows =
      comparisonData.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: i.isEven
            ? Colors.purple.withOpacity(0.04)
            : Colors.purple.withOpacity(0.09),
        border: Border(
          bottom: BorderSide(color: Colors.purple.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(row['aspect']!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 11)),
          ),
          Expanded(
            child: Text(row['implicit']!,
                style:
                    TextStyle(fontSize: 11, color: Colors.purple[700])),
          ),
          Expanded(
            child: Text(row['explicit']!,
                style:
                    TextStyle(fontSize: 11, color: Colors.orange[800])),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Animation Curve Gallery
  // ============================================================
  print('=== Section 8: Animation Curve Gallery ===');

  // Show many curves with AnimatedContainer to demonstrate how
  // curve affects the animation powered by AnimatedWidgetBaseState
  final curveGallery = <Map<String, dynamic>>[
    {'name': 'linear', 'curve': Curves.linear, 'color': Colors.grey},
    {'name': 'easeIn', 'curve': Curves.easeIn, 'color': Colors.blue},
    {'name': 'easeOut', 'curve': Curves.easeOut, 'color': Colors.green},
    {'name': 'easeInOut', 'curve': Curves.easeInOut, 'color': Colors.purple},
    {'name': 'fastOutSlowIn', 'curve': Curves.fastOutSlowIn, 'color': Colors.red},
    {'name': 'bounceIn', 'curve': Curves.bounceIn, 'color': Colors.orange},
    {'name': 'bounceOut', 'curve': Curves.bounceOut, 'color': Colors.teal},
    {'name': 'elasticIn', 'curve': Curves.elasticIn, 'color': Colors.indigo},
    {'name': 'elasticOut', 'curve': Curves.elasticOut, 'color': Colors.pink},
    {'name': 'decelerate', 'curve': Curves.decelerate, 'color': Colors.brown},
  ];

  print('  ${curveGallery.length} curves in gallery');

  final curveWidgets = curveGallery.map<Widget>((curveItem) {
    // Each curve shown as an AnimatedContainer with a progress bar
    // that visually hints at the curve's character
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: (curveItem['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (curveItem['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              curveItem['name'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: curveItem['color'] as Color,
              ),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: curveItem['curve'] as Curve,
              height: 24,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (curveItem['color'] as Color).withOpacity(0.8),
                    (curveItem['color'] as Color).withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.timeline, size: 16,
              color: (curveItem['color'] as Color).withOpacity(0.6)),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Implicit animation widgets', 'value': '${implicitFamily.length}', 'icon': Icons.auto_fix_high},
    {'label': 'Tween cycle steps', 'value': '${tweenSteps.length}', 'icon': Icons.loop},
    {'label': 'Animation curves', 'value': '${curveGallery.length}', 'icon': Icons.timeline},
    {'label': 'Custom widget steps', 'value': '${customSteps.length}', 'icon': Icons.build},
    {'label': 'Live demos shown', 'value': '${animatedContainerDemos.length}', 'icon': Icons.play_circle},
    {'label': 'API properties', 'value': '${apiItems.length}', 'icon': Icons.code},
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
              Colors.purple.withOpacity(0.12),
              Colors.purple.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.purple.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.purple, size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
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
  Widget animSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.purple[300]!],
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

  print('AnimatedWidgetBaseState Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('AnimatedWidgetBaseState'),
      backgroundColor: Colors.purple,
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
                colors: [Colors.purple, Colors.purple[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.auto_fix_high, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'AnimatedWidgetBaseState',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The base State class for all implicitly animated widgets. '
                  'It manages Tween interpolation, AnimationControllers, and '
                  'the forEachTween() lifecycle — powering zero-boilerplate '
                  'property animations across Flutter.',
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
          animSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          animSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          // Section 3
          animSectionHeader('3', 'Implicit Animation Family', Icons.family_restroom),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'All these widgets use AnimatedWidgetBaseState under the hood. '
              'Their State classes extend it and implement forEachTween():',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          ...familyWidgets,

          // Section 4
          animSectionHeader('4', 'How forEachTween() Works', Icons.loop),
          ...tweenStepWidgets,
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'forEachTween() Implementation:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  foreachTweenCode,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ],
            ),
          ),

          // Section 5
          animSectionHeader('5', 'Live Animation Demos', Icons.play_circle),
          ...liveDemoWidgets,

          // Section 6
          animSectionHeader('6', 'Custom Implicit Widget', Icons.build),
          ...customStepWidgets,
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Complete Custom Widget:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  customWidgetCode,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ],
            ),
          ),

          // Section 7
          animSectionHeader('7', 'Explicit vs Implicit', Icons.compare),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.purple.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                comparisonHeader,
                ...comparisonRows,
              ],
            ),
          ),

          // Section 8
          animSectionHeader('8', 'Animation Curve Gallery', Icons.timeline),
          ...curveWidgets,

          // Section 9
          animSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
