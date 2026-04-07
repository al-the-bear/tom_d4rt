// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: TweenAnimationBuilder — implicit animation builder using Tweens
// without requiring an AnimationController. Accent: Colors.deepOrange
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final Color accent = Colors.deepOrange;

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('TweenAnimationBuilder Deep Demo'),
        backgroundColor: accent,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'API'),
            Tab(text: 'Tween Types'),
            Tab(text: 'Curves'),
            Tab(text: 'Builder'),
            Tab(text: 'Lifecycle'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // ── TAB 1: Concept ──
          _buildConceptTab(accent),

          // ── TAB 2: API ──
          _buildApiTab(accent),

          // ── TAB 3: Tween Types ──
          _buildTweenTypesTab(accent),

          // ── TAB 4: Curves ──
          _buildCurvesTab(accent),

          // ── TAB 5: Builder ──
          _buildBuilderTab(accent),

          // ── TAB 6: Lifecycle ──
          _buildLifecycleTab(accent),

          // ── TAB 7: Patterns ──
          _buildPatternsTab(accent),

          // ── TAB 8: Summary ──
          _buildSummaryTab(accent),
        ],
      ),
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 1 — Concept
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildConceptTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.animation, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'TweenAnimationBuilder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Implicit animations without an AnimationController. '
                'Define a target value, and Flutter automatically '
                'animates the transition for you.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Core idea section
        Text(
          'Core Idea',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Text(
            'TweenAnimationBuilder is a general-purpose implicit animation '
            'widget. Unlike explicit animations that require an AnimationController, '
            'a TickerProvider, and manual lifecycle management, '
            'TweenAnimationBuilder handles all of that internally. You simply '
            'provide a Tween, a duration, and a builder function. When the '
            'target value changes, the widget automatically animates from the '
            'current value to the new target.',
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
        ),
        const SizedBox(height: 20),

        // Comparison diagram
        Text(
          'Implicit vs Explicit Animation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: accent, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Implicit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: accent,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '\u2022 No AnimationController\n'
                      '\u2022 No TickerProviderStateMixin\n'
                      '\u2022 No dispose() management\n'
                      '\u2022 Set target, it animates\n'
                      '\u2022 Simpler code',
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tune, color: Colors.grey.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Explicit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '\u2022 Manual AnimationController\n'
                      '\u2022 Requires TickerProvider\n'
                      '\u2022 Must call dispose()\n'
                      '\u2022 Full control over playback\n'
                      '\u2022 More flexible',
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // When to use
        Text(
          'When to Use TweenAnimationBuilder',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        _buildReasonCard(
          Icons.swap_horiz,
          'Value Transitions',
          'Animate between two values (opacity, size, color, position) '
          'driven by state changes.',
          accent,
        ),
        const SizedBox(height: 8),
        _buildReasonCard(
          Icons.widgets,
          'Custom Implicit Animations',
          'Build animations that aren\u0027t covered by built-in '
          'AnimatedFoo widgets like AnimatedOpacity.',
          accent,
        ),
        const SizedBox(height: 8),
        _buildReasonCard(
          Icons.code_off,
          'Reducing Boilerplate',
          'Avoid the ceremony of AnimationController, vsync, '
          'forward(), reverse(), and dispose().',
          accent,
        ),
        const SizedBox(height: 8),
        _buildReasonCard(
          Icons.refresh,
          'One-Shot Entry Animations',
          'Animate a widget into view on first build by setting '
          'an initial value different from the target.',
          accent,
        ),
        const SizedBox(height: 24),

        // How it works internally
        Text(
          'Internal Mechanics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '1. On first build, creates an internal AnimationController',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
              Text(
                '2. Evaluates the Tween to produce initial value',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
              Text(
                '3. Calls builder(context, value, child) each frame',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
              Text(
                '4. When tween.end changes, animates from current to new end',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
              Text(
                '5. Calls onEnd callback when animation completes',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
              Text(
                '6. Disposes the internal controller automatically',
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 2 — API
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildApiTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Constructor Parameters',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 16),

        _buildApiParamCard(
          'tween',
          'Tween<T>',
          'Defines the range of values to interpolate between. '
          'The begin value is the starting point and end is the target. '
          'When end changes, a new animation runs from the current '
          'interpolated value to the new end.',
          accent,
          isRequired: true,
        ),
        const SizedBox(height: 12),
        _buildApiParamCard(
          'duration',
          'Duration',
          'How long the animation takes to complete from start to finish. '
          'Typical values range from 200ms for micro-interactions to '
          '1000ms+ for dramatic transitions.',
          accent,
          isRequired: true,
        ),
        const SizedBox(height: 12),
        _buildApiParamCard(
          'builder',
          'Widget Function(BuildContext, T, Widget?)',
          'Called every frame with the current interpolated value. '
          'Receives context, the animated value of type T, and an '
          'optional pre-built child widget for optimization.',
          accent,
          isRequired: true,
        ),
        const SizedBox(height: 12),
        _buildApiParamCard(
          'curve',
          'Curve',
          'Defines the easing function applied to the animation timeline. '
          'Defaults to Curves.linear. Common choices include easeIn, '
          'easeOut, easeInOut, and bounceOut.',
          accent,
        ),
        const SizedBox(height: 12),
        _buildApiParamCard(
          'child',
          'Widget?',
          'An optional pre-built widget passed through to the builder. '
          'Use this for parts of the subtree that don\u0027t depend on '
          'the animated value, improving performance.',
          accent,
        ),
        const SizedBox(height: 12),
        _buildApiParamCard(
          'onEnd',
          'VoidCallback?',
          'Called when the animation finishes. Useful for chaining '
          'animations, triggering side effects, or updating state '
          'after the transition completes.',
          accent,
        ),
        const SizedBox(height: 24),

        // Type parameter explanation
        Text(
          'The Type Parameter <T>',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TweenAnimationBuilder<T> is generic. The type T must '
                'match the Tween\u0027s type and the builder\u0027s value type.',
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '// T = double\n'
                  'TweenAnimationBuilder<double>(\n'
                  '  tween: Tween<double>(begin: 0, end: 1),\n'
                  '  duration: Duration(milliseconds: 500),\n'
                  '  builder: (context, double value, child) {\n'
                  '    return Opacity(opacity: value, child: child);\n'
                  '  },\n'
                  '  child: Text(\u0027Hello\u0027),\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Inheritance chain
        Text(
          'Widget Hierarchy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHierarchyRow('Widget', 0, Colors.grey),
              _buildHierarchyRow('StatefulWidget', 1, Colors.grey),
              _buildHierarchyRow('ImplicitlyAnimatedWidget', 2, Colors.blueGrey),
              _buildHierarchyRow('TweenAnimationBuilder<T>', 3, accent),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'TweenAnimationBuilder extends ImplicitlyAnimatedWidget, '
                  'which is the base class for all implicit animation widgets '
                  'in Flutter (AnimatedContainer, AnimatedOpacity, etc.).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 3 — Tween Types
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildTweenTypesTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Tween Types',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter provides many Tween subclasses for different data types. '
          'Each knows how to interpolate between its begin and end values.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 20),

        // Tween<double>
        _buildTweenTypeCard(
          'Tween<double>',
          'Linear interpolation between two numbers.',
          'Tween<double>(begin: 0.0, end: 1.0)',
          'Opacity, scale, rotation angle, width/height, padding',
          Icons.linear_scale,
          accent,
        ),
        const SizedBox(height: 12),

        // ColorTween
        _buildTweenTypeCard(
          'ColorTween',
          'Interpolates between two colors through the color space.',
          'ColorTween(\n  begin: Colors.red,\n  end: Colors.blue,\n)',
          'Background transitions, theme changes, highlight effects',
          Icons.palette,
          Colors.purple,
        ),
        const SizedBox(height: 12),

        // IntTween
        _buildTweenTypeCard(
          'IntTween',
          'Rounds interpolated values to the nearest integer.',
          'IntTween(begin: 0, end: 100)',
          'Counters, step indicators, discrete progress values',
          Icons.looks_one,
          Colors.green,
        ),
        const SizedBox(height: 12),

        // AlignmentTween
        _buildTweenTypeCard(
          'AlignmentTween',
          'Smoothly transitions between two Alignment positions.',
          'AlignmentTween(\n  begin: Alignment.topLeft,\n  end: Alignment.bottomRight,\n)',
          'Moving widgets, slide-in effects, positioning transitions',
          Icons.open_with,
          Colors.blue,
        ),
        const SizedBox(height: 12),

        // BorderRadiusTween
        _buildTweenTypeCard(
          'BorderRadiusTween',
          'Transitions between different border radius values.',
          'BorderRadiusTween(\n  begin: BorderRadius.circular(0),\n  end: BorderRadius.circular(24),\n)',
          'Card morphing, avatar shape changes, button states',
          Icons.rounded_corner,
          Colors.teal,
        ),
        const SizedBox(height: 12),

        // DecorationTween
        _buildTweenTypeCard(
          'DecorationTween',
          'Interpolates BoxDecoration properties including color, '
          'border, shadow, and gradient.',
          'DecorationTween(\n  begin: BoxDecoration(color: Colors.white),\n  end: BoxDecoration(color: Colors.blue),\n)',
          'Card elevation, container styling, hover effects',
          Icons.format_paint,
          Colors.indigo,
        ),
        const SizedBox(height: 12),

        // EdgeInsetsTween
        _buildTweenTypeCard(
          'EdgeInsetsTween',
          'Smoothly transitions padding or margin values.',
          'EdgeInsetsTween(\n  begin: EdgeInsets.all(8),\n  end: EdgeInsets.all(24),\n)',
          'Expanding content areas, accordion effects, focus states',
          Icons.space_bar,
          Colors.brown,
        ),
        const SizedBox(height: 12),

        // SizeTween
        _buildTweenTypeCard(
          'SizeTween',
          'Interpolates between two Size objects.',
          'SizeTween(\n  begin: Size(100, 100),\n  end: Size(200, 200),\n)',
          'Widget resizing, expanding panels, zoom effects',
          Icons.aspect_ratio,
          Colors.red,
        ),
        const SizedBox(height: 24),

        // Custom Tweens section
        Text(
          'Creating Custom Tweens',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Extend Tween<T> and override the lerp method to '
                'create tweens for custom data types:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'class TemperatureTween extends Tween<double> {\n'
                  '  TemperatureTween({double? begin, double? end})\n'
                  '    : super(begin: begin, end: end);\n'
                  '\n'
                  '  @override\n'
                  '  double lerp(double t) {\n'
                  '    // Custom interpolation logic\n'
                  '    return begin! + (end! - begin!) * t;\n'
                  '  }\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Tween chaining info
        Text(
          'Chaining with .chain()',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Use .chain() to combine a Tween with a CurveTween, '
                'applying easing inline:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Tween<double>(begin: 0, end: 300)\n'
                  '  .chain(CurveTween(curve: Curves.elasticOut))',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Note: While .chain() is commonly used with explicit '
                'animations, TweenAnimationBuilder applies curves via '
                'the curve parameter instead.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 4 — Curves
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildCurvesTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Curves',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Curves define how the animation progresses over time. '
          'A curve maps a linear 0.0\u20131.0 input to a shaped output.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 20),

        // Visual curve representation table
        _buildCurveRow('linear', '\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500', 'Constant speed', accent),
        const SizedBox(height: 8),
        _buildCurveRow('easeIn', '\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2571\u2571\u2571\u2502\u2502', 'Starts slow, ends fast', Colors.blue),
        const SizedBox(height: 8),
        _buildCurveRow('easeOut', '\u2502\u2502\u2572\u2572\u2572\u2500\u2500\u2500\u2500\u2500\u2500\u2500', 'Starts fast, ends slow', Colors.green),
        const SizedBox(height: 8),
        _buildCurveRow('easeInOut', '\u2500\u2500\u2500\u2571\u2571\u2572\u2572\u2500\u2500\u2500\u2500\u2500', 'Slow start and end', Colors.purple),
        const SizedBox(height: 8),
        _buildCurveRow('bounceOut', '\u2502\u25cb\u2502\u25cb\u2502\u2500\u25cb\u2500\u2500\u2500\u2500\u2500', 'Bounces at the end', Colors.orange),
        const SizedBox(height: 8),
        _buildCurveRow('elasticOut', '\u2502\u2500\u223c\u223c\u2500\u223c\u2500\u2500\u2500\u2500\u2500\u2500', 'Spring-like overshoot', Colors.red),
        const SizedBox(height: 8),
        _buildCurveRow('decelerate', '\u2502\u2502\u2572\u2572\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500', 'Quick deceleration', Colors.teal),
        const SizedBox(height: 8),
        _buildCurveRow('fastOutSlowIn', '\u2502\u2502\u2572\u2572\u2572\u2500\u2500\u2500\u2500\u2500\u2500\u2500', 'Material Design default', Colors.indigo),
        const SizedBox(height: 24),

        // Usage with TweenAnimationBuilder
        Text(
          'Applying Curves',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'TweenAnimationBuilder<double>(\n'
            '  tween: Tween(begin: 0, end: 1),\n'
            '  duration: Duration(milliseconds: 600),\n'
            '  curve: Curves.easeOutCubic,  // <-- here\n'
            '  builder: (context, value, child) {\n'
            '    return Transform.scale(\n'
            '      scale: value,\n'
            '      child: child,\n'
            '    );\n'
            '  },\n'
            '  child: FlutterLogo(size: 100),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Cubic curves
        Text(
          'Cubic Bezier Curves',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Most Flutter curves are defined as cubic Bezier curves '
                'with four control points:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '// Custom cubic curve\n'
                  'const Cubic(0.25, 0.1, 0.25, 1.0)\n'
                  '\n'
                  '// Equivalent to Curves.ease\n'
                  '// (a, b) = first control point\n'
                  '// (c, d) = second control point',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Interval curves
        Text(
          'Sub-Range with Interval',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Interval restricts a curve to a sub-range of the '
                'animation timeline:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '// Only animate during the first 60% of duration\n'
                  'curve: Interval(0.0, 0.6, curve: Curves.easeOut)\n'
                  '\n'
                  '// Animate during the last 40%\n'
                  'curve: Interval(0.6, 1.0, curve: Curves.easeIn)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Useful for staggering multiple TweenAnimationBuilders '
                'with the same duration but different timing windows.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Flipped curves
        Text(
          'Reversed & Flipped Curves',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurveFlipRow('Original', 'Curves.easeIn', accent),
              const Divider(),
              _buildCurveFlipRow('Flipped', 'Curves.easeIn.flipped', Colors.red),
              const Divider(),
              _buildCurveFlipRow('Built-in reverse', 'Curves.easeOut', Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade800, size: 20),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Curves.easeIn.flipped produces the same result as '
                  'Curves.easeOut. Flutter provides named constants '
                  'for the most common flipped curves.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 5 — Builder
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildBuilderTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Builder Function',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The builder callback is called every frame during the animation. '
          'It receives the current interpolated value and returns a widget.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 20),

        // Signature breakdown
        Text(
          'Signature',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Widget Function(\n'
            '  BuildContext context,  // Build context\n'
            '  T value,              // Current animated value\n'
            '  Widget? child,        // Pre-built static child\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Colors.greenAccent,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Three parameters explained
        _buildBuilderParamCard(
          'context',
          'Standard BuildContext from the widget tree. '
          'Can be used to access Theme, MediaQuery, or inherited widgets.',
          Icons.account_tree,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildBuilderParamCard(
          'value',
          'The interpolated value of type T at the current animation frame. '
          'Changes every frame from tween.begin towards tween.end.',
          Icons.timeline,
          accent,
        ),
        const SizedBox(height: 12),
        _buildBuilderParamCard(
          'child',
          'The optional widget passed via the child parameter of '
          'TweenAnimationBuilder. This is NOT rebuilt each frame \u2014 '
          'it\u0027s built once and reused for performance.',
          Icons.child_care,
          Colors.green,
        ),
        const SizedBox(height: 24),

        // Child optimization
        Text(
          'Child Optimization Pattern',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.close, color: Colors.red, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'Without child',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'builder: (ctx, val, _) {\n'
                        '  return Opacity(\n'
                        '    opacity: val,\n'
                        '    child: Column(\n'
                        '      children: [\n'
                        '        Image(...),\n'
                        '        Text(\u0027Title\u0027),\n'
                        '        Text(\u0027Body\u0027),\n'
                        '      ],\n'
                        '    ),\n'
                        '  );\n'
                        '}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.redAccent,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rebuilds Column + all children every frame',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'With child',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'child: Column(\n'
                        '  children: [\n'
                        '    Image(...),\n'
                        '    Text(\u0027Title\u0027),\n'
                        '    Text(\u0027Body\u0027),\n'
                        '  ],\n'
                        '),\n'
                        'builder: (ctx, val, ch) {\n'
                        '  return Opacity(\n'
                        '    opacity: val,\n'
                        '    child: ch,\n'
                        '  );\n'
                        '}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.greenAccent,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Column built once, only Opacity rebuilt',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Multiple transforms in one builder
        Text(
          'Combining Transforms in Builder',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '// Single value driving multiple properties\n'
            'TweenAnimationBuilder<double>(\n'
            '  tween: Tween(begin: 0, end: 1),\n'
            '  duration: Duration(milliseconds: 800),\n'
            '  builder: (context, t, child) {\n'
            '    return Transform.translate(\n'
            '      offset: Offset(0, 50 * (1 - t)),\n'
            '      child: Opacity(\n'
            '        opacity: t,\n'
            '        child: Transform.scale(\n'
            '          scale: 0.8 + 0.2 * t,\n'
            '          child: child,\n'
            '        ),\n'
            '      ),\n'
            '    );\n'
            '  },\n'
            '  child: Card(child: Text(\u0027Content\u0027)),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'A single animated double (0 \u2192 1) can drive opacity, '
            'scale, and translation simultaneously. This creates a '
            'polished entrance animation with minimal code.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 6 — Lifecycle
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildLifecycleTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Lifecycle',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Understanding when and how TweenAnimationBuilder '
          'triggers, updates, and completes its animations.',
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 20),

        // Timeline of events
        Text(
          'Animation Timeline',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        _buildTimelineEvent(
          '1',
          'Widget Created',
          'TweenAnimationBuilder is inserted into the widget tree. '
          'Internal AnimationController is created.',
          accent,
        ),
        _buildTimelineEvent(
          '2',
          'Initial Animation',
          'If tween.begin differs from tween.end, animation starts '
          'immediately from begin to end.',
          accent,
        ),
        _buildTimelineEvent(
          '3',
          'Builder Called Each Frame',
          'builder(context, currentValue, child) is invoked ~60 times '
          'per second during animation.',
          accent,
        ),
        _buildTimelineEvent(
          '4',
          'Animation Completes',
          'The onEnd callback fires when the value reaches tween.end. '
          'The widget remains displaying the final value.',
          accent,
        ),
        _buildTimelineEvent(
          '5',
          'Target Changes',
          'When parent rebuilds with a new tween.end, a new animation '
          'starts from the current value to the new end.',
          accent,
        ),
        _buildTimelineEvent(
          '6',
          'Widget Removed',
          'The internal AnimationController is disposed automatically. '
          'No manual cleanup needed.',
          accent,
        ),
        const SizedBox(height: 24),

        // onEnd callback
        Text(
          'The onEnd Callback',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'onEnd fires when the animation reaches tween.end:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'TweenAnimationBuilder<double>(\n'
                  '  tween: Tween(begin: 0, end: 1),\n'
                  '  duration: Duration(seconds: 1),\n'
                  '  onEnd: () {\n'
                  '    print(\u0027Animation finished!\u0027);\n'
                  '    // Navigate, update state, or start next animation\n'
                  '  },\n'
                  '  builder: (context, value, child) {\n'
                  '    return Opacity(opacity: value, child: child);\n'
                  '  },\n'
                  '  child: Text(\u0027Fade in complete\u0027),\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.greenAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Re-triggering behavior
        Text(
          'Re-Triggering Behavior',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRetriggerRow(
                'Same tween.end',
                'No animation \u2014 already at target',
                Icons.pause_circle_outline,
                Colors.grey,
              ),
              const Divider(),
              _buildRetriggerRow(
                'New tween.end',
                'Animates from current value to new end',
                Icons.play_circle_outline,
                Colors.green,
              ),
              const Divider(),
              _buildRetriggerRow(
                'Mid-animation change',
                'Smoothly redirects from current position',
                Icons.swap_horiz,
                Colors.blue,
              ),
              const Divider(),
              _buildRetriggerRow(
                'New tween.begin',
                'Only takes effect on next creation',
                Icons.info_outline,
                Colors.amber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Important: tween.begin caveat
        Text(
          'The tween.begin Caveat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.red.shade700, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Common Pitfall',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Changing tween.begin after the initial build does NOT '
                'restart the animation from the new begin value. The '
                'animation always starts from the CURRENT interpolated '
                'value to tween.end.',
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: 12),
              const Text(
                'To force an animation from a specific start value, '
                'use a Key to recreate the widget entirely:',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'TweenAnimationBuilder<double>(\n'
                  '  key: ValueKey(resetCounter),\n'
                  '  tween: Tween(begin: 0, end: targetValue),\n'
                  '  ...\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.orangeAccent,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Duration changes
        Text(
          'Changing Duration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Modifying the duration parameter during a rebuild applies '
            'the new duration to subsequent animations, not the current '
            'one. The in-flight animation continues with its original '
            'duration until completion or re-triggering.',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 7 — Patterns
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildPatternsTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Patterns',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 20),

        // Pattern 1: Fade-in on mount
        _buildPatternCard(
          'Fade-In on Mount',
          'Animate opacity from 0 to 1 when the widget first appears.',
          'TweenAnimationBuilder<double>(\n'
          '  tween: Tween(begin: 0.0, end: 1.0),\n'
          '  duration: Duration(milliseconds: 500),\n'
          '  builder: (context, opacity, child) {\n'
          '    return Opacity(\n'
          '      opacity: opacity,\n'
          '      child: child,\n'
          '    );\n'
          '  },\n'
          '  child: MyContentWidget(),\n'
          ')',
          Icons.visibility,
          accent,
        ),
        const SizedBox(height: 16),

        // Pattern 2: Slide + fade
        _buildPatternCard(
          'Slide + Fade Entrance',
          'Combine translation and opacity for a polished entry effect.',
          'TweenAnimationBuilder<double>(\n'
          '  tween: Tween(begin: 0.0, end: 1.0),\n'
          '  duration: Duration(milliseconds: 600),\n'
          '  curve: Curves.easeOutCubic,\n'
          '  builder: (context, t, child) {\n'
          '    return Transform.translate(\n'
          '      offset: Offset(0, 30 * (1 - t)),\n'
          '      child: Opacity(opacity: t, child: child),\n'
          '    );\n'
          '  },\n'
          '  child: Card(child: ListTile(...)),\n'
          ')',
          Icons.north_east,
          Colors.blue,
        ),
        const SizedBox(height: 16),

        // Pattern 3: Color transition
        _buildPatternCard(
          'Background Color Transition',
          'Smoothly transition a container\u0027s background color.',
          'TweenAnimationBuilder<Color?>(\n'
          '  tween: ColorTween(\n'
          '    begin: Colors.blue,\n'
          '    end: isActive ? Colors.green : Colors.grey,\n'
          '  ),\n'
          '  duration: Duration(milliseconds: 400),\n'
          '  builder: (context, color, child) {\n'
          '    return Container(\n'
          '      color: color,\n'
          '      child: child,\n'
          '    );\n'
          '  },\n'
          '  child: Text(\u0027Status\u0027),\n'
          ')',
          Icons.format_color_fill,
          Colors.green,
        ),
        const SizedBox(height: 16),

        // Pattern 4: Scale pulse
        _buildPatternCard(
          'Scale Pulse Effect',
          'Make a widget grow slightly then settle when state changes.',
          'TweenAnimationBuilder<double>(\n'
          '  key: ValueKey(notificationCount),\n'
          '  tween: Tween(begin: 1.2, end: 1.0),\n'
          '  duration: Duration(milliseconds: 300),\n'
          '  curve: Curves.elasticOut,\n'
          '  builder: (context, scale, child) {\n'
          '    return Transform.scale(\n'
          '      scale: scale,\n'
          '      child: child,\n'
          '    );\n'
          '  },\n'
          '  child: Badge(count: notificationCount),\n'
          ')',
          Icons.lens,
          Colors.purple,
        ),
        const SizedBox(height: 16),

        // Pattern 5: Progress indicator
        _buildPatternCard(
          'Animated Progress Bar',
          'Smoothly animate a progress bar when the value changes.',
          'TweenAnimationBuilder<double>(\n'
          '  tween: Tween(begin: 0, end: progress),\n'
          '  duration: Duration(milliseconds: 500),\n'
          '  curve: Curves.easeInOut,\n'
          '  builder: (context, value, _) {\n'
          '    return LinearProgressIndicator(\n'
          '      value: value,\n'
          '      backgroundColor: Colors.grey[200],\n'
          '      valueColor: AlwaysStoppedAnimation(\n'
          '        Colors.blue,\n'
          '      ),\n'
          '    );\n'
          '  },\n'
          ')',
          Icons.linear_scale,
          Colors.teal,
        ),
        const SizedBox(height: 16),

        // Pattern 6: Rotation
        _buildPatternCard(
          'Rotation Animation',
          'Rotate a widget to a target angle when state changes.',
          'TweenAnimationBuilder<double>(\n'
          '  tween: Tween(\n'
          '    begin: 0,\n'
          '    end: isExpanded ? 3.14159 / 2 : 0,\n'
          '  ),\n'
          '  duration: Duration(milliseconds: 200),\n'
          '  builder: (context, angle, child) {\n'
          '    return Transform.rotate(\n'
          '      angle: angle,\n'
          '      child: child,\n'
          '    );\n'
          '  },\n'
          '  child: Icon(Icons.chevron_right),\n'
          ')',
          Icons.rotate_right,
          Colors.orange,
        ),
        const SizedBox(height: 16),

        // Pattern 7: Staggered children
        _buildPatternCard(
          'Staggered List Items',
          'Delay each item\u0027s animation by its index for cascade effect.',
          '// Inside a ListView.builder\n'
          'TweenAnimationBuilder<double>(\n'
          '  tween: Tween(begin: 0.0, end: 1.0),\n'
          '  duration: Duration(milliseconds: 400),\n'
          '  curve: Interval(\n'
          '    (index * 0.1).clamp(0.0, 1.0),\n'
          '    ((index * 0.1) + 0.6).clamp(0.0, 1.0),\n'
          '    curve: Curves.easeOut,\n'
          '  ),\n'
          '  builder: (context, t, child) {\n'
          '    return Opacity(\n'
          '      opacity: t,\n'
          '      child: child,\n'
          '    );\n'
          '  },\n'
          '  child: ListTile(title: Text(items[index])),\n'
          ')',
          Icons.format_list_numbered,
          Colors.indigo,
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// TAB 8 — Summary
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildSummaryTab(Color accent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenAnimationBuilder Summary',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 20),

        // Key properties table
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Text(
                  'Key Properties',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 16,
                  ),
                ),
              ),
              _buildSummaryRow('Class', 'TweenAnimationBuilder<T>'),
              _buildSummaryRow('Extends', 'ImplicitlyAnimatedWidget'),
              _buildSummaryRow('Animation Type', 'Implicit (fire-and-forget)'),
              _buildSummaryRow('Controller', 'Managed internally'),
              _buildSummaryRow('Dispose', 'Automatic'),
              _buildSummaryRow('Trigger', 'Change tween.end value'),
              _buildSummaryRow('Callback', 'onEnd when animation finishes'),
              _buildSummaryRow('Performance', 'Use child parameter for optimization'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // When to use vs alternatives
        Text(
          'Decision Guide',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        _buildDecisionRow(
          'Simple property change',
          'AnimatedContainer / AnimatedFoo',
          'Built-in widgets handle common cases',
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildDecisionRow(
          'Custom implict animation',
          'TweenAnimationBuilder',
          'When no built-in widget exists',
          accent,
        ),
        const SizedBox(height: 8),
        _buildDecisionRow(
          'Full playback control',
          'AnimationController + AnimatedBuilder',
          'Need repeat, reverse, or multi-sequence',
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildDecisionRow(
          'Physics-based motion',
          'AnimationController + simulation',
          'Spring, friction, gravity animations',
          Colors.purple,
        ),
        const SizedBox(height: 8),
        _buildDecisionRow(
          'Page transitions',
          'PageRouteBuilder / Hero',
          'Navigation-specific animations',
          Colors.teal,
        ),
        const SizedBox(height: 24),

        // Quick reference
        Text(
          'Quick Reference',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '// Minimal usage\n'
            'TweenAnimationBuilder<double>(\n'
            '  tween: Tween(begin: 0, end: targetValue),\n'
            '  duration: Duration(milliseconds: 500),\n'
            '  builder: (context, value, child) {\n'
            '    return Opacity(opacity: value, child: child);\n'
            '  },\n'
            '  child: MyWidget(),\n'
            ')\n'
            '\n'
            '// Full-featured usage\n'
            'TweenAnimationBuilder<Color?>(\n'
            '  tween: ColorTween(\n'
            '    begin: Colors.blue,\n'
            '    end: activeColor,\n'
            '  ),\n'
            '  duration: Duration(milliseconds: 300),\n'
            '  curve: Curves.easeInOut,\n'
            '  onEnd: () => print(\u0027Done!\u0027),\n'
            '  builder: (context, color, child) {\n'
            '    return DecoratedBox(\n'
            '      decoration: BoxDecoration(color: color),\n'
            '      child: child,\n'
            '    );\n'
            '  },\n'
            '  child: Padding(\n'
            '    padding: EdgeInsets.all(16),\n'
            '    child: Text(\u0027Colored Box\u0027),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Common gotchas
        Text(
          'Common Gotchas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        _buildGotchaCard(
          'Tween.begin ignored on rebuild',
          'Only tween.end changes trigger new animations. '
          'Use a Key to force full recreation.',
          Icons.warning_amber,
          Colors.red,
        ),
        const SizedBox(height: 8),
        _buildGotchaCard(
          'Missing child optimization',
          'Not passing the child parameter means the entire '
          'subtree rebuilds every frame.',
          Icons.speed,
          Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildGotchaCard(
          'Redundant with built-in widgets',
          'Check if AnimatedContainer, AnimatedOpacity, or '
          'another AnimatedFoo already covers your use case.',
          Icons.layers,
          Colors.amber,
        ),
        const SizedBox(height: 8),
        _buildGotchaCard(
          'Creating Tweens in build()',
          'Creating a new Tween object every build causes the '
          'animation to restart. Preserve the Tween instance or '
          'keep tween.end stable when unchanged.',
          Icons.refresh,
          Colors.blue,
        ),
        const SizedBox(height: 24),

        // Final note
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 36),
              const SizedBox(height: 12),
              const Text(
                'TweenAnimationBuilder is the Swiss Army knife of '
                'implicit animations. Whenever you need a custom '
                'animated transition without the boilerplate of '
                'AnimationController, reach for this widget.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════════
// Helper Widgets
// ════════════════════════════════════════════════════════════════════════════════

Widget _buildReasonCard(IconData icon, String title, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiParamCard(
  String name,
  String type,
  String description,
  Color accent, {
  bool isRequired = false,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: accent,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyRow(String name, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 24.0, top: 6, bottom: 6),
    child: Row(
      children: [
        if (depth > 0)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              '\u2514\u2500',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTweenTypeCard(
  String name,
  String description,
  String code,
  String useCases,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(fontSize: 13, height: 1.4)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Use cases: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: Text(
                useCases,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCurveRow(String name, String visual, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            visual,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.greenAccent,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCurveFlipRow(String label, String curve, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              curve,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.greenAccent,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBuilderParamCard(
  String name,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineEvent(
  String number,
  String title,
  String description,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRetriggerRow(
  String condition,
  String result,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                condition,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              Text(
                result,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  String code,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryRow(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecisionRow(
  String scenario,
  String choice,
  String reason,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scenario,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\u2192 $choice',
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          reason,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildGotchaCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
