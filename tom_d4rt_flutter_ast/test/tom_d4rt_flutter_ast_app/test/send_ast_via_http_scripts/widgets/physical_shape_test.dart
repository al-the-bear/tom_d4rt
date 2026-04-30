// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PhysicalShape widget
// Demonstrates PhysicalShape: a widget that clips its child using a custom
// shape and applies elevation with shadow colors, creating physical material
// surfaces in the UI.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PhysicalShape Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PhysicalShape?
  // ============================================================
  // PhysicalShape draws a physical layer that clips its child
  // to a given shape defined by a CustomClipper<Path>. It adds
  // elevation (shadow) and allows you to specify the surface
  // color and shadow color. Unlike PhysicalModel which only
  // supports rounded rectangles and circles, PhysicalShape
  // can clip to ANY arbitrary path.
  print('=== Section 1: PhysicalShape Basics ===');

  // Rectangle shape — the simplest form
  final basicRectangle = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
    elevation: 4.0,
    color: Colors.blue.shade50,
    shadowColor: Colors.blue.shade900,
    child: Container(
      width: 140.0,
      height: 80.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.crop_square, color: Colors.blue.shade700, size: 28.0),
          SizedBox(height: 4.0),
          Text(
            'Rectangle',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
          Text(
            'elevation: 4.0',
            style: TextStyle(fontSize: 10.0, color: Colors.blue.shade400),
          ),
        ],
      ),
    ),
  );

  // Stadium (pill) shape
  final stadiumShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: StadiumBorder(),
    ),
    elevation: 6.0,
    color: Colors.green.shade50,
    shadowColor: Colors.green.shade900,
    child: Container(
      width: 160.0,
      height: 70.0,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.rounded_corner, color: Colors.green.shade700, size: 24.0),
          SizedBox(width: 8.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stadium',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade800,
                ),
              ),
              Text(
                'StadiumBorder',
                style: TextStyle(fontSize: 9.0, color: Colors.green.shade500),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // Circle shape
  final circleShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: CircleBorder(),
    ),
    elevation: 8.0,
    color: Colors.purple.shade50,
    shadowColor: Colors.purple.shade900,
    child: Container(
      width: 100.0,
      height: 100.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle_outlined, color: Colors.purple.shade700, size: 32.0),
          SizedBox(height: 4.0),
          Text(
            'Circle',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.purple.shade800,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created 3 basic shape variants: rectangle, stadium, circle');

  final section1 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.indigo, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PhysicalShape Basics',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PhysicalShape clips its child to a shape defined by a '
            'CustomClipper<Path>. It renders an elevated surface with '
            'shadows — essentially giving any arbitrary path the look '
            'of a physical material layer. ShapeBorderClipper is the '
            'easiest way to define shapes using ShapeBorder objects.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            basicRectangle,
            stadiumShape,
            circleShape,
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Key parameters:\n'
            '• clipper: CustomClipper<Path> — defines the clip shape\n'
            '• elevation: double — depth for shadow rendering\n'
            '• color: Color — surface fill color\n'
            '• shadowColor: Color — shadow tint color',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Elevation Levels
  // ============================================================
  print('=== Section 2: Elevation Comparison ===');

  // Build elevation samples from 0 to 24
  final elevationLevels = <double>[0.0, 1.0, 2.0, 4.0, 8.0, 12.0, 16.0, 24.0];
  final elevationCards = <Widget>[];

  for (final elev in elevationLevels) {
    // Calculate visual intensity
    final intensity = (elev / 24.0).clamp(0.0, 1.0);
    final surfaceColor = Color.lerp(
      Colors.teal.shade50,
      Colors.teal.shade200,
      intensity,
    )!;
    print('  Elevation $elev → intensity ${intensity.toStringAsFixed(2)}');

    elevationCards.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: PhysicalShape(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: elev,
          color: surfaceColor,
          shadowColor: Colors.teal.shade900,
          child: Container(
            width: 80.0,
            height: 80.0,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${elev.toInt()}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                Text(
                  'dp',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.teal.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  print('Created ${elevationCards.length} elevation samples');

  final section2 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.height, color: Colors.teal, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Elevation Levels',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Higher elevation values produce larger, softer shadows. '
          'In Material Design, elevation conveys hierarchy: cards (1-2 dp), '
          'dialogs (24 dp), navigation drawers (16 dp).',
          style: TextStyle(fontSize: 12.0, color: Colors.teal.shade600),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: elevationCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Shadow Color Variations
  // ============================================================
  print('=== Section 3: Shadow Colors ===');

  final shadowColors = <Map<String, dynamic>>[
    {'name': 'Default\n(Black)', 'shadow': Colors.black, 'surface': Colors.white, 'accent': Colors.grey},
    {'name': 'Blue\nShadow', 'shadow': Colors.blue.shade900, 'surface': Colors.blue.shade50, 'accent': Colors.blue},
    {'name': 'Red\nShadow', 'shadow': Colors.red.shade900, 'surface': Colors.red.shade50, 'accent': Colors.red},
    {'name': 'Green\nShadow', 'shadow': Colors.green.shade900, 'surface': Colors.green.shade50, 'accent': Colors.green},
    {'name': 'Orange\nShadow', 'shadow': Colors.orange.shade900, 'surface': Colors.orange.shade50, 'accent': Colors.orange},
    {'name': 'Purple\nShadow', 'shadow': Colors.purple.shade900, 'surface': Colors.purple.shade50, 'accent': Colors.purple},
  ];

  final shadowCards = <Widget>[];
  for (final entry in shadowColors) {
    final accent = entry['accent'] as Color;
    shadowCards.add(
      Padding(
        padding: EdgeInsets.all(8.0),
        child: PhysicalShape(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          elevation: 10.0,
          color: entry['surface'] as Color,
          shadowColor: entry['shadow'] as Color,
          child: Container(
            width: 100.0,
            height: 90.0,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.palette, size: 28.0, color: accent),
                SizedBox(height: 6.0),
                Text(
                  entry['name'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  print('Created ${shadowCards.length} shadow color samples');

  final section3 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.color_lens, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Shadow Color Variations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The shadowColor parameter tints the elevation shadow. '
          'Colored shadows can create distinctive UI effects: a red '
          'shadow draws attention, a blue one feels cool and calm.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: shadowCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Different Border Shapes
  // ============================================================
  print('=== Section 4: Border Shapes ===');

  // Beveled rectangle
  final beveledShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    elevation: 6.0,
    color: Colors.amber.shade100,
    shadowColor: Colors.amber.shade700,
    child: Container(
      width: 140.0,
      height: 100.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.diamond_outlined, size: 32.0, color: Colors.amber.shade800),
          SizedBox(height: 6.0),
          Text(
            'Beveled',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
          Text(
            'BeveledRectangleBorder',
            style: TextStyle(fontSize: 8.0, color: Colors.amber.shade600),
          ),
        ],
      ),
    ),
  );

  // Continuous rectangle (superellipse)
  final continuousShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    ),
    elevation: 6.0,
    color: Colors.cyan.shade100,
    shadowColor: Colors.cyan.shade700,
    child: Container(
      width: 140.0,
      height: 100.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.rounded_corner, size: 32.0, color: Colors.cyan.shade800),
          SizedBox(height: 6.0),
          Text(
            'Continuous',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade900,
            ),
          ),
          Text(
            'ContinuousRectangle',
            style: TextStyle(fontSize: 8.0, color: Colors.cyan.shade600),
          ),
        ],
      ),
    ),
  );

  // Star shape using StarBorder
  final starLikeShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: StarBorder(
        points: 6,
        innerRadiusRatio: 0.6,
      ),
    ),
    elevation: 6.0,
    color: Colors.pink.shade100,
    shadowColor: Colors.pink.shade700,
    child: Container(
      width: 120.0,
      height: 120.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 32.0, color: Colors.pink.shade800),
          SizedBox(height: 4.0),
          Text(
            'Star',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade900,
            ),
          ),
        ],
      ),
    ),
  );

  // Rounded rectangle with asymmetric corners
  final asymmetricShape = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
    ),
    elevation: 6.0,
    color: Colors.lime.shade100,
    shadowColor: Colors.lime.shade700,
    child: Container(
      width: 140.0,
      height: 100.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.crop_rotate, size: 32.0, color: Colors.lime.shade800),
          SizedBox(height: 6.0),
          Text(
            'Asymmetric',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.lime.shade900,
            ),
          ),
          Text(
            'Diagonal rounding',
            style: TextStyle(fontSize: 8.0, color: Colors.lime.shade600),
          ),
        ],
      ),
    ),
  );

  print('Created 4 shape variants: beveled, continuous, star, asymmetric');

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, color: Colors.amber.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Shape Variations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'ShapeBorderClipper wraps any ShapeBorder into a CustomClipper<Path>. '
          'Flutter provides several built-in borders: RoundedRectangleBorder, '
          'BeveledRectangleBorder, ContinuousRectangleBorder, CircleBorder, '
          'StadiumBorder, and StarBorder.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            beveledShape,
            continuousShape,
            starLikeShape,
            asymmetricShape,
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Practical UI Cards Using PhysicalShape
  // ============================================================
  print('=== Section 5: Practical UI Examples ===');

  // User profile card
  final profileCard = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    elevation: 8.0,
    color: Colors.white,
    shadowColor: Colors.indigo.shade400,
    child: Container(
      width: 200.0,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          PhysicalShape(
            clipper: ShapeBorderClipper(shape: CircleBorder()),
            elevation: 4.0,
            color: Colors.indigo.shade100,
            shadowColor: Colors.indigo.shade300,
            child: Container(
              width: 72.0,
              height: 72.0,
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                size: 40.0,
                color: Colors.indigo.shade700,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Jane Doe',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatPill('Posts', '142', Colors.indigo),
              _buildStatPill('Likes', '3.2K', Colors.pink),
            ],
          ),
        ],
      ),
    ),
  );

  // Notification badge
  final notificationBadge = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevation: 6.0,
    color: Colors.red.shade50,
    shadowColor: Colors.red.shade300,
    child: Container(
      width: 200.0,
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          PhysicalShape(
            clipper: ShapeBorderClipper(shape: CircleBorder()),
            elevation: 3.0,
            color: Colors.red.shade400,
            shadowColor: Colors.red.shade700,
            child: Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              child: Icon(Icons.notifications, color: Colors.white, size: 24.0),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Alert',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
                Text(
                  '3 unread notifications',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.red.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // Success message card
  final successCard = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    elevation: 6.0,
    color: Colors.green.shade50,
    shadowColor: Colors.green.shade300,
    child: Container(
      width: 200.0,
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          PhysicalShape(
            clipper: ShapeBorderClipper(shape: CircleBorder()),
            elevation: 2.0,
            color: Colors.green.shade400,
            shadowColor: Colors.green.shade700,
            child: Container(
              width: 40.0,
              height: 40.0,
              alignment: Alignment.center,
              child: Icon(Icons.check, color: Colors.white, size: 24.0),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                Text(
                  'Operation completed',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.green.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Created 3 practical UI cards');

  final section5 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: Colors.indigo, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Practical UI Components',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PhysicalShape is excellent for building elevated card UIs. '
          'Nested PhysicalShapes create depth hierarchies — the outer '
          'card lifts off the background, while inner shapes (avatars, '
          'badges) float above the card surface.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        profileCard,
        SizedBox(height: 12.0),
        notificationBadge,
        SizedBox(height: 12.0),
        successCard,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Clip Behavior
  // ============================================================
  print('=== Section 6: Clip Behavior ===');

  // clipBehavior controls how content overflowing the shape is handled
  final clipBehaviors = <Map<String, dynamic>>[
    {
      'clip': Clip.none,
      'label': 'Clip.none',
      'desc': 'No clipping applied',
      'color': Colors.red,
    },
    {
      'clip': Clip.hardEdge,
      'label': 'Clip.hardEdge',
      'desc': 'Fast, jagged edges',
      'color': Colors.orange,
    },
    {
      'clip': Clip.antiAlias,
      'label': 'Clip.antiAlias',
      'desc': 'Smooth edges, slower',
      'color': Colors.blue,
    },
    {
      'clip': Clip.antiAliasWithSaveLayer,
      'label': 'antiAlias+SaveLayer',
      'desc': 'Best quality, slowest',
      'color': Colors.green,
    },
  ];

  final clipCards = <Widget>[];
  for (final entry in clipBehaviors) {
    final color = entry['color'] as MaterialColor;
    clipCards.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            PhysicalShape(
              clipper: ShapeBorderClipper(shape: CircleBorder()),
              clipBehavior: entry['clip'] as Clip,
              elevation: 4.0,
              color: color.shade50,
              shadowColor: color.shade400,
              child: Container(
                width: 70.0,
                height: 70.0,
                alignment: Alignment.center,
                child: Icon(Icons.content_cut, color: color.shade700, size: 28.0),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              entry['label'] as String,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Text(
              entry['desc'] as String,
              style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${clipCards.length} clip behavior samples');

  final section6 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.content_cut, color: Colors.deepOrange, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Clip Behavior Options',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The clipBehavior parameter controls edge quality when content '
          'overflows the shape. Clip.none is fastest but may show artifacts; '
          'Clip.antiAliasWithSaveLayer is highest quality but most expensive.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: clipCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Layered Composition
  // ============================================================
  print('=== Section 7: Layered Composition ===');

  // Demonstrate nesting and layered PhysicalShapes to create
  // a rich visual composition — like a floating dashboard panel.
  final dashboardPanel = PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
    elevation: 12.0,
    color: Color(0xFF1A237E),
    shadowColor: Colors.indigo.shade900,
    child: Container(
      width: 320.0,
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Monthly performance summary',
            style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade200),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDashMetric('Revenue', '\$24.5K', Icons.trending_up, Colors.greenAccent),
              _buildDashMetric('Users', '1,847', Icons.group, Colors.cyanAccent),
              _buildDashMetric('Orders', '392', Icons.shopping_cart, Colors.amberAccent),
            ],
          ),
          SizedBox(height: 20.0),
          // Nested bar chart using layered PhysicalShapes
          PhysicalShape(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: 4.0,
            color: Color(0xFF283593),
            shadowColor: Colors.black,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Activity',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar('Mon', 0.6, Colors.cyanAccent),
                      _buildBar('Tue', 0.8, Colors.cyanAccent),
                      _buildBar('Wed', 0.45, Colors.cyanAccent),
                      _buildBar('Thu', 0.9, Colors.cyanAccent),
                      _buildBar('Fri', 0.7, Colors.cyanAccent),
                      _buildBar('Sat', 0.3, Colors.cyanAccent),
                      _buildBar('Sun', 0.2, Colors.cyanAccent),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created layered dashboard composition');

  final section7 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, color: Colors.indigo, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Layered Composition',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PhysicalShape widgets can be nested to create rich depth '
          'hierarchies. The outer shape provides the main elevation, '
          'while inner shapes create secondary surfaces that appear '
          'to float above the parent.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Center(child: dashboardPanel),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: PhysicalShape vs PhysicalModel Comparison
  // ============================================================
  print('=== Section 8: PhysicalShape vs PhysicalModel ===');

  final comparisonWidget = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'PhysicalShape vs PhysicalModel',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PhysicalModel supports only rounded rectangles and circles. '
          'PhysicalShape accepts ANY CustomClipper<Path>, enabling '
          'stars, bevels, continuous curves, and custom drawn paths.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // PhysicalModel — limited shapes
            Column(
              children: [
                PhysicalModel(
                  elevation: 6.0,
                  color: Colors.deepPurple.shade100,
                  shadowColor: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: 110.0,
                    height: 80.0,
                    alignment: Alignment.center,
                    child: Text(
                      'PhysicalModel',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Rounded rect only',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.deepPurple.shade600,
                    ),
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward, color: Colors.grey, size: 20.0),
            // PhysicalShape — any path
            Column(
              children: [
                PhysicalShape(
                  clipper: ShapeBorderClipper(
                    shape: StarBorder(
                      points: 5,
                      innerRadiusRatio: 0.5,
                    ),
                  ),
                  elevation: 6.0,
                  color: Colors.amber.shade100,
                  shadowColor: Colors.amber.shade400,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    alignment: Alignment.center,
                    child: Text(
                      'Physical\nShape',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Any custom path!',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When to use which:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• PhysicalModel: Simple cards with border radius\n'
                '• PhysicalShape: Custom shapes, stars, bevels, wave edges\n'
                '• Both support elevation and shadows\n'
                '• PhysicalShape needs a CustomClipper<Path> (clipper)',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final Assembly
  // ============================================================
  print('=== Assembling final layout ===');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade800, Colors.indigo.shade500],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PhysicalShape',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Clips child to a custom path with elevation and shadows. '
                'Like PhysicalModel but accepts any CustomClipper<Path> '
                'instead of only rounded rectangles or circles.',
                style: TextStyle(fontSize: 13.0, color: Colors.indigo.shade100),
              ),
            ],
          ),
        ),
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        comparisonWidget,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildStatPill(String label, String value, MaterialColor color) {
  return PhysicalShape(
    clipper: ShapeBorderClipper(shape: StadiumBorder()),
    elevation: 2.0,
    color: color.shade50,
    shadowColor: color.shade200,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 9.0, color: color.shade500),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDashMetric(String label, String value, IconData icon, Color color) {
  return PhysicalShape(
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    elevation: 3.0,
    color: Color(0xFF303F9F),
    shadowColor: Colors.black,
    child: Container(
      width: 85.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 9.0, color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBar(String day, double fraction, Color color) {
  final maxHeight = 60.0;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 24.0,
        height: maxHeight * fraction,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
        ),
      ),
      SizedBox(height: 4.0),
      Text(
        day,
        style: TextStyle(
          fontSize: 9.0,
          color: Colors.white54,
        ),
      ),
    ],
  );
}
