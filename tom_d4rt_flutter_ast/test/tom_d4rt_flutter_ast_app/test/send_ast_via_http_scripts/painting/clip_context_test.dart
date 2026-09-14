// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipContext mixin for clipping paths and rects
import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildClipRectDemo(String title, Clip clipBehavior, Color color) {
  print('Building ClipRect demo: $title with $clipBehavior');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(150)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        ClipRect(
          clipBehavior: clipBehavior,
          child: Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withAlpha(200), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -20,
                  top: -20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(80),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -30,
                  bottom: -30,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(60),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    clipBehavior.toString().split('.').last,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'ClipBehavior: ${clipBehavior.toString()}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildClipRectSection() {
  print('Building ClipRect section');
  List<Widget> demos = [];
  
  demos.add(buildClipRectDemo(
    'Hard Edge Clipping',
    Clip.hardEdge,
    Colors.blue,
  ));
  
  demos.add(buildClipRectDemo(
    'Anti-Alias Clipping',
    Clip.antiAlias,
    Colors.green,
  ));
  
  demos.add(buildClipRectDemo(
    'Anti-Alias With Save Layer',
    Clip.antiAliasWithSaveLayer,
    Colors.orange,
  ));
  
  demos.add(buildClipRectDemo(
    'No Clipping',
    Clip.none,
    Colors.purple,
  ));

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipRect Widget Examples',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Clips child to rectangular bounds with various behaviors',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: demos),
      ],
    ),
  );
}

Widget buildClipPathDemo(
  String title,
  Path Function(Size size) pathBuilder,
  Color color,
  String description,
) {
  print('Building ClipPath demo: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(150)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: color, size: 22),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: ClipPath(
            clipper: _CustomPathClipper(pathBuilder),
            child: Container(
              width: 160,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha(180), color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  'Clipped',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

class _CustomPathClipper extends CustomClipper<Path> {
  Path Function(Size size) pathBuilder;
  
  _CustomPathClipper(this.pathBuilder);
  
  @override
  Path getClip(Size size) {
    return pathBuilder(size);
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Path buildTrianglePath(Size size) {
  Path path = Path();
  path.moveTo(size.width / 2, 0);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.close();
  return path;
}

Path buildStarPath(Size size) {
  Path path = Path();
  double centerX = size.width / 2;
  double centerY = size.height / 2;
  double outerRadius = size.width / 2.2;
  double innerRadius = outerRadius * 0.4;
  int points = 5;
  
  int i = 0;
  for (i = 0; i < points * 2; i = i + 1) {
    double radius = (i % 2 == 0) ? outerRadius : innerRadius;
    double angle = (i * math.pi / points) - (math.pi / 2);
    double x = centerX + radius * math.cos(angle);
    double y = centerY + radius * math.sin(angle);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }
  path.close();
  return path;
}

Path buildHexagonPath(Size size) {
  Path path = Path();
  double centerX = size.width / 2;
  double centerY = size.height / 2;
  double radius = size.width / 2.5;
  int sides = 6;
  
  int i = 0;
  for (i = 0; i < sides; i = i + 1) {
    double angle = (i * 2 * math.pi / sides) - (math.pi / 2);
    double x = centerX + radius * math.cos(angle);
    double y = centerY + radius * math.sin(angle);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }
  path.close();
  return path;
}

Path buildWavePath(Size size) {
  Path path = Path();
  path.moveTo(0, size.height * 0.3);
  path.quadraticBezierTo(
    size.width * 0.25,
    0,
    size.width * 0.5,
    size.height * 0.3,
  );
  path.quadraticBezierTo(
    size.width * 0.75,
    size.height * 0.6,
    size.width,
    size.height * 0.3,
  );
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.close();
  return path;
}

Widget buildClipPathSection() {
  print('Building ClipPath section');
  
  List<Widget> pathDemos = [];
  
  pathDemos.add(buildClipPathDemo(
    'Triangle Clip',
    buildTrianglePath,
    Colors.teal,
    'Uses moveTo and lineTo to create triangle path',
  ));
  
  pathDemos.add(buildClipPathDemo(
    'Star Clip',
    buildStarPath,
    Colors.amber,
    'Alternating outer/inner points with angle calculations',
  ));
  
  pathDemos.add(buildClipPathDemo(
    'Hexagon Clip',
    buildHexagonPath,
    Colors.indigo,
    'Regular hexagon using polar coordinates',
  ));
  
  pathDemos.add(buildClipPathDemo(
    'Wave Clip',
    buildWavePath,
    Colors.pink,
    'Quadratic bezier curves creating wave effect',
  ));
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipPath Widget Examples',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Clips child to arbitrary path shapes using CustomClipper',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: pathDemos),
      ],
    ),
  );
}

Widget buildClipRRectDemo(
  String title,
  BorderRadius borderRadius,
  Color color,
) {
  print('Building ClipRRect demo: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(150)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color.withAlpha(100),
                borderRadius: borderRadius,
                border: Border.all(color: color, width: 2),
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              width: 180,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Rounded',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          borderRadius.toString(),
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget buildClipRRectSection() {
  print('Building ClipRRect section');
  
  List<Widget> rrectDemos = [];
  
  rrectDemos.add(buildClipRRectDemo(
    'Uniform Radius',
    BorderRadius.circular(20),
    Colors.blue,
  ));
  
  rrectDemos.add(buildClipRRectDemo(
    'Top Corners Only',
    BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
    Colors.green,
  ));
  
  rrectDemos.add(buildClipRRectDemo(
    'Diagonal Corners',
    BorderRadius.only(
      topLeft: Radius.circular(40),
      bottomRight: Radius.circular(40),
    ),
    Colors.orange,
  ));
  
  rrectDemos.add(buildClipRRectDemo(
    'Elliptical Radius',
    BorderRadius.all(Radius.elliptical(30, 15)),
    Colors.purple,
  ));
  
  rrectDemos.add(buildClipRRectDemo(
    'Stadium Shape',
    BorderRadius.circular(45),
    Colors.red,
  ));
  
  rrectDemos.add(buildClipRRectDemo(
    'Mixed Corners',
    BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(10),
    ),
    Colors.cyan,
  ));

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipRRect Widget Examples',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Clips child to rounded rectangle with configurable corners',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: rrectDemos),
      ],
    ),
  );
}

Widget buildClipOvalDemo(String title, double width, double height, Color color) {
  print('Building ClipOval demo: $title');
  double aspectRatio = width / height;
  String shapeDesc = '';
  if (aspectRatio == 1.0) {
    shapeDesc = 'Circle';
  } else if (aspectRatio > 1.0) {
    shapeDesc = 'Horizontal Ellipse';
  } else {
    shapeDesc = 'Vertical Ellipse';
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(150)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle_outlined, color: color, size: 22),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                shapeDesc,
                style: TextStyle(fontSize: 11, color: color),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: ClipOval(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [color.withAlpha(220), color],
                  center: Alignment(-0.3, -0.3),
                  radius: 1.2,
                ),
              ),
              child: Center(
                child: Text(
                  '${width.toInt()}x${height.toInt()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aspect: ${aspectRatio.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildClipOvalSection() {
  print('Building ClipOval section');
  
  List<Widget> ovalDemos = [];
  
  ovalDemos.add(buildClipOvalDemo(
    'Perfect Circle',
    100,
    100,
    Colors.indigo,
  ));
  
  ovalDemos.add(buildClipOvalDemo(
    'Wide Ellipse',
    160,
    80,
    Colors.teal,
  ));
  
  ovalDemos.add(buildClipOvalDemo(
    'Tall Ellipse',
    80,
    120,
    Colors.deepOrange,
  ));
  
  ovalDemos.add(buildClipOvalDemo(
    'Small Circle',
    60,
    60,
    Colors.pink,
  ));
  
  ovalDemos.add(buildClipOvalDemo(
    'Extreme Wide',
    180,
    50,
    Colors.blue,
  ));

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipOval Widget Examples',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Clips child to ellipse inscribed in bounding box',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: ovalDemos),
      ],
    ),
  );
}

Widget buildClipBehaviorCard(
  String name,
  String description,
  IconData icon,
  Color color,
  int performanceRating,
  int qualityRating,
) {
  print('Building clip behavior card: $name');
  
  List<Widget> perfStars = [];
  List<Widget> qualStars = [];
  int p = 0;
  int q = 0;
  
  for (p = 0; p < 5; p = p + 1) {
    if (p < performanceRating) {
      perfStars.add(Icon(Icons.star, size: 14, color: Colors.amber));
    } else {
      perfStars.add(Icon(Icons.star_border, size: 14, color: Colors.grey));
    }
  }
  
  for (q = 0; q < 5; q = q + 1) {
    if (q < qualityRating) {
      qualStars.add(Icon(Icons.star, size: 14, color: Colors.green));
    } else {
      qualStars.add(Icon(Icons.star_border, size: 14, color: Colors.grey));
    }
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(30),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withAlpha(40),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Clip.$name',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Performance: ',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Row(children: perfStars),
            SizedBox(width: 16),
            Text(
              'Quality: ',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Row(children: qualStars),
          ],
        ),
      ],
    ),
  );
}

Widget buildClipBehaviorsSection() {
  print('Building clip behaviors section');
  
  List<Widget> behaviorCards = [];
  
  behaviorCards.add(buildClipBehaviorCard(
    'none',
    'No clipping at all. Content can overflow bounds freely. Use when overflow is handled elsewhere or not possible.',
    Icons.crop_free,
    Colors.grey,
    5,
    1,
  ));
  
  behaviorCards.add(buildClipBehaviorCard(
    'hardEdge',
    'Fast clipping with aliased edges. Best for rectangular clips where jagged edges are acceptable.',
    Icons.crop_square,
    Colors.blue,
    4,
    2,
  ));
  
  behaviorCards.add(buildClipBehaviorCard(
    'antiAlias',
    'Smooth anti-aliased edges. Good balance of quality and performance for rounded shapes.',
    Icons.blur_on,
    Colors.green,
    3,
    4,
  ));
  
  behaviorCards.add(buildClipBehaviorCard(
    'antiAliasWithSaveLayer',
    'Highest quality with save layer. Required for proper alpha blending but most expensive.',
    Icons.layers,
    Colors.purple,
    1,
    5,
  ));

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Colors.deepPurple, size: 24),
            SizedBox(width: 8),
            Text(
              'Clip Behavior Comparison',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Performance vs quality trade-offs for each clip mode',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: behaviorCards),
      ],
    ),
  );
}

Widget buildPushPopLayerDemo() {
  print('Building push/pop layer demo');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, color: Colors.deepPurple, size: 24),
            SizedBox(width: 8),
            Text(
              'Push/Pop Clip Layers',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Canvas save/restore pattern for nested clipping regions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildLayerStackVisualization(),
        SizedBox(height: 16),
        _buildLayerExplanation(),
      ],
    ),
  );
}

Widget _buildLayerStackVisualization() {
  print('Building layer stack visualization');
  
  List<Map<String, dynamic>> layers = [
    {'name': 'Root Canvas', 'color': Colors.grey.shade300, 'indent': 0},
    {'name': 'ClipRect (outer)', 'color': Colors.blue.shade100, 'indent': 1},
    {'name': 'ClipRRect (middle)', 'color': Colors.green.shade100, 'indent': 2},
    {'name': 'ClipOval (inner)', 'color': Colors.orange.shade100, 'indent': 3},
    {'name': 'Content Paint', 'color': Colors.purple.shade100, 'indent': 4},
  ];
  
  List<Widget> layerWidgets = [];
  int i = 0;
  for (i = 0; i < layers.length; i = i + 1) {
    Map<String, dynamic> layer = layers[i];
    int indent = layer['indent'] as int;
    Color color = layer['color'] as Color;
    String name = layer['name'] as String;
    
    layerWidgets.add(
      Container(
        margin: EdgeInsets.only(left: indent * 20.0, top: 4, bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${i + 1}.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(width: 8),
            Icon(
              i < layers.length - 1 ? Icons.arrow_downward : Icons.brush,
              size: 14,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layer Stack (Push Order)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: layerWidgets,
        ),
      ],
    ),
  );
}

Widget _buildLayerExplanation() {
  print('Building layer explanation');
  
  List<Map<String, String>> steps = [
    {
      'step': 'canvas.save()',
      'desc': 'Saves current canvas state before clipping',
    },
    {
      'step': 'canvas.clipRect/Path/RRect',
      'desc': 'Applies the clipping region to canvas',
    },
    {
      'step': 'paint operations',
      'desc': 'Draw content within clipped area',
    },
    {
      'step': 'canvas.restore()',
      'desc': 'Restores previous canvas state, removes clip',
    },
  ];
  
  List<Widget> stepWidgets = [];
  int s = 0;
  for (s = 0; s < steps.length; s = s + 1) {
    Map<String, String> step = steps[s];
    stepWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${s + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['step']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    step['desc']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipContext Pattern',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget buildNestedClipDemo() {
  print('Building nested clip demo');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested Clipping Example',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue.shade100,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 20,
                    child: ClipOval(
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.green.shade200,
                        child: Center(
                          child: ClipRect(
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.orange.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: ClipPath(
                      clipper: _CustomPathClipper(buildTrianglePath),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.purple.shade200,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.red.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Multiple nested clip widgets demonstrating layer composition',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildClipUsageTable() {
  print('Building clip usage table');
  
  List<Map<String, String>> usages = [
    {
      'widget': 'ClipRect',
      'use': 'Rectangular overflow control',
      'example': 'Images, containers',
    },
    {
      'widget': 'ClipRRect',
      'use': 'Rounded corners',
      'example': 'Cards, avatars, buttons',
    },
    {
      'widget': 'ClipOval',
      'use': 'Circular/elliptical shapes',
      'example': 'Profile pictures, badges',
    },
    {
      'widget': 'ClipPath',
      'use': 'Custom shapes',
      'example': 'Waves, stars, polygons',
    },
  ];
  
  List<Widget> rows = [];
  int u = 0;
  for (u = 0; u < usages.length; u = u + 1) {
    Map<String, String> usage = usages[u];
    Color rowColor = u % 2 == 0 ? Colors.grey.shade50 : Colors.white;
    
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        color: rowColor,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                usage['widget']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                usage['use']!,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                usage['example']!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Widget',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Primary Use',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Examples',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildClipContextOverview() {
  print('Building ClipContext overview');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.content_cut, color: Colors.deepPurple, size: 28),
            SizedBox(width: 10),
            Text(
              'ClipContext Mixin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'A mixin that provides helper methods for clipping content during painting operations. Used by render objects to manage save/restore canvas state and apply various clip shapes.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFeatureChip('Canvas Management', Icons.layers),
            _buildFeatureChip('Path Clipping', Icons.architecture),
            _buildFeatureChip('RRect Clipping', Icons.rounded_corner),
            _buildFeatureChip('Rect Clipping', Icons.crop_square),
            _buildFeatureChip('Save/Restore', Icons.save),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeatureChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.deepPurple),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.deepPurple.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget buildClipMethodsReference() {
  print('Building clip methods reference');
  
  List<Map<String, String>> methods = [
    {
      'name': 'clipPathAndPaint',
      'params': 'Path, Clip, Rect, VoidCallback',
      'desc': 'Clips to arbitrary path then invokes painter callback',
    },
    {
      'name': 'clipRRectAndPaint',
      'params': 'RRect, Clip, Rect, VoidCallback',
      'desc': 'Clips to rounded rectangle then invokes painter callback',
    },
    {
      'name': 'clipRectAndPaint',
      'params': 'Rect, Clip, Rect, VoidCallback',
      'desc': 'Clips to rectangle then invokes painter callback',
    },
  ];
  
  List<Widget> methodCards = [];
  int m = 0;
  for (m = 0; m < methods.length; m = m + 1) {
    Map<String, String> method = methods[m];
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              method['name']!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Parameters: ${method['params']}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 6),
            Text(
              method['desc']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ClipContext Methods',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Core methods provided by the ClipContext mixin',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: methodCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ClipContext deep demo test executing');
  print('Testing clipping paths and rects functionality');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildClipContextOverview(),
        
        buildSectionHeader('ClipRect Examples'),
        buildClipRectSection(),
        
        buildSectionHeader('ClipPath Examples'),
        buildClipPathSection(),
        
        buildSectionHeader('ClipRRect Examples'),
        buildClipRRectSection(),
        
        buildSectionHeader('ClipOval Examples'),
        buildClipOvalSection(),
        
        buildSectionHeader('Push/Pop Clip Layers'),
        buildPushPopLayerDemo(),
        buildNestedClipDemo(),
        
        buildSectionHeader('Clip Behaviors'),
        buildClipBehaviorsSection(),
        
        buildSectionHeader('Quick Reference'),
        buildClipUsageTable(),
        buildClipMethodsReference(),
        
        SizedBox(height: 24),
        Center(
          child: Text(
            'ClipContext Demo Complete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
