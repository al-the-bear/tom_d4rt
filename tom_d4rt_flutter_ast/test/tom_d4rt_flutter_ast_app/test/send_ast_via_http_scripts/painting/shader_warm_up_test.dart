// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShaderWarmUp from painting
import 'package:flutter/material.dart';

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

Widget buildConceptCard(String title, String description, IconData icon, Color color) {
  print('Building concept card: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildShaderJankExplainer() {
  print('Building shader jank explainer section');
  List<Map<String, dynamic>> jankSteps = [
    {
      'step': '1',
      'title': 'First Animation Frame',
      'desc': 'User triggers animation (scroll, transition, etc.)',
      'icon': Icons.touch_app,
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'GPU Shader Required',
      'desc': 'Flutter needs a shader to draw the effect',
      'icon': Icons.memory,
      'color': Colors.orange,
    },
    {
      'step': '3',
      'title': 'Shader Compilation',
      'desc': 'GPU compiles shader code on-the-fly (expensive)',
      'icon': Icons.settings,
      'color': Colors.red,
    },
    {
      'step': '4',
      'title': 'Frame Drop (Jank)',
      'desc': 'Compilation takes too long, frame is missed',
      'icon': Icons.warning,
      'color': Colors.deepOrange,
    },
  ];

  List<Widget> stepWidgets = [];
  int i = 0;
  for (i = 0; i < jankSteps.length; i = i + 1) {
    Map<String, dynamic> step = jankSteps[i];
    stepWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: (step['color'] as Color).withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (step['color'] as Color).withAlpha(60),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: step['color'] as Color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step['step'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: step['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              step['icon'] as IconData,
              color: (step['color'] as Color).withAlpha(180),
              size: 24,
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How Shader Jank Happens',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Understanding the problem that ShaderWarmUp solves',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget buildWarmUpSolutionExplainer() {
  print('Building warm-up solution explainer');
  List<Map<String, dynamic>> solutionSteps = [
    {
      'step': '1',
      'title': 'App Startup',
      'desc': 'ShaderWarmUp runs before main UI loads',
      'icon': Icons.rocket_launch,
      'color': Colors.green,
    },
    {
      'step': '2',
      'title': 'Draw to Hidden Canvas',
      'desc': 'warmUpOnCanvas draws shapes user cannot see',
      'icon': Icons.brush,
      'color': Colors.teal,
    },
    {
      'step': '3',
      'title': 'Shaders Compiled',
      'desc': 'GPU compiles all needed shaders during splash',
      'icon': Icons.check_circle,
      'color': Colors.blue,
    },
    {
      'step': '4',
      'title': 'Smooth Animations',
      'desc': 'Shaders ready when user interacts - no jank',
      'icon': Icons.speed,
      'color': Colors.purple,
    },
  ];

  List<Widget> solutionWidgets = [];
  int s = 0;
  for (s = 0; s < solutionSteps.length; s = s + 1) {
    Map<String, dynamic> item = solutionSteps[s];
    solutionWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (item['color'] as Color).withAlpha(20),
              (item['color'] as Color).withAlpha(8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (item['color'] as Color).withAlpha(80),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    item['color'] as Color,
                    (item['color'] as Color).withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.white,
                size: 22,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item['color'] as Color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Step ${item['step']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    item['desc'] as String,
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
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.green.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'ShaderWarmUp Solution',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Pre-compile shaders during startup to eliminate jank',
          style: TextStyle(fontSize: 12, color: Colors.green.shade700),
        ),
        SizedBox(height: 12),
        Column(children: solutionWidgets),
      ],
    ),
  );
}

Widget buildAbstractClassExplainer() {
  print('Building abstract class explainer');
  List<Map<String, String>> classMembers = [
    {
      'member': 'Size get size',
      'type': 'Property',
      'desc': 'The size of the rectangle used for warm-up canvas',
    },
    {
      'member': 'Future<void> warmUpOnCanvas(Canvas canvas)',
      'type': 'Abstract Method',
      'desc': 'Override this to draw shapes that trigger shader compilation',
    },
    {
      'member': 'Future<void> warmUp()',
      'type': 'Concrete Method',
      'desc': 'Called at startup - creates PictureRecorder and invokes warmUpOnCanvas',
    },
  ];

  List<Widget> memberCards = [];
  int m = 0;
  for (m = 0; m < classMembers.length; m = m + 1) {
    Map<String, String> member = classMembers[m];
    Color typeColor = Colors.blue;
    if (member['type'] == 'Abstract Method') {
      typeColor = Colors.deepPurple;
    } else if (member['type'] == 'Concrete Method') {
      typeColor = Colors.teal;
    }

    memberCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: typeColor.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: typeColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    member['type']!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: typeColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                member['member']!,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              member['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'abstract',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'ShaderWarmUp',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Abstract base class for shader warm-up implementations',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14),
        Column(children: memberCards),
      ],
    ),
  );
}

Widget buildSizePropertyDemo() {
  print('Building size property demo');
  List<Map<String, dynamic>> sizeExamples = [
    {'width': 100.0, 'height': 100.0, 'label': 'Small Canvas', 'color': Colors.green},
    {'width': 256.0, 'height': 256.0, 'label': 'Default Size', 'color': Colors.blue},
    {'width': 512.0, 'height': 512.0, 'label': 'Large Canvas', 'color': Colors.orange},
    {'width': 1024.0, 'height': 768.0, 'label': 'Full Screen', 'color': Colors.purple},
  ];

  List<Widget> sizeCards = [];
  int s = 0;
  for (s = 0; s < sizeExamples.length; s = s + 1) {
    Map<String, dynamic> example = sizeExamples[s];
    double w = example['width'] as double;
    double h = example['height'] as double;
    Color c = example['color'] as Color;
    String label = example['label'] as String;

    double displayScale = 0.15;
    double displayW = w * displayScale;
    double displayH = h * displayScale;

    sizeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: displayW,
              height: displayH,
              decoration: BoxDecoration(
                color: c.withAlpha(50),
                border: Border.all(color: c, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(Icons.aspect_ratio, color: c, size: 20),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Size(${w.toInt()}, ${h.toInt()})',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${(w * h / 1000).toStringAsFixed(1)}K pixels',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${w.toInt()}x${h.toInt()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.photo_size_select_large, color: Colors.indigo, size: 24),
            SizedBox(width: 10),
            Text(
              'Size Property',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Canvas size used during shader warm-up',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Default value is Size(100.0, 100.0). Override to use a larger canvas for more complex warm-up patterns.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Column(children: sizeCards),
      ],
    ),
  );
}

Widget buildWarmUpOnCanvasDemo() {
  print('Building warmUpOnCanvas method demo');
  List<Map<String, dynamic>> drawOperations = [
    {
      'operation': 'drawRect',
      'desc': 'Rectangles and squares',
      'shader': 'Rect shader',
      'icon': Icons.rectangle,
      'color': Colors.blue,
    },
    {
      'operation': 'drawCircle',
      'desc': 'Circles and bubbles',
      'shader': 'Circle shader',
      'icon': Icons.circle,
      'color': Colors.red,
    },
    {
      'operation': 'drawRRect',
      'desc': 'Rounded rectangles',
      'shader': 'RRect shader',
      'icon': Icons.rounded_corner,
      'color': Colors.green,
    },
    {
      'operation': 'drawLine',
      'desc': 'Lines and strokes',
      'shader': 'Line shader',
      'icon': Icons.horizontal_rule,
      'color': Colors.orange,
    },
    {
      'operation': 'drawPath',
      'desc': 'Custom shapes',
      'shader': 'Path shader',
      'icon': Icons.gesture,
      'color': Colors.purple,
    },
    {
      'operation': 'drawShadow',
      'desc': 'Elevation shadows',
      'shader': 'Shadow shader',
      'icon': Icons.blur_on,
      'color': Colors.grey,
    },
  ];

  List<Widget> operationCards = [];
  int o = 0;
  for (o = 0; o < drawOperations.length; o = o + 1) {
    Map<String, dynamic> op = drawOperations[o];
    Color opColor = op['color'] as Color;

    operationCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: opColor.withAlpha(12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: opColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: opColor.withAlpha(40),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(op['icon'] as IconData, color: opColor, size: 24),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'canvas.${op['operation']}()',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: opColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    op['desc'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: opColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                op['shader'] as String,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: opColor,
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
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Colors.teal, size: 24),
            SizedBox(width: 10),
            Text(
              'warmUpOnCanvas Method',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Draw operations to pre-compile GPU shaders',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: operationCards),
      ],
    ),
  );
}

Widget buildDefaultShaderWarmUpDemo() {
  print('Building DefaultShaderWarmUp demo');
  List<Map<String, dynamic>> defaultOperations = [
    {'shape': 'Gradient Rectangle', 'count': 1, 'color': Colors.red},
    {'shape': 'Gradient Circle', 'count': 1, 'color': Colors.green},
    {'shape': 'Rounded Rectangle', 'count': 1, 'color': Colors.blue},
    {'shape': 'Triangle Path', 'count': 1, 'color': Colors.orange},
  ];

  List<Widget> operationItems = [];
  int d = 0;
  for (d = 0; d < defaultOperations.length; d = d + 1) {
    Map<String, dynamic> op = defaultOperations[d];
    operationItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: (op['color'] as Color).withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (op['color'] as Color).withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: op['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                op['shape'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Text(
              'x${op['count']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
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
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'class',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'DefaultShaderWarmUp',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Built-in implementation that warms up common shaders',
          style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Default Warm-Up Operations:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Column(children: operationItems),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Suitable for most Flutter applications out of the box',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCustomWarmUpPatternsDemo() {
  print('Building custom warm-up patterns demo');
  List<Map<String, dynamic>> patterns = [
    {
      'name': 'Animation-Heavy App',
      'desc': 'Add curve paths and transforms',
      'operations': ['drawPath', 'transform', 'clipPath'],
      'icon': Icons.animation,
      'color': Colors.purple,
    },
    {
      'name': 'Image-Rich App',
      'desc': 'Include image decode shaders',
      'operations': ['drawImage', 'drawImageRect', 'drawImageNine'],
      'icon': Icons.image,
      'color': Colors.indigo,
    },
    {
      'name': 'Games',
      'desc': 'Particle effects and blending',
      'operations': ['drawPoints', 'saveLayer', 'blendMode'],
      'icon': Icons.games,
      'color': Colors.red,
    },
    {
      'name': 'Data Visualization',
      'desc': 'Charts and graph elements',
      'operations': ['drawArc', 'drawOval', 'gradient'],
      'icon': Icons.bar_chart,
      'color': Colors.teal,
    },
  ];

  List<Widget> patternCards = [];
  int p = 0;
  for (p = 0; p < patterns.length; p = p + 1) {
    Map<String, dynamic> pattern = patterns[p];
    Color patternColor = pattern['color'] as Color;
    List<String> ops = pattern['operations'] as List<String>;

    List<Widget> opChips = [];
    int oi = 0;
    for (oi = 0; oi < ops.length; oi = oi + 1) {
      opChips.add(
        Container(
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: patternColor.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            ops[oi],
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: patternColor,
            ),
          ),
        ),
      );
    }

    patternCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: patternColor.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: patternColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(pattern['icon'] as IconData, color: patternColor, size: 22),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pattern['name'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: patternColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        pattern['desc'] as String,
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
            SizedBox(height: 10),
            Wrap(children: opChips),
          ],
        ),
      ),
    );
  }

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
        Row(
          children: [
            Icon(Icons.tune, color: Colors.deepOrange, size: 24),
            SizedBox(width: 10),
            Text(
              'Custom Warm-Up Patterns',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Tailor warm-up to your app\'s specific needs',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: patternCards),
      ],
    ),
  );
}

Widget buildUsageCodeExample() {
  print('Building usage code example');
  String codeExample = '''
class MyCustomShaderWarmUp extends ShaderWarmUp {
  @override
  Size get size => Size(256.0, 256.0);

  @override
  Future<void> warmUpOnCanvas(ui.Canvas canvas) async {
    // Draw shapes your app uses
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    // Rectangles with gradients
    paint.shader = LinearGradient(
      colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    ).createShader(Rect.fromLTWH(0, 0, 100, 100));
    canvas.drawRect(Rect.fromLTWH(0, 0, 100, 100), paint);

    // Circles
    paint.shader = null;
    paint.color = Color(0xFF00FF00);
    canvas.drawCircle(Offset(150, 150), 50, paint);

    // Rounded rectangles (common in Material)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 100, 100, 50),
        Radius.circular(10),
      ),
      paint,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyCustomShaderWarmUp().warmUp();
  runApp(MyApp());
}''';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan, size: 22),
            SizedBox(width: 10),
            Text(
              'Implementation Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.cyan.withAlpha(40),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Dart',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            codeExample,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.green.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBestPracticesSection() {
  print('Building best practices section');
  List<Map<String, dynamic>> practices = [
    {
      'title': 'Profile First',
      'desc': 'Use DevTools timeline to identify which shaders cause jank',
      'icon': Icons.speed,
      'color': Colors.blue,
    },
    {
      'title': 'Minimize Warm-Up Time',
      'desc': 'Only warm up shaders you actually use - avoid unnecessary work',
      'icon': Icons.timer,
      'color': Colors.orange,
    },
    {
      'title': 'Run During Splash',
      'desc': 'Execute warmUp() while splash screen is visible',
      'icon': Icons.launch,
      'color': Colors.green,
    },
    {
      'title': 'Test on Release Builds',
      'desc': 'Shader compilation only happens in release mode',
      'icon': Icons.build,
      'color': Colors.purple,
    },
    {
      'title': 'Consider Skia vs Impeller',
      'desc': 'Impeller pre-compiles shaders - may not need warm-up',
      'icon': Icons.auto_awesome,
      'color': Colors.teal,
    },
  ];

  List<Widget> practiceCards = [];
  int b = 0;
  for (b = 0; b < practices.length; b = b + 1) {
    Map<String, dynamic> practice = practices[b];
    Color pColor = practice['color'] as Color;

    practiceCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: pColor.withAlpha(12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: pColor.withAlpha(50)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: pColor.withAlpha(40),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(practice['icon'] as IconData, color: pColor, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    practice['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    practice['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
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
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Best Practices',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Tips for effective shader warm-up',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: practiceCards),
      ],
    ),
  );
}

Widget buildImpellerNote() {
  print('Building Impeller note');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.cyan.shade50,
          Colors.blue.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.auto_awesome, color: Colors.white, size: 26),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Impeller Rendering Engine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'The future of Flutter rendering',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.cyan.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(180),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impeller pre-compiles all shaders at build time, eliminating runtime shader compilation jank entirely.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.check, color: Colors.green, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Default on iOS',
                    style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.check, color: Colors.green, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Default on Android',
                    style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'ShaderWarmUp may not be needed with Impeller enabled.',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildWarmUpTimingSection() {
  print('Building warm-up timing section');
  List<Map<String, dynamic>> timingPhases = [
    {
      'phase': 'Pre-runApp',
      'timing': '0-500ms',
      'action': 'WidgetsFlutterBinding.ensureInitialized()',
      'color': Colors.blue,
    },
    {
      'phase': 'Warm-Up',
      'timing': '500-800ms',
      'action': 'await CustomShaderWarmUp().warmUp()',
      'color': Colors.orange,
    },
    {
      'phase': 'App Start',
      'timing': '800ms+',
      'action': 'runApp(MyApp())',
      'color': Colors.green,
    },
  ];

  List<Widget> phaseWidgets = [];
  int t = 0;
  for (t = 0; t < timingPhases.length; t = t + 1) {
    Map<String, dynamic> phase = timingPhases[t];
    Color c = phase['color'] as Color;
    bool isLast = t == timingPhases.length - 1;

    phaseWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${t + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          SizedBox(width: 14),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: c.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: c.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        phase['phase'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: c,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: c.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          phase['timing'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: c,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      phase['action'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        Row(
          children: [
            Icon(Icons.schedule, color: Colors.indigo, size: 24),
            SizedBox(width: 10),
            Text(
              'Warm-Up Timing',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'When to execute shader warm-up in app lifecycle',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14),
        Column(children: phaseWidgets),
      ],
    ),
  );
}

Widget buildSummaryStats() {
  print('Building summary stats');
  List<Map<String, dynamic>> stats = [
    {'label': 'Abstract Class', 'value': 'ShaderWarmUp', 'icon': Icons.category, 'color': Colors.deepPurple},
    {'label': 'Default Impl', 'value': 'DefaultShaderWarmUp', 'icon': Icons.check_box, 'color': Colors.blue},
    {'label': 'Key Method', 'value': 'warmUpOnCanvas()', 'icon': Icons.brush, 'color': Colors.teal},
    {'label': 'Default Size', 'value': '100x100', 'icon': Icons.aspect_ratio, 'color': Colors.orange},
  ];

  List<Widget> statCards = [];
  int i = 0;
  for (i = 0; i < stats.length; i = i + 1) {
    Map<String, dynamic> stat = stats[i];
    Color c = stat['color'] as Color;
    statCards.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: c.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.withAlpha(60)),
          ),
          child: Column(
            children: [
              Icon(stat['icon'] as IconData, color: c, size: 28),
              SizedBox(height: 8),
              Text(
                stat['value'] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: c,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                stat['label'] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Row(children: statCards),
  );
}

dynamic build(BuildContext context) {
  print('ShaderWarmUp comprehensive test executing');
  print('Purpose: Pre-compile GPU shaders to avoid first-frame jank');
  print('Location: flutter/painting/shader_warm_up.dart');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('ShaderWarmUp - Pre-compile Shaders'),
        buildSummaryStats(),

        buildConceptCard(
          'What is Shader Jank?',
          'When Flutter draws complex graphics for the first time, the GPU must compile shader programs. This compilation can take 10-200ms, causing visible frame drops (stuttering). ShaderWarmUp prevents this by pre-compiling shaders during app startup.',
          Icons.warning_amber,
          Colors.orange,
        ),

        buildSectionHeader('The Problem: Shader Compilation Jank'),
        buildShaderJankExplainer(),

        buildSectionHeader('The Solution: ShaderWarmUp'),
        buildWarmUpSolutionExplainer(),

        buildSectionHeader('ShaderWarmUp Abstract Class'),
        buildAbstractClassExplainer(),

        buildSectionHeader('Size Property'),
        buildSizePropertyDemo(),

        buildSectionHeader('warmUpOnCanvas Method'),
        buildWarmUpOnCanvasDemo(),

        buildSectionHeader('DefaultShaderWarmUp Subclass'),
        buildDefaultShaderWarmUpDemo(),

        buildSectionHeader('Custom Shader Warm-Up Patterns'),
        buildCustomWarmUpPatternsDemo(),

        buildSectionHeader('Warm-Up Timing'),
        buildWarmUpTimingSection(),

        buildSectionHeader('Implementation Example'),
        buildUsageCodeExample(),

        buildSectionHeader('Best Practices'),
        buildBestPracticesSection(),

        buildSectionHeader('Impeller Rendering Engine'),
        buildImpellerNote(),

        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ShaderWarmUp Demo Complete',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Covered: abstract class, warmUpOnCanvas, size property, DefaultShaderWarmUp, custom patterns',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
