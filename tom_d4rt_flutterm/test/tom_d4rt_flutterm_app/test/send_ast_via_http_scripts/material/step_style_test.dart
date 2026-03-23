// ignore_for_file: avoid_print
// D4rt test script: Tests StepStyle from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

Widget buildPropertyRow(String name, String description, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accentColor.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.code, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: accentColor.withAlpha(220),
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStepStyleOverview() {
  print('Building StepStyle overview');
  List<String> propNames = [
    'color',
    'gradient',
    'errorColor',
    'connectorColor',
    'connectorThickness',
    'indexStyle',
    'border',
  ];
  List<String> propDescs = [
    'The background color of the step circle when active',
    'Gradient to apply to the step circle',
    'Color shown when the step is in error state',
    'Color of the connector line between steps',
    'The thickness of the connector line',
    'TextStyle for the step index number',
    'Border around the step circle',
  ];
  List<Color> propColors = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.teal,
    Colors.pink,
  ];

  List<Widget> propRows = [];
  int i = 0;
  for (i = 0; i < propNames.length; i = i + 1) {
    propRows.add(buildPropertyRow(propNames[i], propDescs[i], propColors[i]));
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
            Icon(Icons.style, color: Colors.indigo, size: 28),
            SizedBox(width: 12),
            Text(
              'StepStyle Properties',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'StepStyle allows customizing the visual appearance of individual Step '
          'widgets within a Stepper. Each Step can have its own unique style.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Column(children: propRows),
      ],
    ),
  );
}

Widget buildColorSection() {
  print('Building color section');
  List<String> colorNames = [
    'Blue',
    'Green',
    'Orange',
    'Purple',
    'Red',
    'Teal',
  ];
  List<Color> stepColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < colorNames.length; c = c + 1) {
    colorCards.add(
      Container(
        width: 80,
        margin: EdgeInsets.only(right: 8, bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stepColors[c].withAlpha(120)),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: stepColors[c],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${c + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              colorNames[c],
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
            Icon(Icons.palette, color: Colors.blue, size: 24),
            SizedBox(width: 8),
            Text(
              'Step Circle Colors',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The color property sets the background color of the step circle icon.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(children: colorCards),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Use StepStyle(color: Colors.blue) to set the step circle color',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildGradientSection() {
  print('Building gradient section');
  List<String> gradientNames = [
    'Blue to Purple',
    'Green to Teal',
    'Orange to Red',
    'Pink to Purple',
  ];
  List<List<Color>> gradients = [
    [Colors.blue, Colors.purple],
    [Colors.green, Colors.teal],
    [Colors.orange, Colors.red],
    [Colors.pink, Colors.purple],
  ];

  List<Widget> gradientCards = [];
  int g = 0;
  for (g = 0; g < gradientNames.length; g = g + 1) {
    gradientCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: gradients[g],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  '${g + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gradientNames[g],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: gradients[g][0],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: gradients[g][1],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.gradient, color: gradients[g][0], size: 24),
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
            Icon(Icons.gradient, color: Colors.purple, size: 24),
            SizedBox(width: 8),
            Text(
              'Step Circle Gradients',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The gradient property applies a gradient to the step circle, '
          'overriding the solid color when specified.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: gradientCards),
      ],
    ),
  );
}

Widget buildErrorColorSection() {
  print('Building errorColor section');
  List<String> errorLabels = ['Default Red', 'Orange Error', 'Deep Red', 'Pink Alert'];
  List<Color> errorColors = [
    Colors.red,
    Colors.orange.shade700,
    Colors.red.shade900,
    Colors.pink.shade600,
  ];

  List<Widget> errorCards = [];
  int e = 0;
  for (e = 0; e < errorLabels.length; e = e + 1) {
    errorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: errorColors[e].withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: errorColors[e].withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: errorColors[e],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    errorLabels[e],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'StepState.error displays this color',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: errorColors[e],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
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
            Icon(Icons.error, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text(
              'Error Color Customization',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The errorColor property defines the color shown when a step is in '
          'the StepState.error state, indicating validation or process failures.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: errorCards),
      ],
    ),
  );
}

Widget buildConnectorColorSection() {
  print('Building connectorColor section');
  List<String> connectorLabels = [
    'Blue Line',
    'Green Connection',
    'Purple Path',
    'Orange Trail',
  ];
  List<Color> connectorColors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  List<Widget> connectorRows = [];
  int cn = 0;
  for (cn = 0; cn < connectorLabels.length; cn = cn + 1) {
    connectorRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: connectorColors[cn],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${cn + 1}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: connectorColors[cn],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: connectorColors[cn].withAlpha(120),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${cn + 2}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                connectorLabels[cn],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
            Icon(Icons.linear_scale, color: Colors.blue, size: 24),
            SizedBox(width: 8),
            Text(
              'Connector Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The connectorColor sets the color of the line connecting step circles, '
          'creating visual flow between sequential steps.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: connectorRows),
      ],
    ),
  );
}

Widget buildConnectorThicknessSection() {
  print('Building connectorThickness section');
  List<String> thicknessLabels = ['Thin (1px)', 'Normal (2px)', 'Medium (4px)', 'Bold (6px)'];
  List<double> thicknesses = [1.0, 2.0, 4.0, 6.0];

  List<Widget> thicknessRows = [];
  int t = 0;
  for (t = 0; t < thicknessLabels.length; t = t + 1) {
    thicknessRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.circle, color: Colors.white, size: 14),
            ),
            SizedBox(width: 8),
            Container(
              width: 80,
              height: thicknesses[t],
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(thicknesses[t] / 2),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.circle_outlined, color: Colors.white, size: 14),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thicknessLabels[t],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'connectorThickness: ${thicknesses[t]}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
            Icon(Icons.line_weight, color: Colors.indigo, size: 24),
            SizedBox(width: 8),
            Text(
              'Connector Thickness',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Adjust the visual weight of step connectors using connectorThickness.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: thicknessRows),
      ],
    ),
  );
}

Widget buildIndexStyleSection() {
  print('Building indexStyle section');
  List<String> styleNames = ['Default', 'Bold', 'Large', 'Italic', 'Custom Font'];
  List<TextStyle> indexStyles = [
    TextStyle(fontSize: 14, color: Colors.white),
    TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
    TextStyle(fontSize: 12, letterSpacing: 2, color: Colors.white),
  ];
  List<Color> bgColors = [
    Colors.grey,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  List<Widget> styleRows = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColors[s].withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bgColors[s].withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColors[s],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${s + 1}', style: indexStyles[s]),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    styleNames[s],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Custom indexStyle applied to step number',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
            Icon(Icons.format_size, color: Colors.teal, size: 24),
            SizedBox(width: 8),
            Text(
              'Index Style Variations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The indexStyle property controls the TextStyle of the step index number '
          'displayed inside the circle.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: styleRows),
      ],
    ),
  );
}

Widget buildBorderSection() {
  print('Building border section');
  List<String> borderNames = [
    'No Border',
    'Thin Border',
    'Thick Border',
    'Dashed Style',
  ];
  List<Border?> borders = [
    null,
    Border.all(color: Colors.blue, width: 1),
    Border.all(color: Colors.green, width: 3),
    Border.all(color: Colors.purple, width: 2),
  ];
  List<Color> circleColors = [
    Colors.blue,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
  ];

  List<Widget> borderRows = [];
  int b = 0;
  for (b = 0; b < borderNames.length; b = b + 1) {
    borderRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: circleColors[b],
                shape: BoxShape.circle,
                border: borders[b],
              ),
              child: Center(
                child: Text(
                  '${b + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: b == 0 ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    borderNames[b],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    b == 0
                        ? 'Default circle without border'
                        : 'Border width: ${b == 1 ? 1 : (b == 2 ? 3 : 2)}px',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              color: circleColors[b] == Colors.blue ? Colors.blue : Colors.grey.shade400,
              size: 28,
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
            Icon(Icons.crop_square, color: Colors.pink, size: 24),
            SizedBox(width: 8),
            Text(
              'Border Customization',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The border property adds a decorative border around the step circle, '
          'useful for inactive or highlighted states.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: borderRows),
      ],
    ),
  );
}

Widget buildStepperWithStepStyle() {
  print('Building Stepper with StepStyle examples');

  Step createStyledStep(
    String title,
    String subtitle,
    String content,
    StepStyle stepStyle,
    StepState state,
  ) {
    return Step(
      title: Text(title),
      subtitle: Text(subtitle),
      content: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(content),
      ),
      stepStyle: stepStyle,
      state: state,
    );
  }

  StepStyle blueStyle = StepStyle(
    color: Colors.blue,
    connectorColor: Colors.blue.shade300,
    connectorThickness: 2,
    indexStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );

  StepStyle greenStyle = StepStyle(
    color: Colors.green,
    connectorColor: Colors.green.shade300,
    connectorThickness: 3,
    indexStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );

  StepStyle orangeStyle = StepStyle(
    color: Colors.orange,
    connectorColor: Colors.orange.shade300,
    connectorThickness: 2,
    indexStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );

  StepStyle errorStyle = StepStyle(
    color: Colors.grey,
    errorColor: Colors.red,
    connectorColor: Colors.red.shade200,
    connectorThickness: 2,
    indexStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );

  List<Step> styledSteps = [
    createStyledStep(
      'Account Setup',
      'Create your profile',
      'Enter your email and create a secure password for your account.',
      blueStyle,
      StepState.complete,
    ),
    createStyledStep(
      'Verification',
      'Confirm your identity',
      'We will send a verification code to your email address.',
      greenStyle,
      StepState.editing,
    ),
    createStyledStep(
      'Preferences',
      'Customize your experience',
      'Set your notification preferences and display settings.',
      orangeStyle,
      StepState.indexed,
    ),
    createStyledStep(
      'Payment Error',
      'Fix payment details',
      'There was an issue with your payment information.',
      errorStyle,
      StepState.error,
    ),
  ];

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
            Icon(Icons.format_list_numbered, color: Colors.indigo, size: 24),
            SizedBox(width: 8),
            Text(
              'Stepper with Custom StepStyles',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Complete example showing multiple steps with unique StepStyle configurations.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Stepper(
            currentStep: 1,
            steps: styledSteps,
            onStepTapped: (int index) {
              print('Step $index tapped');
            },
            onStepContinue: () {
              print('Continue pressed');
            },
            onStepCancel: () {
              print('Cancel pressed');
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text('Continue'),
                    ),
                    SizedBox(width: 12),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text('Back'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildStepStyleComparison() {
  print('Building StepStyle comparison table');
  List<String> featureNames = [
    'Basic Step (no style)',
    'Colored Step',
    'Gradient Step',
    'Bordered Step',
    'Custom Index',
    'Thick Connector',
    'Error Styled',
    'Full Custom',
  ];
  List<String> configDescs = [
    'Step() with default appearance',
    'stepStyle: StepStyle(color: Colors.blue)',
    'stepStyle: StepStyle(gradient: LinearGradient(...))',
    'stepStyle: StepStyle(border: Border.all(...))',
    'stepStyle: StepStyle(indexStyle: TextStyle(...))',
    'stepStyle: StepStyle(connectorThickness: 4.0)',
    'stepStyle: StepStyle(errorColor: Colors.red)',
    'StepStyle with all properties configured',
  ];
  List<Color> highlightColors = [
    Colors.grey,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.orange,
    Colors.red,
    Colors.indigo,
  ];

  List<Widget> comparisonRows = [];
  int f = 0;
  for (f = 0; f < featureNames.length; f = f + 1) {
    comparisonRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: highlightColors[f].withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: highlightColors[f].withAlpha(50)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: highlightColors[f],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${f + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    featureNames[f],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    configDescs[f],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontFamily: 'monospace',
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
            Icon(Icons.compare_arrows, color: Colors.indigo, size: 24),
            SizedBox(width: 8),
            Text(
              'StepStyle Configuration Reference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Quick reference for common StepStyle configurations.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: comparisonRows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('StepStyle deep demo executing');
  print('Class: StepStyle');
  print('Package: material');
  print('Description: Styling for individual Step in Stepper');

  return Scaffold(
    appBar: AppBar(
      title: Text('StepStyle Deep Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.indigo.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.style, color: Colors.white, size: 36),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StepStyle',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Customizable styling for individual Step widgets in Stepper',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildSectionHeader('Overview'),
          buildStepStyleOverview(),
          buildSectionHeader('Color'),
          buildColorSection(),
          buildSectionHeader('Gradient'),
          buildGradientSection(),
          buildSectionHeader('Error Color'),
          buildErrorColorSection(),
          buildSectionHeader('Connector Color'),
          buildConnectorColorSection(),
          buildSectionHeader('Connector Thickness'),
          buildConnectorThicknessSection(),
          buildSectionHeader('Index Style'),
          buildIndexStyleSection(),
          buildSectionHeader('Border Customization'),
          buildBorderSection(),
          buildSectionHeader('Stepper with StepStyle'),
          buildStepperWithStepStyle(),
          buildStepStyleComparison(),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'StepStyle deep demo complete - All sections rendered successfully',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
