// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RepeatingAnimationBuilder
// Demonstrates the concept of repeating (looping) animations in
// Flutter. A RepeatingAnimationBuilder continuously cycles an
// animation—forward, reverse, or both—using AnimationController
// .repeat(). This demo covers cycle types, timing, easing curves,
// composition, and real-world use cases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RepeatingAnimationBuilder Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is a Repeating Animation?
  // ============================================================
  print('=== Section 1: Concept ===');

  // A repeating animation is one that automatically restarts
  // when it completes. Instead of playing once (like a page
  // transition), it loops continuously — suitable for loading
  // spinners, pulsing indicators, background effects, and
  // attention-grabbing UI elements.
  //
  // Core mechanism:
  //   AnimationController controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 2),
  //   )..repeat();           // forward loop
  //   ..repeat(reverse: true);  // ping-pong loop
  //
  // A builder widget (AnimatedBuilder, or a custom
  // RepeatingAnimationBuilder) rebuilds its child on each tick
  // using the current animation value.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFAD1457), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.loop, size: 36.0, color: Color(0xFFAD1457)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RepeatingAnimationBuilder',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A builder pattern for animations that loop continuously. '
          'Uses AnimationController.repeat() to restart automatically. '
          'Ideal for spinners, pulsing indicators, background effects, '
          'and any UI that needs perpetual motion.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFFAD1457)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'AnimationController(\n'
            '  duration: Duration(seconds: 2),\n'
            '  vsync: this,\n'
            ')..repeat(reverse: true);\n\n'
            '// Builder rebuilds every frame:\n'
            'AnimatedBuilder(\n'
            '  animation: controller,\n'
            '  builder: (ctx, child) {\n'
            '    return Transform.rotate(\n'
            '      angle: controller.value * 2 * pi,\n'
            '      child: child,\n'
            '    );\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Repeat Modes — Forward, Reverse, Ping-Pong
  // ============================================================
  print('=== Section 2: Repeat modes ===');

  Widget buildModeCard(
    String name,
    String code,
    String description,
    List<double> samples,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 260.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    code,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Color(0xFF80CBC4),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 10.0),
                // Visual timeline showing sample values
                Text(
                  'Value over time:',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: samples.map((v) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          height: v * 46.0 + 4.0,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.3 + v * 0.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              topRight: Radius.circular(2.0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final repeatModes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'Repeat Modes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Different ways the animation restarts after each cycle.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildModeCard(
              'Forward Loop',
              'controller.repeat();',
              '0→1, jump to 0→1, jump to 0→1...\n'
                  'Always plays forward, resets at end.',
              // Sawtooth pattern over 2 cycles
              [0.0, 0.2, 0.4, 0.6, 0.8, 1.0, 0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
              Color(0xFF1976D2),
              Icons.trending_flat,
            ),
            buildModeCard(
              'Ping-Pong',
              'controller.repeat(\n  reverse: true,\n);',
              '0→1→0→1→0...\n'
                  'Forward then backward — smooth loop.',
              // Triangle wave over 2 cycles
              [0.0, 0.33, 0.66, 1.0, 0.66, 0.33, 0.0, 0.33, 0.66, 1.0, 0.66, 0.33],
              Color(0xFF4CAF50),
              Icons.swap_horiz,
            ),
            buildModeCard(
              'Custom Period',
              'controller.repeat(\n  period: Duration(ms: 800),\n);',
              'Override the duration per cycle.\n'
                  'Faster or slower than the base duration.',
              // Same upswing but faster (shorter bars)
              [0.0, 0.25, 0.5, 0.75, 1.0, 0.0, 0.25, 0.5, 0.75, 1.0, 0.0, 0.25],
              Color(0xFFFF9800),
              Icons.speed,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Animation Snapshots at Different Times
  // ============================================================
  print('=== Section 3: Snapshots at different times ===');

  // Show what a rotating widget looks like at different
  // points during one cycle: 0%, 25%, 50%, 75%, 100%.

  Widget buildSnapshot(
    String label,
    double fraction,
    Color color,
  ) {
    final angle = fraction * 6.28318; // 2*pi
    return Column(
      children: [
        Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Transform.rotate(
              angle: angle,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: color,
          ),
        ),
        Text(
          '${(fraction * 360).toInt()}°',
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  final snapshotRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Rotation Animation — One Cycle',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Snapshots at different points during a full 360° rotation cycle.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSnapshot('0%', 0.0, Color(0xFF1976D2)),
            buildSnapshot('25%', 0.25, Color(0xFF388E3C)),
            buildSnapshot('50%', 0.50, Color(0xFFFF9800)),
            buildSnapshot('75%', 0.75, Color(0xFFE91E63)),
            buildSnapshot('100%', 1.0, Color(0xFF7B1FA2)),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'After 100%, the animation loops back to 0% and '
            'restarts — the cycle repeats indefinitely.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Curve Variations on Repeating Animations
  // ============================================================
  print('=== Section 4: Curve variations ===');

  Widget buildCurveRow(
    String curveName,
    String description,
    List<double> barValues,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curveName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: barValues.map((v) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0.5),
                      height: v * 28.0 + 2.0,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2 + v * 0.6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.0),
                          topRight: Radius.circular(1.0),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final curveSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Curves Applied to Repeating Animations',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The same animation feels different with different curves.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildCurveRow(
          'linear',
          'Constant speed',
          [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
          Color(0xFF1976D2),
        ),
        buildCurveRow(
          'easeInOut',
          'Slow → fast → slow',
          [0.0, 0.02, 0.1, 0.3, 0.5, 0.7, 0.9, 0.98, 1.0, 0.98, 0.5],
          Color(0xFF388E3C),
        ),
        buildCurveRow(
          'easeIn',
          'Starts slow',
          [0.0, 0.01, 0.04, 0.09, 0.16, 0.25, 0.36, 0.49, 0.64, 0.81, 1.0],
          Color(0xFFFF9800),
        ),
        buildCurveRow(
          'easeOut',
          'Ends slow',
          [0.0, 0.19, 0.36, 0.51, 0.64, 0.75, 0.84, 0.91, 0.96, 0.99, 1.0],
          Color(0xFFE91E63),
        ),
        buildCurveRow(
          'bounceOut',
          'Bounces at end',
          [0.0, 0.5, 0.9, 1.0, 0.8, 1.0, 0.95, 1.0, 0.98, 1.0, 1.0],
          Color(0xFF7B1FA2),
        ),
        buildCurveRow(
          'elasticIn',
          'Spring start',
          [0.0, -0.01, 0.0, 0.02, -0.03, 0.05, 0.15, 0.3, 0.55, 0.8, 1.0],
          Color(0xFF00897B),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Real-World Use Cases
  // ============================================================
  print('=== Section 5: Real-world use cases ===');

  Widget buildUseCaseCard(
    String name,
    String description,
    IconData icon,
    Widget preview,
    Color color,
  ) {
    return Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 10.0),
                preview,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Loading spinner
  final spinnerPreview = Container(
    width: 50.0,
    height: 50.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade200, width: 4.0),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 15.0,
          child: Container(
            width: 16.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    ),
  );

  // Pulsing dot
  final pulsePreview = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (var i = 0; i < 3; i++) ...[
        Container(
          width: 12.0 + i * 2.0,
          height: 12.0 + i * 2.0,
          decoration: BoxDecoration(
            color: Color(0xFFE91E63).withValues(alpha: 0.3 + i * 0.25),
            shape: BoxShape.circle,
          ),
        ),
        if (i < 2) SizedBox(width: 8.0),
      ],
    ],
  );

  // Breathing glow
  final breathePreview = Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          Color(0xFF4CAF50).withValues(alpha: 0.8),
          Color(0xFF4CAF50).withValues(alpha: 0.3),
          Color(0xFF4CAF50).withValues(alpha: 0.0),
        ],
        stops: [0.3, 0.6, 1.0],
      ),
    ),
    child: Center(
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );

  // Scrolling text
  final scrollPreview = Container(
    height: 28.0,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6.0),
    ),
    clipBehavior: Clip.hardEdge,
    child: Row(
      children: [
        SizedBox(width: 8.0),
        Text(
          'Breaking news: Flutter 4.0 rel',
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFFFF9800),
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.clip,
        ),
      ],
    ),
  );

  // Floating action
  final floatPreview = Column(
    children: [
      Transform.translate(
        offset: Offset(0, -4),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF7B1FA2).withValues(alpha: 0.3),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.add, color: Colors.white, size: 22.0),
        ),
      ),
      Container(
        width: 20.0,
        height: 6.0,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    ],
  );

  final useCases = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'Real-World Use Cases',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildUseCaseCard(
              'Loading Spinner',
              'Circular progress indicator that '
                  'rotates continuously until data loads.',
              Icons.refresh,
              spinnerPreview,
              Color(0xFF1976D2),
            ),
            buildUseCaseCard(
              'Pulse Indicator',
              'Dots that pulse in sequence to '
                  'show activity or typing status.',
              Icons.fiber_manual_record,
              pulsePreview,
              Color(0xFFE91E63),
            ),
            buildUseCaseCard(
              'Breathing Glow',
              'Soft scaling glow effect for '
                  'status indicators or microphones.',
              Icons.flare,
              breathePreview,
              Color(0xFF4CAF50),
            ),
            buildUseCaseCard(
              'Scrolling Ticker',
              'Horizontally scrolling text for '
                  'news tickers or marquee banners.',
              Icons.text_rotation_none,
              scrollPreview,
              Color(0xFFFF9800),
            ),
            buildUseCaseCard(
              'Floating Button',
              'Subtle floating motion that draws '
                  'attention to an action button.',
              Icons.add_circle,
              floatPreview,
              Color(0xFF7B1FA2),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Composing Multiple Repeating Animations
  // ============================================================
  print('=== Section 6: Composing animations ===');

  // Show how multiple repeating animations can be layered
  // to produce complex effects.

  Widget buildCompositionLayer(
    String name,
    String property,
    String range,
    Color color,
    double intensity,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: intensity * 0.15),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  'Animates: $property  •  Range: $range',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Intensity bar
          Container(
            width: 60.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: FractionallySizedBox(
              widthFactor: intensity,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final compositionSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Composing Multiple Animations',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Layer separate repeating animations for complex effects.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),

        // Example: a "radar ping" effect = scale + opacity + rotation
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.radar, color: Color(0xFF00897B), size: 24.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Radar Ping Effect',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(0xFF00897B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              buildCompositionLayer(
                'Scale pulse',
                'transform.scale',
                '1.0 → 1.5',
                Color(0xFF2196F3),
                0.8,
              ),
              buildCompositionLayer(
                'Opacity fade',
                'opacity',
                '1.0 → 0.0',
                Color(0xFF4CAF50),
                0.6,
              ),
              buildCompositionLayer(
                'Ring expansion',
                'border width',
                '3.0 → 0.5',
                Color(0xFFFF9800),
                0.4,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),

        // Visual result of composition
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring (most expanded, least visible)
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF00897B).withValues(alpha: 0.1),
                    width: 1.0,
                  ),
                ),
              ),
              // Middle ring
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF00897B).withValues(alpha: 0.3),
                    width: 2.0,
                  ),
                ),
              ),
              // Inner ring (most visible)
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF00897B).withValues(alpha: 0.6),
                    width: 3.0,
                  ),
                ),
              ),
              // Center dot
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Color(0xFF00897B),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Center(
          child: Text(
            'Combined: scale + opacity + border = radar ping',
            style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Performance & Lifecycle Tips
  // ============================================================
  print('=== Section 7: Performance tips ===');

  Widget buildTipCard(
    IconData icon,
    String title,
    String tip,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  tip,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final perfSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFF57C00)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Color(0xFFF57C00), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Performance & Lifecycle',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        buildTipCard(
          Icons.delete,
          'Dispose the controller',
          'Always call controller.dispose() in the State\'s '
              'dispose() method. Repeating animations never stop '
              'on their own and will leak resources.',
          Color(0xFFF44336),
        ),
        buildTipCard(
          Icons.pause,
          'Pause when off-screen',
          'Use VisibilityDetector or TickerMode to pause '
              'off-screen animations. Saves CPU and battery.',
          Color(0xFF1976D2),
        ),
        buildTipCard(
          Icons.child_care,
          'Use the child parameter',
          'Pass the static subtree as "child" to the builder. '
              'Flutter caches it and only rebuilds the animated part.',
          Color(0xFF388E3C),
        ),
        buildTipCard(
          Icons.layers_clear,
          'RepaintBoundary helps',
          'Wrap animated widgets in RepaintBoundary to isolate '
              'repaints. Prevents the entire tree from repainting.',
          Color(0xFF7B1FA2),
        ),
        buildTipCard(
          Icons.bar_chart,
          'Lower frame rate when idle',
          'Consider using AnimationController.animateWith() '
              'or reducing the Ticker rate for subtle ambient effects.',
          Color(0xFFFF9800),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFAD1457), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFFAD1457), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF880E4F),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRepeatingSummaryItem(
          Icons.loop,
          'Continuous motion',
          'Animations loop via controller.repeat(), no manual restart',
          Color(0xFFAD1457),
        ),
        SizedBox(height: 8.0),
        _buildRepeatingSummaryItem(
          Icons.swap_horiz,
          'Two modes',
          'Forward-only (sawtooth) or ping-pong (reverse: true)',
          Color(0xFF1976D2),
        ),
        SizedBox(height: 8.0),
        _buildRepeatingSummaryItem(
          Icons.timeline,
          'Curves shape time',
          'Apply Curves to make linear motion feel natural',
          Color(0xFF388E3C),
        ),
        SizedBox(height: 8.0),
        _buildRepeatingSummaryItem(
          Icons.layers,
          'Composable',
          'Layer multiple animations for complex visual effects',
          Color(0xFFFF9800),
        ),
        SizedBox(height: 8.0),
        _buildRepeatingSummaryItem(
          Icons.memory,
          'Dispose required',
          'Always dispose controllers — repeating animations never stop',
          Color(0xFFF44336),
        ),
      ],
    ),
  );

  print('RepeatingAnimationBuilder Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF880E4F),
                Color(0xFFAD1457),
                Color(0xFFC2185B),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.loop, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RepeatingAnimationBuilder',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Continuous looping animations',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Repeat Modes',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        repeatModes,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Rotation Snapshots',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        snapshotRow,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Curve Variations',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        curveSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Use Cases',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        useCases,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Composing Animations',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        compositionSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Performance Tips',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        perfSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildRepeatingSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
