// ignore_for_file: avoid_print
// D4rt test script: Deep demo for RenderAnimatedSizeState from rendering
//
// RenderAnimatedSizeState is an enum representing the animation state of a
// RenderAnimatedSize widget. It tracks how the widget transitions between
// different sizes when its child changes dimensions.
//
// Enum values:
//   - start: Initial state before any animation has begun
//   - stable: The animation has completed and the size is stable
//   - changed: The child size has changed and animation is in progress
//   - unstable: The child size changed again during an ongoing animation
//
// Related classes:
//   - RenderAnimatedSize: The render object that uses this state
//   - AnimatedSize: The widget wrapper for RenderAnimatedSize
//   - AnimatedContainer: Similar concept with broader property animation
//   - SizeTransition: Another widget for animating size
//
// Use cases:
//   - Understanding AnimatedSize internal lifecycle
//   - Debugging size animation glitches
//   - Building responsive layouts with animated size changes
//   - Handling rapid successive size changes gracefully
//
// This demo visualizes all four RenderAnimatedSizeState values and shows
// how AnimatedSize behaves under different conditions.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ===========================================================================
// HELPER WIDGETS
// ===========================================================================

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00695C).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.animation, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF4DB6AC).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF00695C), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF00695C),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? Color(0xFF333333),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateCard(
  String stateName,
  String description,
  Color color,
  IconData icon,
  List<String> details,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(40),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stateName,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...details.map((d) => Padding(
          padding: EdgeInsets.only(left: 8, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- ', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(d, style: TextStyle(fontSize: 12, color: Color(0xFF444444))),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}

Widget _buildTransitionArrow(
  String fromState,
  String toState,
  String trigger,
  Color fromColor,
  Color toColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: fromColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            fromState,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Icon(Icons.arrow_forward, color: Color(0xFF757575), size: 20),
              Text(
                trigger,
                style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: toColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            toState,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnimatedSizeDemo(
  String label,
  double width,
  double height,
  Duration duration,
  Curve curve,
  Alignment alignment,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00695C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Duration: ' + duration.inMilliseconds.toString() + 'ms, Curve: ' + curve.toString(),
          style: TextStyle(fontSize: 11, color: Color(0xFF888888)),
        ),
        SizedBox(height: 8),
        AnimatedSize(
          duration: duration,
          curve: curve,
          alignment: alignment,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color.withAlpha(180),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color, width: 2),
            ),
            child: Center(
              child: Text(
                width.toInt().toString() + ' x ' + height.toInt().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withAlpha(200), width: 1),
        ),
      ),
      SizedBox(width: 8),
      Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF444444)),
      ),
    ],
  );
}

// ===========================================================================
// MAIN BUILD FUNCTION
// ===========================================================================

dynamic build(BuildContext context) {
  print('=== RenderAnimatedSizeState Deep Demo ===');
  print('Demonstrating all RenderAnimatedSizeState enum values');

  // Log all enum values
  print('RenderAnimatedSizeState.start = ' + RenderAnimatedSizeState.start.toString());
  print('RenderAnimatedSizeState.stable = ' + RenderAnimatedSizeState.stable.toString());
  print('RenderAnimatedSizeState.changed = ' + RenderAnimatedSizeState.changed.toString());
  print('RenderAnimatedSizeState.unstable = ' + RenderAnimatedSizeState.unstable.toString());

  // Enum index values
  print('start index: ' + RenderAnimatedSizeState.start.index.toString());
  print('stable index: ' + RenderAnimatedSizeState.stable.index.toString());
  print('changed index: ' + RenderAnimatedSizeState.changed.index.toString());
  print('unstable index: ' + RenderAnimatedSizeState.unstable.index.toString());

  // Enum name values
  print('start name: ' + RenderAnimatedSizeState.start.name);
  print('stable name: ' + RenderAnimatedSizeState.stable.name);
  print('changed name: ' + RenderAnimatedSizeState.changed.name);
  print('unstable name: ' + RenderAnimatedSizeState.unstable.name);

  // All values list
  List<RenderAnimatedSizeState> allStates = RenderAnimatedSizeState.values;
  print('All states count: ' + allStates.length.toString());
  for (int i = 0; i < allStates.length; i++) {
    print('  [' + i.toString() + '] ' + allStates[i].toString());
  }

  // State color mapping
  Color startColor = Color(0xFF42A5F5);
  Color stableColor = Color(0xFF66BB6A);
  Color changedColor = Color(0xFFFFA726);
  Color unstableColor = Color(0xFFEF5350);

  print('Color mapping:');
  print('  start -> Blue (' + startColor.toString() + ')');
  print('  stable -> Green (' + stableColor.toString() + ')');
  print('  changed -> Orange (' + changedColor.toString() + ')');
  print('  unstable -> Red (' + unstableColor.toString() + ')');

  // Equality checks
  print('start == start: ' + (RenderAnimatedSizeState.start == RenderAnimatedSizeState.start).toString());
  print('start == stable: ' + (RenderAnimatedSizeState.start == RenderAnimatedSizeState.stable).toString());
  print('changed == unstable: ' + (RenderAnimatedSizeState.changed == RenderAnimatedSizeState.unstable).toString());

  // Demonstrate AnimatedSize configurations
  print('--- AnimatedSize Configuration Demos ---');

  print('Building Section 1: Enum State Overview');
  print('Building Section 2: State Transition Diagram');
  print('Building Section 3: AnimatedSize with Different Curves');
  print('Building Section 4: AnimatedSize with Different Durations');
  print('Building Section 5: AnimatedSize with Different Alignments');
  print('Building Section 6: AnimatedSize Wrapping Different Content');
  print('Building Section 7: Visual Legend');
  print('Building Section 8: State Lifecycle Visualization');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============================================================
        // HEADER
        // ============================================================
        _buildHeader(
          'RenderAnimatedSizeState',
          'Enum representing the animation state of RenderAnimatedSize\n'
          'Values: start, stable, changed, unstable',
        ),
        SizedBox(height: 20),

        // ============================================================
        // SECTION 1: Enum State Overview
        // ============================================================
        _buildSectionTitle('Enum State Overview', Icons.list_alt),
        Text(
          'RenderAnimatedSizeState tracks the lifecycle of size animations. '
          'Each state represents a distinct phase in the animation process.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),

        _buildStateCard(
          'RenderAnimatedSizeState.start',
          'Initial state before first layout',
          startColor,
          Icons.play_circle_outline,
          [
            'Set when RenderAnimatedSize is first created',
            'No previous size information is available yet',
            'Transitions to stable after first successful layout',
            'Duration: very brief, typically one frame',
          ],
        ),

        _buildStateCard(
          'RenderAnimatedSizeState.stable',
          'Size is settled, no animation in progress',
          stableColor,
          Icons.check_circle_outline,
          [
            'The most common resting state',
            'Child size matches the displayed size',
            'No animation controller is actively running',
            'Transitions to changed if child size differs on next layout',
          ],
        ),

        _buildStateCard(
          'RenderAnimatedSizeState.changed',
          'Child size changed, animation is running',
          changedColor,
          Icons.swap_horiz,
          [
            'Triggered when child reports a different size during layout',
            'Animation controller is actively interpolating between old and new size',
            'If child size stays the same, will eventually reach stable',
            'If child size changes again, transitions to unstable',
          ],
        ),

        _buildStateCard(
          'RenderAnimatedSizeState.unstable',
          'Child size changed again during animation',
          unstableColor,
          Icons.warning_amber_outlined,
          [
            'Occurs when the child changes size while already animating',
            'Animation restarts with the newest target size',
            'May lead to visual jitter if size keeps changing rapidly',
            'Will return to changed once the new animation begins cleanly',
          ],
        ),

        SizedBox(height: 8),

        // Enum properties info section
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFC5E1A5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enum Properties',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33691E),
                ),
              ),
              SizedBox(height: 8),
              _buildInfoRow('Type', 'enum RenderAnimatedSizeState'),
              _buildInfoRow('Values count', '4'),
              _buildInfoRow('start.index', '0'),
              _buildInfoRow('stable.index', '1'),
              _buildInfoRow('changed.index', '2'),
              _buildInfoRow('unstable.index', '3'),
              _buildInfoRow('Package', 'flutter/rendering.dart'),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 2: State Transition Diagram
        // ============================================================
        _buildSectionTitle('State Transition Diagram', Icons.account_tree),
        Text(
          'Visual diagram showing how states transition based on child size changes '
          'during the RenderAnimatedSize layout cycle.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),

        _buildTransitionArrow(
          'start', 'stable',
          'First layout completes',
          startColor, stableColor,
        ),
        _buildTransitionArrow(
          'stable', 'changed',
          'Child size differs from current',
          stableColor, changedColor,
        ),
        _buildTransitionArrow(
          'changed', 'stable',
          'Animation completes, size settled',
          changedColor, stableColor,
        ),
        _buildTransitionArrow(
          'changed', 'unstable',
          'Child changes size again mid-animation',
          changedColor, unstableColor,
        ),
        _buildTransitionArrow(
          'unstable', 'changed',
          'New animation begins with latest size',
          unstableColor, changedColor,
        ),

        SizedBox(height: 8),

        // Full cycle visualization
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFF8BBD0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Lifecycle Example',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(height: 10),
              // Step 1
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: startColor, shape: BoxShape.circle),
                    child: Center(child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('Widget created -> state = start', style: TextStyle(fontSize: 12))),
                ],
              ),
              SizedBox(height: 6),
              // Step 2
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: stableColor, shape: BoxShape.circle),
                    child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('First layout done -> state = stable', style: TextStyle(fontSize: 12))),
                ],
              ),
              SizedBox(height: 6),
              // Step 3
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: changedColor, shape: BoxShape.circle),
                    child: Center(child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('Child resizes -> state = changed (animating)', style: TextStyle(fontSize: 12))),
                ],
              ),
              SizedBox(height: 6),
              // Step 4a
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: stableColor, shape: BoxShape.circle),
                    child: Center(child: Text('4a', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('Animation completes -> state = stable', style: TextStyle(fontSize: 12))),
                ],
              ),
              SizedBox(height: 6),
              // Step 4b
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: unstableColor, shape: BoxShape.circle),
                    child: Center(child: Text('4b', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('Child resizes again mid-animation -> state = unstable', style: TextStyle(fontSize: 12))),
                ],
              ),
              SizedBox(height: 6),
              // Step 5
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: changedColor, shape: BoxShape.circle),
                    child: Center(child: Text('5', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text('Restarts with new target -> state = changed', style: TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 3: AnimatedSize with Different Curves
        // ============================================================
        _buildSectionTitle('AnimatedSize with Different Curves', Icons.show_chart),
        Text(
          'AnimatedSize uses curves to control the animation easing. '
          'Different curves produce visually distinct size transitions.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 8),

        _buildAnimatedSizeDemo(
          'Curves.easeInOut (default feel)',
          200, 60, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.center,
          Color(0xFF42A5F5),
        ),

        _buildAnimatedSizeDemo(
          'Curves.bounceOut',
          180, 55, Duration(milliseconds: 800),
          Curves.bounceOut, Alignment.center,
          Color(0xFF66BB6A),
        ),

        _buildAnimatedSizeDemo(
          'Curves.elasticOut',
          220, 65, Duration(milliseconds: 1000),
          Curves.elasticOut, Alignment.center,
          Color(0xFFAB47BC),
        ),

        _buildAnimatedSizeDemo(
          'Curves.fastOutSlowIn',
          190, 50, Duration(milliseconds: 400),
          Curves.fastOutSlowIn, Alignment.center,
          Color(0xFFFF7043),
        ),

        _buildAnimatedSizeDemo(
          'Curves.decelerate',
          210, 70, Duration(milliseconds: 600),
          Curves.decelerate, Alignment.center,
          Color(0xFF26C6DA),
        ),

        _buildAnimatedSizeDemo(
          'Curves.linear',
          170, 45, Duration(milliseconds: 300),
          Curves.linear, Alignment.center,
          Color(0xFFEF5350),
        ),

        // Curve comparison table
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Curve Characteristics',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A)),
              ),
              SizedBox(height: 8),
              _buildInfoRow('easeInOut', 'Smooth start and end, natural feel'),
              _buildInfoRow('bounceOut', 'Bounces at the end, playful effect'),
              _buildInfoRow('elasticOut', 'Overshoots then settles, spring-like'),
              _buildInfoRow('fastOutSlowIn', 'Quick start, gradual stop'),
              _buildInfoRow('decelerate', 'Starts fast, slows to stop'),
              _buildInfoRow('linear', 'Constant speed throughout'),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 4: AnimatedSize with Different Durations
        // ============================================================
        _buildSectionTitle('AnimatedSize with Different Durations', Icons.timer),
        Text(
          'Duration controls how long the size animation takes. '
          'Shorter durations feel snappier, longer durations feel smoother.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 8),

        _buildAnimatedSizeDemo(
          '100ms - Very fast',
          160, 40, Duration(milliseconds: 100),
          Curves.easeInOut, Alignment.center,
          Color(0xFFEF5350),
        ),

        _buildAnimatedSizeDemo(
          '300ms - Typical UI',
          180, 50, Duration(milliseconds: 300),
          Curves.easeInOut, Alignment.center,
          Color(0xFFFFA726),
        ),

        _buildAnimatedSizeDemo(
          '500ms - Noticeable',
          200, 60, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.center,
          Color(0xFF66BB6A),
        ),

        _buildAnimatedSizeDemo(
          '1000ms - Slow and dramatic',
          220, 70, Duration(milliseconds: 1000),
          Curves.easeInOut, Alignment.center,
          Color(0xFF42A5F5),
        ),

        _buildAnimatedSizeDemo(
          '2000ms - Very slow',
          240, 80, Duration(milliseconds: 2000),
          Curves.easeInOut, Alignment.center,
          Color(0xFF7E57C2),
        ),

        // Duration recommendation
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFFFCC80)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFE65100), size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Recommendation: Use 200-500ms for most UI transitions. '
                  'Faster durations risk being jarring; slower durations risk '
                  'feeling sluggish. Match duration to content importance.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 5: AnimatedSize with Different Alignments
        // ============================================================
        _buildSectionTitle('AnimatedSize with Different Alignments', Icons.format_align_center),
        Text(
          'Alignment determines where the child is positioned within '
          'the animated size boundary during transitions.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 8),

        _buildAnimatedSizeDemo(
          'Alignment.topLeft',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.topLeft,
          Color(0xFF42A5F5),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.topCenter',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.topCenter,
          Color(0xFF66BB6A),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.topRight',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.topRight,
          Color(0xFFFFA726),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.center (default)',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.center,
          Color(0xFFAB47BC),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.bottomLeft',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.bottomLeft,
          Color(0xFFEF5350),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.bottomCenter',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.bottomCenter,
          Color(0xFF26C6DA),
        ),

        _buildAnimatedSizeDemo(
          'Alignment.bottomRight',
          150, 50, Duration(milliseconds: 500),
          Curves.easeInOut, Alignment.bottomRight,
          Color(0xFF8D6E63),
        ),

        // Alignment grid visualization
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF9FA8DA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alignment Grid',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF283593)),
              ),
              SizedBox(height: 10),
              // Top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAlignmentCell('TL', Color(0xFF42A5F5)),
                  _buildAlignmentCell('TC', Color(0xFF66BB6A)),
                  _buildAlignmentCell('TR', Color(0xFFFFA726)),
                ],
              ),
              SizedBox(height: 6),
              // Center row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAlignmentCell('CL', Color(0xFF78909C)),
                  _buildAlignmentCell('CC', Color(0xFFAB47BC)),
                  _buildAlignmentCell('CR', Color(0xFF78909C)),
                ],
              ),
              SizedBox(height: 6),
              // Bottom row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAlignmentCell('BL', Color(0xFFEF5350)),
                  _buildAlignmentCell('BC', Color(0xFF26C6DA)),
                  _buildAlignmentCell('BR', Color(0xFF8D6E63)),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 6: AnimatedSize Wrapping Different Content Sizes
        // ============================================================
        _buildSectionTitle('Content Size Variations', Icons.aspect_ratio),
        Text(
          'AnimatedSize smoothly transitions when the child widget changes size. '
          'Here we show different initial content sizes wrapped in AnimatedSize.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 8),

        // Small content
        _buildContentSizeDemo(
          'Small Content',
          'Compact widget inside AnimatedSize',
          80, 40,
          Color(0xFF42A5F5),
        ),

        // Medium content
        _buildContentSizeDemo(
          'Medium Content',
          'A medium-sized child widget that demonstrates how AnimatedSize '
          'adapts to moderately sized content',
          200, 80,
          Color(0xFF66BB6A),
        ),

        // Large content
        _buildContentSizeDemo(
          'Large Content',
          'A significantly larger child widget demonstrating how AnimatedSize '
          'handles bigger content. This shows the widget at a larger dimension '
          'to illustrate the full range of size animation capabilities.',
          280, 120,
          Color(0xFFFFA726),
        ),

        // Very tall thin content
        _buildContentSizeDemo(
          'Tall Thin Content',
          'Narrow but tall content',
          100, 150,
          Color(0xFFAB47BC),
        ),

        // Wide short content
        _buildContentSizeDemo(
          'Wide Short Content',
          'A wider but shorter widget',
          300, 35,
          Color(0xFFEF5350),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 7: Visual Legend
        // ============================================================
        _buildSectionTitle('State Color Legend', Icons.palette),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderAnimatedSizeState Color Mapping',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _buildLegendItem('start', startColor)),
                  Expanded(child: _buildLegendItem('stable', stableColor)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildLegendItem('changed', changedColor)),
                  Expanded(child: _buildLegendItem('unstable', unstableColor)),
                ],
              ),
              SizedBox(height: 14),
              Divider(color: Color(0xFFE0E0E0)),
              SizedBox(height: 10),
              Text(
                'Usage in Code:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF444444)),
              ),
              SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RenderAnimatedSizeState.start',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: startColor),
                    ),
                    Text(
                      'RenderAnimatedSizeState.stable',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: stableColor),
                    ),
                    Text(
                      'RenderAnimatedSizeState.changed',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: changedColor),
                    ),
                    Text(
                      'RenderAnimatedSizeState.unstable',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: unstableColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 8: State Lifecycle Visualization
        // ============================================================
        _buildSectionTitle('State Lifecycle Timeline', Icons.timeline),
        Text(
          'A visual timeline showing how a RenderAnimatedSize object moves '
          'through different states over its lifetime.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),

        // Timeline events
        _buildTimelineEvent(
          'T=0',
          'Widget Inserted',
          'RenderAnimatedSize created, enters start state',
          startColor,
          Icons.fiber_new,
          true,
        ),
        _buildTimelineEvent(
          'T=1',
          'First Layout',
          'Initial child measured and laid out, transitions to stable',
          stableColor,
          Icons.check,
          false,
        ),
        _buildTimelineEvent(
          'T=10',
          'Child Resized',
          'Child reports new intrinsic size, transitions to changed '
          'and starts animation toward new size',
          changedColor,
          Icons.open_with,
          false,
        ),
        _buildTimelineEvent(
          'T=15',
          'Animation Running',
          'AnimationController is active, interpolating between '
          'old and new size using configured curve and duration',
          changedColor,
          Icons.play_arrow,
          false,
        ),
        _buildTimelineEvent(
          'T=20',
          'Animation Done',
          'Size reaches target, animation controller completes, '
          'state returns to stable',
          stableColor,
          Icons.stop,
          false,
        ),
        _buildTimelineEvent(
          'T=30',
          'Rapid Resizing',
          'Child changes size while already animating, '
          'transitions to unstable',
          unstableColor,
          Icons.warning,
          false,
        ),
        _buildTimelineEvent(
          'T=31',
          'Recovery',
          'New animation starts with latest target, '
          'returns to changed state',
          changedColor,
          Icons.refresh,
          false,
        ),
        _buildTimelineEvent(
          'T=41',
          'Final Stable',
          'Animation completes without interruption, '
          'back to stable. Widget is at rest.',
          stableColor,
          Icons.done_all,
          true,
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 9: Practical Usage Patterns
        // ============================================================
        _buildSectionTitle('Practical Usage Patterns', Icons.code),
        Text(
          'Common patterns for using AnimatedSize effectively '
          'and avoiding the unstable state.',
          style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
        ),
        SizedBox(height: 12),

        // Pattern 1: Expandable content
        _buildPatternCard(
          'Expandable Content',
          'Use AnimatedSize to smoothly expand/collapse sections',
          Icons.expand,
          Color(0xFF42A5F5),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: double.infinity,
              height: 60,
              color: Color(0xFF42A5F5).withAlpha(30),
              child: Center(
                child: Text('Expandable area', style: TextStyle(color: Color(0xFF42A5F5))),
              ),
            ),
          ),
        ),

        // Pattern 2: Dynamic list
        _buildPatternCard(
          'Dynamic List Items',
          'AnimatedSize wrapping a list that may grow or shrink',
          Icons.list,
          Color(0xFF66BB6A),
          AnimatedSize(
            duration: Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: 32,
                  color: Color(0xFF66BB6A).withAlpha(20),
                  child: Center(child: Text('Item 1', style: TextStyle(fontSize: 12))),
                ),
                Container(
                  height: 32,
                  color: Color(0xFF66BB6A).withAlpha(40),
                  child: Center(child: Text('Item 2', style: TextStyle(fontSize: 12))),
                ),
                Container(
                  height: 32,
                  color: Color(0xFF66BB6A).withAlpha(60),
                  child: Center(child: Text('Item 3', style: TextStyle(fontSize: 12))),
                ),
              ],
            ),
          ),
        ),

        // Pattern 3: Image loading placeholder
        _buildPatternCard(
          'Image Loading Placeholder',
          'Smooth transition from placeholder to loaded image size',
          Icons.image,
          Color(0xFFFFA726),
          AnimatedSize(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFFFFA726).withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image, color: Color(0xFFFFA726), size: 32),
                    SizedBox(height: 4),
                    Text('Image placeholder', style: TextStyle(fontSize: 11, color: Color(0xFFFFA726))),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 24),

        // ============================================================
        // SECTION 10: API Reference Summary
        // ============================================================
        _buildSectionTitle('API Reference', Icons.menu_book),

        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Enum', 'RenderAnimatedSizeState'),
              _buildInfoRow('Library', 'rendering'),
              _buildInfoRow('Package', 'flutter'),
              Divider(color: Color(0xFFBDBDBD)),
              SizedBox(height: 4),
              Text(
                'Values:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF00695C)),
              ),
              SizedBox(height: 6),
              _buildInfoRow('start', 'Initial state, no layout yet'),
              _buildInfoRow('stable', 'Size is settled, at rest'),
              _buildInfoRow('changed', 'Animating to new size'),
              _buildInfoRow('unstable', 'Size changed again mid-animation'),
              Divider(color: Color(0xFFBDBDBD)),
              SizedBox(height: 4),
              Text(
                'Properties (inherited from Enum):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF00695C)),
              ),
              SizedBox(height: 6),
              _buildInfoRow('index', 'Zero-based position of the value'),
              _buildInfoRow('name', 'String name of the enum value'),
              _buildInfoRow('hashCode', 'Hash code for the value'),
              _buildInfoRow('runtimeType', 'Runtime type representation'),
              Divider(color: Color(0xFFBDBDBD)),
              SizedBox(height: 4),
              Text(
                'Used by:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF00695C)),
              ),
              SizedBox(height: 6),
              _buildInfoRow('RenderAnimatedSize', 'The render object that tracks this state'),
              _buildInfoRow('AnimatedSize', 'Widget wrapper for RenderAnimatedSize'),
            ],
          ),
        ),

        SizedBox(height: 30),

        // Footer
        _buildHeader(
          'Demo Complete',
          'RenderAnimatedSizeState: start | stable | changed | unstable\n'
          'Four states governing AnimatedSize animation lifecycle',
        ),

        SizedBox(height: 16),
      ],
    ),
  );
}

// ===========================================================================
// ADDITIONAL HELPER WIDGETS
// ===========================================================================

Widget _buildAlignmentCell(String label, Color color) {
  return Container(
    width: 60,
    height: 36,
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ),
  );
}

Widget _buildContentSizeDemo(
  String title,
  String description,
  double width,
  double height,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF00695C)),
        ),
        SizedBox(height: 4),
        Text(
          'Size: ' + width.toInt().toString() + ' x ' + height.toInt().toString(),
          style: TextStyle(fontSize: 11, color: Color(0xFF888888)),
        ),
        SizedBox(height: 8),
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color, width: 1),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              description,
              style: TextStyle(fontSize: 11, color: color),
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineEvent(
  String time,
  String title,
  String description,
  Color color,
  IconData icon,
  bool isTerminal,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Timeline line and dot
      Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(60),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 16)),
          ),
          if (!isTerminal)
            Container(
              width: 2,
              height: 40,
              color: color.withAlpha(80),
            ),
        ],
      ),
      SizedBox(width: 12),
      // Content
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: isTerminal ? 0 : 12),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(40),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Color(0xFF555555)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  IconData icon,
  Color color,
  Widget demo,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
        ),
        SizedBox(height: 10),
        demo,
      ],
    ),
  );
}
