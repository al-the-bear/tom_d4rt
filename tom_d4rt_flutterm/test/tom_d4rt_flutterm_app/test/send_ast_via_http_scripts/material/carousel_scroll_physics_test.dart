// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CarouselScrollPhysics concepts from material
import 'package:flutter/material.dart';

// Helper to build a physics indicator bar
Widget buildPhysicsBar(
  String label,
  Color color,
  double fillPercent,
  String description,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 6),
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fillPercent.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

// Helper to build a scroll position display
Widget buildScrollPositionDisplay(
  String title,
  Color primaryColor,
  List<Map<String, dynamic>> positions,
) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        ...positions.map((pos) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: pos['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pos['label'] as String,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  pos['value'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// Helper to build a simulated scroll track
Widget buildScrollTrack(
  String label,
  Color trackColor,
  Color thumbColor,
  double thumbPosition,
  double thumbSize,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    left:
                        (constraints.maxWidth - thumbSize) *
                        thumbPosition.clamp(0.0, 1.0),
                    top: 2,
                    child: Container(
                      width: thumbSize,
                      height: 16,
                      decoration: BoxDecoration(
                        color: thumbColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

// Helper to build bounce zone visualization
Widget buildBounceZone(
  String title,
  Color color,
  bool topBounce,
  bool bottomBounce,
) {
  return Container(
    margin: EdgeInsets.all(8),
    width: 120,
    height: 200,
    decoration: BoxDecoration(
      border: Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: topBounce
                ? color.withValues(alpha: 0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          child: Center(
            child: Text(
              topBounce ? 'BOUNCE' : 'CLAMP',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.shade100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swap_vert, color: color, size: 24),
                  SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: bottomBounce
                ? color.withValues(alpha: 0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Center(
            child: Text(
              bottomBounce ? 'BOUNCE' : 'CLAMP',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper for velocity decay visualization
Widget buildVelocityDecay(String label, Color color, int steps) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          children: List.generate(steps, (i) {
            var opacity = 1.0 - (i / steps);
            var height = 30.0 * opacity;
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1),
                height: height.clamp(4.0, 30.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: opacity.clamp(0.1, 1.0)),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// Helper for spring response visualization
Widget buildSpringResponse(String label, Color color, List<double> amplitudes) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: amplitudes.map((amp) {
              var barHeight = (amp.abs() * 50).clamp(2.0, 50.0);
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (amp > 0)
                      Container(
                        height: barHeight,
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        color: color.withValues(alpha: 0.7),
                      ),
                    Container(height: 1, color: Colors.grey),
                    if (amp <= 0)
                      Container(
                        height: barHeight,
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        color: color.withValues(alpha: 0.4),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// Section header helper
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CarouselScrollPhysics Visual Test ===');
  debugPrint('Demonstrating scroll physics concepts visually');

  // Section 1: Bouncing Physics
  debugPrint('Section 1: BouncingScrollPhysics visualization');
  var bouncingPhysics = BouncingScrollPhysics();
  debugPrint('BouncingScrollPhysics created: $bouncingPhysics');

  // Section 2: Clamping Physics
  debugPrint('Section 2: ClampingScrollPhysics visualization');
  var clampingPhysics = ClampingScrollPhysics();
  debugPrint('ClampingScrollPhysics created: $clampingPhysics');

  // Section 3: NeverScrollable Physics
  debugPrint('Section 3: NeverScrollableScrollPhysics visualization');
  var neverScrollable = NeverScrollableScrollPhysics();
  debugPrint('NeverScrollableScrollPhysics created: $neverScrollable');

  // Section 4: Always Scrollable
  debugPrint('Section 4: AlwaysScrollableScrollPhysics visualization');
  var alwaysScrollable = AlwaysScrollableScrollPhysics();
  debugPrint('AlwaysScrollableScrollPhysics created: $alwaysScrollable');

  // Section 5: Page scroll physics
  debugPrint('Section 5: PageScrollPhysics visualization');
  var pagePhysics = PageScrollPhysics();
  debugPrint('PageScrollPhysics created: $pagePhysics');

  // Section 6: Physics chains
  debugPrint('Section 6: Chained physics');
  var chainedBounce = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );
  debugPrint('Chained bouncing+always: $chainedBounce');
  var chainedClamp = ClampingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );
  debugPrint('Chained clamping+always: $chainedClamp');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Scroll Physics Visual Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Physics Types Overview
            buildSectionHeader(
              'Scroll Physics Types',
              Icons.speed,
              Colors.indigo,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Different scroll physics control how scroll views respond to user gestures',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),

            // Physics type cards
            buildPhysicsBar(
              'BouncingScrollPhysics',
              Colors.blue,
              0.85,
              'iOS-style: allows scrolling past edges with spring-back effect',
            ),
            buildPhysicsBar(
              'ClampingScrollPhysics',
              Colors.green,
              0.75,
              'Android-style: stops at edges with overscroll glow effect',
            ),
            buildPhysicsBar(
              'NeverScrollableScrollPhysics',
              Colors.red,
              0.0,
              'Completely disables scrolling - content stays fixed',
            ),
            buildPhysicsBar(
              'AlwaysScrollableScrollPhysics',
              Colors.orange,
              1.0,
              'Always allows scrolling even when content fits viewport',
            ),
            buildPhysicsBar(
              'PageScrollPhysics',
              Colors.purple,
              0.65,
              'Snaps to page boundaries - used in PageView',
            ),

            // Section 2: Bounce Zone Comparison
            buildSectionHeader(
              'Bounce Zone Behavior',
              Icons.unfold_more,
              Colors.teal,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'How different physics handle overscroll at edges',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildBounceZone('Bouncing', Colors.blue, true, true),
                  buildBounceZone('Clamping', Colors.green, false, false),
                  buildBounceZone('Never', Colors.red, false, false),
                  buildBounceZone('Always', Colors.orange, true, true),
                  buildBounceZone('Page', Colors.purple, true, true),
                ],
              ),
            ),

            // Section 3: Scroll Position Displays
            buildSectionHeader(
              'Scroll Position States',
              Icons.location_on,
              Colors.deepPurple,
            ),
            buildScrollPositionDisplay(
              'Bouncing Physics Positions',
              Colors.blue,
              [
                {
                  'label': 'Resting position',
                  'value': '0.0',
                  'color': Colors.blue,
                },
                {
                  'label': 'Over-scroll top',
                  'value': '-50.0',
                  'color': Colors.blue.shade300,
                },
                {
                  'label': 'Mid content',
                  'value': '250.0',
                  'color': Colors.blue.shade600,
                },
                {
                  'label': 'Near bottom',
                  'value': '480.0',
                  'color': Colors.blue.shade700,
                },
                {
                  'label': 'Over-scroll bottom',
                  'value': '550.0',
                  'color': Colors.blue.shade300,
                },
              ],
            ),
            buildScrollPositionDisplay(
              'Clamping Physics Positions',
              Colors.green,
              [
                {'label': 'Min extent', 'value': '0.0', 'color': Colors.green},
                {
                  'label': 'Quarter scroll',
                  'value': '125.0',
                  'color': Colors.green.shade400,
                },
                {
                  'label': 'Half scroll',
                  'value': '250.0',
                  'color': Colors.green.shade600,
                },
                {
                  'label': 'Three-quarter',
                  'value': '375.0',
                  'color': Colors.green.shade700,
                },
                {
                  'label': 'Max extent',
                  'value': '500.0',
                  'color': Colors.green.shade800,
                },
              ],
            ),
            buildScrollPositionDisplay(
              'Page Physics Positions',
              Colors.purple,
              [
                {
                  'label': 'Page 0',
                  'value': '0.0',
                  'color': Colors.purple.shade300,
                },
                {
                  'label': 'Page 1',
                  'value': '375.0',
                  'color': Colors.purple.shade400,
                },
                {
                  'label': 'Page 2',
                  'value': '750.0',
                  'color': Colors.purple.shade500,
                },
                {
                  'label': 'Page 3',
                  'value': '1125.0',
                  'color': Colors.purple.shade600,
                },
                {
                  'label': 'Page 4',
                  'value': '1500.0',
                  'color': Colors.purple.shade700,
                },
              ],
            ),

            // Section 4: Scroll Track Visualizations
            buildSectionHeader(
              'Scroll Track Positions',
              Icons.linear_scale,
              Colors.brown,
            ),
            buildScrollTrack(
              'Bouncing - At start',
              Colors.blue.shade100,
              Colors.blue,
              0.0,
              40,
            ),
            buildScrollTrack(
              'Bouncing - Mid',
              Colors.blue.shade100,
              Colors.blue,
              0.5,
              40,
            ),
            buildScrollTrack(
              'Bouncing - At end',
              Colors.blue.shade100,
              Colors.blue,
              1.0,
              40,
            ),
            buildScrollTrack(
              'Clamping - At start',
              Colors.green.shade100,
              Colors.green,
              0.0,
              50,
            ),
            buildScrollTrack(
              'Clamping - Mid',
              Colors.green.shade100,
              Colors.green,
              0.5,
              50,
            ),
            buildScrollTrack(
              'Clamping - At end',
              Colors.green.shade100,
              Colors.green,
              1.0,
              50,
            ),
            buildScrollTrack(
              'Page - Page 0',
              Colors.purple.shade100,
              Colors.purple,
              0.0,
              60,
            ),
            buildScrollTrack(
              'Page - Page 1',
              Colors.purple.shade100,
              Colors.purple,
              0.33,
              60,
            ),
            buildScrollTrack(
              'Page - Page 2',
              Colors.purple.shade100,
              Colors.purple,
              0.66,
              60,
            ),
            buildScrollTrack(
              'Page - Page 3',
              Colors.purple.shade100,
              Colors.purple,
              1.0,
              60,
            ),
            SizedBox(height: 8),

            // Section 5: Velocity Decay Patterns
            buildSectionHeader(
              'Velocity Decay Patterns',
              Icons.trending_down,
              Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'How quickly each physics type decelerates after a fling gesture',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildVelocityDecay('Bouncing (Gradual)', Colors.blue, 20),
            buildVelocityDecay('Clamping (Quick Stop)', Colors.green, 12),
            buildVelocityDecay('Never (Instant Stop)', Colors.red, 1),
            buildVelocityDecay('Always (Extended)', Colors.orange, 25),
            buildVelocityDecay('Page (Snap)', Colors.purple, 8),

            // Section 6: Spring Response Visualization
            buildSectionHeader(
              'Spring Response Curves',
              Icons.show_chart,
              Colors.cyan,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Spring-back behavior when overscrolling with bouncing physics',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildSpringResponse('Under-damped (iOS-like)', Colors.blue, [
              1.0,
              0.8,
              0.5,
              0.1,
              -0.3,
              -0.5,
              -0.3,
              0.0,
              0.2,
              0.3,
              0.2,
              0.0,
              -0.1,
              -0.15,
              -0.1,
              0.0,
              0.05,
              0.08,
              0.04,
              0.0,
            ]),
            buildSpringResponse('Critically Damped', Colors.green, [
              1.0,
              0.7,
              0.45,
              0.25,
              0.12,
              0.05,
              0.02,
              0.01,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
              0.0,
            ]),
            buildSpringResponse('Over-damped', Colors.orange, [
              1.0,
              0.85,
              0.72,
              0.6,
              0.5,
              0.42,
              0.35,
              0.28,
              0.22,
              0.17,
              0.13,
              0.1,
              0.07,
              0.05,
              0.03,
              0.02,
              0.01,
              0.005,
              0.0,
              0.0,
            ]),

            // Section 7: Live Physics Demo
            buildSectionHeader(
              'Live Scroll Physics Demo',
              Icons.touch_app,
              Colors.pink,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Actual scrollable areas with different physics applied',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),

            // Bouncing physics demo
            Container(
              margin: EdgeInsets.all(8),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'BouncingScrollPhysics - Try scrolling!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (ctx, i) {
                        return Container(
                          height: 36,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(
                              alpha: 0.1 + (i % 5) * 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Bouncing Item $i',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Clamping physics demo
            Container(
              margin: EdgeInsets.all(8),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.green,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'ClampingScrollPhysics - Try scrolling!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (ctx, i) {
                        return Container(
                          height: 36,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(
                              alpha: 0.1 + (i % 5) * 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Clamping Item $i',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // NeverScrollable demo
            Container(
              margin: EdgeInsets.all(8),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.red,
                    child: Row(
                      children: [
                        Icon(Icons.block, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'NeverScrollableScrollPhysics - Cannot scroll!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (ctx, i) {
                        return Container(
                          height: 36,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(
                              alpha: 0.1 + (i % 5) * 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Locked Item $i',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Section 8: Physics Chaining
            buildSectionHeader(
              'Physics Chaining',
              Icons.link,
              Colors.amber.shade800,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Scroll physics can be chained via parent property for combined behavior',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Bouncing',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_downward, size: 16),
                              Text('Always', style: TextStyle(fontSize: 11)),
                              SizedBox(height: 4),
                              Text(
                                'iOS + always scrollable',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Clamping',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_downward, size: 16),
                              Text('Always', style: TextStyle(fontSize: 11)),
                              SizedBox(height: 4),
                              Text(
                                'Android + always scrollable',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Page',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_downward, size: 16),
                              Text('Bouncing', style: TextStyle(fontSize: 11)),
                              SizedBox(height: 4),
                              Text(
                                'Page snap + iOS bounce',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Section 9: Tolerance Values Table
            buildSectionHeader(
              'Physics Tolerance Values',
              Icons.tune,
              Colors.blueGrey,
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Table(
                border: TableBorder.all(color: Colors.blueGrey.shade200),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade100),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Physics',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Distance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Velocity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Bouncing', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Clamping', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('Page', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('0.01', style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Section 10: Summary
            buildSectionHeader('Summary', Icons.summarize, Colors.indigo),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade50, Colors.blue.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Takeaways:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.blue, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'BouncingScrollPhysics: overscrolls with spring-back',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'ClampingScrollPhysics: hard stop at edges',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'NeverScrollable: no scrolling allowed',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.orange, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'AlwaysScrollable: scrolls even when content fits',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.purple, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'PageScrollPhysics: snaps to page boundaries',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
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
