// D4rt test script: Tests ChipAnimationStyle from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for animation property card
Widget buildAnimPropertyCard(String property, String description, String value, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 4)),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 3, offset: Offset(0, 1)),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(property, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(description, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
      ],
    ),
  );
}

// Helper for duration visual
Widget buildDurationVisual(String label, int durationMs, Color color, double maxWidth) {
  double fraction = durationMs / 1000.0;
  if (fraction > 1.0) fraction = 1.0;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: fraction,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text('${durationMs}ms', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper for curve visual representation
Widget buildCurveVisual(String name, Color color, List<double> points) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: SizedBox(
            height: 36,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: points.map((p) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    height: 36 * p,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.3 + p * 0.7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
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

// Helper for chip state transition visual
Widget buildStateTransitionVisual(String fromState, String toState, Color fromColor, Color toColor,
    String animLabel, int durationMs) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // From state
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: fromColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(fromState, style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 8),
        // Arrow with animation label
        Expanded(
          child: Column(
            children: [
              Text(animLabel, style: TextStyle(fontSize: 9, color: Colors.grey)),
              Container(
                height: 2,
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [fromColor, toColor]),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Text('${durationMs}ms', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(width: 8),
        // To state
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: toColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(toState, style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

// Helper for animation frame strip
Widget buildAnimationFrameStrip(String label, Color startColor, Color endColor, int frames) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Row(
          children: List.generate(frames, (i) {
            double t = i / (frames - 1);
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1),
                height: 40,
                decoration: BoxDecoration(
                  color: Color.lerp(startColor, endColor, t),
                  borderRadius: BorderRadius.circular(4 + t * 16),
                ),
                child: Center(
                  child: Text('${(t * 100).toInt()}%', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// Helper for elevation animation visual
Widget buildElevationAnimFrame(double elevation, Color color, String label) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: [
          Material(
            elevation: elevation,
            borderRadius: BorderRadius.circular(12),
            color: color,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text('e:${elevation.toInt()}', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    ),
  );
}

// Helper for padding animation
Widget buildPaddingAnimFrame(double padding, Color color, String label) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('A', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== ChipAnimationStyle Visual Test ===');
  debugPrint('Demonstrating chip animation configurations');

  debugPrint('Testing animation durations');
  debugPrint('Testing animation curves');
  debugPrint('Testing state transitions');
  debugPrint('Testing visual animation frames');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Chip Animation Style Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Animation Properties
            buildSectionHeader('Animation Style Properties', Icons.animation, Colors.deepPurple),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'ChipAnimationStyle controls how chips animate between states (enable/disable, select/deselect)',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildAnimPropertyCard('enableAnimation', 'Animation for enable/disable', 'AnimationStyle', Colors.blue, Icons.toggle_on),
            buildAnimPropertyCard('selectAnimation', 'Animation for select/deselect', 'AnimationStyle', Colors.green, Icons.check_circle),
            buildAnimPropertyCard('avatarDrawerAnimation', 'Animation for avatar showing/hiding', 'AnimationStyle', Colors.orange, Icons.account_circle),
            buildAnimPropertyCard('deleteIconDrawerAnimation', 'Animation for delete icon', 'AnimationStyle', Colors.red, Icons.delete),

            // Section 2: Animation Duration Comparison
            buildSectionHeader('Duration Comparison', Icons.timer, Colors.blue),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Different duration values affect how fast the animation completes',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildDurationVisual('Instant', 0, Colors.red, 200),
            buildDurationVisual('Very Fast', 100, Colors.orange, 200),
            buildDurationVisual('Fast', 200, Colors.amber, 200),
            buildDurationVisual('Normal', 300, Colors.green, 200),
            buildDurationVisual('Medium', 500, Colors.teal, 200),
            buildDurationVisual('Slow', 700, Colors.blue, 200),
            buildDurationVisual('Very Slow', 1000, Colors.purple, 200),

            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Per animation type:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            buildDurationVisual('enable', 200, Colors.blue, 200),
            buildDurationVisual('select', 300, Colors.green, 200),
            buildDurationVisual('avatar', 250, Colors.orange, 200),
            buildDurationVisual('delete', 200, Colors.red, 200),

            // Section 3: Curve Visualizations
            buildSectionHeader('Animation Curves', Icons.show_chart, Colors.green),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Easing curves define the rate of change over time',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildCurveVisual('linear', Colors.blue, [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]),
            buildCurveVisual('easeIn', Colors.green, [0.0, 0.01, 0.04, 0.09, 0.16, 0.25, 0.36, 0.49, 0.64, 0.81, 1.0]),
            buildCurveVisual('easeOut', Colors.orange, [0.0, 0.19, 0.36, 0.51, 0.64, 0.75, 0.84, 0.91, 0.96, 0.99, 1.0]),
            buildCurveVisual('easeInOut', Colors.purple, [0.0, 0.02, 0.08, 0.18, 0.32, 0.5, 0.68, 0.82, 0.92, 0.98, 1.0]),
            buildCurveVisual('bounce', Colors.red, [0.0, 0.06, 0.25, 0.56, 1.0, 0.81, 0.56, 0.75, 1.0, 0.94, 1.0]),
            buildCurveVisual('elastic', Colors.teal, [0.0, 0.0, 0.0, 0.1, 0.5, 1.1, 0.9, 1.05, 0.97, 1.01, 1.0]),

            // Section 4: State Transitions
            buildSectionHeader('State Transitions', Icons.swap_horiz, Colors.orange),
            buildStateTransitionVisual('Disabled', 'Enabled', Colors.grey, Colors.blue, 'enableAnimation', 200),
            buildStateTransitionVisual('Enabled', 'Disabled', Colors.blue, Colors.grey, 'enableAnimation', 200),
            buildStateTransitionVisual('Unselected', 'Selected', Colors.grey.shade400, Colors.green, 'selectAnimation', 300),
            buildStateTransitionVisual('Selected', 'Unselected', Colors.green, Colors.grey.shade400, 'selectAnimation', 300),
            buildStateTransitionVisual('No Avatar', 'Avatar', Colors.grey.shade400, Colors.orange, 'avatarDrawer', 250),
            buildStateTransitionVisual('Avatar', 'No Avatar', Colors.orange, Colors.grey.shade400, 'avatarDrawer', 250),
            buildStateTransitionVisual('No Delete', 'Delete Icon', Colors.grey.shade400, Colors.red, 'deleteDrawer', 200),
            buildStateTransitionVisual('Delete Icon', 'No Delete', Colors.red, Colors.grey.shade400, 'deleteDrawer', 200),

            // Section 5: Color Transition Frames
            buildSectionHeader('Color Animation Frames', Icons.movie, Colors.pink),
            buildAnimationFrameStrip('Select: grey to blue', Colors.grey, Colors.blue, 8),
            SizedBox(height: 4),
            buildAnimationFrameStrip('Select: grey to green', Colors.grey, Colors.green, 8),
            SizedBox(height: 4),
            buildAnimationFrameStrip('Enable: grey to orange', Colors.grey.shade300, Colors.orange, 8),
            SizedBox(height: 4),
            buildAnimationFrameStrip('Deselect: purple to grey', Colors.purple, Colors.grey, 8),
            SizedBox(height: 4),
            buildAnimationFrameStrip('Focus: teal to cyan', Colors.teal, Colors.cyan, 8),

            // Section 6: Elevation Animation
            buildSectionHeader('Elevation Animation', Icons.layers, Colors.brown),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Elevation changes during select/deselect animation',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select animation (0 to 4)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      buildElevationAnimFrame(0, Colors.blue.shade200, '0ms'),
                      buildElevationAnimFrame(1, Colors.blue.shade300, '75ms'),
                      buildElevationAnimFrame(2, Colors.blue.shade400, '150ms'),
                      buildElevationAnimFrame(3, Colors.blue.shade500, '225ms'),
                      buildElevationAnimFrame(4, Colors.blue.shade600, '300ms'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deselect animation (4 to 0)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      buildElevationAnimFrame(4, Colors.green.shade600, '0ms'),
                      buildElevationAnimFrame(3, Colors.green.shade500, '75ms'),
                      buildElevationAnimFrame(2, Colors.green.shade400, '150ms'),
                      buildElevationAnimFrame(1, Colors.green.shade300, '225ms'),
                      buildElevationAnimFrame(0, Colors.green.shade200, '300ms'),
                    ],
                  ),
                ],
              ),
            ),

            // Section 7: Padding/Size Animation
            buildSectionHeader('Size Animation Frames', Icons.open_in_full, Colors.cyan),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Avatar drawer opening', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      buildPaddingAnimFrame(0, Colors.orange.shade200, '0ms'),
                      buildPaddingAnimFrame(2, Colors.orange.shade300, '50ms'),
                      buildPaddingAnimFrame(4, Colors.orange.shade400, '100ms'),
                      buildPaddingAnimFrame(6, Colors.orange.shade500, '150ms'),
                      buildPaddingAnimFrame(8, Colors.orange.shade600, '200ms'),
                      buildPaddingAnimFrame(10, Colors.orange.shade700, '250ms'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delete drawer opening', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      buildPaddingAnimFrame(0, Colors.red.shade200, '0ms'),
                      buildPaddingAnimFrame(2, Colors.red.shade300, '40ms'),
                      buildPaddingAnimFrame(4, Colors.red.shade400, '80ms'),
                      buildPaddingAnimFrame(6, Colors.red.shade500, '120ms'),
                      buildPaddingAnimFrame(8, Colors.red.shade600, '160ms'),
                      buildPaddingAnimFrame(10, Colors.red.shade700, '200ms'),
                    ],
                  ),
                ],
              ),
            ),

            // Section 8: Animation Style Disabled vs Enabled
            buildSectionHeader('Disabled Animations', Icons.block, Colors.grey.shade700),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Setting duration to Duration.zero disables animation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.animation, color: Colors.green, size: 24),
                              SizedBox(height: 4),
                              Text('Animated', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.green)),
                              Text('300ms easeOut', style: TextStyle(fontSize: 9, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.block, color: Colors.red, size: 24),
                              SizedBox(height: 4),
                              Text('No Animation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.red)),
                              Text('Duration.zero', style: TextStyle(fontSize: 9, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade50, Colors.pink.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Animation Properties Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('enableAnimation', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('selectAnimation', style: TextStyle(fontSize: 10)), backgroundColor: Colors.green.shade100),
                      Chip(label: Text('avatarDrawer', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('deleteDrawer', style: TextStyle(fontSize: 10)), backgroundColor: Colors.red.shade100),
                      Chip(label: Text('duration', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('curve', style: TextStyle(fontSize: 10)), backgroundColor: Colors.teal.shade100),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
