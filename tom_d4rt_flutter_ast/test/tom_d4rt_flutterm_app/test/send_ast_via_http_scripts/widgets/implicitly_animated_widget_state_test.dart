// ignore_for_file: avoid_print
// ImplicitlyAnimatedWidgetState – comprehensive deep demo
// Forest Green / Mint palette – the abstract base state that orchestrates
// animation controllers and tween management for implicit animation widgets.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color wsForest = Color(0xFF1B5E20);
  const Color wsMint = Color(0xFFE8F5E9);
  const Color wsOnForest = Color(0xFFFFFFFF);
  const Color wsDark = Color(0xFF003300);
  const Color wsLightMint = Color(0xFFF1F9F1);
  const Color wsTextDark = Color(0xFF1A2E1A);
  const Color wsAccent = Color(0xFF43A047);
  const Color wsMuted = Color(0xFFA5D6A7);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget wsHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [wsForest, wsDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: wsOnForest)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: wsOnForest.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget wsSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: wsLightMint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: wsForest.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: wsForest.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: wsForest)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget wsBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: wsAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: wsTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget wsCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2E0A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: wsMint,
              height: 1.5)),
    );
  }

  Widget wsKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: wsDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: wsTextDark)),
          ),
        ],
      ),
    );
  }

  Widget wsHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: wsAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: wsAccent.withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: wsDark,
              height: 1.4)),
    );
  }

  Widget wsDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: wsMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget wsPhaseRow(String phase, String desc, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(phase,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(fontSize: 10, color: wsTextDark)),
          ),
        ],
      ),
    );
  }

  Widget wsCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: wsForest,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: wsDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: wsTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget wsInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: wsForest.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: wsForest)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: wsDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: wsTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: wsMint,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          wsHeader(
            'ImplicitlyAnimatedWidgetState',
            'Abstract base state that orchestrates animation controllers, '
                'tween management, and the forEachTween visitor pattern for '
                'implicit animation widgets',
          ),

          // ── 1. class identity ──
          wsSection('1 · Class Identity & Hierarchy', [
            wsKeyValue('Class',
                'ImplicitlyAnimatedWidgetState<T>'),
            wsKeyValue('Extends', 'State<T>'),
            wsKeyValue('Mixin', 'SingleTickerProviderStateMixin<T>'),
            wsKeyValue('T constraint', 'extends ImplicitlyAnimatedWidget'),
            wsKeyValue('Library', 'package:flutter/widgets.dart'),
            wsDivider(),
            wsBullet(
                'ImplicitlyAnimatedWidgetState is the engine behind every '
                'implicit animation widget. It creates and manages the '
                'AnimationController, builds CurvedAnimation, and provides '
                'the forEachTween hook for subclasses.'),
            wsBullet(
                'The SingleTickerProviderStateMixin supplies the vsync '
                'ticker that drives the animation controller.'),
          ]),

          // ── 2. lifecycle phases ──
          wsSection('2 · State Lifecycle Phases', [
            wsPhaseRow('initState', 'Create controller, set duration, '
                'build initial tweens via forEachTween',
                const Color(0xFF1B5E20)),
            wsPhaseRow('didUpdate', 'Check for new duration/curve, '
                'update tweens, start animation if changed',
                const Color(0xFF0277BD)),
            wsPhaseRow('build', 'Evaluate tweens at current animation '
                'value, build widget tree with animated values',
                const Color(0xFFE65100)),
            wsPhaseRow('dispose', 'Dispose CurvedAnimation and '
                'AnimationController (ticker handles vsync)',
                const Color(0xFF880E4F)),
            wsDivider(),
            wsCodeBlock(
                '// Complete lifecycle flow:\n'
                '//\n'
                '// initState()\n'
                '//   → controller = AnimationController(duration, vsync)\n'
                '//   → _constructTweens()  // calls forEachTween\n'
                '//   → didUpdateTweens()   // hook for subclass\n'
                '//\n'
                '// didUpdateWidget(oldWidget)\n'
                '//   → update controller.duration if changed\n'
                '//   → rebuild CurvedAnimation if curve changed\n'
                '//   → _updateTweens()  // calls forEachTween\n'
                '//   → if tweens changed → controller.forward(from: 0)\n'
                '//   → didUpdateTweens()'),
          ]),

          // ── 3. animation controller ──
          wsSection('3 · Animation Controller Management', [
            wsBullet(
                'The state creates an AnimationController in initState() '
                'with the duration from widget.duration.'),
            wsBullet(
                'controller is exposed as a protected property so '
                'subclasses can access it if needed.'),
            wsCodeBlock(
                '// Controller setup in initState:\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  _controller = AnimationController(\n'
                '    duration: widget.duration,\n'
                '    debugLabel: kDebugMode ? widget.toStringShort() : null,\n'
                '    vsync: this,  // SingleTickerProviderStateMixin\n'
                '  );\n'
                '  _controller.addStatusListener((status) {\n'
                '    if (status == AnimationStatus.completed) {\n'
                '      widget.onEnd?.call();\n'
                '    }\n'
                '  });\n'
                '}'),
            wsDivider(),
            wsKeyValue('duration', 'From widget.duration (required)'),
            wsKeyValue('vsync', 'this (via SingleTickerProviderStateMixin)'),
            wsKeyValue('onEnd', 'Called when animation reaches completed'),
          ]),

          // ── 4. forEachTween pattern ──
          wsSection('4 · The forEachTween Visitor Pattern', [
            wsHighlight(
                'forEachTween is the central mechanism. Subclasses override '
                'it to declare which properties are animated. The framework '
                'calls it during init and on every widget update to build '
                'and update Tween objects.'),
            wsCodeBlock(
                '// forEachTween signature:\n'
                '@protected\n'
                'void forEachTween(\n'
                '  TweenVisitor<dynamic> visitor,\n'
                ');\n'
                '\n'
                '// TweenVisitor typedef:\n'
                'typedef TweenVisitor<T> = Tween<T>? Function(\n'
                '  Tween<T>? tween,      // current tween (null on first)\n'
                '  T targetValue,        // new target value\n'
                '  TweenConstructor<T> constructor,  // factory\n'
                ');\n'
                '\n'
                '// TweenConstructor typedef:\n'
                'typedef TweenConstructor<T> = Tween<T> Function(T value);'),
            wsDivider(),
            wsBullet('First call (initState): tween is null, visitor '
                'creates a new Tween with begin=targetValue.'),
            wsBullet('Subsequent calls (didUpdateWidget): tween exists, '
                'visitor updates tween.begin=tween.evaluate(animation), '
                'tween.end=targetValue.'),
          ]),

          // ── 5. concrete forEachTween example ──
          wsSection('5 · Implementing forEachTween', [
            wsCodeBlock(
                '// Example: AnimatedContainer state\n'
                'class _AnimatedContainerState\n'
                '    extends AnimatedWidgetBaseState<AnimatedContainer> {\n'
                '  ColorTween? _color;\n'
                '  DecorationTween? _decoration;\n'
                '  AlignmentGeometryTween? _alignment;\n'
                '  EdgeInsetsGeometryTween? _padding;\n'
                '  BoxConstraintsTween? _constraints;\n'
                '\n'
                '  @override\n'
                '  void forEachTween(TweenVisitor<dynamic> visitor) {\n'
                '    _color = visitor(\n'
                '      _color,\n'
                '      widget.color,\n'
                '      (value) => ColorTween(begin: value as Color?),\n'
                '    ) as ColorTween?;\n'
                '    _decoration = visitor(\n'
                '      _decoration,\n'
                '      widget.decoration,\n'
                '      (value) => DecorationTween(\n'
                '        begin: value as Decoration?,\n'
                '      ),\n'
                '    ) as DecorationTween?;\n'
                '    // ... each animated property\n'
                '  }\n'
                '}'),
            wsDivider(),
            wsBullet(
                'Each animated property gets a nullable tween field. '
                'The visitor either creates a new tween or updates an '
                'existing one depending on whether tween was null.'),
          ]),

          // ── 6. tween update flow ──
          wsSection('6 · Tween Update Flow', [
            wsInfoRow('1', 'Widget rebuilt:', 'New color/size/etc props'),
            wsInfoRow('2', 'didUpdateWidget:', 'Framework calls update'),
            wsInfoRow('3', 'forEachTween:', 'Each tween visited'),
            wsInfoRow('4', 'Tween.begin =', 'Current animated value'),
            wsInfoRow('5', 'Tween.end =', 'New target value'),
            wsInfoRow('6', 'controller:', 'forward(from: 0.0)'),
            wsInfoRow('7', 'build():', 'Tween.evaluate(animation)'),
            wsDivider(),
            wsCodeBlock(
                '// What the visitor does internally:\n'
                '//\n'
                '// if (tween == null) {\n'
                '//   // First time: create new tween\n'
                '//   tween = constructor(targetValue);\n'
                '//   shouldStartAnimation = false;\n'
                '// } else {\n'
                '//   if (tween.end != targetValue) {\n'
                '//     tween.begin = tween.evaluate(animation);\n'
                '//     tween.end = targetValue;\n'
                '//     shouldStartAnimation = true;\n'
                '//   }\n'
                '// }'),
          ]),

          // ── 7. curve management ──
          wsSection('7 · Curve & CurvedAnimation', [
            wsBullet(
                'ImplicitlyAnimatedWidgetState wraps the controller in a '
                'CurvedAnimation using widget.curve.'),
            wsBullet(
                'The CurvedAnimation is rebuilt whenever the curve changes '
                'in didUpdateWidget.'),
            wsCodeBlock(
                '// Curve setup:\n'
                'late Animation<double> _animation;\n'
                '\n'
                '// In initState / didUpdateWidget:\n'
                '_animation = CurvedAnimation(\n'
                '  parent: controller,\n'
                '  curve: widget.curve,  // e.g., Curves.easeInOut\n'
                ');\n'
                '\n'
                '// Subclasses use animation (not controller) to\n'
                '// evaluate tweens:\n'
                '// final color = _colorTween?.evaluate(animation);'),
            wsDivider(),
            wsKeyValue('Default curve', 'Curves.linear'),
            wsKeyValue('Common choices',
                'easeInOut, easeIn, easeOut, fastOutSlowIn'),
            wsKeyValue('Access via', 'animation getter (CurvedAnimation)'),
          ]),

          // ── 8. ImplicitlyAnimatedWidgetState vs AnimatedWidgetBaseState ──
          wsSection('8 · State Base Classes Compared', [
            wsCompare('ImplicitlyAnimatedWidgetState',
                'Base class. Does NOT auto-call setState on tick. '
                'Subclasses control when build() runs.'),
            wsCompare('AnimatedWidgetBaseState',
                'Extends ImplicitlyAnimatedWidgetState. Adds an '
                'animation listener that calls setState() every tick.'),
            wsDivider(),
            wsCodeBlock(
                '// AnimatedWidgetBaseState adds:\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  controller.addListener(() {\n'
                '    setState(() { /* rebuild every frame */ });\n'
                '  });\n'
                '}\n'
                '\n'
                '// ImplicitlyAnimatedWidgetState does NOT do this.\n'
                '// Useful when you want to control rebuild timing.'),
            wsDivider(),
            wsHighlight(
                'Most built-in Flutter implicit animation widgets use '
                'AnimatedWidgetBaseState because they need to rebuild '
                'every frame. Use the plain ImplicitlyAnimatedWidgetState '
                'only when you need custom rebuild control.'),
          ]),

          // ── 9. common implicit animation widgets ──
          wsSection('9 · Built-in Implicit Animation Widgets', [
            wsCompare('AnimatedContainer',
                'Animates decoration, padding, alignment, constraints'),
            wsCompare('AnimatedOpacity',
                'Animates opacity (single double tween)'),
            wsCompare('AnimatedPadding',
                'Animates padding (EdgeInsetsGeometryTween)'),
            wsCompare('AnimatedDefaultTextStyle',
                'Animates text style properties'),
            wsCompare('AnimatedPhysicalModel',
                'Animates shape, elevation, color, shadowColor'),
            wsCompare('AnimatedPositioned',
                'Animates left/top/right/bottom/width/height in a Stack'),
            wsCompare('AnimatedAlign',
                'Animates alignment within parent'),
            wsCompare('AnimatedCrossFade',
                'Cross-fades between two children'),
          ]),

          // ── 10. didUpdateTweens hook ──
          wsSection('10 · The didUpdateTweens Hook', [
            wsBullet(
                'didUpdateTweens() is called right after forEachTween() '
                'completes, both in initState and didUpdateWidget.'),
            wsBullet(
                'Override it to perform additional setup that depends on '
                'the newly built/updated tweens.'),
            wsCodeBlock(
                '// didUpdateTweens usage:\n'
                '@override\n'
                'void didUpdateTweens() {\n'
                '  // Tweens are now up to date.\n'
                '  // Use this to recompute derived values,\n'
                '  // create composite animations, etc.\n'
                '}\n'
                '\n'
                '// Call sequence:\n'
                '// forEachTween(visitor)  → tweens created/updated\n'
                '// didUpdateTweens()      → post-update hook'),
          ]),

          // ── 11. onEnd callback ──
          wsSection('11 · The onEnd Callback', [
            wsBullet(
                'ImplicitlyAnimatedWidget has an optional onEnd callback '
                'that fires when the animation reaches completed status.'),
            wsCodeBlock(
                '// onEnd registration:\n'
                'AnimatedContainer(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  color: isActive ? Colors.green : Colors.grey,\n'
                '  onEnd: () {\n'
                '    // Animation finished!\n'
                '    // Safe to start next animation or update state.\n'
                '  },\n'
                ')'),
            wsDivider(),
            wsBullet(
                'The state listens for AnimationStatus.completed on the '
                'controller and calls widget.onEnd when triggered.'),
            wsBullet(
                'onEnd is NOT called for AnimationStatus.dismissed — '
                'only completed (the forward direction end).'),
          ]),

          // ── 12. creating a custom implicit animation ──
          wsSection('12 · Custom Implicit Animation Widget', [
            wsCodeBlock(
                '// Step 1: Define the widget\n'
                'class AnimatedColor extends ImplicitlyAnimatedWidget {\n'
                '  final Color color;\n'
                '  const AnimatedColor({\n'
                '    required this.color,\n'
                '    required super.duration,\n'
                '    super.curve,\n'
                '    super.onEnd,\n'
                '    super.key,\n'
                '  });\n'
                '\n'
                '  @override\n'
                '  AnimatedWidgetBaseState<AnimatedColor> createState()\n'
                '      => _AnimatedColorState();\n'
                '}\n'
                '\n'
                '// Step 2: Define the state\n'
                'class _AnimatedColorState\n'
                '    extends AnimatedWidgetBaseState<AnimatedColor> {\n'
                '  ColorTween? _colorTween;\n'
                '\n'
                '  @override\n'
                '  void forEachTween(TweenVisitor<dynamic> visitor) {\n'
                '    _colorTween = visitor(\n'
                '      _colorTween,\n'
                '      widget.color,\n'
                '      (v) => ColorTween(begin: v as Color?),\n'
                '    ) as ColorTween?;\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return Container(\n'
                '      color: _colorTween?.evaluate(animation),\n'
                '    );\n'
                '  }\n'
                '}'),
          ]),

          // ── 13. animation evaluation in build ──
          wsSection('13 · Evaluating Tweens in build()', [
            wsBullet(
                'Tweens are evaluated at the current animation value '
                'using tween.evaluate(animation).'),
            wsBullet(
                'The animation getter returns the CurvedAnimation '
                '(not the raw controller), so curves are applied.'),
            wsCodeBlock(
                '// Evaluation flow:\n'
                '//\n'
                '// controller.value: 0.0 → 1.0 (linear)\n'
                '//     ↓\n'
                '// CurvedAnimation: applies curve transform\n'
                '//     ↓\n'
                '// tween.evaluate(curvedAnimation):\n'
                '//   = tween.begin + (tween.end - tween.begin) * t\n'
                '//     ↓\n'
                '// Interpolated value used in build()'),
            wsDivider(),
            wsBullet(
                'If the tween is null (property was not animated), '
                'evaluate returns null — always null-check.'),
          ]),

          // ── 14. duration and curve changes ──
          wsSection('14 · Handling Duration & Curve Changes', [
            wsBullet(
                'When widget.duration changes, the controller duration is '
                'updated. Already running animations continue with the '
                'new duration.'),
            wsBullet(
                'When widget.curve changes, the CurvedAnimation is '
                'rebuilt, which immediately affects interpolation.'),
            wsCodeBlock(
                '// In didUpdateWidget:\n'
                'if (widget.duration != oldWidget.duration) {\n'
                '  controller.duration = widget.duration;\n'
                '}\n'
                'if (widget.curve != oldWidget.curve) {\n'
                '  _animation = CurvedAnimation(\n'
                '    parent: controller,\n'
                '    curve: widget.curve,\n'
                '  );\n'
                '}'),
          ]),

          // ── 15. dispose sequence ──
          wsSection('15 · Dispose & Cleanup', [
            wsBullet(
                'dispose() releases the CurvedAnimation and the '
                'AnimationController, freeing the ticker.'),
            wsCodeBlock(
                '// Dispose sequence:\n'
                '@override\n'
                'void dispose() {\n'
                '  _animation.dispose();   // CurvedAnimation\n'
                '  // controller disposed by\n'
                '  // SingleTickerProviderStateMixin\n'
                '  super.dispose();\n'
                '}'),
            wsDivider(),
            wsBullet(
                'The SingleTickerProviderStateMixin handles controller '
                'disposal and ticker cleanup automatically.'),
          ]),

          // ── 16. quick reference ──
          wsSection('16 · Quick API Reference', [
            wsKeyValue('Class',
                'ImplicitlyAnimatedWidgetState<T>'),
            wsKeyValue('Key abstract', 'forEachTween(TweenVisitor)'),
            wsKeyValue('Key hook', 'didUpdateTweens()'),
            wsKeyValue('controller', 'AnimationController (protected)'),
            wsKeyValue('animation', 'CurvedAnimation (getter)'),
            wsKeyValue('Owned by', 'ImplicitlyAnimatedWidget subclass'),
            wsDivider(),
            wsCodeBlock(
                '// Summary of responsibilities:\n'
                '// 1. Create & manage AnimationController\n'
                '// 2. Build CurvedAnimation from widget.curve\n'
                '// 3. Call forEachTween to init/update Tweens\n'
                '// 4. Start controller.forward on property change\n'
                '// 5. Fire widget.onEnd on completion\n'
                '// 6. Dispose animation resources'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: wsForest.withValues(alpha: 0.06),
            child: const Text(
              'ImplicitlyAnimatedWidgetState · Forest Green Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: wsMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
