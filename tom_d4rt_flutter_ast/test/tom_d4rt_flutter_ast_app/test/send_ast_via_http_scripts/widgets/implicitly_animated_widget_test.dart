// ignore_for_file: avoid_print
// ImplicitlyAnimatedWidget – comprehensive deep demo
// Amber / Honey palette – the abstract StatefulWidget base class that
// gives any property-change the ability to auto-animate with a simple
// duration + curve configuration.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color awAmber = Color(0xFFFF8F00);
  const Color awHoney = Color(0xFFFFF8E1);
  const Color awOnAmber = Color(0xFFFFFFFF);
  const Color awDark = Color(0xFFC56000);
  const Color awLightHoney = Color(0xFFFFFCF0);
  const Color awTextDark = Color(0xFF3E2723);
  const Color awAccent = Color(0xFFFFB300);
  const Color awMuted = Color(0xFFFFE082);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget awHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [awAmber, awDark],
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
                  color: awOnAmber)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: awOnAmber.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget awSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: awLightHoney,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: awAmber.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: awAmber.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: awDark)),
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

  Widget awBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: awAmber, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: awTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget awCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF3E2723),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: awHoney,
              height: 1.5)),
    );
  }

  Widget awKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: awDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: awTextDark)),
          ),
        ],
      ),
    );
  }

  Widget awHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: awAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: awAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: awDark,
              height: 1.4)),
    );
  }

  Widget awDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: awMuted.withValues(alpha: 0.5), height: 1),
    );
  }

  Widget awCompare(String label, String desc) {
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
              color: awAmber,
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
                          color: awDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: awTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget awCurveRow(String name, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(name,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    color: color)),
          ),
          Expanded(
            child: Text(description,
                style: const TextStyle(fontSize: 10, color: awTextDark)),
          ),
        ],
      ),
    );
  }

  Widget awInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: awAmber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: awDark)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: awDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: awTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: awHoney,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          awHeader(
            'ImplicitlyAnimatedWidget',
            'Abstract StatefulWidget base class — just set a property and '
                'it animates to the new value with the given duration and curve',
          ),

          // ── 1. class identity ──
          awSection('1 · Class Identity', [
            awKeyValue('Class', 'ImplicitlyAnimatedWidget'),
            awKeyValue('Extends', 'StatefulWidget'),
            awKeyValue('Abstract', 'Yes — cannot instantiate directly'),
            awKeyValue('Library', 'package:flutter/widgets.dart'),
            awDivider(),
            awBullet(
                'ImplicitlyAnimatedWidget is the parent of every "Animated*" '
                'widget that reacts to property changes by running an '
                'animation between old and new values.'),
            awBullet(
                'It stores the three universal animation parameters: '
                'duration (required), curve (defaults to linear), and '
                'onEnd (optional callback).'),
          ]),

          // ── 2. constructor parameters ──
          awSection('2 · Constructor Parameters', [
            awKeyValue('duration', 'Duration (required)'),
            awKeyValue('curve', 'Curve (default: Curves.linear)'),
            awKeyValue('onEnd', 'VoidCallback? (optional)'),
            awDivider(),
            awCodeBlock(
                '// Constructor signature:\n'
                'const ImplicitlyAnimatedWidget({\n'
                '  super.key,\n'
                '  this.curve = Curves.linear,\n'
                '  required this.duration,\n'
                '  this.onEnd,\n'
                '});\n'
                '\n'
                '// Example with AnimatedContainer:\n'
                'AnimatedContainer(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  curve: Curves.easeInOut,\n'
                '  width: isExpanded ? 200 : 100,\n'
                '  color: isActive ? Colors.amber : Colors.grey,\n'
                '  onEnd: () => print("done"),\n'
                ')'),
            awHighlight(
                'The duration tells the widget how long the transition '
                'should take. The curve shapes the speed profile. onEnd '
                'fires once when the animation reaches completion.'),
          ]),

          // ── 3. complete subclass catalog ──
          awSection('3 · Built-in Subclass Catalog', [
            awCompare('AnimatedContainer',
                'Size, padding, margin, alignment, decoration, color, '
                'constraints — the Swiss Army knife'),
            awCompare('AnimatedOpacity',
                'Single opacity value (0.0–1.0)'),
            awCompare('AnimatedPadding',
                'EdgeInsetsGeometry padding transition'),
            awCompare('AnimatedAlign',
                'Alignment transition within parent'),
            awCompare('AnimatedPositioned',
                'Left/top/right/bottom/width/height in a Stack'),
            awCompare('AnimatedDefaultTextStyle',
                'TextStyle for descendant Text widgets'),
            awCompare('AnimatedPhysicalModel',
                'Shape, elevation, color, shadowColor'),
            awCompare('AnimatedTheme',
                'Full ThemeData transition'),
            awCompare('AnimatedCrossFade',
                'Fade between two child widgets'),
            awCompare('AnimatedSwitcher',
                'Animated child replacement (key-based)'),
            awCompare('AnimatedSize',
                'Smoothly resizes to fit child changes'),
          ]),

          // ── 4. how it works ──
          awSection('4 · How Implicit Animation Works', [
            awInfoRow('1', 'Rebuild:', 'Parent calls setState with new props'),
            awInfoRow('2', 'didUpdate:', 'Framework calls didUpdateWidget'),
            awInfoRow('3', 'Tween:', 'State updates begin/end via forEachTween'),
            awInfoRow('4', 'Forward:', 'controller.forward(from: 0.0) starts'),
            awInfoRow('5', 'Tick:', 'Each frame evaluates tweens at t'),
            awInfoRow('6', 'Build:', 'Interpolated values used in build()'),
            awInfoRow('7', 'Done:', 'onEnd callback fires at completion'),
            awDivider(),
            awCodeBlock(
                '// The magic: no AnimationController in user code!\n'
                '//\n'
                '// Before (explicit animation):\n'
                '// final controller = AnimationController(...);\n'
                '// final animation = ColorTween(...).animate(controller);\n'
                '// controller.forward();\n'
                '// AnimatedBuilder(animation: animation, ...)\n'
                '//\n'
                '// After (implicit animation):\n'
                '// AnimatedContainer(\n'
                '//   duration: Duration(ms: 300),\n'
                '//   color: isActive ? Colors.blue : Colors.grey,\n'
                '// )\n'
                '// Just change the property — the widget does the rest.'),
          ]),

          // ── 5. duration patterns ──
          awSection('5 · Duration Best Practices', [
            awCurveRow('50-100ms', 'Micro-interactions: toggles, highlights',
                const Color(0xFF1B5E20)),
            awCurveRow('150-300ms', 'Standard: layout changes, color shifts',
                const Color(0xFF0277BD)),
            awCurveRow('300-500ms', 'Emphasis: reveals, expansions',
                const Color(0xFFFF8F00)),
            awCurveRow('500ms+', 'Dramatic: page transitions, hero anims',
                const Color(0xFF880E4F)),
            awDivider(),
            awBullet('Material Design recommends 200-300ms for most '
                'UI transitions. Shorter for small changes, longer for '
                'large layout shifts.'),
            awBullet('All built-in Animated widgets accept Duration. '
                'The state creates an AnimationController with this Duration.'),
          ]),

          // ── 6. curve gallery ──
          awSection('6 · Curve Gallery', [
            awCurveRow('linear', 'Constant speed — no easing',
                const Color(0xFF616161)),
            awCurveRow('easeIn', 'Starts slow, accelerates to end',
                const Color(0xFF1B5E20)),
            awCurveRow('easeOut', 'Starts fast, decelerates to end',
                const Color(0xFF0277BD)),
            awCurveRow('easeInOut', 'Slow start/end, fast middle',
                const Color(0xFFFF8F00)),
            awCurveRow('fastOutSlowIn',
                'Material standard — quick launch, soft landing',
                const Color(0xFF880E4F)),
            awCurveRow('bounceOut', 'Bounces at the end',
                const Color(0xFF6A1B9A)),
            awCurveRow('elasticOut', 'Springs past target, settles back',
                const Color(0xFFD32F2F)),
            awDivider(),
            awCodeBlock(
                '// Curve affects interpolation shape:\n'
                '// t = 0.0 → begin value\n'
                '// t = 1.0 → end value\n'
                '//\n'
                '// linear:    t_out = t\n'
                '// easeInOut: t_out = smooth S-curve\n'
                '// bounceOut: t_out = 1.0 + bounces near end\n'
                '//\n'
                '// AnimatedContainer(\n'
                '//   curve: Curves.fastOutSlowIn,\n'
                '//   duration: Duration(milliseconds: 300),\n'
                '//   ...properties...\n'
                '// )'),
          ]),

          // ── 7. onEnd callback patterns ──
          awSection('7 · onEnd Callback Patterns', [
            awBullet(
                'Chaining: Start the next animation in onEnd to create '
                'sequential animation effects.'),
            awBullet(
                'State cleanup: Reset flags or trigger side effects '
                'when the animation finishes.'),
            awBullet(
                'Logging: Track animation completion for analytics.'),
            awCodeBlock(
                '// Chaining example:\n'
                'AnimatedContainer(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  width: phase == 1 ? 200 : 100,\n'
                '  onEnd: () {\n'
                '    setState(() { phase = 2; });\n'
                '    // Triggers another AnimatedContainer rebuild\n'
                '    // with a new target value → second animation\n'
                '  },\n'
                ')\n'
                '\n'
                '// Sequence: phase 1 animates width 100→200,\n'
                '//           onEnd sets phase 2,\n'
                '//           phase 2 animates color or height'),
            awDivider(),
            awHighlight(
                'onEnd fires only when animation reaches '
                'AnimationStatus.completed (forward direction). '
                'If the widget rebuilds mid-animation with a '
                'new target, the animation restarts and onEnd fires '
                'only for the final animation.'),
          ]),

          // ── 8. implicit vs explicit animation ──
          awSection('8 · Implicit vs Explicit Animation', [
            awCompare('Implicit (ImplicitlyAnimatedWidget)',
                'Set-and-forget: change a property, animation happens '
                'automatically. No controllers needed.'),
            awCompare('Explicit (AnimatedWidget / AnimatedBuilder)',
                'Full control: you create AnimationController, manage '
                'lifecycle, can reverse, repeat, chain.'),
            awDivider(),
            awCodeBlock(
                '// Decision guide:\n'
                '//\n'
                '// Use IMPLICIT when:\n'
                '//   ✓ Single property change triggers animation\n'
                '//   ✓ Fire-and-forget — no need to reverse/repeat\n'
                '//   ✓ Simple transitions (color, size, position)\n'
                '//\n'
                '// Use EXPLICIT when:\n'
                '//   ✓ Need to reverse, repeat, or loop\n'
                '//   ✓ Multiple coordinated animations\n'
                '//   ✓ Animation driven by scroll/gesture\n'
                '//   ✓ Need precise frame-level control'),
          ]),

          // ── 9. createState pattern ──
          awSection('9 · The createState Contract', [
            awBullet(
                'ImplicitlyAnimatedWidget.createState() must return an '
                'ImplicitlyAnimatedWidgetState or AnimatedWidgetBaseState.'),
            awCodeBlock(
                '// Widget creates its state:\n'
                'class AnimatedContainer\n'
                '    extends ImplicitlyAnimatedWidget {\n'
                '  @override\n'
                '  AnimatedWidgetBaseState<AnimatedContainer>\n'
                '      createState() => _AnimatedContainerState();\n'
                '}\n'
                '\n'
                '// State does the heavy lifting:\n'
                'class _AnimatedContainerState\n'
                '    extends AnimatedWidgetBaseState<AnimatedContainer> {\n'
                '  // Tween fields, forEachTween, build\n'
                '}'),
            awDivider(),
            awBullet(
                'The widget is thin (just stores duration, curve, onEnd, '
                'and the target property values). All animation logic '
                'lives in the state class.'),
          ]),

          // ── 10. tween types used ──
          awSection('10 · Common Tween Types', [
            awCompare('Tween<double>', 'Basic numeric interpolation'),
            awCompare('ColorTween', 'Color.lerp between two Colors'),
            awCompare('DecorationTween', 'Decoration.lerp (BoxDecoration)'),
            awCompare('EdgeInsetsGeometryTween',
                'Padding/margin interpolation'),
            awCompare('AlignmentGeometryTween',
                'Alignment interpolation (center → topLeft)'),
            awCompare('BoxConstraintsTween',
                'Min/max width/height interpolation'),
            awCompare('TextStyleTween',
                'Font size, weight, color interpolation'),
            awCompare('BorderRadiusTween',
                'Corner radius interpolation'),
            awDivider(),
            awBullet(
                'Each tween type knows how to lerp between its begin '
                'and end values. The base Tween<double> uses simple '
                'linear interpolation; specialized tweens use the '
                'corresponding lerp static methods.'),
          ]),

          // ── 11. animation interruption ──
          awSection('11 · Mid-Animation Rebuilds', [
            awBullet(
                'If the widget rebuilds while an animation is in progress, '
                'the state captures the current interpolated value as the '
                'new begin and sets the new target as end.'),
            awCodeBlock(
                '// Mid-animation scenario:\n'
                '//\n'
                '// t=0.0: color animating from red → blue\n'
                '// t=0.5: rebuild with color = green\n'
                '//        → tween.begin = purple (interpolated at 0.5)\n'
                '//        → tween.end = green\n'
                '//        → controller.forward(from: 0.0)\n'
                '//\n'
                '// Result: smooth transition from current purple to green\n'
                '// No jump, no jank — seamless re-targeting'),
            awDivider(),
            awHighlight(
                'This is one of the key strengths of implicit animations: '
                'rapid property changes produce smooth, continuous motion '
                'because the animation always starts from the current '
                'visual state, not from a fixed begin value.'),
          ]),

          // ── 12. debugFillProperties ──
          awSection('12 · Debug & Diagnostics', [
            awBullet(
                'ImplicitlyAnimatedWidget overrides debugFillProperties '
                'to expose duration and curve in the widget inspector.'),
            awCodeBlock(
                '// Debug output for AnimatedContainer:\n'
                '// AnimatedContainer(\n'
                '//   duration: 0:00:00.300000\n'
                '//   curve: Cubic(0.4, 0.0, 0.2, 1.0)\n'
                '//   width: 200.0\n'
                '//   height: 100.0\n'
                '//   color: Color(0xffffc107)\n'
                '// )\n'
                '\n'
                '// debugFillProperties adds:\n'
                '@override\n'
                'void debugFillProperties(\n'
                '    DiagnosticPropertiesBuilder properties) {\n'
                '  super.debugFillProperties(properties);\n'
                '  properties.add(\n'
                '    IntProperty("duration", duration.inMilliseconds,\n'
                '        unit: "ms"));\n'
                '}'),
          ]),

          // ── 13. performance considerations ──
          awSection('13 · Performance Considerations', [
            awBullet(
                'Each implicit animation widget creates one '
                'AnimationController + one CurvedAnimation. For simple '
                'UIs this is negligible.'),
            awBullet(
                'AnimatedWidgetBaseState calls setState every frame '
                'during animation, triggering a rebuild. Keep the '
                'build() method lightweight.'),
            awBullet(
                'For lists with many animated items, consider using '
                'explicit animations with a shared controller to '
                'reduce object count.'),
            awDivider(),
            awHighlight(
                'Rule of thumb: use implicit animation widgets for '
                'up to ~20 simultaneously animating items. Beyond that, '
                'explicit animations with shared controllers or '
                'CustomPainter may be more efficient.'),
          ]),

          // ── 14. AnimatedSwitcher & AnimatedCrossFade ──
          awSection('14 · Special Subclasses', [
            awBullet(
                'AnimatedSwitcher: replaces one child with another using '
                'a configurable transition builder. Keyed by child.key.'),
            awBullet(
                'AnimatedCrossFade: fades between exactly two children '
                '(firstChild/secondChild) based on crossFadeState.'),
            awCodeBlock(
                '// AnimatedSwitcher:\n'
                'AnimatedSwitcher(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  child: Text("\$counter", key: ValueKey(counter)),\n'
                ')\n'
                '\n'
                '// AnimatedCrossFade:\n'
                'AnimatedCrossFade(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  crossFadeState: isFirst\n'
                '      ? CrossFadeState.showFirst\n'
                '      : CrossFadeState.showSecond,\n'
                '  firstChild: Text("First"),\n'
                '  secondChild: Text("Second"),\n'
                ')'),
          ]),

          // ── 15. type hierarchy diagram ──
          awSection('15 · Type Hierarchy', [
            awCodeBlock(
                '// Widget\n'
                '//   └─ StatefulWidget\n'
                '//       └─ ImplicitlyAnimatedWidget ← this class\n'
                '//           ├─ AnimatedContainer\n'
                '//           ├─ AnimatedOpacity\n'
                '//           ├─ AnimatedPadding\n'
                '//           ├─ AnimatedAlign\n'
                '//           ├─ AnimatedPositioned\n'
                '//           ├─ AnimatedDefaultTextStyle\n'
                '//           ├─ AnimatedPhysicalModel\n'
                '//           ├─ AnimatedTheme\n'
                '//           └─ ... more\n'
                '//\n'
                '// State:\n'
                '//   ImplicitlyAnimatedWidgetState (no per-frame rebuild)\n'
                '//     └─ AnimatedWidgetBaseState (auto setState per frame)'),
          ]),

          // ── 16. quick reference ──
          awSection('16 · Quick API Reference', [
            awKeyValue('Class', 'ImplicitlyAnimatedWidget (abstract)'),
            awKeyValue('Extends', 'StatefulWidget'),
            awKeyValue('duration', 'Duration (required)'),
            awKeyValue('curve', 'Curve (default: Curves.linear)'),
            awKeyValue('onEnd', 'VoidCallback? (optional)'),
            awKeyValue('createState', 'ImplicitlyAnimatedWidgetState'),
            awDivider(),
            awCodeBlock(
                '// Summary:\n'
                '// ImplicitlyAnimatedWidget is the base for all\n'
                '// "just change a property" animation widgets.\n'
                '//\n'
                '// It stores: duration, curve, onEnd\n'
                '// Its state: manages controller, tweens, lifecycle\n'
                '//\n'
                '// Usage: extend it, declare animated properties,\n'
                '// implement forEachTween in the state class.\n'
                '// Or just use AnimatedContainer & friends.'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: awAmber.withValues(alpha: 0.06),
            child: const Text(
              'ImplicitlyAnimatedWidget · Amber Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: awMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
