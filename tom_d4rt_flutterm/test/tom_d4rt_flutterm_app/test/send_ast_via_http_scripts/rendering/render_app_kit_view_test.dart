// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderAppKitView / RenderUiKitView platform view embedding concepts
// Shows placeholder containers representing native macOS/iOS views,
// layout configurations, hit test behaviors, gesture recognizer areas,
// intrinsic sizing, and Flutter/platform view composition.

import 'package:flutter/material.dart';

// Simulated PlatformViewHitTestBehavior enum values for display
List<String> hitTestBehaviors = ['opaque', 'translucent', 'transparent'];

// Descriptions for each hit test behavior
Map<String, String> hitTestDescriptions = {
  'opaque': 'Absorbs all hit events. Flutter widgets behind the platform view receive no events.',
  'translucent': 'Allows hit events to pass through to Flutter widgets behind the platform view.',
  'transparent': 'The platform view is invisible to hit testing. All events go to Flutter widgets.',
};

// Icons mapped to hit test behaviors
Map<String, IconData> hitTestIcons = {
  'opaque': Icons.block,
  'translucent': Icons.blur_on,
  'transparent': Icons.visibility_off,
};

// Colors mapped to hit test behaviors
Map<String, Color> hitTestColors = {
  'opaque': Colors.red,
  'translucent': Colors.orange,
  'transparent': Colors.green,
};

// Gesture recognizer mode labels
List<String> gestureRecognizerModes = [
  'No recognizers (platform handles all)',
  'Tap recognizer (Flutter intercepts taps)',
  'Pan recognizer (Flutter intercepts drags)',
  'Long press recognizer (Flutter intercepts holds)',
  'Scale recognizer (Flutter intercepts pinch)',
];

// Icons for gesture modes
List<IconData> gestureIcons = [
  Icons.touch_app,
  Icons.ads_click,
  Icons.swipe,
  Icons.back_hand,
  Icons.pinch,
];

// Sizing mode labels for intrinsic size demonstrations
List<String> sizingModes = [
  'Fixed 200x150',
  'Expanded (fill parent)',
  'Aspect ratio 16:9',
  'Aspect ratio 4:3',
  'Wrap content (intrinsic)',
  'Min constraints 100x80',
];

// Composition layer labels
List<String> compositionLayers = [
  'Flutter above platform view',
  'Flutter below platform view',
  'Flutter alongside (row)',
  'Flutter alongside (column)',
  'Overlapping stack',
  'Clipped platform view',
];

// Helper to build gradient header containers
Widget buildGradientHeader(String title, List<Color> colors) {
  print('Building gradient header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: colors[0].withValues(alpha: 0.4),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

// Helper to build section title with icon
Widget buildSectionTitle(String title, IconData icon, Color color) {
  print('Building section title: $title');
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a card with shadow
Widget buildCard(Widget child, {Color backgroundColor = Colors.white}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );
}

// Simulated native platform view placeholder
Widget buildPlatformViewPlaceholder(
  String label,
  double width,
  double height,
  Color borderColor,
  IconData platformIcon,
) {
  print('Building platform view placeholder: $label ($width x $height)');
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: borderColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(platformIcon, size: 32, color: borderColor),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: borderColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${width.toInt()} x ${height.toInt()}',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// Section 1: Platform view placeholder containers
Widget buildPlaceholderSection() {
  print('Building placeholder containers section');
  List<Widget> children = [];

  children.add(buildSectionTitle(
    'Native View Placeholders',
    Icons.desktop_mac,
    Colors.indigo,
  ));

  children.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UiKitView (iOS) and AppKitView (macOS) embed native platform views. '
          'These placeholders represent where native views would render.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildPlatformViewPlaceholder(
              'AppKitView\n(macOS NSView)',
              130,
              100,
              Colors.blue,
              Icons.desktop_mac,
            ),
            buildPlatformViewPlaceholder(
              'UiKitView\n(iOS UIView)',
              130,
              100,
              Colors.purple,
              Icons.phone_iphone,
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: buildPlatformViewPlaceholder(
            'AndroidView\n(Android View)',
            130,
            100,
            Colors.green,
            Icons.android,
          ),
        ),
      ],
    ),
  ));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );
}

// Section 2: Layout configurations for platform views
Widget buildLayoutConfigSection() {
  print('Building layout configurations section');
  List<Widget> items = [];

  // Fixed size platform view
  items.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fixed Size (200 x 150)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Center(
          child: buildPlatformViewPlaceholder(
            'Fixed Size\nPlatformView',
            200,
            150,
            Colors.teal,
            Icons.crop_square,
          ),
        ),
      ],
    ),
  ));

  // Expanded platform view
  items.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expanded (fills available width)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.open_in_full, color: Colors.teal),
                SizedBox(width: 8),
                Text('Expanded PlatformView',
                    style: TextStyle(color: Colors.teal)),
              ],
            ),
          ),
        ),
      ],
    ),
  ));

  // Aspect ratio constrained views
  items.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Aspect Ratio Constrained',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('16:9',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    border: Border.all(color: Colors.deepOrange, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('4:3',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'Layout Configurations',
        Icons.view_quilt,
        Colors.teal,
      ),
      Column(children: items),
    ],
  );
}

// Section 3: Hit test behavior visualization
Widget buildHitTestSection() {
  print('Building hit test behavior section');
  List<Widget> cards = [];

  for (int i = 0; i < hitTestBehaviors.length; i++) {
    String behavior = hitTestBehaviors[i];
    String description = hitTestDescriptions[behavior] ?? '';
    IconData icon = hitTestIcons[behavior] ?? Icons.help;
    Color color = hitTestColors[behavior] ?? Colors.grey;

    print('  Hit test behavior: $behavior');

    cards.add(buildCard(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PlatformViewHitTestBehavior.$behavior',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                SizedBox(height: 8),
                // Visual demonstration
                Stack(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Center(
                        child: Text('Flutter Widget (behind)',
                            style: TextStyle(
                                color: Colors.blue.shade400, fontSize: 11)),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: color),
                        ),
                        child: Center(
                          child: Text('Platform View ($behavior)',
                              style: TextStyle(color: color, fontSize: 10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'PlatformViewHitTestBehavior',
        Icons.touch_app,
        Colors.red.shade700,
      ),
      Column(children: cards),
    ],
  );
}

// Section 4: Gesture recognizers behavior
Widget buildGestureRecognizersSection() {
  print('Building gesture recognizers section');
  List<Widget> cards = [];

  for (int i = 0; i < gestureRecognizerModes.length; i++) {
    String mode = gestureRecognizerModes[i];
    IconData icon = gestureIcons[i];

    print('  Gesture mode: $mode');

    Color cardColor = Colors.primaries[i % Colors.primaries.length].shade50;
    Color accentColor = Colors.primaries[i % Colors.primaries.length];

    cards.add(buildCard(
      Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withValues(alpha: 0.6)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mode,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                SizedBox(height: 4),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentColor.withValues(alpha: 0.4)),
                  ),
                  child: Center(
                    child: Text(
                      'Platform view area',
                      style: TextStyle(fontSize: 11, color: accentColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'Gesture Recognizers Configuration',
        Icons.gesture,
        Colors.deepPurple,
      ),
      Text(
        'gestureRecognizers determines which gestures Flutter intercepts '
        'vs which pass to the native platform view.',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      SizedBox(height: 8),
      Column(children: cards),
    ],
  );
}

// Section 5: Intrinsic sizing behavior
Widget buildIntrinsicSizingSection() {
  print('Building intrinsic sizing section');
  List<Widget> items = [];

  List<List<double>> dimensions = [
    [200, 150],
    [0, 80],
    [320, 180],
    [280, 210],
    [0, 0],
    [100, 80],
  ];

  for (int i = 0; i < sizingModes.length; i++) {
    String mode = sizingModes[i];
    double w = dimensions[i][0];
    double h = dimensions[i][1];

    print('  Sizing mode: $mode');

    bool isExpanded = w == 0 && h != 0;
    bool isIntrinsic = w == 0 && h == 0;

    Widget viewWidget;
    if (isIntrinsic) {
      viewWidget = Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          border: Border.all(color: Colors.amber.shade700, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fit_screen, color: Colors.amber.shade700),
            Text('Intrinsic size',
                style: TextStyle(fontSize: 11, color: Colors.amber.shade700)),
            Text('(wraps content)',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    } else if (isExpanded) {
      viewWidget = Container(
        width: double.infinity,
        height: h,
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          border: Border.all(color: Colors.cyan.shade700, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('Expanded width, height: ${h.toInt()}',
              style: TextStyle(fontSize: 11, color: Colors.cyan.shade700)),
        ),
      );
    } else {
      viewWidget = Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.lime.shade50,
          border: Border.all(color: Colors.lime.shade800, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('${w.toInt()} x ${h.toInt()}',
              style: TextStyle(fontSize: 11, color: Colors.lime.shade800)),
        ),
      );
    }

    items.add(buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mode, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          SizedBox(height: 8),
          Center(child: viewWidget),
        ],
      ),
    ));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'Intrinsic Sizing Behavior',
        Icons.straighten,
        Colors.brown,
      ),
      Text(
        'Platform views report their preferred intrinsic sizes to '
        'Flutter layout. These examples show how RenderAppKitView '
        'handles different sizing strategies.',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      SizedBox(height: 8),
      Column(children: items),
    ],
  );
}

// Section 6: Platform view composition with Flutter content
Widget buildCompositionSection() {
  print('Building composition section');
  List<Widget> demos = [];

  // Flutter above platform view
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Above Platform View',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade500, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.desktop_windows, color: Colors.grey.shade500),
                    Text('Native Platform View',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 11)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('Flutter FAB',
                    style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
          ],
        ),
      ],
    ),
  ));

  // Flutter below platform view
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Below Platform View',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('Flutter Background Layer',
                    style: TextStyle(color: Colors.blue.shade300, fontSize: 12)),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade600, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Platform View (above)',
                      style: TextStyle(
                          color: Colors.grey.shade700, fontSize: 11)),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ));

  // Flutter alongside in row
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Alongside (Row)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Flutter\nWidget',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 11)),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey.shade500, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Native Platform View',
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 11)),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Flutter\nWidget',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 11)),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ));

  // Flutter alongside in column
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Alongside (Column)',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text('Flutter Header',
                style: TextStyle(color: Colors.purple, fontSize: 11)),
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey.shade500, width: 2),
          ),
          child: Center(
            child: Text('Native Platform View',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
          ),
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text('Flutter Footer',
                style: TextStyle(color: Colors.purple, fontSize: 11)),
          ),
        ),
      ],
    ),
  ));

  // Overlapping stack
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overlapping Stack Composition',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade100, Colors.indigo.shade200],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Flutter gradient background',
                      style: TextStyle(
                          color: Colors.indigo.shade400, fontSize: 11)),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 30,
              child: Container(
                width: 140,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade600, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text('Platform View A',
                      style: TextStyle(
                          color: Colors.grey.shade700, fontSize: 10)),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 40,
              child: Container(
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border.all(color: Colors.grey.shade700, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text('Platform View B',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ));

  // Clipped platform view
  demos.add(buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Clipped Platform View',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade500, width: 2),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.crop, color: Colors.grey.shade500, size: 24),
                    Text('Clipped',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Center(
          child: Text('ClipRRect with border radius 50',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        ),
      ],
    ),
  ));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'Platform View Composition',
        Icons.layers,
        Colors.indigo,
      ),
      Text(
        'RenderAppKitView composes native views within Flutter rendering. '
        'These demonstrate stacking, clipping, and layout relationships.',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      SizedBox(height: 8),
      Column(children: demos),
    ],
  );
}

// Section 7: Summary info panel
Widget buildSummaryPanel() {
  print('Building summary panel');

  List<List<String>> rows = [
    ['RenderAppKitView', 'macOS NSView embedding via AppKitView'],
    ['RenderUiKitView', 'iOS UIView embedding via UiKitView'],
    ['AndroidViewSurface', 'Android View embedding surface'],
    ['hitTestBehavior', 'Controls event routing to/from platform view'],
    ['gestureRecognizers', 'Declares which gestures Flutter intercepts'],
    ['creationParams', 'Parameters passed to native view factory'],
    ['layoutDirection', 'Inherited text direction for native view'],
    ['clipBehavior', 'How to clip platform view at render boundaries'],
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle(
        'Platform View API Summary',
        Icons.summarize,
        Colors.blueGrey,
      ),
      buildCard(
        Column(
          children: rows.map((row) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      row[0],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row[1],
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// Main build entry point
dynamic build(BuildContext context) {
  print('=== RenderAppKitView / RenderUiKitView Deep Demo ===');
  print('Demonstrating platform view embedding concepts');
  print('Platform: macOS AppKitView, iOS UiKitView');
  print('Topics: layout, hit testing, gestures, sizing, composition');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main header
        buildGradientHeader(
          'RenderAppKitView / RenderUiKitView',
          [Colors.blueGrey.shade800, Colors.blueGrey.shade500],
        ),
        SizedBox(height: 8),
        buildGradientHeader(
          'Platform View Embedding Deep Demo',
          [Colors.indigo.shade600, Colors.purple.shade400],
        ),
        SizedBox(height: 8),
        buildCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderAppKitView (macOS) and RenderUiKitView (iOS) are render objects '
                'responsible for embedding native platform views within the Flutter '
                'rendering pipeline. They manage sizing, hit testing, gesture forwarding, '
                'and compositing of native views alongside Flutter widgets.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.blue),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'These placeholders show where native views would render on actual hardware.',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue.shade600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 1: Placeholder containers
        buildPlaceholderSection(),

        // Section 2: Layout configurations
        buildLayoutConfigSection(),

        // Section 3: Hit test behavior
        buildHitTestSection(),

        // Section 4: Gesture recognizers
        buildGestureRecognizersSection(),

        // Section 5: Intrinsic sizing
        buildIntrinsicSizingSection(),

        // Section 6: Composition
        buildCompositionSection(),

        // Section 7: Summary
        buildSummaryPanel(),

        SizedBox(height: 24),

        // Footer
        buildGradientHeader(
          'End of RenderAppKitView Demo',
          [Colors.grey.shade600, Colors.grey.shade400],
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}
